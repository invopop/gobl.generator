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

Ensure all the GOBL JSON Schema files are available by manually copying the base GOBL project's `build/schemas` path to the `data/schemas` path in this repository. Schemas are _.gitignored_, and you must copy them every time you want to update the generated code:

```bash
rm -rf ./data/schemas
cp -r ../gobl/data/schemas ./data
```

Alternatively you can define the input path to directly use a schemas directory:

```bash
./bin/generate -i ../gobl/data/schemas
```

You can also output the resulting files to the directory of your choosing:

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
