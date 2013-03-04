#!/bin/bash

TS=`date "+%m-%d-%Y_%H:%M"`

cd ../ocv.build

mkdir ios/archive &> /dev/null
rm -rf ios/archive/opencv2.framework
rm -rf ios/archive/build

mv ios/opencv2.framework ios/archive/ &> /dev/null
mv ios/build ios/archive/ &> /dev/null

python ../ocv/opencv/ios/build_framework.py ios > build_framework_${TS}.log

cd ../ocv.ios_samples

