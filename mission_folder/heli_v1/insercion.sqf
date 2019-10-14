/*script de insercion en el area
le da los datos al piloto para hacerla
luego del addacion
*/

  params ["_heli", "_caller", "_actionId", "_arg"]; //argumentos

  _heli setFuel 1; //le pone combustible
  sleep 1;
  _lz = _arg select 0; //define lz
  _helipad = _arg select 1; //define helipad

  //despegue//
  _obj = "Land_HelipadEmpty_F" createVehicle _lz;//crea helipad invisible
  _heli engineon true; //prende el motor
  sleep 10; //espera a que prenda el motor
  _wplz = (group _heli) addWaypoint [ _lz, 0, 1]; //asigna el wa
  _wplz setWaypointPosition [_lz, 0]; //pone el waypoint en el lz
  _wplz setWaypointName "wpMoveLZ";
  _wplz setWaypointType "MOVE";
  _wplz setWaypointSpeed "NORMAL";
  _wplz setWaypointStatements ["true", "vehicle this land 'GET OUT';"];
  //espera a que queden solo pilotos
  waituntil { ( {isPlayer _x} count (crew _heli) < 1 ) && ((getpos _heli) distance2d _lz < 100) && (isTouchingGround _heli) };
  deletevehicle _obj;
  sleep 1;//espera a que salgan todos
  //emprende la vuelta
  deleteWaypoint _wplz;
  _wprtb = (group _heli) addWaypoint [ _helipad, -1, 1];
  _wprtb setWaypointPosition [_helipad, -1];
  _wprtb setWaypointName "RTB";
  _wprtb setWaypointType "MOVE";
  _wprtb setWaypointSpeed "FULL";
  _wprtb setWaypointDescription "Extraction zone";
  _wprtb setWaypointStatements ["true", "vehicle this land 'LAND';"];
  waituntil {isTouchingGround _heli && (getpos _heli) distance2d _helipad < 30};
  deleteWaypoint _wprtb;
  sleep 10;
  deleteWaypoint _wprtb;
  _heli setFuel 0;
