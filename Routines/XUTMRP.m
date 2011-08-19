XUTMRP ;ISF/RWF,BOSTON/MEF - REQUEUE ALL TASKS FOR A DEVICE -PART ONE ;06/11/2001  11:13
 ;;8.0;KERNEL;**2,20,86,120,169**;Jul 10, 1995
 ;REPNT=1 if your using the ZZWFRep option because the device's lta#
 ; was changed 
INIT ;Setup
 Q:$D(DUZ)[0  Q:DUZ=""!(DUZ=0)  D ENV^XUTMUTL S XUCPU=$P(XUTMUCI,",",2)
 ;
 N WAIT,FUT,MEFEND,DIR,XUTMDTH K ^TMP($J)
 D WAIT ;Get what list to work on.
 G:('FUT&'WAIT) EXIT G:($G(MEFEND)&'WAIT) EXIT
OPT W ! S DIR(0)="Y",DIR("A")="Change the device field in the option Scheduling file"
 S DIR("B")="NO",DIR("?")="A yes answer will permanently change the schedule for these tasks"
 D ^DIR K DIR Q:$D(DIRUT)!($D(DUOUT))  S OPT=Y
 W !
 ;
DEV D ASKD("Requeue tasks for device: ") K DIC G:Y'>0 EXIT
 S OLDLTA=LTA,CONFDEV=DEV D DVARRY("OLDDEV",OLDLTA,1)
 D ASKD("Requeue to device: ") K DIC G:Y'>0 EXIT
 D DEV2
 I Y'>0 D EXIT Q  ;no target device
 S CONFDEV(CONFDEV)=DEV D DVARRY("NEWDEV",LTA)
CONF S DEVNAM=""
 F  S DEVNAM=$O(OLDDEV(DEVNAM)) Q:DEVNAM=""  I '$D(CONFDEV(DEVNAM)) D
 . S DEV="" F  S DEV=$O(CONFDEV(DEV)) Q:DEV=""  I $P(OLDDEV(DEVNAM),";",3,4)=$P(NEWDEV(CONFDEV(DEV)),";",3,4) S CONFDEV(DEVNAM)=CONFDEV(DEV) Q
 . Q
 D ^XUTMRP1
 ;
EXIT K CONFDEV,DEL,DEV,DEVNAM,DIC,DIRUT,DUOUT,EDATE,EDT,FUT,I,II,LTA,MEFEND
 K NEWDEV,OLDDEV,OLDLTA,POP,SDATE,SDT,SN,SRCE,WAIT,XQH,Y,XUCPU,ZTDH,ZTIO
 K OPT,ZTKEY,ZTMD,ZTNAME,ZTUCI,ZTSK,ZTC,ZTOPT,XUTMDTH,^TMP($J)
 Q
 ;
DEVNAM(ARRAY) ;Build @ARRAY@(devname) from DEVNAM 
 S DEVNAM=""
 F  S DEVNAM=$O(DEVNAM(DEVNAM)) Q:DEVNAM=""  S IOP=DEVNAM D D0 S @ARRAY@(DEVNAM)=ZTIO K DEVNAM(DEVNAM)
 Q
 ;Slave printers and Spool Documents not allowed
ASKD(%A,%B) ;Ask for a device
 N DIC S:$G(%A)]"" DIC("A")=%A S:$G(%B)]"" DIC("B")=%B
 S DIC("S")="I $S($L($P(^(0),U,9)):($P(^(0),U,9)=XUCPU),$P(^(0),U,2)=0:0,""^SPL^VTRM^MT^OTH""[(U_$P(^(""TYPE""),U)):0,+$G(^(90)):$S(^(90)'>DT:0,1:1),1:1)",DIC="^%ZIS(1,",DIC(0)="AEMQZ"
 D ^DIC Q:Y'>0
 S DEV=Y(0,0),LTA=$P(Y(0),U,2)
 Q
 ;
