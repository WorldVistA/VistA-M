IBCNSC ;ALB/NLR - INSURANCE COMPANY EDIT ;6/1/05 9:42am
 ;;2.0;INTEGRATED BILLING;**46,137,184,276,320,371,400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;also used for IA #4694
 ;
EN ; -- main entry point for IBCNS INSURANCE COMPANY, IBCNS VIEW INS CO
 NEW IB1ST
 K IBFASTXT,VALMQUIT,VALMEVL,XQORS,^TMP("XQORS",$J),IBCNS
 S IBCHANGE="OKAY"
 I '$G(IBVIEW) D EN^VALM("IBCNS INSURANCE COMPANY") G ENQ
 D EN^VALM("IBCNS VIEW INS CO")
ENQ Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Insurance Company Information for: "_$E($P(^DIC(36,IBCNS,0),"^"),1,30)
 S VALMHDR(2)="Type of Company: "_$E($P($G(^IBE(355.2,+$P($G(^DIC(36,+IBCNS,0)),"^",13),0)),"^"),1,20)_"                     Currently "_$S(+($P($G(^DIC(36,+IBCNS,0)),"^",5)):"Inactive",1:"Active")
 Q
 ;
INIT ; -- init variables and list array
 K VALMQUIT
 S VALMCNT=0,VALMBG=1
 I '$D(IBCNS) D INSCO Q:$D(VALMQUIT)
 D BLD,HDR
 Q
BLD ; -- list builder
 NEW BLNKI
 K ^TMP("IBCNSC",$J)
 D KILL^VALM10()    ; delete all video attributes
 F BLNKI=1:1:62 D BLANK(.BLNKI)     ; 62 blank lines to start with
 D PARAM^IBCNSC01      ; billing parameters
 D MAIN^IBCNSC01       ; main mailing address
 D CLAIMS1^IBCNSC0     ; inpatient claims office
 D CLAIMS2^IBCNSC0     ; outpatient claims office
 D PRESCR^IBCNSC1      ; prescription claims office
 D APPEALS             ; appeals office
 D INQUIRY             ; inquiry office
 D DISP^IBCNSC02       ; parent/child associations (ESG 11/3/05)
 D PROVID^IBCNSC1      ; provider IDs
 D PAYER^IBCNSC01      ; payer/payer apps (ESG 7/29/02 IIV project)
 D REMARKS^IBCNSC01    ; remarks
 D SYN^IBCNSC01        ; synonyms
 S VALMCNT=+$O(^TMP("IBCNSC",$J,""),-1)
 Q
 ;
APPEALS ;
 N OFFSET,START,IBCNS14,IBADD
 S IBCNS14=$$ADDRESS^IBCNSC0(IBCNS,.14,7)
 S START=48,OFFSET=2
 D SET^IBCNSP(START,OFFSET+25," Appeals Office Information ",IORVON,IORVOFF)
 D SET^IBCNSP(START+1,OFFSET," Company Name: "_$P($G(^DIC(36,+$P(IBCNS14,"^",7),0)),"^",1))
 D SET^IBCNSP(START+2,OFFSET,"       Street: "_$P(IBCNS14,"^",1))
 D SET^IBCNSP(START+3,OFFSET,"     Street 2: "_$P(IBCNS14,"^",2))
 N OFFSET S OFFSET=45
 D SET^IBCNSP(START+1,OFFSET,"     Street 3: "_$P(IBCNS14,"^",3)) S IBADD=1
 D SET^IBCNSP(START+1+IBADD,OFFSET,"   City/State: "_$E($P(IBCNS14,"^",4),1,15)_$S($P(IBCNS14,"^",4)="":"",1:", ")_$P($G(^DIC(5,+$P(IBCNS14,"^",5),0)),"^",2)_" "_$E($P(IBCNS14,"^",6),1,5))
 D SET^IBCNSP(START+2+IBADD,OFFSET,"        Phone: "_$P(IBCNS14,"^",8))
 D SET^IBCNSP(START+3+IBADD,OFFSET,"          Fax: "_$P(IBCNS14,"^",9))
 Q
 ;
