This section is TBD 

## Continuous Delivery with GitHub Actions

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
