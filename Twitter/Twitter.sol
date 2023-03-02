// SPDX-Licence-Verification : MIT
pragma solidity ^0.8.13;

contract Twitter {
    struct Tweet {
        uint256 id;
        address username;
        stirng TweetText;
        bool isDeleted;
    }

    Tweet[] private tweets;

    // mapping of tweet id to wallet address
    mapping(uint256 => address) tweetToOwner;

    event AddTweet(address recipient, uint256 tweetId);

    // add tweet
    function addTweet(string memory _tweetText, bool _isDeleted) external {
        uint256 tweetId = tweets.length;
        tweets.push(Tweet(tweetId, msg.sender, _tweetText, _isDeleted));
        tweetToOwner[tweetId] = msg.sender;
        emit AddTweet(msg.sender, tweetId);
    }

    // all tweets and return only those tweets who are not deleted
    function allTweets() external view returns (Tweet[] memory) {
        Tweet[] memory temporary = new Tweet[](tweets.length);

        uint256 counter = 0;

        for (uint256 i = 0; i < tweets.length; i++) {
            if (tweets[i].deleted == false) temporary[counter++] = tweets[i];
        }

        Tweet[] memory result = new Tweet[](counter);

        for (uint256 i = 0; i < counter; i++) {
            result[i] = temporary[i];
        }

        return result;
    }

    // tweet of a single user
    function getTweetsForOneUser() external view return(string[]memory){
     Tweet[] memory temporary = new Tweet[](tweets.length);

        uint256 counter = 0;

        for (uint256 i = 0; i < tweets.length; i++) {
            if ( tweetToOwner[i]==msg.sender &&  tweets[i].deleted == false) 
            temporary[counter++] = tweets[i];
        }

        Tweet[] memory result = new Tweet[](counter);

        for (uint256 i = 0; i < counter; i++) {
            result[i] = temporary[i];
        }

        return result;
    }

    event DeleteTweet(uint256 tweetId,bool isDeleted);
    // delete tweet tweeted by a user
    function deleteTweet(uint256 _tweetId,bool _isDeleted) external{
         if(tweetToOwner[_tweetId]==msg.sender){
            tweets[_tweetId].isDeleted=isDeleted;
            emit DeleteTweet(_tweetId,_isDeleted);
         }
    }
}
