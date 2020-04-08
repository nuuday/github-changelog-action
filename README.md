# Generate changelog with git-chglog

Github Action for creating a CHANGELOG.md file based on semver and conventional commits.

## Usage
### Pre-requisites
Create a workflow .yml file in your repositories .github/workflows directory. An example workflow is available below. For more information, reference the GitHub Help Documentation for Creating a workflow file.

Further more you need to have [git-chlog](https://github.com/git-chglog/git-chglog) configured and have the configuration added to your git repository.

### Inputs
 - `next_version`: Next version number
 - `config_dir`: git-chglog configuration directory. Default: `.ghglog`
 - `filename`: Filename to write the changelog to. Default: `CHANGELOG.md`

### Outputs
 - `changelog`: Changelog content if no `filename` input is empty

### Example workflow - upload a release asset
On every `push` to `master` generate a CHANGELOG.md file.

```yaml
name: Build and release
on: 
  push:
    branches:
      - master
  pull_request:
    branches:
      - master

jobs:
  package:
    runs-on: ubuntu-latest
    steps:
      - uses: nuuday/github-changelog-action@v1.0.0
        with:
          next_version: "1.0.0"      
```

## License
The scripts and documentation in this project are released under the [MIT License](LICENSE)

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/nuuday/github-changelog-action/tags). 

## Authors

* **Steffen F. Qvistgaard** - *Initial work* - [ssoerensen](https://github.com/ssoerensen)

See also the list of [contributors](https://github.com/nuuday/github-changelog-action/contributors) who participated in this project.