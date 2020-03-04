var faker = require('faker');
var mysql = require('mysql');

var connection = mysql.createConnection({
	host : 'localhost',
	user : 'root',
	database: 'join_us'
	//,password: ''
});

/*
var q = 'SELECT COUNT(*) AS total_users FROM users';

connection.query(q, function (error, results, fields) {
   if (error) throw error;
   console.log(results[0].total_users);
});
*/


/*
var q = 'INSERT INTO users(email) VALUES("vivian@noemail.com")';

connection.query(q, function (error, results, fields) {
   if (error) throw error;
   console.log(results);
});
*/


/*
var person = {email:email:faker.internet.email(),
				created_at:faker.date.past()
				};

var query = connection.query('INSERT INTO posts SET ?', person, function (error, results, fields) {
  if (error) throw error;
});
console.log(query.sql); 
*/

var person_list = [];

for(var i = 1; i<=500; i++){
	person_list.push([
		faker.internet.email(),
		faker.date.past()
	]);
}

var q = "INSERT INTO users (email,created_at) VALUES ?"

var query = connection.query(q, [person_list], function (error, results, fields) {
   if (error) throw error;
});

connection.end();