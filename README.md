<h1 align="center"> Go Advanced Starter </h1>

<p align="center"> <strong>Advanced Assistant for Initializing Go Projects</strong> </p>

[![MIT license](https://img.shields.io/badge/license-MIT-brightgreen.svg)](https://opensource.org/licenses/MIT)


<h2 align="center"> <strong>Sobre</strong> </h2>
Este script em bash tem como objetivo facilitar a criação de novos projetos em Go (Golang), oferecendo uma estrutura de diretórios inicial e a instalação de bibliotecas comumente utilizadas.

<h2 align="center"> <strong>Estruturas de Projeto</strong> </h2>

Existem duas estruturas principais de projeto suportadas:
```
service: Define o projeto como um serviço, seguindo a estrutura de microserviço.
library: Define o projeto como uma biblioteca.
```

<h2 align="center"> <strong>Bibliotecas Disponíveis</strong> </h2>

O script oferece a instalação de várias bibliotecas, categorizadas da seguinte forma:

```
# Logging

github.com/fonteeboa/go-log-guardian.
github.com/sirupsen/logrus.

# Banco de Dados Relacional

github.com/go-sql-driver/mysql.
gorm.io/driver/postgres.
github.com/jmoiron/sqlx.

# Banco de Dados Não Relacional

go.mongodb.org/mongo-driver/mongo.

# Frameworks Web

github.com/gin-gonic/gin.
github.com/labstack/echo.

# Biblioteca de Mapeamento Objeto-Relacional (ORM)

github.com/go-gorm/gorm.

# Biblioteca de Manipulação de Configurações

github.com/spf13/viper.

# Roteamento

github.com/spf13/cobra.
github.com/gorilla/mux.

# Autenticação e Segurança

github.com/dgrijalva/jwt-go.
github.com/appleboy/gin-jwt.

# Testes

github.com/stretchr/testify.
github.com/onsi/ginkgo.

# Bibliotecas de Autenticação de Múltiplos Fatores (MFA)

github.com/authy/authy-go
github.com/duosecurity/duo_api_golang
github.com/okta/okta-sdk-golang
github.com/dgryski/dgoogauth
github.com/Azure-Samples/active-directory-go-native-multitenant-v2
github.com/pquerna/otp/totp

# Outras Bibliotecas Úteis

github.com/go-redis/redis/v8.
github.com/hashicorp/golang-lru.
gonum.org/v1/gonum.
github.com/asaskevich/govalidator.
github.com/gorilla/websocket.
github.com/aws/aws-sdk-go.
google.golang.org/grpc.
```

<h2 align="center"> <strong>Uso</strong> </h2>

O script pode ser usado da seguinte maneira:

```
bash
./create_go.sh PROJECT_NAME [OPTIONS]
PROJECT_NAME: Nome do projeto a ser criado.
```

## Exemplo de Uso
```
./create_go.sh project_name --mysql --gin --echo
# Este comando criará um novo projeto chamado project_name como um serviço (microserviço) e instalará os pacotes github.com/gin-gonic/gin e github.com/go-sql-driver/mysql.
```

## Mensagem Helpers

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

<h2 align="center"> <strong>Observações</strong> </h2>

Lembre-se de adaptar o projeto criado para se adequar à sua realidade!

As bibiliotecas atuais foram escolhidas por serem as mais comuns em projetos que crio para estudos os quais em sua grande maioria não estão presentes no github.