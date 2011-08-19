IBCEP5D ;ALB/JEH - EDI UTILITIES - for State License ;29-MAR-01
 ;;2.0;INTEGRATED BILLING;**137,320,348,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; STATE LICENSE # ADD/EDIT DBIA ==> DBIA 224
EN ;Add/edit state and license number
 N IBDA,DIR,DIC,DD,DA,DR,IBSTAT,IBLIC,IBQ,Y
 D FULL^VALM1
 I '$G(IBPRV) D  G:IBQ STATQ
 . S IBQ=0
 . S DIC="^VA(200,",DIC(0)="AEMQ",DIC("A")="Select VA Provider: " D ^DIC K DIC
 . I $D(DTOUT)!$D(DUOUT)!(Y<0) S IBQ=1 Q
 . S IBDA=+Y
 I $G(IBPRV)["VA" S IBDA=+IBPRV
 I $G(IBPRV),$G(IBPRV)'["VA" D  G STATQ
 . S DIR("A",1)="You have selected a Non-VA provider"
 . S DIR("A",2)="State license # can only be entered for VA providers"
 . S DIR("A",3)=""
 . S DIR("A")="Press enter to continue"
 . S DIR(0)="EA" W ! D ^DIR K DIR W !
STALIC ;Add/edit file 200 field 54.1 multiple,state(.01) and license#(1) - DBIA 224
 ;
 S DA(1)=IBDA,DIC="^VA(200,"_DA(1)_",""PS1"",",DIC(0)="QEAL"
 D ^DIC I Y=-1 K DIC,DA G STATQ
 F Z=1:1:3 L +^VA(200,IBDA):5 Q:$T
 I '$T D  G STATQ
 . W !,"Another user is editing this entry.  Try again later"
 . S DIR(0)="EA",DIR("A")="Press enter to continue"
 . W ! D ^DIR K DIR W !
 S DIE=DIC K DIC S DA=+Y,DR=".01;1"
 D ^DIE K DIE,DR,DA,Y
 L -^VA(200,IBDA)
STATQ ;
 S VALMBCK="R"
 Q
 ;
GETLIC(IBPRV) ; Get license # for provider in file 200 IBPRV
 ; Pass IBPRV by reference to retrieve #'s by state
 ; IBPRV(state ien)=id
 ; Returns 0 if no license # found
 N Z
 S Z=0 F  S Z=$O(^VA(200,IBPRV,"PS1",Z)) Q:'Z  S Z0=$G(^(Z,0)) I $P(Z0,U,2)'="" S IBPRV(+Z0)=$P(Z0,U,2)
 Q +$O(IBPRV(0))
 ;
EDIT(IBFILE,IBFLD,IB0,IBOLD,IBIEN,IBCK1) ; Generic edit flds
 N DIR,Y,X,IB,IB1,IBCUVAL,IBCUY,IBFLD0,IBNEW,IBPRV,IBVAL,IBIVAL,IBINS,IBCUCHK,IBOK,DUOUT,DTOUT
 I IBFILE=355.91,IBFLD=.02 S IBNEW="" G EDITQ ; No .02 in file 355.91
 S IBCUCHK=1,IBCUVAL=""
 S IBFLD0=IBFLD*100,IBPRV=$S(IBFILE=355.9:$P(IB0,U),1:""),IBNEW=""
 S IBPRV0=$S(IBPRV'["355.93":"",1:$G(^IBA(355.93,+IBPRV,0)))
 S IBINS=$P(IB0,U,$S(IBFILE=355.9:2,1:1))
 I IBFLD'=.03 S IBVAL=$$EXPAND^IBTRE(IBFILE,IBFLD,$P(IB0,U,IBFLD0)),IBIVAL=$P(IB0,U,IBFLD0)
 I IBFLD=.03,$S('IBINS:1,1:'$$CAREUN^IBCEP3(IBINS,$P(IB0,U,6),$P(IB0,U,4),$P(IB0,U,5),$P(IB0,U,5)=3)) S:$P(IB0,U,3) IBNEW="@" G EDITQ
 I IBFLD=.03 S IBVAL=$P($G(^IBA(355.95,+$G(^IBA(355.96,+$P(IB0,U,3),0)),0)),U),IBIVAL=$P(IB0,U,3) D
 . S IBCUCHK=0,IBCUVAL=$P($G(^IBA(355.96,+IBIVAL,0)),U,1) I IBCUVAL="" Q
 . I $O(^IBA(355.96,"AUNIQ",IBINS,IBCUVAL,$P(IB0,U,4),$P(IB0,U,5),$P(IB0,U,6),"")) S IBCUCHK=1 Q
 . I $O(^IBA(355.96,"AUNIQ",IBINS,IBCUVAL,$P(IB0,U,4),0,$P(IB0,U,6),""))  S IBCUCHK=1 Q
 . I $O(^IBA(355.96,"AUNIQ",IBINS,IBCUVAL,0,$P(IB0,U,5),$P(IB0,U,6),"")) S IBCUCHK=1 Q
 . I $O(^IBA(355.96,"AUNIQ",IBINS,IBCUVAL,0,0,$P(IB0,U,6),"")) S IBCUCHK=1 Q
 . S IBIVAL="@"
 ;
 I IBFLD'=.02 D
 . N DA
 . S DIR(0)=$S(IBFLD'=.03:IBFILE_","_IBFLD_"AO",1:"PAO^355.95:AEMQ")
 . I IBFLD=.03 D  Q:$P(IB0,U,4)=""!($P(IB0,U,5)="")!($P(IB0,U,6)="")
 .. S DIR("A")="CARE UNIT: "
 .. S DIR("S")="I $D(^IBA(355.96,""AUNIQ"",IBINS,Y,$P(IB0,U,4),$P(IB0,U,5),$P(IB0,U,6)))!($D(^IBA(355.96,""AUNIQ"",IBINS,Y,$P(IB0,U,4),0,$P(IB0,U,6))))"
 .. S DIR("S")=DIR("S")_"!($D(^IBA(355.96,""AUNIQ"",IBINS,Y,0,$P(IB0,U,5),$P(IB0,U,6))))!($D(^IBA(355.96,""AUNIQ"",IBINS,Y,0,0,$P(IB0,U,6))))"
 . I IBFLD'=.03 S DIR("A")=$$GET1^DID(IBFILE,IBFLD,,"LABEL")_": "
 . S:IBVAL'=""&(IBCUCHK) DIR("A")=DIR("A")_IBVAL_"// "
 .; If field .04, Set DIR(0)[3] up to make sure the form type selected is allowed for this ID type.
 . I Z=.04,IBPRV["355.93",$$GET1^DIQ(355.93,+IBPRV,.02,"I")=1 D
 .. I $$GET1^DIQ(355.97,$P(IB0,U,6),.03,"I")="EI" S $P(DIR(0),U,3)="K:Y'=1 X",DIR("?")="Provider ID Qualifier selected only allows institutional (UB type) forms" Q
 .. I $$GET1^DIQ(355.97,$P(IB0,U,6),.03,"I")="TJ" S $P(DIR(0),U,3)="K:Y'=2 X",DIR("?")="Provider ID Qualifier selected only allows professional (CMS-1500) forms" Q
 .. N AFT
 .. S AFT=$$GET1^DIQ(355.97,$P(IB0,U,6),.07,"I")  ; get allowable form type for this Provider ID Type
 .. I AFT="B" S $P(DIR(0),U,3)="K:"".0.1.2.""'[("".""_X_""."") X",DIR("?")="Provider ID Qualifier selected allows institutional, professional or both" Q   ; allow proff, inst, or both
 .. I AFT="I" S $P(DIR(0),U,3)="K:X'=1 X",DIR("?")="Provider ID Qualifier selected only allows institutional (UB type) forms" Q  ; allow institutional
 .. I AFT="P" S $P(DIR(0),U,3)="K:X'=2 X",DIR("?")="Provider ID Qualifier selected only allows professional (CMS-1500) forms" Q  ; allow professional
 . ;
 . ; field .06 (ID qualifier)
 . I Z=.06 D   ;,IBPRV["355.93" D
 .. S DIR(0)="PAOr^355.97:AEMQ"
 .. S DIR("?")="Enter a Qualifier to indentify the type of ID number you are entering."
 .. N TAG
 .. S TAG=$S($G(IBSLEV)=1&($$GET1^DIQ(355.93,+IBPRV,.02,"I")=1):"NVALFOWN",$G(IBSLEV)=1:"RAOWN",$$GET1^DIQ(355.93,+IBPRV,.02,"I")=1:"LFINS",1:"RAINS")
 .. N AFT
 .. S AFT=$S($P(IB0,U,4)]"":$P(IB0,U,4),1:$P(IBOLD,U,4))
 .. D
 ... I AFT=1 S DIR("S")="I $$"_TAG_"^IBCEPU(Y),$$GET1^DIQ(355.97,+Y,.07,""I"")'=""P""",DIR("?")="Provider ID Qualifier selected only allows institutional (UB type) forms" Q
 ... I AFT=2 S DIR("S")="I $$"_TAG_"^IBCEPU(Y),$$GET1^DIQ(355.97,+Y,.07,""I"")'=""I""",DIR("?")="Provider ID Qualifier selected only allows professional (CMS-1500) forms" Q
 ... S DIR("S")="I $$"_TAG_"^IBCEPU(Y)"
 .. I $$GET1^DIQ(355.93,+IBPRV,.02,"I")=1 D
 ... I AFT=1 S DIR("S")=DIR("S")_",$$GET1^DIQ(355.97,+Y,.03)'=""TJ""" Q
 ... I AFT=2 S DIR("S")=DIR("S")_",$$GET1^DIQ(355.97,+Y,.03)'=""EI""" Q
 ... I 'AFT S DIR("S")=DIR("S")_","".EI.TJ.""'[("".""_$$GET1^DIQ(355.97,+Y,.03)_""."")" Q
 . ;
 . S DA=0
 . F  D ^DIR S IBOK=0 D  Q:IBOK
 .. I $D(DUOUT)!$D(DTOUT) S IBOK=1 Q
 .. I X="",$P(IB0,U,(IBFLD*100))'="" S (X,Y)=$P(IB0,U,(IBFLD*100))
 .. I IBFLD=.06,$P(IB0,U,4)'=1,$P($G(^IBE(355.97,$S(+Y:+Y,1:+$P(IB0,U,6)),0)),U,3)="1A" W !,"BLUE CROSS IS ONLY ALLOWED FOR UB-04 ONLY" Q
 .. S IBOK=1
 . K DIR
 . I IBFLD=.03,'$D(DTOUT),'$D(DUOUT) D  S Y=IBCUY
 .. S IBCUVAL=+$G(^IBA(355.96,+Y,0))
 .. S IBCUY=+$O(^IBA(355.96,"AUNIQ",IBINS,IBCUVAL,$P(IB0,U,4),$P(IB0,U,5),$P(IB0,U,6),0))
 .. I 'IBCUY S IBCUY=+$O(^IBA(355.96,"AUNIQ",IBINS,IBCUVAL,$P(IB0,U,4),0,$P(IB0,U,6),0))
 .. I 'IBCUY S IBCUY=+$O(^IBA(355.96,"AUNIQ",IBINS,IBCUVAL,0,$P(IB0,U,5),$P(IB0,U,6),0))
 .. I 'IBCUY S IBCUY=+$O(^IBA(355.96,"AUNIQ",IBINS,IBCUVAL,0,0,$P(IB0,U,6),0))
 .. I 'IBCUY S IBCUY="@"
 . I IBIVAL'="",IBCUCHK,($P(Y,U)=IBIVAL!(X="")) S IBNEW=IBIVAL Q
 . I 'IBCUCHK,X="" S IBNEW=IBIVAL Q
 . I X'="@",($S(X="":IBIVAL'="",1:0)!$D(DTOUT)!$D(DUOUT)) S IBNEW="^1" Q
 . S IBNEW=$S(X'="@":$P(Y,U),1:X)
 . I IBFLD=.03,X="" S IBNEW="" ; No care unit selected
 I IBFLD=.02 D  ; Only file 355.9
 . N DIR,X,Y,DIC,DA,IBIT
 . S IBIT=$$GET1^DID(355.9,.02,,"INPUT TRANSFORM")
 . S DIR(0)="FAO^1:30"
 . S DIR("A")="INSURANCE CO: "_$S(IBVAL'="":IBVAL_"// ",1:" "),DIR("?")="^N IBHELP,Z D HELP^DIE(355.9,,.02,""A"",""IBHELP"") S Z=0 F  S Z=$O(IBHELP(""DIHELP"",Z)) Q:'Z  W !,IBHELP(""DIHELP"",Z)"
 . F  W ! D ^DIR D  I IBNEW'="" K DIR Q
 .. I $D(DTOUT)!$D(DUOUT) S IBNEW="^1" Q
 .. I IBIVAL'="",($P(Y,U)=IBIVAL!(X="")) S IBNEW=IBIVAL Q
 .. I X="@" S IBNEW="@" Q
 .. I X="",IBIVAL="" S IBNEW="*ALL*" Q
 .. S DIC="^DIC(36,",DIC(0)="EMQ",DIC("S")="X IBIT I $D(X)" D ^DIC
 .. I Y>0 S IBNEW=$P(Y,U) Q
 .. S Y="",IBNEW="^1"
 G:IBNEW="^1"!(IBNEW=IBIVAL)!(IBFLD=.07) EDITQ
 I $G(IBCK1) D
 . N X1,X2,X3,X4,X5,X6
 . S X1=$S(IBFILE=355.9:$S(IBFLD'=.01:IBPRV,1:IBNEW),1:"")
 . S X2=$S(IBFILE=355.9:$S(IBFLD'=.02:$P(IB0,U,2),1:IBNEW),1:$S(IBFLD'=.01:$P(IB0,U),1:IBNEW))
 . S X3=$S(IBFLD'=.03:$P(IB0,U,3),1:IBNEW),X4=$S(IBFLD'=.04:$P(IB0,U,4),1:IBNEW),X5=$S(IBFLD'=.05:$P(IB0,U,5),1:IBNEW),X6=$S(IBFLD'=.06:$P(IB0,U,6),1:IBNEW)
 . I X2="" S X2="*ALL*"
 . I X3="" S X3="*N/A*"
 . I IBFILE=355.9,$S(X4=""!(X5="")!(X6=""):1,$O(^IBA(355.9,"AUNIQ",X1,X2,X3,X4,X5,X6,0)):$O(^(0))'=IBIEN,1:0) S IBNEW=IBNEW_"^2" Q
 . I IBFILE=355.91,$S(X4=""!(X5="")!(X6=""):1,$O(^IBA(355.91,"AUNIQ",X2,X3,X4,X5,X6,0)):$O(^(0))'=IBIEN,1:0) S IBNEW=IBNEW_"^2" Q
 . F IB=2,3 D  Q:$P(IBNEW,U,3)=3
 .. S IB1=(X2="*ALL*"!(X3="*N/A*"))
 .. I IBFILE=355.9,IB=2,$S($P(IBOLD,U,2)="":X2'="*ALL*",1:$P(IBOLD,U,2)'=X2) S X2=""
 .. I IB=3,$S($P(IBOLD,U,3)="":X3'="*N/A*",1:$P(IBOLD,U,3)'=X3) S X3=""
 .. I '$$COMBOK^IBCEP5C(IBFILE,IBPRV_U_(IBFLD*100)_U_X2_U_X3_U_X4_U_X5_U_X6,IB1) S IBNEW="^3"
 ;
EDITQ Q IBNEW
