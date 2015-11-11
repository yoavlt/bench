var express = require('express');
var router = express.Router();

var names = ['yoavlt', 'entotsu', 'morishitter'];

/* GET users listing. */
router.get('/html', function(req, res, next) {
  res.render('index', {names: names});
});

router.get('/json', function(req, res, next) {
  res.contentType('application/json');
  json = JSON.stringify({names: names});
  res.send(json);
});

module.exports = router;
