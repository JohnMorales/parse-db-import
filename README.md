# parse-db-import

This solution is if you need to move away from Parse and build your own backend. This tool allows you to quickly import data exported from Parse into a database supported by active record. Currently it expects the records to be pre-flattened by [parse-migrator](https://github.com/JohnMorales/parse-migrator)

See also

  - [parse-migrator](https://github.com/JohnMorales/parse-migrator)
  - [rack-scaffold](https://github.com/mattt/rack-scaffold)

## Installation

```sh
    $ gem install parse-db-import
```


## Usage

It's assumed that the database will exist so create the database if that's not the case 

`createdb sampledb`

then 

```sh
   $  bundle exec parse-db-import --path [path] --dbname [database]
```

### Other options

```ruby
 --adapter [postgresql]  #(mysql, mysql2, postgresql or sqlite3 defaults to postgresql)
 --dbuser [user]  #(optional, will use current account)
 --dbpassword [password] #(optional, will use current account)
 --host [host]  #(optional, will use 'localhost')
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/parse-db-import/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
