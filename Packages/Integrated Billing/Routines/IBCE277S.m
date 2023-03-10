IBCE277S ;ALB/JRA - Create MailMan message from 277STAT data array
 ;;2.0;INTEGRATED BILLING;**650,665**;17-Jul-18;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POST(RESULT,ARG) ;Entry point to create MailMan message from ARG array
 ; Input: ARG
 N FLDNAM,FLDVAL,GLBO,MSGARY,BADCLM,BADLN,OCC
 S GLBO="^TMP(""IBCE277J"",$J,""OUT"")" K @GLBO
 ;;WCJ;IB*2.0*665;KILL THE KILL SWITCH
 ;;JWS;IB*2.0*650;STOP 277STAT FHIR PROCESSING (I.E. KILL SWITCH)
 ;;G QUIT
 ;S SUBJ="MCT"
 I $D(ARG)'>1 D  Q
 . S @GLBO@("Status")="0^ARG parameter is missing or has bad format"
 . D ENCODE^XLFJSONE(GLBO,"RESULT") S RESULT(1)="["_RESULT(1)_"]"
 S FLDNAM="" F  S FLDNAM=$O(ARG(FLDNAM)) Q:FLDNAM=""  D
 . S OCC=+$P(FLDNAM,".",2)
 . D GETVAL(FLDNAM,OCC)
 I $D(MSGARY)'>1 D  Q
 . S @GLBO@("Status")="0^ARG parameter has no usable data"
 . D ENCODE^XLFJSONE(GLBO,"RESULT") S RESULT(1)="["_RESULT(1)_"]"
 S BADCLM="",BADLN=0 D MAIL
 I BADCLM]"" D  Q
 . S @GLBO@("Status")="0^"_$S(BADCLM="XX":"Missing",1:"Bad")_" claim number"_$S(BADCLM="XX":"",1:" '"_BADCLM_"'")
 . D ENCODE^XLFJSONE(GLBO,"RESULT") S RESULT(1)="["_RESULT(1)_"]"
 I BADLN D  Q
 . S @GLBO@("Status")="0^Bad Line Type received in ARG parameter"
 . D ENCODE^XLFJSONE(GLBO,"RESULT") S RESULT(1)="["_RESULT(1)_"]"
 S @GLBO@("Status")="1^277STAT MailMan message created"
 D ENCODE^XLFJSONE(GLBO,"RESULT") S RESULT(1)="["_RESULT(1)_"]"
 K @GLBO
 Q
 ;
