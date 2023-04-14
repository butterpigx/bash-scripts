# bash-scripts

Uses s3cmd to see the percent usage of buckets on an object storage (like df).

Note:
* Empty buckets will not be seen.
* Object storage size is hardcoded.


```
./calculate_percentage.sh

Bucket objects s3://bucket01: 2.8000% : 7G / 250G
Bucket objects s3://bucket02: 0% : 11K / 250G
Bucket objects s3://bucket03: .0100% : 35M / 250G
Bucket objects s3://bucket04: 0% : 5K / 250G
```
