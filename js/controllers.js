// Controladores de la aplicación.

// Controlador del listado de productos.

app.controller('listadoProductosCtrl', function($scope, $http) 
{
    // Obtener el listado de los productos.

    $http.get('api/listadoproductos').success(function(data)
    {
        $scope.productos = data;
    });
});

// Controlador del detalle de los productos.

app.controller('detallesProductosCtrl', function($scope, $http, $routeParams, $location, $cookieStore)
{
    // Variables de trabajo.

    var usuario = $cookieStore.get('usuario');
    var id = $routeParams.id;
    $scope.detallesProductos = {};
    $scope.cantidad = 1;

    // Obtener el detalle de los productos.

    $http.get('api/detallesproductos/'+id).success(function(data) 
    {
        $scope.detallesProductos = data[0];
    });

    // Agregar productos al carrito de compras.

    $scope.agregarProductoCarrito = function() 
    {
        if(usuario)
        {
            var productoCarrito = {usuario:usuario,producto:$scope.detallesProductos.id, cantidad:$scope.cantidad};

            $http.post('api/agregarproductoscarrito', productoCarrito).success(function(data)
            {
                $scope.mensajeCarrito = true;
            });
        }
        else
        {
            $location.path("/login");
        }
    }
});

// Controlador del carro de compras.

app.controller('carritoProductosCtrl', function($scope, $http, $cookieStore)
{
    $scope.usuario = $cookieStore.get('usuario');

    if($scope.usuario)
    {
        // Variables de trabajo.

        var subTotal = 0;
        var enganche = 0;
        var bonificacion = 0;
        var totalAdeudo = 0;
        var meses = 0;
        var interesMensual = 0;
        var abono = 0;
        var totalPagar = 0;
        var ahorra = 0;
        var abonosMensuales = [];

        // Obtener los datos del cliente.

        $http.get("api/buscarusuario/"+$scope.usuario).success(function(data)
        {
            $scope.datosUsuario = data[0];
        });

        // Obtener el listado de los productos del carro de compras.

        $http.get("api/listadoproductoscarrito/"+$scope.usuario).success(function(data)
        {
            $scope.productosCarrito = data;

            // Si hay productos en el carro se realizan los calculos de la factura de compra.
            
            if(data.length > 0)
            {     
                // Calculos de la factura de compra.

                $.each($scope.productosCarrito, function() 
                {
                    subTotal += parseInt(this.precio);
                });

                enganche = subTotal*0.2;
                bonificacion = ((subTotal)*2.8)/100;
                totalAdeudo = subTotal - enganche - bonificacion;

                for (var i = 3; i <= 12; i+=3) 
                {
                    meses = i;
                    interesMensual = ((totalAdeudo/i)*2.8)/100;
                    abono = (totalAdeudo/i) - interesMensual;
                    totalPagar = totalAdeudo - interesMensual*12;
                    ahorra = totalAdeudo - totalPagar;

                    abonosMensuales.push({meses:meses,abono:abono,totalPagar:totalPagar,ahorra:ahorra});
                }

                // Asignación de valores a la vista.

                $scope.enganche = enganche;
                $scope.bonificacion = bonificacion;
                $scope.totalAdeudo = totalAdeudo;
                $scope.abonosMensuales = abonosMensuales;
            }
        });   
    }
});

// Controlador del panel de opciones del menu principal.

app.controller('panelOpcionesCtrl', function($scope, $http, $location, $cookieStore) 
{
    // Cerrar sesión.

    $scope.logout = function()
    {
        $cookieStore.remove('usuario');
        location.reload();
    }
});

// Controlador del login de los usuarios.

app.controller('loginCtrl', function($scope, $http, $location, $cookieStore) 
{
    // Iniciar sesión.

    $scope.ingresar = function(usuario)
    {
        $http.post('api/login', usuario).success(function(data)
        {
            if(data.length == 1)
            {
                $cookieStore.put('usuario', data[0].id);
                location.reload();
                $location.path("#/");
            }
            else
            {
                $scope.mensajeLogin = true;
            }
        });
    }

    // Registrarse en la tienda.

    $scope.registrar = function(usuario)
    {
        $http.post('api/registrar', usuario).success(function(data)
        {
            $scope.mensajeRegistro = true;
            $scope.registro = {};
        });
    }
});