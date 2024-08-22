#!/bin/bash

# Function to display help
show_help() {
    cat <<EOF
Usage: $0 PROJECT_NAME [OPTIONS]
Creates a new Go project with folder structure and some pre-installed libraries.

OPTIONS:

    --help              Displays this help text

    STRUCTURES:
        --service           Defines the project as a service (microservice structure)
        --library           Defines the project as a library (library structure)

    LIBRARIES:
        Logging:
            --logg Installs the package github.com/fonteeboa/go-log-guardian
            --logrus Installs the package github.com/sirupsen/logrus

        Relational Database:
            --mysql Installs the package github.com/go-sql-driver/mysql
            --postgres Installs the package gorm.io/driver/postgres
            --sqlx Installs the package github.com/jmoiron/sqlx
            --neon Installs the package github.com/lib/pq
        
        No Relational Database:
            --mongodriver Installs the package go.mongodb.org/mongo-driver/mongo
        
        Web Framework:
            --gin Installs the package github.com/gin-gonic/gin
            --echo Installs the package github.com/labstack/echo

        Object-Relational Mapping (ORM) Library:
            --gorm Installs the package github.com/go-gorm/gorm

        Configuration Handling Library:
            --viper Installs the package github.com/spf13/viper

        Routing:
            --cobra Installs the package github.com/spf13/cobra
            --mux Installs the package github.com/gorilla/mux

        Authentication and Security:
            --jwtgo Installs the package github.com/dgrijalva/jwt-go
            --ginjwt Installs the package github.com/appleboy/gin-jwt

        Testing:
            --testify Installs the package github.com/stretchr/testify
            --ginkgo Installs the package github.com/onsi/ginkgo

        Multi-Factor Authentication (MFA):
            --mfa-authy Installs the Authy package (Twilio's MFA solution)
            --mfa-duo Installs the Duo Security package (MFA provider)
            --mfa-okta Installs the Okta package (Identity and Access Management with MFA support)
            --mfa-google Installs the Google Authenticator package (Google's MFA solution)
            --mfa-azure Installs the Azure Multi-Factor Authentication package (Microsoft's MFA solution)
            --mfa-otp Installs the TOTP package (Time-based One-Time Password)

        Other Useful:
            --goredis Installs the package github.com/go-redis/redis/v8
            --golang-lru Installs the package github.com/hashicorp/golang-lru
            --gonum Installs the package gonum.org/v1/gonum
            --govalidator Installs the package github.com/asaskevich/govalidator
            --gorillaw Installs the package github.com/gorilla/websocket
            --aws Installs the package github.com/aws/aws-sdk-go
            --grpc Installs the package google.golang.org/grpc

Example usage:
  $0 project_name --mysql --gin --echo
  This will create a new project 'project_name' as a service (microservice) and install the packages 'github.com/gin-gonic/gin' and 'github.com/go-sql-driver/mysql'.
EOF
}

# Function to create project directories
create_project_directories() {
    local project_type="$1"

    if [ "$project_type" = "service" ]; then
        echo "Creating service project..."
        mkdir -p cmd
        mkdir -p internal/helpers
        mkdir -p internal/infra/database
        mkdir -p internal/infra/http/routes
        mkdir -p internal/infra/providers
        mkdir -p internal/modules/module1/{controller,domain,repositories,services,tests/mock}
    else
        echo "Creating library project..."
        mkdir -p internal/service
        mkdir -p pkg
    fi

    touch README.md
}

# Function to create optimized main.go
create_main_go() {
    local libraries=("$@")
    local db_imports=""
    local db_setup=""
    local db_connection_test=""
    local db_connection_select_test=""
    local load_env='
    // Carrega variáveis de ambiente do arquivo .env
    err := godotenv.Load()
    if err != nil {
        log.Fatalf("Erro ao carregar o arquivo .env: %v", err)
    }
    ';
    local load_end_usage=""

    for lib in "${libraries[@]}"; do
        case $lib in
            "--mysql")
                load_end_usage=$load_env;
                db_imports+='
    "github.com/joho/godotenv"
    _ "github.com/go-sql-driver/mysql"'
                db_setup='
    dsn := os.Getenv("MYSQL_USER") + ":" + os.Getenv("MYSQL_PASSWORD") + "@tcp(" + os.Getenv("MYSQL_HOST") + ":" + os.Getenv("MYSQL_PORT") + ")/" + os.Getenv("MYSQL_DBNAME")'
                db_connection_test='
    db, err := sql.Open("mysql", dsn)
    if err != nil {
        log.Fatalf("Could not connect to MySQL: %v", err)
    }'
                ;;
            "--postgres")
                load_end_usage=$load_env;
                db_imports+='
    "github.com/joho/godotenv"
    _ "github.com/lib/pq"'
                db_setup='
    dsn := "postgres://" + os.Getenv("POSTGRES_USER") + ":" + os.Getenv("POSTGRES_PASSWORD") + "@" + os.Getenv("POSTGRES_HOST") + ":" + os.Getenv("POSTGRES_EXTERNAL_PORT") + "/" + os.Getenv("POSTGRES_DB") + "?sslmode=" + os.Getenv("NEON_SSLMODE")'
                db_connection_test='
    db, err := sql.Open("postgres", dsn)
    if err != nil {
        log.Fatalf("Could not connect to PostgreSQL/Neon: %v", err)
    }'
                ;;
            "--mongodriver")
                load_end_usage=$load_env;
                db_imports+='
    "github.com/joho/godotenv"
    "go.mongodb.org/mongo-driver/mongo"
    "go.mongodb.org/mongo-driver/mongo/options"
    "context"
    "time"'
                db_setup='
    ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
    defer cancel()
    client, err := mongo.NewClient(options.Client().ApplyURI(os.Getenv("MONGODB_URI")))
    if err != nil {
        log.Fatalf("Could not create MongoDB client: %v", err)
    }
    err = client.Connect(ctx)
    if err != nil {
        log.Fatalf("Could not connect to MongoDB: %v", err)
    }'
                db_connection_test='
    err = client.Ping(ctx, nil)
    if err != nil {
        log.Fatalf("Could not ping MongoDB: %v", err)
    }'
                ;;

                "--neon")
                load_end_usage=$load_env;
                db_imports+='
    "github.com/joho/godotenv"
    _ "github.com/lib/pq"
    "database/sql"
    '
                db_setup='

    user := os.Getenv("NEON_USER")
    password := os.Getenv("NEON_PASSWORD")
    host := os.Getenv("NEON_HOST")
    dbname := os.Getenv("NEON_DBNAME")
    sslmode := os.Getenv("NEON_SSLMODE")

    if user == "" || password == "" || host == "" || dbname == "" || sslmode == "" {
        log.Fatal("One or more environment variables are not set")
    }

    dsn := fmt.Sprintf("postgresql://%s:%s@%s/%s?sslmode=%s",
        user,
        password,
        host,
        dbname,
        sslmode,
    )
