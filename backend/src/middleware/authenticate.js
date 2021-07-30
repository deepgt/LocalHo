const jwt = require('jsonwebtoken');
require('dotenv/config');
const helper = require('../helper/util.js');
const { errorResponse } = helper;

// check and authenticate request token
const validateToken = (req, res, next) => {
  const token = req.headers.authorization;

  if (!token) {
    return errorResponse(res, 401, 'AUT_01', 'Authorization code is empty', 'USER_KEY');
  }
  if (token.split(' ')[0] !== 'Bearer') {
    return errorResponse(res, 401, 'AUT_02', 'The userkey is invalid', 'USER_KEY');
  }
  const accessToken = token.split(' ')[2];
  jwt.verify(accessToken, process.env.SECRET, (err, decoded) => {
    if (err) {
      return errorResponse(res, 401, 'AUT_02', 'The userkey is invalid', 'USER_KEY');
    }
    req.user = decoded;
    next();
  });
};
module.exports = validateToken;