PSJSFRQ ; SMT - SEARCH FOR ERRONEOUS FREQS ; 4/23/09 3:28pm
 ;;5.0; INPATIENT MEDICATIONS ;**221**; FEB 09;Build 11
 ; Enter EN^PSJSFRQ for Programmer
 ; QUE^PSJSFRQ to QUEUE for the past 6 months
 ; Mail sends to DUZ and anyone holding "PSJ RPHARM" key
 Q  ; No entry from ^PSJSFRQ
 ;
QUE ;
 N NAMSP,PATCH,JOBN,DTOUT,DUOUT,ZTSK,ZTRTN,ZTIO,ZTDTH,ZTDESC,QUIT,Y,ZTQUEUED,ZTREQ,ZTSAVE,PSJQUE,PSRUN
 S NAMSP=$$NAMSP
 S JOBN="Frequency Report"
 S PATCH="PSJ*5*221"
 S PSRUN="U" ;This is the type of run UD or IV for the report.
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
 . S DIR("A",1)=" Enter when to Queue the "_JOBN_" job to run"
 . S DIR("A")=" in date@time format"
 . S DIR("B")="NOW"
 . S DIR(0)="D^::%DT"
 . S DIR("?")=" Enter when to start the job. The default is Now. You can enter a date and time in the format like this: 021506@3:30p"
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
 S ZTRTN="EN^"_NAMSP,ZTIO="",PSJQUE=1
 S ZTDESC="Background job for "_JOBN_" on prescriptions updated via "_PATCH
 S ZTSAVE("JOBN")="",ZTSAVE("PSJQUE")="",ZTSAVE("PSRUN")=""
 L -^XTMP(NAMSP)
 D ^%ZTLOAD
 D:$D(ZTSK)
 . D MES^XPDUTL("*** Task #"_ZTSK_" Queued! ***")
 . D BMES^XPDUTL("")
 D BMES^XPDUTL("")
 K XPDQUES
 Q
 ;
