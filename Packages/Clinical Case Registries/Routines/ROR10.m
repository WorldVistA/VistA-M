ROR10 ;HCIOFO/SG - NIGHTLY TASK UTILITIES ; 11/29/05 4:21pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** DISPLAYS THE ALERT ABOUT PROBLEMATIC HL7 MESSAGES
ALERT ;
 Q:$G(XQADATA)=""
 N I,PARAMS,RORINFO,TMP
 ;--- Get and prepare the parameters
 S PARAMS("REGISTRY")=$P(XQADATA,"^")
 S PARAMS("NOR")=$P(XQADATA,"^",2)
 ;--- Load and format the text
 D BLD^DIALOG(7980000.027,.PARAMS,,"RORINFO","S")
 ;--- Display the text
 S I=""  W !!
 F  S I=$O(RORINFO(I))  Q:I=""  W RORINFO(I),!
 Q
 ;
 ;***** CHECKS THE STATUS OF LAST HL7 MESSAGE(S)
 ;
 ; .REGLST       Reference to a local array containing registry
 ;               names as subscripts and (optionally) registry
 ;               IENs as values.
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  Ok
 ;
CHECKMSG(REGLST) ;
 N RORLBLST      ; List of latest batch HL7 messages (see ^ROR11)
 ;
 N HDTIEN,IENS,IM,LBCID,MSGDT,MSGSTC,RC,REGIEN,REGNAME,RORBUF,RORFDA,RORMSG,TMP
 S RC=0
 ;
 ;=== Compile the list of latest batch HL7 messages
 S REGNAME=""
 F  S REGNAME=$O(REGLST(REGNAME))  Q:REGNAME=""  D  Q:RC<0
 . ;--- Get the registry IEN
 . S REGIEN=+$G(REGLST(REGNAME))
 . I REGIEN'>0  D  I REGIEN'>0  S RC=+REGIEN  Q
 . . S REGIEN=$$REGIEN^RORUTL02(REGNAME)
 . S $P(REGLST(REGNAME),U)=REGIEN
 . ;--- Get the list of batch HL7 message IDs
 . K RORBUF,RORMSG
 . S IENS=","_REGIEN_","
 . D LIST^DIC(798.122,IENS,"@;.01;.02;.03I",,,,,"B",,,"RORBUF","RORMSG")
 . I $G(DIERR)  S RC=$$DBS^RORERR("RORMSG",-9,,,798.122,IENS)  Q
 . ;--- Update the list of latest HL7 batch messages
 . S IM=""
 . F  S IM=$O(RORBUF("DILIST","ID",IM))  Q:IM=""  D
 . . S LBCID=RORBUF("DILIST","ID",IM,.01)
 . . S IENS=RORBUF("DILIST",2,IM)_","_REGIEN_","
 . . S MSGDT=$G(RORBUF("DILIST","ID",IM,.03))
 . . D ADDMSG^ROR11(LBCID,IENS,$G(RORBUF("DILIST","ID",IM,.02)),MSGDT)
 Q:RC<0 RC
 ;
 ;=== Analyze the list of messages
 S LBCID=0
 F  S LBCID=$O(RORLBLST(LBCID))  Q:LBCID'>0  D  Q:RC<0
 . S MSGSTC=+RORLBLST(LBCID,"MS")
 . S MSGDT=RORLBLST(LBCID,"DT")
 . ;--- If the message does not exist (usually, it should), remove
 . ;    the reference(s) but do not update the patients' extraction
 . ;--- dates. Data will be re-extracted and resent (just in case).
 . I 'MSGSTC  D  Q
 . . D DELMSG^ROR11(LBCID,.RORFDA)
 . . D ERROR^RORERR(-49,,,,LBCID)
 . ;--- Unfortunately, the 'successfully completed' status (3) is
 . ;    returned for cancelled messages as well (and possibly in
 . ;    some other situations). Update the patients' extraction
 . ;    dates only if there is no error message in the status
 . ;--- string. Then remove the message reference(s).
 . I MSGSTC=3  D  Q
 . . S TMP=$P(RORLBLST(LBCID,"MS"),U,3)
 . . S:TMP="" TMP=$$UPDTRR^ROR11($P(RORLBLST(LBCID),U),MSGDT)
 . . D DELMSG^ROR11(LBCID,.RORFDA)
 . ;--- If the message is being processed/transmitted,
 . ;--- then keep the reference(s) in the list.
 . I (MSGSTC=1.5)!(MSGSTC=1.7)  D  Q
 . . D ERROR^RORERR(-73,,,,LBCID)
 . ;--- Otherwise (the message has not been sent), keep the
 . ;--- reference(s) and requeue the message (just in case).
 . S TMP=+$$MSGACT^HLUTIL(LBCID,2)
 . D ERROR^RORERR($S(TMP:-93,1:-92),,,,LBCID)
 Q:RC<0 RC
 ;
 S REGNAME=""
 F  S REGNAME=$O(REGLST(REGNAME))  Q:REGNAME=""  D
 . ;--- Get the registry IEN
 . S REGIEN=+$G(REGLST(REGNAME))  Q:REGIEN'>0
 . S IENS=REGIEN_","
 . ;--- Check if all registry messages have been sent
 . I $D(RORLBLST("RM",REGIEN))<10  D:$D(RORLBLST("RM",REGIEN))  Q
 . . K RORLBLST("RM",REGIEN)
 . . ;--- Clear the HL7 ATTEMPT COUNTER field
 . . S RORFDA(798.1,IENS,19.3)="@"
 . . ;--- Check for an automatic backpull definition
 . . S HDTIEN=$$GET1^DIQ(798.1,IENS,21.01,"I",,"RORMSG")
 . . I $G(DIERR)  D DBS^RORERR("RORMSG",-9,,,798.1,IENS)  Q
 . . D:HDTIEN>0
 . . . ;--- Reset the automatic backpull mode
 . . . S RORFDA(798.1,IENS,21.01)="@"
 . . . ;--- Complete the automatic backpull
 . . . S TMP=$$COMPLETE^RORHDT06(HDTIEN,REGNAME)
 . ;--- Increment the HL7 ATTEMPT COUNTER for registries with unsent
 . ;--- message(s) and exclude those registries from data extraction.
 . S TMP=$$GET1^DIQ(798.1,IENS,19.3,,,"RORMSG")
 . D:$G(DIERR) DBS^RORERR("RORMSG",-9,,,798.1,IENS)
 . S RORFDA(798.1,IENS,19.3)=TMP+1
 . K REGLST(REGNAME)
 ;
 ;=== Update the registry parameters if necessary
 D:$D(RORFDA)>1
 . D FILE^DIE(,"RORFDA","RORMSG")
 . D:$G(DIERR) DBS^RORERR("RORMSG",-9,,,798.1)
 ;
 ;=== Notify the AAC and local coordinators if necessary
 D:$D(RORLBLST("RM"))>1 NOTIFY^ROR11()
 ;
 ;=== Success
 Q 0
 ;
 ;***** PROCESSES THE TASK PARAMETERS
 ;
 ; .REGLST       Reference to a local variable where the list of
 ;               registry names is returned to
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  Ok
 ;
