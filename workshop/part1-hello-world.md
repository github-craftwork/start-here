
# Part 1: Hello World

Begin by creating a [new sandbox repository](https://github.com/organizations/github-craftwork/repositories/new) in the github-craftwork org, to keep everything nice and contained. 

![](https://paper-attachments.dropbox.com/s_CDDCC4EC3C7C8C14E8A73684CA9909721C965A1258B4380D90B28E1A4E030470_1570058137257_Screenshot+2019-10-02+16.12.56.png)


_Please add your name to the repo name, i.e. **bdougie-sandbox**_

Your initialized repository already has a triggered action. Click on the Actions tab to see what happened. 

![](https://paper-attachments.dropbox.com/s_CDDCC4EC3C7C8C14E8A73684CA9909721C965A1258B4380D90B28E1A4E030470_1568391143385_Screenshot+2019-09-13+09.12.12.png)


Within the Actions tab, you will have a successful workflow run for your new **hello-world action**. Go ahead and click your workflow to see your logs. 

_Note: These logs are powered by GitHub's [Checks API](https://developer.github.com/v3/checks/)_

![](https://paper-attachments.dropbox.com/s_CDDCC4EC3C7C8C14E8A73684CA9909721C965A1258B4380D90B28E1A4E030470_1570058201382_Screenshot+2019-10-02+16.16.33.png)


Within the logs, take note that your hello-world action outputs —”hello world.” 


![](https://paper-attachments.dropbox.com/s_CDDCC4EC3C7C8C14E8A73684CA9909721C965A1258B4380D90B28E1A4E030470_1568391516459_Screenshot+2019-09-13+09.18.30.png)


Congrats you have created your first Action, and all you had to do was show up and click a few buttons 😉.

This workflow was triggered from the the `hello.yml` file. 

The name of the workflow is important and will be used to identify your Action in the logs.


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

**About workflows** 
You can create a workflow file configured to run on specific events. For more information, see "[Configuring a workflow](https://help.github.com/en/articles/configuring-a-workflow)" and "[Workflow syntax for GitHub Actions](https://help.github.com/en/articles/workflow-syntax-for-github-actions)".

The basics you should know is there is an Action already made for you in the `.github/workflows` folder. Inside there you find that  `hello.yml` defines a Software Development Lifecycle (SDLC) workflow. 

Find out more about the core concepts of [GitHub Actions](https://help.github.com/en/articles/about-github-actions#core-concepts-for-github-actions).

One thing to take note of workflows are **jobs**.

A `job` is defined task made up of steps. Each job is run in a fresh instance of the virtual environment. You can define the dependency rules for how jobs run in a workflow file. Jobs can run at the same time in parallel or be dependent on the status of a previous job and run sequentially. For example, a workflow can have two sequential jobs that build and test code, where the test job is dependent on the status of the build job. If the build job fails, the test job will not run.

**runs-on**

GitHub hosts virtual machines with Linux, macOS, and Windows environments. Each job in a workflow executes in a fresh instance of the virtual environment. All steps in the job execute in the same instance of the virtual environment, allowing the actions in that job to share information using the filesystem.

You can specify the virtual environment for each job in a workflow. You can configure each job to run in different virtual environments or run all jobs in the same environment.

**Steps**

A step is a set of tasks performed by a job. Each step in a job executes in the same virtual environment, allowing the actions in that job to share information using the filesystem. Steps can run commands or actions.

## Part 1a: Environment Variable

Next let’s make our simple action a little more advanced by adding a name to the environments variables.


        - name: hello-world
          run: |
            echo "hello $NAME"
          env:
            NAME: Mary


Committing this change will also trigger the action and you should see the output of your variable just fine in the action logs as `hello Mary`. 

Now we will leverage existing environment variables to add your name name 
i.e. GITHUB_ACTOR.


        - name: hello-world
          run: |
            echo "hello $GITHUB_ACTOR"

Find out more about the [default environment variables](https://help.github.com/en/articles/virtual-environments-for-github-actions#default-environment-variables) available for you to leverage. 

You will find in the docs, in addition to the `GITHUB_ACTOR` secret variable, the `GITHUB_TOKEN` variables is available for us to perform Actions on our own repos.

[Continue on to Part 2](part2-issues.md)
