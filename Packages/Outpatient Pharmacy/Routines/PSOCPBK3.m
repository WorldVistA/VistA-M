PSOCPBK3 ;BIR/GN-Copay Back Bill for Automated-release refills ;10/6/05 4:57pm
 ;;7.0;OUTPATIENT PHARMACY;**217**;DEC 1997
 ;External reference to ^XUSEC supported by DBIA 10076
 ;External reference to IBARX supported by DBIA 125
 ;External reference to $$PROD^XUPROD(1) supported by DBIA 4440
 ;
 N NAMSP,DTOUT,DUOUT,ZTSK,ZTRTN,ZTIO,ZTDTH,ZTDESC,QUIT,RUNOPT,JOBN,Y
 S NAMSP=$$NAMSP
 S JOBN="Back Bill"
 ;
 L +^XTMP(NAMSP):0 I '$T D  Q
 . D BMES^XPDUTL(JOBN_" job is already running.  Halting...")
 . D MES^XPDUTL("")
 . D QUIT
 ;
 I '$D(^XTMP(NAMSP)) D INITXTMP(NAMSP,"BACK BILLING of unbilled copays for refills via OPAI, PSO*7*217",90)        ;90 day life
 S QUIT=0
 ;
 ;ques 1, if running from mumps prompt
 I '$D(XPDQUES("POS1")) D  I QUIT D QUIT Q
 . ;selected cancel run at last install, dont allow to run manually
 . I $G(^XTMP(NAMSP,0,"LAST"))["CANCEL" D  Q
 . . S QUIT=1
 . . W !!,*7,"The last install of this patch you selected to NOT Run Back-Billing"
 . . W !,"If you have changed your mind, you must re-install the patch to run",!!
 . K DIR
 . S DIR("A",1)="****************** SELECT RUN OPTION ******************"
 . S DIR("A")="Do you want to run the Back-Billing process? "
 . S DIR(0)="YA^^"
 . D ^DIR I $D(DTOUT)!($D(DUOUT)) W !,"Halting..." S QUIT=1 Q
 . S RUNOPT=Y
 . S:'RUNOPT QUIT=1
 ;
 ;ques 1, if running from kids install
 I $D(XPDQUES("POS1")) D  I 'RUNOPT D QUIT Q
 . S RUNOPT=XPDQUES("POS1")
 . S:'RUNOPT ^XTMP(NAMSP,0,"LAST")="CANCEL RUN^"_$$NOW^XLFDT_"^^^"
 . D BMES^XPDUTL("***** SELECTED "_$S('RUNOPT:"NOT ",1:"")_"TO RUN BACK-BILLING *****")
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
 . D ^DIR I $D(DTOUT)!($D(DUOUT)) W !,"Halting..." S ZTDTH="" Q
 . S ZTDTH=$$FMTH^XLFDT(Y)
 ;
 ;ques 2, if running from kids install
 I $D(XPDQUES("POS2")) S ZTDTH=$$FMTH^XLFDT(XPDQUES("POS2"))
 ;
 D BMES^XPDUTL("===================================================")
 D MES^XPDUTL("Queuing background job to "_JOBN_" unbilled refills...")
 D MES^XPDUTL("Start time: "_$$HTE^XLFDT(ZTDTH))
 D MES^XPDUTL("===================================================")
 I ZTDTH="" D BMES^XPDUTL(JOBN_" NOT QUEUED") D QUIT Q
 ;
 I $P($G(^XTMP(NAMSP,0,"LAST")),"^")="STOP" D
 . S $P(^XTMP(NAMSP,0,"LAST"),"^",1,2)="RUN^"_$$NOW^XLFDT
 E  D
 . S ^XTMP(NAMSP,0,"LAST")="RUN^"_$$NOW^XLFDT_"^^^"
 ;
 S ZTRTN="EN^PSOCPBK3",ZTIO=""
 S ZTDESC="Background job to "_JOBN_" unbilled copays for refills via OPAI"
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
 N PSODT,RXP,PSOTEXT,XX,YY,PSOCNT,PSOSTART,PSOEND,PSOVETS,PSOTRX,XIEN
 N PSOSCMX,PSODFN,PSOREL,PSOAMT,FOUND,V24,PSOTRF,PSOEND2,PSOSTRT2,CC
 N PSOTIME,PSOSTNM,PSOS1,PSOINST,I,PSOTC,PSOCNTS,LIN,%,X1,XMY,STO
 D NOW^%DTC S (Y,PSOS1)=% D DD^%DT S PSOSTART=Y
 S PSOSTRT2=$$FMTE^XLFDT(%,"1PS")
 I '$G(DT) S DT=$$DT^XLFDT
 S PSODT=+$P($G(^XTMP(NAMSP,0,"LAST")),"^",3)
 S RXP=+$P($G(^XTMP(NAMSP,0,"LAST")),"^",4)
 ;
 ;get 1st occurence of install date of patch PSO*7*156 (OPAI)
 S XIEN=+$O(^XPD(9.7,"B","PSO*7.0*156",0))
 S:'PSODT PSODT=+$P($G(^XPD(9.7,XIEN,1)),"^",3)
 I 'PSODT D  Q
 . S ^XTMP(NAMSP,0,.1)="OPAI PATCH PSO*7*156 IS NOT INSTALLED"
 . S $P(^XTMP(NAMSP,0,"LAST"),"^",1,2)="COMPLETED^"_$$NOW^XLFDT
 . D MAIL3^PSOCPBK5(^XTMP(NAMSP,0,.1))
 ;
 ;check if any division is on v2.4 (OPAI interface)
 S V24=0
 F XX=0:0 S XX=$O(^PS(59,XX)) Q:'XX  D  Q:V24
 . S:+$G(^PS(59,XX,"DISP"))=2.4 V24=1
 I 'V24 D  Q
 . S ^XTMP(NAMSP,0,.2)="OPAI IS INSTALLED BUT IS NOT TURNED ON"
 . S $P(^XTMP(NAMSP,0,"LAST"),"^",1,2)="COMPLETED^"_$$NOW^XLFDT
 . D MAIL3^PSOCPBK5(^XTMP(NAMSP,0,.2))
 ;
 S (PSOTRX,PSOTRF)=1
 N STOP K ^XTMP(NAMSP,0,"STOP") S STOP=0          ;init stop flag to 0
 F CC=1:1 S PSODT=$O(^PSRX("AL",PSODT)) Q:'PSODT  D  Q:STOP
 . I CC#100=0,$D(^XTMP(NAMSP,0,"STOP")) D  Q
 . . S $P(^XTMP(NAMSP,0,"LAST"),"^",1,2)="STOP^"_$$NOW^XLFDT,STOP=1
 . F PSOTRX=PSOTRX+1:1 S RXP=$O(^PSRX("AL",PSODT,RXP)) Q:'RXP  D
 .. ;save last date & fill info
 .. S $P(^XTMP(NAMSP,0,"LAST"),"^",3,5)=PSODT_"^"_RXP_"^"_PSOTRX
 .. S PSODFN=$P($G(^PSRX(RXP,0)),"^",2)
 .. Q:('PSODFN)!('$D(^DPT(PSODFN,0)))        ;quit, no valid DFN info
 .. D XTYPE^PSOCPBK4
 .. Q:+PSOSCMX=0                             ;quit, Exempt or deceased
 .. ;search refills only, ignore 0=orig fill
 .. F YY=0:0 S YY=$O(^PSRX("AL",PSODT,RXP,YY)) Q:'YY  D ADDBILL^PSOCPBK4
 Q:STOP
 ;
 S PSOCNT=0
 D BILLIT^PSOCPBK4 Q:STOP
 D TOTAL^PSOCPBK4
 S $P(^XTMP(NAMSP,0,"LAST"),"^",1,2)="COMPLETED^"_$$NOW^XLFDT
 D MAIL^PSOCPBK5
 D MAIL2^PSOCPBK5
 D MAILAAC^PSOCPBK5
 L -^XTMP(NAMSP)
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
 . W !,"Outpatient RX Copay Tally Job - set to STOP Soon"
 . W !!,"Check Status to be sure it has stopped and is not running..."
 . W !,"     (D STATUS^PSOCPBK3)"
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
