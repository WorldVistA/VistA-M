IVMBULK2 ;ALB/KCL - IVM/ENROLLMENT Extract Utilities; 23-SEP-1997
 ;;2.0;INCOME VERIFICATION MATCH;**9**; 21-OCT-94
 ;
 ;
GET(IVMARRY) ; --
 ; Description: Used to obtain a record from the IVM Extract Management file into the local IVMARRY array.
 ;
 ; Input: None
 ;
 ; Output:
 ;   Function  Value - returns 1 if success, 0 if failure.
 ;   IVMARRY - this is the name of a local array, it should be passed by
 ;             reference. If the function is successful this array will
 ;             contain the record.
 ;
 ;     Subscript       Field Name
 ;     ==========      =======================
 ;     "HOST"          Host File Name
 ;     "DIR"           Directory
 ;     "PROC"          # of Patients Processed
 ;     "TASK"          Task Number
 ;     "START"         Date/Time Job Started
 ;     "STOP"          Date/Time Job Stopped
 ;     "TERM"          Job Terminated?
 ;     "LASTPAT"       Last Patient Processed
 ;     "PROJECT"       Projected Completion Date/Time
 ;     "EXTRACT"       # of Patients Extracted
 ;     "FILES"          Number of Host Files
 ;     "ERROR"         Error
 ;
 N NODE,SUCCESS
 S SUCCESS=0
 ;
 I '$D(^IVM(301.63,1,0)) G GETQ
 ;
 K IVMARRY S IVMARRY=""
 S NODE=$G(^IVM(301.63,1,0))
 ;
 S IVMARRY("HOST")=$P(NODE,"^")
 S IVMARRY("DIR")=$P(NODE,"^",2)
 S IVMARRY("PROC")=$P(NODE,"^",3)
 S IVMARRY("TASK")=$P(NODE,"^",4)
 S IVMARRY("START")=$P(NODE,"^",5)
 S IVMARRY("STOP")=$P(NODE,"^",6)
 S IVMARRY("TERM")=$P(NODE,"^",7)
 S IVMARRY("LASTPAT")=$P(NODE,"^",8)
 S IVMARRY("PROJECT")=$P(NODE,"^",9)
 S IVMARRY("EXTRACT")=$P(NODE,"^",10)
 S IVMARRY("FILES")=$P(NODE,"^",11)
 S NODE=$G(^IVM(301.63,1,10))
 S IVMARRY("ERROR")=$P(NODE,"^")
 ;
 S SUCCESS=1
 ;
GETQ Q SUCCESS
 ;
 ;
STORE(IVMARRY) ; --
 ; Description: Used to store the processing information for the
 ; execution of the initial extract in the IVM Extract Management file.
 ;
 ; Input:
 ;   IVMARRY - this is the name of a local array, it should be passed by
 ;             reference. This array should contain the processing
 ;             information to be stored. Missing subscripts will cause
 ;             the field to be deleted.  "HOST" is required.
 ;
 ;     Subscript       Field Name
 ;     ==========      =======================
 ;     "HOST"          Host File Name
 ;     "DIR"           Directory
 ;     "PROC"          # of Patients Processed
 ;     "TASK"          Task Number
 ;     "START"         Date/Time Job Started
 ;     "STOP"          Date/Time Job Stopped
 ;     "TERM"          Job Terminated?
 ;     "LASTPAT"       Last Patient Processed
 ;     "PROJECT"       Projected Completion Date/Time
 ;     "EXTRACT"       # of Patients Extracted
 ;     "FILES"          Number of Host Files
 ;     "ERROR"         Error
 ;
 ; Output:
 ;   Function  Value - returns 1 if success, 0 if failure.
 ;
 N SUCCESS
 S SUCCESS=1
 ;
 I $G(IVMARRY("HOST"))="" S SUCCESS=0 G STOREQ
 I '$D(^IVM(301.63,1,0)) D  G:('SUCCESS) STOREQ
 .S DATA(.01)=IVMARRY("HOST")
 .I '$$ADD^DGENDBS(301.63,,.DATA) S SUCCESS=0
 ;
 ;
 S DATA(.01)=IVMARRY("HOST")
 S DATA(.02)=$G(IVMARRY("DIR"))
 S DATA(.03)=$G(IVMARRY("PROC"))
 S DATA(.04)=$G(IVMARRY("TASK"))
 S DATA(.05)=$G(IVMARRY("START"))
 S DATA(.06)=$G(IVMARRY("STOP"))
 S DATA(.07)=$G(IVMARRY("TERM"))
 S DATA(.08)=$G(IVMARRY("LASTPAT"))
 S DATA(.09)=$G(IVMARRY("PROJECT"))
 S DATA(.1)=$G(IVMARRY("EXTRACT"))
 S DATA(.11)=$G(IVMARRY("FILES"))
 S DATA(10)=$G(IVMARRY("ERROR"))
 I '$$UPD^DGENDBS(301.63,1,.DATA) S SUCCESS=0
 ;
STOREQ Q SUCCESS
 ;
 ;
