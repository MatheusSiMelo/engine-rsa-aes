REM by: bruno.rojo@dock.tech
@ECHO OFF
@CLS
@CLEAR

REM Utilize sempre o git-bash!
REM Permitir execução do script: chmod 770 gerar-chaves.bat
REM Executar script: ./gerar-chaves.bat

REM CONFIGURACAO DOS NOMES DOS ARQUIVOS DAS CHAVES QUE SERAO GERADAS
REM SE PREFERIR, ALTERE O EMISSORNAME
SET CHAVE_RSA_PRIVATE_KEY=emissorname-chave_rsa_private_key.pem
SET CHAVE_PRIVATE_KEY=emissorname-chave_private_key.pem
SET CHAVE_PUBLIC_KEY=emissorname-chave_public_key.key

ECHO  Use o GIT-BASH que já contém o OPENSSL configurado.

ECHO.
ECHO.
ECHO ######################################################
ECHO ############## [1ª Gerar CHAVE: RSA PRIVATE KEY]
openssl genrsa -out %CHAVE_RSA_PRIVATE_KEY% 2048
ECHO  [%CHAVE_RSA_PRIVATE_KEY%]


ECHO.
ECHO.
ECHO ######################################################
ECHO ############## [2ª Gerar CHAVE: PUBLIC KEY]
openssl rsa -pubout -in %CHAVE_RSA_PRIVATE_KEY% -out %CHAVE_PUBLIC_KEY%
ECHO  [%CHAVE_PUBLIC_KEY%]
ECHO DICA: Para cadastrar a chave public key no emissor, utilize o endpoint de Cadastro de Chave
ECHO [BASE DE DADOS CONSULTA]
ECHO ATENCAO: Para levantar o idToken, execute a query:
ECHO USE PIER_HMLG_V2;
ECHO SELECT * FROM TOKENS WHERE TOKEN LIKE '%fortbrasil%'
ECHO [REQUEST]
ECHO     CURL DE EXEMPLO:
ECHO         curl --location --request POST 'http://10.75.128.38:8181/v2/api/criptografia/chaves'
ECHO         header 'access_token: sqa84qui' header 'Content-Type: application/json'
ECHO         data-raw '{
ECHO                 "idToken": 1087,
ECHO                 "chavePublicaEmissor": "-----BEGIN PUBLIC KEY----- XXXXXXXXX...-----END PUBLIC KEY-----",
ECHO                 "dataValidadeChavePublicaEmissor": "2028-12-30T00:00:00.000Z"
ECHO    }'
ECHO.
ECHO.
ECHO ######################################################
ECHO ############## [3ª Gerar CHAVE PRIVATE KEY]
openssl pkcs8 -topk8 -inform PEM -in %CHAVE_RSA_PRIVATE_KEY% -out %CHAVE_PRIVATE_KEY% -nocrypt
ECHO  [%CHAVE_PRIVATE_KEY%]
ECHO DICA: Retire os espaços da chave e atualize a String PRIVATE_KEY_EMISSOR da classe Configuracoes.Java com o conteúdo desta chave)


ECHO CASO ENCONTRE PROBLEMAS, USE O REQUEST PARA LIMPAR CACHE DE CHAVES CRIPTOGRADAS
ECHO curl --location --request DELETE 'http://10.75.128.38:8181/v2/api/criptografia/chaves/caches' \
ECHO     --header 'Access_Token: sqa14fortbrasil35'
exit 0