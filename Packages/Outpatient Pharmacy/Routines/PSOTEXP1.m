PSOTEXP1 ;BIR/LE-Tally Missing Expiration Dates ;06/14/06
 ;;7.0;OUTPATIENT PHARMACY;**250,268**;DEC 1997;Build 9
 ;External references ^DPT supported by DBIA 10035
 N NAMSP,PATCH,JOBN,DTOUT,DUOUT,ZTSK,ZTRTN,ZTIO,ZTDTH,ZTDESC,QUIT,Y,ZTQUEUED,ZTREQ,ZTSAVE
 S NAMSP=$$NAMSP
 S JOBN="TALLY MISSING EXPIRATION DATES"
 S PATCH="PSO*7*250"
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
 . W "If you want to run it again, the global subscript ^XTMP('PSOTEXP1') must be",!
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
 S ZTRTN="EN^PSOTEXP1",ZTIO=""
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
EN ;
 N PATCH,NAMSP S NAMSP=$$NAMSP,PATCH="PSO*7*250",JOBN="TALLY MISSING EXPIRATION DATES"
 ;if can't get Lock, then already running.
 L +^XTMP(NAMSP):3 I '$T D  Q
 . S:$D(ZTQUEUED) ZTREQ="@"
 . S $P(^XTMP(NAMSP,0,"LAST"),"^",1,2)="LOCKED^"_$$NOW^XLFDT
 ;
 N PSOSTART,Y,PSOS1,RXP,PSOV7,PSOARR,PSOISS,PSOEXP,PSOSTA,PSOACT,PSOINST,CC,RXE,DFN,PSODRUG,PSOINACT
 ;
 D NOW^%DTC S (Y,PSOS1)=% D DD^%DT S PSOSTART=Y
 I '$G(DT) S DT=$$DT^XLFDT
 S RXP=+$P($G(^XTMP(NAMSP,0,"LAST")),"^",4)
 ;get date that PSO v7 was installed
 S PSOV7=$S($P($G(^PS(59.7,1,49.99)),"^",7):$P(^PS(59.7,1,49.99),"^",7),1:$P($G(^PS(59.7,1,49.99)),"^",4))
 S:PSOV7["." PSOV7=$P(PSOV7,".",1)
 ;
 ;^XTMP(NAMSP,INSTITUTION)=tot missing expiration dates on or before v7 install^tot missing expiration dates after v7 install^total missing expiration dates^tot past expiration date minus 1 day
 ;
 S PSOINST=$P($G(^DIC(4,+$P($G(^XMB(1,1,"XUS")),"^",17),99)),"^")
 S:'$G(PSOINST) PSOINST="9999999999"
 S PSOACT=",0,1,2,3,4,5,10,16,",PSOINACT=",11,12,13,14,15,"
 N STOP K ^XTMP(NAMSP,0,"STOP") S STOP=0 S:RXP="" RXP=0
 F CC=1:1 S RXP=$O(^PSRX(RXP)) Q:'RXP!(RXP'?1N.NN)  D  Q:STOP
 . I $D(^XTMP(NAMSP,0,"STOP")) D  Q
 . . S $P(^XTMP(NAMSP,0,"LAST"),"^",1,2)="STOP^"_$$NOW^XLFDT,STOP=1
 . K PSOARR D GETS^DIQ(52,RXP_",",".01;2;6;1;20;26;100","I","PSOARR")
 . S DFN=$G(PSOARR(52,RXP_",",2,"I")),PSODRUG=$G(PSOARR(52,RXP_",",6,"I")),PSOSTA=$G(PSOARR(52,RXP_",",100,"I"))
 . S PSOISS=$G(PSOARR(52,RXP_",",1,"I"))
 . ;--- eliminate bad Rx's
 . Q:DFN=""!(PSODRUG="")
 . Q:'$D(^DPT(DFN))!('$D(^PSDRUG(PSODRUG)))
 . Q:$G(PSOISS)=""
 . ;--- 
 . S RXE=$G(PSOARR(52,RXP_",",".01","I")),PSOEXP=$G(PSOARR(52,RXP_",",26,"I"))
 . ;save last date & fill info
 . S $P(^XTMP(NAMSP,0,"LAST"),"^",3,5)=$G(PSOISS)_"^"_RXP
 . D SET
 G STP:STOP
 S $P(^XTMP(NAMSP,0,"LAST"),"^",1,2)="COMPLETED^"_$$NOW^XLFDT
 D MAIL
STP ;
 L -^XTMP(NAMSP)
 I $D(^XTMP(NAMSP,0,"STOP")) S ^XTMP(NAMSP,0,"ZAUDIT",$H)="STOPPED ON"_"^"_$P(^XTMP(NAMSP,0,"LAST"),"^",2,5)
 S:$D(ZTQUEUED) ZTREQ="@"
 K JOBN
 ;I '$D(^XTMP(NAMSP,0,"STOP")) K ^XTMP(NAMSP)
 Q
 ;
