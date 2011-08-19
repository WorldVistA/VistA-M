RORUPD51 ;HCIOFO/SG - UPDATE PATIENT'S DEMOGRAPHIC DATA (1) ; 7/6/06 11:15am
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 Q
 ;
 ;***** MARKS REGISTRIES (UPDATE DEMOGRAPHICS)
 ;
 ; PTIEN         Patient IEN
 ; [DOD]         Date of death
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
MARKREGS(PTIEN,DOD) ;
 N ACTIVE,ECNT,I,IENS,RC,RI,TMP
 N RORBUF,RORFDA,RORMSG,RORSRC
 ;--- Compile a list of associated registries
 D FIND^DIC(798,,"@","QUX",PTIEN,,"B",,,"RORBUF","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,PTIEN,798)
 ;--- Mark patient records of the registries
 S RI="",ECNT=0
 F  S RI=$O(RORBUF("DILIST",2,RI))  Q:RI=""  D  L -^RORDATA(798,+IENS)
 . S IENS=RORBUF("DILIST",2,RI)_","
 . K RORFDA,RORSRC
 . ;--- Try to lock the record; if this fails, continue anyway
 . L +^RORDATA(798,+IENS):3
 . ;--- Load the field values
 . D GETS^DIQ(798,IENS,"4;8","EI","RORSRC","RORMSG")
 . I $G(DIERR)  D  S ECNT=ECNT+1  Q
 . . S RC=$$DBS^RORERR("RORMSG",-9,,PTIEN,798,IENS)
 . S ACTIVE=+$G(RORSRC(798,IENS,8,"E"))
 . ;--- Do not mark again if already marked
 . I '$G(RORSRC(798,IENS,4,"I"))  S RC=0  D  Q:RC<0
 . . ;--- Mark only active records
 . . S:ACTIVE RORFDA(798,IENS,4)=1
 . ;--- Update registry data record
 . I $D(RORFDA)>1  S RC=0  D  Q:RC<0
 . . D FILE^DIE(,"RORFDA","RORMSG")
 . . I $G(DIERR)  D  S ECNT=ECNT+1
 . . . S RC=$$DBS^RORERR("RORMSG",-9,,PTIEN,798,IENS)
 Q $S(ECNT>0:-9,1:0)
 ;
 ;***** PROCESSES THE MERGED PATIENT RECORD
 ;
 ; DFN           IEN of the merged record (medrged from)
 ; NEWDFN        New patient IEN (merged to)
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  Ok
 ;
MERGE(DFN,NEWDFN) ;
 N DA,DIK,DTNEW,DTOLD,IEN,IENS,IR,PTIEN,REGIEN,REGLST,RORBUF,RORFDA,RORMSG,TMP
 D LOG^RORERR(-111,,,DFN,NEWDFN)
 ;=== Get the lists of registry records associated with the
 ;=== merged from ("from") and merged to ("to") patient data
 F PTIEN=DFN,NEWDFN  D  Q:RC<0
 . K RORBUF,RORMSG
 . D FIND^DIC(798,,"@;.02I;1I","QUX",PTIEN,,"B",,,"RORBUF","RORMSG")
 . I $G(DIERR)  S RC=$$DBS^RORERR("RORMSG",-9,,PTIEN,798)  Q
 . S IR=0
 . F  S IR=$O(RORBUF("DILIST",2,IR))  Q:IR'>0  D  Q:RC<0
 . . S IEN=+RORBUF("DILIST",2,IR)
 . . S REGIEN=+$G(RORBUF("DILIST","ID",IR,.02))
 . . I REGIEN'>0  S RC=$$ERROR^RORERR(-95,,,PTIEN,798,IEN_",",.02)  Q
 . . S TMP=+$G(RORBUF("DILIST","ID",IR,1))
 . . I TMP'>0  S RC=$$ERROR^RORERR(-95,,,PTIEN,798,IEN_",",1)  Q
 . . S REGLST(PTIEN,REGIEN)=IEN_U_TMP
 Q:RC<0 RC
 ;=== Compare the "from" and "to" registry records
 S REGIEN=0
 F  S REGIEN=$O(REGLST(DFN,REGIEN))  Q:REGIEN'>0  D
 . K RORFDA,RORMSG  S RC=0
 . S DTOLD=+$P(REGLST(DFN,REGIEN),U,2)
 . S DTNEW=+$P($G(REGLST(NEWDFN,REGIEN)),U,2)
 . I (DTNEW'>0)!(DTOLD<DTNEW)  D  Q:RC<0
 . . ;--- Make sure that the "to" patient has a record
 . . ;--- in the ROR PATIENT file.
 . . S RC=$$ADDPDATA^RORUPD50(NEWDFN)  Q:RC<0
 . . ;--- Replace the .01 value in the "from" registry record with
 . . ;    the new patient pointer since there is either no other
 . . ;--- record for this patient or it is newer than the "from" one.
 . . S IENS=+$P(REGLST(DFN,REGIEN),U)_","
 . . S RORFDA(798,IENS,.01)=NEWDFN
 . . D FILE^DIE(,"RORFDA","RORMSG")
 . . I $G(DIERR)  S RC=$$DBS^RORERR("RORMSG",-9,,DFN,798,IENS)  Q
 . . ;--- Delete the "to" registry record. It was created after
 . . ;--- the original ("from") one and we should keep the latter.
 . . S DA=+$P($G(REGLST(NEWDFN,REGIEN)),U)
 . . I DA>0  S DIK=$$ROOT^DILFD(798)  D ^DIK
 . E  D
 . . ;--- Delete the "from" registry record since
 . . ;--- the "to" record is actually older
 . . S DIK=$$ROOT^DILFD(798),DA=+$P(REGLST(DFN,REGIEN),U)  D ^DIK
 . ;--- Indicate successful merge
 . K REGLST(DFN,REGIEN)
 ;=== Done
 Q 0
 ;
 ;***** SCANS PATIENTS AND UPDATES DEMOGRAPHIC DATA (IF NECESSARY)
 ;
 ; .REGLST       Reference to a local array containing
 ;               registry names as subscripts
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
UPDDEM(REGLST) ;
 N CNT,IR,PTIEN,RC,REGIEN,REGNAME,ROOT,SCR,UPD,UPDCNT
 N RORLOR,RORLST,RORMSG
 S ROOT=$$ROOT^DILFD(798,,1)
 ;--- Compile a list of registry internal entry numbers
 S REGNAME="",RC=0
 F  S REGNAME=$O(REGLST(REGNAME))  Q:REGNAME=""  D  Q:RC<0
 . S RC=+$G(REGLST(REGNAME))
 . S:RC'>0 RC=$$REGIEN^RORUTL02(REGNAME)
 . S:RC>0 RORLOR(+RC)=""
 Q:RC<0 RC
 ;--- Loop through the patients of the registries
 S PTIEN="",(CNT,RC)=0
 F  S PTIEN=$O(@ROOT@("B",PTIEN))  Q:PTIEN=""  D  Q:RC<0
 . ;--- Check if task stop has been requested
 . I $D(ZTQUEUED),$$S^%ZTLOAD  D  Q
 . . S RC=$$ERROR^RORERR(-42)
 . S CNT=CNT+1
 . I $G(RORPARM("DEBUG"))>1  W:$E($G(IOST),1,2)="C-" *13,CNT
 . ;--- Check for "stray" items in the cross-reference
 . S IR=""
 . F  S IR=$O(@ROOT@("B",PTIEN,IR))  Q:IR=""  D
 . . K:$P($G(@ROOT@(IR,0)),U)'>0 @ROOT@("B",PTIEN,IR)
 . Q:$D(@ROOT@("B",PTIEN))<10
 . ;--- Check for a merged patient record
 . S RC=$$MERGED^RORUTL18(PTIEN)
 . I RC  S:RC>0 RC=$$MERGE(PTIEN,RC)  S RC=0  Q
 . ;--- Load a list of patient's registry records
 . S SCR="S Y=+$P($G(^(0)),U,2) I Y,$D(RORLOR(Y))"
 . D FIND^DIC(798,,"@;.02I;3I;8E","QUX",PTIEN,,"B",SCR,,"RORLST","RORMSG")
 . I $G(DIERR)  D  Q
 . . S RC=$$DBS^RORERR("RORMSG",-9,,PTIEN,798)
 . ;--- Demographic data should be checked only if at least one of
 . ;--- the registry records of the patient is active.
 . S IR="",UPDCNT=0
 . F  S IR=$O(RORLST("DILIST","ID",IR))  Q:IR=""  D
 . . S UPD=+$G(RORLST("DILIST","ID",IR,8))
 . . S REGIEN=+$G(RORLST("DILIST","ID",IR,.02))
 . . S TMP=+$G(RORLST("DILIST","ID",IR,3))  ; STATUS
 . . S CNT(REGIEN,TMP)=$G(CNT(REGIEN,TMP))+1
 . . S:UPD UPDCNT=UPDCNT+1
 . S:UPDCNT RC=$$UPDPTDEM(PTIEN)
 D:RC'<0 UPDRCNT(.CNT)
 ;---
 Q $S(RC<0:RC,1:0)
 ;
 ;***** UPDATES DEMOGRAPHIC DATA OF THE PATIENT (IF NECESSARY)
 ;
 ; PTIEN         Patient IEN
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
UPDPTDEM(PTIEN) ;
 N CF,DOD,IENS,RC,RORMSG,RORPAT
 S IENS=PTIEN_",",CF=0
 ;--- Try to lock the record of the ROR PATIENT file
 L +^RORDATA(798.4,PTIEN):3
 E  Q $$ERROR^RORERR(-11,,,PTIEN,"file #798.4")
 D
 . ;--- Compare demographic data
 . S RC=$$PATDATA^RORUPD52(IENS,.RORPAT,IENS,.DOD)  Q:RC<0
 . S:RC CF=1
 . ;--- Mark registry records of the patient
 . I CF  S RC=$$MARKREGS(PTIEN,$G(DOD))  Q:RC<0
 . ;--- Update demographic data
 . I CF,$D(RORPAT)>1  S RC=0  D  Q:RC<0
 . . D FILE^DIE(,"RORPAT","RORMSG")  Q:'$G(DIERR)
 . . S RC=$$DBS^RORERR("RORMSG",-9,,PTIEN,798.4)
 ;
 L -^RORDATA(798.4,PTIEN)
 Q 0
 ;
 ;***** UPDATES RECORD COUNTERS IN THE 'ROR REGISTRY PARAMETERS' FILE
 ;
 ; .CNT(         Reference to a local array containg registry
 ;               record counters
 ;   Registry#,
 ;     0)        Number of confirmed records
 ;     4)        Number of pending records
 ;
UPDRCNT(CNT) ;
 N IENS,RC,REGIEN,RORFDA,RORMSG
 S REGIEN=0
 F  S REGIEN=$O(CNT(REGIEN))  Q:REGIEN=""  D
 . S IENS=REGIEN_","
 . S RORFDA(798.1,IENS,19.1)=$G(CNT(REGIEN,0))
 . S RORFDA(798.1,IENS,19.2)=$G(CNT(REGIEN,4))
 . D FILE^DIE("K","RORFDA","RORMSG")
 . I $G(DIERR)  D  Q
 . . S RC=$$DBS^RORERR("RORMSG",-9,,798.1,IENS)
 Q
