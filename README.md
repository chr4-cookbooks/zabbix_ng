# zabbix_ng-cookbook

TODO: Enter the cookbook description here.

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['zabbix_ng']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### zabbix_ng::default

Include `zabbix_ng` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[zabbix_ng::default]"
  ]
}
```

## License and Authors

Author:: Chris Aumann (<me@chr4.org>)
