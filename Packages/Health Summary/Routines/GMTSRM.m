GMTSRM ; SLC/KER - Edit HS Type                   ; 01/06/2003
 ;;2.7;Health Summary;**30,35,29,47,56,58**;Oct 20, 1995
 ;
 ; External References
 ;    DBIA 10076  ^XUSEC(
 ;    DBIA 10076  ^XUSEC("GMTSMGR"
 ;    DBIA 10018  ^DIE
 ;    DBIA 10010  EN1^DIP
 ;    DBIA 10026  ^DIR
 ;                   
MAIN ; Main loop to modify multiple health summary types
 N %,DTOUT,DUOUT,DIRUT,EXISTS,GMTSFUNC,GMTSQIT,P
 S GMTSQIT=0 F  S EXISTS=0 D SELTYP Q:GMTSQIT
 Q
SELTYP ; Select Health Summary Type to Edit
 N CHANGE,DA,DIC,DIE,DLAYGO,DR,DUOUT,EXISTS,GMTSUM,GMTSNEW,GMTSMGR,GMTSEG,GMTSIFN,SELCNT,X,Y
 W ! S U="^",DIC="^GMT(142,",DIC(0)="AEMQL"
 S DIC("A")="Select Health Summary Type: "
 S DIC("S")="I +($$AHST^GMTSULT(+($G(Y))))" S DLAYGO=142
 S Y=$$TYPE^GMTSULT K DIC S:+Y'>0 GMTSQIT=1 Q:+Y'>0  S (GMTSIFN,DA)=+Y
 S GMTSUM=$P(Y,U,2),GMTSNEW=+$P(Y,U,3),GMTSMGR=$S($D(^XUSEC("GMTSMGR",DUZ)):1,1:0)
 I 'GMTSMGR,($P(^GMT(142,+DA,0),U,2)]"") D  Q:'GMTSMGR
 . S GMTSMGR=$D(^XUSEC($P(^(0),U,2),DUZ))
 . W:'GMTSMGR !,$C(7),"This summary report is currently locked to prevent alteration.",!
 I 'GMTSMGR,'GMTSNEW,($P(^GMT(142,+DA,0),U,3)'=DUZ) W !,$C(7),"Alteration of this summary report is restricted to its owner.",!,"See the Clinical Coordinator if you need additional help." Q
 I $D(^GMT(142.5,"AC",+DA)) D  Q:+DA'>0
 . W !!,$C(7),"WARNING:  You are about to edit a Health Summary Type that is being used"
 . W !,"by a Health Summary Object.  Changing the structure of this Health Summary"
 . W !,"Type will alter how the Object will display.",! H 1
 . N DIR,DTOUT,DUOUT,DIROUT,X,Y S DIR(0)="YAO",DIR("B")="NO"
 . S DIR("A")="Do want to continue?  " D ^DIR S:+Y'>0 DA=0
 . I $D(DTOUT)!($D(DUOUT))!($D(DIROUT)) S DA=0,GMTSQIT=1
 S DIE="^GMT(142,",(GMTSIFN,DA)=+Y,DR="[GMTS EDIT HLTH SUM TYPE]" D ^DIE
 I '$D(^GMT(142,+GMTSIFN,0))!$D(Y)!$D(DUOUT)!$D(DIROUT)!$D(DTOUT) D  Q
 . S GMTSQIT=1 D CHKDEL Q
 I 'GMTSNEW,($O(^GMT(142,+GMTSIFN,1,0))) S EXISTS=1 D LIST,EXISTS Q
 D SELCMP^GMTSRM5 Q:GMTSQIT  D LIST:EXISTS,EXISTS D CHKDEL
 Q
CHKDEL ; Check for Possible Deletion (New Type without Component)
 Q:+($G(GMTSIFN))'>0  Q:'$D(^GMT(142,+($G(GMTSIFN)),0))  D:GMTSMGR!(GMTSNEW)!($P(^GMT(142,+GMTSIFN,0),U,3)'=$G(DUZ)) ADEL^GMTSRM2(+($G(GMTSIFN)))
 Q
ENADHOC ; Entry point for AD HOC edit
 N %,C,CHANGE,DA,DIC,DIE,DR,DUOUT,EXISTS,I,GMTSIFN,GMTSN,GMTSNCNT,GMTSNEW
 N GMTSIFN,GMTSUM,P,SELCNT
 N GMTSQIT,GMTSFUNC,X,Y
 W !!,">>> EDITING the GMTS HS ADHOC OPTION Health Summary Type"
 S (GMTSNEW,GMTSQIT)=0
 S DIC=142,DIC(0)="XZF",X="GMTS HS ADHOC OPTION"
 S Y=$$TYPE^GMTSULT I +Y'>0 D ^GMTSLOAD Q:$D(DIRUT)!$D(DIROUT)  G ENADHOC
 S GMTSIFN=+Y,GMTSUM=$P(Y,U,2),EXISTS=1
 S DIE="^GMT(142,",DA=GMTSIFN,DR=".08T" D ^DIE
 Q:$D(Y)
 D LIST,EXISTS
 Q
EXISTS ; Edit an existing health summary type
 N CNT,NXTCMP Q:$D(DUOUT)  S NXTCMP=0,NXTCMP(0)=0
 F CNT=$$GETCNT(GMTSIFN):0 D NXTCMP^GMTSRM1,LIST:GMTSQIT Q:GMTSQIT!($D(DUOUT))  K GMTSQIT,GMTSNEW,TWEENER,SOACTION
 I NXTCMP>0 W !,"Please hold on while I resequence the summary order" D COPY^GMTSRN,RNMBR^GMTSRN:CHANGE
 Q
LIST ; Lists existing summary parameters
 N B,DIC,DIR,IOP,Y,FR,TO,BY,DHD,FLDS,L
 I GMTSQIT'=2 Q:($D(DUOUT)!(GMTSQIT=1))
 I GMTSQIT=2,(NXTCMP=0) S GMTSQIT=0 Q
 I 'GMTSNEW W ! S DIC=142,DIR(0)="Y",DIR("A")="Do you wish to review the Summary Type structure before continuing",DIR("B")="NO" D ^DIR K DIR I 'Y S:GMTSQIT=2 DUOUT="" S:GMTSQIT=2 GMTSQIT="D" S:$D(DUOUT) GMTSQIT=1 Q
 I $D(GMTSQIT),GMTSQIT=2 S GMTSQIT=0
 S IOP="HOME",DIC=142,(FR,TO)=GMTSUM,BY=".01",DHD="[GMTS TYPE INQ HEADER]-[GMTS TYPE INQ FOOTER]",FLDS="[GMTS TYPE INQ]",L=0 D EN1^DIP
 Q
GETCNT(GMTSIFN) ; Determine default summary order for new component
 N LI,LCNT S LI=0,LCNT=5 F  S LI=$O(^GMT(142,+GMTSIFN,1,LI)) Q:+LI'>0  S LCNT=$P(LI,".")+5
 Q LCNT