GETVAL(FLDNAM,OCC) ;;Get the value associated with the field name
 Q:($G(FLDNAM)=""!(OCC=""))
 S FLDVAL=$G(ARG(FLDNAM))
 ;Translate any '^' to '~' since the lines of the mailman message contain pieces delimited by '^'
 F  Q:FLDVAL'[U  S FLDVAL=$P(FLDVAL,U)_"~"_$P(FLDVAL,U,2,999)
 ;I $$UP^XLFSTR(FLDNAM)["TESTLIVE" S SUBJ=$S($$UP^XLFSTR(FLDVAL)="LIVE":"MCH",1:"MCT") Q
 D MSGLINE($P(FLDNAM,"."),FLDVAL,OCC)
 Q
 ;
MSGLINE(FLDNAM,FLDVAL,OCC) ;Add data to specified node in message array
 ;Each array node corresponds to a unique line in the MailMan message
 Q:$G(FLDNAM)=""
 N FLDDAT,FLDNUM,I,NODE
 F I=1:1 S FLDDAT=$P($T(MAPFLD+I),";;",2) Q:FLDDAT=""  D
 . Q:$$UP^XLFSTR(FLDNAM)'=$$UP^XLFSTR($P(FLDDAT,U))
 . S FLDNUM=$P(FLDDAT,"_",2),NODE=$P(FLDDAT,U,2),NODE=OCC_NODE Q:(NODE=""!('FLDNUM))
 . S $P(MSGARY(NODE),U,FLDNUM)=FLDVAL
 Q
 ;
CHKCLM(FLDVAL) ;;
 Q:$G(FLDVAL)="" 0
 N IBD,IBIFN
 S $P(IBD,U,2)=FLDVAL
 D STRTREC^IBCE277
 Q:'IBIFN 0
 Q 1
 ;
MAIL ;Assemble 277STAT MailMan message and create/send
 N BILL,GOTLN,LN,MSG,NODE,XMTO,SUBJ
 S GOTLN=0
 ;S XMTO("G."_SUBJ)=""
 S XMTO("G.MCH")=""
 S LN=$$SETMSG("RACUBOTH RUCH") ;'RACUBOTH RUCH' text needed for conditional in ^IBCESRV
 S NODE="" F  S NODE=$O(MSGARY(NODE)) Q:(NODE=""!(BADCLM]""!(BADLN)))  D
 . I NODE["LN" D  Q:BADLN!(BADCLM]"")
 . . I $P(MSGARY(NODE),U)'=$P(NODE,"LN",2) S BADLN=1 Q
 . . S BILL=$P(MSGARY(NODE),U,2) I '$$CHKCLM(BILL) S BADCLM=$S(BILL="":"XX",1:$$GETCLM^IBCE277(BILL))
 . I NODE["LN10" D PARSE(NODE,.LN) Q
 . S LN=$$SETMSG(MSGARY(NODE),LN)
 Q:BADCLM]""!(BADLN)
 S SUBJ="MCH 277STAT "_$S(BILL["-":$P(BILL,"-",2),1:BILL)
 S LN=$$SETMSG("99^$",LN),LN=$$SETMSG("NNNN",LN)
 D SENDMSG^XMXAPI(DUZ,SUBJ,"MSG",.XMTO)
 Q
 ;
SETMSG(DATA,LN) ;Set a line of the MailMan Message and return next line number
 S:'$G(LN) LN=1
 S MSG(LN)=$G(DATA),LN=LN+1
 Q LN
 ;
PARSE(NODE,LN) ;
 Q:($G(NODE)=""!('$G(LN)))
 N I,STATARY,STATMSG,STATLIM,TXT
 S STATLIM=200  ;Max characters for "Status Message" field on "10" line
 S STATMSG=$P(MSGARY(NODE),U,6)
 S TXT=MSGARY(NODE)
 I $L(STATMSG)'>STATLIM S LN=$$SETMSG(TXT,LN) Q
 D FSTRNG^IBJU1(STATMSG,STATLIM,.STATARY)
 F I=1:1:STATARY S $P(TXT,U,6)=STATARY(I),LN=$$SETMSG(TXT,LN)
 Q
 ;
QUIT ; kill switch
 S @GLBO@("Status")="0^277STAT FHIR process turned off...i.e. Kill Switch"
 D ENCODE^XLFJSONE(GLBO,"RESULT") S RESULT(1)="["_RESULT(1)_"]"
 Q
 ;
MAPFLD ;RPC_field_name (limit 45 char)^Array_node
 ;;HeaderData_1_ReturnMessageId^HDR
 ;;HeaderData_2_X12ProprietaryFlag^HDR
 ;;HeaderData_3_StatusDate^HDR
 ;;HeaderData_4_StatusTime^HDR
 ;;HeaderData_5_MRAStatus^HDR
 ;;HeaderData_6_TotalNumberClaimsSubmitted^HDR
 ;;HeaderData_7_TotalNumberClaimsRejected^HDR
 ;;HeaderData_8_TotalChargesSubmitted^HDR
 ;;HeaderData_9_TotalChargesRejected^HDR
 ;;HeaderData_10_PayerName^HDR
 ;;HeaderData_11_PayerId^HDR
 ;;HeaderData_12_PayerGenerated^HDR
 ;;HeaderData_13_Source^HDR
 ;;HeaderData_14_BatchReferenceNumber^HDR
 ;;MessageHeader_1_LineType^LN09
 ;;MessageHeader_2_BillNumber^LN09
 ;;MessageHeader_3_MessageNumber^LN09
 ;;MessageHeader_4_ErrorData^LN09
 ;;MessageHeader_5_ErrorField^LN09
 ;;MessageData_1_LineType^LN10
 ;;MessageData_2_BillNumber^LN10
 ;;MessageData_3_AcceptRejectCode^LN10
 ;;MessageData_4_WarnErrorInfoCode^LN10
 ;;MessageData_5_StatusCode^LN10
 ;;MessageData_6_StatusMessage^LN10
 ;;ClaimData_1_LineType^LN13
 ;;ClaimData_2_BillNumber^LN13
 ;;ClaimData_3_ClearinghouseTraceNumber^LN13
 ;;ClaimData_4_PayerStatusDate^LN13
 ;;ClaimData_5_PayerClaimNumber^LN13
 ;;ClaimData_6_SplitClaimIndicator^LN13
 ;;ClaimData_7_ClaimType^LN13
 ;;ClmSvcDtSubscrPatData_1_LineType^LN15
 ;;ClmSvcDtSubscrPatData_2_BillNumber^LN15
 ;;ClmSvcDtSubscrPatData_3_PatientLastName^LN15
 ;;ClmSvcDtSubscrPatData_4_PatientFirstName^LN15
 ;;ClmSvcDtSubscrPatData_5_PatientMiddleName^LN15
 ;;ClmSvcDtSubscrPatData_6_PatientIdNumber^LN15
 ;;ClmSvcDtSubscrPatData_7_SubscriberLastName^LN15
 ;;ClmSvcDtSubscrPatData_8_SubscriberFirstName^LN15
 ;;ClmSvcDtSubscrPatData_9_SubscriberMiddleName^LN15
 ;;ClmSvcDtSubscrPatData_10_SubscriberIdNumber^LN15
 ;;ClmSvcDtSubscrPatData_11_FirstServiceDate^LN15
 ;;ClmSvcDtSubscrPatData_12_LastServiceDate^LN15
 ;
 ;277STAT processing will error out if there is a line 20 and/or
 ; line 21 in the mailman message (see IBCESRV routine).
 ;;ServiceLineStatusData_1_LineType^LN20
 ;;ServiceLineStatusData_2_BillNumber^LN20
 ;;ServiceLineStatusData_3_AcceptRejectCode^LN20
 ;;ServiceLineStatusData_4_WarnErrorInfoCode^LN20
 ;;ServiceLineStatusData_5_StatusCode^LN20
 ;;ServiceLineStatusData_6_StatusMessage^LN20
 ;;ServiceLineStatusData_7_FreeTextMessage^LN20
 ;;ServiceLineStatusData_8_ServiceLineNumber^LN20
 ;;ServiceLineIdData_1_LineType^LN21
 ;;ServiceLineIdData_2_BillNumber^LN21
 ;;ServiceLineIdData_3_ServiceLineNumber^LN21
 ;;ServiceLineIdData_4_ServiceType^LN21
 ;;ServiceLineIdData_5_ServiceCode^LN21
 ;;ServiceLineIdData_6_Modifiers^LN21
 ;;ServiceLineIdData_7_UnitsOfService^LN21
 ;
