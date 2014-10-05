# fluent-plugin-addinfo



## Usage

expample setting

```ruby:td-agent.conf
<match nginx.access>
  type addinfo
  yaml /path_to/addinfo.yaml
  field info_field
  pattern [^ ]* ([^ ]*) .*
  addkey info_field_add
</match>
```

```ruby:/path_to/addinfo.yaml
aaa: 111
bbb: 222
ccc: 333
```

and use this plugin

```
{"info_field" : "GET aaa hogehoge"} to {"info_field" : "GET aaa hogehoge", "info_field_add":"111"}
{"info_field" : "GET bbb hogehoge"} to {"info_field" : "GET bbb hogehoge", "info_field_add":"222"}
{"info_field" : "GET ddd hogehoge"} to {"info_field" : "GET ddd hogehoge"}
```


this plugin rewirte tag to `#{tag}.addinfo`
so example `nginx.access.addinfo`


## Installation

`gem install fluent-plugin-addinfo` or `fluent-gem install fluent-plugin-addinfo`