SET ;Data collected and stored:
 ; Piece 1 - Pre-install v7 active Rx's with null expiration date
 ; Piece 2 - Pre-install v7 inactive Rx's with null expiration date
 ; Piece 3 - Post-install v7 active Rx's with null expiration
 ; Piece 4 - Post-install v7 inactive Rx's with null expiration
 ; Piece 5 - total Rx's with null expiration date
 ; Piece 6 - total active Rx's with expire date of t-1 day
 ;
 I PSOEXP="" D  Q
 . I PSOISS'>PSOV7 D
 . . S:PSOACT[(","_PSOSTA_",") $P(^XTMP(NAMSP,PSOINST),"^",1)=$P($G(^XTMP(NAMSP,PSOINST)),"^",1)+1
 . . S:PSOINACT[(","_PSOSTA_",") $P(^XTMP(NAMSP,PSOINST),"^",2)=$P($G(^XTMP(NAMSP,PSOINST)),"^",2)+1
 . I PSOISS>PSOV7 D 
 . . S:PSOACT[(","_PSOSTA_",") $P(^XTMP(NAMSP,PSOINST),"^",3)=$P($G(^XTMP(NAMSP,PSOINST)),"^",3)+1
 . . S:PSOINACT[(","_PSOSTA_",") $P(^XTMP(NAMSP,PSOINST),"^",4)=$P($G(^XTMP(NAMSP,PSOINST)),"^",4)+1
 . S $P(^XTMP(NAMSP,PSOINST),"^",5)=$P($G(^XTMP(NAMSP,PSOINST)),"^",5)+1
 .;S ^XTMP("PSOTEXP1","MISS",RXP)=PSOINST_"^"_PSOISS_"^"_PSOV7_"^"_PSOEXP_"^"_$S($G(PSOSTA)'="":PSOSTA,1:"*")_"^"_$P($G(^PSRX(RXP,0)),"^")
 ; normal daily job expires all rx's with yesterday's date, so looking for anything before yesterday.
 I (PSOEXP<(DT-1))&(PSOACT[(","_PSOSTA_",")) S $P(^XTMP(NAMSP,PSOINST),"^",6)=$P($G(^XTMP(NAMSP,PSOINST)),"^",6)+1
 ;.S ^XTMP("PSOTEXP1","PAST",$S($G(PSOSTA)'="":PSOSTA,1:"*"),PSOEXP,RXP)=PSOINST_"^"_PSOISS_"^"_PSOV7_"^"_PSOEXP_"^"_PSOSTA_"^"_$P($G(^PSRX(RXP,0)),"^")
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
MAIL ;
 N PSOEND,PSOEND2,PSOTEXT,XMY,LIN,DATA,J,L,PSOINST,M,LEN
 S LIN="",$P(LIN," ",80)="",LEN=80
 D NOW^%DTC S Y=% D DD^%DT S PSOEND=Y
 S PSOEND2=$$FMTE^XLFDT(%,"1PS")
 I $G(DUZ) S XMY(DUZ)=""
 S XMDUZ=PATCH_" "_JOBN
 S XMSUB="Outpatient Pharmacy "_PATCH_" "_JOBN
 S XMY("ELLZEY.LINDA@FORUM.VA.GOV")=""
 S XMY("WHITE.ELAINE@FORUM.VA.GOV")=""
 S XMY("WILLIAMSON.ERIC@FORUM.VA.GOV")=""
 I $O(XMY(""))="" Q  ; no recipients for mail message
 S PSOTEXT(1)="The "_JOBN_" job for the Outpatient Pharmacy"
 S PSOTEXT(2)="patch ("_PATCH_") started "_PSOSTART
 S PSOTEXT(3)="and completed "_PSOEND_"."
 S PSOTEXT(4)=" "
 S PSOTEXT(5)="Excel comma delimited data below, five headings, one data line"
 S PSOTEXT(6)="Note that an institution of 999999999 denotes one was not found during run."
 S PSOTEXT(7)=",,,,,,Total Active Rx's"
 S PSOTEXT(8)=",Before v7 Install,Before v7 Install,After v7 Install,After v7 Install,,With"
 S PSOTEXT(9)=",Tot Active Rx's,Tot Inactive,Tot Active,Tot Inactive,Total Rx's,Expiration"
 S PSOTEXT(10)=",Missing Expired,Rx's Missing,Rx's Missing,Rx's Missing,Missing,Date of T-1"
 S PSOTEXT(11)="Institution,Date,Expired Date,Expired Date,Expired Date,Expired Date,Day"
 S PSOINST=0,L=12
 F  S PSOINST=$O(^XTMP(NAMSP,PSOINST)) Q:PSOINST=""!(PSOINST'?1N.NN)  D
 . S DATA=^XTMP(NAMSP,PSOINST),DATA=$TR(DATA,"^",",")
 . S PSOTEXT(L)=$E((PSOINST_","_DATA_LIN),1,LEN),L=L+1
 S L=L+1,PSOTEXT(L)=" "
 ;
 S XMTEXT="PSOTEXT(" N DIFROM D ^XMD K XMDUZ,XMTEXT,XMSUB
 Q
