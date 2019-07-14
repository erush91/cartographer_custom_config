#!/usr/bin/python2
import rosbag, sys, os
import rospy
import pdb

for topic, msg, t in rosbag.Bag(sys.argv[1]).read_messages():
   if 'imu' in topic:
       if 'cloud' in topic:
           #print 'Time:', t, ' topic:', topic, ' msg:', msg
           bagTime = t
           offset = bagTime - msg.header.stamp
           #pdb.set_trace()
           print 'BagTime:', bagTime.to_sec(), ' Offset:', offset.to_sec()
