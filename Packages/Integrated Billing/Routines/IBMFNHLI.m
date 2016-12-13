IBMFNHLI ;ALB/YMG - HL7 Process Incoming MFN Messages ;14-SEP-2015
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; entry point
 N APP,CNT,DATA,DATAMFK,DESC,FLN,FSVDY,HCT,HEDI,HLECH,HLFS,HLREP,IBCNACT,IBCNADT,IBSEG,ID,MSG,MSGID,NAFLG
 N NEWID,NPFLG,PEDI,PSVDY,REQSUB,SEG,SEGCNT,STAT,STOPFLG,SUBJ,TRUSTED,TSSN,X12TABLE,Z
 ;
 K ^TMP("IBMFNHLI",$J)
 S SUBJ="Incoming table update HL7 message problem" ; subject line for mailman error messages
 ;  Initialize the HL7 variables
 D INIT^HLFNC2("IB TBLUPD IN",.HL)
 S HLFS=HL("FS"),HLECH=$E(HL("ECH"),1),HLREP=$E(HL("ECH"),2)
 ; put message into a TMP global
 F SEGCNT=1:1 X HLNEXT Q:HLQUIT'>0  D
 .S CNT=0,^TMP("IBMFNHLI",$J,SEGCNT,CNT)=HLNODE
 .F  S CNT=$O(HLNODE(CNT)) Q:'CNT  S ^TMP("IBMFNHLI",$J,SEGCNT,CNT)=HLNODE(CNT)
 .Q
 S SEG=$G(^TMP("IBMFNHLI",$J,1,0))
 I $E(SEG,1,3)'="MSH" D  G ENX
 .S MSG(1)="MSH Segment is not the first segment found"
 .S MSG(2)="Please call the Help Desk and report this problem."
 .D MSG(SUBJ,"MSG(")
 .Q
 S MSGID=$P(SEG,HLFS,10) ; HL7 message control id
 ; build list of dictionary file numbers that can be updated (table updates)
 F Z=1,11:1:19,2,21:1:23 S X12TABLE("356.0"_Z)=""
 F Z=11:1:18 S X12TABLE("365.0"_Z)=""
 F Z=21:1:28 S X12TABLE("365.0"_Z)=""
 S X12TABLE(350.9)=""
 ; Decide if message belongs to "E-Pharm", "eIV", or "HCSR"
 S APP="",HCT=0,FLN=""
 F  S HCT=$O(^TMP("IBMFNHLI",$J,HCT)) Q:HCT=""  D SPAR I $G(IBSEG(1))="MFI" S FLN=$P($G(IBSEG(2)),$E(HLECH,1),1) Q
 I ",366.01,366.02,366.03,365.12,355.3,"[(","_FLN_",") S APP="E-PHARM"
 I $E(FLN,1,5)="356.0" S APP="HCSR"
 I $E(FLN,1,5)="365.0" S APP="IIV"
 I FLN=365.12 S (STOPFLG,HCT)=0 F  S HCT=$O(^TMP("IBMFNHLI",$J,HCT)) Q:HCT=""  D  Q:STOPFLG
 .D SPAR I $G(IBSEG(1))="ZPA" S APP=$G(IBSEG(3)) S:APP'="" STOPFLG=1
 .Q
 ; If unable to determine application, then quit
 I APP="" D  G ENX
 .S MSG(1)="Unable to determine application this message is for"
 .S MSG(2)="Message control id: "_MSGID
 .D MSG(SUBJ,"MSG(")
 .Q
 ;
 S HCT=1,(NAFLG,NPFLG,STOPFLG)=0,Z=""
 F  S HCT=$O(^TMP("IBMFNHLI",$J,HCT)) Q:HCT=""  D  Q:STOPFLG
 .D SPAR S SEG=$G(IBSEG(1))
 .I SEG="MFI" D
 ..S FLN=$P($G(IBSEG(2)),$E(HLECH,1),1)
 ..I APP="E-PHARM" D
 ...; Initialize MFK Message (Application Acknowledgement) variables
 ...S DATAMFK("MFI-1")=$G(IBSEG(2)) ; Master File Identifier
 ...S DATAMFK("MFI-3")=$G(IBSEG(4)) ; File-Level Event Code
 ...Q
 ..Q
 .I SEG="MFE" D
 ..I $G(FLN)="" S STOPFLG=1 D  Q
 ...S MSG(1)="File Number not found in MFN message"
 ...S MSG(2)="Message control id: "_MSGID
 ...D MSG(SUBJ,"MSG(")
 ...Q
 ..I '$$VFILE^DILFD(FLN) S STOPFLG=1 D  Q
 ...S MSG(1)="File "_FLN_" not found in the Data Dictionary"
 ...S MSG(2)="Message control id: "_MSGID
 ...D MSG(SUBJ,"MSG(")
 ...Q
 ..I APP="E-PHARM" D
 ...; Initialize MFK Message (Application Acknowledgement) variables
 ...S DATAMFK("MFE-1")=$G(IBSEG(2)) ; Record-Level Event Code
 ...S DATAMFK("MFE-4")=$G(IBSEG(5)) ; Primary Key Value
 ...S DATAMFK("MFE-5")=$G(IBSEG(6)) ; Primary Key Value Type
 ...; Transfer control to e-Pharmacy
 ...D ^IBCNRHLT
 ...Q
 ..I APP="IIV"!(APP="HCSR") D
 ...I FLN'=365.12 D  Q
 ....S DATA=$G(IBSEG(5))
 ....S ID=$$DECHL7^IBCNEHL2($P(DATA,$E(HLECH,1),1)),DESC=$$DECHL7^IBCNEHL2($P(DATA,$E(HLECH,1),2))
 ....D TFIL
 ....Q
 ...S IBCNACT=$G(IBSEG(2)) ; Pull the action code
 ...S IBCNADT=$G(IBSEG(4)) ; Effective Date
 ...Q
 ..Q
 .I SEG="ZP0" D
 ..I APP="IIV"!(APP="HCSR") D
 ...S ID=$$DECHL7^IBCNEHL2(IBSEG(3)),NEWID=$$DECHL7^IBCNEHL2(IBSEG(4))
 ...S DESC=$$DECHL7^IBCNEHL2(IBSEG(5)),HEDI=$$DECHL7^IBCNEHL2(IBSEG(6)),PEDI=$$DECHL7^IBCNEHL2(IBSEG(7))
 ...Q
 ..I APP="E-PHARM" D ^IBCNRHLT
 ..Q
 .I SEG="ZPA" D
 ..I APP="IIV"!(APP="HCSR") D
 ...S STAT=$S(IBSEG(4)="Y":1,1:0),TSSN=IBSEG(5),REQSUB=IBSEG(7)
 ...S FSVDY=IBSEG(8),PSVDY=IBSEG(9),TRUSTED=$S(IBSEG(10)="N":0,1:1)
 ...D PFIL
 ...Q
 ..Q
 .; Transfer control to e-Pharmacy on other segments
 .I ",ZCM,ZPB,ZPL,ZPT,ZRX,"[(","_SEG_","),APP="E-PHARM" D ^IBCNRHLT
 .Q
 ;
 ; Send MFK Message (Application Acknowledgement)?
 I HL("APAT")="AL",$G(EPHARM),'STOPFLG D ^IBCNRMFK
 ;
ENX ; exit point
 K ^TMP("IBMFNHLI",$J),HL,HLNEXT,HLNODE,HLQUIT
 Q
 ;
PFIL ;  Payer Table Filer
 ;  Set the action:
 ;     MAD=Add, MUP=Update, MDC=Deactivate, MAC=Reactivate
 N AIEN,APIEN,IBAPP,IBCNTYPE,IBDESC,IBID,IBNOK,IBSTR,IEN,OLDAF,OLDTF
 N DA,DD,DIC,DIE,DLAYGO,DO,DR,X,Y
 ;
 S IBNOK=0,IBAPP=($TR(APP," ")="")
 S IBCNADT=$$FMDATE^HLFNC(IBCNADT)
 I IBCNADT="" S IBCNADT=$$NOW^XLFDT()
 ;  If the action is MAD - Add the payer as new
 I IBCNACT="MAD" D  I IBNOK G PFILX
 .; Check certain required fields: Application, VA National & Payer Name
 .; If not populated, send MailMan message.
 .S IBID=($TR(ID," ")=""),IBDESC=($TR(DESC," ")="")
 .S IBNOK=IBAPP!IBID!IBDESC
 .I 'IBNOK D MAD(DESC) Q
 .S IBSTR="" I IBAPP S IBSTR="Application"
 .I IBID S:IBSTR]"" IBSTR=IBSTR_", " S IBSTR=IBSTR_"VA National"
 .I IBDESC S:IBSTR]"" IBSTR=IBSTR_", " S IBSTR=IBSTR_"Payer Name"
 .S MSG(1)="MAD action received.  "_IBSTR_" unknown."
 .S MSG(2)="Message control id: "_MSGID
 .D MSG(SUBJ,"MSG(")
 .Q
 I IBCNACT'="MAD" D FND
 I IEN<1!IBAPP D  G PFILX
 .S IBCNTYPE=$S(IBCNACT="MAD":"Add",IBCNACT="MUP":"Update",IBCNACT="MDC":"Deactivate",IBCNACT="MAC":"Reactivate",1:"Unknown")
 .S MSG(1)=IBCNTYPE_" ("_IBCNACT_") action received. Payer and/or Application may be unknown."
 .S MSG(2)="Message control id: "_MSGID
 .S MSG(3)="VA National : "_ID
 .S MSG(4)="Payer Name  : "_DESC
 .S MSG(5)="Application : "_APP
 .S MSG(6)=""
 .S MSG(7)="Log a Remedy Ticket for this issue."
 .S MSG(8)=""
 .S MSG(9)="Please include in the Remedy Ticket that VISTA did not receive the required"
 .S MSG(10)="information or the accurate information to add/update this Payer."
 .D MSG(SUBJ,"MSG(")
 .Q
 ;
 S DESC=$E(DESC,1,80)    ;restriction of the field in the DD
 S DIC=$$ROOT^DILFD(FLN)
 S DR=".01///^S X=DESC;.02////^S X=NEWID;.05////^S X=PEDI;.06////^S X=HEDI"
 ; If new payer, add the Date/Time created
 I NPFLG S DR=DR_";.04///^S X=$$NOW^XLFDT()"
 S DIE=DIC,DA=IEN D ^DIE
 ; currently there's nothing to file on application level for HCSR, so we can bail if HCSR application
 I APP="HCSR" G PFILX
 ;
 ;  Check for application
 S DIC="^IBE(365.13,",DIC(0)="X",X=APP D ^DIC
 S AIEN=+Y I AIEN<1 D
 .S DLAYGO=365.13,DIC(0)="L",DIC("P")=DLAYGO
 .S DIE=DIC,X=APP
 .K DD,DO D FILE^DICN K DO
 .S AIEN=+Y
 .Q
 ;
 S APIEN=$O(^IBE(365.12,IEN,1,"B",AIEN,""))
 I APIEN="" D
 .S DLAYGO=365.121,DIC(0)="L",DIC("P")=DLAYGO,DA(1)=IEN,X=AIEN
 .S DIC="^IBE(365.12,"_DA(1)_",1,",DIE=DIC
 .K DD,DO D FILE^DICN K DO
 .S APIEN=+Y,NAFLG=1
 ; get current values for Active and Trusted flags
 S OLDAF=$P(^IBE(365.12,IEN,1,APIEN,0),U,2),OLDTF=$P(^IBE(365.12,IEN,1,APIEN,0),U,7)
 S DA(1)=IEN,DA=APIEN,DIC="^IBE(365.12,"_DA(1)_",1,",DR=""
 ;
 I IBCNACT="MDC" S DR=DR_".11///^S X=1;.12////^S X=IBCNADT;",STAT=0
 I IBCNACT="MAC" S DR=DR_".11///^S X=0;.12///@;"
 S DR=DR_".02///^S X=STAT;.06///^S X=$$NOW^XLFDT()"
 I APP="IIV" D
 .S DR=DR_";.07///^S X=TRUSTED"
 .I IBCNACT'="MDC" S DR=DR_";.08///^S X=REQSUB;.1///^S X=TSSN;.14///^S X=FSVDY;.15///^S X=PSVDY"
 .Q
 ; if new application, add the Date/Time created
 I NAFLG S DR=DR_";.13///^S X=$$NOW^XLFDT()"
 ;
 S DIE=DIC D ^DIE
 ; Update flag logs
 I APP="IIV" D
 .I STAT'=OLDAF D UPDLOG("A",STAT,IEN,APIEN)
 .I TRUSTED'=OLDTF D UPDLOG("T",TRUSTED,IEN,APIEN)
 .Q
 I IBCNACT="MDC" D MDC Q
