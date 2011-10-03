IBCNEHLU ;DAOU/ALA - HL7 Utilities ;10-JUN-2002  ; Compiled December 16, 2004 15:36:12
 ;;2.0;INTEGRATED BILLING;**184,300,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
HLP(PROTOCOL) ;  Find the Protocol IEN
 Q +$O(^ORD(101,"B",PROTOCOL,0))
 ;
NAME(NM) ;  Convert a name that isn't in standard VISTA format -
 NEW LNM,FNM,MI
 ;
 I NM?." " Q NM
 ;  LastName,FirstName MI
 I NM["," Q NM
 ;
 ; Remove double-spaces from name
 F  Q:$L(NM,"  ")<2  S NM=$P(NM,"  ",1)_" "_$P(NM,"  ",2,9999)
 ;
 ; Trim leading/trailing spaces
 S NM=$$TRIM^XLFSTR(NM)
 ;
 ; Find number of spaces in name
 S II=$L(NM," ")
 ;
 I II>3 Q NM
 I II=3 S FNM=$P(NM," ",1),MI=" "_$P(NM," ",2),LNM=$P(NM," ",3)
 I II=2 S FNM=$P(NM," ",1),LNM=$P(NM," ",2),MI=""
 I II<2 Q NM
 Q LNM_","_FNM_MI
 ;
DODCK(DFN,DOD,MGRP,NAME,RIEN,SSN) ;  Date of death check
 ;
 ; Input Variables
 ; DFN, DOD, MGRP, NAME, RIEN, SSN
 ;
 N CDOD,CIDDSP,IDDSP,IDSSN,MSG,XMSUB
 S CDOD=$P($G(^DPT(DFN,.35)),U,1),CIDDSP=$$FMTE^XLFDT(CDOD,"5Z")
 S IDDSP=$$FMTE^XLFDT(DOD,"5Z")
 S IDSSN=$E(SSN,$L(SSN)-3,$L(SSN))
 ;
 ; If the two dates of death are the same, quit
 I CDOD=DOD G DODCKX
 ;
 ;  If no current date of death but payer sent one
 I CDOD="" D  G DODCKX
 . ;  Send an email message
 . S XMSUB="Date of Death Received"
 . S MSG(1)="A Date of Death ("_IDDSP_") was received for patient: "_NAME_"/"_IDSSN_" "_$$GETDOB^IBCNEDEQ(DFN)_" from"
 . S MSG(2)="payer "_$$GET1^DIQ(365,RIEN,.03,"E")_".  There is no current Date of Death on file for "
 . S MSG(3)="this patient."
 . D TXT^IBCNEUT7("MSG")
 . D MSG^IBCNEUT5(MGRP,XMSUB,"MSG(")
 ;
 S XMSUB="Variant Date of Death"
 S MSG(1)="A Date of Death ("_IDDSP_") was received for patient: "_NAME_"/"_IDSSN_" "_$$GETDOB^IBCNEDEQ(DFN)_" from payer "_$$GET1^DIQ(365,RIEN,.03,"E")_"."
 S MSG(2)="This Date of Death does not currently match the Date of Death ("_CIDDSP_") on file for this patient. "
 D TXT^IBCNEUT7("MSG")
 D MSG^IBCNEUT5(MGRP,XMSUB,"MSG(")
DODCKX   ;
 Q
 ;
SPAR     ;  Segment Parsing
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
 ;
 ;Reset IBSEG
 K IBSEG
 ;
 S ISCT="",II=0,IS=0
 F  S ISCT=$O(^TMP($J,"IBCNEHLI",HCT,ISCT)) Q:ISCT=""  D
 . S IS=IS+1
 . S ISDATA(IS)=$G(^TMP($J,"IBCNEHLI",HCT,ISCT))
 . I $O(^TMP($J,"IBCNEHLI",HCT,ISCT))="" S ISDATA(IS)=ISDATA(IS)_HLFS
 . S ISPEC(IS)=$L(ISDATA(IS),HLFS)
 ;
 S IM=0,LSDATA=""
LP S IM=IM+1 Q:IM>IS
 S LSDATA=LSDATA_ISDATA(IM),NPC=ISPEC(IM)
 F IJ=1:1:NPC-1 D
 . S II=II+1,IBSEG(II)=$$CLNSTR($P(LSDATA,HLFS,IJ),$E(HL("ECH"),1,2)_$E(HL("ECH"),4),$E(HL("ECH")))
 S LSDATA=$P(LSDATA,HLFS,NPC)
 G LP
CLNSTR(STRING,CHARS,SUBSEP)      ; Remove extra trailing components and subcomponents in the HL7 seg
 ;
 N NUMPEC,PEC,RTSTRING
 ;
 S RTSTRING=$$RTRIMCH(STRING,CHARS)
 ; Now we have string w/o trailing chars, remove from subs
 S NUMPEC=$L(RTSTRING,SUBSEP)
 F PEC=1:1:NUMPEC S $P(RTSTRING,SUBSEP,PEC)=$$RTRIMCH($P(RTSTRING,SUBSEP,PEC),CHARS)
 Q RTSTRING
 ;
RTRIMCH(STR,CHRS) ; Remove the trailing chars from string
 ;
 N R,L
 ;
 S L=1,CHRS=$G(CHRS," ")
 F R=$L(STR):-1:1 Q:CHRS'[$E(STR,R)
 I L=R,(CHRS[$E(STR)) S STR=""
 Q $E(STR,L,R)
 ;
 ;
GTICNM(ICN,NAME) ; Retrieve PID segment and set ICN and patient name
 ;
 N HCT,ERFLG,SEG,IBSEG
 S (HCT,ICN,NAME)="",ERFLG=0
 F  S HCT=$O(^TMP($J,"IBCNEHLI",HCT)) Q:HCT=""  D  Q:ERFLG
 .  D SPAR
 .  S SEG=$G(IBSEG(1)) Q:SEG'="PID"
 .  S ICN=$G(IBSEG(4)),NAME=$G(IBSEG(6)),ERFLG=1
 Q
 ;
PATISSUB(IDATA0) ; check if patient is the subscriber
 ; IDATA0 - 0 node of file 2.312
 ;
 ; returns 1 if patient is the subscriber, 0 otherwise
 ;
 N PREL,RES
 S RES=0
 ; check field 2.312/16 first
 S PREL=$P(IDATA0,U,16) I PREL'="" S:PREL="01" RES=1 Q RES
 ; if 2.312/16 is empty, try field 2.312/6
 I $P(IDATA0,U,6)="v" S RES=1
 Q RES
 ;
ONEPOL(PIEN,IEN2) ; check if patient has only one policy on file for a given payer
 ; PIEN - payer ien
 ; IEN2 - patient ien (file 2)
 ;
 ; returns 1 if only one policy is found, 0 otherwise
 N CNT,IEN36,IEN312,RES
 S (CNT,RES)=0
 I +$G(PIEN)'>0!(+$G(IEN2)'>0) Q RES
 S IEN36="" F  S IEN36=$O(^DIC(36,"AC",PIEN,IEN36)) Q:IEN36=""  D
 .S IEN312="" F  S IEN312=$O(^DPT(IEN2,.312,"B",IEN36,IEN312)) Q:IEN312=""  S CNT=CNT+1
 .Q
 I CNT=1 S RES=1
 Q RES
 ;
MCRDT(RIEN,EBIEN) ; find effective date for Medicare response
 ; RIEN - file 365 ien
 ; EBIEN - subfile 365.02 ien
 ;
 ; returns date in FM format or "" if effective date was not found
 ;
 N DONE,DTIEN,IENS,RES,Z
 S RES="",DONE=0
 S Z="" F  S Z=$O(^IBCN(365,RIEN,2,EBIEN,8,"B",Z)) Q:Z=""!DONE  D
 .S DTIEN=$O(^IBCN(365,RIEN,2,EBIEN,8,"B",Z,"")) I 'DTIEN Q
 .S IENS=DTIEN_","_EBIEN_","_RIEN_","
 .; effective date has "eligibility" qualifier
 .I $$GET1^DIQ(365.28,IENS,.03)=307 S RES=$$FMDATE^HLFNC($$GET1^DIQ(365.28,IENS,.02)),DONE=1
 .Q
 Q RES
 ;
ISMCR(RIEN) ; check if response is for Medicare part A/B
 ; RIEN - file 365 ien
 ;
 ; returns a four piece string:
 ;   piece 1 = 1 if response if for Medicare, 0 otherwise
 ;   piece 2 = "MA" if response is for Medicare Part A
 ;           = "MB" if response is for Medicare Part B
 ;           = "B" if response is for both Part A and Part B
 ;           = "" if respnse if not for Medicare
 ;   piece 3 = effective date for Medicare Part A if response if for Part A or both parts, "" otherwise
 ;   piece 4 = effective date for Medicare Part B if response if for Part B or both parts, "" otherwise
 ;
 N DONE,EBIEN,RES,TYPE,Z
 S RES="0^",DONE=0
 I +RIEN'>0 Q RES
 I '$D(^IBCN(365,RIEN)) Q RES
 S Z="" F  S Z=$O(^IBCN(365,RIEN,2,"B",Z)) Q:Z=""!DONE  D
 .S EBIEN=$O(^IBCN(365,RIEN,2,"B",Z,"")),TYPE=$$GET1^DIQ(365.02,EBIEN_","_RIEN_",",.05)
 .I TYPE="MA" S $P(RES,U)=1,$P(RES,U,2)=$S($P(RES,U,2)="":"MA",1:"B"),$P(RES,U,3)=$$MCRDT(RIEN,EBIEN)
 .I TYPE="MB" S $P(RES,U)=1,$P(RES,U,2)=$S($P(RES,U,2)="":"MB",1:"B"),$P(RES,U,4)=$$MCRDT(RIEN,EBIEN)
 .I $P(RES,U,2)="B" S DONE=1
 .Q
 Q RES
