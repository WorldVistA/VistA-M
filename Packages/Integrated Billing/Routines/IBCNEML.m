IBCNEML ;BP/YMG - MAILMAN NOTIFICATION TO LINK PAYERS ;27-AUG-2010
 ;;2.0;INTEGRATED BILLING;**438**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
EN ; entry point
 N ACTIVE,APP,DATA,IEN,INS,INSTID,LN,LOACT,MGRP,MSG,MSUBJ,NAACT,PAYER,PROFID,RPTDATA,STR1,STR2,TOTAL
 ; build a cross reference with all existing professional and institutional EDI ID numbers in file 36.
 S INS=0 F  S INS=$O(^DIC(36,INS)) Q:'INS  D
 .I '$$ACTIVE^IBCNEUT4(INS) Q  ; inactive ins co
 .S DATA=$G(^DIC(36,INS,3)) I $P(DATA,U,10)'="" Q  ; already linked to a payer
 .S PROFID=$P(DATA,U,2),INSTID=$P(DATA,U,4)
 .I PROFID'="" S RPTDATA("P",PROFID)=""
 .I INSTID'="" S RPTDATA("I",INSTID)=""
 .Q
 ; loop through payers - if there is an unlinked insurance company with the same prof/inst id, this payer has
 ; potential payer-insurance company links that have not yet been made.
 S (TOTAL,IEN)=0 F  S IEN=$O(^IBE(365.12,IEN)) Q:'IEN  D
 .I '$$ACTAPP^IBCNEUT5(IEN) Q  ; no active payer applications
 .; Must have at least 1 nationally active payer application
 .S APP=0,ACTIVE=0 F  S APP=$O(^IBE(365.12,IEN,1,APP)) Q:'APP!ACTIVE  D
 ..I $P($G(^IBE(365.12,IEN,1,APP,0)),U,2)=1 S ACTIVE=1
 ..Q
 .Q:'ACTIVE    ; no nationally active payer application found
 .S DATA=$G(^IBE(365.12,IEN,0)),PAYER=$P(DATA,U),PROFID=$P(DATA,U,5),INSTID=$P(DATA,U,6)
 .I PROFID'="",$D(RPTDATA("P",PROFID)) S:'$D(RPTDATA("PYR",IEN)) RPTDATA("PYR",IEN)="",TOTAL=TOTAL+1
 .I INSTID'="",$D(RPTDATA("I",INSTID)) S:'$D(RPTDATA("PYR",IEN)) RPTDATA("PYR",IEN)="",TOTAL=TOTAL+1
 .; if payer is nationally active, but locally inactive, add it to the list
 .S APP=$$PYRAPP^IBCNEUT5("IIV",IEN),(LOACT,NAACT)=0
 .I 'APP Q
 .S DATA=$G(^IBE(365.12,IEN,1,APP,0)),NAACT=$P(DATA,U,2),LOACT=$P(DATA,U,3)
 .I NAACT,'LOACT,$D(RPTDATA("PYR",IEN)) S RPTDATA("INACTIVE",IEN)=PAYER
 .Q
 ; create and send Mailman messages
 S MGRP=$$MGRP^IBCNEUT5(),STR1="Immediate Attention Required:",STR2="-----------------------------"
 I TOTAL D
 .S MSUBJ="ACTION REQ: POTENTIAL PAYERS TO BE LINKED",LN=0
 .S LN=LN+1,MSG(LN)="TOTAL NUMBER OF PAYERS WITH POTENTIAL INSURANCE COMPANY MATCHES: "_TOTAL
 .S LN=LN+1,MSG(LN)=""
 .S LN=LN+1,MSG(LN)=STR1
 .S LN=LN+1,MSG(LN)=STR2
 .S LN=LN+1,MSG(LN)="Please link the associated active insurance companies to these payers at your"
 .S LN=LN+1,MSG(LN)="earliest convenience. Please visit the e-Business Projects Webpage on VistA"
 .S LN=LN+1,MSG(LN)="University Website to download the Link Payer Instructions."
 .D MSG^IBCNEUT5(MGRP,MSUBJ,"MSG(")
 .Q
 I $D(RPTDATA("INACTIVE")) D
 .K MSG
 .S MSUBJ="ACTION REQ: PAYERS TO BE LOCALLY ACTIVATED",LN=0
 .S LN=LN+1,MSG(LN)="Nationally Active Payers that are Locally Inactive:"
 .S LN=LN+1,MSG(LN)="---------------------------------------------------"
 .S LN=LN+1,MSG(LN)=""
 .S IEN="" F  S IEN=$O(RPTDATA("INACTIVE",IEN)) Q:IEN=""  S LN=LN+1,MSG(LN)=$$FO^IBCNEUT1(RPTDATA("INACTIVE",IEN),79)
 .S LN=LN+1,MSG(LN)=""
 .S LN=LN+1,MSG(LN)=STR1
 .S LN=LN+1,MSG(LN)=STR2
 .S LN=LN+1,MSG(LN)="Please locally activate the payers after you link insurance companies to them."
 .S LN=LN+1,MSG(LN)="Please visit the e-Business Projects Webpage on VistA University Website to"
 .S LN=LN+1,MSG(LN)="download the Payer Activation Instructions."
 .D MSG^IBCNEUT5(MGRP,MSUBJ,"MSG(")
 .Q
 Q
