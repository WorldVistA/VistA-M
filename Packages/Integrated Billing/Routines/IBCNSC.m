IBCNSC ;ALB/NLR - INSURANCE COMPANY EDIT ;6/1/05 9:42am
 ;;2.0;INTEGRATED BILLING;**46,137,184,276,320,371,400,488,547**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
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
 ;WCJ;IB*2.0*547
 ;NEW BLNKI
 NEW BLNKI,IBACMAX ; new variable set in PARAM section and needed throughout for display
 ;
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
 ;
 ;WCJ;IB*2.0*547;Call new API
 ;S IBCNS14=$$ADDRESS^IBCNSC0(IBCNS,.14,7)
 S IBCNS14=$$ADD2^IBCNSC0(IBCNS,.14,7)
 ;
 ;WCJ;IB*2.0*547
 ;S START=48,OFFSET=2
 S START=49+(2*$G(IBACMAX)),OFFSET=2
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
 ;
 ;WCJ;IB*2.0*547;Call new API
 ;S IBCNS15=$$ADDRESS^IBCNSC0(IBCNS,.15,8)
 S IBCNS15=$$ADD2^IBCNSC0(IBCNS,.15,8)
 ;
 ;WCJ;IB*2.0*547
 ;S START=55,OFFSET=2
 S START=56+(2*$G(IBACMAX)),OFFSET=2
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
 NEW DLAYGO,DIC,X,Y,DTOUT,DUOUT,IBCNS3
 I '$D(IBCNS) D  G:$D(VALMQUIT) INSCOQ
 .S DIC="^DIC(36,",DIC(0)="AEQMZ",DIC("S")="I '$G(^(5))"
 .I '$G(IBVIEW) S DLAYGO=36,DIC(0)=DIC(0)_"L"
 .D ^DIC K DIC
 .S IBCNS=+Y
 .;/Beginning of IB*2.0*488 (vd)
 .I +IBCNS I $P($G(^DIC(36,+IBCNS,3)),"^",1)="" D     ; Set default for EDI=Transmit? to YES-LIVE
 ..S DR="3.01////1",DIE="^DIC(36,",DA=IBCNS D ^DIE K DIE
 ..;/End of IB*2.0*488 (vd)
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
DUPQUAL(IBCNS,QUAL,FIELD) ; input transform to make sure that the same qualifier is not used twice for
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
 ;
 ;WCJ;IB*2.0*547
ALLOWED(IBAC) ;  input transform to make sure that Administrative Contractor is set up in the site parameters.
 ; it will be set up for either commercial or medicare.  Since the type is defined my the plan and we are at a higher
 ; level in the Insurance Company, we have to allow both.
 ; called from ^DD(36.015,.01,0) and ^DD(36.016,.01,0)
 ;
 ;3/17/2016 - A decision was made to limit which type is allowed by using the TYPE OF COVERAGE field. (TAZ)
 ;
 ;
 ; Input:
 ; IBAC  is the internal code of the value being input.
 ;
 ; Returns:
 ; TRUE/1 if allowed (set up in site parameters)
 ; FALSE/0 if they are not
 ; 
 Q:$D(^IBE(350.9,1,$S($$GET1^DIQ(36,IBCNS_",","TYPE OF COVERAGE")="MEDICARE":81,1:82),"B",IBAC)) 1
 Q 0
 ;
 ; WCJ;IB*2.0*547
 ; This is to clean up any extraneous nodes if a user entered an alternate ID type, but not an actual ID.
CLEANIDS(INSIEN) ;
 ; INSIEN=Insurance Company IEN
 ;
 N NODE,LOOP,DATA,CLEANUP
 F NODE=15,16 D
 .S LOOP=0 F  S LOOP=$O(^DIC(36,INSIEN,NODE,LOOP))  Q:'+LOOP  S DATA=$G(^(LOOP,0)) I DATA]"",$P(DATA,U,2)="" D
 ..N DIK,DA
 ..S DA=LOOP,DA(1)=INSIEN
 ..S DIK="^DIC(36,"_INSIEN_","_NODE_","
 ..D ^DIK
 ..S CLEANUP=1
 I $G(CLEANUP) D
 . N DIR
 . S DIR("A",1)="Payer ID Types without corresponding ID# were deleted."
 . S DIR(0)="EA",DIR("A")="PRESS ENTER TO CONTINUE "
 . D ^DIR
 .Q
 Q
