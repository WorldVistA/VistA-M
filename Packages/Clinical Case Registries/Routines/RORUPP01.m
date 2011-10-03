RORUPP01 ;HCIOFO/SG - PATIENT EVENTS (ERRORS)  ; 1/20/06 1:55pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; RORUPD("LM2",         Static list of registries must be defined
 ;   Registry#)          if you are going to use these functions.
 ;
 ; RORUPD("MAXPPCNT")    This node should have a positive value if
 ;                       you are going to use these functions.
 ;                       Otherwise, 14 will be used by default.
 ;
 ; See source code of the ^RORUPD routine for detailed description
 ; of these nodes.
 ;
 Q
 ;
 ;***** ADDS THE REFERENCES TO THE LIST
 ;
 ; PATIEN        Patient IEN
 ; DATE          Date to start next registry update
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
ADD(PATIEN,DATE) ;
 N I,IENS,MAXCNT,RC,REGIEN,RORBUF,RORFDA,RORIEN,RORMSG,TMP,URLST
 S MAXCNT=$$MAXCNT()
 I $D(^RORDATA(798.3,PATIEN,1,"B"))>1  S RC=0  D  Q:RC<0 RC
 . ;--- Get a list of existing patient error records
 . S IENS=","_PATIEN_",",I="I $D(RORUPD(""LM2"",+$P(^(0),U)))"
 . D LIST^DIC(798.31,IENS,"@;.01I;1I;2",,,,,"B",I,,"RORBUF","RORMSG")
 . I $G(DIERR)  D  Q
 . . S RC=$$DBS^RORERR("RORMSG",-9,,,798.31,IENS)
 . Q:'$G(RORBUF("DILIST",0))
 . ;--- Prepare FDA for records to update
 . S I=""
 . F  S I=$O(RORBUF("DILIST",2,I))  Q:I=""  D
 . . S REGIEN=+$G(RORBUF("DILIST","ID",I,.01))
 . . S URLST(REGIEN)=""
 . . Q:$G(RORBUF("DILIST","ID",I,2))'<MAXCNT
 . . S IENS=RORBUF("DILIST",2,I)_","_PATIEN_","
 . . S TMP=$G(RORBUF("DILIST","ID",I,1))
 . . S RORFDA(798.31,IENS,1)=$S(TMP&(TMP<DATE):TMP,1:DATE)
 . . S RORFDA(798.31,IENS,2)=$G(RORBUF("DILIST","ID",I,2))+1
 . Q:$D(RORFDA)<10
 . ;--- Update the records
 . D FILE^DIE("K","RORFDA","RORMSG")
 . S:$G(DIERR) RC=$$DBS^RORERR("RORMSG",-9,,,798.31)
 ;--- Prepare FDA for records to create
 S REGIEN="",I=1
 F  S REGIEN=$O(RORUPD("LM2",REGIEN))  Q:REGIEN=""  D
 . Q:$D(URLST(REGIEN))
 . S I=I+1,IENS="+"_I_",?+1,"
 . S RORFDA(798.31,IENS,.01)=REGIEN
 . S RORFDA(798.31,IENS,1)=DATE
 . S RORFDA(798.31,IENS,2)=1
 ;--- Create the records
 I $D(RORFDA)>1  S RC=0  D  Q:RC<0 RC
 . S (RORFDA(798.3,"?+1,",.01),RORIEN(1))=PATIEN
 . D UPDATE^DIE(,"RORFDA","RORIEN","RORMSG")
 . S:$G(DIERR) RC=$$DBS^RORERR("RORMSG",-9,,,798.31)
 Q 0
 ;
 ;***** RETURNS THE THRESHOLD VALUE OF THE ERROR COUNTER
MAXCNT() ;
 Q $S($G(RORUPD("MAXPPCNT"))>0:+RORUPD("MAXPPCNT"),1:14)
 ;
 ;***** REMOVES THE REFERNCES FROM THE LIST
 ;
 ; PATIEN        Patient IEN
 ; [ROR8LST]     Closed root of an array containg list of registry
 ;               IENs as subscripts. $NA(RORUPD("LM2")) is used
 ;               by default. Only records associated with these
 ;               registries will be removed.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
REMOVE(PATIEN,ROR8LST) ;
 Q:$D(^RORDATA(798.3,PATIEN,1,"B"))<10 0
 N I,IENS,RC,RORBUF,RORFDA,RORMSG
 S:$G(ROR8LST)="" ROR8LST=$NA(RORUPD("LM2"))
 S IENS=","_PATIEN_",",I="I $D(@ROR8LST@(+$P(^(0),U)))"
 D LIST^DIC(798.31,IENS,"@",,,,,"B",I,,"RORBUF","RORMSG")
 I $G(DIERR)  D  Q RC
 . S RC=$$DBS^RORERR("RORMSG",-9,,,798.31,IENS)
 Q:'$G(RORBUF("DILIST",0)) 0
 S I=""
 F  S I=$O(RORBUF("DILIST",2,I))  Q:I=""  D
 . S IENS=RORBUF("DILIST",2,I)_","_PATIEN_","
 . S RORFDA(798.31,IENS,.01)="@"
 D FILE^DIE("K","RORFDA","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,798.31)
 Q 0
 ;
 ;***** RETURNS START DATE FOR THE DATA SCAN (IF ANY)
 ;
 ; PATIEN        Patient IEN
 ;
 ; Return Values:
 ;       <0  Error code
 ;       ""  There is no date for the patient in the file
 ;       >0  Start date
 ;
SDSDATE(PATIEN) ;
 Q:$D(^RORDATA(798.3,PATIEN,1,"B"))<10 ""
 N CNT,DATE,I,IENS,MAXCNT,RC,RORBUF,RORMSG,TMP
 ;--- Load the pending references (in chronological order)
 S IENS=","_PATIEN_",",I="I $D(RORUPD(""LM2"",+$P(^(0),U)))"
 D LIST^DIC(798.31,IENS,"@;1I;2",,,,,"AD",I,,"RORBUF","RORMSG")
 I $G(DIERR)  D  Q RC
 . S RC=$$DBS^RORERR("RORMSG",-9,,,798.31,IENS)
 Q:'$G(RORBUF("DILIST",0)) ""
 ;--- Get and return the earliest date
 S MAXCNT=$$MAXCNT()
 S (DATE,I)="",CNT=0
 F  S I=$O(RORBUF("DILIST","ID",I))  Q:I=""  D  Q:CNT&DATE
 . S:$G(RORBUF("DILIST","ID",I,2))<MAXCNT CNT=CNT+1
 . S:'DATE DATE=$G(RORBUF("DILIST","ID",I,1))
 Q $S('CNT:$$ERROR^RORERR(-66,,,PATIEN),1:DATE)
