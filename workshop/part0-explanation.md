<details><summary>Explanation</summary>

Your account was auto added to the org by a few ways. Here is the explanation on how that happened.

The actions workflow, auto-approve.yml, is trigger on all pull requests. During this triggered worfklow 3 synchronous actions. They syncronous because of the [`steps`](https://help.github.com/en/articles/workflow-syntax-for-github-actions#jobsjob_idsteps) flag in the YAML, which we will cover. 

1. hmarr/auto-approve-action@v2.0.0 - An action that approves PRs automatically
2. bdougie/label-when-approved-action@master - An action the adds a specified label when approved (forked from puill-reminders/label-when-approved-action)
3. bdougie/automerge-action@master - An action that merges pull requests with the "automerge" label. (forked from pascalgn/automerge-action)

Click through the links to see the code, each one is approached differently, this is because actions are Virtual enviroments that run any specified and abritray code. 

</details>

Now that you have seen this in action, let's implement our first GitHub Action. Move on to [Part 1 of this workshop](part1-hello-world.md).
