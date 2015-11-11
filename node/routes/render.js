var express = require('express');
var router = express.Router();

var names = ['yoavlt', 'entotsu', 'morishitter'];

/* GET users listing. */
router.get('/html', function(req, res, next) {
  res.render('index', {names: names});
});

module.exports = router;
