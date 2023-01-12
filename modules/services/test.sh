#!/bin/bash

'if [ -d /var/lib/cloud ]; then until [ -f /var/lib/cloud/instance/boot-finished ] ; do echo "cloud-init接続中"; sleep 1; done; fi' || true
