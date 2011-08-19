ENTIRRX ;WOIFO/SAB - Signature Exception Report ;2/4/2008
 ;;7.0;ENGINEERING;**87**;Aug 17, 1993;Build 16
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,ENADT,ENTYP,X,Y
 ;
 ; ask type
 S DIR(0)="S^E:ELECTRONICALLY SIGNED;C:CERTIFIED HARD COPY SIGNATURE;B:BOTH"
 S DIR("A")="Select type of signature to check"
 S DIR("B")="BOTH"
 D ^DIR K DIR Q:$D(DIRUT)
 S ENTYP=Y
 ;
 ; ask anniversary date
 S DIR(0)="D"
 S DIR("A")="Report signatures at least 1 year old as of "
 S DIR("B")=$$FMTE^XLFDT($$FMADD^XLFDT(DT,-1))
 D ^DIR K DIR Q:$D(DIRUT)
 S ENADT=Y
 ;
 ; ask device
 S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^ENTIRRX",ZTDESC="Signature Exception Report"
 . S ZTSAVE("ENTYP")="",ZTSAVE("ENADT")=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK,IO("Q")
 ;
QEN ; queued entry
 U IO
 ;
 ; generate output
 K ENT S ENT=0
 S (END,ENPG)=0 D NOW^%DTC S Y=% D DD^%DT S ENDT=Y
 S ENCDT=($E(ENADT,1,3)-1)_$E(ENADT,4,7) ; computed date (1 year before)
 S ENADTE=$$FMTE^XLFDT(ENADT) ; external format for anniversary date
 D HD
 ;
 ; print data
 ; loop thru active assignments by owner and equipment
 S ENOWN=0 F  S ENOWN=$O(^ENG(6916.3,"AOA",ENOWN)) Q:'ENOWN  D  Q:END
 . S ENEQ=0 F  S ENEQ=$O(^ENG(6916.3,"AOA",ENOWN,ENEQ)) Q:'ENEQ  D  Q:END
 . . S ENDA=0
 . . F  S ENDA=$O(^ENG(6916.3,"AOA",ENOWN,ENEQ,ENDA)) Q:'ENDA  D  Q:END
 . . . S ENY=$G(^ENG(6916.3,ENDA,0))
 . . . Q:$P(ENY,U,5)=""  ; not signed
 . . . I ENTYP="E",$P(ENY,U,7)'="" Q  ; only check e-sigs
 . . . I ENTYP="C",$P(ENY,U,7)="" Q  ; only check certified sigs
 . . . Q:$P($P(ENY,U,5),".")>ENCDT  ; was signed after computed date
 . . . ;
 . . . ; report assignment
 . . . S ENT=ENT+1
 . . . ;
 . . . ; display assignment data
 . . . I $Y+6>IOSL D HD Q:END
 . . . W !,$$GET1^DIQ(6916.3,ENDA,1)
 . . . W ?32,ENEQ
 . . . W ?44,$$GET1^DIQ(6916.3,ENDA,20)
 . . . W ?55,$$GET1^DIQ(6916.3,ENDA,21)
 . . . W !,"  ",$E($$GET1^DIQ(6914,ENEQ,3),1,76)
 ;
 I 'END D
 . ; report footer
 . I $Y+4>IOSL D HD Q:END
 . W !!,"Count of signatures on report = ",ENT
 . I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 ;
 D ^%ZISC
 ;
EXIT I $D(ZTQUEUED) S ZTREQ="@"
 K DIR,DIROUT,DIRUT,DIWF,DIWL,DTOUT,DUOUT,POP,X,Y
 K ENADT,ENADTE,ENCDT,ENDA,ENEQ,ENOWN,ENT,ENTYP,ENY
 K END,ENDT,ENPG
 Q
 ;
HD ; header
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W "SIGNATURE EXCEPTION REPORT",?48,ENDT,?72,"page ",ENPG,!
 W "  for "
 I ENTYP="E" W "electronic "
 I ENTYP="C" W "hard copy "
 W "signatures at least one year old as of ",ENADTE,!!
 W "Owner",?32,"Entry #",?44,"Status",?55,"Status Date",!
 W "------------------------------",?32,"----------"
 W ?44,"---------",?55,"-----------"
 Q
 ;
 ;ENTIRRX
