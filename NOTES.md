# Notes

Basic idea: gradual alarm clock app

* Wake you up with a series of alarms
* Progress to lighter and lighter sleep stages
* Haptic feedback as later stage (MS Band, Apple Watch)
* All-out alarm if you're going to be late (x minutes after alarm scheduled for?)
* Simple test to make sure you're actually awake, not just hitting snooze or whatever
    * Type a word?
    * Solve a math problem
    * Swipe a pattern

# Design

* Minimalistic - not a lot of options / buttons
* Super minimalist learning curve

# Alarm Notifications

* Schedule all the notifications at once
    * 5 or so different notifications to gradually wake person up (i.e. different sounds)
        * Staggered
    * Different repeat intervals for each one
    * Will gradually build on each other to be continuous by the end
* Typing in the code -> cancel all notifications

# TODO

* Completing alarm
* State persistence
    * One alarm at a time - NSUserDefaults
    * Make sure we don't schedule notifications again
* Configurable wakeup period
* Variable sounds
* Haptic feedback / Apple Watch notifications
* Alarm screen
    * Should also handle notifications while app open
