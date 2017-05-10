var App = {};
App.Controllers = {};

App.Controllers.TodoController = function () {
    var self = this;

    self.todos = [];

    self.newTodo = "";

    self.addTodo = function() {
        self.todos.push({
            content: self.newTodo,
            done: false,
            editing: false
        });
        self.newTodo = "";
    };

    self.editTodo = function(todo) {
     
        angular.forEach(self.todos, function(value) {
            value.editing = false;
        });
        todo.editing = true;
    };

    self.finishEditing = function(todo) {
        todo.editing = false;
    };

    self.removeTodo = function(todo) {
        angular.Array.remove(self.todos, todo);
    };

    var countTodos = function(done) {
        return function() {
            return angular.Array.count(self.todos, function(x) {
                return x.done === (done === "done");
            });
        }
    };

    self.remainingTodos = countTodos("undone");

    self.finishedTodos = countTodos("done");

    self.clearCompletedItems = function() {
        var oldTodos = self.todos;
        self.todos = [];
        angular.forEach(oldTodos, function(todo) {
            if (!todo.done) self.todos.push(todo);
        });
    };

    self.hasFinishedTodos = function() {
        return self.finishedTodos() > 0;
    };

    self.hasTodos = function() {
        return self.todos.length > 0;
    };

   

    Rx.Observable
      .FromAngularScope(self, "newTodo")
      .SelectThenThrottledSelect(function(x){ return false; }, 500, function(x){ return x.length > 0; })
      .ToOutputProperty(self, "showHitEnterHint");

};
App.Controllers.TodoController.$inject = [];