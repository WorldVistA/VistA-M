QACMAIL0 ;ERC/WASHCIOFO-Send data to reposititory ;11/29/99
 ;;2.0;Patient Representative;**4,14,15,17**;07/25/1995
 ;
 N QACREQUE
 D ZTDTH
 ;
 Q
 ;
TASK ;Set up tasking for routine.   Roll-up will be queued for
 ; 01:30am, so that it doesn't run at a busy time of day.
 S ZTRTN="START^QACMAIL0"
 S ZTDESC="Routine collects data from local Patient Rep file for rollup"
 S ZTDTH=QACSTART
 S ZTSAVE("XMTXT")="",ZTSAVE("QACNOT")="",ZTSAVE("QACREQUE")=""
 S ZTIO=""
 F QAC1=1:1:20 D ^%ZTLOAD Q:$G(ZTSK)
 I $G(ZTSK)']"" S QACERR=7 D ERROR
 S DA=1,DR="754///^S X=ZTSK"
 S DIE="^QA(740,"
 D ^DIE K DIE
 D EXIT
 Q
START ;
 N QAC1,QACC,QACD,QACE,QACEE,QACF,QACHK,QACJ,QACK
 N QA,QACBDAT,QACCONT,QACDOM,QACEDAT,QACELIG,QACEM,QACEMP
 N QACERR,QACERROR,QACEXIT,QACINC,QACINTAP,QACLIN,QANLINE,QACLSAT,QACMADE
 N QACMON,QACNO,QACNOCNT,QACNOT,QACQUIT,QACRST,QACSERV,QACSITE,QACSOR
 N QACSR,QACSTA,QACST,QACTMP,QACVISN,QACVZ,QACYR,QACZERO
 ;QACLCNT is message line count
 ;QACRCNT is the number of records processed
 ;QACCHCNT is a count of characters on the EMP line
 ;QACTCNT is number of characters in message
 ;QACNOCNT is the number of records not sent
 N QACCHCNT,QACLCNT,QACNOCNT,QACRCNT,QACTCNT
 S (QACCHCNT,QACLCNT,QACNOCNT,QACRCNT,QACTCNT)=0
 ;set executable to cut down on keying
 S QACINC="S QACTCNT=$G(QACTCNT)+$L($G(^TMP(""QAC MAIL"",$J,QACLCNT))),QACLCNT=$G(QACLCNT)+1"
 K ^TMP("QAC MAIL",$J)
 S QACEXIT=0
 S QACZERO=$S($D(^QA(740,1,0))#2:^(0),1:0) I +QACZERO'>0 S QACERR=1 D ERROR G EXIT
 S QACSITNO=+QACZERO
 I $G(QACSITNO)]"" D VISN(QACSITNO)
 S QACSTA="" D SITE^QACUTL0(+QACZERO,.QACSTA) I '$L(QACSTA) S QACERR=3 D ERROR G EXIT
 ;reset ZTDTH, ^%ZTLOAD
 I $G(QACREQUE)<1 D ZTDTH ;re-tasks job for next run
 I $G(QACHK)=1 Q
 ;
 I $G(QACREQUE)'=1 D LOOP^QACMAIL1
 I $G(QACREQUE)=1 D REQLOOP
 I $D(^TMP("QAC MAIL",$J)) D SEND
EXIT ;
 K ^TMP("QAC MAIL",$J)
 K DIROUT,DIRUT
 K QACDUZ,QACINT,QACMSG,QACNO,QACNOCNT
 N QACQBEG,QACQEND,QACRCNT,QACREQUE,QACST,QACTCNT,QACVISN,QACZTSK
 K X,X1,X2
 K XMSUB,XMTEXT,XMY
 K ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTIO
 Q
ERROR ;
 ; Need to send message with error codes if QACERR is set.
 ; QACERR is set if site and domain information is missing
 ; or if no task number assigned to queueing.
 ; Then need to re-queue for next run.
 D KILL^XM
 S QACERROR(QACERR)=$P($T(ERR+QACERR),";;",2)
 S XMTEXT="QACERROR("
 S XMY("G.IRM")=""
 S XMSUB="ERROR MSG FROM PATIENT REP DATABASE ROLLUP - PATCH QAC*2*4"
 D ^XMD
 D KILL^XM
 K QACERROR(QACERR)
 Q
