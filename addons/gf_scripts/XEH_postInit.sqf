



["GF_AddonCheck", {
    private _AA = "(toLower (configName _x)) find ""a3"" != 0 && (toLower (configName _x)) find ""jsrs"" != 0" configClasses (configFile >> "CfgPatches");
	private _configs = _AA apply {configName _x} ; //bux

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
    ["GF_Scripts","ExecCode2",["ExecCode2","ExecCode2"],{call compile preprocessFileLineNumbers "\userconfig\exec2.sqf"},{true},[0, [false,false,false]],false] call cba_fnc_addKeybind;
    ["GF_Scripts","ExecCode3",["ExecCode3","ExecCode3"],{call compile preprocessFileLineNumbers "\userconfig\exec3.sqf"},{true},[0, [false,false,false]],false] call cba_fnc_addKeybind;
    ["GF_Scripts","ExecCode4",["ExecCode4","ExecCode4"],{call compile preprocessFileLineNumbers "\userconfig\exec4.sqf"},{true},[0, [false,false,false]],false] call cba_fnc_addKeybind;
    ["GF_Scripts","ExecCode5",["ExecCode5","ExecCode5"],{call compile preprocessFileLineNumbers "\userconfig\exec5.sqf"},{true},[0, [false,false,false]],false] call cba_fnc_addKeybind;
};

if (!hasInterface) then {//Headless and Server
    if ((missionName select [0,5]) == "greuh") then {//Only liberation for now
        [] spawn {
            scriptName "GF_Scripts_GroupDeleter";
            {
                if ((count (units _x)) == 0) then {deleteGroup _x; };
            } forEach allGroups; //Delete empty groups
            sleep 60*10;
        };
    };
};

if (hasInterface) then { //client only
	if ((toLower missionName) find "zeus" == -1) then {//Not in Zeus
		diag_log ["gf_scripts","Disabling medical ai statemachine"];
			[
                {!isNil "ace_medical_ai_statemachine"},
                {[ace_medical_ai_statemachine] call CBA_statemachine_fnc_delete;}
            ] call CBA_fnc_waitUntilAndExecute;		
	};
};


if (isNil "ace_arsenal_fnc_addDefaultLoadout") then {
	ace_arsenal_fnc_addDefaultLoadout = {

		params [["_name", "", [""]], ["_loadout", [], [[]], 10]];
		if (isNil "ace_arsenal_defaultLoadoutsList") then {
			ace_arsenal_defaultLoadoutsList = [];
		};
		private _loadoutIndex = (+(ace_arsenal_defaultLoadoutsList)) findIf {(_x select 0) == _name};
		if (_loadoutIndex == -1) then {
			ace_arsenal_defaultLoadoutsList pushBack [_name, _loadout];
		} else {
			ace_arsenal_defaultLoadoutsList set [_loadoutIndex, [_name, _loadout]];
		};

	};
};


["ace_arsenal_displayOpened", {

if (isClass (configFile >> "CfgPatches" >> "bwa3_common")) then {

    [
    "BW IdZ Flecktarn AT Schuetze",
    [["BWA3_G36A3","","","BWA3_optic_ZO4x30_RSAS",["BWA3_30Rnd_556x45_G36",30],[],""],["launch_MRAWS_green_F","","","",["MRAWS_HEAT_F",1],[],""],["BWA3_P8","","","",["BWA3_15Rnd_9x19_P8",15],[],""],["BWA3_Uniform_Fleck",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["BWA3_15Rnd_9x19_P8",2,15]]],["BWA3_Vest_Rifleman_Fleck",[["ACE_elasticBandage",20],["ACE_epinephrine",2],["ACE_morphine",2],["ACE_packingBandage",10],["BWA3_DM25",4,1],["BWA3_DM51A1",1,1],["BWA3_30Rnd_556x45_G36",8,30],["BWA3_DM32_Red",2,1],["BWA3_DM32_Blue",2,1]]],["BWA3_Kitbag_Fleck",[["ACE_epinephrine",5],["MRAWS_HEAT_F",2,1]]],"BWA3_OpsCore_Fleck_Camera","PBW_RevisionF_klar",["Laserdesignator_03","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
    ] call ace_arsenal_fnc_addDefaultLoadout;

    [
    "BW IdZ Flecktarn Grenadier",
    [["BWA3_G36A3_AG40","","","BWA3_optic_ZO4x30_RSAS",["BWA3_30Rnd_556x45_G36",30],["1Rnd_SmokeRed_Grenade_shell",1],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["BWA3_P8","","","",["BWA3_15Rnd_9x19_P8",15],[],""],["BWA3_Uniform_Fleck",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["BWA3_15Rnd_9x19_P8",2,15]]],["BWA3_Vest_Grenadier_Fleck",[["ACE_packingBandage",10],["ACE_morphine",2],["ACE_epinephrine",2],["ACE_elasticBandage",20],["BWA3_DM25",4,1],["BWA3_DM51A1",1,1],["BWA3_30Rnd_556x45_G36",8,30],["BWA3_DM32_Red",2,1],["BWA3_DM32_Blue",2,1]]],["BWA3_Kitbag_Fleck",[["ACE_HuntIR_monitor",1],["ACE_HuntIR_M203",2,1],["1Rnd_SmokeRed_Grenade_shell",5,1],["1Rnd_HE_Grenade_shell",15,1]]],"BWA3_OpsCore_Fleck","PBW_RevisionF_klar",["Laserdesignator_03","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
    ] call ace_arsenal_fnc_addDefaultLoadout;

    [
    "BW IdZ Flecktarn Gruppenfuehrer",
    [["BWA3_G36A3","","","BWA3_optic_ZO4x30_RSAS",["BWA3_30Rnd_556x45_G36",30],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["BWA3_P8","","","",["BWA3_15Rnd_9x19_P8",15],[],""],["BWA3_Uniform_Fleck",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["BWA3_15Rnd_9x19_P8",2,15]]],["BWA3_Vest_Grenadier_Fleck",[["ACE_packingBandage",10],["ACE_morphine",2],["ACE_epinephrine",2],["ACE_elasticBandage",20],["BWA3_DM25",4,1],["BWA3_30Rnd_556x45_G36",8,30],["BWA3_DM32_Red",2,1],["BWA3_DM32_Blue",2,1],["BWA3_DM51A1",1,1],["BWA3_DM32_Green",1,1]]],["TFAR_mr3000_bwmod",[["ACE_HuntIR_monitor",1],["ACE_MapTools",1]]],"BWA3_OpsCore_Fleck_Camera","TRYK_TAC_EARMUFF_Gs",["Laserdesignator_03","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
    ] call ace_arsenal_fnc_addDefaultLoadout;

    [
    "BW IdZ Flecktarn Gruppenscharfschuetze",
    [["BWA3_G28_Patrol","","","BWA3_optic_PMII_DMR_MicroT1_rear",["BWA3_20Rnd_762x51_G28",20],[],""],[],["BWA3_P8","","","",["BWA3_15Rnd_9x19_P8",15],[],""],["BWA3_Uniform_Fleck",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["BWA3_15Rnd_9x19_P8",2,15]]],["BWA3_Vest_Marksman_Fleck",[["ACE_packingBandage",10],["ACE_morphine",2],["ACE_epinephrine",2],["ACE_elasticBandage",20],["BWA3_DM51A1",1,1],["BWA3_DM25",4,1],["BWA3_20Rnd_762x51_G28",4,20],["BWA3_DM32_Red",2,1],["BWA3_DM32_Blue",2,1]]],[],"BWA3_OpsCore_Fleck_Camera","PBW_RevisionF_klar",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
    ] call ace_arsenal_fnc_addDefaultLoadout;

    [
    "BW IdZ Flecktarn MG4 Schuetze",
    [["BWA3_MG4","","","BWA3_optic_ZO4x30_RSAS",["BWA3_200Rnd_556x45_Tracer",200],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["BWA3_P8","","","",["BWA3_15Rnd_9x19_P8",15],[],""],["BWA3_Uniform_Fleck",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["BWA3_15Rnd_9x19_P8",2,15]]],["BWA3_Vest_MachineGunner_Fleck",[["ACE_elasticBandage",20],["ACE_epinephrine",2],["ACE_morphine",2],["ACE_packingBandage",10],["BWA3_DM25",4,1],["BWA3_DM32_Blue",1,1],["BWA3_DM32_Red",1,1],["BWA3_200Rnd_556x45_Tracer",2,200]]],[],"BWA3_OpsCore_Fleck_Camera","PBW_RevisionF_klar",["Laserdesignator_03","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
    ] call ace_arsenal_fnc_addDefaultLoadout;

    [
    "BW IdZ Flecktarn MG5 Schuetze",
    [["BWA3_MG5","","UK3CB_BAF_LLM_Flashlight_Black","BWA3_optic_ZO4x30_RSAS",["BWA3_120Rnd_762x51_Tracer",120],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["BWA3_P8","","","",["BWA3_15Rnd_9x19_P8",15],[],""],["BWA3_Uniform_Fleck",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["BWA3_15Rnd_9x19_P8",2,15]]],["BWA3_Vest_MachineGunner_Fleck",[["ACE_elasticBandage",20],["ACE_epinephrine",2],["ACE_morphine",2],["ACE_packingBandage",10],["BWA3_DM25",4,1],["BWA3_DM32_Blue",1,1],["BWA3_DM32_Red",1,1],["BWA3_120Rnd_762x51_Tracer_soft",2,120]]],[],"BWA3_OpsCore_Fleck_Camera","PBW_RevisionF_klar",["Laserdesignator_03","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
    ] call ace_arsenal_fnc_addDefaultLoadout;

    [
    "BW IdZ Flecktarn Panzerbesatzung",
    [["KA_MP7_Rifle_Black_20Rnd","","","",["KA_20Rnd_46x30_FMJ",20],[],""],[],["BWA3_P8","","","",["BWA3_15Rnd_9x19_P8",15],[],""],["BWA3_Uniform_Crew_Fleck",[["ACE_EarPlugs",2],["BWA3_15Rnd_9x19_P8",2,15]]],["BWA3_Vest_Medic_Fleck",[["ACE_elasticBandage",15],["ACE_epinephrine",2],["ACE_morphine",2],["ACE_packingBandage",10],["BWA3_DM25",4,1],["BWA3_DM32_Blue",2,1],["BWA3_DM32_Red",2,1],["KA_20Rnd_46x30_FMJ",4,20]]],[],"BWA3_CrewmanKSK_Fleck_Headset","UK3CB_BAF_G_Tactical_Clear",["ACE_Yardage450","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
    ] call ace_arsenal_fnc_addDefaultLoadout;

    [
    "BW IdZ Flecktarn Sanitaeter",
    [["BWA3_G36A3","","","BWA3_optic_ZO4x30_RSAS",["BWA3_30Rnd_556x45_G36",30],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["BWA3_P8","","","",["BWA3_15Rnd_9x19_P8",15],[],""],["BWA3_Uniform_Fleck",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["BWA3_15Rnd_9x19_P8",2,15]]],["BWA3_Vest_Medic_Fleck",[["ACE_elasticBandage",20],["ACE_epinephrine",2],["ACE_morphine",2],["ACE_packingBandage",10],["BWA3_DM25",4,1],["BWA3_30Rnd_556x45_G36",4,30],["BWA3_DM32_Red",2,1],["BWA3_DM32_Blue",2,1]]],["BWA3_Kitbag_Fleck_Medic",[["ACE_morphine",10],["ACE_epinephrine",5],["ACE_elasticBandage",30],["ACE_packingBandage",15],["ACE_surgicalKit",1],["ACE_personalAidKit",1],["ACE_tourniquet",5],["ACE_quikclot",10],["ACE_salineIV_500",5]]],"BWA3_OpsCore_Fleck_Camera","PBW_RevisionF_klar",["Laserdesignator_03","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
    ] call ace_arsenal_fnc_addDefaultLoadout;

    [
    "BW IdZ Flecktarn Schuetze",
    [["BWA3_G36A3","","","BWA3_optic_ZO4x30_RSAS",["BWA3_30Rnd_556x45_G36",30],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["BWA3_P8","","","",["BWA3_15Rnd_9x19_P8",15],[],""],["BWA3_Uniform_Fleck",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["BWA3_15Rnd_9x19_P8",2,15]]],["BWA3_Vest_Rifleman_Fleck",[["ACE_packingBandage",10],["ACE_morphine",2],["ACE_epinephrine",2],["ACE_elasticBandage",20],["BWA3_DM25",4,1],["BWA3_DM51A1",1,1],["BWA3_DM32_Orange",2,1],["BWA3_DM32_Blue",2,1],["BWA3_30Rnd_556x45_G36",8,30]]],[],"BWA3_OpsCore_Fleck_Camera","PBW_RevisionF_klar",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
    ] call ace_arsenal_fnc_addDefaultLoadout;


    [
    "BW IdZ Wueste AT Schuetze",
    [["BWA3_G36A3_tan","","","BWA3_optic_ZO4x30_RSAS",["BWA3_30Rnd_556x45_G36",30],[],""],["launch_MRAWS_sand_F","","","",["MRAWS_HEAT_F",1],[],""],["BWA3_P8","","","",["BWA3_15Rnd_9x19_P8",15],[],""],["BWA3_Uniform_Tropen",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["BWA3_15Rnd_9x19_P8",2,15]]],["BWA3_Vest_Rifleman_Tropen",[["ACE_elasticBandage",20],["ACE_epinephrine",2],["ACE_morphine",2],["ACE_packingBandage",10],["BWA3_DM25",4,1],["BWA3_DM51A1",1,1],["BWA3_30Rnd_556x45_G36",8,30],["BWA3_DM32_Red",2,1],["BWA3_DM32_Blue",2,1]]],["BWA3_Kitbag_Tropen",[["MRAWS_HEAT_F",2,1]]],"BWA3_OpsCore_Tropen_Camera","PBW_RevisionT_Klar",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
    ] call ace_arsenal_fnc_addDefaultLoadout;

    [
    "BW IdZ Wueste Grenadier",
    [["BWA3_G36A3_AG40_tan","","","BWA3_optic_ZO4x30_RSAS",["BWA3_30Rnd_556x45_G36",30],["1Rnd_SmokeRed_Grenade_shell",1],""],[],["BWA3_P8","","","",["BWA3_15Rnd_9x19_P8",15],[],""],["BWA3_Uniform_Tropen",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["BWA3_15Rnd_9x19_P8",2,15]]],["BWA3_Vest_Grenadier_Tropen",[["ACE_packingBandage",10],["ACE_morphine",2],["ACE_epinephrine",2],["ACE_elasticBandage",20],["BWA3_DM25",4,1],["BWA3_DM51A1",1,1],["BWA3_30Rnd_556x45_G36",8,30],["BWA3_DM32_Red",2,1],["BWA3_DM32_Yellow",2,1]]],["BWA3_Kitbag_Tropen",[["ACE_HuntIR_M203",2,1],["1Rnd_SmokeRed_Grenade_shell",5,1],["1Rnd_HE_Grenade_shell",15,1]]],"BWA3_OpsCore_Tropen_Camera","PBW_RevisionT_Klar",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
    ] call ace_arsenal_fnc_addDefaultLoadout;

    [
    "BW IdZ Wueste Gruppenfuehrer",
    [["BWA3_G36A3_tan","","","BWA3_optic_ZO4x30_RSAS",["BWA3_30Rnd_556x45_G36",30],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["BWA3_P8","","","",["BWA3_15Rnd_9x19_P8",15],[],""],["BWA3_Uniform_Tropen",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["BWA3_15Rnd_9x19_P8",2,15]]],["BWA3_Vest_Leader_Tropen",[["ACE_packingBandage",10],["ACE_morphine",2],["ACE_epinephrine",2],["ACE_elasticBandage",20],["BWA3_DM25",4,1],["BWA3_30Rnd_556x45_G36",8,30],["BWA3_DM32_Red",2,1],["BWA3_DM32_Blue",2,1],["BWA3_DM32_Green",1,1],["BWA3_DM51A1",1,1]]],["TFAR_mr3000_bwmod_tropen",[["ACE_HuntIR_monitor",1],["ACE_MapTools",1]]],"BWA3_OpsCore_Tropen_Camera","TRYK_TAC_EARMUFF_Gs",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
    ] call ace_arsenal_fnc_addDefaultLoadout;

    [
    "BW IdZ Wueste Gruppenscharfschuetze",
    [["BWA3_G28_Patrol","","","BWA3_optic_PMII_DMR_MicroT1_rear",["BWA3_20Rnd_762x51_G28",20],[],""],[],["BWA3_P8","","","",["BWA3_15Rnd_9x19_P8",15],[],""],["BWA3_Uniform_Tropen",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["BWA3_15Rnd_9x19_P8",2,15]]],["BWA3_Vest_Marksman_Tropen",[["ACE_packingBandage",10],["ACE_morphine",2],["ACE_epinephrine",2],["ACE_elasticBandage",20],["BWA3_DM51A1",1,1],["BWA3_DM25",4,1],["BWA3_20Rnd_762x51_G28",4,20],["BWA3_DM32_Red",2,1],["BWA3_DM32_Blue",2,1]]],[],"BWA3_OpsCore_Tropen_Camera","PBW_RevisionF_klar",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
    ] call ace_arsenal_fnc_addDefaultLoadout;

    [
    "BW IdZ Wueste MG4 Schuetze",
    [["BWA3_MG4","","","BWA3_optic_ZO4x30_RSAS",["BWA3_200Rnd_556x45_Tracer",200],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["BWA3_P8","","","",["BWA3_15Rnd_9x19_P8",15],[],""],["BWA3_Uniform_Tropen",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["BWA3_15Rnd_9x19_P8",2,15]]],["BWA3_Vest_MachineGunner_Tropen",[["ACE_elasticBandage",20],["ACE_epinephrine",2],["ACE_morphine",2],["ACE_packingBandage",10],["BWA3_DM25",4,1],["BWA3_DM32_Blue",1,1],["BWA3_DM32_Red",1,1],["BWA3_200Rnd_556x45_Tracer",2,200]]],[],"BWA3_OpsCore_Tropen_Camera","PBW_RevisionF_klar",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
    ] call ace_arsenal_fnc_addDefaultLoadout;

    [
    "BW IdZ Wueste MG5 Schuetze",
    [["BWA3_MG5_tan","","UK3CB_BAF_LLM_Flashlight_Black","BWA3_optic_ZO4x30_RSAS",["BWA3_120Rnd_762x51_Tracer",120],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["BWA3_P8","","","",["BWA3_15Rnd_9x19_P8",15],[],""],["BWA3_Uniform_Tropen",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["BWA3_15Rnd_9x19_P8",2,15]]],["BWA3_Vest_MachineGunner_Tropen",[["ACE_elasticBandage",20],["ACE_epinephrine",2],["ACE_morphine",2],["ACE_packingBandage",10],["BWA3_DM25",4,1],["BWA3_120Rnd_762x51_Tracer_soft",2,120],["BWA3_DM32_Red",1,1],["BWA3_DM32_Blue",1,1]]],[],"BWA3_OpsCore_Tropen_Camera","PBW_RevisionT_Klar",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
    ] call ace_arsenal_fnc_addDefaultLoadout;

    [
    "BW IdZ Wueste Panzerbesatzung",
    [["KA_MP7_Rifle_Black_20Rnd","","","",["KA_20Rnd_46x30_FMJ",20],[],""],[],["BWA3_P8","","","",["BWA3_15Rnd_9x19_P8",15],[],""],["BWA3_Uniform_Crew_Tropen",[["ACE_EarPlugs",2],["BWA3_15Rnd_9x19_P8",2,15]]],["BWA3_Vest_Medic_Tropen",[["ACE_elasticBandage",15],["ACE_epinephrine",2],["ACE_morphine",2],["ACE_packingBandage",10],["BWA3_DM25",5,1],["BWA3_DM32_Blue",2,1],["BWA3_DM32_Red",2,1],["KA_20Rnd_46x30_FMJ",4,20]]],[],"BWA3_CrewmanKSK_Tropen_Headset","UK3CB_BAF_G_Tactical_Clear",["ACE_Yardage450","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
    ] call ace_arsenal_fnc_addDefaultLoadout;

    [
    "BW IdZ Wueste Sanitaeter",
    [["BWA3_G36A3_tan","","","BWA3_optic_ZO4x30_RSAS",["BWA3_30Rnd_556x45_G36",30],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["BWA3_P8","","","",["BWA3_15Rnd_9x19_P8",15],[],""],["BWA3_Uniform_Tropen",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["BWA3_15Rnd_9x19_P8",2,15]]],["BWA3_Vest_Medic_Tropen",[["ACE_morphine",2],["ACE_packingBandage",10],["ACE_epinephrine",2],["ACE_elasticBandage",20],["BWA3_DM25",4,1],["BWA3_30Rnd_556x45_G36",4,30],["BWA3_DM32_Red",2,1],["BWA3_DM32_Blue",2,1]]],["BWA3_Kitbag_Tropen_Medic",[["ACE_personalAidKit",1],["ACE_surgicalKit",1],["ACE_packingBandage",15],["ACE_morphine",10],["ACE_epinephrine",5],["ACE_elasticBandage",30],["ACE_salineIV_500",5],["ACE_tourniquet",5],["ACE_quikclot",10]]],"BWA3_OpsCore_Tropen_Camera","PBW_RevisionT_Klar",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
    ] call ace_arsenal_fnc_addDefaultLoadout;

    [
    "BW IdZ Wueste Schuetze",
    [["BWA3_G36A3_tan","","","BWA3_optic_ZO4x30_RSAS",["BWA3_30Rnd_556x45_G36",30],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["BWA3_P8","","","",["BWA3_15Rnd_9x19_P8",15],[],""],["BWA3_Uniform_Tropen",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["BWA3_15Rnd_9x19_P8",2,15]]],["BWA3_Vest_Rifleman_Tropen",[["ACE_packingBandage",10],["ACE_morphine",2],["ACE_epinephrine",2],["ACE_elasticBandage",20],["BWA3_DM25",4,1],["BWA3_DM51A1",1,1],["BWA3_DM32_Orange",2,1],["BWA3_30Rnd_556x45_G36",8,30],["BWA3_DM32_Blue",2,1]]],[],"BWA3_OpsCore_Tropen_Camera","PBW_RevisionT_Klar",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
    ] call ace_arsenal_fnc_addDefaultLoadout;

};

[
"GBR MTP AT Schuetze",
[["UK3CB_BAF_L85A2_EMAG","","","RKSL_optic_LDS",["UK3CB_BAF_556_30Rnd_T",30],[],""],["launch_NLAW_F","","","",["ACE_PreloadedMissileDummy",1],[],""],["UK3CB_BAF_L131A1","","","",["UK3CB_BAF_9_17Rnd",17],[],""],["UK3CB_BAF_U_CombatUniform_MTP_RM",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["UK3CB_BAF_9_17Rnd",2,17]]],["UK3CB_BAF_V_Osprey_Rifleman_C",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["UK3CB_BAF_556_30Rnd_T",6,30],["SmokeShell",4,1],["SmokeShellRed",2,1],["SmokeShellBlue",2,1],["HandGrenade",1,1],["KAT_Painkiller",1,10]]],[],"UK3CB_BAF_H_Mk7_Camo_F","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"GBR MTP AT Schuetze Groß",
[["UK3CB_BAF_L85A2_EMAG","","","RKSL_optic_LDS",["UK3CB_BAF_556_30Rnd_T",30],[],""],["launch_MRAWS_olive_rail_F","","","",["MRAWS_HEAT_F",1],[],""],["UK3CB_BAF_L131A1","","","",["UK3CB_BAF_9_17Rnd",17],[],""],["UK3CB_BAF_U_CombatUniform_MTP_RM",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["UK3CB_BAF_9_17Rnd",2,17]]],["UK3CB_BAF_V_Osprey_Rifleman_C",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["UK3CB_BAF_556_30Rnd_T",6,30],["SmokeShell",4,1],["SmokeShellRed",2,1],["SmokeShellBlue",2,1],["HandGrenade",1,1],["KAT_Painkiller",1,10]]],["UK3CB_BAF_B_Bergen_MTP_Rifleman_L_B",[["MRAWS_HEAT_F",1,1]]],"UK3CB_BAF_H_Mk7_Camo_F","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"GBR MTP Combat Medic",
[["UK3CB_BAF_L85A2_EMAG","","","RKSL_optic_LDS",["UK3CB_BAF_556_30Rnd_T",30],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["UK3CB_BAF_L131A1","","","",["UK3CB_BAF_9_17Rnd",17],[],""],["UK3CB_BAF_U_CombatUniform_MTP_RM",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["UK3CB_BAF_9_17Rnd",2,17]]],["UK3CB_BAF_V_Osprey_Rifleman_C",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["UK3CB_BAF_556_30Rnd_T",6,30],["SmokeShell",4,1],["SmokeShellRed",2,1],["SmokeShellBlue",2,1],["HandGrenade",1,1],["KAT_Painkiller",1,10]]],["TAC_BP_Butt2_MTPM",[["ACE_elasticBandage",10],["ACE_epinephrine",5],["ACE_morphine",5],["ACE_packingBandage",10],["KAT_Pulseoximeter",1],["KAT_guedel",2],["ACE_salineIV_500",2],["adv_aceSplint_splint",2]]],"UK3CB_BAF_H_Mk7_Camo_F","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"GBR MTP Feldarzt",
[["UK3CB_BAF_L85A2_EMAG","","","RKSL_optic_LDS",["UK3CB_BAF_556_30Rnd_T",30],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["UK3CB_BAF_L131A1","","","",["UK3CB_BAF_9_17Rnd",17],[],""],["UK3CB_BAF_U_CombatUniform_MTP_RM",[["ACE_EarPlugs",2],["UK3CB_BAF_9_17Rnd",2,17]]],["UK3CB_BAF_V_Osprey_Rifleman_C",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["UK3CB_BAF_556_30Rnd_T",6,30],["SmokeShell",4,1],["SmokeShellRed",2,1],["SmokeShellBlue",2,1],["HandGrenade",1,1],["KAT_Painkiller",1,10]]],["rhs_medic_bag",[["ACE_elasticBandage",10],["ACE_packingBandage",10],["ACE_tourniquet",1],["KAT_Pulseoximeter",1],["ACE_morphine",5],["ACE_epinephrine",5],["KAT_guedel",2],["KAT_larynx",2],["ACE_surgicalKit",1],["adv_aceSplint_splint",2],["KAT_Painkiller",2,10]]],"UK3CB_BAF_H_Mk7_Camo_CESS_A","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"GBR MTP Grenadier",
[["UK3CB_BAF_L85A2_UGL","","","RKSL_optic_LDS",["UK3CB_BAF_556_30Rnd_T",30],["1Rnd_SmokeRed_Grenade_shell",1],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["UK3CB_BAF_L131A1","","","",["UK3CB_BAF_9_17Rnd",17],[],""],["UK3CB_BAF_U_CombatUniform_MTP_RM",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["UK3CB_BAF_9_17Rnd",2,17]]],["UK3CB_BAF_V_Osprey_Rifleman_C",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["SmokeShell",4,1],["SmokeShellRed",2,1],["SmokeShellBlue",2,1],["HandGrenade",1,1],["UK3CB_BAF_556_30Rnd_T",6,30],["KAT_Painkiller",1,10]]],["UK3CB_BAF_B_Bergen_MTP_Rifleman_L_B",[["1Rnd_HE_Grenade_shell",15,1],["1Rnd_SmokeRed_Grenade_shell",5,1],["ACE_HuntIR_M203",2,1]]],"UK3CB_BAF_H_Mk7_Camo_F","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"GBR MTP Gruppenfuehrer",
[["UK3CB_BAF_L85A2_EMAG","","","RKSL_optic_LDS",["UK3CB_BAF_556_30Rnd_T",30],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["UK3CB_BAF_L131A1","","","",["UK3CB_BAF_9_17Rnd",17],[],""],["UK3CB_BAF_U_CombatUniform_MTP_RM",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["UK3CB_BAF_9_17Rnd",2,17]]],["UK3CB_BAF_V_Osprey_Rifleman_C",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["UK3CB_BAF_556_30Rnd_T",6,30],["SmokeShell",4,1],["SmokeShellRed",2,1],["SmokeShellBlue",2,1],["HandGrenade",1,1],["KAT_Painkiller",1,10]]],["OPXT_multicam_1523",[["ACE_MapTools",1],["ACE_HuntIR_monitor",1]]],"UK3CB_BAF_H_Mk7_Camo_F","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"GBR MTP Marksman",
[["R3F_HK417L","","","optic_DMS",["R3F_20Rnd_762x51_TRACER_HK417",20],[],"R3F_BIPIED_HK417"],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["UK3CB_BAF_L131A1","","","",["UK3CB_BAF_9_17Rnd",17],[],""],["UK3CB_BAF_U_CombatUniform_MTP_RM",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["UK3CB_BAF_9_17Rnd",2,17]]],["UK3CB_BAF_V_Osprey_Marksman_A",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["SmokeShell",4,1],["SmokeShellRed",2,1],["SmokeShellBlue",2,1],["HandGrenade",1,1],["R3F_20Rnd_762x51_TRACER_HK417",6,20],["KAT_Painkiller",1,10]]],[],"UK3CB_BAF_H_Mk7_Camo_F","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"GBR MTP LMG Schuetze",
[["UK3CB_BAF_L110A2","","","",["UK3CB_BAF_556_200Rnd_T",200],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["UK3CB_BAF_L131A1","","","",["UK3CB_BAF_9_17Rnd",17],[],""],["UK3CB_BAF_U_CombatUniform_MTP_RM",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["UK3CB_BAF_9_17Rnd",2,17]]],["UK3CB_BAF_V_Osprey_MG_B",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["SmokeShell",2,1],["SmokeShellRed",1,1],["UK3CB_BAF_556_200Rnd_T",2,200],["KAT_Painkiller",1,10]]],[],"UK3CB_BAF_H_Mk7_Camo_F","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"GBR MTP Schuetze",
[["UK3CB_BAF_L85A2_EMAG","","","RKSL_optic_LDS",["UK3CB_BAF_556_30Rnd_T",30],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["UK3CB_BAF_L131A1","","","",["UK3CB_BAF_9_17Rnd",17],[],""],["UK3CB_BAF_U_CombatUniform_MTP_RM",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["UK3CB_BAF_9_17Rnd",2,17]]],["UK3CB_BAF_V_Osprey_Rifleman_C",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["UK3CB_BAF_556_30Rnd_T",6,30],["SmokeShell",4,1],["SmokeShellRed",2,1],["SmokeShellBlue",2,1],["HandGrenade",1,1],["KAT_Painkiller",1,10]]],[],"UK3CB_BAF_H_Mk7_Camo_F","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;





[
"US OCP AT Schuetze",
[["rhs_weap_m4a1_carryhandle_mstock","","RH_SFM952V","RH_ta31rmr",["rhs_mag_30Rnd_556x45_M855A1_Stanag",30],[],""],["launch_MRAWS_sand_rail_F","","","",["MRAWS_HEAT_F",1],[],""],["rhsusf_weap_m9","","","",["rhsusf_mag_15Rnd_9x19_FMJ",15],[],""],["rhs_uniform_cu_ocp",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["rhsusf_mag_15Rnd_9x19_FMJ",2,15]]],["rhsusf_iotv_ocp_Rifleman",[["ACE_packingBandage",5],["ACE_elasticBandage",5],["ACE_tourniquet",2],["SmokeShell",4,1],["rhs_mag_30Rnd_556x45_M855A1_Stanag",6,30],["SmokeShellBlue",2,1],["SmokeShellRed",2,1],["HandGrenade",1,1],["KAT_Painkiller",1,10]]],["rhsusf_assault_eagleaiii_ocp",[["MRAWS_HEAT_F",2,1]]],"rhsusf_ach_helmet_ocp","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"US OCP Combat Medic",
[["rhs_weap_m4a1_carryhandle","","RH_SFM952V","RH_ta31rmr",["rhs_mag_30Rnd_556x45_M855A1_Stanag",30],[],""],[],["rhsusf_weap_m9","","","",["rhsusf_mag_15Rnd_9x19_JHP",15],[],""],["rhs_uniform_cu_ocp",[["ACE_EarPlugs",2]]],["rhsusf_iotv_ocp_Medic",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["SmokeShell",3,1],["rhs_mag_30Rnd_556x45_M855A1_Stanag",6,30],["rhsusf_mag_15Rnd_9x19_FMJ",2,15],["KAT_Painkiller",1,10]]],["TAC_BP_Butt2_MTPM",[["KAT_Pulseoximeter",1],["KAT_guedel",2],["ACE_elasticBandage",10],["ACE_packingBandage",10],["ACE_salineIV_500",2],["ACE_epinephrine",5],["ACE_morphine",5],["adv_aceSplint_splint",2]]],"rhsusf_ach_helmet_ocp","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;
[
"US OCP Feldarzt",
[["rhs_weap_m4a1_carryhandle","","RH_SFM952V","RH_ta31rmr",["rhs_mag_30Rnd_556x45_M855A1_Stanag",30],[],""],[],["rhsusf_weap_m9","","","",["rhsusf_mag_15Rnd_9x19_JHP",15],[],""],["rhs_uniform_cu_ocp",[["ACE_EarPlugs",2]]],["rhsusf_iotv_ocp_Teamleader",[["ACE_packingBandage",5],["ACE_elasticBandage",5],["SmokeShell",3,1],["rhs_mag_30Rnd_556x45_M855A1_Stanag",6,30],["rhsusf_mag_15Rnd_9x19_FMJ",2,15],["KAT_Painkiller",1,10]]],["rhs_medic_bag",[["ACE_elasticBandage",10],["ACE_packingBandage",10],["ACE_epinephrine",5],["ACE_morphine",5],["KAT_Pulseoximeter",1],["KAT_guedel",2],["KAT_larynx",2],["adv_aceSplint_splint",2],["ACE_surgicalKit",1],["ACE_tourniquet",1],["KAT_Painkiller",2,10]]],"rhsusf_ach_helmet_headset_ess_ocp","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"US OCP Grenadier",
[["rhs_weap_m4a1_carryhandle_m203S","","RH_SFM952V","RH_ta31rmr",["rhs_mag_30Rnd_556x45_M855A1_Stanag",30],["1Rnd_SmokeRed_Grenade_shell",1],""],[],["rhsusf_weap_m9","","","",["rhsusf_mag_15Rnd_9x19_FMJ",15],[],""],["rhs_uniform_cu_ocp",[["ACE_tourniquet",1],["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["rhsusf_mag_15Rnd_9x19_FMJ",2,15]]],["rhsusf_iotv_ocp_Grenadier",[["ACE_packingBandage",5],["ACE_elasticBandage",5],["ACE_tourniquet",2],["SmokeShell",4,1],["SmokeShellBlue",2,1],["SmokeShellRed",2,1],["MiniGrenade",1,1],["rhs_mag_30Rnd_556x45_M855A1_Stanag",7,30],["KAT_Painkiller",1,10]]],["rhsusf_assault_eagleaiii_ocp",[["ACE_HuntIR_M203",2,1],["1Rnd_HE_Grenade_shell",15,1],["1Rnd_SmokeRed_Grenade_shell",5,1]]],"rhsusf_ach_helmet_ocp","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"US OCP Gruppenfuehrer",
[["rhs_weap_m4a1_carryhandle_mstock","","RH_SFM952V","RH_ta31rmr",["rhs_mag_30Rnd_556x45_M855A1_Stanag",30],[],""],[],["rhsusf_weap_m9","","","",["rhsusf_mag_15Rnd_9x19_FMJ",15],[],""],["rhs_uniform_cu_ocp",[["ACE_tourniquet",1],["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["rhsusf_mag_15Rnd_9x19_FMJ",2,15]]],["rhsusf_iotv_ocp_Teamleader",[["ACE_packingBandage",5],["ACE_elasticBandage",5],["ACE_tourniquet",2],["SmokeShellBlue",2,1],["SmokeShellRed",2,1],["SmokeShell",4,1],["HandGrenade",1,1],["rhs_mag_30Rnd_556x45_M855A1_Stanag",6,30],["SmokeShellGreen",1,1],["KAT_Painkiller",1,10]]],["OPXT_multicam_1523",[["ACE_HuntIR_monitor",1],["ACE_MapTools",1]]],"rhsusf_ach_helmet_ocp","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"US OCP Marksman",
[["rhs_weap_sr25_ec","","","optic_DMS",["rhsusf_20Rnd_762x51_SR25_m118_special_Mag",20],[],""],[],["rhsusf_weap_m9","","","",["rhsusf_mag_15Rnd_9x19_FMJ",15],[],""],["rhs_uniform_cu_ocp",[["ACE_tourniquet",1],["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["rhsusf_mag_15Rnd_9x19_FMJ",2,15]]],["rhsusf_iotv_ocp_Rifleman",[["ACE_packingBandage",5],["ACE_elasticBandage",5],["ACE_tourniquet",2],["SmokeShellBlue",2,1],["SmokeShellRed",2,1],["SmokeShell",4,1],["rhsusf_20Rnd_762x51_SR25_m118_special_Mag",4,20],["KAT_Painkiller",1,10]]],[],"rhsusf_ach_helmet_ocp","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"US OCP MG Schuetze",
[["rhs_weap_m249_pip_S_para","","","RH_compM2l",["rhsusf_200rnd_556x45_mixed_box",200],[],""],[],["rhsusf_weap_m9","","","",["rhsusf_mag_15Rnd_9x19_FMJ",15],[],""],["rhs_uniform_cu_ocp",[["ACE_tourniquet",1],["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["rhsusf_mag_15Rnd_9x19_FMJ",2,15]]],["rhsusf_iotv_ocp_SAW",[["ACE_packingBandage",5],["ACE_elasticBandage",5],["ACE_tourniquet",2],["SmokeShellBlue",2,1],["SmokeShellRed",2,1],["SmokeShell",4,1],["rhsusf_200rnd_556x45_mixed_box",2,200],["KAT_Painkiller",1,10]]],[],"rhsusf_ach_helmet_ocp","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"US OCP Schuetze",
[["rhs_weap_m4a1_carryhandle_mstock","","RH_SFM952V","RH_ta31rmr",["rhs_mag_30Rnd_556x45_M855A1_Stanag",30],[],""],[],["rhsusf_weap_m9","","","",["rhsusf_mag_15Rnd_9x19_FMJ",15],[],""],["rhs_uniform_cu_ocp",[["ACE_tourniquet",1],["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["rhsusf_mag_15Rnd_9x19_FMJ",2,15]]],["rhsusf_iotv_ocp_Rifleman",[["ACE_packingBandage",5],["ACE_elasticBandage",5],["ACE_tourniquet",2],["SmokeShellBlue",2,1],["SmokeShellRed",2,1],["SmokeShell",4,1],["HandGrenade",1,1],["rhs_mag_30Rnd_556x45_M855A1_Stanag",6,30],["KAT_Painkiller",1,10]]],[],"rhsusf_ach_helmet_ocp","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;




[
"US UCP AT Schuetze",
[["rhs_weap_m4a1_carryhandle_mstock","","RH_SFM952V","RH_ta31rmr",["rhs_mag_30Rnd_556x45_M855A1_Stanag",30],[],""],["launch_MRAWS_sand_rail_F","","","",["MRAWS_HEAT_F",1],[],""],["rhsusf_weap_m9","","","",["rhsusf_mag_15Rnd_9x19_FMJ",15],[],""],["rhs_uniform_cu_ucp",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["rhsusf_mag_15Rnd_9x19_FMJ",2,15]]],["rhsusf_iotv_ucp_Rifleman",[["ACE_packingBandage",5],["ACE_elasticBandage",5],["ACE_tourniquet",2],["SmokeShell",4,1],["rhs_mag_30Rnd_556x45_M855A1_Stanag",6,30],["SmokeShellBlue",2,1],["SmokeShellRed",2,1],["HandGrenade",1,1],["KAT_Painkiller",1,10]]],["rhsusf_assault_eagleaiii_ucp",[["MRAWS_HEAT_F",2,1]]],"rhsusf_ach_helmet_ucp","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"US UCP Combat Medic",
[["rhs_weap_m4a1_carryhandle","","RH_SFM952V","RH_ta31rmr",["rhs_mag_30Rnd_556x45_M855A1_Stanag",30],[],""],[],["rhsusf_weap_m9","","","",["rhsusf_mag_15Rnd_9x19_JHP",15],[],""],["rhs_uniform_cu_ucp",[["ACE_EarPlugs",2]]],["rhsusf_iotv_ucp_Medic",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["SmokeShell",3,1],["rhs_mag_30Rnd_556x45_M855A1_Stanag",6,30],["rhsusf_mag_15Rnd_9x19_FMJ",2,15],["KAT_Painkiller",1,10]]],["TAC_BP_Butt2ACUM",[["KAT_Pulseoximeter",1],["KAT_guedel",2],["ACE_elasticBandage",10],["ACE_packingBandage",10],["ACE_salineIV_500",2],["ACE_epinephrine",5],["ACE_morphine",5],["adv_aceSplint_splint",2]]],"rhsusf_ach_helmet_ucp","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"US UCP Feldarzt",
[["rhs_weap_m4a1_carryhandle","","RH_SFM952V","RH_ta31rmr",["rhs_mag_30Rnd_556x45_M855A1_Stanag",30],[],""],[],["rhsusf_weap_m9","","","",["rhsusf_mag_15Rnd_9x19_JHP",15],[],""],["rhs_uniform_cu_ucp",[["ACE_EarPlugs",2]]],["rhsusf_iotv_ucp_Teamleader",[["ACE_packingBandage",5],["ACE_elasticBandage",5],["ACE_tourniquet",2],["SmokeShell",3,1],["rhs_mag_30Rnd_556x45_M855A1_Stanag",6,30],["rhsusf_mag_15Rnd_9x19_FMJ",2,15],["KAT_Painkiller",1,10]]],["rhs_medic_bag",[["ACE_elasticBandage",10],["ACE_packingBandage",10],["ACE_epinephrine",5],["ACE_morphine",5],["KAT_Pulseoximeter",1],["KAT_guedel",2],["KAT_larynx",2],["ACE_tourniquet",1],["ACE_surgicalKit",1],["KAT_Painkiller",2,10]]],"rhsusf_ach_helmet_headset_ess_ucp","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"US UCP Grenadier",
[["rhs_weap_m4a1_carryhandle_m203S","","RH_SFM952V","RH_ta31rmr",["rhs_mag_30Rnd_556x45_M855A1_Stanag",30],["1Rnd_SmokeRed_Grenade_shell",1],""],[],["rhsusf_weap_m9","","","",["rhsusf_mag_15Rnd_9x19_FMJ",15],[],""],["rhs_uniform_cu_ucp",[["ACE_tourniquet",1],["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["rhsusf_mag_15Rnd_9x19_FMJ",2,15]]],["rhsusf_iotv_ucp_Grenadier",[["ACE_packingBandage",5],["ACE_elasticBandage",5],["ACE_tourniquet",2],["SmokeShell",4,1],["SmokeShellBlue",2,1],["SmokeShellRed",2,1],["MiniGrenade",1,1],["rhs_mag_30Rnd_556x45_M855A1_Stanag",7,30],["KAT_Painkiller",1,10]]],["rhsusf_assault_eagleaiii_ucp",[["ACE_HuntIR_M203",2,1],["1Rnd_HE_Grenade_shell",15,1],["1Rnd_SmokeRed_Grenade_shell",5,1]]],"rhsusf_ach_helmet_ucp","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"US UCP Gruppenfuehrer",
[["rhs_weap_m4a1_carryhandle_mstock","","RH_SFM952V","RH_ta31rmr",["rhs_mag_30Rnd_556x45_M855A1_Stanag",30],[],""],[],["rhsusf_weap_m9","","","",["rhsusf_mag_15Rnd_9x19_FMJ",15],[],""],["rhs_uniform_cu_ucp",[["ACE_tourniquet",1],["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["rhsusf_mag_15Rnd_9x19_FMJ",2,15]]],["rhsusf_iotv_ucp_Teamleader",[["ACE_packingBandage",5],["ACE_elasticBandage",5],["ACE_tourniquet",2],["SmokeShellBlue",2,1],["SmokeShellRed",2,1],["SmokeShell",4,1],["HandGrenade",1,1],["rhs_mag_30Rnd_556x45_M855A1_Stanag",6,30],["SmokeShellGreen",1,1],["KAT_Painkiller",1,10]]],["OPXT_at_au_1523",[["ACE_HuntIR_monitor",1],["ACE_MapTools",1]]],"rhsusf_ach_helmet_ucp","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"US UCP Marksman",
[["rhs_weap_sr25_ec","","","optic_DMS",["rhsusf_20Rnd_762x51_SR25_m118_special_Mag",20],[],""],[],["rhsusf_weap_m9","","","",["rhsusf_mag_15Rnd_9x19_FMJ",15],[],""],["rhs_uniform_cu_ucp",[["ACE_tourniquet",1],["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["rhsusf_mag_15Rnd_9x19_FMJ",2,15]]],["rhsusf_iotv_ucp_Rifleman",[["ACE_packingBandage",5],["ACE_elasticBandage",5],["ACE_tourniquet",2],["SmokeShellBlue",2,1],["SmokeShellRed",2,1],["SmokeShell",4,1],["rhsusf_20Rnd_762x51_SR25_m118_special_Mag",4,20],["KAT_Painkiller",1,10]]],[],"rhsusf_ach_helmet_ucp","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"US UCP MG Schuetze",
[["rhs_weap_m249_pip_S_para","","","RH_compM2l",["rhsusf_200rnd_556x45_mixed_box",200],[],""],[],["rhsusf_weap_m9","","","",["rhsusf_mag_15Rnd_9x19_FMJ",15],[],""],["rhs_uniform_cu_ucp",[["ACE_tourniquet",1],["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["rhsusf_mag_15Rnd_9x19_FMJ",2,15]]],["rhsusf_iotv_ucp_SAW",[["ACE_packingBandage",5],["ACE_elasticBandage",5],["ACE_tourniquet",2],["SmokeShellBlue",2,1],["SmokeShellRed",2,1],["SmokeShell",4,1],["rhsusf_200rnd_556x45_mixed_box",2,200],["KAT_Painkiller",1,10]]],[],"rhsusf_ach_helmet_ucp","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"US UCP Schuetze",
[["rhs_weap_m4a1_carryhandle_mstock","","RH_SFM952V","RH_ta31rmr",["rhs_mag_30Rnd_556x45_M855A1_Stanag",30],[],""],[],["rhsusf_weap_m9","","","",["rhsusf_mag_15Rnd_9x19_FMJ",15],[],""],["rhs_uniform_cu_ucp",[["ACE_tourniquet",1],["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["rhsusf_mag_15Rnd_9x19_FMJ",2,15]]],["rhsusf_iotv_ucp_Rifleman",[["ACE_packingBandage",5],["ACE_elasticBandage",5],["ACE_tourniquet",2],["SmokeShellBlue",2,1],["SmokeShellRed",2,1],["SmokeShell",4,1],["HandGrenade",1,1],["rhs_mag_30Rnd_556x45_M855A1_Stanag",6,30],["KAT_Painkiller",1,10]]],[],"rhsusf_ach_helmet_ucp","rhs_googles_clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;




[
"RF EMR AT Schuetze",
[["arifle_min_rf_aek_a545","","","optic_min_rf_eotech_553",["30Rnd_545x39_Mag_F",30],[],""],["launch_min_rf_RPG32","","","",["RPG32_F",1],[],""],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["min_rf_flora_officer",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["16Rnd_9x21_Mag",2,17]]],["min_rf_armor_vest_flora",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["Grenade_min_rf_rgd_5",2,1],["30Rnd_545x39_Mag_F",6,30],["SmokeShell",4,1],["SmokeShellRed",2,1],["SmokeShellBlue",2,1],["KAT_Painkiller",1,10]]],["min_rf_torna_flora",[["RPG32_F",2,1]]],"min_rf_helmet_soldier_flora","min_rf_balaclava_goggles_olive",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_fadak","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"RF EMR Combat Medic",
[["arifle_min_rf_aek_a545","","","optic_min_rf_eotech_553",["30Rnd_545x39_Mag_F",30],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["min_rf_flora_officer",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["16Rnd_9x21_Mag",2,17]]],["min_rf_armor_vest_flora",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["Grenade_min_rf_rgd_5",2,1],["rhssaf_mag_brd_m83_white",4,1],["rhssaf_mag_brd_m83_red",2,1],["rhssaf_mag_brd_m83_blue",2,1],["30Rnd_545x39_Mag_F",6,30],["KAT_Painkiller",1,10]]],["min_rf_torna_flora",[["ACE_elasticBandage",10],["ACE_epinephrine",5],["ACE_morphine",5],["KAT_guedel",2],["ACE_packingBandage",10],["KAT_Pulseoximeter",1],["ACE_salineIV_500",2],["adv_aceSplint_splint",2]]],"min_rf_helmet_soldier_flora","min_rf_balaclava_goggles_black",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_fadak","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"RF EMR Feldarzt",
[["arifle_min_rf_ak_12_grip","","","optic_min_rf_1p_87",["30Rnd_545x39_Mag_F",30],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["min_rf_flora_officer",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["16Rnd_9x21_Mag",2,17]]],["min_rf_highcapacity_special_flora",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["30Rnd_545x39_Mag_F",6,30],["Grenade_min_rf_rgd_5",2,1],["rhssaf_mag_brd_m83_white",4,1],["KAT_Painkiller",1,10]]],["rhs_medic_bag",[["ACE_elasticBandage",10],["ACE_epinephrine",5],["KAT_guedel",2],["KAT_larynx",2],["ACE_morphine",5],["ACE_packingBandage",5],["KAT_Pulseoximeter",1],["ACE_tourniquet",1],["ACE_surgicalKit",1],["adv_aceSplint_splint",2],["KAT_Painkiller",2,10]]],"min_rf_cap_flora","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_fadak","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"RF EMR Grenadier",
[["arifle_min_rf_ak_12_gp","","","optic_min_rf_1p_87",["30Rnd_545x39_Mag_F",30],["UGL_FlareRed_F",1],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["min_rf_flora_officer",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["16Rnd_9x21_Mag",2,17]]],["min_rf_armor_vest_GL_flora",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["Grenade_min_rf_rgd_5",2,1],["rhssaf_mag_brd_m83_white",4,1],["rhssaf_mag_brd_m83_red",2,1],["rhssaf_mag_brd_m83_blue",2,1],["30Rnd_545x39_Mag_F",6,30],["KAT_Painkiller",1,10]]],["min_rf_torna_flora",[["ACE_HuntIR_monitor",1],["1Rnd_HE_Grenade_shell",15,1],["ACE_HuntIR_M203",2,1],["UGL_FlareRed_F",5,1]]],"min_rf_helmet_soldier_flora","min_rf_balaclava_goggles_olive",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_fadak","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"RF EMR Gruppenfuehrer",
[["arifle_min_rf_ak_12_grip","","","optic_min_rf_1p_87",["30Rnd_545x39_Mag_F",30],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["min_rf_flora_officer",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["16Rnd_9x21_Mag",2,17]]],["min_rf_armor_vest_flora",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["30Rnd_545x39_Mag_F",6,30],["Grenade_min_rf_rgd_5",2,1],["rhssaf_mag_brd_m83_white",4,1],["rhssaf_mag_brd_m83_red",2,1],["rhssaf_mag_brd_m83_blue",2,1],["KAT_Painkiller",1,10]]],["TFAR_bussole",[["ACE_HuntIR_monitor",1],["ACE_MapTools",1]]],"min_rf_helmet_soldier_flora","min_rf_scarf_goggles_olive",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_fadak","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"RF EMR Marksman",
[["srifle_min_rf_vs_121","","","optic_min_rf_po_4x24_p",["ACE_10Rnd_762x54_Tracer_mag",10],[],"RH_HBLM"],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["min_rf_flora_officer",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["16Rnd_9x21_Mag",2,17]]],["min_rf_armor_vest_M_flora",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["Grenade_min_rf_rgd_5",2,1],["rhssaf_mag_brd_m83_white",4,1],["rhssaf_mag_brd_m83_red",2,1],["rhssaf_mag_brd_m83_blue",2,1],["ACE_10Rnd_762x54_Tracer_mag",6,10],["KAT_Painkiller",1,10]]],[],"min_rf_helmet_soldier_flora","min_rf_balaclava_goggles_olive",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_fadak","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"RF EMR MG Schuetze",
[["LMG_min_rf_6p69","","","",["ACE_150Rnd_762x54_Box_red",150],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["min_rf_flora",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["16Rnd_9x21_Mag",2,17]]],["min_rf_armor_vest_AR_flora",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["rhssaf_mag_brd_m83_white",3,1],["ACE_150Rnd_762x54_Box_red",2,150],["SmokeShellBlue",1,1],["SmokeShellRed",1,1],["KAT_Painkiller",1,10]]],[],"min_rf_helmet_soldier_flora","min_rf_scarf_goggles_olive",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_fadak","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"RF EMR Panzerbesatzung",
[["SMG_min_rf_pp_2000","","","optic_min_rf_ekp_8_18",["20Rnd_min_rf_9x19_T_Mag",20],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["min_rf_flora_officer",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["16Rnd_9x21_Mag",2,17]]],["min_rf_highcapacity_special_flora",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["Grenade_min_rf_rgd_5",2,1],["rhssaf_mag_brd_m83_white",4,1],["20Rnd_min_rf_9x19_T_Mag",6,20],["KAT_Painkiller",1,10]]],[],"min_rf_helmet_crew","PBW_RevisionF_klar",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_fadak","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"RF EMR Schuetze",
[["arifle_min_rf_ak_12_grip","","","optic_min_rf_1p_87",["30Rnd_545x39_Mag_F",30],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["min_rf_flora_officer",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["16Rnd_9x21_Mag",2,17]]],["min_rf_armor_vest_flora",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["30Rnd_545x39_Mag_F",6,30],["Grenade_min_rf_rgd_5",2,1],["rhssaf_mag_brd_m83_white",4,1],["rhssaf_mag_brd_m83_red",2,1],["rhssaf_mag_brd_m83_blue",2,1],["KAT_Painkiller",1,10]]],[],"min_rf_helmet_soldier_flora","min_rf_balaclava_goggles_olive",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_fadak","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"RF Pilot",
[[],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["min_rf_pilot_overall",[["ACE_EarPlugs",2],["ACE_elasticBandage",5],["ACE_tourniquet",2],["ACE_packingBandage",5],["16Rnd_9x21_Mag",2,17],["KAT_Painkiller",1,10]]],[],[],"min_rf_helmet_ace","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_fadak","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;




[
"RF Surpad AT Schuetze",
[["arifle_min_rf_aek_a545","","","optic_min_rf_eotech_553",["30Rnd_545x39_Mag_F",30],[],""],["launch_min_rf_RPG32","","","",["RPG32_F",1],[],""],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["min_rf_surpat_officer",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["16Rnd_9x21_Mag",2,17]]],["min_rf_armor_vest_surpat",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["Grenade_min_rf_rgd_5",2,1],["30Rnd_545x39_Mag_F",6,30],["SmokeShell",4,1],["SmokeShellRed",2,1],["SmokeShellBlue",2,1],["KAT_Painkiller",1,10]]],["min_rf_torna_surpat",[["RPG32_F",2,1]]],"min_rf_helmet_soldier_surpat","min_rf_balaclava_goggles_black",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_fadak","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"RF Surpad Combat Medic",
[["arifle_min_rf_aek_a545","","","optic_min_rf_eotech_553",["30Rnd_545x39_Mag_F",30],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["min_rf_surpat_officer",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["16Rnd_9x21_Mag",2,17]]],["min_rf_armor_vest_surpat",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["Grenade_min_rf_rgd_5",2,1],["rhssaf_mag_brd_m83_white",4,1],["rhssaf_mag_brd_m83_red",2,1],["rhssaf_mag_brd_m83_blue",2,1],["30Rnd_545x39_Mag_F",6,30],["KAT_Painkiller",1,10]]],["min_rf_torna_surpat",[["ACE_elasticBandage",10],["ACE_epinephrine",5],["ACE_morphine",5],["KAT_guedel",2],["ACE_packingBandage",10],["KAT_Pulseoximeter",1],["ACE_salineIV_500",2],["adv_aceSplint_splint",2]]],"min_rf_helmet_soldier_surpat","min_rf_balaclava_goggles_black",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_fadak","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"RF Surpad Feldarzt",
[["arifle_min_rf_ak_12_grip","","","optic_min_rf_1p_87",["30Rnd_545x39_Mag_F",30],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["min_rf_surpat_officer",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["16Rnd_9x21_Mag",2,17]]],["min_rf_highcapacity_special_surpat",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["30Rnd_545x39_Mag_F",6,30],["Grenade_min_rf_rgd_5",2,1],["rhssaf_mag_brd_m83_white",4,1],["KAT_Painkiller",1,10]]],["rhs_medic_bag",[["ACE_elasticBandage",10],["ACE_epinephrine",5],["KAT_guedel",2],["KAT_larynx",2],["ACE_morphine",5],["ACE_packingBandage",5],["KAT_Pulseoximeter",1],["ACE_tourniquet",1],["ACE_surgicalKit",1],["adv_aceSplint_splint",2],["KAT_Painkiller",2,10]]],"min_rf_cap_surpat","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_fadak","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"RF Surpad Grenadier",
[["arifle_min_rf_ak_12_gp","","","optic_min_rf_1p_87",["30Rnd_545x39_Mag_F",30],["UGL_FlareRed_F",1],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["min_rf_surpat_officer",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["16Rnd_9x21_Mag",2,17]]],["min_rf_armor_vest_GL_surpat",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["Grenade_min_rf_rgd_5",2,1],["rhssaf_mag_brd_m83_white",4,1],["rhssaf_mag_brd_m83_red",2,1],["rhssaf_mag_brd_m83_blue",2,1],["30Rnd_545x39_Mag_F",6,30],["KAT_Painkiller",1,10]]],["min_rf_torna_surpat",[["ACE_HuntIR_monitor",1],["1Rnd_HE_Grenade_shell",15,1],["ACE_HuntIR_M203",2,1],["UGL_FlareRed_F",5,1]]],"min_rf_helmet_soldier_surpat","min_rf_balaclava_goggles_black",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_fadak","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"RF Surpad Gruppenfuehrer",
[["arifle_min_rf_ak_12_grip","","","optic_min_rf_1p_87",["30Rnd_545x39_Mag_F",30],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["min_rf_surpat_officer",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["16Rnd_9x21_Mag",2,17]]],["min_rf_armor_vest_surpat",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["30Rnd_545x39_Mag_F",6,30],["Grenade_min_rf_rgd_5",2,1],["rhssaf_mag_brd_m83_white",4,1],["rhssaf_mag_brd_m83_red",2,1],["rhssaf_mag_brd_m83_blue",2,1],["KAT_Painkiller",1,10]]],["TFAR_bussole",[["ACE_HuntIR_monitor",1],["ACE_MapTools",1]]],"min_rf_helmet_soldier_surpat","min_rf_scarf_goggles_black",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_fadak","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"RF Surpad Marksman",
[["srifle_min_rf_vs_121","","","optic_min_rf_po_4x24_p",["ACE_10Rnd_762x54_Tracer_mag",10],[],"RH_HBLM"],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["min_rf_surpat_officer",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["16Rnd_9x21_Mag",2,17]]],["min_rf_armor_vest_M_surpat",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["Grenade_min_rf_rgd_5",2,1],["rhssaf_mag_brd_m83_white",4,1],["rhssaf_mag_brd_m83_red",2,1],["rhssaf_mag_brd_m83_blue",2,1],["ACE_10Rnd_762x54_Tracer_mag",6,10],["KAT_Painkiller",1,10]]],[],"min_rf_helmet_soldier_surpat","min_rf_balaclava_goggles_black",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_fadak","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"RF Surpad MG Schuetze",
[["LMG_min_rf_6p69","","","",["ACE_150Rnd_762x54_Box_red",150],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["min_rf_surpat",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["16Rnd_9x21_Mag",2,17]]],["min_rf_armor_vest_AR_surpat",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["rhssaf_mag_brd_m83_white",3,1],["SmokeShellBlue",1,1],["SmokeShellRed",1,1],["ACE_150Rnd_762x54_Box_red",2,150],["KAT_Painkiller",1,10]]],[],"min_rf_helmet_soldier_surpat","min_rf_scarf_goggles_black",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_fadak","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"RF Surpad Panzerbesatzung",
[["SMG_min_rf_pp_2000","","","optic_min_rf_ekp_8_18",["20Rnd_min_rf_9x19_T_Mag",20],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["min_rf_surpat_officer",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["16Rnd_9x21_Mag",2,17]]],["min_rf_highcapacity_special_surpat",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["Grenade_min_rf_rgd_5",2,1],["rhssaf_mag_brd_m83_white",4,1],["20Rnd_min_rf_9x19_T_Mag",6,20],["KAT_Painkiller",1,10]]],[],"min_rf_helmet_crew_surpat","PBW_RevisionF_klar",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_fadak","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;

[
"RF Surpad Schuetze",
[["arifle_min_rf_ak_12_grip","","","optic_min_rf_1p_87",["30Rnd_545x39_Mag_F",30],[],""],["UK3CB_BAF_Javelin_Slung_Tube","","","",[],[],""],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["min_rf_surpat_officer",[["ACE_EarPlugs",2],["ACE_EntrenchingTool",1],["16Rnd_9x21_Mag",2,17]]],["min_rf_armor_vest_surpat",[["ACE_elasticBandage",5],["ACE_packingBandage",5],["ACE_tourniquet",2],["30Rnd_545x39_Mag_F",6,30],["Grenade_min_rf_rgd_5",2,1],["rhssaf_mag_brd_m83_white",4,1],["rhssaf_mag_brd_m83_red",2,1],["rhssaf_mag_brd_m83_blue",2,1],["KAT_Painkiller",1,10]]],[],"min_rf_helmet_soldier_surpat","min_rf_balaclava_goggles_black",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_fadak","ItemCompass","ItemWatch",""]]
] call ace_arsenal_fnc_addDefaultLoadout;





	
}] call CBA_fnc_addEventHandler;














//Serveronly
if (!isServer and !isDedicated) exitWith {};


call gf_scripts_fnc_initQuadCargo;



["GF_MakeUnitCurator", {
    params ["_target","_causer"];
    [_target,_causer] call GF_fnc_p_makeUnitCurator;
}] call CBA_fnc_addEventHandler;



["GF_AddonCheckServer", {
    params ["_configs","_playername"];

    private _AA = "(toLower (configName _x)) find ""a3"" != 0 && (toLower (configName _x)) find ""jsrs"" != 0" configClasses (configFile >> "CfgPatches");
	private _serverConfigs = _AA apply {configName _x} ; //bux

    [str (_configs - _serverConfigs), str ["Loaded extra addons",_playername], [false, true, false]] call CBA_fnc_debug;
    [str ( _serverConfigs - _configs ), str ["Loaded missing addons",_playername], [false, true, false]] call CBA_fnc_debug;
}] call CBA_fnc_addEventHandler;



