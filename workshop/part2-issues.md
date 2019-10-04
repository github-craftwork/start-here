
# Part 2 Issues 

## Part 2a: Madlibs with issues 
Working with issues can be mundane, add the below action and ISSUE_TEMPLATE to your project for some fun with issues.

**Commit to madlib.yml to master**
Create a `madlib.yml`  in your `.github/workflo``ws` folder with the content below:


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

Now open up an issue leveraging the existing MadLib issue template template and watch it work. (If you are familiar with MadLibs, feel free to change out some of the variables.

Note:  depending on how your resources and WiFi, you made need to refresh the page to see the issue get updated. 

Once you have completed creating a successful MadLib, take a look at the [Variables in Markdown](https://github.com/marketplace/actions/variables-in-markdown) action page to learn more about this particular automation.
