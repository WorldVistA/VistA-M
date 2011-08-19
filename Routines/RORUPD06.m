RORUPD06 ;HCIOFO/SG - REGISTRY UPDATE (MISCELLANEOUS) ; 11/25/03 3:49pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** ADDS THE PATIENT TO THE REGISTRY (UNCONDITIONALLY)
 ;
 ; PATIEN        Patient IEN
 ; REGNAME       Registry name
 ; .RULES        Reference to a local array containing list of
 ;               triggered selection rules: RULES(n)=RuleIEN^Date
 ;
 ; Return Values:
 ;       <0  Error code (see MSGLIST^RORERR20)
 ;        0  Ok
 ;
ADDPAT(PATIEN,REGNAME,RULES) ;
 N RORERRDL      ; Default error location
 N RORUPD        ; Update descriptor
 N RORUPDPI      ; Closed root of the temporary storage
 ;
 N I,RC,REGIEN,REGLST,RORLRC,RORSRLST,RULEIEN,VSRLST
 D INIT^RORUTL01("RORUPD")
 D CLEAR^RORERR("ADDPAT^RORUPD06")
 S RORUPDPI=$NA(^TMP("RORUPD",$J))
 ;--- Check the registry name
 Q:REGNAME?." " $$ERROR^RORERR(-10,,,PATIEN,REGNAME)
 S REGIEN=$$REGIEN^RORUTL02(REGNAME)  Q:REGIEN<0 REGIEN
 S REGLST(REGNAME)=REGIEN
 ;--- Compile a list of IENs of valid selection rules
 S I=""
 F  S I=$O(^ROR(798.1,REGIEN,1,"B",I))  Q:I=""  D
 . S RULEIEN=$$SRLIEN^RORUTL02(I)  S:RULEIEN>0 VSRLST(RULEIEN)=""
 ;--- Prepare list of triggered selection rules
 S I="",RC=0
 F  S I=$O(RULES(I))  Q:I=""  D  Q:RC<0
 . S RULEIEN=$P(RULES(I),U)
 . I RULEIEN'>0            S RC=$$ERROR^RORERR(-45)  Q
 . I '$D(VSRLST(RULEIEN))  S RC=$$ERROR^RORERR(-45)  Q
 . S RORSRLST(RULEIEN)=$P(RULES(I),U,2)
 Q:RC<0 RC
 ;--- Prepare update descriptor
 S RC=$$PREPARE1^RORUPR(.REGLST)
 Q:RC<0 $$ERROR^RORERR(-14,,,PATIEN)
 ;--- Add the patient to the registry
 S RC=$$ADDPDATA^RORUPD50(PATIEN)               Q:RC<0 RC
 S RC=$$ADD^RORUPD50(PATIEN,REGIEN,"RORSRLST")  Q:RC<0 RC
 ;--- Update patient demographic data
 S RC=$$UPDPTDEM^RORUPD51(PATIEN)
 Q:RC<0 $$ERROR^RORERR(-16,,,PATIEN)
 ;--- Cleanup
 D:'$G(RORPARM("DEBUG")) INIT^RORUTL01("RORUPD")
 Q 0
 ;
 ;***** CHECKS/UPDATES THE SINGLE PATIENT IN THE REGISTRY
 ;
 ; PATIEN        Patient IEN
 ; REGNAME       Registry name
 ;
 ; .UPDBYRUL     Reference to a local array for the list of rules that
 ;               the patient is selected by (output). The list has
 ;               the following structure: UPDBYRUL(Rule#)=Date, where
 ;               "Rule#" is an IEN of the selection rule in the file
 ;               #798.2 and "Date" is the date when the patient has
 ;               passed the selection rule for the first time.
 ;
 ; [CHKONLY]     If this optional parameter is undefined (default)
 ;               or equals to zero then the function checks a patient
 ;               against selection rules and adds him to the registry 
 ;               if he passes at least one of the rules.
 ;               Otherwise, the patient is only checked against the
 ;               rules but registry is not updated.
 ;
 ; Return Values:
 ;       <0  Error code (see MSGLIST^RORERR20)
 ;        0  Ok
 ;
 ; If a local array passed as the UPDBYRUL parameter is undefined
 ; after return from the function then the patient has not pass any
 ; selection rule.
 ;
UPDPAT(PATIEN,REGNAME,UPDBYRUL,CHKONLY) ;
 N RORERRDL      ; Default error location
 N RORLRC        ; List of Lab result codes to check
 N RORUPD        ; Update descriptor
 N RORUPDPI      ; Closed root of the temporary storage
 N RORVALS       ; Calculated values
 ;
 N RC,REGIEN,REGLST
 D INIT^RORUTL01("RORUPD")
 D CLEAR^RORERR("UPDPAT^RORUPD06")
 S RORUPDPI=$NA(^TMP("RORUPD",$J))
 ;--- Check the registry name
 Q:REGNAME?." " $$ERROR^RORERR(-10,,,PATIEN,REGNAME)
 S REGLST(REGNAME)=""  K UPDBYRUL
 ;--- Prepare selection rules
 S RC=$$PREPARE^RORUPR(.REGLST)
 Q:RC<0 $$ERROR^RORERR(-14,,,PATIEN)
 D:$G(RORPARM("DEBUG"))>1 DEBUG^RORUPDUT
 ;--- Check the patient and update the registry
 S RC=$$PROCPAT^RORUPD01(PATIEN,$G(CHKONLY))
 Q:RC<0 $$ERROR^RORERR(-15,,,PATIEN)
 ;--- Update patient demographic data
 I '$G(CHKONLY)  D  Q:RC<0 $$ERROR^RORERR(-16,,,PATIEN)
 . S RC=$$UPDPTDEM^RORUPD51(PATIEN)
 ;--- Load the list of triggered rules
 S REGIEN=""
 F  S REGIEN=$O(@RORUPDPI@("U",PATIEN,2,REGIEN))  Q:REGIEN=""  D
 . M UPDBYRUL=@RORUPDPI@("U",PATIEN,2,REGIEN)
 ;--- Cleanup
 D:'$G(RORPARM("DEBUG")) INIT^RORUTL01("RORUPD")
 Q 0
