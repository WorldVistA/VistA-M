IBTRV1 ;ALB/AAS - CLAIMS TRACKING -  REVIEW ACTIONS ; 14-JUL-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% G EN^IBTRV
 ;
DT ; -- Delete tracking entry
 I '$D(^XUSEC("IB CLAIMS SUPERVISOR",DUZ)) D SORRY^IBTRE1 G DTQ
 D EN^VALM2($G(XQORNOD(0)))
 N I,J,IBXX,DIR,DIRUT
 I $D(VALMY) D FULL^VALM1 S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX!$D(DIRUT)  D
 .S IBTRV=$P($G(^TMP("IBTRVDX",$J,+$O(^TMP("IBTRV",$J,"IDX",IBXX,0)))),"^",2)
 .I $O(^IBT(356.2,"AD",IBTRV,0)) W !!,*7,"There are Insurance Reviews associated with this entry."
 .W ! S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are You Sure you want to delete entry #"_IBXX
 .D ^DIR I Y'=1 W !,"Entry #",IBXX," not Deleted!" Q
 .D DP1
 .Q
DTQ D BLD^IBTRV
 S VALMBCK="R" Q
 ;
DP1 ; -- actual deletion
 N DA,DIC,DIK
 ;
 ; -- delete reviews, communications,
 N IBI,IBCNT
 S (IBI,IBCNT)=0 F  S IBI=$O(^IBT(356.2,"AD",IBTRV,IBI)) Q:'IBI  D
 .S DA=IBI,DIK="^IBT(356.2," D ^DIK
 .S IBCNT=IBCNT+1
 I IBCNT W !,"Number of Insurance Reviews Deleted: ",IBCNT
 ;
 ; -- delete entry in review file
 S DA=IBTRV,DIK="^IBT(356.1," D ^DIK
 W !,"Entry ",IBXX," Deleted"
 Q
 ;
QE ; -- Quick edit Review entry
 D EN^VALM2($G(XQORNOD(0)))
 N I,J,IBXX
 I $D(VALMY) D FULL^VALM1 S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 .S IBTRV=$P($G(^TMP("IBTRVDX",$J,+$O(^TMP("IBTRV",$J,"IDX",IBXX,0)))),"^",2)
 .D QE1
QEQ S VALMBCK="R"
 D BLD^IBTRV
 Q
 ;
QE1 N X,Y,DA,DR,DIC,DIE,IBSPEC,IBPROV,IBUNIT,IBADT,IBSEL
 S DIE="^IBT(356.1,",DA=IBTRV
 S IBTRTP=$P($G(^IBE(356.11,+$P($G(^IBT(356.1,IBTRV,0)),"^",22),0)),"^",2)
 S IBPROV="",IBSPEC="",IBATD=""
 I 'IBTRTP Q
 D @(IBTRTP_"^IBTRV3") ;sets up dr string for review type
 S DR=DR_"1.15;1.17;.21////10;.21;.2;"
 D EDIT^IBTRVD1(.DR,1)
 Q  ; -- don't always ask clinical info
 I $$TRTP^IBTRE1(IBTRN)<3 D  ;clinical info only on inpt/outpt
 .; -- diagnosis edit
 .D EN^IBTRE3(IBTRN) Q:$G(IBSEL)["^"
 .;
 .; -- procedure edit / only inpt. / outpt use add/edit
 .I $$TRTP^IBTRE1(IBTRN)<2 D EN^IBTRE4(IBTRN) Q:$G(IBSEL)["^"
 .;
 .; -- provider edit
 .D EN^IBTRE5(IBTRN)
 Q
 ;
NX(IBTMPNM) ; -- Go to next template
 ; -- Input template name
 N VALMY,I,J,IBXXV
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXXV=0 F  S IBXXV=$O(VALMY(IBXXV)) Q:'IBXXV  D
 .S IBTRV=$P($G(^TMP("IBTRVDX",$J,$O(^TMP("IBTRV",$J,"IDX",IBXXV,0)))),"^",2)
 .D EN^VALM(IBTMPNM)
 .K IBAMT,IBAPR,IBADG,IBDA,IBDGCR,IBDGCRU1,IBDV,IBETYP,IBETYPD,IBI,IBICD,IBLCNT,IBSEL,IBT,IBTEXT,IBTNOD,IBTSAV,VAUTD
 .K IBAPEAL,IBCDFN,IBCNT,IBDEN,IBDENIAL,IBDENIAL,IBPARNT,IBPEN,IBPENAL,IBTCOD,IBTRDD,IBTRSV,IBTYPE,VAINDT,VA
 .D KVAR^VADPT
 .Q
 I '$D(IBFASTXT) D BLD^IBTRV
 S VALMBCK="R"
 Q
 ;
EDIT(IBTEMP) ; -- Edit entries
 D EN^VALM2($G(XQORNOD(0)))
 N I,J,IBXX
 I $D(VALMY) D FULL^VALM1 S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 .S IBTRV=$P($G(^TMP("IBTRVDX",$J,+$O(^TMP("IBTRV",$J,"IDX",IBXX,0)))),"^",2)
 .W !!,"Editing Entry #",IBXX,!
 .D EDIT^IBTRVD1(IBTEMP,1)
 S VALMBCK="R"
 D BLD^IBTRV
 Q
 ;
CP ; -- change patient from within insurance reviews
 N VALMQUIT,IBDFN,IBY,IBTRNOLD
 D FULL^VALM1
 S IBDFN=DFN D PAT^IBCNSM
 I $D(VALMQUIT) S DFN=IBDFN
 S IBTRNOLD=IBTRN K IBTRN
 D TRAC^IBTRV
 I '$G(IBTRN) S DFN=IBDFN,IBTRN=IBTRNOLD
 S IBTRND=$G(^IBT(356,+IBTRN,0))
 D HDR^IBTRV,BLD^IBTRV
 S VALMBCK="R"
CPQ Q
