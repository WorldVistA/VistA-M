IBCNEDEQ ;DAOU/ALA - Process eIV Transactions continued ;21-AUG-2002
 ;;2.0;INTEGRATED BILLING;**184,271,300,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program contains some subroutines for processing a transmission
 ;
HLER ;  HL7 Creation error message
 ;
 ;  Called from IBCNEDEP
 ;
 ;  Parameters
 ;    HLRESLT = Error from GENERATE^HLMA call
 ;    DFN = Patient IEN
 ;    PAYR = Payer IEN
 ;    MGRP = Mail group
 ;    XMSUB = Subject line
 ;    MSG = Message array
 ;
 S HLRESLT="Error - "_$P(HLRESLT,U,2,99)
 S MSG(1)=HLRESLT
 S MSG(2)="occurred when trying to create the outgoing HL7 message for"
 S MSG(3)="Patient: "_$P($G(^DPT(DFN,0)),U,1)_$$SSN(DFN)_" and Payer: "_$P($G(^IBE(365.12,PAYR,0)),U,1)_"."
 S MSG(4)="Please contact the Help Desk and report this problem."
 D TXT^IBCNEUT7("MSG")
 S XMSUB="eIV HL7 Creation Error"
 D MSG^IBCNEUT5(MGRP,XMSUB,"MSG(")
 K XMSUB,MSG,HLRESLT
 Q
 ;
CERR ;  Communication Error Mail Message - No Retries defined
 ;
 ;  Called from IBCNEDEP
 ;
 ;  Parameters
 ;    DFN = Patient IEN
 ;    PAYR = Payer IEN
 ;    FMSG = Failure message flag
 ;    MGRP = Mail group
 ;    XMSUB = Subject line
 ;    MSG = Message array
 ;
 I 'FMSG G CERRQ
 S XMSUB="eIV Communication Error"
 S MSG(1)="VistA was unable to electronically confirm insurance for"
 S MSG(2)="Patient: "_$P($G(^DPT(DFN,0)),U)_$$SSN(DFN)_" and Payer: "_$P($G(^IBE(365.12,PAYR,0)),U)_"."
 S MSG(3)="A single attempt was made to electronically confirm the insurance"
 S MSG(4)="with this payer."
 ;
 D TXT^IBCNEUT7("MSG")
 ;
 D MSG^IBCNEUT5(MGRP,XMSUB,"MSG(")
 K MSG,XMSUB
CERRQ Q
 ;
CERE ;  Communication Error Mail Message - Exceeds Retries
 ;
 ;  Called from IBCNEDEP
 ;
 ;  Parameters
 ;    DFN = Patient IEN
 ;    PAYR = Payer IEN
 ;    FMSG = Failure message flag
 ;    MGRP = Mail group
 ;    XMSUB = Subject line
 ;    MSG = Message array
 ;
 I 'FMSG G CEREQ
 S XMSUB="eIV Communication Error"
 S MSG(1)="VistA was unable to electronically confirm insurance for"
 S MSG(2)="Patient: "_$P($G(^DPT(DFN,0)),U)_$$SSN(DFN)_" and Payer: "_$P($G(^IBE(365.12,PAYR,0)),U)_"."
 ;
 D TXT^IBCNEUT7("MSG")
 ;
 D MSG^IBCNEUT5(MGRP,XMSUB,"MSG(")
 K MSG,XMSUB
CEREQ Q
 ;
SUB ;  Create HL7 subrecord in TQ file
 ;
 ;  Called from tag SCC within this routine
 ;
 ;  Input Parameters
 ;    IEN = the transmission IEN
 ;    RSIEN = the response IEN
 ;    MDTM = the date/time message was created
 ;    MSGID = the HL7 message ID
 ;
 NEW DIC,DIE,X,DA,DLAYGO,Y
 S DIC="^IBCN(365.1,"_IEN_",2,",DIE=DIC,X=MDTM,DA(1)=IEN
 S DLAYGO=365.16,DIC(0)="L",DIC("P")=DLAYGO
 I '$D(^IBCN(365.1,IEN,2,0)) S ^IBCN(365.1,IEN,2,0)="^365.16D^^"
 K DD,DO
 D FILE^DICN
 K DO
 S HIEN=+Y
 S DR=".02////^S X=MSGID;.03////^S X=RSIEN" D ^DIE
 S DA=HIEN D ^DIE
 ;
 K HIEN,RSIEN,DR,MDTM
 Q
 ;
