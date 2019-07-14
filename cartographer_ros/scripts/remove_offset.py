#!/usr/bin/python2
import rosbag, sys, os
import rospy
import pdb
import rosbag

num_msgs = 0

with rosbag.Bag('output.bag', 'w') as outbag:
    for topic, msg, t in rosbag.Bag(sys.argv[1]).read_messages():

        if 'cloud' in topic:
            #print 'Time:', t, ' topic:', topic, ' msg:', msg
            bagTime = t
            msg.header.stamp  = bagTime
            outbag.write(topic, msg, t)
        else:
            outbag.write(topic, msg, t)
        num_msgs += 1
