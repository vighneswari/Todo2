
angular.service('myAngularApp', function($route, $location, $window) {

  $route.when('/main', {template: 'main.jsp', controller: App.Controllers.TodoController});
  $route.otherwise({redirectTo: '/main'});

  var self = this;

  self.$on('$afterRouteChange', function(){
    $window.scrollTo(0,0);
  });

}, {$inject:['$route', '$location', '$window'], $eager: true});
