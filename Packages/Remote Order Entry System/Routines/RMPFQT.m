RMPFQT ;DDC/KAW-QUEUE A BATCH FOR TRANSMISSION [ 09/03/97  3:16 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;**16**;JUN 16, 1995
 ;;Reference to ^VA(200) supported by DBIA #10060
 ;;Reference to ^DIC(4.2) supported by DBIA #248
RMPFSET I '$D(RMPFMENU) D MENU^RMPFUTL I '$D(RMPFMENU) W !!,$C(7),"*** A MENU SELECTION MUST BE MADE ***" Q  ;;RMPFMENU must be defined
 I '$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS) D ^RMPFUTL Q:'$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS)
 W @IOF,!!,"QUEUE A BATCH FOR TRANSMISSION"
 W !!,"This option will allow you to queue the transmission of a batch"
 W !,"to the VA Denver Distribution Center.  Only batches with the status"
 W !,"CLOSED, QUEUED FOR TRANSMISSION or TRANSMITTED may be chosen."
 S XMINST=$O(^DIC(4.2,"B","DDC.VA.GOV",0)) I XMINST,$D(^DIC(4.2,XMINST,0))
 E  W !!,"*** 'DDC.VA.GOV' DOMAIN NOT SET UP FOR TRANSMISSION ***" H 2 G END
 F I=1:1 Q:$Y>21  W !
 W !!,"Enter <RETURN> to continue. " D READ G END:$D(RMPFOUT)
DISP K RMPFS S (RMPFS(4),RMPFS(2),RMPFS(3))="" D DISP^RMPFDB G SHOW:$D(RMPFBT)
 I '$D(RMPFB) W !!,"*** NO BATCHES AVAILABLE ***" G END
 D SEL^RMPFDB G END:$D(RMPFOUT)!'$D(RMPFBT)
SHOW W !!,"Display batch entries? YES// " D READ
 G END:$D(RMPFOUT)
SHOW1 I $D(RMPFQUT) W !!,"Enter <Y> or <RETURN> to display entries in the batch or <N> to continue." G SHOW
 S:Y="" Y="Y" I "YyNn"'[Y S RMPFQUT="" G SHOW1
 G CONT:"Nn"[Y D ^RMPFDB1
CONT W !!,"Do you wish to continue with the transmission? NO// "
 D READ G END:$D(RMPFOUT)
CONT1 I $D(RMPFQUT) W !!,"Enter a <Y> to transmit the batch, <N> or <RETURN> to avoid transmission." G CONT
 S:Y="" Y="N" S Y=$E(Y,1) I "NnYy"'[Y S RMPFQUT="" G CONT1
 G END:"Yy"'[Y D STAT,AUTOQ
 W !!,"*** Queued for Transmission ***",! G END
AUTOQ ;;Automatic queueing of transmission batch
 ;; input: RMPFBT
 ;;output: None
 S XMINST=$O(^DIC(4.2,"B","DDC.VA.GOV",0)) I XMINST,$D(^DIC(4.2,XMINST,0))
 E  G END
 S RMPFP3=$P(RMPFSYS,U,3)
 S ZTRTN="TRANS^RMPFQT",ZTIO="",ZTDESC="DDC ORDER"
 I RMPFP3="I"!(RMPFP3="")!(RMPFP3="A") S ZTDTH=$H
 I RMPFP3="S" S ZTDTH=$S($P(RMPFSYS,U,4)?1"."1N.4N:DT_$P(RMPFSYS,U,4),1:$H)
 S ZTSAVE("RMPFBT")=RMPFBT,ZTSAVE("RMPFSTAP")=RMPFSTAP,ZTSAVE("XMINST")=XMINST,ZTSAVE("RMPFSYS")="",ZTSAVE("RMPFMENU")=""
 D ^%ZTLOAD
 S DIE="^RMPF(791812,",DA=RMPFBT,DR=".02////4" D ^DIE
 S X="NOW",%DT="T" D ^%DT
 S DIE="^RMPF(791810,",DR=".03////9;.06////"_Y,II=0
 F I=1:1 S II=$O(^RMPF(791812,RMPFBT,101,II)) Q:'II  I $D(^RMPF(791812,RMPFBT,101,II,0)),'$P(^(0),U,2) S DA=$P(^(0),U,1) D ^DIE:DA
END K RMPFP3,RMPFSIG,RMPFS,RMPFB,RMPFBT,ZTRTN,ZTIO,ZTDESC,ZTSAVE,ZTDTH
 K RMPFOUT,RMPFQUT,ZTSK,%,%T,D,D0,DA,DI,DIC,DIE,DQ,DR,I,II
 K XMINST,TD,X,Y,%H Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
TRANS ;;Build and send message with ROES orders
 ;; input: RMPFBT
 ;;output: None
 Q:'$D(^RMPF(791812,RMPFBT,0))
 S XMDUZ=DUZ,XMDUN=$P(^VA(200,DUZ,0),U,1)
 S XMSUB="VADDC TRANS-"_RMPFSTAP_"-"_$P(^RMPF(791812,RMPFBT,0),U,1)
 D XMZ^XMA2 Q:XMZ=-1  S X="NOW",%DT="T" D ^%DT
 S DIE="^RMPF(791812,",DA=RMPFBT,DR=".06////"_XMZ_";.07////"_Y_";.02////3" D ^DIE
 D ^RMPFQT1
 S XMY("S.RMPFAUTO-READ@DDC.VA.GOV")=XMINST D ENT1^XMD
TRANSE K XMDUZ,XMSUB,XMTEXT,XMY,XMZ,DIE,DR,D0,DI,DQ,DR,DA,D,X,Y Q
STAT ;;change status of lines to be sent to APROVED if batch status=transmitted
 Q:$P(^RMPF(791812,RMPFBT,0),U,2)'=3
 S APP=$O(^RMPF(791810.2,"B","APPROVED",0)) Q:'APP
 S J=0 F  S J=$O(^RMPF(791812,RMPFBT,101,J)) Q:'J  D
 .Q:'$D(^(J,0))  S RMPFX=$P(^(0),U,1) Q:'RMPFX  Q:'$D(^RMPF(791810,RMPFX,0))  D
 ..S RMPFY=0 F  S RMPFY=$O(^RMPF(791810,RMPFX,101,RMPFY)) Q:'RMPFY  D
 ...S ST=$P($G(^(RMPFY,0)),U,18) Q:'ST  S STP=$P($G(^RMPF(791810.2,ST,0)),U,1)
 ...I $P(STP,"-",2)="TRANS" S $P(^RMPF(791810,RMPFX,101,RMPFY,0),U,18)=APP
STATE K RMPFX,RMPFY,J,ST,STP Q
