ENFAR6 ;WIRMFO/SAB-FIXED ASSET RPT, EQUIP NOT REPORTED TO FAP; 7/19/96
 ;;7.0;ENGINEERING;**29,33**;Aug 17, 1993
 ; List of Capitalized NX Equipment which has not been reported to FAP
EN ; The option which calls this routine should normally be queued
 ;   to print weekly via TaskManager.
 I $D(ZTQUEUED) G QEN ; no user input when automatically queued
 ; ask device
 W !!,"This report searches the entire equipment file and may take some"
 W !,"time to complete. Consider queuing this report to run after-hours."
 S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^ENFAR6"
 . S ZTDESC="Capitalized NX Equip. Not Reported to FAP"
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
QEN ; queued entry
 U IO
 S ENPG=0 D NOW^%DTC S Y=% D DD^%DT S ENDT=Y
 S ENL="",$P(ENL,"-",IOM)=""
 D HD
 S (ENC,END,ENT)=0
 S ENSND=$$GET1^DIQ(6910,"1,",1) S:ENSND="" ENSND="Unk" ; default station
 ; loop thru equipment file
 S ENDA=0 F  S ENDA=$O(^ENG(6914,ENDA)) Q:'ENDA  D  Q:END
 . S ENC=ENC+1
 . I '(ENC#500),$D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,END=1 Q
 . Q:$P($G(^ENG(6914,ENDA,8)),U,2)'=1  ; not capitalized
 . Q:$P($G(^ENG(6914,ENDA,3)),U,11)]""  ; disposition date exists
 . Q:$P($G(^ENG(6914,ENDA,0)),U,4)'="NX"  ; not NX
 . Q:+$$CHKFA^ENFAUTL(ENDA)  ; already reported to FAP
 . ; should have been reported and wasn't
 . I $Y+4>IOSL D HD Q:END
 . S ENT=ENT+1
 . S ENAQDT=$$GET1^DIQ(6914,ENDA,13)
 . S ENVALUE=$$GET1^DIQ(6914,ENDA,12)
 . S ENFUND=$$GET1^DIQ(6914,ENDA,62)
 . S ENSGL=$$GET1^DIQ(6914,ENDA,38)
 . S ENCSN=$$GET1^DIQ(6914,ENDA,18)
 . S ENCMR=$$GET1^DIQ(6914,ENDA,19)
 . S ENSN=$P($G(^ENG(6914,ENDA,9)),U,5) S:ENSN="" ENSN=ENSND
 . W !,ENDA,?11,ENAQDT,?24,$J("$"_$FN(ENVALUE,",",2),14),?40,ENSN
 . W ?48,ENFUND,?55,ENSGL,?61,ENCSN,?74,ENCMR
 I END W !!,"REPORT STOPPED AT USER REQUEST"
 E  D
 . I ENT=0 W !!,"All capitalized NX equipment has been reported to Fixed Assets."
 . I ENT>0 W !!,ENT," capitalized NX equipment entries have not been reported to Fixed Assets."
 . I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
EXIT I $D(ZTQUEUED) S ZTREQ="@"
 K DIR,DIROUT,DIRUT,DIWF,DIWL,DTOUT,DUOUT,X,Y
 K ENAQDT,ENC,ENCMR,ENCSN,ENDA,ENFUND,ENSGL,ENSN,ENSND,ENT,ENVALUE
 K END,ENDT,ENL,ENPG
 Q
HD ; header
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,END=1 Q
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W !,"CAPITALIZED NX EQUIP. NOT REPORTED TO FAP"
 W ?49,ENDT,?72,"page ",ENPG
 W !!,"ENTRY#",?11,"ACQ. DATE",?24,"ASSET VALUE",?40,"STATION"
 W ?48,"FUND",?55,"SGL",?61,"CSN",?74,"CMR"
 W !,$E(ENL,1,10),?11,$E(ENL,1,12),?24,$E(ENL,1,14),?40,$E(ENL,1,7)
 W ?48,$E(ENL,1,6),?55,$E(ENL,1,4),?61,$E(ENL,1,11),?74,$E(ENL,1,5)
 Q
 ;ENFAR6
