
ACTION MapInputs:

	FOR index := 0 TO MAI_CONVEYORS DO
		conveyor[index].io.diPhotoeye1 := io.conveyor[index].diPhotoeyeEntrance;
		conveyor[index].io.diPhotoeye2 := io.conveyor[index].diPhotoeyeExit;
	END_FOR 

END_ACTION
