
TYPE
	State_enum : 
		(
		IDLE,
		WAITING_FOR_PACKAGE,
		HAS_PACKAGE,
		READY_TO_SEND_PACKAGE
		);
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