SEND ;Send message. 
 ;This message is the roll-up.
 S ^TMP("QAC MAIL",$J,QACLCNT)=^TMP("QAC MAIL",$J,QACLCNT)_"#"
 D KILL^XM
 S XMY("XXX@Q-PSS.MED.VA.GOV")=""
 S XMSUB="QAC ROC LIST: "_^DD("SITE")_" ("_^DD("SITE",1)_")"
 S XMTEXT="^TMP(""QAC MAIL"",$J,"
 D ^XMD D KILL^XM
 I $G(QACCONT)=1 S QACCONT=0 Q
 D EXIT
 Q
ERR ;;Text for error messages to be included in mail message
 ;;Site not found in QA Site Parameter file
 ;;Site not found in Institute file
 ;;Site number not found in Institution file
 ;;Mail group not found in QA Site Parameter file
 ;;Domain not found in QA Site Parameter file
 ;;Domain not found in Domain file
 ;;Message not sent - no task number
 ;;No VISN number - primary VISN association not set up in Institution file
 Q
ZTDTH ;set the kernel ZTDTH variable for the first run and rescheduled runs.
 ;
 H 20
 D CHKTSK
 I $G(QACHK)=1 Q
 N %Y,QACSTART
 S (X,X1)=DT
 D H^%DTC
 S X2=$S(%Y=0:2,%Y=6:3,1:1)
 D C^%DTC
 S QACSTART=X_".013"
 D TASK
 S DA=1
 S DR="754///^S X=ZTSK"
 S DIE="^QA(740,"
 D ^DIE K DIE
 Q
NEWMSG ;send message, set variables for continuation message.
 ;S (QACCHCNT,QACLCNT,QACRCNT,QACTCNT)=0
 ;flag for continuation message - don't go to EXIT at end of SEND
 S QACCONT=1
 D SEND
 S (QACCHCNT,QACLCNT,QACRCNT,QACTCNT)=0
 K ^TMP("QAC MAIL")
 Q
ROLL(QACODE) ;set new Roll-Up Status field
 ;if record is not being rolled up set field to "1" (Rejected).
 ;if record is has been rolled up and is closed, set field to "0".
 ;if record was sent, but status is still open, set to "2".
 ;not used after QAC*2*17
 N DA,DIE,DR
 S DIE="^QA(745.1,"
 S DA=QACJ
 S DR="41///^S X=QACODE"
 D ^DIE K DIE
 Q
REQUE ;this subroutine will task this extract once, for one month or for 
 ;a portion of one month.
 N QACREQUE
 N QACCHCNT,QACLCNT,QACNOCNT,QACRCNT,QACTCNT
 S (QACCHCNT,QACLCNT,QACNOCNT,QACRCNT,QACTCNT)=0
 ;set re-queue flag so that task will not be re-tasked during this run
 S QACREQUE=1
 D START
 Q
