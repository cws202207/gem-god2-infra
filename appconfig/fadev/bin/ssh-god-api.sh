#!/bin/bash
set -eu
exec ssh -F "/Users/ooooos/gem-god-infra/envs/dev/3-Service/../../../appconfig/fadev/etc/ssh/god-api/config" dev.god-api.fadev $@
