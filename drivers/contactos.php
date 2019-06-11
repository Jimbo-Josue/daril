<?php

class contactos
{
  const CREADO = 1;
  const ERROR = 2;
  public static function post($peticion)
  {
    $idUsuario = usuarios::autorizar();
    $body = file_get_contents('php://input');
    $contacto = json_decode($body);
    $email = $contacto->correo;

    $ret = self::crear($idUsuario, $email);
    if($ret == self::CREADO)
      return ["Mensaje" => "Contacto Creado"];
    else if($ret == self::ERROR)
    {
      http_response_code(400);
      return ["Mensaje" => "Error al crear Contacto"];
    }
    else
    {
      http_response_code(400);
      return ["Mensaje" => $ret];
    }
  }

  private function crear($idUsuario, $email)
  {
    $idUsuario = usuarios::autorizar();

    $cmd = "SELECT idUser FROM User INNER JOIN Email ON Email.idEmail=User.idEmail".
           " WHERE Email.email=?"; 
    $sentencia = ConexionBD::obtenerInstancia()->obtenerBD()->prepare($cmd);
    $sentencia->bindParam(1, $email);
    $sentencia->execute();

    $idContacto = $sentencia->fetchColumn();
    if($idContacto == $idUsuario)
      return 9;

    if($idContacto > 0)
    {
      $cmd = "SELECT COUNT(*) FROM Contact".
           " WHERE idUser=? AND idUserContact=?"; 
      $sentencia = ConexionBD::obtenerInstancia()->obtenerBD()->prepare($cmd);
      $sentencia->bindParam(1, $idUsuario);
      $sentencia->bindParam(2, $idContacto);

      $sentencia->execute();
      $ret = $sentencia->fetchColumn();
      if($ret == 0)
      {
        $cmd = "INSERT INTO Contact VALUES(null,?,?)";

        $pdo = ConexionBD::obtenerInstancia()->obtenerBD();
        $sentencia = $pdo->prepare($cmd);
        $sentencia->bindParam(1, $idUsuario, PDO::PARAM_INT);
        $sentencia->bindParam(2, $idContacto, PDO::PARAM_INT);

        if($sentencia->execute())
          return self::CREADO;
        return 10;
      }
      else
        return 11;
    }
    else
      return 12;
    return self::ERROR;
  }
}

