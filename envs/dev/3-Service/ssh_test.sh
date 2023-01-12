#!/bin/bash
set -eu
exec ssh -F /Users/ooooos/gem-dev-infra/envs/dev/3-Service/../../../appconfig/fadev/etc/ssh/config api2.fadev.gem-dev $@

