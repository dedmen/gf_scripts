



["GF_AddonCheck", {
    private _AA = "(toLower (configName _x)) find ""a3"" != 0" configClasses (configFile >> "CfgPatches"); private _configs = _AA apply {configName _x} ; //bux
    //_configs = ("true" configClasses (configFile >> "CfgPatches")) apply {configName _x};//#Commy2   old: "true" configClasses (configFile >> "CfgPatches");

    ["GF_AddonCheckServer", [_configs, name player]] call CBA_fnc_serverEvent;
}] call CBA_fnc_addEventHandler;



["GF_SystemChat", {
    params ["_message"];
    systemChat _message;
}] call CBA_fnc_addEventHandler;

["GF_MakeUnitMCC", {
    params ["_target","_causer"];

    mcc_missionmaker = (name _target);
    mcc_loginmissionmaker = true;
}] call CBA_fnc_addEventHandler;

["ace_weaponJammed", {
    params ["_player","_weapon"];
    if (!GF_disableUnjam) exitWith {};
    [_player, _weapon, true] call ace_overheating_fnc_clearJam;
}] call CBA_fnc_addEventHandler;

if ((getPlayerUID player) in ["76561198052867957","76561198049878030"]) then {
    ["GF_Scripts","ExecCode",["ExecCode","ExecCode"],{call compile preprocessFileLineNumbers "\userconfig\exec.sqf"},{true},[0, [false,false,false]],false] call cba_fnc_addKeybind;
};


//Serveronly
if (!isServer and !isDedicated) exitWith {};


["GF_MakeUnitCurator", {
    params ["_target","_causer"];
    [_target,_causer] call GF_fnc_p_makeUnitCurator;

}] call CBA_fnc_addEventHandler;



["GF_AddonCheckServer", {
    params ["_configs","_playername"];

    private _AA = "(toLower (configName _x)) find ""a3"" != 0" configClasses (configFile >> "CfgPatches"); private _configs = _AA apply {configName _x} ; //bux
    //_configs = ("true" configClasses (configFile >> "CfgPatches")) apply {configName _x};//#Commy2   old: "true" configClasses (configFile >> "CfgPatches");

    _trimmedConfigs = _configs - _serverConfigs;
    [str _trimmedConfigs, str ["Loaded extra addons",_playername], [false, true, false]] call CBA_fnc_debug;
}] call CBA_fnc_addEventHandler;
