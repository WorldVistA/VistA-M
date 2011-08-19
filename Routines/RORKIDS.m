RORKIDS ;HCIOFO/SG - INSTALL UTILITIES (LOW-LEVEL) ; 4/21/05 2:02pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** DISPLAYS THE MESSAGE IF THE INSTALLATION ABORTS
ABTMSG() ;
 ;;You can use the Print Log Files [RORMNT PRINT LOGS] option from
 ;;the Clinical Case Registries Maintenance [RORMNT MAIN] menu to
 ;;review the log file(s). The Install File Print [XPD PRINT INSTALL
 ;;FILE] option from the Utilities [XPD UTILITY] can help also.
 ;;Please fix the error(s) and restart the installation.
 ;;
 ;;NOTE: You must have the ROR VA IRM key to be able to access
 ;;      the Clinical Case Registries files and view the logs.
 ;
 N I,INFO,MODE,TMP
 S MODE=+$G(RORPARM("KIDS"))
 S MODE=$S(MODE=1:"PRE-INSTALL",MODE=2:"POST-INSTALL",1:"")
 Q:MODE=""
 F I=1:1  S TMP=$T(ABTMSG+I)  Q:TMP'[";;"  S INFO(I)=$P(TMP,";;",2,99)
 D BMES("FATAL ERROR(S) DURING THE REGISTRY "_MODE_"!",.INFO)
 Q
 ;
 ;***** SENDS AN ALERT
 ;
 ; DUZ           DUZ of the addressee
 ;
 ; MSG           Text of the message or negative error code. The '^'
 ;               characters are replaced with spaces in the text.
 ;
 ; [REGNAME]     Registry name
 ;
 ; [PATIEN]      Patient IEN
 ;
 ; [ARG2-ARG5]   Optional parameters as for $$ERROR^RORERR
 ;
ALERT(DUZ,MSG,REGNAME,PATIEN,ARG2,ARG3,ARG4,ARG5) ;
 Q:'$G(DUZ)
 N XQA,XQADATA,XQAFLG,XQAMSG,XQAROU,TMP
 S XQA(DUZ)=""
 ;--- Get text of the error message
 I +MSG=MSG  Q:MSG'<0  D
 . S MSG=$$MSG^RORERR20(+MSG,,.PATIEN,.ARG2,.ARG3,.ARG4,.ARG5)
 S MSG=$TR(MSG,"^","~"),XQAMSG="ROR: ",TMP=70-$L(XQAMSG)-3
 S XQAMSG=XQAMSG_$S($L(MSG)>TMP:$E(MSG,1,TMP)_"...",1:MSG)
 ;--- Setup alert processing routine
 S $P(XQADATA,U,1)=$E(MSG,1,78)
 S $P(XQADATA,U,2)=$G(REGNAME)
 S $P(XQADATA,U,3)=$G(PATIEN)
 S XQAROU="ALERTRTN^RORKIDS"
 ;--- Send the alert
 S XQAFLG="D"  D SETUP^XQALERT
 Q
 ;
 ;***** ALERT PROCESSING ROUTINE
 ;
 ; XQADATA       Alert data
 ;                 ^1: Message
 ;                 ^2: Registry name
 ;                 ^3: Patient DFN
 ;
ALERTRTN ;
 ;;Registry Name:
 ;;Patient DFN:
 ;
 Q:$G(XQADATA)=""
 N I,TMP
 W !!,$P(XQADATA,"^"),!
 F I=1:1:2  S TMP=$P(XQADATA,"^",I+1)  D:TMP'=""
 . W $P($T(ALERTRTN+I),";;",2),?15,TMP,!
 Q
 ;
 ;***** OUTPUTS THE MESSAGE AND PUTS IT INTO THE LOG
