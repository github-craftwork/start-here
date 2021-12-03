# Part 5:  Continuous Delivery with GitHub Actions

_If you would like to jump into the guide repo, start by forking the [template](https://github.com/github-craftwork/docs-template)._

GitHub Actions gets a lot of continuous integration, but what about continuous delivery?
In this guide, I will share the building blocks for managing the continuous delivery of your project. With this foundation, you can have continuous integration, staging reviews, and production deployments in the same YAML.

## Using the visualization graph

Every workflow run generates a real-time graph that illustrates the run progress. You can use this graph to monitor and debug workflows.
The graph displays each job in the workflow. An icon to the left of the job name indicates the status of the job. Lines between jobs indicate dependencies.

![Workflow Visulaizer](https://res.cloudinary.com/practicaldev/image/fetch/s--_8HdrNE7--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/uploads/articles/zldsi0fs96mkhn638cs3.png)

## Dependent jobs

By default, the jobs in your workflow all run in parallel at the same time. So if you have a job that must only run after another job has been completed, you can use the needs keyword to create this dependency. If one of the jobs fails, all dependent jobs are skipped; however, if you need the jobs to continue, you can define this using the if conditional statement.
In this example, the setup, build, and test jobs run in series, with build and test being dependent on the successful completion of the job that precedes them:

    jobs:
      setup:
        runs-on: ubuntu-latest
        steps:
          - run: ./setup_server.sh
      build:
        needs: setup
        runs-on: ubuntu-latest
        steps:
          - run: ./build_server.sh
      test:
        needs: build
        runs-on: ubuntu-latest
        steps:
          - run: ./test_server.sh
    
## Environments

You can configure environments with protection rules and secrets. When a workflow job references an environment, the job won't start until all of the environment's protection rules pass. A job also cannot access secrets that are defined in an environment until all the environment protection rules pass.
Learn more about environments.

## Build and Deploy

Use deployment branches to restrict which branches can deploy to the environment. Below are the options for deployment branches for an environment:

- All branches: All branches in the repository can deploy to the environment.
- Protected branches: Only branches with branch protection rules enabled can deploy to the environment. If no branch protection rules are defined for any branch in the repository, then all branches can deploy. For more information about branch protection rules, see "About protected branches."
- Selected branches: Only branches that match your specified name patterns can deploy to the environment.

You can have certain events run for specific branches. You adjust the YAML to include branch names to only run CI checks on branches you needed them. Below is an example with placeholder text for the environment and commands. Please leverage this to get you started, but be sure to replace the text with your build and deploy steps.

_example workflow_

```yml
// cd.yml
// This is an example workflow. Add to your ci-template repo.

# This is a basic workflow to help you get started with Actions

name: Short CD

# Controls when the action will run. 
on:
  # Allows you to run this workflow manually from the Actions tab. Also watches push and pull request events
  [workflow_dispatch, pull_request, push]

# A workflow run is made up of one or more jobs that can run sequentially or in parallel
jobs:
  build:
    runs-on: ubuntu-latest
    steps:

      - uses: actions/checkout@v2

      - name: Run a one-line script
        run: echo Hello, world!

      - name: Run a multi-line script
        run: |
          echo Add other actions to build,
          echo test, and deploy your project.
  deploy-staging:
    needs: [build]
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    environment: 
      name: staging
      url: http://staging.int.bdougie.live

    steps:

      - uses: actions/checkout@v2


      - name: Run a one-line script
        run: echo Hello, world!

      - name: Run a multi-line script
        run: |
          echo Add other actions to build,
          echo test, and deploy your project.
          
  test-site:
    needs: [deploy-staging]
    runs-on: ubuntu-latest
    name: Test on ${{ matrix.browser }}
    strategy:
      matrix:
        browser: ['edge', 'chrome', 'mozilla']
    steps:
      - name: Run a one-line script
        run: echo Hello, world!

      - name: Run a multi-line script
        run: |
          echo Add other actions to build,
          echo test, and deploy your project.
 
  deploy-storybook:
    needs: [test-site]
    if: github.ref == 'refs/heads/main'

    runs-on: ubuntu-latest
    environment: 
      name: production
      url: http://www.design.bdougie.live

    steps:

      - uses: actions/checkout@v2

      - name: Run a one-line script
        run: echo Hello, world!

      - name: Run a multi-line script
        run: |
          echo Add other actions to build,
          echo test, and deploy your project.
    
  deploy-production:
    needs: [test-site]
    if: github.ref == 'refs/heads/main'
 
    runs-on: ubuntu-latest
    environment: 
      name: production
      url: http://www.bdougie.live

    steps:

      - uses: actions/checkout@v2

      - name: Run a one-line script
        run: echo Hello, world!

      - name: Run a multi-line script
        run: |
          echo Add other actions to build,
          echo test, and deploy your project.
    
  deploy-review:
    needs: [build]
    if: github.event_name == 'pull_request'
 
    runs-on: ubuntu-latest
    environment: 
      name: review
      url: http://review.bdougie.live

    steps:

      - uses: actions/checkout@v2

      - name: Run a one-line script
        run: echo Hello, world!

      - name: Run a multi-line script
        run: |
          echo Add other actions to build,
          echo test, and deploy your project.
```
