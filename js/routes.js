// Configuración de las rutas de la aplicación.

app.config(function($routeProvider) 
{
    $routeProvider
        .when('/', 
        {
            templateUrl : 'views/listadoproductos.html',
            controller  : 'listadoProductosCtrl',
        })
        .when('/ver/:id', 
        {
            templateUrl : 'views/detallesproductos.html',
            controller  : 'detallesProductosCtrl',
        })
        .when('/carrito', 
        {
            templateUrl : 'views/carritoproductos.html',
            controller  : 'carritoProductosCtrl',
        })
        .when('/login', 
        {
            templateUrl : 'views/login.html',
            controller  : 'loginCtrl',
        })
        .otherwise({redirectTo: '/'});
});