BMES(MSG,INFO) ;
 N I
 D BMES^XPDUTL("   "_MSG)
 S I=""
 F  S I=$O(INFO(I))  Q:I=""  D MES^XPDUTL("   "_INFO(I))
 D LOG^RORLOG(,MSG,,.INFO)
 Q
 ;
 ;***** CHECKS THE SCHEDULED OPTION
 ;
 ; OPTION        Option name
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
 ; This function can be used in the environment check routines to
 ; check if the option is running and/or scheduled to run.
 ;
 ; The function displays appropriate error messages and warnings
 ; using the WRITE command. So, it MUST NOT be called from the
 ; pre-install or post-install routines.
 ;
 ; The function uses the ^UTILITY($J,"W") node (^DIWP and ^DIWW).
 ;
CHKOPT(OPTION) ;
 N DIWF,DIWL,DIWR,RC,RORBUF,RORI,RORSDT,TMP,X,ZTSK
 ;--- Check status of the option
 D OPTSTAT^XUTMOPT(OPTION,.RORBUF)
 S (RC,RORSDT)=0
 F RORI=1:1:$G(RORBUF)  K ZTSK  D  I $G(ZTSK(1))=2  S RC=-76  Q
 . S ZTSK=$P(RORBUF(RORI),"^")  Q:'ZTSK
 . D STAT^%ZTLOAD
 . S TMP=$P(RORBUF(RORI),"^",2)
 . I TMP>0  S:'RORSDT!(TMP<RORSDT) RORSDT=TMP
 ;--- Display an error message if the option is running
 I RC  D  Q RC
 . W !,$$MSG^RORERR20(RC,,,OPTION),!
 ;--- Display an apropriate warning
 S DIWL=5,DIWR=$G(IOM,80)-DIWL
 K ^UTILITY($J,"W")
CM1 I RORSDT>0  D
 . ;;"The ["_OPTION_"] option is scheduled to run "_RORSDT_"."
 . ;;"If you are going to schedule the installation, please, choose"
 . ;;"an appropriate time so that the post-install will either"
 . ;;"finish well before the ["_OPTION_"] scheduled time or start"
 . ;;"after the option completion."
 . ;---
 . S RORSDT=$$FMTE^XLFDT(RORSDT)
 . S RORSDT="on "_$P(RORSDT,"@")_" at "_$P(RORSDT,"@",2)
 . F RORI=1:1  S X=$T(CM1+RORI)  Q:X'[";;"  D
 . . X "S X="_$P(X,";;",2)  D ^DIWP
CM2 E  D
 . ;;"The ["_OPTION_"] option is not scheduled. Do not forget"
 . ;;"to schedule it after completion of the installation."
 . ;---
 . F RORI=1:1  S X=$T(CM2+RORI)  Q:X'[";;"  D
 . . X "S X="_$P(X,";;",2)  D ^DIWP
 W !  D ^DIWW
 Q 0
 ;
 ;***** PROCESSES THE INSTALL CHECKPOINT
 ;
 ; CPNAME        Checkpoint name
 ;
 ; CALLBACK      Callback entry point ($$TAG^ROUTINE). This function
 ;               accepts no parameters and must return either 0 if
 ;               everything is Ok or a negative error code.
 ;
 ; [PARAM]       Value to set checkpoint parameter to.
 ;
 ; The function checks if the checkpoint is completed. If it is not,
 ; the callback entry point is XECUTEd. If everything is Ok, the
 ; function will complete the checkpoint.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
CP(CPNAME,CALLBACK,PARAM) ;
 N RC
 ;--- Verify the checkpoint and quit if it is completed
 S RC=$$VERCP^XPDUTL(CPNAME)  Q:RC>0 0
 ;--- Create the new checkpoint
 I RC<0  D  Q:'RC $$ERROR^RORERR(-50,,,,CPNAME)
 . S RC=$$NEWCP^XPDUTL(CPNAME,,.PARAM)
 ;--- Reset the KIDS progress bar
 S XPDIDTOT=0  D UPDATE^XPDID(0)
 ;--- Execute the callback entry point
 X "S RC="_CALLBACK  Q:RC<0 RC
 ;--- Complete the check point
 S RC=$$COMCP^XPDUTL(CPNAME)
 Q:'RC $$ERROR^RORERR(-51,,,,CPNAME)
 Q 0
 ;
 ;***** DELETES THE (SUB)FILE DD AND DATA (IF REQUESTED)
 ;
 ; FILE          File number
 ;
 ; [FLAGS]       String that contains flags for EN^DIU2:
 ;                 "D"  Delete the data as well as the DD
 ;                 "E"  Echo back information during deletion
 ;                 "S"  Subfile data dictionary is to be deleted
 ;                 "T"  Templates are to be deleted
 ;
 ; [SILENT]      If this parameters is defined and non-zero, the
 ;               function will work in "silent" mode.
 ;               Nothing (except error messages if debug mode >1 is
 ;               enabled) will be displayed on the console or stored
 ;               into the INSTALLATION file.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
 ; NOTE: This entry point can also be called as a procedure:
 ;       D DELFILE^RORKIDS(...) if you do not need its return value.
 ;