TASKPRMS(REGLST) ;
 N %DT,DTOUT,INFO,REGNAME,TMP,X,Y
 ;--- Log the task parameters
 D TP(.INFO,"ZTQPARAM")
 D TP(.INFO,"RORFLSET")
 D TP(.INFO,"RORFLCLR")
 D TP(.INFO,"RORMNTSK")
 D TP(.INFO,"RORSUSP")
 D LOG^RORLOG(,"Task Parameters",,.INFO)
 ;--- Check the task parameters
 I ZTQPARAM=""  D  Q RC
 . D TEXT^RORTXT(7980000.001,.INFO)
 . S RC=$$ERROR^RORERR(-88,,.INFO,,"TASK PARAMETERS")
 ;--- Maximum number of subtasks
 S RORMNTSK=$S(RORMNTSK'="":$TR(RORMNTSK,"-","^"),1:"2^3^AUTO")
 ;--- Suspension parameters
 D:RORSUSP'=""
 . S TMP=RORSUSP,RORSUSP=""
 . F I=1,2  D  S:$G(Y)>0 $P(RORSUSP,"^",I)=Y#1
 . . S X=$P(TMP,"-",I),%DT="R"  D ^%DT
 ;--- Extract registry names from task parameters
 F I=1:1  S REGNAME=$P(ZTQPARAM,",",I)  Q:REGNAME=""  D
 . S REGNAME=$$TRIM^XLFSTR(REGNAME)
 . S:REGNAME'="" REGLST(REGNAME)=""
 ;--- Flags
 S RORFLCLR=$$UP^XLFSTR(RORFLCLR)
 S RORFLSET=$$UP^XLFSTR(RORFLSET)
 Q 0
 ;
TP(INFO,NAME) ;
 S @NAME=$$TRIM^XLFSTR($G(@NAME))  Q:@NAME=""
 S INFO($O(INFO(""),-1)+1)=$$LJ^XLFSTR(NAME,8)_" = """_@NAME_""""
 Q
