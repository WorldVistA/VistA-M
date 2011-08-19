GMTSRM5 ;SLC/DLT - Create/Modify - Copy from existing type ; 07/18/2000
 ;;2.7;Health Summary;**30,37**;Oct 20, 1995
 ;
SELCMP ;Select components from existing health summary type
 N DIC,DIR,GMI,GMTSEG,GMTSEGI,GMTSTITL,GMTSTYP,I,SEQ,X,XQORM,Y
 W ! S DIR(0)="Y",DIR("A")="Do you wish to copy COMPONENTS from an existing Health Summary Type",DIR("B")="YES"
 ; DBIA 10026 call ^DIR
 D ^DIR S:+Y'>0 EXISTS=0 S:$D(DTOUT)!($D(DIROUT)) GMTSQIT=1 K DIR Q:+Y'>0
 W ! S GMTSQIT=0,DIC=142,DIC(0)="AEFQMZ",DIC("A")="Select Health Summary Type to copy from: "
 S Y=$$TYPE^GMTSULT K DIC S:Y=-1 GMTSQIT=1 Q:GMTSQIT  S GMTSTYP=+Y,GMTSTITL=$P(Y,U,2)
 W @IOF,"The Following Components are Available:",!
 S XQORM("S")="I $P(^GMT(142.1,$P(^GMT(142,DA(1),1,DA,0),U,2),0),U,6)'=""Y"""
 S XQORM=GMTSTYP_";GMT(142,",XQORM(0)="DA",XQORM("A")="Select COMPONENTS(S): ",XQORM("??")="D HELP^GMTSRM2"
 ; DBIA 10140 call EN^XQORM
 D EN^XQORM I Y'>0 S GMTSQIT=1 K XQORM,Y Q
 S (X,GMI,SEQ)=0 F  S GMI=$O(Y(GMI)) Q:'GMI  S X=^GMT(142,GMTSTYP,1,+Y(GMI),0) I $P(X,U,2) S SEQ=SEQ+1,GMTSEG(SEQ)=X,GMTSEGI($P(X,U,2))=SEQ D SETUPSEL
 ;Load global from GMTSEG() array.
 S:'$D(^GMT(142,GMTSIFN,1,0)) ^(0)="^142.01IA^0^0"
 W !!,"Loading components into the Health Summary Type with defaults"
 S EXISTS=1
 S SEQ=0 F  S SEQ=$O(GMTSEG(SEQ)) Q:'SEQ  D LOADCMP
 Q
LOADCMP ; Call DIE to stuff STRUCTURE multiple for each component
 N ISEQ,DA,DIE,DR,CNT,SDA,S2
 S (ISEQ,DA)=SEQ*5,DIE="^GMT(142,"_GMTSIFN_",1,",DA(1)=GMTSIFN
 S DR=".01///"_DA_";1///"_$P(GMTSEG(SEQ),U,2)_";2///"_$P(GMTSEG(SEQ),U,3)
 S DR=DR_";3///"_$P(GMTSEG(SEQ),U,4)_";5///"_$P(GMTSEG(SEQ),U,5)
 S DR=DR_";6///"_$P(GMTSEG(SEQ),U,6)_";7///"_$P(GMTSEG(SEQ),U,7)
 S DR=DR_";8///"_$P(GMTSEG(SEQ),U,8)_";9///"_$P(GMTSEG(SEQ),U,9)
 ; DBIA 10018 call ^DIE
 D ^DIE
 S (CNT,S2)=0 F  S S2=$O(GMTSEG(SEQ,S2)) Q:'S2  D LOADSEL
 I CNT>0 S:'$D(^GMT(142,GMTSIFN,1,ISEQ,1,0)) ^(0)="^142.14V^"_SDA_"^"_CNT
 Q
LOADSEL ; Loads selection item multiple
 N DIE,DA,DR
 S:'$D(^GMT(142,GMTSIFN,1,ISEQ,1,0)) ^(0)="^142.14V^^"
 S DIE="^GMT(142,"_GMTSIFN_",1,"_ISEQ_",1,",DA(2)=GMTSIFN,DA(1)=ISEQ,DA=S2,DR=".01////"_"^S X=GMTSEG(SEQ,S2)"
 ; DBIA 10018 call ^DIE
 D ^DIE S SDA=DA,CNT=CNT+1
 Q
SETUPSEL ;Setup default selection items into new summary type
 N S2,SEL
 S S2=0 F  S S2=$O(^GMT(142,GMTSTYP,1,+Y(GMI),1,S2)) Q:'S2  S SEL=^(S2,0) S GMTSEG(SEQ,S2)=SEL
 Q
