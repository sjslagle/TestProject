
TYPE
	IO_Pusher_typ : 	STRUCT 
		aoActualPosition : REAL;
		diPusherExtended : BOOL;
		diPusherRetracted : BOOL;
	END_STRUCT;
	IO_typ : 	STRUCT 
		conveyor : ARRAY[0..MAI_CONVEYORS]OF IO_Conveyor_typ;
		spawnCase : BOOL;
		pusher : IO_Pusher_typ;
	END_STRUCT;
	IO_Conveyor_typ : 	STRUCT 
		diPhotoeyeEntrance : BOOL;
		diPhotoeyeExit : BOOL;
		doRunForward : BOOL;
		doRunReverse : BOOL;
		aoRunSpeed : REAL;
	END_STRUCT;
END_TYPE
