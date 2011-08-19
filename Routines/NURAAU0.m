NURAAU0 ;HIRMFO/RM,MD-DRIVER FOR ACUITY COUNTS...AMIS 1106a ;2/27/98  14:19
 ;;4.0;NURSING SERVICE;**9**;Apr 25, 1997
EN1 ;DONE BY: DAILY BATCH RUN 12:00 AM TO 2:00 AM    NURAAU2
 ;DOES: HSKEEP2^NURAAU4
 S X=$G(^DIC(213.9,1,"OFF")) Q:X=""!(X=1)
 ; check if acuity job is currently running
 I +$P(^DIC(213.9,1,"DATE"),U,13)>0  D:'$D(ZTQUEUED)  G QUIT1
 .W !!,"This option is currently running.",!! H 3
 .Q
 I $P(^DIC(213.9,1,"DATE"),U,1)>DT W:'$D(ZTQUEUED) !,"BATCH JOB HAS A FUTURE DATE. CALL IRM" G QUIT1 ;quit if DATE AMIS JOB LAST RUN is in future
 L +^DIC(213.9,1,"DATE"):0 I '$T,$D(ZTQUEUED) D  G QUIT1
 .  S ZTDTH=$$HADD^XLFDT($H,"","",59),ZTDESC="Requeued Nursing Acuity/Separation-Activation Run",ZTIO="",ZTRTN="EN1^NURAAU0" D ^%ZTLOAD
 .  Q
 ;
CONT ; start processing acuity totals
 D ^NURAAU5 ; check if MAS wards have a Nursing Location.
 S $P(^DIC(213.9,1,"DATE"),U,13)=$S($D(ZTQUEUED):ZTSK,1:1) ;set flag to show acuity job is running
 S NUROUTSW=0 ; initialize processing switch (0=process/1=stop)
 F  D  Q:NUROUTSW
 .D HSKEEP2^NURAAU4 Q:NUROUTSW  ; see when last job was run and set flags
 .I OUTSW(4) W:'$D(ZTQUEUED) !,"BATCH JOB ALREADY COMPLETED" S NUROUTSW=1 Q
 .I '$D(^NURSF(211.4,"ABS")) W:'$D(ZTQUEUED) !!,"No Bedsections associated with MAS units cannot process",! S NUROUTSW=1 Q
 .S RPTDATE=+$G(^DIC(213.9,1,"DATE"))
 .I +RPTDATE D EN2^NURAAU3 Q:NUROUTSW  D  ;purge old data and create new nodes
 ..F BED=0:0 S BED=$O(^NURSF(211.4,"ABS",BED)) Q:BED'>0!(NUROUTSW)  S BEDSECT=BED F NCWARD=0:0 S NCWARD=$O(^NURSF(211.4,"ABS",BED,NCWARD)) Q:NCWARD'>0!(NUROUTSW)  I $P($G(^NURSF(211.4,NCWARD,1)),U)="A" W:'$D(ZTQUEUED) "." D  Q:NUROUTSW
 ...S NURTYPE=0 F I=1:1:5 S NCLASS(I)=0
 ...F SHIFT="N","D","E" D FINALLY
 ...Q
 ..I 'OUTSW(2) D EN1^NURAMB1 ; process night shift acuity
 ..I 'OUTSW S NURCENDT=(.15+RPTDATE),NURCUTDT=(.1445+RPTDATE) D ^NURSACEN ; Calculate hospital census at day shift cutoff time (AMIS acuity).
 ..I 'OUTSW!'(OUTSW(1)) D EN1^NURAAU1 ; process day & evening shift acuity
 ..I 'OUTSW(3) D EN1^NURAMU3 ; separation/activation update
 ..S X=+$G(^DIC(213.9,1,"DATE")),$P(^DIC(213.9,1,"DATE"),U)=$$FMADD^XLFDT(X,1) H 5 ;add one day to last process date and wait 5 seconds
 ..F X=2,6,9,10 S $P(^DIC(213.9,1,"DATE"),U,X)=1
 ..I +$G(^DIC(213.9,1,"DATE"))=DT S NUROUTSW=1 ; if acuity totals are done through today, then set process flag to 1 (stop)
 ..Q
 .Q
 S $P(^DIC(213.9,1,"DATE"),U,13)="" ;set flag to show acuity job is finished running
QUIT ; unlock parameter node
 L -^DIC(213.9,1,"DATE")
QUIT1 ; kill local variables and close device
 D KVAR^VADPT,^NURAKILL S:$D(ZTQUEUED) ZTREQ="@" D ^%ZISC
 Q
FINALLY ; ADD ACUITY COUNTS TO FILE
 S X=RPTDATE_SHIFT_NCWARD D EN1^NURAMHU S DA(1)=DA ; EN1^NURAMHU creates/looks up 213.4 entries (AMIS 1106 MANHOURS file)
 L +^NURSA(213.4,DA(1)):0 G:'$T FINALLY
 I '$D(^NURSA(213.4,DA(1),1,0)) S ^NURSA(213.4,DA(1),1,0)="^213.41PA^^"
 S DA=$O(^NURSA(213.4,DA(1),1,"B",+BEDSECT,0)) I +DA>0 G EDIT
 S X=+BEDSECT,DLAYGO=213.41,DIC="^NURSA(213.4,DA(1),1,",DIC(0)="L" K DD
 D FILE^DICN K DD,DLAYGO Q:+Y'>0
 S DA=+Y,^NURSA(213.4,DA(1),1,DA,0)=+BEDSECT_"^0^0^0^0^0",^NURSA(213.4,DA(1),1,"B",+BEDSECT,DA)=""
EDIT S ZERONOD=$G(^NURSA(213.4,DA(1),1,DA,0)) F X=2:1:6 S $P(^NURSA(213.4,DA(1),1,DA,0),U,X)=($P(ZERONOD,U,X)+NCLASS(X-1))
 L -^NURSA(213.4,DA(1))
 Q
