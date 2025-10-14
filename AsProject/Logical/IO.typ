
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
	Task_typ : 	STRUCT 
		status : Task_Status_typ;
	END_STRUCT;
	Task_Status_typ : 	STRUCT 
		zone : ARRAY[0..MAI_CONVEYORS]OF Zone_type;
	END_STRUCT;
	Zone_type : 	STRUCT 
		zoneBusy : BOOL;
		startOfZone_ : BOOL;
		startOfZone : BOOL;
		endOfZone_ : BOOL;
		endOfZone : BOOL;
		overrun : TON := (PT:=T#500ms);
	END_STRUCT;
END_TYPE
