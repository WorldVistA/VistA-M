IBCECSA3 ;ALB/CXW - CLAIMS STATUS AWAITING RESOLUTION REPORT ;23-JUL-99
 ;;2.0;INTEGRATED BILLING;**137,320,371,377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
EN ; Report of claims status awaiting resolution
 NEW %ZIS,ZTSAVE,ZTRTN,ZTDESC,DIR,X,Y,DIRUT,DTOUT,DUOUT,DIROUT,IBRVW
 ;
 D FULL^VALM1
 W !
 S DIR(0)="YO"           ; IB*2*377 new question
 S DIR("A")="Would you like to include Review Comments with this report"
 S DIR("B")="No"
 D ^DIR K DIR
 I $D(DIRUT) Q
 S IBRVW=Y
 ;
 W !!,"You will need a 132 column printer for this report!",!
 ;
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) K IO("Q") D  Q
 . S ZTRTN="LIST^IBCECSA3"
 . S ZTSAVE("IBSORT1")=""
 . S ZTSAVE("IBSORT2")=""
 . S ZTSAVE("IBSORT3")=""
 . S ZTSAVE("IBSORTOR")=""
 . S ZTSAVE("^TMP(""IBCECSB"",$J,")=""
 . S ZTSAVE("IBRVW")=""
 . S ZTDESC="IB -Claims Status Awaiting Resolution Report" D ^%ZTLOAD K ZTSK D HOME^%ZIS
 U IO