VISN(QACSITNO) ;find VISN for this site
 N QACV
 I $D(^DIC(4,QACSITNO,7,0)) D PARENT^XUAF4("QACV",QACSITNO,"VISN")
 I '$D(^DIC(4,QACSITNO,7,0)) S QACERR=8 S QACVISN=0 ;D ERROR Q
 S QACVZ=$O(QACV("P",0))
 I $G(QACVZ)]"" S QACVISN=$P(QACV("P",QACVZ),U)
 I $G(QACVZ)']"" D
 . S QACEE=0
 . F  S QACEE=$O(^DIC(4,QACSITNO,7,QACEE)) Q:QACEE'>0  D
 . . I +^DIC(4,QACSITNO,7,QACEE,0)'=1 Q
 . . S QACVISN=$P(^DIC(4,QACSITNO,7,QACEE,0),U,2)
 . . S QACVISN=$P($G(^DIC(4,QACVISN,0)),U)
 I $G(QACVISN)']"" S QACERR=8
 I $G(QACERR)=8 S QACVISN=0 D ERROR Q
 I $G(QACVISN)["VISN " S QACVISN=$E(QACVISN,6,9)
 Q
CHKTSK ;check to see if this job has already been tasked (i.e. on an earlier 
 ;installation, or if it has already started running).
 S ZTSK=$P(^QA(740,1,"QAC"),U,5)
 I $G(ZTSK)>0 D
 . D STAT^%ZTLOAD
 . I $G(ZTSK(1))=2 Q
 . S QACZTSK=ZTSK K ZTSK S ZTSK=QACZTSK
 . D ISQED^%ZTLOAD
 . I $P($G(ZTSK("D")),",")>$P($H,",") S QACHK=1 Q
 . I $P($G(ZTSK("D")),",")=$P($H,",") I $P(ZTSK("D"),",",2)>$P($H,",",2) S QACHK=1
 Q
REQLOOP ; this subroutine will run the rollup manually for a month or a part
 ; of one month.
 N Y
 W !!,"This option will run the Patient Representative data roll-up"
 W !,"for one month."
 K %DT S %DT="AE",%DT("A")="Enter Month and Year: " D ^%DT
 I Y'>0!(Y<2991000)!(Y>DT)!(+$E(Y,4,5)'>0) W !!,"Valid date not entered - exiting." Q
 S QACQBEG=$E(Y,1,5)_"00"
 S QACQEND=$E(Y,1,5)_"31"
 S Y=QACQBEG D DD^%DT
 I Y<0 W !!,"Invalid Date" Q
 S QACMONTH=Y
 S DIR(0)="Y"
 S QACMONTH=Y
 S DIR("A")="Would you like only a part of "_QACMONTH_"?"
 S DIR("B")="NO"
 S DIR("?")="Enter ""Y"" if to limit the date range, ""N"" if you want the whole month."
 D ^DIR I $D(DIRUT)!($D(DIROUT)) Q
 K QACFAIL
REQLOOP1 I Y=1 D
 . K DIR
 . S DIR(0)="N^1:31"
 . S DIR("A")="Enter the number of the earliest day."
 . D ^DIR I $D(DIRUT)!($D(DIROUT)) Q
 . S QACQBEG=$E(QACQBEG,1,5)_$S($L(+Y)<2:"0"_Y,1:Y)
 . S DIR("A")="Enter the number of the last day."
 . D ^DIR I $D(DIRUT)!($D(DIROUT)) Q
 . S QACQEND=$E(QACQEND,1,5)_$S($L(+Y)<2:"0"_Y,1:Y)
 . I QACQBEG>QACQEND S QACFAIL=1 W !!,"End date must be later than beginning date."
 I $G(QACFAIL)=1 K QACFAIL S QACQBEG=$E(QACQBEG,1,5)_"00",QACQEND=$E(QACQEND,1,5)_"32" S Y=1 G REQLOOP1
 N QACA,QACJ,QACOUNT
 S QACOUNT=0
 S QACQBEG=QACQBEG-.001
 S QACA=QACQBEG
 S QACQEND=QACQEND_.999
 F  S QACA=$O(^QA(745.1,"D",QACA)) Q:QACA'>0!($G(QACOUNT)>700)!(QACA>QACQEND)  D
 . S QACJ=""
 . F  S QACJ=$O(^QA(745.1,"D",QACA,QACJ)) Q:QACJ'>0  D
 . . D NODE0^QACMAIL1
 . . I $D(^QA(745.1,QACJ,3,0)),($P(^QA(745.1,QACJ,3,0),U,3)>0) S QACOUNT=QACOUNT+1
 I $G(QACOUNT)=0 W !!,"No Contacts for this date range." Q
 D SITEMSG(QACOUNT,QACMONTH)
 I $G(QACOUNT)>0 W !!,"Number of records transmitted to the national database - "_QACOUNT
 W !!,"End of Manual Rollup Option."
 Q
SITEMSG(QACOUNT,QACMONTH) ;sends a message with the number of records 
 ;sent from the manual option
 D KILL^XM
 S QACDUZ=$P(^VA(200,DUZ,0),U)
 S XMY(QACDUZ)=""
 S XMSUB="MANUAL ROLLUP STATUS"
 S QACMSG(1)="Manual Rollup for "_QACMONTH_"."
 S QACMSG(2)="Total number of records sent: "_QACOUNT
 S XMTEXT="QACMSG("
 D ^XMD D KILL^XM
 Q
