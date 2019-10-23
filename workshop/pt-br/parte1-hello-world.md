
# Parte 1: Hello World

Comece pela criação de um [ novo respositório sandbox](https://github.com/organizations/github-craftwork/repositories/new) na org github-craftwork, para manter tudo organizado. 

![](https://paper-attachments.dropbox.com/s_CDDCC4EC3C7C8C14E8A73684CA9909721C965A1258B4380D90B28E1A4E030470_1570058137257_Screenshot+2019-10-02+16.12.56.png)


_Por favor, adicione o seu nome no repositório, ex.: **bdougie-sandbox**_

O seu repositório inicializado já tem uma action disparada. Clique na aba Actions para ver o que acontece. 

![](https://paper-attachments.dropbox.com/s_CDDCC4EC3C7C8C14E8A73684CA9909721C965A1258B4380D90B28E1A4E030470_1568391143385_Screenshot+2019-09-13+09.12.12.png)


Na aba Actions, você vai ter uma execução de workflow para a sua nova **hello-world action**. Vá em frente e clique no seu workflow para ver os logs. 

_Nota: Estes logs são produzidos pela [Checks API](https://developer.github.com/v3/checks/) do GitHub_

![](https://paper-attachments.dropbox.com/s_CDDCC4EC3C7C8C14E8A73684CA9909721C965A1258B4380D90B28E1A4E030470_1570058201382_Screenshot+2019-10-02+16.16.33.png)


Nos logs, perceba que a sua action hello-world imprime -"hello world."


![](https://paper-attachments.dropbox.com/s_CDDCC4EC3C7C8C14E8A73684CA9909721C965A1258B4380D90B28E1A4E030470_1568391516459_Screenshot+2019-09-13+09.18.30.png)


Parabéns! Você criou a sua primeira Action, e tudo o que você teve que fazer foi aparecer e clicar em alguns botões 😉.

Este workflow foi iniciado a partir do arquivo `hello.yml`. 

O nome do workflow é importante e será usado para identificar sua Action nos logs.


    # .github/workflows/hello.yml
    on: push # runs when ever there is a push to any branch of the repo
    name: A workflow for my Hello World Action
    jobs:
      build:
        name: Hello world action
        runs-on: ubuntu-latest # useful environment so we can run a simple bash    
        steps:
        - name: hello-world
          run: |
            echo "hello"

**Sobre workflows** 
Você pode criar um arquivo de workflow configurado para rodar em eventos específicos. Para mais informações, veja "[Configurando um workflow](https://help.github.com/en/articles/configuring-a-workflow)" e "[Sintaxe de Workflow para GitHub Actions](https://help.github.com/en/articles/workflow-syntax-for-github-actions)".

O básico que você precisa saber é que existe uma Action já pronta para você na pasta `.github/workflows`. Dentro dela você você verá que o arquivo `hello.yml` define um workflow de um Ciclo de Vida de Desenvolvimento de Softwarea Software Development Lifecycle (CVDS ou SDLC em inglês). 

Veja mais sobre os principais conceitos das [GitHub Actions](https://help.github.com/en/articles/about-github-actions#core-concepts-for-github-actions).

Uma coisa para prestar atenção sobre workflows são os **jobs**.

Um `job` é uma tarefa composta por etapas ("steps"). Cada job é rodado em uma instância do ambiente virtual criada do zero. Você pode definir as regras de dependências para como jobs são executados em um arquivo de workflow. Jobs podem rodar em paralelo ou serem dependentes do status de um job anterior e rodar em sequência. Por exemplo, um workflow pode ter dois jobs sequenciais que dão build e testam código, onde o job de teste é dependente do status do job de build. Se o build falhar, o job de teste não irá rodar.

**runs-on**

O GitHub hospeda máquinas virtuais com ambientes Linux, macOS, e Windows. Cada job em um workflow executa em uma instância nova do ambiente virtual. Todos os passos no job executam na mesma instância do ambiente virtual, permitindo às actions naquele job compartilhar informação utilizando o filesystem.

Você pode especificar o ambiente vitual para cada job em um workflow. Você pode configurar cada job em diferentes ambientes virtuais ou rodar todos os jobs no mesmo ambiente.

**Steps**

Um step (passo) é um conjunto de atividades executadas por um job. Cada step em um job é executado no mesmo ambiente virtual, permitindo às actions naquele job compartilhar informação utilizando o filesystem. Steps podem rodar comandos ou actions.

## Parte 1a: Variáveis de ambiente

Em seguida, vamos fazer nossa pequena action um pouco mais avançada adicionando um nome às variáveis de ambiente.

        - name: hello-world
          run: |
            echo "hello $NAME"
          env:
            NAME: Mary


Comittar essa mudança irá também disparar a action e você deverá ver o output da sua variável nos logs da action como `hello Mary`. 

Agora nos vamos utilizar variáveis de ambiente já existentes para adicionar o seu nome. ex.: GITHUB_ACTOR.


        - name: hello-world
          run: |
            echo "hello $GITHUB_ACTOR"

Veja mais sobre as [variáveis de ambiente padrão](https://help.github.com/en/articles/virtual-environments-for-github-actions#default-environment-variables) disponíveis para seu uso. 

Você irá encontrar na documentação, além da variável `GITHUB_ACTOR`, a variável de acesso (secret) `GITHUB_TOKEN` para que nós possamos realizar ações em nossos próprios repositórios. variables is available for us to perform Actions on our own repos.

[Continue na Parte 2](parte2-issues.md)
