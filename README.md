# Smart Config

We have "smart" toothbrushes these days, so why not smart configuration?

**Note**: As you can see in the version number, this gem is still in a very early version, and you should expect that there may be breaking changes until we reach 1.0.

## Usage

Smart Config allows you to define a static configuration and access it from anywhere within your application.
It will try to read the configuration from a YAML file, and fallback on environment variables.

### Installation

Add the `smart_config` dependency to you Gemfile:

```
gem 'smart_config'
```

### Usage

Then, create a new config class that, and define the configuration you need:

```ruby
class Config
	extend SmartConfig::Config

	# Optional. Will default to `config/config.yml`
	config_path 'config/app_config.yml'

	value :app_name, default: 'My App'

	group :smtp do
		value :hostname
		value :port, format: :integer
		value :username
		value :password
	end

	group :redis do
		group :connection do
			value :hostname
			value :port
			value :username
			value :password
		end

		value :timeout
	end
end
```

Then, within your application, you can call:

```
Config.redis.connection.hostname
```

To access the configuration value, from the following YAML file for example:

```yaml
redis:
  connection:
    hostname: 'localhost'
```

For values that are not  in the YAML config, the tool will try reading it from environment variables, such as (from the previous configuration):

```
REDIS_CONNECTION_PASSWORD
```

#### Value Options

Values can use options, which can be set after the value name. For example:

```ruby
value :hostname, default: 'localhost'
```

All available options are:

| name      | description                                                                                                                                        |
|-----------|----------------------------------------------------------------------------------------------------------------------------------------------------|
| default   | Sets a default value for the field, if no configuration could be found. If this option is not set, getting an unset field will raise an exception. |
| format    | Sets the format of the field. If this option is not set, the field will be formatted as string.                                                    |
