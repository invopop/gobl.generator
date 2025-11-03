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

You must provide the input schema files and the output directory of your choosing:

```bash
./bin/generate -i ../gobl/data/schemas -o ../gobl.ruby/lib/generated/gobl
```

Files from a previous export that are not longer needed will *not be deleted automatically*. If the destination mixes generated with handwritten code, use the following find and grep command *before* generating to remove all generated code:

```bash
find ../gobl.ruby/lib -name "*.rb" -exec grep -l "Generated with GOBL" {} \; | xargs rm
```

This generator also supports Markdown output:

```bash
rm -rf ../gobl.docs/draft-0
./bin/generate -l markdown -i ../gobl/data/schemas -o ../gobl.docs/draft-0
```
