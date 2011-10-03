PSO7P274 ;SMT - PSO*7*274 Activity Log Cleanup ; 10/11/07 12:16pm
 ;;7.0;OUTPATIENT PHARMACY;**274**;APR 2007;Build 8
 ;
 ;Cleanup routine, to fix erroneous listings of partials in the
 ;activity log.
 ;
 N NAMSP,PATCH,JOBN,DTOUT,DUOUT,ZTSK,ZTRTN,ZTIO,ZTDTH,ZTDESC,QUIT,Y,ZTQUEUED,ZTREQ,ZTSAVE
 S NAMSP=$$NAMSP
 S JOBN="Activity Log Cleanup"
 S PATCH="PSO*7*274"
 ;
 L +^XTMP(NAMSP):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I '$T D  Q
 . D BMES^XPDUTL(JOBN_" job is already running.  Halting...")
 . D MES^XPDUTL("")
 . D QUIT
 ;
 I '$D(^XTMP(NAMSP)) D INITXTMP(NAMSP,JOBN_", "_PATCH,90)        ;90 day life
 S QUIT=0
 ;
 I $G(^XTMP(NAMSP,0,"LAST"))["COMPLETED" D  Q
 . W !!,*7,"This job has been run before to completion on "
 . W $$FMTE^XLFDT($P($G(^XTMP(NAMSP,0,"LAST")),"^",2)),!!
 . W "If you want to run it again, the global subscript ^XTMP('"_NAMSP_"') must be",!
 . W "deleted prior to doing so.",!!
 . D QUIT
 ;
 ;ques 2, if running from mumps prompt
 I '$D(XPDQUES("POS2")) D  I 'ZTDTH D QUIT Q
 . K DIR
 . S DIR("A")="  Enter when to Queue the "_JOBN_" job to run in date@time   format "
 . S DIR("B")="NOW"
 . S DIR(0)="D^::%DT"
 . S DIR("?")="Enter when to start the job. The default is Now. You can enter a date and time in the format like this: 021506@3:30p"
 . D ^DIR I $D(DUOUT) W !,"Halting..." S ZTDTH="" Q
 . S:$D(DTOUT) Y=$$NOW^XLFDT S ZTDTH=$$FMTH^XLFDT(Y)
 ;
 ;ques 2, if running from kids install
 I $D(XPDQUES("POS2")) S ZTDTH=$$FMTH^XLFDT(XPDQUES("POS2"))
 ;
 D BMES^XPDUTL("=============================================================")
 D MES^XPDUTL("Queuing background job for "_JOBN_"...")
 D MES^XPDUTL("Start time: "_$$HTE^XLFDT(ZTDTH))
 D MES^XPDUTL("==============================================================")
 I ZTDTH="" D BMES^XPDUTL(JOBN_" NOT QUEUED") D QUIT Q
 ;
 S:$D(^XTMP(NAMSP,0,"LAST")) ^XTMP(NAMSP,0,"ZAUDIT",$H)="RE-STARTED ON"_"^"_$$NOW^XLFDT_"^"_$P(^XTMP(NAMSP,0,"LAST"),"^",2,5)
 ;
 I $P($G(^XTMP(NAMSP,0,"LAST")),"^")="STOP" D
 . S $P(^XTMP(NAMSP,0,"LAST"),"^",1,2)="RUN^"_$$NOW^XLFDT
 E  D
 . S ^XTMP(NAMSP,0,"LAST")="RUN^"_$$NOW^XLFDT_"^^^"
 ;
 S ZTRTN="EN^"_NAMSP,ZTIO=""
 S ZTDESC="Background job for "_JOBN_" on prescriptions updated via "_PATCH
 S ZTSAVE("JOBN")=""
 L -^XTMP(NAMSP)
 D ^%ZTLOAD
 D:$D(ZTSK)
 . D MES^XPDUTL("*** Task #"_ZTSK_" Queued! ***")
 . D BMES^XPDUTL("")
 D BMES^XPDUTL("")
 K XPDQUES
 Q
QUIT ;
 L -^XTMP(NAMSP)
 Q
 ;
STATUS ;show status of job running
 I $$ST D
 . W !,"Currently processing:"
 . I $G(^XTMP($$NAMSP,0,"LAST"))["COMPLETED" D
 . . W !,"COMPLETED ON ",$$FMTE^XLFDT($P($G(^XTMP($$NAMSP,0,"LAST")),"^",2)),!
 . W !?5,"Date being processed > ",$$FMTE^XLFDT($P(^XTMP($$NAMSP,0,"LAST"),"^",3))
 . W !?5,"                RX # > ",$P(^XTMP($$NAMSP,0,"LAST"),"^",4)
 . ;W !?5,"          TOTAL RX's > ",$P(^XTMP($$NAMSP,0,"LAST"),"^",5),!
 E  D
 .I $G(^XTMP($$NAMSP,0,"LAST"))["COMPLETED" D
 .. W !,"COMPLETED ON ",$$FMTE^XLFDT($P($G(^XTMP($$NAMSP,0,"LAST")),"^",2)),!
 Q
 ;
STOP ;stop job command
 I $$ST S ^XTMP($$NAMSP,0,"STOP")="" D
 . W !,"TALLY MISSING EXPIRATION DATES Job - set to STOP Soon"
 . W !!,"Check Status to be sure it has stopped and is not running..."
 . W !,"     (D STATUS^PSOTEXP1)"
 Q
ST() ;status
 L +^XTMP($$NAMSP):3 I $T D  Q 0
 . L -^XTMP($$NAMSP)
 . W !,"*** NOT CURRENTLY RUNNING! ***",!
 Q 1
INITXTMP(NAMSP,TITLE,LIFE) ;create ^Xtmp according to SAC std
 N BEGDT,PURGDT
 S BEGDT=$$NOW^XLFDT()
 S PURGDT=$$FMADD^XLFDT(BEGDT,LIFE)
 S ^XTMP(NAMSP,0)=PURGDT_"^"_BEGDT_"^"_TITLE
 Q
NAMSP() ;
 Q $T(+0)
 ;
EN ;
 N C,CC,CNT ;Clean erroneous activity log partials
 S (C,CNT)=0 F  S C=$O(^PSRX(C)),CNT=CNT+1 Q:'C  I $D(^PSRX(C,"A",0)) D
 .S CC=0 F  S CC=$O(^PSRX(C,"A",CC)) Q:'CC  S:($P(^PSRX(C,"A",CC,0),"^",4)=6)&('$D(^PSRX(C,"P",0))) $P(^PSRX(C,"A",CC,0),"^",4)=7
 Q
