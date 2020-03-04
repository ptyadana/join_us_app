var express = require('express');
var bodyParser = require('body-parser');
var mysql = require('mysql');
var app = express();

app.set("view engine", "ejs");
app.use(bodyParser.urlencoded({extended:true}));
app.use(express.static(__dirname + "/public"));

var connection = mysql.createConnection({
	host : 'localhost',
	user : 'root',
	database: 'join_us'
});

app.get("/",function(req,res){
	var q = "SELECT COUNT(*) AS count FROM users"; 
	
	connection.query(q, function(err,results){
		if (err) throw err;
		var count = results[0].count;
		res.render("home",{data:count});
	});
});

app.post("/register",function(req,res){
	var person = {
		email:req.body.email_address
	};
	
	connection.query('INSERT INTO users SET ?', person, function (error, results, fields) {
  		if (error) throw error;
		res.redirect("/");
	});
});

app.get("/joke",function(req,res){
	var joke = 'What do you call a dog that does magic tricks? A labracadabrador.';
	res.send(joke);
});

app.get("/random_number",function(req,res){
	var num = Math.floor(Math.random()*10)+1;
	res.send("Your lucky number is " + num);
});

app.listen(3000, function(){
	console.log("server is running on 3000.");
});