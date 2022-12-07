# Alma WEB

Este projeto foi criado com o intuito alavancar a aprendizagem de leitura e escrita para pessoas que possuem algum tipo de deficiencia ou não aprendeu.

## Getting Started

OBS: Certifique-se que o Flutter esteja instalado em sua máquina e que seu ambiente esteje devidamente configurado.

Execute ``` flutter doctor ``` em seu terminal e veja se está tudo ok.

---

##### Clone

No terminal de sua máquina execute o comando git:

```git clone <urlrepo>```

Isto fará com que o projeto seja baixado em sua máquina.

##### Instalação de depêndencias

Após fazer o clone do projeto na sua máquina, é necessário instalar todas as dependencias do mesmo, quando estiver na pasta do mesmo via terminal execute o comando:

```flutter pub get```

Isto fará com que todas as dependências que estão sendo utilizadas no projeto sejam instaladas.

##### Run

Após executar a instalação de todas as dependências vamos rodar o projeto, quando estiver na pasta do mesmo via terminal execute o comando:

``` flutter run -d chrome --web-port=3000 --web-renderer html ``` ou ``` flutter run --release --web-renderer html ```

Ambos vão executar o projeto, o primeiro comando roda o projeto em versão de desenvolvimento, observa-se que passamos as flags ``` -d chrome --web-port=3000 ``` onde o projeto estará executando na porta 3000, e também as flags ``` --web-renderer html ```
responsáveis por utilizar recursos do navegador. O segundo comando é passado a flag ``` --release ``` é como se estivessemos rodando o projeto em versão de produção.

#### Build

Para realizar o build do projeto basta executar na pasta do mesmo via terminal:

``` flutter build web --web-renderer html ```

Este projeto pode ser executado em qualquer dispositivo/plataforma, porém, projetado específicamente para a Web.

## Warning

``` Flutter 3.3.9 * channel stable ```
``` Tools * Dart 2.18.5 ```

**IDE:** VSCode(The Best)

