# GOBL Generator

Use Ruby to generate versions of the GOBL schema in other languages.

## Usage

Download the local repository and ensure you've installed the bundle:

```
git clone git@github.com:invopop/gobl.generator.git
cd ./gobl.generator
bundle install
```

Run the generate command with the `-h` to ensure everything is working and see the command options:

```
./bin/generate -h
```

By default, the generate command will use the `data/schema` directory as a source for data, and output Ruby source code into the `build/ruby` path.

If for example you want to build the Markdown output from a gobl repo directly and send to the output to the documentation project, run:

```bash
./bin/generate -l markdown -i ../gobl/build/schemas -o ../gobl.docs/draft-0
```