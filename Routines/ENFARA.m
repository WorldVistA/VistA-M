ENFARA ;WIRMFO/SAB-FIXED ASSET RPT, ADJUSTMENT VOUCHER ;6/30/97
 ;;7.0;ENGINEERING;**39**;Aug 17, 1993
 ; Adjustment Vouchers during Selected Period
 ; This report can be scheduled for automatic queuing.
EN ;
 ; set start date to yesterday
 S ENDTS=$$FMADD^XLFDT($P(DT,"."),"-1")
 ; ask start date when interactive
 I '$D(ZTQUEUED) D  G:$D(DIRUT) EXIT
 . S DIR(0)="D^::EX",DIR("A")="Start Date",DIR("B")="T-1"
 . D ^DIR K DIR S ENDTS=Y
 ; set end date equal to start date
 S ENDTE=ENDTS
 ; ask end date when interactive
 I '$D(ZTQUEUED) D  G:$D(DIRUT) EXIT
 . S DIR(0)="D^::EX",DIR("A")="End Date",DIR("B")=$$FMTE^XLFDT(ENDTS,"D")
 . D ^DIR K DIR S ENDTE=Y
 I ENDTE<ENDTS W $C(7),!,"End date can't be prior to start date!",! G EN
 ; set sort by user to NO
 S ENSRT("U")=0
 ; ask sort by user when interactive
 I '$D(ZTQUEUED) D  G:$D(DIRUT) EXIT
 . S DIR(0)="Y",DIR("B")="NO"
 . S DIR("A")="Sort by person that created the Adj. Voucher"
 . D ^DIR K DIR S ENSRT("U")=Y
 I '$D(ZTQUEUED),ENSRT("U") D  G:ENSRT("U",0)="" EXIT
 . S ENSRT("U",0)=""
 . S DIR(0)="Y"
 . S DIR("A")="Include all users",DIR("B")="YES"
 . D ^DIR K DIR Q:$G(DIRUT)
 . I Y S ENSRT("U",0)="*",ENSRT("U",0,"E")="ALL USERS"
 . E  D
 . . S DIC="^VA(200,",DIC(0)="AQEM"
 . . S DIC("B")=$$GET1^DIQ(200,DUZ,.01)
 . . D ^DIC K DIC Q:Y<1
 . . S ENSRT("U",0)=+Y,ENSRT("U",0,"E")=$$GET1^DIQ(200,+Y,.01)
 ; ask device when interactive
 I '$D(ZTQUEUED) S %ZIS="QM" D ^%ZIS G:POP EXIT I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^ENFARA1",ZTDESC="Adjustment Voucher Report"
 . F X="ENDTS","ENDTE","ENSRT(" S ZTSAVE(X)=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
 D QEN^ENFARA1
EXIT ;
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 K ENDTE,ENDTS,ENSRT
 Q
 ;ENFARA