DELFILE(FILE,FLAGS,SILENT) ;
 I '$$VFILE^DILFD(+FILE)  Q:$QUIT 0  Q
 N DIU,FT,RC
 S DIU=+FILE,DIU(0)=$G(FLAGS)
 I '$G(SILENT)  D
 . S FT=$S(DIU(0)["S":"subfile",1:"file")
 . D BMES("Deleting the "_FT_" #"_(+FILE)_"...")
 D EN^DIU2
 D:'$G(SILENT) MES("The "_FT_" has been deleted.")
 Q:$QUIT 0  Q
 ;
 ;***** DELETES FIELD DEFENITIONS FROM THE DD
 ;
 ; FILE          File number
 ;
 ; FLDLST        String that contains list of field numbers to
 ;               delete (separated with the ';').
 ;
 ; [SILENT]      If this parameters is defined and non-zero, the
 ;               function will work in "silent" mode.
 ;               Nothing (except error messages if debug mode >1 is
 ;               enabled) will be displayed on the console or stored
 ;               into the INSTALLATION file.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
 ; NOTE: This entry point can also be called as a procedure:
 ;       D DELFLDS^RORKIDS(...) if you do not need its return value.
 ;
DELFLDS(FILE,FLDLST,SILENT) ;
 I '$$VFILE^DILFD(+FILE)  Q:$QUIT 0  Q
 N DA,DIK,I,RC
 D:'$G(SILENT)
 . D BMES("Deleting the field definitions...")
 . D MES("File #"_(+FILE)_", Fields: '"_FLDLST_"'")
 S DA(1)=+FILE,DIK="^DD("_DA(1)_","
 F I=1:1  S DA=$P(FLDLST,";",I)  Q:'DA  D ^DIK
 D:'$G(SILENT) MES("The definitions have been deleted.")
 Q:$QUIT 0  Q
 ;
 ;***** OUTPUTS THE MESSAGE AND PUTS IT INTO THE LOG
MES(MSG,INFO) ;
 N I
 D MES^XPDUTL("   "_MSG)
 S I=""
 F  S I=$O(INFO(I))  Q:I=""  D MES^XPDUTL("   "_INFO(I))
 D LOG^RORLOG(,MSG,,.INFO)
 Q
 ;
 ;***** RETURNS A VALUE OF THE INSTALLATION PARAMETER
 ;
 ; NAME          Name of the parameter
 ;
PARAM(NAME) ;
 Q $G(RORPARM("KIDS",NAME))
 ;
 ;***** UPDATES THE FILE'S PACKAGE REVISION DATA (IF NECESSARY)
 ;
 ; FILE          File number
 ;
 ; [PRD]         Package revision data
 ;                 ^01: Revision number (N.N)
 ;                 ^02: Patch name
 ;
 ; If this entry point is called as a function, it returns the
 ; previous value of the PACKAGE REVISION DATA attribute.
 ;
PRD(FILE,PRD) ;
 N OLDPRD,RORMSG
 S OLDPRD=$$GET1^DID(FILE,,,"PACKAGE REVISION DATA",,"RORMSG")
 D:$G(PRD)>OLDPRD PRD^DILFD(FILE,PRD)
 Q:$QUIT OLDPRD  Q