PFILX ;
 Q
 ;
TFIL ;  Non Payer Tables Filer
 N DA,DIC,DIE,DLAYGO,IEN,MAX,X,Y
 ;
 ; store the FILENAME, FIELDNAME and VALUE if the APP is IIV and FLN is 350.9.
 ; For file #350.9, DESC represents the FIELD NUMBER and ID represents the VALUE.
 I APP="IIV",FLN=350.9 D  Q
 .S DIE=FLN,DA=1,DR=DESC_"///"_ID
 .D ^DIE
 .Q
 ;
 S DIC(0)="X",X=ID,DIC=$$ROOT^DILFD(FLN)
 D ^DIC S IEN=+Y
 ; don't update existing entries
 I IEN>0 Q
 ;
 D FIELD^DID(FLN,.02,,"FIELD LENGTH","MAX")
 I MAX("FIELD LENGTH")>0 S DESC=$E(DESC,1,MAX("FIELD LENGTH")) ; restriction of the field in the DD
 ; add new entry to the table
 S DLAYGO=FLN,DIC(0)="L",DIC("DR")=".02///^S X=DESC"
 K DD,DO D FILE^DICN K DO
 Q
 ;
MAD(X) ;  Add an entry
 D FND
 I IEN>0 G MADX
 N DD,DIC,DIE,DLAYGO,DO,Y
 S DIC=$$ROOT^DILFD(FLN)
 S DLAYGO=FLN,DIC(0)="L",DIC("P")=DLAYGO,DIE=DIC
 K DD,DO D FILE^DICN K DO
 S IEN=+Y,NPFLG=1
