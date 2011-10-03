DGHTHLAA ;ALB/JRC - Home Telehealth Patient HL7 Application Acknowledgment;10 January 2005 ; 10/4/06 3:07pm
 ;;5.3;Registration;**644**;Aug 13, 1993;Build 11
 ;;
ACKMSG ; Process A03 and A04 'AA' messages for Home Telehealth Application
 ; Input  : All variables set by the HL7 package
 ; Output : None
 ;
 ;   Note: This process will update file # 391.31 subfile 391.317
 ;           Date/Time of ACK from HT        -  Field .06
 ;           ACK Code from HT                -  Field .07
 ;           Reject Message(Only if reject)  -  Field .08
 ;
 N DGHMSG,DGHPARAM,I,X
 ;
 ;Get message text
 S ^TMP("DGRUACK",$H)="START PROCESS"
 F I=1:1 X HLNEXT Q:(HLQUIT'>0)  D
 . S DGHMSG(I,1)=HLNODE
 . ; Check for segment length greater than 245
 . S X=0 F  S X=+$O(HLNODE(X)) Q:('X)  S DGHMSG(I,(X+1))=HLNODE(X)
 ;
 ;Quit if there is no valid message header
 Q:$P($G(DGHMSG(1,1)),"^")'="MSH"
 ;
 M ^TMP("DGRUACK",$H,"HL")=DGHMSG
 ;analyze the message and take appropriate action
 ;
 S X=1,DGHPARAM=""
 F  S X=+$O(DGHMSG(X)) Q:('X)  D
 . I $P(DGHMSG(X,1),"^")="MSA" D
 .. D PROCESS(DGHMSG(X,1),.DGHPARAM)
 Q
 ;
PROCESS(DGHMSG,DGHPARAM) ;
 N EVNTYPE,ACK,REJMSG,MSGID,IEN,SIEN,PATIENT,FLDS,DGHERR,DGHFDA,DATE
 ;Initialize variables
 S EVNTYPE=""
 ;
 ;Set incoming message event type
 S EVNTYPE=$G(HL("ETN"))
 ;
 Q:$G(DGHMSG)']""
 ;
 S ACK=$P(DGHMSG,"^",2)         ; Get acknowledgement code
 S REJMSG=$P(DGHMSG,"^",7)   ; Get Reject Message if it exist
 ;
 ;Get outgoing message ID
 S MSGID=$P(DGHMSG,U,3)
 ;
 ;Update Home Telehealth File (# 391.31) sub-file (#391.317)
 ;$order on "D" cross reference to resolve IEN and SIEN values
 ;for updating the record and sub record
 ;
 S IEN=0,IEN=$O(^DGHT(391.31,"D",MSGID,IEN)) Q:'+IEN
 S SIEN=0,SIEN=$O(^DGHT(391.31,"D",MSGID,IEN,SIEN)) Q:'+SIEN
 Q:$P($G(^DGHT(391.31,IEN,"TRAN",SIEN,0)),U,7)="A"
 ;Resolve external value for PATIENT
 S PATIENT=$$GET1^DIQ(2,$P($G(^DGHT(391.31,IEN,0)),U,2),.01,"E")
 S FLDS=SIEN_","_IEN_","
 ;If valid entries found update subfile 391.317
 I IEN&SIEN D
 .;Convert date to FM format
 .S DATE=$$FMTE^XLFDT($$FMDATE^HLFNC($P(HL("DTM"),"-",1)))
 .S DGHFDA(391.317,FLDS,.06)=DATE
 .S DGHFDA(391.317,FLDS,.07)=$S(ACK="AA":"A",ACK="AR":"R",1:"")
 .S DGHFDA(391.317,FLDS,.08)=$P(REJMSG,"~",2)
 .D FILE^DIE("EK","DGHFDA","DGHERR")
 .I $D(DGHERR) S DGHERR="Problem encountered while filing record # "_IEN
 ;
 ;If valid AA is receieved for message kill the "HTHNOACK" xref
 D:(ACK="AA")!(ACK="AR") KILLXREF^DGHTXREF(MSGID)
 ;
 ;Update inactivation date field (#6)
 I $P($G(^DGHT(391.31,IEN,"TRAN",SIEN,0)),U,4)="I",ACK="AA",'$D(DGHERR) D
 .N FLDS S FLDS=IEN_","
 .S DGHFDA(391.31,FLDS,6)=DATE
 .D FILE^DIE("EK","DGHFDA","DGHERR")
 ; 
 ;If the ACK is AA and 'DGHERR quit
 Q:ACK="AA"&'$D(DGHERR)
 ;
 ;If transaction is not found in subfile #391.317 set DGHERR variable
 I '+SIEN S DGHERR="Problem processing transaction record"
 ;
 ;Set DGHPARAM(4) to  error message if defined
 S DGHPARAM(4)=$S($D(DGHERR):DGHERR,ACK'="AA":$P(DGHMSG,"^",7),1:"")
 ;
 D MESSAGE
 Q
 ;
MESSAGE ;Build bulletin and send to mail group
 ;      Input:
 ;      Output:
 ;
 N MSGTEXT,XMTEXT,XMSUB,XMY,XMCHAN,XMZ,XMDUZ,MSGTYPE
 S MSGTYPE=$S(EVNTYPE["A04":"Sign-up/Activation",EVNTYPE["A03":"Inactivation",1:"")
 S MSGTEXT(1)=" "
 S MSGTEXT(2)="Home Telehealth "_MSGTYPE_" was REJECTED"
 S MSGTEXT(3)=" "
 S MSGTEXT(4)="Date:       "_$$FMTE^XLFDT(DATE,1)
 S MSGTEXT(5)="Patient:    "_PATIENT
 S MSGTEXT(6)="Message ID: "_MSGID
 S MSGTEXT(7)="Error Code: "_DGHPARAM(4)
 ;Send message to mail group
 S XMSUB="Home Telehealth Patient "_MSGTYPE_" Reject"
 S XMTEXT="MSGTEXT("
 S XMY("G.DGHTERR")=""
 S XMCHAN=1
 S XMDUZ="Home Telehealth Patient "_MSGTYPE
 D ^XMD
 Q