EN ;
 N MSG,MCNT,START,STOP,I,DFN,IEN,ORD,SCH,OINFO,CNT,I,SUBJ,STARTH,STOPH,VADM,INF,Y,X,% K ERORD
 I '$G(PSJQUE) W !,"This report will generate a mailman of problem Orders with incorrect frequency"
 I '$G(PSJQUE),'$G(PSRUN) S PSRUN="" F  D  Q:(PSRUN="U")!(PSRUN="I")!(PSRUN="UI")!(PSRUN="")!(PSRUN["^")
 . W !,"Please Select, type of order to run this report on",!,"U - Unit Dose",!,"I - IV",!,"UI - Both",!,"Selection:"
 . R PSRUN:$S($G(DTIME):DTIME,1:9999) E  S PSRUN="^" Q
 . I (PSRUN'="U")&(PSRUN'="I")&(PSRUN'="UI")&(PSRUN'["^")&(PSRUN'="") W "  <??>",$C(7)
 Q:(PSRUN["^")!(PSRUN="")
 D RANGE Q:START=-1
 ;UD Orders
 I PSRUN["U" D
 . S I=START F  S I=$O(^PS(55,"AUDS",I)) Q:'I!(I>STOP)  D
 . . S DFN=0 F  S DFN=$O(^PS(55,"AUDS",I,DFN)) Q:'DFN  D
 . . . S IEN=0 F  S IEN=$O(^PS(55,"AUDS",I,DFN,IEN)) Q:'IEN  D 
 . . . . S ORD=DFN_";"_IEN_"U"
 . . . . K OINFO,SCH S OINFO=$$INFO(ORD) S SCH=$$GETSCH($P(OINFO,"^")) Q:SCH=0
 . . . . I $$CHKSDT(ORD) S ERORD(ORD)=""
 . . . . I ("AH"[$P(OINFO,"^",4)),+$P(OINFO,"^",3)'=+$P(SCH,"^",3) Q:'$P(OINFO,"^",3)!($P(OINFO,"^",6)'="C")  S ERORD(ORD)=""
 ;IV orders
 I PSRUN["I" D
 . S I=START F  S I=$O(^PS(55,"AIVS",I)) Q:'I!(I>STOP)  D
 . . S DFN=0 F  S DFN=$O(^PS(55,"AIVS",I,DFN)) Q:'DFN  D
 . . . S IEN=0 F  S IEN=$O(^PS(55,"AIVS",I,DFN,IEN)) Q:'IEN  D
 . . . . S ORD=DFN_";"_IEN_"I"
 . . . . K OINFO,SCH S OINFO=$$INFO(ORD) S SCH=$$GETSCH($P(OINFO,"^")) Q:SCH=0
 . . . . I ("AH"[$P(OINFO,"^",4)),+$P(OINFO,"^",3)'=+$P(SCH,"^",3) Q:'$P(OINFO,"^",3)!($P(OINFO,"^",6)'="P")  S ERORD(ORD)=""
 ;Pending Orders
 ;TBD
 ;
 ;CREATE Message to send based on ERORD
 S CNT=1
 S Y=START D DD^%DT S STARTH=Y
 S Y=STOP D DD^%DT S STOPH=Y
 S SUBJ="FREQUENCY MISMATCH :"_RUNTM
 S MSG(CNT)="This is a list of orders with mismatching frequencies and possible",CNT=CNT+1
 S MSG(CNT)="start date problems. This excludes orders with no frequency and invalid",CNT=CNT+1
 S MSG(CNT)="schedules, the orders on this list need to be reviewed!",CNT=CNT+1
 S MSG(CNT)="This report range is from:"_STARTH_" to "_STOPH,CNT=CNT+1
 I '$D(ERORD) S MSG(CNT)="There are no problems.",CNT=CNT+1
 S I=0 F  S I=$O(ERORD(I)) Q:'I  D
 . S INF=$$INFO(I),DFN=$P(I,";") K VA,VADM D
 . . N I D ^VADPT
 . S MSG(CNT)="",CNT=CNT+1
 . S MSG(CNT)="PATIENT:"_VADM(1)_"  SSN:"_VA("BID"),CNT=CNT+1 I I'["I" S MSG(CNT-1)=MSG(CNT-1)_"  DRUG:"_$P(^PSDRUG($P(INF,"^",5),0),"^")
 . S MSG(CNT)="DFN:"_$P(I,";")_"   ORDER#:"_+$P(I,";",2)_"   SCHED:"_$P(INF,"^")_"   STATUS:"_$P(INF,"^",4),CNT=CNT+1
 . S MSG(CNT)="  TYPE:"_$S(I["I":"IV",I["U":"UNIT DOSE",1:"PENDING")_"   FREQ:"_$P(INF,"^",3),CNT=CNT+1
 ;
 ;Send message
 D MAIL(.MSG,SUBJ)
 Q
RANGE ;
 N NOW,%DT,Y,X,X1,X2,% K START,STOP,RUNTM
 D NOW^%DTC S NOW=% S Y=$P(%,".") D DD^%DT S RUNTM=Y
 ;If this is qued, don't ask, just set to 6 months.
 I $G(PSJQUE) S STOP=NOW,X1=NOW,X2=-183 D C^%DTC S START=X Q
 S %DT="AEPT",%DT("A")="Start Date:",%DT(0)="-NOW" D ^%DT
 S START=Y I Y=-1 Q
 S %DT="AEPT",%DT("A")="Stop Date:",%DT(0)=START D ^%DT
 S STOP=Y I Y=-1 Q
 Q
 ;
GETSCH(SCHED) ;
 ; 
 ; Returns "SCHED^AT^FREQ^PKG"
 ;
 N I,FRQ,PKG,AT K FREQ
 Q:SCHED']"" 0
 I '$O(^PS(51.1,"APPSJ",SCHED,0)) Q 0
 S I=0 F  S I=$O(^PS(51.1,"APPSJ",SCHED,I)) Q:'I  D
 . ;Get Data
 . S FRQ=$P(^PS(51.1,I,0),"^",3),PKG=$P(^(0),"^",4),AT=$P(^(0),"^",2)
 ;
 Q $G(SCHED)_"^"_$G(AT)_"^"_$G(FRQ)_"^"_$G(PKG)
 ;
INFO(ORD) ;
 ;
 ; IEN=DFN;IEN(TYPE) 
 ; ex 2222;102U or 2222;32I or ;23P
 ;
 ; Return "SCHED^AT^FRQ^STATUS^DRUG^SCHTP" (SCHTP is Schedule Type for UD and TYPE for IV
 ;
 N F,SCHED,AT,FRQ,DFN,STAT,DRUG,X,SCHTP,DSPDG,ND0 K DTA55
 S DFN=$P(ORD,";")
 I ORD["P" S F="^PS(53.1,"_+$P(ORD,";",2)_","
 E  S F="^PS(55,"_DFN_","_$S(ORD["U":"5",1:"""IV""")_","_+$P(ORD,";",2)_","
 ;Unit Dose
 I (ORD["U")!(ORD["P") D
 . S ND0=F_"0)"
 . S DSPDG=F_"1," S X=DSPDG_"0)" S X=$O(@X),DSPDG=$G(@(DSPDG_$S(+X:X,1:1)_",0)"))
 . S F=F_"2)"
 . S SCHED=$P(@F,"^"),AT=$P(@F,"^",5),FRQ=$P(@F,"^",6),STAT=$P(@ND0,"^",9),DRUG=$P(DSPDG,"^"),SCHTP=$P(@ND0,"^",7)
 ;IV
 I ORD["I" D
 . S DRUG=""
 . S F=F_"0)"
 . S SCHED=$P(@F,"^",9),AT=$P(@F,"^",11),FRQ=$P(@F,"^",15),STAT=$P(@F,"^",17),SCHTP=$P(@F,"^",4)
 ;
 Q $G(SCHED)_"^"_$G(AT)_"^"_$G(FRQ)_"^"_$G(STAT)_"^"_$G(DRUG)_"^"_$G(SCHTP)
 ;
CHKSDT(ORD) ;
 ;
 ; If this function returns 1 there is a start date problem.
 ;
 N DFN,ERR,ND2,ND0,I,LIDT,STDT,F,ND
 Q:ORD["I" 0
 S DFN=$P(ORD,";")
 I ORD["P" S F="^PS(53.1,"_+$P(ORD,";",2)_","
 E  S F="^PS(55,"_DFN_","_$S(ORD["U":"5",1:"""IV""")_","_+$P(ORD,";",2)_","
 S ND2=F_"2)",ND2=@ND2,ND0=F_"0)",ND0=@ND0,ERR=0
 I ORD["U" D
 . S STDT=$P(ND2,"^",2),LIDT=$P(ND0,"^",14),I=""
 . F  S I=$O(^PS(55,DFN,5,+$P(ORD,";",2),9,I),-1) Q:'I  S ND=^(I,0) I $P(ND,"^",3)["Start Date" D  Q
 . . Q:STDT=LIDT
 . . I STDT'=$P(ND,"^",5) S ERR=1
 Q ERR
 ;
MAIL(MSG,SBJ) ; Send out some mail!
 N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY,I
 S XMDUZ="INPT PHARMACY",XMSUB=SBJ,XMTEXT="MSG("
 S XMY(DUZ)="",I=0 F  S I=$O(^XUSEC("PSJ RPHARM",I)) Q:'I  S XMY(I)=""
 D ^XMD
 Q ""
 ;
NAMSP() ;
 Q $T(+0)
 ;
STOP ;stop job command
 I $$ST S ^XTMP($$NAMSP,0,"STOP")="" D
 . W !,"TALLY MISSING EXPIRATION DATES Job - set to STOP Soon"
 . W !!,"Check Status to be sure it has stopped and is not running..."
 . W !,"     (D STATUS^PSOTEXP1)"
 Q
 ;
ST() ;status
 L +^XTMP($$NAMSP):3 I $T D  Q 0
 . L -^XTMP($$NAMSP)
 . W !,"*** NOT CURRENTLY RUNNING! ***",!
 Q 1
 ;
INITXTMP(NAMSP,TITLE,LIFE) ;create ^Xtmp according to SAC std
 N BEGDT,PURGDT
 S BEGDT=$$NOW^XLFDT()
 S PURGDT=$$FMADD^XLFDT(BEGDT,LIFE)
 S ^XTMP(NAMSP,0)=PURGDT_"^"_BEGDT_"^"_TITLE
 Q
 ;
QUIT ;
 L -^XTMP(NAMSP)
 Q
 ;