'
                db_connection_test='
    db, err := sql.Open("postgres", dsn)
    if err != nil {
        log.Fatalf("Could not connect to Neon database: %v", err)
    }'
                db_connection_select_test='
                    var version string
    if err := db.QueryRow("select version()").Scan(&version); err != nil {
        panic(err)
    }

    fmt.Printf("version=%s\n", version)
    '
                ;;
        esac
    done

    cat <<EOF > main.go
package main

import (
    "fmt"
    "log"
    "os"$db_imports
)

func main() {
$load_end_usage$db_setup$db_connection_test

    defer db.Close()

    err = db.Ping()
    if err != nil {
        log.Fatalf("Could not ping the database: %v", err)
    }

$db_connection_select_test

    fmt.Println("Connected to the database successfully!")
}
EOF

    # Default to "Hello, World!" if no database libraries were selected
    if [ -z "$db_imports" ]; then
        cat <<EOF > main.go
package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}
EOF
    fi
}


# Install selected libraries
install_libraries() {
    local libraries=("$@")

    for lib in "${libraries[@]}"; do
        case $lib in
            "--mysql")
                go get -u github.com/go-sql-driver/mysql
                go get github.com/joho/godotenv
                echo "MYSQL_HOST=" >> .env
                echo "MYSQL_PORT=" >> .env
                echo "MYSQL_USER=" >> .env
                echo "MYSQL_PASSWORD=" >> .env
                echo "MYSQL_DBNAME=" >> .env         
                ;;
            "--postgres")
                go get -u gorm.io/driver/postgres
                go get github.com/joho/godotenv
                echo "POSTGRES_HOST=" >> .env
                echo "POSTGRES_EXTERNAL_PORT=" >> .env
                echo "POSTGRES_USER=" >> .env
                echo "POSTGRES_PASSWORD=" >> .env
                echo "POSTGRES_DB=" >> .env
                ;;
            "--logg")
                go get -u github.com/fonteeboa/go-log-guardian
                echo "LOG_GUARDIAN_DATABASE_TYPE=" >> .env
                ;;
            "--gin")
                go get -u github.com/gin-gonic/gin
                ;;
            "--echo")
                go get -u github.com/labstack/echo
                ;;
            "--gorm")
                go get -u github.com/go-gorm/gorm
                ;;
            "--viper")
                go get -u github.com/spf13/viper
                ;;
            "--cobra")
                go get -u github.com/spf13/cobra
                ;;
            "--mux")
                go get -u github.com/gorilla/mux
                ;;
            "--logrus")
                go get -u github.com/sirupsen/logrus
                ;;
            "--sqlx")
                go get -u github.com/jmoiron/sqlx
                ;;
            "--jwtgo")
                go get -u github.com/dgrijalva/jwt-go
                ;;
            "--goredis")
                go get -u github.com/go-redis/redis/v8
                ;;
            "--testify")
                go get -u github.com/stretchr/testify
                ;;
            "--ginjwt")
                go get -u github.com/appleboy/gin-jwt
                ;;
            "--ginkgo")
                go get -u github.com/onsi/ginkgo
                ;;
            "--golang-lru")
                go get -u github.com/hashicorp/golang-lru
                ;;
            "--gonum")
                go get -u gonum.org/v1/gonum
                ;;
            "--govalidator")
                go get -u github.com/asaskevich/govalidator
                ;;
            "--gorillaw")
                go get -u github.com/gorilla/websocket
                ;;
            "--mongodriver")
                go get -u go.mongodb.org/mongo-driver/mongo
                go get github.com/joho/godotenv
                echo "MONGODB_URI=" >> .env
                echo "MONGODB_DBNAME=" >> .env
                ;;
            "--aws")
                go get -u github.com/aws/aws-sdk-go
                ;;
            "--grpc")
                go get -u google.golang.org/grpc
                ;;
            "--grpc")
                go get -u google.golang.org/grpc
                touch .env
                ;;
            "--mfa-authy")
                go get -u github.com/authy/authy-go
                ;;
            "--mfa-duo")
                go get -u github.com/duosecurity/duo_api_golang
                ;;
            "--mfa-okta")
                go get -u github.com/okta/okta-sdk-golang
                ;;
            "--mfa-google")
                go get -u github.com/dgryski/dgoogauth
                ;;
            "--mfa-azure")
                go get -u github.com/Azure-Samples/active-directory-go-native-multitenant-v2
                ;;
            "--mfa-otp")
                go get -u github.com/pquerna/otp/totp
                ;;
            "--neon")
                go get github.com/joho/godotenv
                go get github.com/lib/pq
                echo "NEON_USER=" >> .env
                echo "NEON_PASSWORD=" >> .env
                echo "NEON_DBNAME=" >> .env
                echo "NEON_HOST=" >> .env
                echo "NEON_SSLMODE=" >> .env
                ;;
            "help")
                show_help
                exit 0
                ;;
            *)
                echo "Invalid library option: $lib"
                exit 1
                ;;
        esac
    done
}

