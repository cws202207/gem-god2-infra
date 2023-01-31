#!/bin/bash
set -eu
exec ssh -F "/Users/rd-main01/gem-god-infra/envs/dev/3-Service/../../../appconfig/fadev/etc/ssh/god-api/config" dev.god-api.fadev $@
