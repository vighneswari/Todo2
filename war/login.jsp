<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<title>oauth</title>
<style type="text/css">
.image{
  width: 20%;
  height: 10%;
  border-radius: 10%;
  background-position: center center;
  background-size: cover;
}
</style>

</head>
<body>
			 		<body background="https://thumbs.dreamstime.com/z/to-do-list-white-paper-pencils-background-template-56711188.jpg">
			 
			<script src="js/jquery.js"></script>
				<table>
				<td>
				<div class = "container" align="center">
				<div class="pic">
				<img src= "${picture}"  class="image" >
				</div>
				<div class="title">
				<div class="name">
				<h2>${username}</h2>
				</div>
				<div class="title">
				<h2>${email}</h2>
				</div>
				</div>
				<center>
				
				<a href="/yourTodo" data-toggle="modal" class="btn btn-info"  data-dismiss = "modal" width="40%">Task Editor</a>
<!--  				 <li><a href="/yourTodo"> Your To-do List</a></li>
 --> 				
 				</center>
				</div>
				</td>
				</table>
</body>
</html>