<?php

require 'Slim/Slim.php';

$app = new Slim();

// Rutas.

// Productos.

$app->get('/listadoproductos', 'listadoproductos');
$app->get('/detallesproductos/:id', 'detallesproductos');
$app->post('/agregarproductoscarrito', 'agregarProductosCarrito');
$app->get('/listadoproductoscarrito/:id', 'listadoProductosCarrito');

// Usuarios.

$app->post('/login', 'login');
$app->post('/registrar', 'registrar');
$app->get('/buscarusuario/:id', 'buscarUsuario');

// Iniciar aplicación.

$app->run();

// Funciones.

// Productos.

function listadoProductos() 
{
	$sql = "SELECT id, imagen, titulo, marca, precio FROM productos;";
	try {
		$db = getConnection();
		$stmt = $db->query($sql);  
		$data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		echo json_encode($data);
	} catch(PDOException $e) {
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

function detallesProductos($id) 
{
	$sql = "SELECT id, titulo, imagen, marca, precio FROM productos WHERE id=".$id." LIMIT 1;";
	try {
		$db = getConnection();
		$stmt = $db->query($sql);  
		$data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		echo json_encode($data);
	} catch(PDOException $e) {
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

function agregarProductosCarrito() 
{
	$request = Slim::getInstance()->request();
	$carrito = json_decode($request->getBody());
	$sql = "INSERT INTO carrito (usuario, producto, cantidad) VALUES (:usuario, :producto, :cantidad);";
	try 
	{
		$db = getConnection();
		$stmt = $db->prepare($sql);  
		$stmt->bindParam("usuario", $carrito->usuario);
		$stmt->bindParam("producto", $carrito->producto);
		$stmt->bindParam("cantidad", $carrito->cantidad);
		$stmt->execute();
		$db = null;
		echo json_encode($carrito); 
	} catch(PDOException $e) {
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

function listadoProductosCarrito($id) 
{
	$sql = "SELECT titulo, marca, precio, cantidad 
			FROM carrito 
			INNER JOIN productos 
			ON productos.id = carrito.producto
			WHERE usuario = ".$id.";";
	try {
		$db = getConnection();
		$stmt = $db->query($sql);  
		$data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		echo json_encode($data);
	} catch(PDOException $e) {
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

// Usuarios.

function login() 
{
	$request = Slim::getInstance()->request();
	$usuario = json_decode($request->getBody());
	$salt = strtr(base64_encode(mcrypt_create_iv(16, MCRYPT_DEV_URANDOM)), '+', '.');
	$salt = $usuario->email . $salt;
	$password = crypt($usuario->password, $salt);
	$sql = "SELECT id FROM usuarios WHERE email=:email AND password=:password LIMIT 1;";
	try 
	{
		$db = getConnection();
		$stmt = $db->prepare($sql);  
		$stmt->bindParam("email", $usuario->email);
		$stmt->bindParam("password", $password);
		$stmt->execute();
		$data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		echo json_encode($data); 
	} catch(PDOException $e) {
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

function registrar() 
{
	$request = Slim::getInstance()->request();
	$usuario = json_decode($request->getBody());
	$salt = strtr(base64_encode(mcrypt_create_iv(16, MCRYPT_DEV_URANDOM)), '+', '.');
	$salt = $usuario->email . $salt;
	$password = crypt($usuario->password, $salt);
	$sql = "INSERT INTO usuarios (nombre, apellidoPaterno, apellidoMaterno, direccion, rfc, email, password) VALUES (:nombre, :apellidoPaterno, :apellidoMaterno, :direccion, :rfc, :email, :password);";
	try 
	{
		$db = getConnection();
		$stmt = $db->prepare($sql);  
		$stmt->bindParam("nombre", $usuario->nombre);
		$stmt->bindParam("apellidoPaterno", $usuario->apellidoPaterno);
		$stmt->bindParam("apellidoMaterno", $usuario->apellidoMaterno);
		$stmt->bindParam("direccion", $usuario->direccion);
		$stmt->bindParam("rfc", $usuario->rfc);
		$stmt->bindParam("email", $usuario->email);
		$stmt->bindParam("password", $password);
		$stmt->execute();
		$db = null;
		echo json_encode($usuario); 
	} catch(PDOException $e) {
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

function buscarUsuario($id) 
{
	$sql = "SELECT nombre, apellidoPaterno, apellidoMaterno, direccion, rfc, email FROM usuarios WHERE id=".$id." LIMIT 1;";
	try {
		$db = getConnection();
		$stmt = $db->query($sql);  
		$data = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		echo json_encode($data);
	} catch(PDOException $e) {
		echo '{"error":{"text":'. $e->getMessage() .'}}'; 
	}
}

// Conexión a la base de datos.

function getConnection() 
{
	$dbhost="localhost";
	$dbuser="root";
	$dbpass="";
	$dbname="tienda_muebles";

	$dbh = new PDO("mysql:host=$dbhost;dbname=$dbname", $dbuser, $dbpass);	
	$dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	return $dbh;
}
?>