MADX ;
 Q
 ;
FND ;  Find an existing Payer entry
 N D,DIC,X,Y
 S X=ID,DIC(0)="X",D="C",DIC=$$ROOT^DILFD(FLN)
 ; do a lookup with the "C" cross-reference
 D IX^DIC S IEN=+Y
 Q
 ;
MDC ;  Check for active transmissions and cancel
 N BUFF,HIEN,RIEN,STA,TQIEN
 F STA=1,2,4,6 S TQIEN="" D
 .F  S TQIEN=$O(^IBCN(365.1,"AC",STA,TQIEN)) Q:TQIEN=""  D
 ..;  If the record doesn't match the payer, quit
 ..I $P(^IBCN(365.1,TQIEN,0),U,3)'=IEN Q
 ..;  Set the status to 'Cancelled'
 ..D SST^IBCNEUT2(TQIEN,7)
 ..;  If a buffer entry, set to ! (bang)
 ..S BUFF=$P(^IBCN(365.1,TQIEN,0),U,5)
 ..I BUFF'="" D BUFF^IBCNEUT2(BUFF,17)
 ..;  Change any responses status also
 ..S HIEN=0 F  S HIEN=$O(^IBCN(365.1,TQIEN,2,HIEN)) Q:'HIEN  D
 ...S RIEN=$P(^IBCN(365.1,TQIEN,2,HIEN,0),U,3)
 ...;  If the Response status is 'Response Received', don't change it
 ...I $P(^IBCN(365,RIEN,0),U,6)=3 Q
 ...D RSP^IBCNEUT2(RIEN,7)
 ..Q
 .Q
 Q
 ;
