maxScreenShotFolderSizeMB = 2000000; // 2 TB;

pos = [9212.26, 20062.9, 0.00376892]; 
radius = 15; 
initialPos = 20;
playerHeight = 1.8; 
zRotation = [[0.985, -0.174, 0], [0.174, 0.985, 0], [0, 0, 1]];
yRotation = [[0.985, 0, 0.174], [0, 1, 0], [-0.174,0, 0.985]];
 
veh = "B_MBT_01_cannon_F" createVehicle pos; 
 
camPos = [pos select 0, (pos select 1)+initialPos, (pos select 2)+playerHeight]; 
camera = "camera" camCreate camPos; 
camera cameraEffect ["internal", "back"]; 
camera camSetTarget veh; 
camera camCommit 1;

for "_d" from 0 to (5) do {
	d=_d; 
	for "_ex" from 0 to (2) do { 
		x=_ex;
		for "_z" from 0 to (2) do {
			sleep 2;
			screenshot (["B_MBT_01_cannon_F__",str (d),"-",str (x),"-",str (_z),".png"] joinString "");
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