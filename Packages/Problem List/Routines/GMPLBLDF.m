GMPLBLDF ; SLC/MKB -- Build Problem Selection List from IB Enc Form ;5/12/94  10:26
 ;;2.0;Problem List;;Aug 25, 1994
EN ; Start here.
 S X="IBDF18" X ^%ZOSF("TEST") I '$T D  Q
 . W !!,">>>  The IB Encounter Form utility is not available.",!
EN0 S GMPLFORM=$$GETFORM^IBDF18 G:'GMPLFORM EXIT
 W !,"Searching for the problems ..."
 S X=$$COPYFORM^IBDF18(+GMPLFORM,"GMPL"),GMPL(0)=X
 I 'X W !!,"No problems found.  Please select another form.",! G EN0
EN1 ; Create list to copy problems into
 S DIR(0)="FA^3:30",DIR("A")="LIST NAME: "
 S:'$D(^GMPL(125,"B",$P(GMPLFORM,U,2))) DIR("B")=$P(GMPLFORM,U,2)
 S DIR("?",1)="Enter the name you wish to give this list; use meaningful"
 S DIR("?")="text, as it will be used as a title when presenting this list."
 W !!,">>>  Please create a new selection list in which to store these problems:"
EN2 D ^DIR G:$D(DUOUT)!($D(DTOUT)) EXIT
 I $D(^GMPL(125,"B",Y)) W $C(7),!,"There is already a list by this name!",! G EN2
 S DIC="^GMPL(125,",DIC(0)="L",DIC("DR")=".02////"_DT,DLAYGO=125 K DD,DO
 D FILE^DICN I Y'>0 W !!,"ERROR -- Cannot create new list!",$C(7) G EXIT
 S GMPLSLST=$P(Y,U,1,2),DIE=DIC,DA=+Y,DR=".03   CLINIC" D ^DIE ; clinic
EN3 ; Here we go ...
 W !!,"Copying problems from "_$P(GMPLFORM,U,2)_" form into "
 W:(42+$L($P(GMPLFORM,U,2))+$L($P(GMPLSLST,U,2))>80) !
 W $P(GMPLSLST,U,2)_" list ..."
 S (GSEQ,PSEQ,GMPLI)=0,GHDR="" S:'+GMPL(1) GHDR=$P(GMPL(1),U,2),GMPLI=1
 S GSEQ=GSEQ+1,GMPLGRP=$$NEWGRP(GMPLFORM,GHDR,GSEQ)
 F  S GMPLI=$O(GMPL(GMPLI)) Q:GMPLI'>0  D
 . S ITEM=$G(GMPL(GMPLI)) Q:'$L(ITEM)
 . I '+ITEM D  Q
 . . S GSEQ=GSEQ+1,PSEQ=0,GMPLGRP=$$NEWGRP(GMPLFORM,$P(ITEM,U,2),GSEQ)
 . S PSEQ=PSEQ+1,DIK="^GMPL(125.12,",ITEM=PSEQ_U_ITEM
 . D NEW^GMPLBLD2(DIK,+GMPLGRP,ITEM) W "."
 W " <done>"
EXIT ; Clean-up
 K GMPL,GMPLSLST,GMPLGRP,GMPLI,GMPLFORM,GHDR,GSEQ,PSEQ,DIC,DIR,DIK,DR,X,Y,DIE,DA,DLAYGO
 Q
 ;
NEWGRP(FORM,HDR,SEQ) ; Create new group entries in #125.1 and #125.11
 N DIC,DD,DO,X,Y,DIK,ITEM,DLAYGO
 S DIC="^GMPL(125.11,",DIC(0)="L",DIC("DR")="1////"_DT,DLAYGO=125.11
 I $L(HDR),'$D(^GMPL(125.11,"B",$$UP^XLFSTR(HDR))) S X=$$UP^XLFSTR(HDR)
 E  S X=$E($P(FORM,U,2),1,23-$L(SEQ))_" GROUP "_SEQ
 D FILE^DICN G:Y'>0 NGQ
 S DIK="^GMPL(125.1,",ITEM=SEQ_U_+Y_U_HDR_"^1"
 D NEW^GMPLBLD2(DIK,+GMPLSLST,ITEM)
NGQ S Y=$P(Y,U,1,2)
 Q Y
