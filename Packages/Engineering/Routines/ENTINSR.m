ENTINSR ;WOIFO/SAB - NON-SPACE FILE LOCATION REPORT ;2/4/2008
 ;;7.0;ENGINEERING;**87**;Aug 17, 1993;Build 16
 ;
 ; ask device
 S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^ENTINSR",ZTDESC="Non-Space File Location Report"
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK,IO("Q")
 ;
QEN ; queued entry
 U IO
 ;
 ; generate output
 K ENT S ENT=0
 S (END,ENPG)=0 D NOW^%DTC S Y=% D DD^%DT S ENDT=Y
 S ENL="",$P(ENL,"-",IOM)=""
 D HD
 ;
 ; loop thru non-space file locations
 S ENNSP="" F  S ENNSP=$O(^ENG(6914,"ANSP",ENNSP)) Q:ENNSP=""  D  Q:END
 . ; non-space file location
 . I $Y+5>IOSL D HD Q:END
 . W !!,"NON-SPACE FILE LOCATION: ",ENNSP
 . ; loop thru equipment
 . S ENDA=0 F  S ENDA=$O(^ENG(6914,"ANSP",ENNSP,ENDA)) Q:'ENDA  D  Q:END
 . . ; equipment item
 . . I $Y+3>IOSL D HD Q:END  D HDNSP
 . . W !,?2,ENDA ; equip id
 . . W ?14,$P($$GET1^DIQ(6914,ENDA_",",90.2),"@") ; non-space file date
 . . W ?28,$$GET1^DIQ(6914,ENDA_",",90.1) ; non-space file person
 . . W ?60,$$GET1^DIQ(6914,ENDA_",",24) ; location
 . . S ENT=ENT+1
 ;
 I 'END D
 . ; report footer
 . I $Y+4>IOSL D HD Q:END
 . W !!,"Count of equipment items with non-space location values = ",ENT
 . I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 ;
 D ^%ZISC
 ;
EXIT I $D(ZTQUEUED) S ZTREQ="@"
 K DIR,DIROUT,DIRUT,DIWF,DIWL,DTOUT,DUOUT,POP,X,Y
 K ENDA,ENNSP,ENT
 K END,ENDT,ENL,ENPG
 Q
 ;
HD ; header
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W !,"NON-SPACE FILE LOCATION REPORT"
 W ?48,ENDT,?72,"page ",ENPG
 W !!,?2,"EQUIP ID #",?14,"NON-SP DATE",?28,"ENTERED BY",?60,"LOCATION"
 W !,?2,$E(ENL,1,10),?14,$E(ENL,1,12),?28,$E(ENL,1,30),?60,$E(ENL,1,20)
 Q
 ;
HDNSP ; header for continued NON-SPACE FILE LOCATION
 I $G(ENNSP)]"" D
 . W !,"NON-SPACE LOCATION: ",ENNSP," (continued)"
 Q
 ;ENTINSR
