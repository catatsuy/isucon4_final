#!/bin/bash

set -x

SSH_USER=isucon

echo "deploy start by $USER" | ../../notify_slack.sh

for SSH_SERVER in isucon01.asia-east1-c.isucon5-1060 isucon02.asia-east1-c.isucon5-1060 isucon03.asia-east1-c.isucon5-1060
do
  rsync -avz ./ $SSH_USER@$SSH_SERVER:/home/isucon/isucon4_final/webapp/go/
  ssh -t $SSH_USER@$SSH_SERVER /bin/bash -c "/home/isucon/isucon4_final/webapp/go/build_wrapper.sh"
  ssh -t $SSH_USER@$SSH_SERVER pkill golang-webapp
done

echo "deploy finished $USER" | ../../notify_slack.sh
