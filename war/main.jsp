
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<title>oauth</title>
<style type="text/css">
.image {
	width: 20%;
	height: 10%;
	border-radius: 10%;
	background-position: center center;
	background-size: cover;
}

.exit-btn {
	border: none;
	font-family: inherit;
	font-size: inherit;
	color: inherit;
	background: none;
	cursor: pointer;
	padding: 25px 80px;
	display: inline-block;
	margin: 15px 30px;
	text-transform: uppercase;
	letter-spacing: 1px;
	font-weight: 700;
	outline: none;
	position: relative;
	-webkit-transition: all 0.3s;
	-moz-transition: all 0.3s;
	transition: all 0.3s;
}
</style>
</head>
<body>
	<div id="todoapp">
		<div class="title">
			<h1>Task Editor</h1>
		</div>
		<div class="content">
			<div id="todo-form"></div>
			<form id="todo-form" ng:submit="addTodo()">
				<input id="new-todo" name="newTodo" placeholder="Current Task" type="text" autocomplete="off">
			</form>
			<div id="todos">
				<ul id="todo-list">
					<li class="todo"
						ng:class="'editing-' + todo.editing + ' done-' + todo.done"
						ng:repeat="todo in todos">
						<div class="display">
							<input class="check" type="checkbox" name="todo.done"/ >
							<div ng:click="editTodo(todo)" class="todo-content">{{
								todo.content }}</div>
							<span class="todo-destroy" ng:click="removeTodo(todo)"></span>
						</div>
						<div class="edit">
							<form ng:submit="finishEditing(todo)">
								<input class="todo-input" my:focus="todo.editing"
									my:blur="finishEditing(todo)" name="todo.content" type="text">
							</form>
						</div>
					</li>
				</ul>
			</div>
			<div id="todo-stats">
				<span class="todo-count" ng:show="hasTodos()"> <span
					class="number">{{ remainingTodos() }}</span> <span class="word">items</span>
					left.
				</span> <span class="todo-clear" ng:show="hasFinishedTodos()"> <a
					ng:click="clearCompletedItems()"> Clear <span
						class="number-done">{{ finishedTodos() }}</span> completed <span
						class="word-done">item</span>
				</a>
				</span>
			</div>
		</div>
		<center>
			<div>
				<button class="exit-btn">
					<a href="/logout">logout</a>
					
				</button>
			</div>
		</center>
	</div>
</body>
</html>