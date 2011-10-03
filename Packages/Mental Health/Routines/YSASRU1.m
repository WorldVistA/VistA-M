YSASRU1 ;ASF/ALB- ASI NATIONAL ROLL UP UTILS ;3/19/97  16:50
 ;;5.01;MENTAL HEALTH;**24,30,32,38**;Dec 30, 1994
 Q
RESENDI ;individual resend
 N DIC,YSASIEN
 S DIC="^YSTX(604,",DIC(0)="AEQM",DIC("A")="Select ASI Administration:" D ^DIC
 Q:Y'>0
 S YSASIEN=+Y
 I $P($G(^YSTX(604,YSASIEN,.5)),U)'=1 W !,"This ASI has not been signed and cannot be transmitted!",$C(7) G RESENDI
 S DA=YSASIEN,DIE="^YSTX(604,",DR="5.5///1"
 L +^YSTX(604,YSASIEN):9999 Q:'$T
 D ^DIE
 L -^YSTX(604,YSASIEN)
 W !,"Placed in transmission list"
 G RESENDI
 ;
TIMED ;send all signed given between
 N YSASE,YSASNB,YSASL
 W !,"PLEASE use this option ONLY when instructed to do so by the",!,"Remote Systems Support staff!"
 K DIR S DIR(0)="Y",DIR("A")="Have you been instructed to resend data",DIR("B")="No"
 D ^DIR Q:Y'=1
 K DIR S DIR(0)="D^2960101:DT",DIR("A")="Enter Earliest Date" D ^DIR
 Q:$D(DIURT)
 S YSASE=Y
 K DIR S DIR(0)="D^"_YSASE_":DT",DIR("A")="Enter Latest Date" D ^DIR
 Q:$D(DIURT)
 S YSASL=Y
 S YSASE=YSASE-.001,YSASNB=0
 F I=1:1 S YSASE=$O(^YSTX(604,"AD",YSASE)) Q:YSASE>YSASL!(YSASE'>0)  D
 . S N=0 F  S N=$O(^YSTX(604,"AD",YSASE,N)) Q:N'>0  D
 .. I $P($G(^YSTX(604,N,.5)),U)=1 S ^YSTX(604,"ATR",1,N)="",$P(^YSTX(604,N,5),U,3)=1,YSASNB=YSASNB+1
 ;
 W !,YSASNB," ASI's added to the transmission list"
 Q
QUEIT ; task out resend
 S X1=DT,X2=7 D C^%DTC
 K DIR S DIR(0)="D^NOW:"_X_":EFXR",DIR("A")="Resend Date and Time",DIR("B")="T@11pm"
 D ^DIR
 Q:$D(DIRUT)
 S ZTRTN="EN^YSASRU",ZTIO="",ZTDTH=Y,ZTDESC="ASI RESEND YSASRU1" D ^%ZTLOAD
 W !,"Thanks........" H 2
 Q
AA ; print awaiting report
 S DIC="^YSTX(604,",L=0,FLDS=".05;""DATE"",.02;L30,.04;L5,.09;L20",BY="5.5,.05,.02"
 S FR(1)="",FR(2)="",FR(3)="",DHD="ASI Awaitng Transmission List"
 D EN1^DIP
 Q
