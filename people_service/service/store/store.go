package store

import (
	"context"
	"database/sql"
	"fmt"
	"os"
	"strconv"

	"github.com/golang-migrate/migrate/v4"
	"github.com/golang-migrate/migrate/v4/database/postgres"
	_ "github.com/golang-migrate/migrate/v4/source/file"
	"github.com/jackc/pgx/v4"
	_ "github.com/lib/pq"
)

type Store struct {
	conn *pgx.Conn
}

type People struct {
	ID   int
	Name string
}

func NewStore(connString string) *Store {
	conn, err := pgx.Connect(context.Background(), connString)
	if err != nil {
		panic(err)
	}

	//migrations
	db, err := sql.Open("postgres", connString)
	if err != nil {
		panic(err)
	}
	defer db.Close()

	driver, err := postgres.WithInstance(db, &postgres.Config{})
	if err != nil {
		panic(err)
	}

	m, err := migrate.NewWithDatabaseInstance("file:../../migrations/", "postgres", driver)
	if err != nil {
		panic(err)
	}

	m.Up()

	return &Store{
		conn: conn,
	}
}

func (s *Store) ListPeople() ([]People, error) {

	people := make([]People, 5)

	rows, err := s.conn.Query(context.Background(), `
	SELECT ID, Name
	FROM people
	`)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Query failed: %v \n", err)
		return nil, nil
	}
	defer rows.Close()

	for rows.Next() {
		var id string
		var name string

		if err := rows.Scan(&id, &name); err != nil {
			fmt.Fprintf(os.Stderr, "Rows scan failed: %v \n", err)
			return nil, nil
		}
		n, err := strconv.Atoi(id)
		if err != nil {
			return people, fmt.Errorf("error: %w", err)
		}

		people = append(people, People{
			ID:   n,
			Name: name,
		})
	}

	if rows.Err() != nil {
		return people, fmt.Errorf("error: %w", err)
	}

	return people, nil
}

func (s *Store) GetPeopleByID(id string) (People, error) {
	var i string
	var n string

	err := s.conn.QueryRow(context.Background(), `
	SELECT ID, Name
	FROM people
	WHERE ID = ?`, id).Scan(&i, &n)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Query failed: %v \n", err)
		return People{}, nil
	}

	nt, err := strconv.Atoi(i)
	if err != nil {
		fmt.Fprintf(os.Stderr, "not an integer: %v \n", err)
		return People{}, nil
	}

	var result = People{
		ID:   nt,
		Name: n,
	}

	return result, nil
}