INIT(IVMARRY) ; --
 ; Description: Used to initilized IVM Extract Management record in the local IVMARRY array.
 ;
 ; Input: None
 ;
 ; Output:
 ;   Function  Value - returns 1 if success, 0 if failure.
 ;   IVMARRY - this is the name of a local array, it should be passed by
 ;             reference. If the function is successful this array will
 ;             contain the initialized record.
 ;
 ;     Subscript       Field Name
 ;     ==========      =======================
 ;     "HOST"          Host File Name
 ;     "DIR"           Directory
 ;     "PROC"          # of Patients Processed
 ;     "TASK"          Task Number
 ;     "START"         Date/Time Job Started
 ;     "STOP"          Date/Time Job Stopped
 ;     "TERM"          Job Terminated?
 ;     "LASTPAT"       Last Patient Processed
 ;     "PROJECT"       Projected Completion Date/Time
 ;     "EXTRACT"       # of Patients Extracted
 ;     "FILES"         Number of Host Files
 ;     "ERROR"         Error
 ;
 K IVMARRY S IVMARRY=""
 ;
 S IVMARRY("HOST")=""
 S IVMARRY("DIR")=""
 S IVMARRY("PROC")=""
 S IVMARRY("TASK")=""
 S IVMARRY("START")=""
 S IVMARRY("STOP")=""
 S IVMARRY("TERM")=""
 S IVMARRY("LASTPAT")=""
 S IVMARRY("PROJECT")=""
 S IVMARRY("EXTRACT")=""
 S IVMARRY("FILES")=""
 S IVMARRY("ERROR")=""
 ;
INITQ Q 1
 ;
 ;
PATH(IVMARRY) ; --
 ; Description: Ask user for for valid host file directory.
 ;
 ;  Input:
 ;   IVMARRY - a local array where the extract input parameters will be
 ;             stored, pass by reference
 ;
 ; Output:
 ;   Function Value - returns 1 if successful, 0 otherwise
 ;   IVMARRY("DIR") - directory
 ;
 N DIR,DTOUT,DUOUT,DIROUT,DIRUT,SUCCESS,Y
 ;
 S SUCCESS=0
 ;
 W !!,?15,"* * * * *  I M P O R T A N T  * * * * *"
 W !,?5,"The host files created by this job will be placed in the"
 W !,?5,"current working directory.  A directory other than the"
 W !,?5,"current working directory may also be selected."
 W !!,?5,"Please check the following to ensure the extract runs correctly."
 W !!,?10,"1) The directory you have chosen the extract to run in"
 W !,?13,"is a valid directory."
 W !!,?10,"2) In order for TaskMan to have access to the directory, the"
 W !,?13,"WORLD file protection must be 'RW' (Read and Write).  For"
 W !,?13,"NT/OpenM systems, ensure that the directory is not read only.",!
 ;
 ; ask directory
 S DIR("A")="Select Directory"
 S DIR("B")=$$PWD^%ZISH,DIR(0)="F^3:50"
 D ^DIR
 G:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)) PATHQ
 ;
 S IVMARRY("DIR")=Y
 S SUCCESS=1
 ;
PATHQ Q SUCCESS
 ;
 ;
GETCONST(IVMARRY) ; --
 ; Description: Places enrollment extract constants into the local IVMARRY array.
 ;
 ; Input: None
 ;
 ; Output:
 ;   Function  Value - returns 1 if success, 0 if failure.
 ;   IVMARRY - this is the name of a local array, it should be passed by
 ;             reference. If the function is successful this array will
 ;             contain the extract constants.
 ;
 ;     Subscript    Description
 ;     ==========   =======================
 ;     "BEGDT"      as begin date/time for extract search
 ;     "HOST"       as name of host file
 ;     "MAILGRP"    as HEC mail group for notification msg
 ;     "MSGMAX"     as maximum # of HL7 msgs each host file may contain
 ;     "PERCNT"     as # of patients expected to be extracted
 ;     "AVG100"     as average time to extract 100 patients in seconds
 ;     "SIZE"       as average size of single patient record in bytes
 ;
 ;
 K IVMARRY
 S IVMARRY=""
 ;
 S IVMARRY("BEGDT")=2951231.2359
 S IVMARRY("HOST")="HECHOST"_$P($$SITE^VASITE,"^",3)
 S IVMARRY("MAILGRP")="G.ENROLLMENT EXTRACT@IVM.VA.GOV"
 S IVMARRY("MSGMAX")=10000
 S IVMARRY("PERCNT")=31
 S IVMARRY("AVG100")=42
 S IVMARRY("SIZE")=1050
 ;
CONSTQ Q 1
 ;
 ;
INQUIRE(ROOT,IEN) ; --
 ; Description: Display data from file entry.
 ;
 ;  Input:
 ;    ROOT - global root of the file
 ;     IEN - IEN of file entry
 ;
 N DA,DIC
 ;
 S DIC=ROOT,DA=IEN
 D EN^DIQ
 Q
 ;
 ;
LOCK(IEN) ; --
 ; Description: This lock is used to prevent another process from editing
 ;     IVM Extract Management record.
 ;
 ;  Input:
 ;    IEN - Internal entry number of IVM EXTRACT MANAGEMENT file
 ;
 ; Output:
 ;  Function Value - Returns 1 if the lock was successful, 0 otherwise
 ;
 I $G(IEN) L +^IVM(IEN,301.63):10
 Q $T
 ;
 ;
UNLOCK(IEN) ; --
 ; Description: Used to release a lock created by $$LOCK.
 ;  Input:
 ;    IEN - Internal entry number of IVM EXTRACT MANAGEMENT file
 ;
 ; Output: None
 ;
 I $G(IEN) L -^IVM(IEN,301.63)
 Q
