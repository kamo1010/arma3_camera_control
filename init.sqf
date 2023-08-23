maxScreenShotFolderSizeMB = 2000000; // 2 TB;

pos = [9212.26, 20062.9, 0.00376892]; 
radius = 15; 
initialPos = 20;
playerHeight = 1.8; 
zRotation = [[0.985, -0.174, 0], [0.174, 0.985, 0], [0, 0, 1]];
yRotation = [[0.985, 0, 0.174], [0, 1, 0], [-0.174,0, 0.985]];

fullsnap = {
	params ["_name", "_time"];
	n = _name;
	t = _time;
	for "_d" from 0 to (0) do {
		d=_d; 
		for "_ex" from 0 to (0) do { 
			x=_ex;
			for "_z" from 0 to (0) do {
				sleep 2;
				screenshot ([n,"_",t,"_",str (d),"-",str (x),"-",str (_z),".png"] joinString "");
				vehPos = getPos veh;
				camPos = getPos camera;
				_pvVector = [[(camPos select 0)-(vehPos select 0)], [(camPos select 1)-(vehPos select 1)], [(camPos select 2)-(vehPos select 2)]];
				pos = zRotation matrixMultiply _pvVector;
				camera camSetPos [((pos select 0) select 0)+(vehPos select 0), ((pos select 1) select 0)+(vehPos select 1), ((pos select 2) select 0)+(vehPos select 2)];
				camera camCommit 1;
			};
			vehPos = getPos veh;
			camPos = getPos camera;
			_pvVector = [[(camPos select 0)-(vehPos select 0)], [(camPos select 1)-(vehPos select 1)], [(camPos select 2)-(vehPos select 2)]];
			pos = yRotation matrixMultiply _pvVector;
			camera camSetPos [((pos select 0) select 0)+(vehPos select 0), ((pos select 1) select 0)+(vehPos select 1), ((pos select 2) select 0)+(vehPos select 2)];
			camera camCommit 1;
		};
		camPos = getPos camera;
		camera camSetPos [(camPos select 0), (camPos select 1)+radius, (camPos select 2)];
		camera camCommit 1;
	};
};

snap_at_day = {
	params ["_name"];
	n = _name;
	setDate [2023, 6, 15, 14, 15];
	camera camSetPos [9212.26, 20062.9+initialPos, 0.00376892+playerHeight]; 
	camera camCommit 1;
	[n, "day"] call fullsnap;

	// set the rain
	0 setRain 0.5; 
	camera camSetPos [9212.26, 20062.9+initialPos, 0.00376892+playerHeight]; 
	camera camCommit 1;
	[n, "day"] call fullsnap;
	0 setRain 0;

	// let there be fog
	0 setFog 0.7;
	camera camSetPos [9212.26, 20062.9+initialPos, 0.00376892+playerHeight]; 
	camera camCommit 1;
	[n, "day"] call fullsnap;
	0 setFog 0;

	// let it snow let it snow let it snow
	0 setOvercast 1;
	0 setRain 1;
	0 setFog 0.1;
	setHUmidity 0.9;
	enableEnvironment [false, true];
	forceWeatherChange;
	camera camSetPos [9212.26, 20062.9+initialPos, 0.00376892+playerHeight]; 
	camera camCommit 1;
	setRain ["a3\data_f\rainnormal_ca.paa", 1, 0.01, 15, 0.1, 2, 0.5, 0.5, 0.05, 0.05, [0.3, 0.3, 0.3, 1], 0.1, 0.1, 5.5, 0.3, true, false];
	[n, "day"] call fullsnap;
	0 setOvercast 0;
	0 setRain 0;
	0 setFog 0;
	setHUmidity 0;
	forceWeatherChange;
};

snap_at_night = {
	params ["_name"];
	n = _name;
	setDate [2023, 6, 15, 19, 15];
	camera camSetPos [9212.26, 20062.9+initialPos, 0.00376892+playerHeight]; 
	camera camCommit 1;
	[n, "night"] call fullsnap;

	// set the rain
	0 setRain 1;
	setHUmidity 0.9;
	enableEnvironment [false, true];
	forceWeatherChange;
	camera camSetPos [9212.26, 20062.9+initialPos, 0.00376892+playerHeight]; 
	camera camCommit 1;
	[n, "night"] call fullsnap;
	0 setRain 0;
	setHUmidity 0;
	forceWeatherChange;

	// let there be fog
	0 setFog 0.7;
	camera camSetPos [9212.26, 20062.9+initialPos, 0.00376892+playerHeight]; 
	camera camCommit 1;
	[n, "night"] call fullsnap;
	0 setFog 0;

	// let it snow let it snow let it snow
	0 setOvercast 1;
	0 setRain 1;
	0 setFog 0.1;
	setHUmidity 0.9;
	enableEnvironment [false, true];
	forceWeatherChange;
	camera camSetPos [9212.26, 20062.9+initialPos, 0.00376892+playerHeight]; 
	camera camCommit 1;
	setRain ["a3\data_f\rainnormal_ca.paa", 1, 0.01, 15, 0.1, 2, 0.5, 0.5, 0.05, 0.05, [0.3, 0.3, 0.3, 1], 0.1, 0.1, 5.5, 0.3, true, false];
	[n, "night"] call fullsnap;
	0 setOvercast 0;
	0 setRain 0;
	0 setFog 0;
	setHUmidity 0;
	forceWeatherChange;
};

cars = ["B_MBT_01_cannon_F", "B_SAM_System_02_F", "B_Radar_System_01_F", "B_MBT_01_cannon_F"];

veh = "B_MBT_01_cannon_F" createVehicle pos;
camPos = [pos select 0, (pos select 1)+initialPos, (pos select 2)+playerHeight]; 
camera = "camera" camCreate camPos; 
camera cameraEffect ["internal", "back"]; 
camera camSetTarget veh; 
camera camCommit 1;
"B_MBT_01_cannon_F" call snap_at_day;
// at night
"B_MBT_01_cannon_F" call snap_at_night;
camera cameraEffect ["terminate","back"];
camDestroy camera;
deleteVehicle veh;

pos = [9212.26, 20062.9, 0.00376892]; 
veh = "B_SAM_System_02_F" createVehicle pos;
camPos = [pos select 0, (pos select 1)+initialPos, (pos select 2)+playerHeight]; 
camera = "camera" camCreate camPos; 
camera cameraEffect ["internal", "back"]; 
camera camSetTarget veh; 
camera camCommit 1;
"B_SAM_System_02_F" call snap_at_day;
// at night
"B_SAM_System_02_F" call snap_at_night;
camera cameraEffect ["terminate","back"];
camDestroy camera;
deleteVehicle veh;