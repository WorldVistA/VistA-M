RORHDT ;HCIOFO/SG - HISTORICAL DATA EXTRACTION ; 3/14/06 10:54am
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 ; RORHDT -------------- HISTORICAL DATA EXTRACTION DESCRIPTOR
 ;
 ; RORHDT("BHS")         If this node has a non-zero value, the
 ;                       $$COMMIT^RORHDT05 function outputs a BHS
 ;                       segment before writing the data from the
 ;                       ^TMP("HLS",$J) node. Then it kills the
 ;                       RORHDT("BHS") node.
 ;
 ; See also descriptions of the ^TMP("RORHDT") node in the ^ROR01
 ; routine.
 ;
 Q
 ;
 ;***** (RE)CREATES A DATA EXTRACTION TASK TABLE
CREATE ;
 N RORERRDL      ; Default error location
 N RORERROR      ; Error processing data
 N RORPARM       ; Application parameters
 ;
 N HDEIEN,RC
 S RORPARM("ERR")=1
 ;S RORPARM("DEBUG")=2 ; Remove the first ';' to start in debug mode
 D CLEAR^RORERR("CREATE^RORHDT")
 ;--- Select a data extraction
 S HDEIEN=$$SELHDE^RORHDTUT()  G:HDEIEN<0 ERROR
 Q:'HDEIEN
 ;--- Request a confirmation
 S RC=$$CREATE^RORHDTAC(HDEIEN)
 I RC  G:RC<0 ERROR  Q
 ;--- Create a new task table
 S RC=$$CREATE^RORHDT02(HDEIEN)    G:RC<0 ERROR
 W:'RC !,"New task table has been created."
 Q
 ;
 ;***** EDITS THE EXTRACTION DEFINITION
EDITHDE ;
 N DA,DIE,DIDEL,DR,DTOUT,NATIONAL
 ;--- Select a data extraction
 S DA=$$SELHDE^RORHDTUT("A",,.NATIONAL)  G:DA<0 ERROR
 Q:'DA
 ;--- Edit the parameters
 S DIE=$$ROOT^DILFD(799.6)
 S DR="[RORHDT EDIT "_$S(NATIONAL:"NATIONAL EXTRACT]",1:"EXTRACTION]")
 W !  D ^DIE
 Q
 ;
 ;***** DISPLAYS THE ERRORS
ERROR ;
 D DSPSTK^RORERR()
 Q
 ;
 ;***** DISPLAYS THE LATEST LOG OF THE TASK
LOG ;
 N RORERRDL      ; Default error location
 N RORERROR      ; Error processing data
 N RORPARM       ; Application parameters
 ;
 N HDEIEN,POP,RC,TASKIEN
 S RORPARM("ERR")=1
 ;S RORPARM("DEBUG")=2 ; Remove the first ';' to start in debug mode
 D CLEAR^RORERR("LOG^RORHDT")
 ;--- Select data extraction and task
 S HDEIEN=$$SELHDE^RORHDTUT()           G:HDEIEN<0 ERROR
 Q:'HDEIEN
 S TASKIEN=$$SELTASK^RORHDTUT(HDEIEN)  G:TASKIEN<0 ERROR
 Q:'TASKIEN
 ;--- Display the log
 S RC=$$LOG^RORHDT01(HDEIEN,TASKIEN)        G:RC<0 ERROR
 Q
 ;
 ;***** STARTS A DATA EXTRACTION TASK
START ;
 N RORERRDL      ; Default error location
 N RORERROR      ; Error processing data
 N RORPARM       ; Application parameters
 ;
 N FAM,HDEIEN,RC,SDT,TASKIEN
 S RORPARM("ERR")=1
 ;S RORPARM("DEBUG")=2 ; Remove the first ';' to start in debug mode
 D CLEAR^RORERR("START^RORHDT")
 ;--- Select data extraction and task
 S HDEIEN=$$SELHDE^RORHDTUT()           G:HDEIEN<0 ERROR
 Q:'HDEIEN
 S TASKIEN=$$SELTASK^RORHDTUT(HDEIEN)  G:TASKIEN<0 ERROR
 Q:'TASKIEN
 ;--- Double-check the task status, and request confirmation(s)
 ;--- and start date/time for the task from the user
 S RC=$$START^RORHDTAC(HDEIEN,TASKIEN,.FAM,.SDT)
 I RC  G:RC<0 ERROR  Q
 ;--- Start the task
 S RC=$$START^RORHDT03(HDEIEN,TASKIEN,FAM,SDT)  G:RC<0 ERROR
 Q
 ;
 ;***** DISPLAYS DATA EXTRACTION STATUS
STATUS ;
 N RORERRDL      ; Default error location
 N RORERROR      ; Error processing data
 N RORPARM       ; Application parameters
 ;
 N DIR,HDEIEN,POP,RC,TMP
 S RORPARM("ERR")=1
 ;S RORPARM("DEBUG")=2 ; Remove the first ';' to start in debug mode
 D CLEAR^RORERR("STATUS^RORHDT")
 ;--- Select a data extraction
 S HDEIEN=$$SELHDE^RORHDTUT()  G:HDEIEN<0 ERROR
 Q:'HDEIEN
 ;--- Display status of the data extraction
 S RC=$$STATUS^RORHDT01(HDEIEN)
 W !  D PAGE^RORHDTUT(),^%ZISC     G:RC<0 ERROR
 Q
 ;
 ;***** STOPS A DATA EXTRACTION TASK
STOP ;
 N RORERRDL      ; Default error location
 N RORERROR      ; Error processing data
 N RORPARM       ; Application parameters
 ;
 N HDEIEN,RC,TASKIEN
 S RORPARM("ERR")=1
 ;S RORPARM("DEBUG")=2 ; Remove the first ';' to start in debug mode
 D CLEAR^RORERR("STOP^RORHDT")
 ;--- Select data extraction and task
 S HDEIEN=$$SELHDE^RORHDTUT()           G:HDEIEN<0 ERROR
 Q:'HDEIEN
 S TASKIEN=$$SELTASK^RORHDTUT(HDEIEN)  G:TASKIEN<0 ERROR
 Q:'TASKIEN
 ;--- Stop the task
 S RC=$$STOP^RORHDTAC(HDEIEN,TASKIEN)
 I RC  G:RC<0 ERROR  Q
 S RC=$$STOP^RORHDT03(HDEIEN,TASKIEN)       G:RC<0 ERROR
 Q
