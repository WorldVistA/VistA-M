ENWOREP ;WIRMFO/DH,SAB-Reprint Work Orders ;2.24.98
 ;;7.0;ENGINEERING;**15,35,48**;Aug 17, 1993
EN ; ask section
 S DIC="^DIC(6922,",DIC(0)="AEQM"
 S DIC("A")="For Engineering SECTION: ALL// "
 D ^DIC K DIC G:X="^" EXIT
 I X="" S ENDA="ALL"
 I +Y>0 S ENDA=+Y
ASKDT ; ask date range
 S %DT="AEXP"
 S %DT("A")="Start DATE: " D ^%DT G:Y'>0 EXIT S ENFR=+Y
 S %DT("B")=$$FMTE^XLFDT(ENFR)
 S %DT("A")="Stop DATE: " D ^%DT G:Y'>0 EXIT S ENTO=+Y
 I ENTO<ENFR W !!,"Stop Date may not preceed Start Date.",*7,! G ASKDT
 S ENFR=$E(ENFR,2,7),ENTO=$E(ENTO,2,7)
 I ENTO<ENFR D  G:'Y EXIT
 . S DIR("A",1)="It appears that you are reprinting across a century."
 . S DIR("A")="Is that what you want to do"
 . S DIR(0)="Y",DIR("B")="YES"
 . D ^DIR K DIR
 ;
 S ENBARCD=0
 S I=$O(^ENG(6910.2,"B","PRINT BAR CODES ON W.O.",0)) I I>0,$P(^ENG(6910.2,I,0),U,2)="Y" S ENBARCD=1
 ;
 D DEV^ENLIB G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTDESC="Engineering Work Order Reprint"
 . S ZTRTN=$S(ENDA="ALL":"ENALL^ENWOREP",1:"ENONE^ENWOREP")
 . S ZTSAVE("EN*")=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
 G:ENDA=+ENDA ENONE
 ;
ENALL U IO
 D:$E(IOST,1,2)'="C-" PSET^%ZISP
 S (ENDA,ENQUIT)=0
 F  S ENDA=$O(^DIC(6922,ENDA)) Q:'ENDA!ENQUIT  I ENDA#100'>89 D SECT
 D:$E(IOST,1,2)'="C-" PKILL^%ZISP
 D ^%ZISC
 G EXIT
 ;
ENONE U IO
 D:$E(IOST,1,2)'="C-" PSET^%ZISP
 S ENQUIT=0
 D SECT
 D:$E(IOST,1,2)'="C-" PKILL^%ZISP
 D ^%ZISC
 G EXIT
 ;
SECT ; reprint work orders for section ENDA
 S ENABR=$P(^DIC(6922,ENDA,0),U,2),ENCC=$L(ENABR)
 ; if entire range within century loop
 I ENTO'<ENFR D DATELP(ENFR,ENTO)
 ; if range crosses century use two ranges to print
 I ENTO<ENFR D DATELP(ENFR,"999999") D:'ENQUIT DATELP("000000",ENTO)
 Q
 ;
DATELP(ENFR,ENTO) ; date loop for dates within a century
 ; input ENFR and ENTO with format YYMMDD
 S ENWO=ENABR_ENFR,ENDLP=0
 F  S ENWO=$O(^ENG(6920,"B",ENWO)) D  Q:ENDLP!ENQUIT
 . I ENWO="" S ENDLP=1 Q  ; no more work orders
 . I ENABR'=$E(ENWO,1,ENCC)!($E(ENWO,ENCC+1)'?1N) S ENDLP=1 Q  ; shop
 . I $E(ENWO,ENCC+1,ENCC+6)>ENTO S ENDLP=1 Q  ; after stop date
 . S DA=$O(^ENG(6920,"B",ENWO,0))
 . I $P($G(^ENG(6920,DA,4)),U,3)'>4 D PRT ; only print incomplete w.o.
 Q
 ;
PRT ; print one work order (DA)
 D ST^ENWOD1,TOP^ENWOD2
 D:ENBARCD BAR^ENWOD
 I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR I 'Y S ENQUIT=1 Q
 W @IOF
 I IO'=IO(0),'$D(ZTQUEUED) U IO(0) W "." U IO
 Q
 ;
EXIT K ENABR,ENCC,ENDA,ENDLP,ENFR,ENTO,ENDSTAT,ENBARCD,ENQUIT,ENWO
 K %DT,DA,DTOUT,DUOUT,DIRUT,DIROUT,I,Y
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;ENWOREP
