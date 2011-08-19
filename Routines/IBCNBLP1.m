IBCNBLP1 ;ALB/ARH-Ins Buffer: LM buffer process build ;1 Jun 97
 ;;2.0;INTEGRATED BILLING;**82,133**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
PATLST(IBCNT,DFN,CMPDATA) ; collect and display all the patients insurance policies
 ; if the buffer field data (CMPDATA) matches the displayed insurance entry's data, then that data is displayed in bold
 N IBINS,IBY,IBX,IB0,IBG0,IBI0,IBLINE,IBPLDA,IBBOLD,IBFND,IBDA S IBFND=0,IBCNT=+$G(IBCNT)
 ;
 D ALL^IBCNS1(DFN,"IBINS")
 ;
 S IBY=$J("",26)_"Patient's Existing Insurance" D SET(IBY,1,"","R")
 S IBY="   Insurance Company    Group #        Subscriber Id  Holder  Effective Expires" D SET(IBY,1,"","U")
 ;
 S IBPLDA=0 F  S IBPLDA=$O(IBINS(IBPLDA)) Q:'IBPLDA  D
 . S IB0=IBINS(IBPLDA,0),IBG0=$G(^IBA(355.3,+$P(IB0,U,18),0)),IBI0=$G(^DIC(36,+IB0,0)),IBCNT=IBCNT+1,IBFND=1
 . S IBY=IBCNT S IBLINE=$$SETSTR(IBY,"",1,3)
 . S IBY=$S(+$P(IBI0,U,5):"~",+$P(IBG0,U,11):"~",'$P(IBG0,U,2):"-",1:"") S IBLINE=$$SETSTR(IBY,IBLINE,4,1)
 . S IBY=$P(IBI0,U,1) S IBLINE=$$SETSTR(IBY,IBLINE,5,18,$P(CMPDATA,U,1))
 . S IBY=$P(IBG0,U,4) S IBLINE=$$SETSTR(IBY,IBLINE,25,13,$P(CMPDATA,U,2))
 . S IBY=$P(IB0,U,2) S IBLINE=$$SETSTR(IBY,IBLINE,40,13,$P(CMPDATA,U,3))
 . S IBY=$P(IB0,U,16),IBY=$$EXPAND^IBTRE(355.33,60.06,IBY) S IBLINE=$$SETSTR(IBY,IBLINE,55,6)
 . S IBY=$$DATE($P(IB0,U,8)) S IBLINE=$$SETSTR(IBY,IBLINE,63,8)
 . S IBY=$$DATE($P(IB0,U,4)) S IBLINE=$$SETSTR(IBY,IBLINE,73,8)
 . S IBDA=+IB0_U_+$P(IB0,U,18)_U_IBPLDA_U_+DFN
 . D SET(IBLINE,IBCNT,IBDA)
 ;
 I 'IBFND D SET("",1),SET("   No Insurance Policies on file for this patient.",1),SET("",1)
 Q
 ;
GRPLST(IBCNT,IBINSDA,DFN,CMPDATA) ; display insurance group/plans for a specific company
 ; if the buffer field data (CMPDATA) matches the displayed insurance entry's data, then that data is displayed in bold
 ; if the buffer entry's patient is already a member of the group/plan then the record's number is displayed in bold
 N IBX,IBY,IBGRPDA,IBPOLDA,IB0,IBI0,IBLINE,IBBOLD,IBFND,IBDA S IBFND=0,IBCNT=+$G(IBCNT),IBI0=$G(^DIC(36,IBINSDA,0))
 ;
 S IBX="Existing Plans for "_$P(IBI0,U,1)_"  ("_$P($G(^DIC(36,IBINSDA,.11)),U,1)_")"
 S IBY=$J("",40-($L(IBX)\2))_IBX D SET(IBY,1,"","R")
 S IBY="     Group Name              Group #             Type of Plan" D SET(IBY,1,"","U")
 ;
 S IBGRPDA=0 F  S IBGRPDA=$O(^IBA(355.3,"B",IBINSDA,IBGRPDA)) Q:'IBGRPDA  D
 . S IB0=$G(^IBA(355.3,IBGRPDA,0)) I +$G(DFN),$P(IB0,U,2)=0,$P(IB0,U,10)'=DFN Q
 . S IBCNT=IBCNT+1,IBFND=1,IBPOLDA=$$PTGRP^IBCNBU1(DFN,IBINSDA,IBGRPDA)
 . S IBY=IBCNT S IBLINE=$$SETSTR(IBY,"",1,4,$S(+IBPOLDA:IBY,1:""))
 . S IBY=$S(+$P(IBI0,U,5):"~",+$P(IB0,U,11):"~",'$P(IB0,U,2):"-",1:"") S IBLINE=$$SETSTR(IBY,IBLINE,5,1)
 . S IBY=$P(IB0,U,3) S:IBY=""&('$P(IB0,U,2)) IBY="<individual policy>" S IBLINE=$$SETSTR(IBY,IBLINE,6,20,$P(CMPDATA,U,1))
 . S IBY=$P(IB0,U,4) S IBLINE=$$SETSTR(IBY,IBLINE,30,17,$P(CMPDATA,U,2))
 . S IBY=$P(IB0,U,9) I +IBY S IBY=$P($G(^IBE(355.1,+IBY,0)),U,1) S IBLINE=$$SETSTR(IBY,IBLINE,50,30,$P(CMPDATA,U,3))
 . S IBDA=+IB0_U_+IBGRPDA_U_+IBPOLDA_U_DFN
 . D SET(IBLINE,IBCNT,IBDA)
 ;
 I 'IBFND D SET("",1),SET("   No Insurance Group/Plans on file for this Insurance Company.",1),SET("",1)
 Q
 ;
SRCHLST(IBCNT,DFN,INSNM,GRPNM,GRPNUM) ; display any insurance group/plan that matchs either group name or group number
 ; if the buffer field data (CMPDATA) matches the displayed insurance entry's data, then that data is displayed in bold
 ; if the buffer entry's patient is already a member of the group/plan then the record's number is displayed in bold
 ;
 N IBX,IBY,IBCX,IBFDATA,IBGRPDA,IBPOLDA,IB0,IBI0,IBLINE,IBBOLD,IBFND,IBDA,IBFD,IBLNS
 S IBFND=0,IBCNT=+$G(IBCNT),IBLNS=$S(+IBCNT:IBCNT,1:1) K ^TMP($J,"IBCNBLPG")
 ;
 S IBY=$J(" ",80) D SET(IBY,IBLNS)
 S IBX="Any Group/Plan that may match Group Name or Group Number",IBY=$J("",40-($L(IBX)\2))_IBX D SET(IBY,IBLNS,"","R")
 S IBY="     Insurance Company                  Group Name            Group Number" D SET(IBY,IBLNS,"","U")
 ;
 F IBCX="D","E" S IBFDATA=$S(IBCX="D":$G(GRPNM),1:$G(GRPNUM)) I IBFDATA'=""  D
 . S IBFD=$$PREV(IBFDATA) F  S IBFD=$O(^IBA(355.3,IBCX,IBFD)) Q:IBFD=""!(IBFD'[IBFDATA)  D
 .. S IBGRPDA=0 F  S IBGRPDA=$O(^IBA(355.3,IBCX,IBFD,IBGRPDA)) Q:IBGRPDA=""  D
 ... Q:$D(^TMP($J,"IBCNBLPG",IBGRPDA))  S ^TMP($J,"IBCNBLPG",IBGRPDA)=""
 ... S IB0=$G(^IBA(355.3,IBGRPDA,0)) I +$G(DFN),$P(IB0,U,2)=0,$P(IB0,U,10)'=DFN Q
 ... S IBCNT=IBCNT+1,IBFND=1,IBPOLDA=+$$PTGRP^IBCNBU1(DFN,+IB0,IBGRPDA),IBI0=$G(^DIC(36,+IB0,0))
 ... S IBY=IBCNT S IBLINE=$$SETSTR(IBY,"",1,4,$S(IBPOLDA:IBY,1:""))
 ... S IBY=$S(+$P(IBI0,U,5):"~",+$P(IB0,U,11):"~",'$P(IB0,U,2):"-",1:"") S IBLINE=$$SETSTR(IBY,IBLINE,5,1)
 ... S IBY=$P(IBI0,U,1) S IBLINE=$$SETSTR(IBY,IBLINE,6,18,$G(INSNM))
 ... S IBY=$P($G(^DIC(36,+IB0,.11)),U,1) S IBLINE=$$SETSTR(IBY,IBLINE,26,13)
 ... S IBY=$P(IB0,U,3) S:IBY=""&('$P(IB0,U,2)) IBY="<individual policy>" S IBLINE=$$SETSTR(IBY,IBLINE,41,20,$G(GRPNM))
 ... S IBY=$P(IB0,U,4) S IBLINE=$$SETSTR(IBY,IBLINE,63,17,$G(GRPNUM))
 ... S IBDA=+IB0_U_IBGRPDA_U_+IBPOLDA_U_DFN
 ... D SET(IBLINE,IBCNT,IBDA)
 ;
 I 'IBFND D SET("",IBCNT),SET(" No Group/Plans found that Match the buffer entry's Group Name or Group Number.",IBCNT),SET("",IBCNT)
 K ^TMP($J,"IBCNBLPG")
 Q
 ;
SETSTR(DATA,LINE,COL,LNG,CMPDATA) ; save data in formated line, if data matchs compare data save string position for bolding
 S LINE=$$SETSTR^VALM1(DATA,LINE,COL,LNG)
 I $D(CMPDATA),DATA=CMPDATA S IBBOLD=$G(IBBOLD)_COL_";"_LNG_"^"
 I $D(CMPDATA),DATA'=CMPDATA,$E(DATA,1,$L(CMPDATA))[CMPDATA S IBBOLD=$G(IBBOLD)_COL_";"_$L(CMPDATA)_"^"
 Q LINE
 ;
SET(LINE,CNT,IBDA,SPEC) ;
 S VALMCNT=VALMCNT+1 N IBX,IBI
 S ^TMP("IBCNBLP",$J,VALMCNT,0)=LINE
 I +$G(CNT) S ^TMP("IBCNBLP",$J,"IDX",VALMCNT,+CNT)=""
 I +$G(CNT),+$G(IBDA) S ^TMP("IBCNBLPX",$J,+CNT)=VALMCNT_U_IBDA
 I $G(SPEC)="U" D CNTRL^VALM10(VALMCNT,1,80,IOUON,IOUOFF)
 I $G(SPEC)="B" D CNTRL^VALM10(VALMCNT,1,80,IOINHI,IOINORM)
 I $G(SPEC)="R" D CNTRL^VALM10(VALMCNT,1,80,IORVON,IORVOFF)
 I $D(IBBOLD) F IBI=1:1 S IBX=$P(IBBOLD,U,IBI) Q:IBX=""  D
 . D CNTRL^VALM10(VALMCNT,$P(IBX,";",1),$P(IBX,";",2),IOINHI,IOINORM)
 K IBBOLD
 Q
 ;
DATE(X) ;
 N Y S Y="" I X?7N.E S Y=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 Q Y
 ;
PREV(STRING) ; return previous ascii value of the string for collating
 N IBL,IBX S IBL=$L(STRING),IBX=$E(STRING,1,IBL-1)_$C($A($E(STRING,IBL))-1)_"~"
 Q IBX
