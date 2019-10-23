
# Parte 3: Continuous Integration (CI) 

_Nota: The following section requires you to create a repository on your own account. You will need to ensure you have access to the [Actions](https://github.com/features/actions) and [Package Registry](https://github.com/features/package-registry) beta by navigating to the features page._

Next let’s start a new project in your personal repos (**not the github-craftwork org**) using the [github-craftwork/ci-template](https://github.com/github-craftwork/ci-template/generate). The contents of the project include JavaScript that finds out what the current week number it is today. 

![](https://paper-attachments.dropbox.com/s_CDDCC4EC3C7C8C14E8A73684CA9909721C965A1258B4380D90B28E1A4E030470_1569479640818_Screenshot+2019-09-25+23.33.52.png)


**Create a CI pull requests**
To develop a GitHub Workflow process that employs Actions to automate the Continuous 
Integration process, you can begin by adding starter workflow file to the `.github` directory. On the initial view of your repository, find and navigate to the **Actions** tab.


![](https://paper-attachments.dropbox.com/s_CDDCC4EC3C7C8C14E8A73684CA9909721C965A1258B4380D90B28E1A4E030470_1569479299414_Screenshot+2019-09-25+23.28.14.png)


On the Actions page you should see 2 JavaScript workflow options. Find the Node.js (the one that is not a Package) option and click the `Set up this workflow` button.

_Note: The [actions/starter-workflows](https://github.com/actions/starter-workflows) repository contains many sample workflow files._

The Actions Workflow wizard will install the sample workflow selected in your repo within the `.github` folder. You may edit the name of the file and its contents on the screen provided.

![Screenshot 2019-10-09 17 02 03](https://user-images.githubusercontent.com/5713670/66528996-3d6bbe80-eaf1-11e9-98ca-d9bd5b148de8.png)

Commit the `nodejs.yml` file to the master branch to complete this process of creating our first CI workflow. 

The `.github/workflows/` folder will include the contents from below:


    name: Node CI
    
    on: [push]
    
    jobs:
      build:
    
        runs-on: ubuntu-latest
    
        strategy:
          matrix:
            node-version: [8.x, 10.x, 12.x]
    
        steps:
        - uses: actions/checkout@v1
        - name: Use Node.js ${{ matrix.node-version }}
          uses: actions/setup-node@v1
          with:
            node-version: ${{ matrix.node-version }}
        - name: npm install, build, and test
          run: |
            npm install
            npm run build --if-present
            npm test
          env:
            CI: true

_Take note that our workflow is running a strategy with 3 versions of node, [8, 10, and 12]. This will be important to know later._ 

Because your new Actions CI is running on everything push, you should already have a workflow running. 

![](https://paper-attachments.dropbox.com/s_CDDCC4EC3C7C8C14E8A73684CA9909721C965A1258B4380D90B28E1A4E030470_1570060483830_Screenshot+2019-10-02+16.53.23.png)


Note that we  will need to a test to run as part of our CI, Find the `index.test.js` file with the contents from below:

```js
// index.test.js
const weekNum = require('./index.js');

test('that weekNum returns a value', () => {
  expect(weekNum).not.toBeNull();
});
```

The result of that last push to master should look like this image:

![](https://paper-attachments.dropbox.com/s_CDDCC4EC3C7C8C14E8A73684CA9909721C965A1258B4380D90B28E1A4E030470_1570060795895_Screenshot+2019-10-02+16.59.26.png)


Add another test
Let’s add another test to ensure we have 200% test coverage. 

```js
const weekNum = require('./index.js');

test('that weekNum returns a value', () => {
  expect(weekNum).not.toBeNull();
});

// new test added
test('that weekNum returns a number', () => {
  expect(weekNum).toBeDefined();
});
```

Add the above test using the UI, but instead of committing directly to the master branch, open a pull request to trigger you CI workflow again.. 

We have not created a pull request until now, so please take note that you can see all the workflows triggering through a GitHub [Check Suite](https://developer.github.com/v3/checks/). All Action Workflows are being powered by this API feature. And since we are on the subject the GitHub Actions bot is built on the [GitHub App](https://developer.github.com/apps/) framework that has already popularized by a number of our [Marketplace](https://github.com/marketplace) and Ecosystem partners.

![](https://paper-attachments.dropbox.com/s_CDDCC4EC3C7C8C14E8A73684CA9909721C965A1258B4380D90B28E1A4E030470_1569480356208_Screenshot+2019-09-25+23.45.04.png)


Once all test have passed, merge the pull request and let us move on to complete the next step. 

## Part 3a: Build 
The GitHub Actions workflow allows users to take advantage of a vast selection of open source tooling and solutions. Since the Actions workflow 'runners' are in themselves Virtual Machines (VMs) running on cloud servers. This is different from the GitHub App workflow, which requires you to host it on your own server. 

_Learn more on [the strengths of GitHub Actions and GitHub Apps](https://developer.github.com/marketplace/actions/comparing-actions-and-apps/) in the developer guides._

Our package.json has no build step, and our nodejs.yml is specifically looking for one, so let’s add that. 

**Add build script**
In the package.json add a new line to the script that runs **npx** and **parcel** in the VM. `npx parcel build index.js` is a script that will install parcel on the VM and bundle the index.js in one step.

```js
// package.json

"scripts": {
  "test": "jest", // add the comma
  "build":"npx parcel build index.js" // add this line
},
```

_Note: The scripts is a comma separated list, be sure add the comma to the previous script test script when adding the build script._

![](https://paper-attachments.dropbox.com/s_CDDCC4EC3C7C8C14E8A73684CA9909721C965A1258B4380D90B28E1A4E030470_1569481135392_Screenshot+2019-09-25+23.58.36.png)


You will now see that the build step completes and provides a bundle version of our Javascript.

![](https://paper-attachments.dropbox.com/s_CDDCC4EC3C7C8C14E8A73684CA9909721C965A1258B4380D90B28E1A4E030470_1569481282110_Screenshot+2019-09-26+00.00.59.png)


In situations where you would like a smaller file size package distribution this is important to do, but build is one thing — what else can we do? Move on to the next to step to learn what else you can at build time. 

## Part 3b: Add Lint script
Our project is missing something else, a linter. We can add this the same way we added the build script. In the package.json, add the `lint` key with the value as `npx standard`.

```js
// package.json

"scripts": {
  "test": "jest",
  "build":"npx parcel build index.js", // add the comma
  "lint": "npx standard --fix" // add this line
},
```

We will also need to add a step to our linter as a separate job in our `nodejs.yml`.

To do this we will use the [Node Code Formatter](https://github.com/marketplace/actions/node-code-formatter) Action.

![Screenshot 2019-10-09 16 48 12](https://user-images.githubusercontent.com/5713670/66528510-a7836400-eaef-11e9-98db-0a5c29780d8a.png)

**Add formatter workflow**
Add the following code to your existing `nodejs.yml` and open a pull request with this change.


    jobs:
      lint:
        name: Node Code Formatter
        runs-on: ubuntu-latest
        steps:
        - name: Node Code Formatter
          uses: MarvinJWendt/run-node-formatter@1.2.1
          env:
            GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

This update will check your code for lint issues and fix them for you. When the Action completes you will see a commit appear that looks similar to this:


![](https://paper-attachments.dropbox.com/s_CDDCC4EC3C7C8C14E8A73684CA9909721C965A1258B4380D90B28E1A4E030470_1569485959784_Screenshot+2019-09-26+00.49.03.png)


That completes this section, move on to the next section to learn how to automate your release workflow.

## Part 3d: Draft and Auto publish a release
CI is often coupled with the idea of Continuous Delivery (CD). The next two sections will cover automating your projects release management.

**Add release workflow**
You can use the [Release Drafter GitHub Action](https://github.com/marketplace/actions/release-drafter) in a [GitHub Actions Workflow](https://help.github.com/en/articles/about-github-actions) by configuring a YAML-based workflow file, e.g. `.github/workflows/release-management.yml`, with the following:


    name: Release Management
    
    on:
      push:
        # branches to consider in the event; optional, defaults to all
        branches:
          - master
    
    jobs:
      update_draft_release:
        runs-on: ubuntu-latest
        steps:
          # Drafts your next Release notes as Pull Requests are merged into "master"
          - uses: toolmantim/release-drafter@v5.2.0
            env:
              GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

Once you’ve added Release Drafter to your repository, it must be enabled by adding a `.github/release-drafter.yml` configuration file to each repository.

**Add release template**
Create the following `.github/release-drafter.yml`  file in a repository and commit to your master branch:

    template: |
      ## What’s Changed
    
      $CHANGES

**Make a change**
Navigate to your package.json file in the repo and replace the contents with your details. Be sure to create merge a PR for this change instead of write to master.

Change:  Swap out my name with your handle and commit that to master.

![](https://paper-attachments.dropbox.com/s_CDDCC4EC3C7C8C14E8A73684CA9909721C965A1258B4380D90B28E1A4E030470_1569515320558_Screenshot+2019-09-26+09.27.43.png)


As pull requests are merged, a draft release is kept up-to-date listing the changes, ready to publish when you’re ready:

![Screenshot of generated draft release](https://github.com/toolmantim/release-drafter/raw/master/design/screenshot.png)


To test this workflow, edit your draft using the existing tag created for it. Once completed, move on to the next step in the project to complete this step.

![](https://paper-attachments.dropbox.com/s_CDDCC4EC3C7C8C14E8A73684CA9909721C965A1258B4380D90B28E1A4E030470_1569513609522_Screenshot+2019-09-26+08.59.53.png)


## Part 3e: Publish to NPM 

We have been using npm for some basic script commands thus far, `npm`, short for Node Package Manager, is two things: first and foremost, it is an online repository for the publishing of open-source Node.js projects; second, it is a command-line utility for interacting with said repository that aids in package installation, version management, and dependency management. A plethora of node.js libraries and applications are published on npm, and many more are added every day. These applications can be searched for on [search.npmjs.org/.](http://search.npmjs.org/). 

Now let’s put our work on npm to share. 

Return to the Actions tab and select the “New workflow” button.

![](https://paper-attachments.dropbox.com/s_CDDCC4EC3C7C8C14E8A73684CA9909721C965A1258B4380D90B28E1A4E030470_1569514191075_Screenshot+2019-09-26+09.09.20.png)


**Add package workflow**
First [create an npm account](https://www.npmjs.com/) if you do not. 

Navigate back to the **Actions** tab and find the “New Workflow” button to expose the wizard. Select the Node.js Package and set up that workflow. 


![](https://paper-attachments.dropbox.com/s_CDDCC4EC3C7C8C14E8A73684CA9909721C965A1258B4380D90B28E1A4E030470_1569486194937_Screenshot+2019-09-25+23.28.14.png)


The file will require a changes. We only want to publish packages after they have been merged to master. 

_The default setup runs this workflow on all open pull requests. This is not needed and will need to be removed. This workflow should only run on pushes to master._


    name: Node.js Package
    
    on:
      push:
        branches:
          - master
    

Scrolling through the `npmpublish.yml` you will see 3 jobs:


1. build - running tests
2. publish-npm 
3. publish-gpr

**Publish to npm**
The first two you are familiar based on the content we went through so far. The `publish-npm`  requires a `secrets.npm_token` which I which you will need to share [generate on npm.com](https://docs.npmjs.com/creating-and-viewing-authentication-tokens).

**Add npm_token secrets**
You can provide you secret by navigating to your repository’s settings. There you will see a Secrets menu item.

**Add your npm token** 

![](https://paper-attachments.dropbox.com/s_CDDCC4EC3C7C8C14E8A73684CA9909721C965A1258B4380D90B28E1A4E030470_1569514818101_Screenshot+2019-09-26+09.20.09.png)


**Publish to public** 
npm requires a payment on file to publish private packages. You will need to add add a public flag to the publish script. 


      publish-npm:
        ... 
         - run: npm publish --access public // add this public access flag

**Publish to GitHub Package Registry**
_Note: [The Package Registry feature is in public beta._

The next job is `publish-gpr`. 

You will need to replace the “@your-github-username” with your username.


![](https://paper-attachments.dropbox.com/s_CDDCC4EC3C7C8C14E8A73684CA9909721C965A1258B4380D90B28E1A4E030470_1569515177144_Screenshot+2019-09-26+09.25.09.png)


GitHub Package Registry is a software package hosting service, similar to npmjs.org, rubygems.org, or hub.docker.com, that allows you to host your packages and code in one place. You can host software packages privately or publicly and use them as dependencies in your projects.

**Create a PR for this workflow**
Commit this workflow to a new branch and open the pull request.

Before you merge these changes to master, head over to the package.json and replace the git URL to match the repo you are working out of and replace the GitHub handles to yours.   

To start the  `npmpublish` workflow, merge the PR.

![Screenshot 2019-10-09 16 54 25](https://user-images.githubusercontent.com/5713670/66528746-8e2ee780-eaf0-11e9-9c68-149cbc1e7ddd.png)

[Continue Part 4](part4-bonus.md)
