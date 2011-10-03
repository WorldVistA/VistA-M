IBCNS3 ;ALB/ARH - DISPLAY EXTENDED INSURANCE ; 01-DEC-04
 ;;2.0;INTEGRATED BILLING;**287,399,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
DISP(DFN,DATE,DISPLAY) ;  Display all insurance company information
 ;    input: DFN     = pointer to patient
 ;           DATE    = date to check for coverage and riders
 ;           DISPLAY = contain indicators of data to display (1234)
 ;                     1 : first line of display ins company and plan data
 ;                     2 : extended data (Plan Filing Timeframe, Plan Coverage, Conditional Coverage Comments, and Riders)
 ;                     3 : ins. policy comments and plan comments
 ;                     4 : eIV eligibility/benefit information (IB*2*416)
 ;
 Q:'$G(DFN)  D:'$D(IOF) HOME^%ZIS
 N IBINS,IBPOLFN,IBPOL0,IBPLNFN S DISPLAY=$G(DISPLAY) I '$G(DATE) S DATE=DT
 K ^TMP($J,"IBCNS3")
 ;
 D ALL^IBCNS1(DFN,"IBINS",3,DATE)
 ;
 I '$D(IBINS) D SETLN(" "),SETLN("No Insurance Information")
 ;
 S IBPOLFN=0 F  S IBPOLFN=$O(IBINS(IBPOLFN)) Q:'IBPOLFN  D
 . S IBPOL0=IBINS(IBPOLFN,0),IBPLNFN=$P(IBPOL0,U,18)
 . S ^TMP($J,"IBCNS3")=IBPOLFN
 . ;
 . D GETLN(IBPOL0,DATE)
 . I DISPLAY[2 D GETEXT(DFN,IBPOLFN,IBPOL0,DATE) ; display extended
 . I DISPLAY[3 D GETCOM(IBPLNFN,$G(IBINS(IBPOLFN,1))) ; display extended 3, comments
 . I DISPLAY[4 D EB(DFN,IBPOLFN)    ; display eIV elig/ben data
 . Q
 ;
 S ^TMP($J,"IBCNS3")="" D GETNOTES(DFN)   ; display final notes/warning messages
 ;
 D PRINT
 ;
DISPQ K ^TMP($J,"IBCNS3")
 Q
 ;
PRINT ; display compiled array of patient insurance information in ^TMP($J,"IBCNS3")
 N IBSUB,IBCOUNT,IBQUIT,IBLEVEL,IBLNX,IBDASH,IBLINE,IBCNTLN S $P(IBDASH,"-",80)="-" S DISPLAY=+$G(DISPLAY)
 ;
 D HDR S IBSUB="IBCNS3",IBCOUNT=3,IBQUIT=0
 ;
 S IBLEVEL=0 F  S IBLEVEL=$O(^TMP($J,IBSUB,IBLEVEL)) Q:'IBLEVEL  D  Q:IBQUIT
 . S IBCNTLN=+$G(^TMP($J,IBSUB,IBLEVEL))+1
 . ;
 . I IBCOUNT>10,(IBCNTLN+IBCOUNT)>(IOSL-3) S IBQUIT=$$EOP Q:IBQUIT  D HDR S IBCOUNT=3
 . ;
 . S IBLNX=0 F  S IBLNX=$O(^TMP($J,IBSUB,IBLEVEL,IBLNX)) Q:'IBLNX  D  Q:IBQUIT
 .. ;
 .. S IBLINE=$G(^TMP($J,IBSUB,IBLEVEL,IBLNX))
 .. ;
 .. W !,IBLINE S IBCOUNT=IBCOUNT+1 I IBCOUNT>(IOSL-3) S IBQUIT=$$EOP Q:IBQUIT  W @IOF S IBCOUNT=2
 . ;
 . I 'IBQUIT,DISPLAY>1 W !,IBDASH S IBCOUNT=IBCOUNT+1
 ;
 I 'IBQUIT,IBCOUNT>2 S IBQUIT=$$EOP
 Q
 ;
SETLN(LINE) ; set line as next line for current policy
 N CNT,POL S LINE=$G(LINE)
 S POL=+$G(^TMP($J,"IBCNS3"))
 I 'POL S POL=$O(^TMP($J,"IBCNS3","~"),-1)+1 S ^TMP($J,"IBCNS3")=POL
 ;
 S CNT=+$G(^TMP($J,"IBCNS3",POL))+1
 S ^TMP($J,"IBCNS3",POL)=CNT
 S ^TMP($J,"IBCNS3",POL,CNT)=LINE
 Q
 ;
 ;
 ;
GETLN(IBPOL0,IBDATE) ; get single line of primary data on insurance policy
 ;     input:   IBPOL0 = line from array, zero node of patient policy (2,.312)
 ;              IBDATE = date to check coverage, default today
 ;    output:   formatted line of data for insurance policy in TMP($J,"IBCNS")
 ;
 N IBX,IBLINE S IBLINE=" " S IBPOL0=$G(IBPOL0)
 ;
 S IBX=$G(^DIC(36,+IBPOL0,0)),IBX=$S($P(IBX,U,1)'="":$P(IBX,U,1),1:"UNKNOWN") S IBLINE=$$FRMLN(IBX,IBLINE,11,0)
 S IBX=$P(IBPOL0,U,20),IBX=$S(IBX=1:"p",IBX=2:"s",IBX=3:"t",1:"") S IBLINE=$$FRMLN(IBX,IBLINE,1,14)
 S IBX=$P(IBPOL0,U,2) S IBLINE=$$FRMLN(IBX,IBLINE,16,17)
 S IBX=$$FNDGRP($P(IBPOL0,U,18)) S IBLINE=$$FRMLN(IBX,IBLINE,10,35)
 S IBX=$P(IBPOL0,U,6),IBX=$S(IBX="v":"SELF",IBX="s":"SPOUSE",1:"OTHER") S IBLINE=$$FRMLN(IBX,IBLINE,7,47)
 S IBX=$$DAT1^IBOUTL($P(IBPOL0,U,8)) S IBLINE=$$FRMLN(IBX,IBLINE,8,55)
 S IBX=$$DAT1^IBOUTL($P(IBPOL0,U,4)) S IBLINE=$$FRMLN(IBX,IBLINE,8,65)
 S IBX=$$FNDCOV(+IBPOL0,+$P(IBPOL0,U,18),$G(IBDATE)) S IBLINE=$$FRMLN(IBX,IBLINE,6,74)
 ;
 D SETLN(IBLINE)
GETLNQ Q
 ;
 ;
GETEXT(DFN,IBPOLFN,IBPOL0,DATE) ; display extended insurance information
 ; Plan Filing Timeframe, Plan Coverage, Conditional Coverage Comments, and Riders
 ;     input:   DFN     = pointer to patient (2)
 ;              IBPOLFN = pointer to patient insurance policy in 2.312
 ;              IBPOL0  = line from array, zero node of patient policy (2,.312)
 ;              DATE    = date to check coverage, default today
 ;              DISPARR = array to pass data back in, pass by reference
 ;    output:   array of extended data in TMP($J,"IBCNS")
 ;
 N IBX,IBY,IBZ,IBC,IBINSFN,IBPLNFN,IBPLN0,IBLINE,IBCAT,IBCATFN,IBCOVRD,IBU,ARR,ARR1 S:'$G(DATE) DATE=DT
 S IBINSFN=+$G(IBPOL0) Q:'IBINSFN  S IBPLNFN=+$P(IBPOL0,U,18),IBPLN0=$G(^IBA(355.3,IBPLNFN,0)) Q:IBPLN0=""
 ;
 S IBLINE="Last Verified:   ",(IBY,IBX)=""
 S IBY=$P($G(^DPT(DFN,.312,IBPOLFN,1)),U,3) I IBY'="" S IBX=$$DAT1^IBOUTL(IBY) S IBLINE=IBLINE_IBX D SETLN(" "),SETLN(IBLINE)
 ;
 S IBLINE="Plan Filing Time Frame: "
 S IBY=$P(IBPLN0,U,13) S:IBY'="" IBY=IBY_"  " I +$P(IBPLN0,U,16) S IBY=IBY_"("_$$FTFN^IBCNSU31(IBPLNFN)_")"
 I IBY'="" S IBLINE=IBLINE_IBY D:IBX="" SETLN(" ") D SETLN(IBLINE)
 ;
 S IBLINE="Insurance Comp:  "
 I $P($G(^DIC(36,IBINSFN,0)),U,2)="N" S IBLINE=IBLINE_"Will Not Reimburse" D SETLN(" "),SETLN(IBLINE)
 ;
 S IBLINE="Conditional: ",IBCOVRD="",IBU=""
 K ARR F IBCAT="INPATIENT","OUTPATIENT","PHARMACY","MENTAL HEALTH","DENTAL","LONG TERM CARE" D
 . S IBCATFN=+$O(^IBE(355.31,"B",IBCAT,"")) Q:'IBCATFN
 . S IBY=$$PLCOV^IBCNSU3(+IBPLNFN,DATE,IBCATFN,.ARR) Q:IBY'>0
 . I IBY=1 S IBCOVRD=$G(IBCOVRD)_IBU_$S(IBCAT["PATIENT":$P(IBCAT,"IENT",1),1:IBCAT),IBU=", " Q
 . S IBX=IBCAT_": ",IBC=$G(IBC)+100 S IBLINE=$$FRMLN(IBX,IBLINE,15,17)
 . S IBZ=0 F  S IBZ=$O(ARR(IBZ)) Q:'IBZ  S IBX=ARR(IBZ) D  S IBLINE=""
 .. S IBLINE=$$FRMLN(IBX,IBLINE,46,33) S ARR1(IBC+IBZ)=IBLINE
 I IBCOVRD'="" S IBLINE="Plan Coverage:   "_$G(IBCOVRD) D SETLN(" "),SETLN(IBLINE)
 I $O(ARR1("")) D:IBCOVRD="" SETLN(" ") S IBZ=0 F  S IBZ=$O(ARR1(IBZ)) Q:'IBZ  S IBX=ARR1(IBZ) D SETLN(IBX)
 ;
 S IBLINE="Policy Riders: "
 K ARR D RIDERS^IBCNSU3(+$G(DFN),+$G(IBPOLFN),.ARR) I $O(ARR("")) D SETLN(" ")
 S IBZ=0 F  S IBZ=$O(ARR(IBZ)) Q:'IBZ  S IBX=ARR(IBZ) D  S IBLINE=""
 . S IBLINE=$$FRMLN(IBX,IBLINE,62,17) D SETLN(IBLINE)
 Q
 ;
 ;
GETCOM(IBPLNFN,IBPOL1) ; get patient insurance and plan insurance comments in TMP($J,"IBCNS")
 N IBX,IBY
 ;
 S IBX=$P($G(IBPOL1),U,8) I IBX'="" S IBY="Patient Policy Comments: " D SETLN(" "),SETLN(IBY),SETLN(IBX)
 ;
 I +$G(IBPLNFN),$O(^IBA(355.3,+IBPLNFN,11,0)) S IBX="Group/Plan Comments:" D SETLN(" "),SETLN(IBX) D
 . S IBX=0 F  S IBX=$O(^IBA(355.3,+IBPLNFN,11,IBX)) Q:'IBX  S IBY=$G(^IBA(355.3,+IBPLNFN,11,IBX,0)) D SETLN(IBY)
 Q
 ;
 ;
GETNOTES(DFN) ; get final notes/warnings in TMP($J,"IBCNS")
 N IBX,IBY,IBLINE1,IBLINE2,IBFND S (IBFND,IBLINE1,IBLINE2)=""  Q:'$G(DFN)
 ;
 S IBX=+$G(^IBA(354,DFN,60)) I +IBX S IBY="*** Verification of No Coverage "_$$FMTE^XLFDT(IBX)_" ***" S IBLINE1=$$FRMLN(IBY,"",60,16),IBFND=1
 I $$BUFFER^IBCNBU1(DFN) S IBY="***  Patient has Insurance Buffer entries  ***" S IBLINE2=$$FRMLN(IBY,"",50,17),IBFND=1
 ;
 I +IBFND D SETLN(" ") D:IBLINE1'="" SETLN(IBLINE1) D:IBLINE2'="" SETLN(IBLINE2) D SETLN(" ")
 ;
 Q
 ;
 ;
EB(DFN,IBCDFN) ; Build eIV elig/benefit display for ?INX screen display
 NEW IBX,IBY
 D INIT^IBCNES(2.322,IBCDFN_","_DFN_",","A",,"?INX")
 D SETLN(" ")
 D SETLN("eIV Eligibility/Benefit Information:")
 S IBX=0
 F  S IBX=$O(^TMP("?INX",$J,"DISP",IBX)) Q:'IBX  D
 . S IBY=$G(^TMP("?INX",$J,"DISP",IBX,0))
 . D SETLN(IBY)
 . Q
 ;
 ; clean up scratch global
 K ^TMP("?INX",$J)
 ;
EBX ;
 Q
 ;
 ;
FRMLN(FIELD,IBLINE,FLNG,COL) ; format line data fields, returns IBLINE with FIELD of length FLNG at column COL
 N IBNEW,IBL S FIELD=$G(FIELD),IBLINE=$G(IBLINE),FLNG=$G(FLNG),COL=$G(COL)
 ;
 S IBNEW=$E(IBLINE,1,COL),IBL=$L(IBNEW),IBNEW=IBNEW_$J("",COL-IBL)
 S IBNEW=IBNEW_$E(FIELD,1,FLNG),IBL=$L(FIELD),IBNEW=IBNEW_$J("",FLNG-IBL)
 S IBNEW=IBNEW_$E(IBLINE,COL+FLNG+1,9999)
 Q IBNEW
 ;
 ;
 ;
FNDCOV(IBINSFN,IBPLNFN,IBDATE) ; -- return group/plan coverage limitations indications
 ;     input:   IBINSFN = pointer to insurance company entry in 36
 ;              IBPLNFN = pointer to insurance plan entry in 355.3
 ;              IBDATE  = date to check coverage, default today
 ;    output:   if insurance company will not reimburse = WNR, if all covered then returns null
 ;              otherwise list of first characters of types covered, if conditional then character in lower case
 ;              
 N IBOUT,IBX,IBY,IBCAT,IBCATFN S IBOUT="" S:'$G(IBDATE) IBDATE=DT I '$G(IBINSFN)!'$G(IBPLNFN) G FNDCOVQ
 ;
 I $P($G(^DIC(36,+IBINSFN,0)),U,2)="N" S IBOUT="*WNR*" G FNDCOVQ
 F IBCAT="INPATIENT","OUTPATIENT","PHARMACY","MENTAL HEALTH","DENTAL","LONG TERM CARE" D
 . S IBCATFN=+$O(^IBE(355.31,"B",IBCAT,"")) Q:'IBCATFN
 . S IBY=$$PLCOV^IBCNSU3(+IBPLNFN,IBDATE,+IBCATFN) Q:'IBY
 . S IBX=$S(IBCAT="PHARMACY":"R",1:$E(IBCAT)) S:IBY>1 IBX=$C($A(IBX)+32) S IBOUT=IBOUT_IBX
 S:IBOUT="" IBOUT="no CV" I IBOUT?6U S IBOUT=""
FNDCOVQ Q IBOUT
 ;
 ;
FNDGRP(IBPLNFN) ; -- return group name/group policy
 ;     input:   IBPLNFN = pointer to insurance plan entry in 355.3
 ;    output:   group name or group number, if both group NUMBER, check for Individual plans
 ;
 N IBX,IBOUT S IBOUT=""
 S IBX=$G(^IBA(355.3,+$G(IBPLNFN),0))
 S IBOUT=$S($P(IBX,U,4)'="":$P(IBX,U,4),1:$P(IBX,U,3))
 I $P(IBX,U,10) S IBOUT="Ind. Plan "_IBOUT
FNDGRPQ Q IBOUT
 ;
 ;
 ;
 ;
HDR ; -- print header
 N IBX W @IOF
 W !,"Insurance",?13,"COB",?17,"Subscriber ID",?35,"Group",?47,"Holder",?55,"Effectve",?65,"Expires",?75,"Only"
 S IBX="",$P(IBX,"=",80)="=" W !,IBX
 Q
 ;
EOP() ; ask user for return at end of page, return 1 if '^' entered
 N IBQ,DIR,DIRUT,DUOUT,DTOUT,X,Y W ! S IBQ=0,DIR(0)="E" D ^DIR K DIR I $D(DUOUT)!($D(DIRUT)) S IBQ=1
 Q IBQ
