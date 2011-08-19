RORUPD62 ;HCIOFO/SG - HIV-SPECIFIC REGISTRY UPDATE CODE ; 5/11/05 2:17pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; This routine uses the following IAs:
 ;
 ; #2762         Check for the patient merge (controlled)
 ;
 ;--------------------------------------------------------------------
 ; Registry: [VA HIV]
 ;--------------------------------------------------------------------
 Q
 ;
 ;***** CONVERTS ICR 2.1 RECORDS TO CCR:HIV FORMAT
 ;
 ; RORREG        Registry IEN
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;
CONVERT(RORREG) ;
 N CODE,IMRIEN,PATIEN,RC,REGIEN,RULENAME,RULES,TMP
 D LOG^RORLOG(2,"ICR 2.1 Conversion")
 S REGIEN=+RORREG
 ;--- Prepare the selection rules
 S RULENAME="VA HIV 2.1 CONVERSION"
 S TMP=$$SRLIEN^RORUTL02(RULENAME)
 Q:TMP'>0 $$ERROR^RORERR(-3,,RULENAME)
 S RULES(1)=TMP_U_DT
 ;--- Convert the remaining records of ICR v2.1
 S (IMRIEN,RC)=0
 F  S IMRIEN=$O(^IMR(158,IMRIEN))  Q:IMRIEN'>0  D  Q:RC<0
 . S CODE=$P($G(^IMR(158,IMRIEN,0)),U)  Q:CODE'>0
 . S PATIEN=+$$XOR^RORUTL03(CODE)  Q:PATIEN'>0
 . ;--- Check if the patient has been merged
 . S TMP=+$G(^DPT(PATIEN,-9))  S:TMP>0 PATIEN=TMP
 . ;--- Check if the patient record in the file #2 is valid
 . Q:$$CHKPTR^RORUTL05(PATIEN)<0
 . ;--- Quit if the patient has already been added to the new registry
 . Q:$$PRRIEN^RORUTL01(PATIEN,REGIEN)>0
 . ;--- Check if the patient is an employee
 . Q:$$SKIPEMPL^RORUTL02(PATIEN,.REGIEN)
 . ;--- Add the patient to the new registry
 . S TMP=$$ADDPAT^RORUPD06(PATIEN,"VA HIV",.RULES)
 ;---
 Q $S(RC<0:RC,1:0)
 ;
 ;***** AFTER UPDATE CALL-BACK ENTRY POINT
 ;
 ; RORIEN        An IEN of the newly added registry record
 ; PATIEN        Patient IEN
 ; REGIEN        Registry IEN
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;
POSTUPD(RORIEN,PATIEN,REGIEN) ;
 N DA,DIK,IENS,RC,RORFDA,RORHIV,RORMSG
 S RORIEN=+$G(RORIEN)  Q:RORIEN'>0 0
 ;--- Delete the record if it exists by some reason
 D:$D(^RORDATA(799.4,RORIEN))
 . S DIK="^RORDATA(799.4,",DA=RORIEN  D ^DIK
 ;--- Prepare the data
 S IENS="+1,"
 S RORFDA(799.4,IENS,.01)=RORIEN
 S RORHIV(1)=RORIEN
 ;--- Add the record to the ROR HIV STUDY file
 D UPDATE^DIE(,"RORFDA","RORHIV","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,799.4,IENS)
 Q 0
