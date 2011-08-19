ROR11 ;HCIOFO/SG - NIGHTLY TASK UTILITIES ; 12/7/05 9:40am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; RORLBLST ------------ LIST OF LATEST HL7 MESSAGES
 ;
 ; RORLBLST(
 ;   MsgID,              Internal Batch ID
 ;     "MS")             Message Status (see $$MSGSTAT^HLUTIL)
 ;                         ^01: Status Code
 ;                         ^02: Status Updated
 ;                         ^03: Error Message
 ;                         ^04: Error Type pointer
 ;                         ^05: Queue Position or Number of Retries
 ;                         ^06: Open Failed
 ;                         ^07: ACK Timeout
 ;     "RL",
 ;       RegIEN)         IENS of the message reference in the
 ;                       registry parameters (sub-file #798.122)
 ;
 ;   "N",                Created and used by the NOTIFY^ROR11
 ;     EMail,
 ;       RegName)        RegIEN
 ;
 ;   "RM",
 ;     RegIEN,           ""
 ;       MsgID)          ""
 ;
 Q
 ;
 ;***** ADDS THE HL7 BATCH MESSAGE TO THE LIST
 ;
 ; MSGID         Batch HL7 Message Control ID
 ; IENS          IENS of the message reference in the reigstry
 ;               parameters (sub-file #798.122)
 ; IBID          Internal Batch ID
 ; DATE          Date/Time of the batch
 ;
ADDMSG(MSGID,IENS,IBID,DATE) ;
 N REGIEN  S REGIEN=$P(IENS,",",2)
 D:'$D(RORLBLST(MSGID))
 . S RORLBLST(MSGID,"MS")=$$MSGSTAT^HLUTIL(MSGID)
 . S RORLBLST(MSGID,"DT")=DATE
 . S RORLBLST(MSGID)=IBID
 S RORLBLST(MSGID,"RL",REGIEN)=IENS
 S RORLBLST("RM",REGIEN,MSGID)=""
 S RORLBLST("RM",REGIEN)=""
 Q
 ;
 ;***** REMOVES THE HL7 BATCH MESSAGE FROM THE LIST
 ;
 ; MSGID         Batch HL7 Message Control ID
 ; [.FDA]        Reference to the FDA arrays that will be updated
 ;               to remove the references to the message
 ;
DELMSG(MSGID,FDA) ;
 N IENS,REGIEN  S REGIEN=""
 F  S REGIEN=$O(RORLBLST(MSGID,"RL",REGIEN))  Q:REGIEN=""  D
 . S IENS=$P(RORLBLST(MSGID,"RL",REGIEN),U)
 . S:IENS'="" FDA(798.122,IENS,.01)="@"
 . K RORLBLST("RM",REGIEN,MSGID)
 K RORLBLST(MSGID)
 Q
 ;
 ;***** NOTIFIES THE AAC AND LOCAL COORDINATORS
NOTIFY() ;
 Q:$D(RORLBLST("RM"))<10
 N ALNOR,EMAIL,IENS,MSGID,NOR,PARAMS,REGIEN,REGNAME,RORBUF,RORMSG,RORTXT,RORXML,TMP
 K RORLBLST("N")
 ;
 ;=== Send local alerts and generate the notification list
 S REGIEN=0
 F  S REGIEN=$O(RORLBLST("RM",REGIEN))  Q:REGIEN'>0  D
 . K RORBUF,RORMSG,RORTXT  S IENS=REGIEN_","
 . ;--- Load the notification parameters
 . D GETS^DIQ(798.1,IENS,".01;13.2;13.3;19.3",,"RORBUF","RORMSG")
 . I $G(DIERR)  D DBS^RORERR("RORMSG",-9,,,798.1,IENS)  Q
 . ;--- Check if the notification should be sent
 . S ALNOR=+$G(RORBUF(798.1,IENS,13.2)) ; ALERT FREQUENCY
 . S NOR=+$G(RORBUF(798.1,IENS,19.3))   ; HL7 ATTEMPT COUNTER
 . Q:$S(ALNOR'>0:1,1:NOR#ALNOR)
 . ;---
 . S REGNAME=$G(RORBUF(798.1,IENS,.01)) ; Registry Name
 . S EMAIL=$G(RORBUF(798.1,IENS,13.3))  ; Notification E-mail
 . S PARAMS("REGISTRY")=REGNAME
 . S PARAMS("NOR")=NOR
 . ;--- Error message header
 . D BLD^DIALOG(7980000.023,.PARAMS,,"RORTXT","S")
 . ;--- Append the list of unsent HL7 messages
 . S MSGID=""
 . F  S MSGID=$O(RORLBLST("RM",REGIEN,MSGID))  Q:MSGID=""  D
 . . S MSGSTAT=RORLBLST(MSGID,"MS")
 . . S RORTXT($O(RORTXT(""),-1)+1)=""
 . . D MSG7STS^RORUTL05(MSGID,.RORTXT,,7980000.004,.PARAMS,MSGSTAT)
 . ;--- Error message footer
 . D BLD^DIALOG(7980000.024,.PARAMS,,"RORTXT")
 . ;--- Record the error message
 . D LOG^RORERR(-67,.RORTXT,,NOR)
 . ;--- Notify local staff
 . S TMP=REGNAME_U_NOR
 . D ALERT^RORUTL01(REGNAME,-67,"ALERT^ROR10",TMP,,NOR)
 . ;--- Update the national notification list
 . D:$$CCRNTFY^RORUTL05(REGIEN)
 . . S:EMAIL'="" RORLBLST("N",EMAIL,REGNAME)=REGIEN
 ;
 ;=== Get station name and number
 S TMP=$$SITE^RORUTL03()
 S PARAMS("STNAME")=$P(TMP,U,2)
 S PARAMS("STNUM")=$P(TMP,U)
 ;
 ;=== Generate notification e-mails
 S EMAIL=""
 F  S EMAIL=$O(RORLBLST("N",EMAIL))  Q:EMAIL=""  D
 . K RORXML
 . ;--- E-mail header
 . D BLD^DIALOG(7980000.025,.PARAMS,,"RORXML","S")
 . ;--- Process affected registries
 . S REGNAME=""
 . F  S REGNAME=$O(RORLBLST("N",EMAIL,REGNAME))  Q:REGNAME=""  D
 . . S REGIEN=+RORLBLST("N",EMAIL,REGNAME)
 . . S PARAMS("REGISTRY")=REGNAME
 . . S PARAMS("NOR")=NOR
 . . ;--- Append registry section
 . . D NTFXML("<REGISTRY>")
 . . D NTFXML("<NAME>"_REGNAME_"</NAME>")
 . . S TMP=$P($$REGNAME^RORUTL01(REGIEN),U,2)
 . . D NTFXML("<DESCRIPTION>"_TMP_"</DESCRIPTION>")
 . . ;--- Append message list
 . . S MSGID=""
 . . F  S MSGID=$O(RORLBLST("RM",REGIEN,MSGID))  Q:MSGID=""  D
 . . . S MSGSTAT=RORLBLST(MSGID,"MS")
 . . . D MSG7STS^RORUTL05(MSGID,.RORXML,,7980000.002,.PARAMS,MSGSTAT)
 . . ;--- Close the registry section
 . . D NTFXML("</REGISTRY>")
 . ;--- E-mail footer
 . D BLD^DIALOG(7980000.026,.PARAMS,,"RORXML","S")
 . ;--- Send the e-mail
 . D
 . . N XMCHAN,XMDUZ,XMLOC,XMSUB,XMTEXT,XMY,XMZ
 . . S XMDUZ=.5,XMY(EMAIL)=""
 . . S XMSUB="ROR: HL7 PROBLEM"
 . . S XMTEXT="RORXML("
 . . D ^XMD
 Q
 ;
NTFXML(STR) ;
 S RORXML($O(RORXML(""),-1)+1)=STR
 Q
 ;
 ;***** UPDATES REGISTRY RECORDS AFTER SUCCESSFUL DATA TRANSMISSION
 ;
 ; BATCHID       Internal HL7 batch ID
 ; BATCHDT       Date/Time of the batch
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  Ok
 ;
UPDTRR(BATCHID,BATCHDT) ;
 N IEN,IENS,LBI,MSGID,PATIEN,REGIEN,RORBUF,RORFDA,RORMSG,TMP,XREF
 S XREF=$$ROOT^DILFD(798)_"""AM"")"
 S LBI=$L(BATCHID)
 ;===
 S MSGID=BATCHID
 F  S MSGID=$O(@XREF@(MSGID))  Q:$E(MSGID,1,LBI)'=BATCHID  D
 . S IEN=0
 . F  S IEN=$O(@XREF@(MSGID,IEN))  Q:IEN'>0  D
 . . S IENS=IEN_","  K RORBUF,RORFDA,RORMSG
 . . ;=== Load the registry record
 . . S TMP=".01;.02;3;4;4.1;5;5.1;6;9.1;9.2;10"
 . . D GETS^DIQ(798,IENS,TMP,"I","RORBUF","RORMSG")
 . . S PATIEN=$G(RORBUF(798,IENS,.01,"I"))
 . . I $G(DIERR)  D DBS^RORERR("RORMSG",-9,,PATIEN,798,IENS)  Q
 . . S REGIEN=+$G(RORBUF(798,IENS,.02,"I"))
 . . ;
 . . ;=== Update record state only if the corresponding HL7 message
 . . ;=== was actually generated (check for fake Message ID)
 . . I $P($G(RORBUF(798,IENS,10,"I")),"-",2)  S RC=0  D  Q:RC
 . . . ;--- Delete a record marked for deletion (only if the deletion
 . . . ;--- date/time is earlier than the last message timestamp)
 . . . I $G(RORBUF(798,IENS,3,"I"))=5  D  Q
 . . . . Q:$G(RORBUF(798,IENS,6,"I"))'<BATCHDT
 . . . . N DA,DIK  S RC=1
 . . . . S DIK=$$ROOT^DILFD(798),DA=IEN  D ^DIK
 . . . . S TMP=$$REGNAME^RORUTL01(REGIEN)
 . . . . D LOG^RORERR(-90,,PATIEN,$P(TMP,U))
 . . . ;--- Reset the UPDATE DEMOGRAPHICS flag if the demographic
 . . . ;--- data was updated before the latest data extraction
 . . . D:$G(RORBUF(798,IENS,4,"I"))
 . . . . S:$G(RORBUF(798,IENS,4.1,"I"))<BATCHDT RORFDA(798,IENS,4)="@"
 . . . ;--- Reset the UPDATE LOCAL REGISTRY DATA flag if the local
 . . . ;--- data was updated before the latest data extraction
 . . . D:$G(RORBUF(798,IENS,5,"I"))
 . . . . S:$G(RORBUF(798,IENS,5.1,"I"))<BATCHDT RORFDA(798,IENS,5)="@"
 . . ;
 . . ;=== Update extraction dates
 . . S TMP=+$G(RORBUF(798,IENS,9.2,"I"))
 . . S:TMP>$G(RORBUF(798,IENS,9.1)) RORFDA(798,IENS,9.1)=TMP
 . . ;=== Clear the message ID
 . . S RORFDA(798,IENS,10)="@"
 . . ;=== Update the registry record (if necessary)
 . . D:$D(RORFDA)>1
 . . . D FILE^DIE(,"RORFDA","RORMSG")
 . . . D:$G(DIERR) DBS^RORERR("RORMSG",-9,,PATIEN,798,IENS)
 ;===
 Q 0
