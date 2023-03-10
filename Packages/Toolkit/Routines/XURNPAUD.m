XURNPAUD ;MVI/CKN - Master Veteran Index - Remote New Person Audit; 4 Apr 2021 2:48 pm ; 4/26/21 6:10pm
 ;;8.0;KERNEL;**743**;Jul 10, 1995;Build 1
 Q
AUDIT(RETURN,PARAM) ;Entry point for RPC - XUS REMOTE NEW PERSON AUDIT
 ;This RPC returns remote audit data from the AUDIT (#1.1) at facility
 ;for specific New Person in the NEW PERSON (#200) file.
 ;Required Input:
 ;PARAM("SourceSystemID") = Facility Station Number
 ;PARAM("SourceID") = Source ID (DUZ)
 ;Optional:
 ;PARAM("BegDate") = Earliest recorded date of the audit records to return
 ;PARAM("EndDate") = Lastest recorded date of the audit records to return
 ;Returns:
 ; @RETURN@(0) = "1^SourceSystemID^SourceID^IDTYPE^ASSIGNAUTH^AuditBegDate^AuditEndDate^TotalAuditRecordsReturned
 ;                or "-1^errorMessage"
 ; @RETURN@(n) = "DateTimeRecorded^FieldName^UserName^UserDUZ^OldValue^NewValue^MenuOptionUsed^ProtocolOrOptionUsed"
 N XUDUZ,XUIENARR,BEGDT,CNT,EDITDT,ENDDT,ERR,IEN
 ;
 S RETURN=$NA(^TMP("XURNPAUD",$J,"RET")) K @RETURN
 K XUIENARR S XUIENARR=$NA(^TMP("XURNPAUD",$J,"AIEN")) K @XUIENARR
 S XUDUZ=$G(PARAM("SourceID")),CNT=0
 I +XUDUZ'>0 S @RETURN@(0)="-1^SourceID: Not a valid DUZ" Q
 I '$D(^VA(200,+XUDUZ)) S @RETURN@(0)="-1^SourceID: New Person not found at selected facility" Q
 S BEGDT=$$INTDATE($G(PARAM("BegDate"))) I BEGDT=-1 S @RETURN@(0)="-1^BegDate: Beginning Date is not a valid date" Q
 S ENDDT=$$INTDATE($G(PARAM("EndDate"))) I ENDDT=-1 S @RETURN@(0)="-1^EndDate: Ending Date is not a valid date" Q
 ;Set the first line of return
 S @RETURN@(0)=1_U_PARAM("SourceSystemID")_U_PARAM("SourceID")_U_$G(PARAM("IDTYPE"))_U_$G(PARAM("ASSIGNAUTH"))_U_$G(PARAM("BegDate"))_U_$G(PARAM("EndDate"))_U
 ;Get the IENs of audit records for this correlation that were recorded within the date range
 D GETAUD(200,+XUDUZ,BEGDT,ENDDT,.XUIENARR)
 ;
 ;Loop through audit entries and put audit values into the return global
 S (CNT,EDITDT)=0 F  S EDITDT=$O(@XUIENARR@(EDITDT)) Q:'EDITDT  D
 . S IEN=0 F  S IEN=$O(@XUIENARR@(EDITDT,IEN)) Q:'IEN  D
 .. ;Get the data for this audit record
 .. N DIC,DIA,DA,DIQ,DR,FLDNM,MENUOPT,NEWVAL,OLDVAL,PROTOPT,RECDT,USERDUZ,USERNM,VAL
 .. S DIC="^DIA(200,",DIA=200,DA=IEN,DIQ="VAL",DIQ(0)="EI",DR=".02;.03;.04;1.1;2;3;4.1;4.2"
 .. D EN^DIQ1
 .. ;
 .. I $G(VAL(1.1,IEN,.03,"I"))=11 Q  ;Do not include Verify code
 .. S RECDT=$TR($$FMTE^XLFDT($G(VAL(1.1,IEN,.02,"I")),"5SZ"),"@"," ") ;DATE/TIME RECORDED
 .. S FLDNM=$G(VAL(1.1,IEN,1.1,"E")) ;FIELD NAME
 .. S USERNM=$G(VAL(1.1,IEN,.04,"E")) ;USER
 .. S USERDUZ=$G(VAL(1.1,IEN,.04,"I")) ;DUZ
 .. S OLDVAL=$G(VAL(1.1,IEN,2,"E")) ;OLD VALUE
 .. S NEWVAL=$G(VAL(1.1,IEN,3,"E")) ;NEW VALUE
 .. S MENUOPT=$G(VAL(1.1,IEN,4.1,"E")) ;MENU OPTION
 .. S PROTOPT=$G(VAL(1.1,IEN,4.2,"E")) ;PROTOCOL or OPTION USED
 .. ;
 .. S CNT=CNT+1
 .. S @RETURN@(CNT)=RECDT_U_FLDNM_U_USERNM_U_USERDUZ_U_OLDVAL_U_NEWVAL_U_MENUOPT_U_PROTOPT
 ;
 S @RETURN@(0)=@RETURN@(0)_CNT
 K @XUIENARR
 Q
 ;
INTDATE(X) ;Get the internal form of the Date
 N %DT,Y
 Q:X="" ""
 S %DT="PX" D ^%DT
 Q Y
 ;
GETAUD(FILE,XUDUZ,BEGDT,ENDDT,RET) ;Build @RET@(auditDate,auditIEN) for audit records
 ; that pertain to the IEN in FILE and that were recorded between BEGDT and ENDDT, inclusive.
 N AIEN,EDITDT
 K @RET
 S:$G(BEGDT)="" BEGDT=0
 S:$G(ENDDT)="" ENDDT=9999999
 ;
 S AIEN=0 F  S AIEN=$O(^DIA(FILE,"B",XUDUZ,AIEN)) Q:'AIEN  D
 . Q:'$D(^DIA(FILE,AIEN,0))  S EDITDT=$P(^(0),U,2)
 . I EDITDT'<BEGDT,EDITDT<(ENDDT+1) S @RET@(EDITDT,AIEN)=""
 Q