UPDLOG(FLAG,VALUE,PIEN,APIEN) ; Update active/trusted flag logs
 ; FLAG - "A" for Active flag, "T" for Trusted flag
 ; VALUE - new flag value (0 or 1)
 ; PIEN - ien in PAYER file (365.12)
 ; APIEN - ien in APPLICATION sub-file (365.121)
 ;
 N FILE,IENSTR,UPDT
 I $G(FLAG)=""!($G(VALUE)="") Q
 I +$G(PIEN)=0!(+$G(APIEN)=0) Q
 S FILE=$S(FLAG="A":"365.1212",FLAG="T":"365.1213",1:"") I FILE="" Q
 S IENSTR="+1,"_APIEN_","_PIEN_","
 S UPDT(FILE,IENSTR,.01)=$$NOW^XLFDT()
 S UPDT(FILE,IENSTR,.02)=VALUE
 D UPDATE^DIE("E","UPDT")
 Q
 ;
MSG(XMSUB,XMTEXT) ;  Send a MailMan Message related to table update HL7 interface
 ;
 ;  Input Parameters
 ;   XMSUB = Subject Line (required)
 ;   XMTEXT = Message Text Array Name in open format:  "MSG(" (required)
 ;
 ; New MailMan variables and also some FileMan variables.  The FileMan
 ; variables are used and not cleaned up when sending to external
 ; internet addresses.
 N DIFROM,XMDUZ,XMDUN,XMZ,XMMG,XMSTRIP,XMROU,XMY,XMYBLOB
 N D0,D1,D2,DG,DIC,DICR,DISYS,DIW
 N MGRP,TMPSUB,TMPTEXT,TMPY,XX
 ;
 S XMDUZ=.5 ; send from postmaster DUZ
 ; mail group to send message to
 S MGRP="IBTUPD MESSAGE" I $G(MGRP)'="" S XMY("G."_MGRP)=""
 ; Store off subject, array reference and array of recipients
 S TMPSUB=XMSUB,TMPTEXT=XMTEXT
 M TMPY=XMY
 D ^XMD
 ;
 ; Error logic
 ; If there's an error message and the message was not originally sent
 ; to the postmaster, then send a message to the postmaster with this
 ; error message.
 ;
 I $D(XMMG),'$D(TMPY(.5)) D
 .S XMY(.5)="",XMTEXT=TMPTEXT,XMSUB="MailMan Error"
 .; Add XMMG error message as the first line of the message
 .S XX=999999
 .F  S XX=$O(@(XMTEXT_"XX)"),-1) Q:'XX  S @(XMTEXT_"XX+3)")=@(XMTEXT_"XX)")
 .S @(XMTEXT_"1)")="   MailMan Error:  "_XMMG
 .S @(XMTEXT_"2)")="Original Subject:  "_TMPSUB
 .S @(XMTEXT_"3)")="------Original Message------"
 .D ^XMD
 .Q
 Q
 ;