LIST ; display
 N IBSTOP,X,IBPAGE,IBX,IBDIV,IBDA,IBPAY,IB,IBZ,IBZFT,IBFST,IBX2
 W:$E(IOST,1,2)["C-" @IOF ;Only initial form feed for print to screen
 S (IBSTOP,IBPAGE,IBFST,IBDIV)=0
 I IBSORT1="D" S IBDIV=1
 I '$D(^TMP("IBCECSB",$J)) D  G LISTQ
 . D HDR1 W !,"No entries found for this report"
 S IBX="" F  S IBX=$O(^TMP("IBCECSB",$J,IBX)) Q:IBX=""!IBSTOP  S IBX2="" F  S IBX2=$O(^TMP("IBCECSB",$J,IBX,IBX2)) Q:IBX2=""!IBSTOP  S IBX3="" F  S IBX3=$O(^TMP("IBCECSB",$J,IBX,IBX2,IBX3)) Q:IBX3=""!IBSTOP  D  Q:IBSTOP
 . I 'IBFST S IBPAY=$$IBPAY(IBX,IBX2,IBX3) D HDR1 S:'IBDIV IBFST=1 Q:IBSTOP
 . S IBDA=0 F  S IBDA=$O(^TMP("IBCECSB",$J,IBX,IBX2,IBX3,IBDA)) Q:'IBDA!IBSTOP  S IB=$G(^TMP("IBCECSB",$J,IBX,IBX2,IBX3,IBDA)) D  Q:IBSTOP
 .. I ($Y+3)>IOSL D HDR1 Q:IBSTOP
 .. W $$BN1^PRCAFN(+IB),$P(IB,U,12),?13,$E($P(IB,U,2),1,25),?40,$E($P(IB,U,3),1,30),?72,$P($P(IB,U,4),"~"),?78,$$DAT1^IBOUTL($P(IB,U,5)),?88,$E($P(IB,U,7),1,10),?100,"$"_$J($P(IB,U,6),0,2),?110,$P(IB,U,10),?122,$P(IB,U,11),!
 .. I $P(IB,U,12)="*" W " ***** CSA REVIEW IN PROCESS *****",!
 .. W " FORM TYPE: "_$P($G(^IBE(353,$P($G(^DGCR(399,+IB,0)),U,19),0)),U),!
 .. I 'IBDIV S X=" DIVISION: "_$P(IB,U,8) W X,$J(" ",40-$L(X))_"AUTHORIZING BILLER: "_$P($P(IB,U,9),"~",1),!
 .. W " MESSAGE TEXT: " S IBZFT=0
 .. S IBZ=0 F  S IBZ=$O(^IBM(361,IBDA,1,IBZ)) Q:'IBZ  D  Q:IBSTOP
 ... W:'IBZFT ?15 S X=$G(^IBM(361,IBDA,1,IBZ,0))
 ... F I=1:131:$L(X) W " "_$E(X,I,I+130),!
 ... S IBZFT=1
 ... I ($Y+3)>IOSL D HDR1 Q:IBSTOP
 ... Q
 .. Q:IBSTOP
 .. ;
 .. ; Display the Review Comments if they exist based on user choice (IB*377)
 .. I $G(IBRVW),+$O(^IBM(361,IBDA,2,0)) D  Q:IBSTOP
 ... N IBCM,IBT1,IBT0,IBD0,IBCL
 ... I ($Y+3)>IOSL D HDR1 Q:IBSTOP
 ... W ?3,"*** Review Comments for Claim "_$$BN1^PRCAFN(+IB)_" ***",!
 ... S IBCM=0 F IBT1=0:1 S IBCM=$O(^IBM(361,IBDA,2,IBCM)) Q:'IBCM     ; count up # of comments
 ... S IBT0=0
 ... S IBCM=0 F  S IBCM=$O(^IBM(361,IBDA,2,IBCM)) Q:'IBCM!IBSTOP  D  Q:IBSTOP
 .... S IBT0=IBT0+1
 .... S IBD0=$G(^IBM(361,IBDA,2,IBCM,0))
 .... I ($Y+3)>IOSL D HDR1 Q:IBSTOP
 .... W ?7,"Entered "_$$FMTE^XLFDT($P(IBD0,U,1),"5ZPM")
 .... I $P(IBD0,U,2) W " by "_$P($G(^VA(200,$P(IBD0,U,2),0)),U,1)
 .... W " ("_IBT0_" of "_IBT1_")",!
 .... S IBCL=0 F  S IBCL=$O(^IBM(361,IBDA,2,IBCM,1,IBCL)) Q:'IBCL!IBSTOP  D  Q:IBSTOP
 ..... I ($Y+3)>IOSL D HDR1 Q:IBSTOP
 ..... W ?10,$G(^IBM(361,IBDA,2,IBCM,1,IBCL,0)),!
 ..... Q
 .... Q
 ... Q
 .. ;
 .. ; Display a line break before the next claim in this report
 .. I ($Y+3)>IOSL D HDR1 Q:IBSTOP
 .. W !
 .. Q
 . Q
 ;
 G:IBSTOP LISTQ
 I $E(IOST,1,2)["C-" K DIR S DIR(0)="E" D ^DIR K DIR
LISTQ I $D(ZTQUEUED) S ZTREQ="@" Q
 W ! D ^%ZISC
 Q
IBPAY(IBX,IBX2,IBX3) ; return biller name
 N X
 S X=$O(^TMP("IBCECSB",$J,IBX,IBX2,IBX3,0))
 S X=$G(^TMP("IBCECSB",$J,IBX,IBX2,IBX3,X))
 Q $P($P(X,U,9),"~",1)
HDR1 ;
 N DIR,Y
 I IBPAGE D  Q:IBSTOP
 . I $E(IOST,1,2)["C-" K DIR S DIR(0)="E" D ^DIR K DIR S IBSTOP=('Y) Q:IBSTOP
 . W @IOF
 S IBPAGE=IBPAGE+1
 W !,"Sort 1: ",$$SD^IBCECSA(IBSORT1)
 W ?46,"Claims Status Awaiting Resolution Report",?120,$J("Page: "_IBPAGE,11)
 W !,"Sort 2: ",$S($G(IBSORT2)'="":$$SD^IBCECSA(IBSORT2),1:"n/a")
 W ?104,$J("Run Date: "_$$HTE^XLFDT($H,"2Z"),27)
 W !,"Sort 3: ",$S($G(IBSORT3)'="":$$SD^IBCECSA(IBSORT3),1:"n/a")
 I IBDIV W !!,"Division: "_$S($G(IBX)=0:"",1:$G(IBX)),!,"Authorizing Biller: "_$G(IBPAY)
 W !,?72,"Last",?78,"Date of",?88,"Location",?100,"Current",?110,"Source of",?122,"Days Msg"
 W !,"Bill #",?13,"Payer Name",?40,"Patient Name",?72,"4 SSN",?78,"Service",?88,"of Service",?100,"Balance",?110,"Message",?122,"Pending"
 W !,$TR($J("",132)," ","-"),!
 Q
 ;
 ;
RESORT ; CSA screen re-sort action
 NEW DIR,X,Y,Z,IBSAVE,VALMQUIT,IBCURR
 D FULL^VALM1 S VALMBCK="R"
 W !!?2,"The CSA screen is currently sorted in the following manner:"
 W !!?9,"Primary Sort:  ",$S($G(IBSORT1)'="":$$SD^IBCECSA(IBSORT1),1:"n/a")
 W !?7,"Secondary Sort:  ",$S($G(IBSORT2)'="":$$SD^IBCECSA(IBSORT2),1:"n/a")
 W !?8,"Tertiary Sort:  ",$S($G(IBSORT3)'="":$$SD^IBCECSA(IBSORT3),1:"n/a")
 ;
 W !
 S DIR(0)="Y",DIR("A")="Would you like to change the sort criteria"
 S DIR("B")="Yes" D ^DIR K DIR
 I 'Y G RESORTX
 ;
 ; save the old sort criteria
 S IBSAVE=$G(IBSORT1)_U_$G(IBSORT2)_U_$G(IBSORT3)
 S Z="" F  S Z=$O(IBSORTOR(Z)) Q:Z=""  S IBSAVE=IBSAVE_U_Z_U_IBSORTOR(Z)
 ;
 W !
 K IBSORTOR
 D SORT^IBCECSA(1,$P(IBSAVE,U,1)) I $G(VALMQUIT) G RES1
 D SORT^IBCECSA(2) I $G(VALMQUIT) G RES1
 I $G(IBSORT2)'="" D SORT^IBCECSA(3) I $G(VALMQUIT) G RES1
RES1 ;
 I $G(IBSORT1)="" S IBSORT1=$P(IBSAVE,U,1)   ; need at least one
 ;
 ; see if the sort criteria changed
 S IBCURR=$G(IBSORT1)_U_$G(IBSORT2)_U_$G(IBSORT3)
 S Z="" F  S Z=$O(IBSORTOR(Z)) Q:Z=""  S IBCURR=IBCURR_U_Z_U_IBSORTOR(Z)
 I IBSAVE=IBCURR G RESORTX    ; no sort changes made at all
 ;
 ; time to rebuild the list because sorts have changed
 I $G(IBDAYS)="" S IBDAYS=0
 I $G(IBSEV)="" S IBSEV="R"
 D BLD^IBCECSA1
 S VALMBCK="R",VALMBG=1
 ;
RESORTX ;
 Q
 ;
MCS ; Link to the Multiple CSA Message Management option
 NEW IBCSAMCS S IBCSAMCS=1
 D FULL^VALM1 S VALMBCK="R"
 I '$$KCHK^XUSRB("IB MESSAGE MANAGEMENT") D  G MCSX
 . W !!?5,"You must hold the IB MESSAGE MANAGEMENT key to access this option."
 . D PAUSE^VALM1
 . Q
 ;
 D      ; call the MCS screen
 . NEW IBSORT1,IBSORT2,IBSORT3,IBDAYS,IBSEV     ; protect CSA vars
 . D EN^IBCEMCL
 . Q
 ;
 I $G(IBCSAMCS)=2 D BLD^IBCECSA1 S VALMBG=1     ; rebuild CSA
 S VALMBCK="R"
MCSX ;
 Q
 ;
