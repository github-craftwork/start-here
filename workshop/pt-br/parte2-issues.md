
# Parte 2 Issues 

## Parte 2a: Madlibs com issues 
Trabalhar com issues pode ser trivial, adicione a action abaixo e o ISSUE_TEMPLATE ao seu projeto para alguma diversão com as issues.

**Commite madlib.yml no master**
Crie um arquivo `madlib.yml` na sua pasta `.github/workflows` com o seguinte conteúdo:


    # madlib.yml
    on: issues
    name: Create MadLibs in GitHub Issues
    jobs:
      madlib:
        runs-on: ubuntu-latest
        steps:
        - uses: actions/checkout@master
        - uses: bdougie/variables-in-markdown@v0.1.4
          env:
            GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

Agora abra uma issue utilizando o template MadLib para ver isto funcionando. (Se você tem familiaridade com MadLibs, sinta-se à vontade para alterar algumas variáveis).

Nota: dependendo dos seus recursos e WiFi, você pode precisar atualizar a página para ver a issue ser atualizada. 

Uma vez que você tiver criado uma MadLib com sucesso, dê uma olhada em na página da action [Variáveis em Markdown](https://github.com/marketplace/actions/variables-in-markdown) para aprender mais sobre essa automação.

[Continue para a Parte 3](parte3-ci.md)
