SDTMPPRC ;TMP/DRF - TMP Clinic Schedule Edit Queueing Routine;Oct 7, 2022
 ;;5.3;Scheduling;**821**;OCT 7, 2022;Build 9
 Q
PROCESS(JOB) ;Process any unprocessed record in SDTMPX queue
 ;JOB = Job number of the process that produced the clinic edits
 ;Lock the queue
 I $G(JOB)="" Q  ;Called incorrectly
 I '$D(^XTMP("SDTMPX",0))  S %H=$H D YMD^%DTC S $P(^XTMP("SDTMPX",0),"^",2)=X ;Set up for first run
 L +^XTMP("SDTMPX",JOB):5 I '$T Q  ;This job's queue is already being processed
 N CL,DATE,FUN,FUNSTR,I,J,K,REC,SDEND,SDSTART,SEQ,SEQSTR,TMS,TOTC,TOTUC,X,Y,Z
 ;Process from piece 2 to piece 1
 S SDEND=+$P($G(^XTMP("SDTMPX",JOB,"SEQ")),"^",1),SDSTART=+$P($G(^XTMP("SDTMPX",JOB,"SEQ")),"^",2) ;process what's in the queue now
 I SDEND=SDSTART Q  ;Nothing new in queue
 ;Load array
 K ^TMP("SDTMPX",JOB)
 F I=SDSTART+1:1:SDEND D
 . S X=^XTMP("SDTMPX",JOB,I)
 . S SEQ=I,CL=$P(X,"^",1),TMS=$P(X,"^",2),DATE=$P(X,"^",3),DUZ=$P(X,"^",4),FUN=$P(X,"^",5)
 . S ^TMP("SDTMPX",JOB,CL,DATE,SEQ)=FUN_"^"_DUZ,^XTMP("SDTMPX","B",TMS,JOB,SEQ)=""
 ;Check array for offsetting transactions
 S CL=0 F  S CL=$O(^TMP("SDTMPX",JOB,CL)) Q:'CL  D
 . S DATE=0 F  S DATE=$O(^TMP("SDTMPX",JOB,CL,DATE)) Q:'DATE  D PROCDATE
 S $P(^XTMP("SDTMPX",JOB,"SEQ"),"^",2)=SDEND
 K ^TMP("SDTMPX",JOB)
 L -^XTMP("SDTMPX",JOB)
 D ORPHAN
 D PURGE
 Q
 ;
PROCDATE ;Process a single date
 S REC=0,FUNSTR=",",SEQSTR=""
 S SEQ=0 F  S SEQ=$O(^TMP("SDTMPX",JOB,CL,DATE,SEQ)) Q:'SEQ  D
 . S FUN=$P(^TMP("SDTMPX",JOB,CL,DATE,SEQ),"^",1),DUZ=$P(^TMP("SDTMPX",JOB,CL,DATE,SEQ),"^",2)
 . S REC=REC+1,FUNSTR=FUNSTR_FUN_",",SEQSTR=SEQSTR_SEQ_","
 S TOTC=0,TOTUC=0 F J=2:1 S Y=$P(FUNSTR,",",J) Q:Y=""  S:Y="C" TOTC=TOTC+1 S:Y="UC" TOTUC=TOTUC+1
 I REC#2=0,TOTC=TOTUC D  Q  ;If even number of transactions, all ofsetting, cancel them
 . F K=1:1 S Z=$P(SEQSTR,",",K) Q:Z=""  S $P(^XTMP("SDTMPX",JOB,Z),"^",6)="O" ;Mark processed offset
 I REC,TOTC>TOTUC D
 . D EN^SDTMPHLC(CL,DATE,,"C","NO APPOINTMENT AVAILABILITY") ;Appointments previously available, now none - send block transaction
 . D MARK("C")
 I REC,TOTUC>TOTC D
 . D EN^SDTMPHLC(CL,DATE,,"UC","RESTORED BY SDBUILD") ;No appointments previously available, send unblock transaction
 . D MARK("UC")
 Q
 ;
MARK(FUN) ;For an odd number of transactions, mark each transaction correct (one sent, the rest offset)
 N FUNSTR2,CNT,FUNCNT,SENT
 S FUNSTR2=$P(FUNSTR,",",2),SENT=0
 S FUNCNT=$L(SEQSTR,",")-1
 F CNT=1:1:FUNCNT D
 . I $P(FUNSTR2,",",CNT)=FUN,'SENT S $P(^XTMP("SDTMPX",JOB,$P(SEQSTR,",",CNT)),"^",6)="P",SENT=1 Q
 . S $P(^XTMP("SDTMPX",JOB,$P(SEQSTR,",",CNT)),"^",6)="O"
 Q
 ;
ORPHAN ;Check for unprocessed entries older than 30 minutes - user may have left Edit A Clinic abnormally
 S JOB=0 F  S JOB=$O(^XTMP("SDTMPX",JOB)) Q:'JOB  D
 . S SDEND=+$P($G(^XTMP("SDTMPX",JOB,"SEQ")),"^",1),SDSTART=+$P($G(^XTMP("SDTMPX",JOB,"SEQ")),"^",2) ;process what's in the queue now
 . I SDEND=SDSTART Q  ;Nothing unprocessed
 . S X=^XTMP("SDTMPX",JOB,SDEND),TS=$P(X,"^",2)
 . I $P($H,",",2)-$P(TS,",",2)>1800 D PROCESS(JOB) ;More than 30 minutes old so process it
 Q
 ;
