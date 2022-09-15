'use strict';

exports.handler = function (event, context, callback) {
    var response = {
        statusCode: 200,
        body: JSON.stringify(event['requestContext']['requestTime']),
    };

    callback(null, response);
};
