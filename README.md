# Gerar par de chaves usando OPENSSL
> Utilize o GIT-BASH que já contém o OPENSSL configurado.

----

## 1. Gerar CHAVE PRIVADA RSA
```shell
openssl genrsa -out chave_privada_rsa.pem 2048
```
> xxxxxx
    
## 2. Gera a CHAVE PÚBLICA RSA a partir da chave privada rsa gerada
```shell
openssl rsa -pubout -in chave_privada_rsa.pem -out chave_publica_rsa.key
```
> xxxxxxx
  
## 3. Gerar CHAVE BEGIN PRIVATE KEY
```shell
openssl pkcs8 -topk8 -inform PEM -in chave_privada_rsa.pem -out chave_begin_private_key.pem -nocrypt
```
> Atualizar a String PRIVATE_KEY_EMISSOR da classe Configuracoes.Java
