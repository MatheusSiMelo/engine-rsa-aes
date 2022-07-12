import criptografia.Configuracoes;
import criptografia.GerenciadorAES;
import criptografia.GerenciadorRSA;

import javax.crypto.SecretKey;
import java.security.PrivateKey;
import java.util.Base64;

public class App {

    public static void main(String[] args) {

        try {

            // Carregando Chave Privada
            GerenciadorRSA engineRSA = new GerenciadorRSA();
            PrivateKey privateKey = engineRSA.carregaChavePrivada(Configuracoes.PRIVATE_KEY_EMISSOR);

            // Decodificando Base64 da chave AES
            byte[] secretKeyTemp = Base64.getDecoder().decode(Configuracoes.SECRET_KEY_EMISSOR);

            // Descriptografando chave AES
            byte[] secretKeyByte = engineRSA.descriptografar(secretKeyTemp, privateKey);

            // Carrega chave AES
            GerenciadorAES engineEAS = new GerenciadorAES();
            SecretKey secretKey = engineEAS.carregaChaveAES(secretKeyByte);

//           // ------------------------CRIPTOGRAFANDO CONTEÚDO------------------------
//               byte[] objetoCriptografado = engineEAS.criptografar("CONTEÚDO QUE SERÁ CRIPTOGRAFADO".getBytes(), secretKey);
//               String bodyCriptografado = Base64.getEncoder().encodeToString(objetoCriptografado);
//               System.out.println(bodyCriptografado);

            // ------------------------DECRIPTOGRAFANDO CONTEÚDO------------------------
            byte[] dadosDecodeBase64 = Base64.getDecoder().decode(Configuracoes.MENSAGEM_CRIPTOGRAFADA);
            byte[] dadosDescriptografados = engineEAS.decriptografar(dadosDecodeBase64, secretKey);
            System.out.println("\n..:PRIVATE KEY:\n " + Configuracoes.PRIVATE_KEY_EMISSOR);
            System.out.println("\n..:SECRET KEY (AES):\n" + Configuracoes.SECRET_KEY_EMISSOR);
            System.out.println("\n..:MENSAGEM CRIPTOGRAFADA:\n" + Configuracoes.MENSAGEM_CRIPTOGRAFADA);
            System.out.println("\n..:RESPONSE DECRIPTOGRAFADO:\n" + new String(dadosDescriptografados, "UTF-8"));
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
