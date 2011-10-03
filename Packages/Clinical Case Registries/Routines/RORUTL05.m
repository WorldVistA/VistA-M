RORUTL05 ;HCIOFO/SG - MISCELLANEOUS UTILITIES ; 1/26/07 4:24pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1,2**;Feb 17, 2006;Build 6
 ;
 ; This routine uses the following IAs:
 ;
 ; #4493         Read the .01 field of the file #771.7 (private)
 ; #10040        Access to the HOSPITAL LOCATION file (supported)
 ; #10061        DEM^VADPT (supported)
 ;
 Q
 ;
 ;***** CHECKS IF THE E-MAIL NOTIFICATION IS ENABLED
 ;
 ; REGIEN        Registry IEN
 ;
 ; Return Values:
 ;        0  Do not send e-mail notifications
 ;        1  E-mail notifications are enabled
 ;
CCRNTFY(REGIEN) ;
 N DOMAIN,RC
 ;--- Check if not a production account
 I $T(PROD^XUPROD)'=""  Q:'$$PROD^XUPROD() 0
 ;--- Check the domain name
 S DOMAIN=$G(^XMB("NETNAME"))
 Q:DOMAIN'?1.E1".VA.GOV" 0
 Q:(DOMAIN?1"TEST.".E)!(DOMAIN?1"TST.".E) 0
 ;--- Registry-specific checks
 I $G(REGIEN)>0  S RC=1  D  Q:'RC 0
 . N HL,HLECH,HLFS,HLQ,NAME,RORMSG
 . ;--- Get the HL7 protocol name
 . S NAME=$$GET1^DIQ(798.1,+REGIEN,13,,,"RORMSG")  Q:NAME=""
 . ;--- Check the HL7 processing ID
 . D INIT^HLFNC2(NAME,.HL)
 . I $G(HL("PID"))'="",HL("PID")'="P"  S RC=0  Q
 ;--- Notification is enabled (production account)
 Q 1
 ;
 ;***** CHECK IF THE PATIENT'S RECORD IN FILE #2 IS VALID
 ;
 ; DFN           Patient IEN (in file #2)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
CHKPTR(DFN,SILENT) ;
 N RC,VA,VADM,VAERR
 D VADEM(DFN)
 I $G(VADM(1))=""  S RC=-102  D:'$G(SILENT)  Q RC
 . D ERROR^RORERR(RC,,,,"PATIENT",DFN)
 Q 0
 ;
 ;***** DELETES ALL RECORDS FROM THE (SUB)FILE
 ;
 ; FILE          File/Subfile number
 ; [IENS]        IENS of the subfile
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
CLEAR(FILE,IENS) ;
 Q:'$$VFILE^DILFD(FILE) 0
 N DA,DIK,RC,ROOT,TMP
 S IENS=$G(IENS)
 ;--- Lock the (sub)file
 S RC=$$LOCK^RORLOCK(FILE,IENS)
 I RC  D  Q RC
 . S TMP=$$GET1^DID(FILE,,,"NAME",,"RORMSG")
 . S TMP=$S(TMP'="":"file",1:"subfile")_" #"_FILE
 . S:IENS'="" TMP=TMP_"; IENS: '"_IENS_"'"
 . S RC=$$ERROR^RORERR(-11,,"By "_$$TEXT^RORLOCK(RC),,TMP)
 ;
 ;--- Delete the records
 S DIK=$$ROOT^DILFD(FILE,IENS)
 S ROOT=$$CREF^DILF(DIK)
 D DA^DILF(IENS,.DA)  S DA=0
 F  S DA=$O(@ROOT@(DA))  Q:DA'>0  D ^DIK
 ;
 ;--- Unlock the (sub)file
 D UNLOCK^RORLOCK(FILE,IENS)
 Q $S(RC<0:RC,1:0)
 ;
 ;***** CLEARS THE FIELDS OF THE RECORDS FOUND BY NAME
 ;
 ; FILE          File number
 ; [IENS]        IENS of the subfile
 ; NAME          Name of the record (value of the .01 field)
 ; FIELDS        List of field numbers separated by semicolons
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
CLRFLDS(FILE,IENS,NAME,FIELDS) ;
 N FLD,I,IEN,IENS1,IS,RC,RORBUF,RORFDA,RORMSG
 ;--- Find the record(s)
 D FIND^DIC(FILE,$G(IENS),"@","X",NAME,,"B",,,"RORBUF","RORMSG")
 S RC=$$DBS^RORERR("RORMSG",-9,,,FILE)  Q:RC<0 RC
 S:$G(IENS)="" IENS=","  S FIELDS=$TR(FIELDS," ")
 ;--- Update the record(s)
 S IS="",RC=0
 F  S IS=$O(RORBUF("DILIST",2,IS))  Q:IS=""  D  Q:RC<0
 . S IEN=RORBUF("DILIST",2,IS)  Q:IEN'>0
 . S IENS1=IEN_IENS
 . F I=1:1  S FLD=$P(FIELDS,";",I)  Q:FLD'>0  D
 . . S RORFDA(FILE,IENS1,+FLD)="@"
 . D FILE^DIE(,"RORFDA","RORMSG")
 . S RC=$$DBS^RORERR("RORMSG",-9,,,FILE,IENS1)
 Q $S(RC<0:RC,1:0)
 ;
 ;***** RETURNS THE END DATE FOR THE EVENT PURGE
EPDATE() ;
 N DATE,IR,RC,RORBUF,RORMSG,TMP
 D LIST^DIC(798.1,,"@;1I;2I","U",,,,"B",,,"RORBUF","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,798.1)
 ;--- Get the oldest date of registry updates
 S IR="",DATE=$$DT^XLFDT
 F  S IR=$O(RORBUF("DILIST","ID",IR))  Q:IR=""  D
 . S TMP=$G(RORBUF("DILIST","ID",IR,1)) ; REGISTRY UPDATED UNTIL
 . I TMP>0  S:TMP<DATE DATE=TMP
 . ;S TMP=$G(RORBUF("DILIST","ID",IR,2)) ; DATA EXTRACTED UNTIL
 . ;I TMP>0  S:TMP<DATE DATE=TMP
 ;--- Subtract additional 14 days (just in case)
 S DATE=$$FMADD^XLFDT(DATE\1,-14)
 ;--- No more than 60 days in the past
 S TMP=$$FMADD^XLFDT($$DT^XLFDT,-60)
 Q $S(DATE>TMP:DATE,1:TMP)
 ;
 ;***** RETURNS NAME OF THE HOSPITAL LOCATION
 ;
 ; HLIEN         IEN of the hospital location
 ;
HLNAME(HLIEN) ;
 N NAME
 S NAME=$$GET1^DIQ(44,(+HLIEN)_",",.01,,,"RORMSG")
 D:$G(DIERR) DBS^RORERR("RORMSG",-9,,,44,(+HLIEN)_",")
 Q NAME
 ;
 ;***** FORMATS THE TEXT THAT DESCRIBES STATUS OF THE HL7 MESSAGE
 ;
 ; MSGID         A valid ID of the HL7 message
 ;
 ; .RORDST       Reference to a local array that the text
 ;               is appended to
 ;
 ; [TITLE]       Title of the output
 ;
 ; [DLGNUM]      Number of an entry in the DIALOG file that
 ;               contains the text template (by default,
 ;               the 7980000.004 is used)
 ;
 ; [.PARAMS]     Reference to a local variable containing
 ;               additional parameters that substitute the
 ;               placeholders in the text template
 ; PARAMS(
 ;  "NOR")       Number of retries to resend the message
 ;  "REGISTRY")  Name of the registry
 ;
 ; [MSGSTAT]     Status of the message (result value of the
 ;               $$MSGSTAT^HLUTIL function). If this parameter
 ;               is undefined or equal to an empty string, the
 ;               current status of the message is retrieved.
 ;
MSG7STS(MSGID,RORDST,TITLE,DLGNUM,PARAMS,MSGSTAT) ;
 N RORMSG,TMP
 Q:$G(MSGID)?." "
 S:$G(MSGSTAT)="" MSGSTAT=$$MSGSTAT^HLUTIL(MSGID)
 ;--- Prepare the parameters
 S PARAMS("ID")=MSGID
 S PARAMS("STATUS")=$$MSGSTXT^RORHL7A(MSGSTAT)
 S TMP=+$P(MSGSTAT,U,2)
 S:TMP>0 PARAMS("UPDATED")=$$FMTE^XLFDT(TMP)
 S PARAMS("ERRMSG")=$P(MSGSTAT,U,3)
 S TMP=+$P(MSGSTAT,U,4)
 S:TMP>0 PARAMS("ERRTYPE")=$$GET1^DIQ(771.7,TMP_",",.01,,,"RORMSG")
 S PARAMS($S(+MSGSTAT=1:"QPOS",1:"RETRIES"))=$P(MSGSTAT,U,5)
 S PARAMS("OPENFAIL")=$P(MSGSTAT,U,6)
 S PARAMS("ACK")=$P(MSGSTAT,U,7)
 ;--- Additional parameters
 I $G(DLGNUM)>0  D
 . S PARAMS("STATCODE")=+MSGSTAT
 . S TMP=+$P(MSGSTAT,U,2)
 . S:TMP>0 PARAMS("STATUPD")=$$FMTHL7^XLFDT(TMP)
 . S TMP=$$SITE^RORUTL03()
 . S PARAMS("STNAME")=$P(TMP,U,2)
 . S PARAMS("STNUM")=$P(TMP,U)
 . S:$G(PARAMS("NOR"))'>0 PARAMS("NOR")="several"
 . S:$G(PARAMS("REGISTRY"))="" PARAMS("REGISTRY")="<unknown>"
 E  S DLGNUM=7980000.004
 ;--- Build the text
 S:$G(TITLE)'="" RORDST(1)=TITLE,RORDST(2)=" "
 D BLD^DIALOG(DLGNUM,.PARAMS,,"RORDST","S")
 Q
 ;
 ;***** CHECK IF THE ARGUMENT IS A NUMBER
 ;
 ; Return Values:
 ;        1  Value starts from a number
 ;        0  Otherwise
 ;
NUMERIC(VAL,NUMVAL) ;
 S NUMVAL=$$TRIM^XLFSTR(VAL)
 I NUMVAL?.1(1"+",1"-")1(1.N.1".".N,.N.1"."1.N).1(1"E".1(1"+",1"-")1.N)  S NUMVAL=+NUMVAL  Q 1
 S NUMVAL=""
 Q 0
 ;
 ;***** MARKS THE REGISTRY RECORDS FOR RESENDING THE LOCAL DATA
 ;
 ; .REGLST       Reference to a local array containing registry names 
 ;               as subscripts and optional registry IENs as values
 ;
 ; WD            Number of days to wait before marking the records
 ;               for resending the local registry data
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
REMARK(REGLST,WD) ;
 N DATE,IEN,IENS,REGIEN,REGNAME,ROOT,RORFDA,RORMSG,TMP
 S ROOT=$$ROOT^DILFD(798,,1),RC=0
 S DATE=$$FMADD^XLFDT($$DT^XLFDT,-WD)
 ;--- Process the registries from the list
 S REGNAME=""
 F  S REGNAME=$O(REGLST(REGNAME))  Q:REGNAME=""  D
 . S REGIEN=+REGLST(REGNAME)
 . I REGIEN'>0  S REGIEN=$$REGIEN^RORUTL02(REGNAME)  Q:REGIEN'>0
 . S IENS=REGIEN_","
 . ;--- Get the registry parameters
 . D GETS^DIQ(798.1,IENS,"21.04;21.05","I","RORFDA","RORMSG")
 . I $G(DIERR)  S TMP=$$DBS^RORERR("RORMSG",-9,,,798.1,IENS)  Q
 . ;--- Local data has been resent already
 . Q:$G(RORFDA(798.1,IENS,21.04,"I"))
 . ;--- The registry has not been populated yet
 . Q:'$G(RORFDA(798.1,IENS,21.05,"I"))
 . ;--- It is too early for resending the local data
 . Q:RORFDA(798.1,IENS,21.05,"I")>DATE
 . K RORFDA,RORMSG
 . ;--- Mark registry records as modified
 . S IEN=0
 . F  S IEN=$O(@ROOT@("AC",REGIEN,IEN))  Q:'IEN  D
 . . S IENS=IEN_","
 . . S RORFDA(798,IENS,4)=1  ; UPDATE DEMOGRAPHICS
 . . S RORFDA(798,IENS,5)=1  ; UPDATE LOCAL REGISTRY DATA
 . . D FILE^DIE(,"RORFDA","RORMSG")
 . . D:$G(DIERR) DBS^RORERR("RORMSG",-9,,,798,IENS)
 . ;--- Update registry parameters
 . S IENS=REGIEN_","
 . S RORFDA(798.1,IENS,21.04)=$$NOW^XLFDT
 . D FILE^DIE("K","RORFDA","RORMSG")
 . I $G(DIERR)  S TMP=$$DBS^RORERR("RORMSG",-9,,,798.1,IENS)  Q
 . ;--- Record the message
 . S TMP="Local registry and demographic data will be resent to AAC"
 . D LOG^RORLOG(2,TMP,,"Registry Name: "_REGNAME)
 Q 0
 ;
 ;***** CALLS THE DEM^VADPT
 ;
 ; DFN           Patient IEN (in file #2)
 ; VALIDATE      Make sure that required fields are not empty
 ; VAPTYP
 ; VAHOW
 ;
VADEM(DFN,VALIDATE,VAPTYP,VAHOW) ;
 N I,J,X,A,K,K1,NC,NF,NQ,T,VAROOT
 D DEM^VADPT
 S VA("BID")=$E($P($G(VADM(2)),U),6,10)  ; Always 'Last4'
 Q:'$G(VALIDATE)
 ;--- Make sure that required fields are not empty
 S:$G(VADM(1))="" VADM(1)="Unknown ("_DFN_")"
 S:$G(VA("BID"))="" VA("BID")="UNKN"
 Q