RESP ;  Create Response Record
 ;
 ;  Called from IBCNEHL3 tag SCC within this routine
 ;
 ;  Input Parameters
 ;    MSGID = Message Control ID (required)
 ;    MDTM = Message date/time created (optional)
 ;    DFN = Patient IEN (optional)
 ;    PAYR = Payer IEN (optional)
 ;    BUFF = Buffer IEN (optional)
 ;    IEN = Transmission IEN (optional)
 ;    RSTYPE = Response Type (O=Original, U=Unsolicited)
 ;
 NEW DIC,DIE,X,DA,DLAYGO,Y,RARRAY
 S DIC="^IBCN(365,",X=MSGID,DLAYGO=365,DIC(0)="L",DIC("P")=DLAYGO
 K DD,DO
 D FILE^DICN
 K DO
 S RSIEN=+Y
 S RARRAY(365,RSIEN_",",.02)=$G(DFN),RARRAY(365,RSIEN_",",.03)=$G(PAYR)
 I $G(IEN)'="" D
 . I $P(^IBCN(365.1,IEN,0),U,18)=1 S RARRAY(365,RSIEN_",",.04)=$G(BUFF)
 S RARRAY(365,RSIEN_",",.05)=$G(IEN)
 S RARRAY(365,RSIEN_",",.06)=2,RARRAY(365,RSIEN_",",.08)=$G(MDTM)
 ;
 I $G(RSTYPE)="" S RSTYPE="U"
 S RARRAY(365,RSIEN_",",.1)=RSTYPE
 ;
 D FILE^DIE("I","RARRAY","ERR")
 I $D(ERR) D
 . S ERFLG=1,MCT=0,VEN=0
 . F  S VEN=$O(ERR("DIERR",VEN)) Q:'VEN  D
 .. S MCT=MCT+1,MSG(MCT)=$G(ERR("DIERR",VEN,"TEXT",1))
 . ;
 . S MCT=MCT+1,MSG(MCT)="Please contact the Help Desk and report this problem."
 . S XMSUB="Error creating Response"
 . D MSG^IBCNEUT5(MGRP,XMSUB,"MSG(")
 . K ERR,VEN,MCT
 Q
 ;
TMRR ;  Communication Timeout message
 I 'TMSG Q
 S XMSUB="eIV Communication Timeout"
 S MSG(1)="No Response has been received within the defined failure days of "_FAIL_" for "
 S MSG(3)="Patient: "_$P($G(^DPT(DFN,0)),U,1)_$$SSN(DFN)_" and Payer: "_$P($G(^IBE(365.12,PAYR,0)),U,1)
 ;
 D TXT^IBCNEUT7("MSG")
 ;
 D MSG^IBCNEUT5(MGRP,XMSUB,"MSG(")
 K MSG,XMSUB
 Q
 ;
SSN(DFN) ; Retrieve patient's ssn and return last 4 digits
 ; Subsequently added Date of Birth to display as well
 Q:'$G(DFN) ""
 N SSN,DOB
 S SSN=$$GETSSN^IBCNEDE5(DFN)
 S DOB=$$GETDOB(DFN)
 I SSN="",DOB="" Q ""
 I SSN="" Q " (DOB: "_DOB_")"
 S SSN=" (SSN: xxx-xx-"_$E(SSN,6,9)
 I DOB'="" S DOB="  DOB: "_DOB
 Q SSN_DOB_")"
 ;
GETDOB(DFN) ;
 Q:'$G(DFN) "Unknown"
 N DOB
 S DOB=$P($G(^DPT(DFN,0)),U,3)
 S DOB=$S('DOB:"Unknown",1:$$FMTE^XLFDT(DOB,"5Z"))
 Q DOB
 ;
SCC ;  If successfully creates an HL7 msg
 S MSGID=$P(HLRESLT,U,1),NTRAN=NTRAN+1,MDTM=$$NOW^XLFDT(),IHCNT=IHCNT+1
 I NTRAN>1 S NRETR=NRETR+1
 D SST^IBCNEUT2(IEN,2)
 S DA=IEN,DIE="^IBCN(365.1,",DR=".07////^S X=NTRAN;.08////^S X=NRETR"
 D ^DIE
 ;
 ;  Create Response Record
 S RSTYPE="O" D RESP
 ;
 ;  Create HL7 subrecord
 D SUB
 ;
 ; If a buffer entry exists, set the buffer symbol to a '?'
 I BUFF'="" D BUFF^IBCNEUT2(BUFF,10)
 Q
