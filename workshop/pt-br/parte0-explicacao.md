<details><summary>Explicação</summary>

Sua conta foi adicionada automaticamente à org de algumas maneiras. Aqui vai uma explicação de como isto aconteceu.

O workflow das Actions, auto-approve.yml, é disparado em todos os pull requests. Durente este workflow, são disparadas 3 actions síncronas. Elas são síncronas devido à flag [`steps`](https://help.github.com/en/articles/workflow-syntax-for-github-actions#jobsjob_idsteps) no arquivo  YAML, que vamos cobrir posteriormente. 

1. hmarr/auto-approve-action@v2.0.0 - Uma action que aprova PRs automaticamente
2. bdougie/label-when-approved-action@master - Uma action que adiciona um label especificado quando aprovada. (fork de puill-reminders/label-when-approved-action)
3. bdougie/automerge-action@master - Uma action que faz o merge de pull requests com o label  "automerge". (forked from pascalgn/automerge-action)

Clique nos links para ver o código, cada um é trabalhado de uma maneira diferente, isto se deve porque as actions são ambientes virtuais que rodam qualquer código especificado e arbritário. 

</details>

Agora que você já viu na prática, vamos implementar nossa primeira Action. Avance para a [Parte 1 deste workshop](parte1-hello-world.md).