PURGE ;Purge history greater than 90 days old
 N START,DATE,JOB,SEQ,%H,X
 S START=$H-91_","_"00000"
 S DATE=START F  S DATE=$O(^XTMP("SDTMPX","B",DATE),-1) Q:DATE=""  D
 . S JOB=0 F  S JOB=$O(^XTMP("SDTMPX","B",DATE,JOB),-1) Q:'JOB  D
 .. K ^XTMP("SDTMPX",JOB),^XTMP("SDTMPX","B",DATE,JOB)
 S %H=$H+90 D YMD^%DTC
 S $P(^XTMP("SDTMPX",0),"^",1)=X
 Q
 ;
BEGIN ;Report Begin & Title
 N %,%H,%T,%Y,CL,DA,DATE,DIC,DIE,DIR,DOW,FUN,JOB,LN,OCL,POP,PRC,SDCLIN,SDLN,SDPG,SDT,SEQ,TS,X,XDATE,XTIME,Y
 W #,"TMP Clinic Schedule Edit Transaction List",!!
 S DA=0
 ;
ALLORONE ;All clinics or one clinic
 S DIR(0)="S^O:ONE CLINIC;A:ALL CLINICS"
 S DIR("A")="ONE CLINIC OR ALL",DIR("B")="A" D ^DIR
 I $G(DUOUT)!($G(DTOUT)) G END
 S SDCLIN=X
 I $$UPPER^SDUL1(SDCLIN)="O" D CLINIC I $G(DUOUT)!($G(DTOUT)) G END
 ;
IO ;Ask IO device and Queue
 S %ZIS="PQM" D ^%ZIS G:POP END
 I $D(IO("Q")) D QUE G END
 ;
LOOP ;Compile Data
 K ^TMP("SDTMPPRC")
 S %H=$H D YX^%DTC S SDT=$P(Y,"@"),OCL=0
 S JOB=0 F  S JOB=$O(^XTMP("SDTMPX",JOB)) Q:'JOB  D
 . S SEQ=0 F  S SEQ=$O(^XTMP("SDTMPX",JOB,SEQ)) Q:'SEQ  D
 .. S X=^XTMP("SDTMPX",JOB,SEQ)
 .. S CL=$P(X,"^",1),TS=$P(X,"^",2),DATE=$P(X,"^",3),DUZ=$P(X,"^",4),FUN=$P(X,"^",5),PRC=$P(X,"^",6)
 .. S ^TMP("SDTMPPRC",CL,DATE,TS,SEQ)=FUN_"^"_PRC_"^"_DUZ
 D PRINT
 D END
 Q
 ;
CLINIC ;Clinic prompt
 S DIC=44,DIC(0)="MAQEZ",DIC("A")="Select CLINIC NAME: "
 F  D  Q:Y>0!($G(DTOUT))!($G(DUOUT))
 . D ^DIC
 . I Y<0!(X="") Q
 . S DIE=44,DA=+Y
 K DIC("A"),DIC("S")
 Q
 ;
PRINT ;Print Data
 U IO
 S SDPG=0,SDLN=1
 I DA S CL=DA D PRINT2
 I 'DA S CL=0 F  S CL=$O(^TMP("SDTMPPRC",CL)) Q:'CL  D PRINT2
 W !!,"END OF REPORT"
 Q
 ;
PRINT2 ;Navigate lines in sequence
 S DATE=0 F  S DATE=$O(^TMP("SDTMPPRC",CL,DATE)) Q:'DATE  D
 . S TS="" F  S TS=$O(^TMP("SDTMPPRC",CL,DATE,TS)) Q:TS=""  D
 .. S SEQ=0 F  S SEQ=$O(^TMP("SDTMPPRC",CL,DATE,TS,SEQ)) Q:'SEQ  D
 ... S LN=^TMP("SDTMPPRC",CL,DATE,TS,SEQ),FUN=$P(LN,"^",1),PRC=$P(LN,"^",2),DUZ=$P(LN,"^",3) D LINE
 Q
 ;
LINE ;Print one line
 I CL'=OCL D HEADER
 S OCL=CL
 I SDLN>(IOSL-4) D HEADER
 S SDLN=SDLN+1
 S Y=DATE D DD^%DT S XDATE=Y
 S X=DATE D DW^%DTC S DOW=X
 S %H=TS D YX^%DTC S XTIME=Y
 W ?1,XDATE,?15,DOW,?28,$S(FUN="C":"BLOCK",FUN="UC":"UNBLOCK",1:""),?43,$S(PRC="O":"OFFSET",PRC="P":"SENT",1:"UNPROCESSED"),?56,XTIME,?79,$P($G(^VA(200,DUZ,0)),"^",1),!
 Q
 ;
END ;Clean up and Quit
 D:'$D(ZTQUEUED) ^%ZISC
 K ^TMP("SDTMPPRC"),%ZIS,ZTSAVE,DTOUT,DUOUT
 Q
 ;
HEADER ;Print report header
 S SDPG=SDPG+1,SDLN=1
 W #!!," TMP Clinic Schedule Edit Transaction List",?100,SDT,?120,"PAGE: ",SDPG,!
 W " CLINIC: ",CL,"-",$P(^SC(CL,0),"^",1),!!
 W " DATE          DAY OF WEEK  BLOCK/UNBLOCK  ACTION       MODIFIED               MODIFIED BY",!
 W " ------------  -----------  -------------  -----------  ---------------------  --------------------",!
 Q
 ;
QUE ;Run job in background
 S ZTRTN="LOOP^SDTMPPRC",ZTDESC="Hospital Location List",ZTSAVE("SD*")=""
 D ^%ZTLOAD W:$D(ZTSK) !,"Task #",ZTSK," Started."
 D HOME^%ZIS K IO("Q"),ZTSK,ZTDESC,ZTQUEUED,ZTRTN
 D END
 Q
