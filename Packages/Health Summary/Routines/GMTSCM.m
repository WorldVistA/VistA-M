GMTSCM ; SLC/JER,KER - Create/Modify Health Summary Comp ; 02/27/2002
 ;;2.7;Health Summary;**7,30,49**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10112  $$SITE^VASITE
 ;   DBIA 10006  ^DIC
 ;   DBIA 10022  %XY^%RCR
 ;   DBIA 10018  ^DIE
 ;   DBIA 10026  ^DIR
 ;   DBIA    82  EN^XQORM
 ;                 
MAIN ; Controls branching
 N %,C,D,D0,GMCMP,GMTSQIT,X,Y,DIRUT
 I +$G(DUZ(2))'>0 W !,"DUZ(2) must be set to your division.",! Q
 F  D  Q:$D(GMTSQIT)
 . N DA,DIC,DIE,DR,GMCMP,X,Y,GMDA,DLAYGO,DIDEL,GMSITE
 . S GMSITE=$P($$SITE^VASITE(),U,3)
 . S:GMSITE'>0 GMSITE=DUZ(2)
 . S:+$P($G(^GMT(142.1,0)),U,3)'>100000 $P(^GMT(142.1,0),U,3)=GMSITE_"000"
 . S DIC=142.1,DIC(0)="AEMQLZ",DIC("A")="Select COMPONENT: "
 . S DIC("S")="I $S(DUZ(2)=5000:1,(+$G(Y)'<100001)&(+$G(Y)'>9999999):1,1:0)"
 . S DLAYGO=142.1
 . D ^DIC I +Y'>0 S GMTSQIT="" Q
 . S GMDA=+Y
 . I +$P(Y,U,3) S GMCMP(0)=$P(Y,U,2) D COPY(.GMCMP)
 . S DIDEL=142.1
 . I $D(GMCMP)=11 S GMCMP=+GMDA D  Q
 . . I $D(GMCMP(3.5))>9 D
 . . . N %X,%Y
 . . . S %X="GMCMP(3.5,",%Y="^GMT(142.1,"_+GMDA_",3.5," D %XY^%RCR
 . . S DIE="^GMT(142.1,",DA=+GMDA
 . . S DR=".01;1///^S X=$P(GMCMP(0),U,2);2///"_$P(GMCMP(0),U,3)_";4///"_$P(GMCMP(0),U,5)_";6///"_$P(GMCMP(0),U,7)_";10///"_$P(GMCMP(0),U,10)_";11///"_$P(GMCMP(0),U,11)_";12///"_$P(GMCMP(0),U,12)
 . . S DR=DR_";3;3.5;I X=""^""!(X=""^^"") S DIRUT=1,Y=""@1"";1;2;4;10;11;12;6;9;@1"
 . . D ^DIE I $D(Y)>9!($D(DIRUT))!'$D(DA) S GMTSQIT="" Q
 . . I $D(GMCMP("SEL")) D
 . . . S DIE="^GMT(142.1,"_+DA_",1,",DA(1)=DA,DA=1,DR=".01///"_$P(GMCMP("SEL"),U)_";1///"_$P(GMCMP("SEL"),U,2) S:'$D(@(DIE_"0)")) ^(0)="^142.17P^^" D ^DIE  I $D(Y)>9 S GMTSQIT="" Q
 . . S DIE="^GMT(142.1,",(GMCMP,DA)=+GMDA,DR=7
 . . D ^DIE I $D(Y)>9!($D(DIRUT)) S GMTSQIT="" Q
 . . I $D(DA) D  Q
 . . . W ! I $$ADHOC D ENADHOC^GMTSRM W !!,">>> Returning to Create/Modify Health Summary Component Option.",!
 . S DIE="^GMT(142.1,",(GMCMP,DA)=+GMDA,DR=".01;1;3;3.5;I X=""^""!(X=""^^"") S DIRUT=1,Y=""@1"";2;4;10;11;12;6;9;7;@1"
 . D ^DIE I $D(Y)>9!($D(DIRUT)) S GMTSQIT="" Q
 . I $D(DA) D  Q
 . . W ! I $$ADHOC,'$D(DIRUT) D ENADHOC^GMTSRM W !!,">>> Returning to Create/Modify Health Summary Component Option.",!
 . . I $D(DIRUT) S GMTSQIT="" Q
 . D CLEANUP^GMTSDD
 Q
COPY(GMCMP) ; Duplicate existing Health Summary Component
 N %,DIC,DIR,GMI,I,X,XQORM,XQORSPEW,Y
 S DIR(0)="Y",DIR("A")="Do you wish to duplicate an existing COMPONENT"
 S DIR("B")="YES" D ^DIR Q:+Y'>0
 S DIC=142,DIC(0)="XF",X="GMTS HS ADHOC OPTION" S Y=$$TYPE^GMTSULT Q:+Y'>0
 S XQORM=+Y_";GMT(142,",XQORM(0)="1AD",XQORM("A")="Enter COMPONENT to Duplicate: "
 W ! D EN^XQORM Q:+Y'>0
 S GMCMP=+$P($G(^GMT(142,+XQORM,1,+Y(1),0)),U,2)
 S GMCMP(0)=GMCMP(0)_U_$P($G(^GMT(142.1,+GMCMP,0)),U,2,12)
 I $O(^GMT(142.1,+GMCMP,3.5,0)) D
 . S GMCMP(3.5,0)=$G(^GMT(142.1,+GMCMP,3.5,0))
 . S GMI=0 F  S GMI=$O(^GMT(142.1,+GMCMP,3.5,GMI)) Q:+GMI'>0  D
 . . S GMCMP(3.5,GMI,0)=$G(^(GMI,0))
 I $O(^GMT(142.1,+GMCMP,1,0)) S GMCMP("SEL")=$G(^GMT(142.1,+GMCMP,1,$O(^(0)),0))
 Q
ADHOC() ; Ask user whether or not to ADD new component to AD HOC
 N %,DIR,X,Y
 S DIR(0)="Y",DIR("A")="ADD new Component to the AD HOC Health Summary"
 S DIR("B")="NO" D ^DIR
 Q Y
