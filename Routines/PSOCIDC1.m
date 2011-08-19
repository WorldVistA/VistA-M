PSOCIDC1 ;BIR/LE-Copay Correction of erroneous billed copays ;11/8/05 12:50pm
 ;;7.0;OUTPATIENT PHARMACY;**226**;DEC 1997
 ;External reference to ^XUSEC supported by DBIA 10076
 ;External reference to IBARX supported by DBIA 125
 ;External reference to $$PROD^XUPROD(1) supported by DBIA 4440
 ;
 N NAMSP,DTOUT,DUOUT,ZTSK,ZTRTN,ZTIO,ZTDTH,ZTDESC,QUIT,RUNOPT,JOBN,Y
 S NAMSP=$$NAMSP
 S JOBN="CANCEL COPAY"
 ;
 L +^XTMP(NAMSP):0 I '$T D  Q
 . D BMES^XPDUTL(JOBN_" job is already running.  Halting...")
 . D MES^XPDUTL("")
 . D QUIT
 ;
 I '$D(^XTMP(NAMSP)) D INITXTMP(NAMSP,"Correct erroneously billed copays, PSO*7*226",90)        ;90 day life
 S QUIT=0
 ;
 ;ques 1, if running from mumps prompt
 I '$D(XPDQUES("POS1")) D  I QUIT D QUIT Q
 . ;selected cancel run at last install, dont allow to run manually
 . I $G(^XTMP(NAMSP,0,"LAST"))["CANCEL" D  Q
 . . S QUIT=1
 . . W !!,*7,"The last install of this patch you selected to NOT Run the Copay Correction process."
 . . W !,"If you have changed your mind, you must re-install the patch to run",!!
 . K DIR
 . S DIR("A",1)="****************** SELECT RUN OPTION ******************"
 . S DIR("A")="Do you want to run the Copay Correction process? Y or N//"
 . S DIR(0)="YA^^"
 . D ^DIR I $D(DTOUT)!($D(DUOUT)) W !,"Halting..." S QUIT=1 Q
 . S RUNOPT=Y
 . S:'RUNOPT QUIT=1
 ;
 ;ques 1, if running from kids install
 I $D(XPDQUES("POS1")) D  I 'RUNOPT D QUIT Q
 . S RUNOPT=XPDQUES("POS1")
 . S:'RUNOPT ^XTMP(NAMSP,0,"LAST")="CANCEL RUN^"_$$NOW^XLFDT_"^^^"
 . D BMES^XPDUTL("***** SELECTED "_$S('RUNOPT:"NOT ",1:"")_"TO RUN THE COPAY CORRECTION PROCESS *****")
 ;
 I $G(^XTMP(NAMSP,0,"LAST"))["COMPLETED" D  Q
 . W !!,*7,"This job has been run before to completion on "
 . W $$FMTE^XLFDT($P($G(^XTMP(NAMSP,0,"LAST")),"^",2)),!!
 . D QUIT
 ;
 ;ques 2, if running from mumps prompt
 I '$D(XPDQUES("POS2")) D  I 'ZTDTH D QUIT Q
 . K DIR
 . S DIR("A")="Enter when to Queue the "_JOBN_" job to run in date@time format "
 . S DIR("B")="NOW"
 . S DIR(0)="D^::%DT"
 . S DIR("?")="Enter when to start the job. The default is Now. You can enter a date and time in the format like this: 081505@3:30p"
 . D ^DIR I $D(DUOUT) W !,"Halting..." S ZTDTH="" Q
 . S:$D(DTOUT) Y=$$NOW^XLFDT S ZTDTH=$$FMTH^XLFDT(Y)
 ;
 ;ques 2, if running from kids install
 I $D(XPDQUES("POS2")) S ZTDTH=$$FMTH^XLFDT(XPDQUES("POS2"))
 ;
 D BMES^XPDUTL("===================================================")
 D MES^XPDUTL("Queuing background job to "_JOBN_" erroneous billed copays...")
 D MES^XPDUTL("Start time: "_$$HTE^XLFDT(ZTDTH))
 D MES^XPDUTL("===================================================")
 I ZTDTH="" D BMES^XPDUTL(JOBN_" NOT QUEUED") D QUIT Q
 ;
 S:$D(^XTMP(NAMSP,0,"LAST")) ^XTMP(NAMSP,0,"ZAUDIT",$H)="RE-STARTED ON"_"^"_$$NOW^XLFDT_"^"_$P(^XTMP(NAMSP,0,"LAST"),"^",2,5)
 ;
 I $P($G(^XTMP(NAMSP,0,"LAST")),"^")="STOP" D
 . S $P(^XTMP(NAMSP,0,"LAST"),"^",1,2)="RUN^"_$$NOW^XLFDT
 E  D
 . S ^XTMP(NAMSP,0,"LAST")="RUN^"_$$NOW^XLFDT_"^^^"
 ;
 S ZTRTN="EN^PSOCIDC1",ZTIO=""
 S ZTDESC="Background job to "_JOBN_" for erroneously billed copays via PSO*7*143"
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
EN ;
 N NAMSP S NAMSP=$$NAMSP
 ;if can't get Lock, then already running.
 L +^XTMP(NAMSP):3 I '$T D  Q
 . S:$D(ZTQUEUED) ZTREQ="@"
 . S $P(^XTMP(NAMSP,0,"LAST"),"^",1,2)="LOCKED^"_$$NOW^XLFDT
 ;
 N DFN,PSODT,RXP,PSOTEXT,XX,YY,PSOCNT,PSOUCNT,PSOCCNT,PSOSTART,PSOEND,PSOVETS,PSOCVETS,PSOUVETS,PSOTRX,XIEN
 N PSOSCMX,PSODFN,PSOUDFN,PSOREL,PSOAMT,PSOCAMT,PSOUAMT,FOUND,PSOTRF,PSOEND2,PSOSTRT2,CC
 N PSOTIME,PSOSTNM,PSOS1,PSOINST,I,PSOTC,PSOCNTS,PSOUCNTS,PSOCCNTS,LIN,%,X1,XMY,STO,PSOSCP
 D NOW^%DTC S (Y,PSOS1)=% D DD^%DT S PSOSTART=Y
 S PSOSTRT2=$$FMTE^XLFDT(%,"1PS")
 I '$G(DT) S DT=$$DT^XLFDT
 S PSODT=+$P($G(^XTMP(NAMSP,0,"LAST")),"^",3)
 S RXP=+$P($G(^XTMP(NAMSP,0,"LAST")),"^",4)
 ;
 ;get 1st occurence of install date of patch PSO*7*143 (CIDC)
 S XIEN=+$O(^XPD(9.7,"B","PSO*7.0*156",0))
 S:'PSODT PSODT=+$P($G(^XPD(9.7,XIEN,1)),"^",3)
 I 'PSODT D  Q
 . S ^XTMP(NAMSP,0,.1)="CIDC PATCH PSO*7*143 IS NOT INSTALLED"
 . S $P(^XTMP(NAMSP,0,"LAST"),"^",1,2)="COMPLETED^"_$$NOW^XLFDT
 . D MAIL3^PSOCIDC3(^XTMP(NAMSP,0,.1))
 ;
 S (PSOTRX,PSOTRF)=1
 N STOP K ^XTMP(NAMSP,0,"STOP") S STOP=0          ;init stop flag to 0
 F CC=1:1 S PSODT=$O(^PSRX("AD",PSODT)) Q:'PSODT  D  Q:STOP  ;FINISH DATE
 . I $D(^XTMP(NAMSP,0,"STOP")) D  Q
 . . S $P(^XTMP(NAMSP,0,"LAST"),"^",1,2)="STOP^"_$$NOW^XLFDT,STOP=1
 . F PSOTRX=PSOTRX+1:1 S RXP=$O(^PSRX("AD",PSODT,RXP)) Q:'RXP  D
 .. Q:'$D(^PSRX(RXP,"ICD",0))
 .. ;save last date & fill info
 .. S $P(^XTMP(NAMSP,0,"LAST"),"^",3,5)=PSODT_"^"_RXP_"^"_PSOTRX
 .. S (DFN,PSODFN)=$P($G(^PSRX(RXP,0)),"^",2)
 .. Q:('PSODFN)!('$D(^DPT(PSODFN,0)))        ;quit, no valid DFN info
 .. D ELIG^VADPT S PSOSCP="",PSOSCP=$P(VAEL(3),U,2) K VAEL  ;SC percentage
 .. ;search all fills
 .. S YY="" F  S YY=$O(^PSRX("AD",PSODT,RXP,YY)) Q:YY=""  D:PSOSCP<50 CHECK^PSOCIDC2
 G STP:STOP
 ;
 S (PSOUCNT,PSOCNT,PSOCCNT)=0
 D CANCEL^PSOCIDC2 G STP:STOP
 D TOTAL^PSOCIDC2
 S $P(^XTMP(NAMSP,0,"LAST"),"^",1,2)="COMPLETED^"_$$NOW^XLFDT
 D MAIL^PSOCIDC4
 D MAIL2^PSOCIDC4
STP ;
 L -^XTMP(NAMSP)
 I $D(^XTMP(NAMSP,0,"STOP")) S ^XTMP(NAMSP,0,"ZAUDIT",$H)="STOPPED ON"_"^"_$P(^XTMP(NAMSP,0,"LAST"),"^",2,5)
 S:$D(ZTQUEUED) ZTREQ="@"
 K JOBN
 Q
 ;
STATUS ;show status of job running
 I $$ST D
 . W !,"Currently processing:"
 . I ^XTMP($$NAMSP,0,"LAST")["COMPLETED" D
 . . W !,"COMPLETED ON ",$$FMTE^XLFDT($P($G(^XTMP($$NAMSP,0,"LAST")),"^",2)),!
 . W !?5,"Released Date > ",$P(^XTMP($$NAMSP,0,"LAST"),"^",3)
 . W !?5,"         RX # > ",$P(^XTMP($$NAMSP,0,"LAST"),"^",4)
 . W !?5,"   TOTAL RX's > ",$P(^XTMP($$NAMSP,0,"LAST"),"^",5),!
 . E  D
 . I ^XTMP($$NAMSP,0,"LAST")["COMPLETED" D
 . . W !,"COMPLETED ON ",$$FMTE^XLFDT($P($G(^XTMP($$NAMSP,0,"LAST")),"^",2)),!
 Q
 ;
STOP ;stop job command
 I $$ST S ^XTMP($$NAMSP,0,"STOP")="" D
 . W !,"Outpatient RX Copay Correction Job - set to STOP Soon"
 . W !!,"Check Status to be sure it has stopped and is not running..."
 . W !,"     (D STATUS^PSOCIDC1)"
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
