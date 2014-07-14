console.log('post init js.');

angular.module('WebApp', ['ui.router', 'WebApp.Controllers'])
.constant('CDN_ROOT', $cdn_root)
.config(['$stateProvider', '$urlRouterProvider', '$locationProvider', 'CDN_ROOT', function ($stateProvider, $urlRouterProvider, $locationProvider, CDN_ROOT) {
	$locationProvider.html5Mode(true);

	$urlRouterProvider.otherwise('/');

	$stateProvider.state('home', {
		url: '/',
		templateUrl: CDN_ROOT + '/views/home.html',
		controller: 'HomeCtrl'
	})
	.state('about', {
		url: '/about',
		templateUrl: CDN_ROOT + '/views/about.html'
	});

}]);

angular.module('WebApp.Controllers', [])
.controller('HomeCtrl', ['$scope', function ($scope) {

}]);