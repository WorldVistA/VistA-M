RORHDT01 ;HCIOFO/SG - HISTORICAL DATA EXTRACTION STATUS ; 12/21/05 3:41pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** DISPLAYS THE LATEST TASK LOG
 ;
 ; HDEIEN        Data Extract IEN
 ; TASKIEN       Task IEN
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
LOG(HDEIEN,TASKIEN) ;
 N BY,FIC,FR,IENS,INFO,IOP,L,LOGIEN,RC,TASK,TO
 ;--- Get the task number
 S TASK=$$TASKNUM^RORHDTUT(HDEIEN,TASKIEN)
 Q:TASK<0 TASK
 I 'TASK  D  Q 0
 . W !!,"Sorry. It appears that this task has not been run."
 ;--- Get the task info (Log IEN, in particular)
 S RC=$$TASKINFO^RORTSK02(TASK,.INFO,"E")  Q:RC<0 RC
 S LOGIEN=+$G(INFO(12))
 ;--- Print the log
 I LOGIEN>0,$D(^RORDATA(798.7,LOGIEN))  D
 . S L=0,DIC=798.7
 . S BY="NUMBER;@,4,.01;@",FLDS="[ROR LOG]"
 . S (FR,TO)=LOGIEN
 . W !  D EN1^DIP
 E  W !!,"Sorry. The log is not available."
 Q 0
 ;
 ;***** DISPLAYS DATA EXTRACTION STATUS
 ;
 ; HDEIEN        Data Extract IEN
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
STATUS(HDEIEN) ;
 N I,IENS,REGLST,RORBUF,RORMSG,TMP
 ;--- Get values from the main record
 S IENS=(+HDEIEN)_","
 D GETS^DIQ(799.6,IENS,".01;.03;.04;2;3*","EI","RORBUF","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,799.6,IENS)
 ;--- Compile the list of registries
 S (I,REGLST)=""
 F  S I=$O(RORBUF(799.63,I))  Q:I=""  D
 . S TMP=$G(RORBUF(799.63,I,.01,"E"))
 . S:TMP'="" REGLST=REGLST_", "_TMP
 ;--- Display the data extraction information
 W !
 W !,"Name:       ",RORBUF(799.6,IENS,.01,"E")
 W !,"Registries: ",$P(REGLST,", ",2,999)
 W !,"Date Range: ",$G(RORBUF(799.6,IENS,.03,"E"))
 W " -- ",$G(RORBUF(799.6,IENS,.04,"E"))
 W !,"Output Dir: ",$G(RORBUF(799.6,IENS,2,"E")),!
 ;--- Display the task list
 Q $$TASKLIST^RORHDTUT(HDEIEN)