INQUIRY ;
 ;
 N OFFSET,START,IBCNS15,IBADD
 S IBCNS15=$$ADDRESS^IBCNSC0(IBCNS,.15,8)
 S START=55,OFFSET=2
 D SET^IBCNSP(START,OFFSET+25," Inquiry Office Information ",IORVON,IORVOFF)
 D SET^IBCNSP(START+1,OFFSET," Company Name: "_$P($G(^DIC(36,+$P(IBCNS15,"^",7),0)),"^",1))
 D SET^IBCNSP(START+2,OFFSET,"       Street: "_$P(IBCNS15,"^"))
 D SET^IBCNSP(START+3,OFFSET,"     Street 2: "_$P(IBCNS15,"^",2))
 N OFFSET S OFFSET=45
 D SET^IBCNSP(START+1,OFFSET,"     Street 3: "_$P(IBCNS15,"^",3)) S IBADD=1
 D SET^IBCNSP(START+1+IBADD,OFFSET,"   City/State: "_$E($P(IBCNS15,"^",4),1,15)_$S($P(IBCNS15,"^",4)="":"",1:", ")_$P($G(^DIC(5,+$P(IBCNS15,"^",5),0)),"^",2)_" "_$E($P(IBCNS15,"^",6),1,5))
 D SET^IBCNSP(START+2+IBADD,OFFSET,"        Phone: "_$P(IBCNS15,"^",8))
 D SET^IBCNSP(START+3+IBADD,OFFSET,"          Fax: "_$P(IBCNS15,"^",9))
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K VALMQUIT,IBCNS,IBCHANGE,IBFASTXT
 D CLEAN^VALM10
 Q
 ;
INSCO ; -- select insurance company
 NEW DLAYGO,DIC,X,Y,DTOUT,DUOUT
 I '$D(IBCNS) D  G:$D(VALMQUIT) INSCOQ
 .S DIC="^DIC(36,",DIC(0)="AEQMZ",DIC("S")="I '$G(^(5))"
 .I '$G(IBVIEW) S DLAYGO=36,DIC(0)=DIC(0)_"L"
 .D ^DIC K DIC
 .S IBCNS=+Y
 I $G(IBCNS)<1 K IBCNS S VALMQUIT="" G INSCOQ
INSCOQ ;
 K DIC
 Q
 ;
BLANK(LINE) ; -- Build blank line
 D SET^VALM10(.LINE,$J("",80))
 Q
 ;
EDIKEY() ; input transform code to determine if user is allowed to edit
 ; certain fields in the insurance company file
 NEW OK S OK=0
 I $$KCHK^XUSRB("IB EDI INSURANCE EDIT") S OK=1 G EDIKEYX
 D EN^DDIOL("You must hold the IB EDI INSURANCE EDIT security key to edit this field.",,"!!")
 D EN^DDIOL("",,"!!?5")
EDIKEYX ;
 Q OK
 ;
DUPQUAL(IBCNS,QUAL,FIELD) ; input transform to make sure that the sam qualifier is not used twice for
 ; payer secondary IDs.  There are two sets of fields in file 36 that can not be duplicated.
 ; 6.01 EDI INST SECONDARY ID QUAL(1) can not be the same as 6.03 EDI INST SECONDARY ID QUAL(2)
 ; 6.05 EDI PROF SECONDARY ID QUAL(1) can not be the same as 6.07 EDI PROF SECONDARY ID QUAL(2)
 ; 
 ; Input:
 ; IBCNS is the insurance company internal number
 ; QUAL  is the internal code of the value being input.
 ; FIELD is the field it is being compare with.
 ;
 ; Returns:
 ; TRUE/1 if they are the same (duplicate)
 ; FALSE/0 if they are not
 ;
 Q:$G(QUAL)="" 0  ; should not happen because this is invoked as an input transform
 Q:'+$G(IBCNS) 1  ; stop from editing through fileman
 N DUP
 S DUP=$$GET1^DIQ(36,+$G(IBCNS)_",",+$G(FIELD),"I")
 D CLEAN^DILF
 Q QUAL=DUP
