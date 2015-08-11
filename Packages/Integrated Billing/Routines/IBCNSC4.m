IBCNSC4 ;ALB/TMP - INSURANCE PLAN DETAIL SCREEN UTILITIES ; 09-AUG-94
 ;;2.0;INTEGRATED BILLING;**43,85,103,251,416,497,516**;21-MAR-94;Build 123
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
INIT ; -- Load the plan detail segments
 N IBLCNT
 K ^TMP("IBCNSCP",$J)
 K VALMQUIT
 S VALMBG=1,(IBLCNT,VALMCNT)=0
 D KILL^VALM10()
 ;
 Q:'$G(IBCPOL)
 ;
 S IBCPOLD=$G(^IBA(355.3,IBCPOL,0)),IBCND1=$G(^(1)),$P(IBCDFND,U,18)=IBCPOL
 S IBCPOLD2=$G(^IBA(355.3,IBCPOL,6)) ;; Daou/EEN adding BIN and PCN
 S IBCPOLDL=$G(^IBA(355.3,IBCPOL,2)) ;; Daou/EEN adding BIN and PCN
 D POLICY^IBCNSP0,UR,LIM,AB,VER,COMMENT
 Q
 ;
UR ; -- UR region
 N START,OFFSET
 ; MRD;IB*2.0*516 - Moved the UR section to be on its own lines, no
 ; longer to the right of the Plan Information.
 ;S START=1,OFFSET=43,VALMCNT=+$O(@VALMAR@(""),-1)
 S START=+$O(@VALMAR@(""),-1)+1,OFFSET=2,VALMCNT=+$O(@VALMAR@(""),-1)
 D SET(START,OFFSET," Utilization Review Info ",IORVON,IORVOFF)
 D SET(START+1,OFFSET,"         Require UR: "_$$EXPAND^IBTRE(355.3,.05,$P(IBCPOLD,"^",5)))
 D SET(START+2,OFFSET,"   Require Amb Cert: "_$$EXPAND^IBTRE(355.3,.12,$P(IBCPOLD,"^",12)))
 D SET(START+3,OFFSET,"   Require Pre-Cert: "_$$EXPAND^IBTRE(355.3,.06,$P(IBCPOLD,"^",6)))
 D SET(START+4,OFFSET,"   Exclude Pre-Cond: "_$$EXPAND^IBTRE(355.3,.07,$P(IBCPOLD,"^",7)))
 D SET(START+5,OFFSET,"Benefits Assignable: "_$$EXPAND^IBTRE(355.3,.08,$P(IBCPOLD,"^",8)))
 Q
 ;
LIM ; Plan coverage limitations region
 N START,OFFSET
 S START=+$O(@VALMAR@(""),-1)+$S($P($G(IBCPOLD),U,14)]"":3,1:2),OFFSET=2
 D BLANK(START-1) S VALMCNT=VALMCNT+1
 D LIMBLD^IBCNSC41(START,OFFSET,.IBLCNT)
 Q
 ;
AB ; -- Annual benefit years region
 N OFFSET,START,ADT,Z
 S START=+$O(@VALMAR@(""),-1)+2,OFFSET=2
 D BLANK(START-1) S VALMCNT=VALMCNT+1
 D SET(START,OFFSET," Annual Benefit Dates ",IORVON,IORVOFF)
 I $O(^IBA(355.4,"APY",IBCPOL,""))="" D SET(START+1,OFFSET+2,"No Annual Benefits Information") G ABQ
 S ADT="" F Z=0:1:6 S ADT=$O(^IBA(355.4,"APY",IBCPOL,ADT)) Q:'ADT  D SET(START+1,OFFSET+3+(10*Z),$$DAT1^IBOUTL(-ADT))
 I ADT'="",$O(^IBA(355.4,"APY",IBCPOL,ADT))'="" D SET(START+1,OFFSET+3+(10*(Z+1)),"*More dates on file - use AB to see them")
ABQ Q
 ;
VER ; -- Plan detail User Information Region
 N OFFSET,START
 S START=+$O(@VALMAR@(""),-1)+2,OFFSET=2
 D BLANK(START-1) S VALMCNT=VALMCNT+1
 D SET(START,OFFSET," User Information ",IORVON,IORVOFF)
 I IBCND1="" D SET(START+1,OFFSET,"No User Information") G VERQ
 D SET(START+1,OFFSET,"      Entered By: "_$E($P($G(^VA(200,+$P(IBCND1,"^",2),0)),"^",1),1,20))
 D SET(START+2,OFFSET,"      Entered On: "_$$DAT1^IBOUTL(+IBCND1))
 D SET(START+3,OFFSET," Last Updated By: "_$E($P($G(^VA(200,+$P(IBCND1,"^",6),0)),"^",1),1,20))
 D SET(START+4,OFFSET," Last Updated On: "_$$DAT1^IBOUTL(+$P(IBCND1,"^",5)))
VERQ Q
 ;
COMMENT ; -- Plan detail comment region
 N START,OFFSET,LINE
 S START=+$O(@VALMAR@(""),-1)+2,OFFSET=2,LINE=1
 D BLANK(START-1) S VALMCNT=VALMCNT+1
 D SET(START,OFFSET," Plan Comments ",IORVON,IORVOFF)
 S IBI=0
 F LINE=LINE:1 S IBI=$O(^IBA(355.3,+IBCPOL,11,IBI)) Q:'IBI  D SET(START+LINE,OFFSET,"  "_$E($G(^IBA(355.3,+IBCPOL,11,IBI,0)),1,80))
 D SET(START+LINE,OFFSET,"  ")
 S IBLCNT=$G(IBLCNT)+LINE
 Q
 ;
BLANK(LINE) ; -- Build blank line
 D SET^VALM10(.LINE,$J("",90))
 Q
 ;
SET(LINE,COL,TEXT,ON,OFF) ; -- set display info in array
 I '$D(@VALMAR@(LINE,0)) D BLANK(.LINE) S VALMCNT=$G(VALMCNT)+1
 D SET^VALM10(.LINE,$$SETSTR^VALM1(.TEXT,@VALMAR@(LINE,0),.COL,$L(TEXT)))
 D:$G(ON)]""!($G(OFF)]"") CNTRL^VALM10(.LINE,.COL,$L(TEXT),$G(ON),$G(OFF))
 W:'(LINE#5) "."
 Q
 ;
HDR ; Active plan list header
 N IBCNS0,IBLEAD,X,X2
 S IBCNS0=$G(^DIC(36,+IBCNS,0))
 S IBLEAD=$S($G(IBIND):"All ",1:"")_$S($G(IBW):"",1:"Active ")_"Plans for: "_$P(IBCNS0,U)_" Insurance Company"
 S VALMHDR(1)=$$SETSTR^VALM1(IBLEAD,"",1,80)
 S X=$TR($J("",$L(IBLEAD)),""," ")
 S VALMHDR(2)=$$SETSTR^VALM1(X,"",$L(IBLEAD)+1,80)
 S X="#" I $G(IBIND) S X="#  + => Indiv. Plan"
 I $G(IBW) S X=$E(X_$J("",23),1,23)_"* => Inactive Plan"
 S VALMHDR(3)=$$SETSTR^VALM1("Pre-  Pre-  Ben",X,64,17)
 Q
 ;
