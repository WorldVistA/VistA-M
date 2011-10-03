IBTRE1 ;ALB/AAS - CLAIMS TRACKING - ACTIONS ; 27-JUN-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**45**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% G EN^IBTRE
 ;
NX(IBTMPNM) ; -- Go to next template
 ; -- Input template name
 N VALMY,I,J,IBXXT
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXXT=0 F  S IBXXT=$O(VALMY(IBXXT)) Q:'IBXXT  D
 .S IBTRN=$P($G(^TMP("IBTREDX",$J,+$O(^TMP("IBTRE",$J,"IDX",IBXXT,0)))),"^",2)
 .I IBTRN D EN^VALM(IBTMPNM)
 .K IBAMT,IBAPR,IBADG,IBDA,IBDGCR,IBDGCRU1,IBDV,IBETYP,IBETYPD,IBI,IBICD,IBLCNT,IBSEL,IBT,IBTEXT,IBTNOD,IBTSAV,VAUTD
 .K IBAPEAL,IBCDFN,IBCNT,IBDEN,IBDENIAL,IBDENIAL,IBPARNT,IBPEN,IBPENAL,IBTCOD,IBTRDD,IBTRSV,IBTYPE,VAINDT,VA
 .D KVAR^VADPT
 .Q
 I '$D(IBFASTXT) D HDR^IBTRE,BLD^IBTRE
 S VALMBCK="R"
 Q
 ;
DT ; -- Delete tracking entry
 I '$D(^XUSEC("IB CLAIMS SUPERVISOR",DUZ)) D SORRY G DTQ
 N I,J,IBXX,VALMY,DIRUT
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) D FULL^VALM1 S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX!$D(DIRUT)  D
 .S IBTRN=$P($G(^TMP("IBTREDX",$J,$O(^TMP("IBTRE",$J,"IDX",IBXX,0)))),"^",2)
 .; do some error checking here
 .I $O(^IBT(356.1,"C",IBTRN,0)) W !!,*7,"There are Hospital Reviews associated with this entry."
 .I $O(^IBT(356.2,"C",IBTRN,0)) W !!,*7,"There are Insurance Reviews associated with this entry."
 .W ! S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are You Sure you want to delete entry #"_IBXX
 .D ^DIR I Y'=1 W !,"Entry #",IBXX," not Deleted!" Q
 .D DP1
 .Q
DTQ D BLD^IBTRE
 S VALMBCK="R" Q
 ;
DP1 ; -- actual deletion
 N DA,DIC,DIK
 ;
 ; -- delete reviews, communications,
 N IBI,IBCNT
 S (IBI,IBCNT)=0 F  S IBI=$O(^IBT(356.1,"C",IBTRN,IBI)) Q:'IBI  D
 .S DA=IBI,DIK="^IBT(356.1," D ^DIK
 .S IBCNT=IBCNT+1
 I IBCNT W !,"Number of Hospital Reviews Deleted: ",IBCNT
 ;
 S (IBI,IBCNT)=0 F  S IBI=$O(^IBT(356.2,"C",IBTRN,IBI)) Q:'IBI  D
 .S DA=IBI,DIK="^IBT(356.2," D ^DIK
 .S IBCNT=IBCNT+1
 I IBCNT W !,"Number of Insurance Reviews Deleted: ",IBCNT
 ;
 ; -- delete entry in claims tracking file
 S DA=IBTRN,DIK="^IBT(356," D ^DIK
 W !,"Entry ",IBXX," Deleted"
 Q
 ;
CP ; -- change patient
 N VALMQUIT,IBDFN
 D FULL^VALM1
 S IBDFN=DFN D PAT^IBCNSM
 I $D(VALMQUIT) S DFN=IBDFN
 S VALMBG=1 D HDR^IBTRE,BLD^IBTRE
 S VALMBCK="R"
CPQ K IBDFN
 Q
 ;
QE ; -- Quick edit tracking entry
 D EN^VALM2($G(XQORNOD(0)))
 N I,J,IBXX
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 .S IBTRN=$P($G(^TMP("IBTREDX",$J,$O(^TMP("IBTRE",$J,"IDX",IBXX,0)))),"^",2)
 .D QE1
QEQ S VALMBCK="R"
 D BLD^IBTRE
 Q
 ;
