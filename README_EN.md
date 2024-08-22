<h1 align="center"> Go Advanced Starter </h1>

<p align="center"> <strong>Advanced Assistant for Initializing Go Projects</strong> </p>

[![MIT license](https://img.shields.io/badge/license-MIT-brightgreen.svg)](https://opensource.org/licenses/MIT)

Para a versão em português deste README, clique [aqui](README.md).

<h2 align="center"> <strong>About</strong> </h2>
This bash script is designed to facilitate the creation of new Go (Golang) projects by offering an initial directory structure and installing commonly used libraries.

<h2 align="center"> <strong>Project Structures</strong> </h2>
There are two main project structures supported:

```
service: Defines the project as a service, following a microservice structure.
library: Defines the project as a library.
```

<h2 align="center"> <strong>Available Libraries</strong> </h2>

The script offers the installation of several libraries, categorized as follows:

```
🔹 Logging

github.com/fonteeboa/go-log-guardian.
github.com/sirupsen/logrus.

🔹 Relational Database

github.com/go-sql-driver/mysql.
gorm.io/driver/postgres.
github.com/jmoiron/sqlx.
github.com/lib/pq.

🔹 NoSQL Database

go.mongodb.org/mongo-driver/mongo.

🔹 Web Frameworks

github.com/gin-gonic/gin.
github.com/labstack/echo.

🔹 Object-Relational Mapping (ORM) Library

github.com/go-gorm/gorm.

🔹 Configuration Management Library

github.com/joho/godotenv.
github.com/spf13/viper.

🔹 Routing

github.com/spf13/cobra.
github.com/gorilla/mux.

🔹 Authentication and Security

github.com/dgrijalva/jwt-go.
github.com/appleboy/gin-jwt.

🔹 Testing

github.com/stretchr/testify.
github.com/onsi/ginkgo.

🔹 Multi-Factor Authentication (MFA) Libraries

github.com/authy/authy-go
github.com/duosecurity/duo_api_golang
github.com/okta/okta-sdk-golang
github.com/dgryski/dgoogauth
github.com/Azure-Samples/active-directory-go-native-multitenant-v2
github.com/pquerna/otp/totp

🔹 Other Useful Libraries

github.com/go-redis/redis/v8.
github.com/hashicorp/golang-lru.
gonum.org/v1/gonum.
github.com/asaskevich/govalidator.
github.com/gorilla/websocket.
github.com/aws/aws-sdk-go.
google.golang.org/grpc.
```

<h2 align="center"> <strong>Usage</strong> </h2>

The script can be used as follows:

```
bash
./create_go.sh PROJECT_NAME [OPTIONS]
PROJECT_NAME: Name of the project to be created.
```

## Example Usage

```
./create_go.sh project_name --mysql --gin --echo
🔹 This command will create a new project called project_name as a service (microservice) and install the packages github.com/gin-gonic/gin and github.com/go-sql-driver/mysql.
```

## Helper Messages

```
$ ./create_go.sh --help
Usage: ./create_go.sh PROJECT_NAME [OPTIONS]
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

        Multi-Factor Authentication (MFA) Libraries:
            --mfa-authy Installs the Authy library (Twilio's MFA solution)
            --mfa-duo Installs the Duo Security library (MFA provider)
            --mfa-okta Installs the Okta library (Identity and Access Management with MFA support)
            --mfa-google Installs the Google Authenticator library (Google's MFA solution)
            --mfa-azure Installs the Azure Multi-Factor Authentication library (Microsoft's MFA solution)
            --mfa-otp Installs the TOTP library (Time-based One-Time Password)

        Other Useful:
            --goredis Installs the package github.com/go-redis/redis/v8
            --golang-lru Installs the package github.com/hashicorp/golang-lru
            --gonum Installs the package gonum.org/v1/gonum
            --govalidator Installs the package github.com/asaskevich/govalidator
            --gorillaw Installs the package github.com/gorilla/websocket
            --aws Installs the package github.com/aws/aws-sdk-go
            --grpc Installs the package google.golang.org/grpc

Example usage:
  ./create_go.sh project_name --mysql --gin --echo
  This will create a new project 'project_name' as a service (microservice) and install the packages 'github.com/gin-gonic/gin' and 'github.com/go-sql-driver/mysql'.
```

<h2 align="center"> <strong>Notes</strong> </h2>

🔹 Remember to adapt the created project to fit your specific needs!

🔹 The current libraries were chosen because they are the most commonly used in projects I create for study purposes, most of which are not published on GitHub.