SPAR ;  Segment Parsing
 ;
 ; This tag will parse the current segment referenced by the HCT index
 ; and place the results in the IBSEG array.
 ;
 ; Input Variables
 ; HCT
 ;
 ; Output Variables
 ; IBSEG (ARRAY of fields in segment)
 ;
 N II,IJ,IK,IM,IS,ISBEG,ISCT,ISDATA,ISEND,ISPEC,LSDATA,NPC
 K IBSEG
 S ISCT="",II=0,IS=0 F  S ISCT=$O(^TMP("IBMFNHLI",$J,HCT,ISCT)) Q:ISCT=""  D
 .S IS=IS+1,ISDATA(IS)=$G(^TMP("IBMFNHLI",$J,HCT,ISCT))
 .I $O(^TMP("IBMFNHLI",$J,HCT,ISCT))="" S ISDATA(IS)=ISDATA(IS)_HLFS
 .S ISPEC(IS)=$L(ISDATA(IS),HLFS)
 .Q
 ;
 S IM=0,LSDATA=""
 F  S IM=IM+1 Q:IM>IS  D
 .S LSDATA=LSDATA_ISDATA(IM),NPC=ISPEC(IM)
 .F IJ=1:1:NPC-1 D
 ..S II=II+1,IBSEG(II)=$$CLNSTR^IBCNEHLU($P(LSDATA,HLFS,IJ),$E(HL("ECH"),1,2)_$E(HL("ECH"),4),$E(HL("ECH")))
 ..Q
 .S LSDATA=$P(LSDATA,HLFS,NPC)
 .Q
 Q
