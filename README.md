## Twitter [(raw)](https://gist.githubusercontent.com/timothy1ee/b9b1860c8ecb4b0b1c18/raw/2adc3f63677d81644e00245cee891eee88907767/gistfile1.md)

This is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: 35 hours 

### Features

#### Required

- [x] User can sign in using OAuth login flow
- [x] User can view last 20 tweets from their home timeline
- [x] The current signed in user will be persisted across restarts
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.  In other words, design the custom cell with the proper Auto Layout settings.  You will also need to augment the model classes.
- [x] User can pull to refresh
- [x] User can compose a new tweet by tapping on a compose button.
- [x] User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
- [x] User can retweet, favorite, and reply to the tweet directly from the timeline feed.

#### Optional

- [x] When composing, you should have a countdown in the upper right for the tweet limit.
- [ ] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [x] Retweeting and favoriting should increment the retweet and favorite count.
- [x] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [x] Replies should be prefixed with the username and the reply_id should be set when posting the tweet,
- [x] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.

### Walkthrough

### Notes
- Please use "git clone --recursive" to checkout repository.  SwiftyJSON was added as a submodule to this git repository.
- App does not start up in simulator when debugger is not connected.  It works on hardware. Not sure if this is an Xcode issure or a MYcode issue. 

### Walkthrough

###![Video Walkthrough](151004_Twitter_Walkthrough.gif)

Credits
---------
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)
* [LiceCap](http://www.cockos.com/licecap/)
* [BDBOAuth1Manager](https://github.com/bdbergeron/BDBOAuth1Manager)

License
--------
This project is licensed under the terms of the MIT license.