QE1 N X,Y,DA,DR,DIC,DIE,IBTRTP,IBSEL
 S DIE="^IBT(356,",DA=IBTRN
 D EDIT^IBTRED1("[IBT QUICK EDIT]",1)
 ;
 I '$D(IBTATRK),$$TRTP^IBTRE1(IBTRN)<3 D  ;clinical info only on inpt/outpt
 .; -- diagnosis edit
 .D EN^IBTRE3(IBTRN) Q:$G(IBSEL)["^"
 .;
 .; -- procedure edit / only inpt. / outpt use add/edit
 .I $$TRTP^IBTRE1(IBTRN)<2 D EN^IBTRE4(IBTRN) Q:$G(IBSEL)["^"
 .;
 .; -- provider edit
 .D EN^IBTRE5(IBTRN)
 .;
 .; -- compute drg
 .I $P($G(^IBT(356,IBTRN,0)),"^",5) W !! D DRG^IBTRV2(IBTRN)
 Q
 ;
CD ; -- Change Date range
 D FULL^VALM1
 S VALMB=IBTBDT D RANGE^VALM11
 I $S('VALMBEG:1,IBTBDT'=VALMBEG:0,1:IBTEDT=VALMEND) W !!,"Date range was not changed." D PAUSE^VALM1 S VALMBCK="" G CDQ
 S IBTBDT=VALMBEG,IBTEDT=VALMEND
 S VALMBG=1 D HDR^IBTRE,BLD^IBTRE
CDQ K VALMB,VALMBEG,VALMEND
 S VALMBCK="R"
 Q
 ;
EDIT(IBTEMP) ; -- Edit visit
 ; -- Input template name
 N VALMY,I,J,IBXXT
 D EN^VALM2($G(XQORNOD(0)))
 ;N I,J,IBXXT
 I $D(VALMY) S IBXXT=0 F  S IBXXT=$O(VALMY(IBXXT)) Q:'IBXXT  D
 .S IBTRN=$P($G(^TMP("IBTREDX",$J,+$O(^TMP("IBTRE",$J,"IDX",IBXXT,0)))),"^",2)
 .I IBTRN D EDIT^IBTRED1(IBTEMP,1)
 .Q
 D BLD^IBTRE
 S VALMBCK="R"
 Q
DIAG ; -- diagnosis editing
 N VALMY,I,J,IBXXT
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXXT=0 F  S IBXXT=$O(VALMY(IBXXT)) Q:'IBXXT  D
 .S IBTRN=$P($G(^TMP("IBTREDX",$J,+$O(^TMP("IBTRE",$J,"IDX",IBXXT,0)))),"^",2)
 .I IBTRN D EN^IBTRE3(IBTRN)
 .I $P($G(^IBT(356,IBTRN,0)),"^",5) W !! D DRG^IBTRV2(IBTRN)
 .Q
 S VALMBCK="R"
 Q
 ;
TRTP(X) ; -- compute tracking type code
 ;    input x = internal entry in 356
 ;    output  = code of tracking type from 356.6
 Q $P($G(^IBE(356.6,+$P($G(^IBT(356,+$G(X),0)),"^",18),0)),"^",3)
 ;
SORRY ; -- can't delete, don't have key.
 W !!,"You do not have access to delete entries.  See your application coordinator.",!
 Q
 ;
PU ; -- procedure editing
 N VALMY,I,J,IBXXT
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXXT=0 F  S IBXXT=$O(VALMY(IBXXT)) Q:'IBXXT  D
 .S IBTRN=$P($G(^TMP("IBTREDX",$J,+$O(^TMP("IBTRE",$J,"IDX",IBXXT,0)))),"^",2)
 .I IBTRN D EN^IBTRE4(IBTRN)
 .Q
 S VALMBCK="R"
 Q
 ;
PRV ; -- provider editing
 N VALMY,I,J,IBXXT
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXXT=0 F  S IBXXT=$O(VALMY(IBXXT)) Q:'IBXXT  D
 .S IBTRN=$P($G(^TMP("IBTREDX",$J,+$O(^TMP("IBTRE",$J,"IDX",IBXXT,0)))),"^",2)
 .I IBTRN D EN^IBTRE5(IBTRN)
 .Q
 S VALMBCK="R"
 Q