DVARRY(II,LTA,OOS) ;Build list of devices for a LTA.
 N SN S OOS=$G(OOS)
 F SN=0:0 S SN=$O(^%ZIS(1,"C",LTA,SN)) Q:SN'>0  S (ZTMD,IOP)=$P(^%ZIS(1,+SN,0),U) D
 . I $S($L($P(^(0),U,9)):($P(^(0),U,9)=XUCPU),$P(^(0),U,2)=0:0,"^SPL^VTRM^MT^OTH"[(U_$P(^("TYPE"),U)):0,OOS:1,+$G(^(90)):$S(^(90)'>DT:0,1:1),1:1) D D0 S @II@(ZTMD)=ZTIO
 Q
 ;
WAIT S (WAIT,FUT)=0
 S DIR(0)="Y",DIR("A")="Do you want to re-direct waiting tasks",DIR("B")="Yes" D ^DIR K DIR Q:$D(DIRUT)!($D(DUOUT))  S WAIT=Y
 ;
FUT W ! S DIR(0)="Y",DIR("A")="Do you want to re-direct future tasks",DIR("B")="NO" D ^DIR K DIR Q:$D(DIRUT)!($D(DUOUT))  S FUT=Y
 I FUT D
 . W !,"Now give a date/time range of future tasks to change."
 . S SDT=$$DT("STARTING DATE/TIME","NOW") Q:SDT'>0
 . S EDT=$$DT("ENDING DATE/TIME","T@24:00") Q:EDT'>0
 . I SDT>EDT S ZDT=SDT,SDT=EDT,EDT=ZDT
 . S SDATE=$$FMTE^XLFDT(SDT),EDATE=$$FMTE^XLFDT(EDT)
 Q
 ;
REPNT ;Re-queues tasks to new lta# when dsv/ports are changed
 Q:$D(DUZ)[0  Q:DUZ=""!(DUZ=0)  D ENV^XUTMUTL S XUCPU=$P(XUTMUCI,",",2)
 K ^TMP($J),EXIT S REPNT=1
 D REP2
 G:$G(EXIT) EXIT D ^XUTMRP1,EXIT
 Q
REP2 ;
 D WAIT I $D(DIRUT)!($D(DUOUT)) S EXIT=1 Q
 W ! S DIR("A")="Enter old $I (i.e. _LTA111: or 367) ",DIR(0)="F^1:55",DIR("?")="^D LISTIO^XUTMRP" D ^DIR
 I $D(DIRUT)!($D(DUOUT)) S EXIT=1 Q
 I $O(^%ZTSCH("IO",Y,0))="" S EXIT=1 W !,"There are NO tasks waiting for this device.",!
 S OLDLTA=Y Q:$G(EXIT)
 W ! D ASKD("Requeue tasks to device: ") ;Returns LTA,Y,DEV
 K DIC I Y'>0 D  Q:$G(EXIT)
 . K DIR S DIR(0)="Y",DIR("A")="Want to just move the Tasks back to the schedul list with a new run time:"
 . D ^DIR I 'Y S EXIT=1 Q
 . S LTA=OLDLTA
 . Q
 S NEWLTA=LTA
 D DVARRY("NEWDEV",NEWLTA),DVARRY("OLDDEV",OLDLTA,1)
 S II=""
 F  S II=$O(NEWDEV(II)) Q:II=""  S CONFDEV(II)=II
 S XUTMDTH=$$DT("When to have the tasks restart:","NOW")
 Q
 ;
DEV2 ;Return Y=0 to quit
 S IOP=DEV,Y=1 D D0
 Q:$P(OLDDEV(CONFDEV),";",3,4)=$P(ZTIO,";",3,4)
 S SRCE=OLDDEV(CONFDEV)
 W !,$C(7),$P(SRCE,";")," margin ",$P(SRCE,";",3)," page length ",$P(SRCE,";",4),$C(7)
 W !,"doesn't match ",$P(ZTIO,";")," margin ",$P(ZTIO,";",3)," page length ",$P(ZTIO,";",4)
 W !,"Please confirm target device.",!,"If I can find a matching margin/page length",!,"I'll use it for the default.",!!,$C(7)
 D DVARRY("DEVNAM",LTA)
 S DEVNAM="" F  S DEVNAM=$O(DEVNAM(DEVNAM))  Q:DEVNAM=""  Q:$P(DEVNAM(DEVNAM),";",3,4)=$P(OLDDEV(CONFDEV),";",3,4)
 I DEVNAM]"" S DEFDEV=DEVNAM
 K DEVNAM D ASKD("Requeue to device: ",$G(DEFDEV)) K DIC,DEFDEV Q:Y'>0
 S IOP=DEV D D0
 Q
 ;
D0 ;
 S %ZIS="NQZ" D ^%ZIS
 S ZTIO=$S($D(IOS)[0:"",POP:"",$D(ION)[0:"",ION]"":ION,IOS="":"",$D(^%ZIS(1,IOS,0))[0:"",1:$P(^(0),U))
 S ZTIO=ZTIO_$S($D(IOST)[0:"",1:";"_IOST)_$S($D(IO("DOC"))[0:$S($D(IOM)[0:"",1:";"_IOM_$S($D(IOSL)[0:"",1:";"_IOSL)),1:";"_IO("DOC"))_$S($D(IO("P"))[0:"",IO("P")="":"",1:";/"_IO("P"))
 S:$D(IOCPU)#2 XUCPU=IOCPU
 I $D(IO("HFSIO"))#2,$D(IOPAR)#2,IOT="HFS" S ZTIO("H")=IO("HFSIO"),ZTIO("P")=IOPAR
 Q
 ;
DT(MES,DEF) S DIR("A")=MES,DIR("B")=DEF
 S DIR(0)="D^DT::AEFT",DIR("?")="This response must be a date/time"
 D ^DIR K DIR
 Q Y
LISTIO ;List the entries in the IO queue.
 N DEV,I,Y,DIR
 S DEV="" W @IOF
 W !,"  $IO       Device names",!,"_______     ____________"
 F  S DEV=$O(^%ZTSCH("IO",DEV)) Q:DEV=""  D
 . Q:$D(^%ZTSCH("IO",DEV))'>2
 . W !,DEV,?14," => "
 . F I=0:0 S I=$O(^%ZIS(1,"C",DEV,I)) Q:I'>0  S Y=$P($G(^%ZIS(1,I,0)),U) W:$X+$L(Y)+2>79 !,?18 W Y,", "
 . I ($Y+4)>IOSL S DIR(0)="E" D ^DIR S:$D(DIRUT) DEV=$C(126) W @IOF
 . Q
 Q
