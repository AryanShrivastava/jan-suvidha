// var Twitter = require("twitter-lite");
const Twitter = require("twitter");

const client = new Twitter({
  access_token_key: process.env.TWITTER_ACCESS_TOKEN,
  access_token_secret: process.env.TWITTER_ACCESS_TOKEN_SECRET,
  consumer_key: process.env.TWITTER_API_KEY,
  consumer_secret: process.env.TWITTER_API_SECRET_KEY,
  // bearer_token: process.env.TWITTER_BEARER_TOKEN,
});

const tweet = (text, image) => {
  // client
  //   .post("statuses/update", {
  //     status: text,
  //     media: url
  //   })
  //   .then((result) => {
  //     console.log('You successfully tweeted this : "' + result.text + '"');
  //   })
  //   .catch(console.error);

  client.post(
    "media/upload",
    { media: image },
    function (error, media, response) {
      if (error) {
        console.log(error);
      } else {
        const status = {
          status: text,
          media_ids: media.media_id_string,
        };

        client.post(
          "statuses/update",
          status,
          function (error, tweet, response) {
            if (error) {
              console.log(error);
            } else {
              console.log("Successfully tweeted an image!");
            }
          }
        );
      }
    }
  );
};

module.exports = { tweet };