# Variable initialization
project_name=""
project_type="library"
selected_libraries=()

# Parse arguments
while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        --service)
            project_type="service"
            shift
            ;;
        --library)
            project_type="library"
            shift
            ;;
        --logg|--mysql|--gin|--echo|--gorm|--viper|--cobra|--mux|--logrus|--sqlx|--jwtgo|--goredis|--testify|--ginjwt|--ginkgo|--golang-lru|--gonum|--govalidator|--gorillaw|--mongodriver|--aws|--grpc|--postgres--mfa-authy|--mfa-duo|--mfa-okta|--mfa-google|--mfa-azure|--mfa-otp|--neon)
            selected_libraries+=("$1")
            shift
            ;;
        --help)
            show_help
            exit 0
            ;;
        *)
            if [ -z "$project_name" ]; then
                project_name="$1"
                shift
            fi
        ;;
    esac
done

# Check for a provided project name
if [ -z "$project_name" ]; then
    echo "A project name is required."
    show_help
    exit 1
fi

mkdir -p "projects" && cd projects || exit

# Create project directory
mkdir -p "$project_name"
cd "$project_name" || exit

# Initialize a new Go module
go mod init "$project_name"

# Create project structure
create_project_directories "$project_type"

# Install selected libraries
install_libraries "${selected_libraries[@]}"

# Create main.go
create_main_go "${selected_libraries[@]}"

# Display success message
cat <<EOF
Project "$project_name" created successfully!
Remember to adapt the created project to fit your reality!
EOF
