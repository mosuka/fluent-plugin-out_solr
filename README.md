# Fluent::Plugin::SolrOutput

This is a [Fluentd](http://fluentd.org/) output plugin for send data to [Apache Solr](http://lucene.apache.org/solr/). It support [SolrCloud](https://cwiki.apache.org/confluence/display/solr/SolrCloud) not only Standalone Solr.

## Requirements

| fluent-plugin-output-solr | fluentd         | td-agent | ruby   |
| ------------------------- | --------------- | -------- | ------ |
| 1.x.x                     | >= 0.14.0, < 2  | 3        | >= 2.1 |
| 0.x.x                     | ~> 0.12.0       | 2        | >= 1.9 |

* The 1.x.x series is developed from this branch (master)
* The 0.x.x series (compatible with fluentd v0.12, and td-agent 2) is developed on the [v0.x.x branch](https://github.com/mosuka/fluent-plugin-output-solr/tree/v0.x.x)

## Installation

Install it yourself as:

```
$ gem install fluent-plugin-output-solr
```

## How to build

```
$ gem install bundler
$ bundle install
$ rake test
$ rake build
$ rake install
```

## Config parameters

### url

The Solr server url (for example http://localhost:8983/solr/collection1).

```
url http://localhost:8983/solr/collection1
```

### zk_host

The ZooKeeper connection string that SolrCloud refers to (for example localhost:2181/solr).

```
zk_host localhost:2181/solr
```

### collection

The SolrCloud collection name (default collection1).

```
collection collection1
```

### defined_fields

The defined fields in the Solr schema.xml. If omitted, it will get fields via Solr Schema API.

```
defined_fields ["id", "title"]
```

### ignore_undefined_fields

Ignore undefined fields in the Solr schema.xml.

```
ignore_undefined_fields false
```

### unique_key_field

A field name of unique key in the Solr schema.xml. If omitted, it will get unique key via Solr Schema API.

```
unique_key_field id
```

### timestamp_field

A field name of event timestamp in the Solr schema.xml (default event_timestamp).

```
timestamp_field event_timestamp
```

### flush_size

A number of events to queue up before writing to Solr (default 100).

```
flush_size 100
```

### commit_with_flush

Send commit command to Solr with flush (default true).

```
commit_with_flush true
```

## Plugin setup examples

### Sent to standalone Solr using data-driven schemaless mode.
```
<match something.logs>
  @type solr

  # The Solr server url (for example http://localhost:8983/solr/collection1).
  url http://localhost:8983/solr/collection1
</match>
```

### Sent to SolrCloud using data-driven schemaless mode.
```
<match something.logs>
  @type solr

  # The ZooKeeper connection string that SolrCloud refers to (for example localhost:2181/solr).
  zk_host localhost:2181/solr

  # The SolrCloud collection name (default collection1).
  collection collection1
</match>
```

## Solr setup examples

### How to setup Standalone Solr using data-driven schemaless mode.

1.Download and install Solr

```sh
$ mkdir $HOME/solr
$ cd $HOME/solr
$ wget https://archive.apache.org/dist/lucene/solr/5.4.0/solr-5.4.0.tgz
$ tar zxvf solr-5.4.0.tgz
$ cd solr-5.4.0
```

2.Start standalone Solr

```sh
$ ./bin/solr start -p 8983 -s server/solr
```

3.Create core

```sh
$ ./bin/solr create -c collection1 -d server/solr/configsets/data_driven_schema_configs -n collection1_configs
```

### How to setup SolrCloud using data-driven schemaless mode (shards=1 and replicationfactor=2).

1.Download and install ZooKeeper

```sh
$ mkdir $HOME/zookeeper
$ cd $HOME/zookeeper
$ wget https://archive.apache.org/dist/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz
$ tar zxvf zookeeper-3.4.6.tar.gz
$ cd zookeeper-3.4.6
$ cp -p ./conf/zoo_sample.cfg ./conf/zoo.cfg
```

2.Start standalone ZooKeeper

```sh
$ ./bin/zkServer.sh start
```

3.Download an install Solr

```sh
$ mkdir $HOME/solr
$ cd $HOME/solr
$ wget https://archive.apache.org/dist/lucene/solr/5.4.0/solr-5.4.0.tgz
$ tar zxvf solr-5.4.0.tgz
$ cd solr-5.4.0
$ ./server/scripts/cloud-scripts/zkcli.sh -zkhost localhost:2181 -cmd clear /solr
$ ./server/scripts/cloud-scripts/zkcli.sh -zkhost localhost:2181 -cmd makepath /solr
$ cp -pr server/solr server/solr1
$ cp -pr server/solr server/solr2
```

4.Start SolrCloud

```sh
$ ./bin/solr start -h localhost -p 8983 -z localhost:2181/solr -s server/solr1
$ ./bin/solr start -h localhost -p 8985 -z localhost:2181/solr -s server/solr2
```

5.Create collection

```sh
$ ./bin/solr create -c collection1 -d server/solr1/configsets/data_driven_schema_configs -n collection1_configs -shards 1 -replicationFactor 2
```

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake test` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mosuka/fluent-plugin-output-solr.
