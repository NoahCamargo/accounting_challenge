# AccountingChallenge

## Usage

```bash
docker-compose up --build
```

## Tests

```bash
docker-compose run --rm web rspec
```

## Endpoints

A API foi desenvolvida assumindo que os valores de entrada sempre serão em centavos de real (inteiro).
- `POST /accounts` Funcionalidade #1 - Criar Conta. Exemplo de entrada:
```json
{
	"id": 6,
	"name": "Nome",
	"opening_balance": 5000
}
```
- `POST /accounts/bank-transaction` Funcionalidade #2 - Transferir dinheiro. Exemplo de entrada:
```json
{
	"source_account_id": 1,
	"destination_account_id": 2,
	"amount": 1000
}
```
- `GET /accounts/check-balance` Funcionalidade #3 - Consultar saldo. Exemplo de entrada:
```json
{
	"account_id": 6
}
```

Para *bater* os endpoints (exceto */accounts*) é necessário informar o *token* gerado através do */accounts*. O mesmo esta no padrão JWT e deve ser informado com a chave do header *Authorization* e no valor, usar o sufixo `JWT <token>`. Exemplo:

```bash
Authorization: JWT eyJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50X2lkIjo5fQ.Uc7Pg8T1jElRSgIoS2rjd134WjUB_eVLbO_RcIdubiA
```

## Gems
- rspec-rails - Utilizado para realização dos testes.
- database_cleaner-active_record - Útil para limpar o banco no momento que cada teste ira rodar.
- faker - Gera dados falsos de diversos tipos, neste caso, esta sendo utilizado nos testes.
- jwt - Destinada a geração, codificação e decodificação de chaves no padrão JWT.
- rack-cors - Muito útil para evitar problemas de CORS.
