# protolint-action

protolint-action - action for run protolint with plugins

Supported plugins:
* [protostyle](https://github.com/ci-space/protostyle)

## Usage example

Add new job in your workflow:

```yaml
jobs:
  protolint:
    name: protolint
    runs-on: ubuntu-latest
    steps:
      - name: Check out code
        uses: actions/checkout@v3

      - name: Run linter
        uses: ci-space/protolint-action@master
```
