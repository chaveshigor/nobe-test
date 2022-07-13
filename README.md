# Nobe Test

### Esse projeto tem como finalidade simular transações bancarias de forma online, tendo como funcionalidades as seguintes transações:

- Depósito para qualquer conta
- Saque
- Transferência entre contas

### Outras funcionalidades são:

- Congelamento da conta
- Verificação e filtragem de extrato por data
- Download de extrato no formato csv

## Regras de negócio:

- Para realizar qualquer transação, o usuário precisa estar autenticado
- Depósito:
  - É possível depositar em qualquer conta ativa
- Saque:
  - É possível realizar saques apenas da própria conta
  - É possível realizar saques apenas caso o valor do saque, somado a taxa da transação não seja superior ao valor em conta
  - Não é possível realizar saques em contas desativadas
- Transferência:
  - É possível realizar trasnferências para qualquer conta ativa
  - Contas desativadas não podem realizar transferências
  - É possível realizar transferências apenas caso o valor transferido, somado a taxa da transação não seja superior ao valor em conta


## Instruções para rodar o projeto

### Dependências:
- Ruby
- Ruby on Rails
- Yarn
- Docker
- Docker Compose

### Executar:
- Clonar o projeto
- Executar o comando `yarn install`
- Executar o comando `bundle install`
- Executar o comando `docker-compose build`
- Executar o comando `docker-compose up`