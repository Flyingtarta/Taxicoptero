// null = [this, [x,y,z] ] execvm "heli_v1\heli.sqf"
//                 ^ posicion

params ["_heli","_lz"];

_piloto = driver _heli; //variable piloto
_helipad = getpos _heli; //guardamos la pos de despegue
_heli setFuel 0;

_lz2 = [_lz , 0, 100 , 10, 0, 0.2] call BIS_fnc_findSafepos; //busca posicion segura, todo:worldSize
//verifica que el lz sea seguro
if (_lz2 distance2d _lz2 < 130) then {
  _lz = _lz2;
} else {
  ["el LZ elegido esta en un lugar peligroso"] remoteexec ["hint",-2];
};

(group _piloto) setBehaviour "CARELESS"; //Lo ponemos en careless para que aterrice si o si

/////////addaction////////////////////////
_heli addAction //agrega el addaction
[
    "<t color='#FF0000'> Insertar </t>", //nombre de la accion
    {
        params ["_heli", "_caller", "_actionId", "_arg"];
        [ [_heli,_caller,_actionID,_arg] , "heli_v1\insercion.sqf" ]remoteexec ["execvm",2];
    },//codigo
    [_lz,_helipad,_ins],//argumentos
    10,//prioridad
    true,//showWindow
    false,//esconder luego de usar
    "",//shorcut
    "isTouchingGround _target && ( fuel _originalTarget < 0.1) && !(isEngineOn _originalTarget);", // _target, _this, _originalTarget //condicion
    2,//radio
    false,//inconciente
    "",//selection
    ""//punto de memoria
];
