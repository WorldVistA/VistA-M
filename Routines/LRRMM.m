LRRMM ;CIOFO-DALLAS/JMC/SED -Lab Reports via Network Mail
 ;;5.2;LAB SERVICE;**164**;Apr 09, 1993
LAB ;Requires Lab 5.0 and Mailman 7.0 (Spooling to XMBS GlobaL)
 ;Enter with LRRLROC=Interim Report Location (File 44 Abbreviation)
 ;    LRRVDT=Date to produce reports for (i.e. "T-1" would 
 ;           produce reports for work verified yesterday)
 ;    LRRDEV=Name of the spool Device. 
 ;           Default is "SPOOL80"  if not defined.
 ;   LRRSITE=Name Of Referring Lab (Should be domain file
 ;           entry i.e "MILWAUKEE.VA.GOV")
 ;   LRRNORP=1 If "NEGATIVE" Mail Messages are -NOT- Required.
 ;
 S U="^" S:'$D(DTIME) DTIME=600
 S:'$D(LRRNORP) LRRNORP=0 S X=$S($D(LRRVDT):LRRVDT,1:"T-1"),%DT="" D ^%DT Q:Y<1  S LRRVDT=Y D DD^LRX S LRRDATE=Y D ^LRPARAM
 I '$D(^LRO(69,LRRVDT,1,"AN",LRRLROC))&(LRRNORP) Q
 S:$G(LRRDEV)="" LRRDEV="SPOOL80"
 D NOW^%DTC
 S LRRNAME="LAB REPORTS "_$P(LRRSITE,".",1)_" "_%,IO("DOC")=LRRNAME,IOP=LRRDEV_";"_IO("DOC") D ^%ZIS
 S (LRLAB,LREND,LRSTOP,LRFOOT)=0,(LRH,LRONESPC,LRONETST)="",LRCW=8,LRHF=1
 U IO I '$D(^LRO(69,LRRVDT,1,"AN",LRRLROC)) W !,"No reports to transmit today." G MAIL
 S LRDFN=0 F  S LRDFN=$O(^LRO(69,LRRVDT,1,"AN",LRRLROC,LRDFN)) Q:LRDFN<1  D
 .S LROC=LRRLROC D:LRFOOT FOOT^LRRP1 S LRFOOT=0,LRHF=1,LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3) D PT^LRX D
 ..S LRIDT=0 F  S LRIDT=$O(^LRO(69,LRRVDT,1,"AN",LRRLROC,LRDFN,LRIDT)) Q:LRIDT<1  D:$D(^LR(LRDFN,"CH",LRIDT)) CH^LRRP2 D:$D(^LR(LRDFN,"MI",LRIDT)) MI^LRRP2
MAIL D:LRFOOT FOOT^LRRP1 W ! D ^%ZISC,KILL^XM
 S XMDF=1,XMDUZ=DUZ,X="G.LAB REPORT" D WHO^XMA21
 S X="G.LAB REPORT@"_LRRSITE D INST^XMA21
 S XMSUB=^DD("SITE")_" LAB REPORTS FOR "_$P(LRRSITE,".",1)_" ON "_LRRDATE
 D TSK^LRRMM
 Q
 ;
ONELOC ;Entry point to create lab reports for one location.
 D LAB,KILL Q
 ;
MANYLOC ;Entry point to create lab reports for several sites.
 ;Enter with LRRLST=List of File #44 Locations (abbreviations) 
 ;Separated by ";" (i.e. LRRLST="XXX;YYY")
 ;LRRDLST=List of corresponding domain names to send reports
 ;         to (i.e. LRRDLST="AAA.VA.GOV;BBB.VA.GOV")
 F LRRZZ=1:1 S LRRLROC=$P(LRRLST,";",LRRZZ) Q:LRRLROC=""  S LRRSITE=$P(LRRDLST,";",LRRZZ) D LAB
 D KILL Q
 ;
ALLOC ;Entry point to send lab reports to all locations defined in 
 ;file #64.6 (interim reports) that have a domain name entered.
 ;This requires a field "domain name" being added to #64.6 at 
 ;subscript ^LAB(64.6,D0,0), this is a pointer to the domain file.
 S LRRZZ=0
 F  S LRRZZ=$O(^LAB(64.6,LRRZZ)) Q:'LRRZZ  D
 .S LRRZZ(0)=+$P($G(^LAB(64.6,LRRZZ,0)),U,7)
 .I LRRZZ(0) S LRRLROC=$P($G(^SC(+$P(^LAB(64.6,LRRZZ,0),"^"),0)),"^",2),LRRSITE=$P($G(^DIC(4.2,LRRZZ(0),0)),"^") I LRRLROC]"",LRRSITE]"" D LAB
 D KILL Q
 ;
KILL ;Cleanup before leaving.
 S:$D(ZTQUEUED) ZTREQ="@"
 K %,%DT,DFN,LRCW,LRDFN,LRDPF,LREND,LRFOOT,LRH,LRHF,LRIDT,LRLAB,LROC
 K LRONESPC,LRONETST,LRSTOP,IOP,X,XMDF,Y,ZZ,LRRDATE,LRRDLST
 K LRRLROC,LRRLST,LRRNAME,LRRNORP,LRRSITE,LRRVDT,LRRZZ,LRRDEV
 D V^LRU,^LRKILL,KILL^XM
 Q
TSK ;Entry point from taskman to load a spool file into message.
 ;Enter with XMSUB=header,XMY(SENDEE NAMES)=""
 ;LRRNAME=name of spool document file to load into message.
 K DIC S:'$D(DTIME) DTIME=300
 S U="^",X=LRRNAME,DIC=3.51,DIC(0)="MZ"
 D ^DIC Q:Y<1  S DA=+Y,ZISPL0=Y(0),ZISDA=DA K DIC
DQMAIL W:'$D(ZTQUEUED) !,"Moving it..."
 S XS=$P(ZISPL0,"^",10),XMY(DUZ)="",XMTEXT="^XMBS(3.519,"_XS_",2,"
 D:XS>0 ^XMD D DSDOC^ZISPL(ZISDA),DSD^ZISPL(XS) W:'$D(ZTQUEUED) !,"  Now a normal mail message.."
 I $G(XMZ) S XMDUZ=DUZ D NNEW^XMA ;Make message new for recipient.
 D KILL1 Q
 ;
PRINT ;Entry point from menu option to extract text of message and print it.
 D HOME^%ZIS K DIC
ASK ;Select the mailman basket.
 S DIC="^XMB(3.7,DUZ,2,",DIC(0)="AEMNQ",DIC("A")="Select Mail Basket: "
 S DIC("B")="IN"
 W ! D ^DIC G:Y<1 KILL1 S LRRMK=+Y,LRRMKN=$P(Y,"^",2)
 K ^TMP($J) S (LRRMC,LRRMZ1)=0
 F  S LRRMZ1=$O(^XMB(3.7,DUZ,2,LRRMK,1,LRRMZ1)) Q:LRRMZ1<1  D
 .S J=+^(LRRMZ1,0)
 .Q:$P($G(^XMB(3.9,J,0)),U,1)'["LAB REPORT"
 .S LRRMC=LRRMC+1,^TMP($J,"B",LRRMC)=J
 W "  ",$S(LRRMC=0:"No Lab",1:LRRMC)," Message",$S(LRRMC'=1:"s",1:"")," in basket." G:LRRMC=0 ASK
LIST ;Select the message.
 W @IOF,!,"Select from the following:" S (LRRMZ,LRROUT,I)=0
 F  S I=$O(^TMP($J,"B",I)) Q:'I  S LRRMZ=^TMP($J,"B",I) D  Q:LRROUT
 .I $Y>(IOSL-5) K DIR S DIR(0)="E" D ^DIR K DIR S LRROUT=Y-1 W @IOF Q:LRROUT
 .S LRRMR=$G(^XMB(3.9,LRRMZ,0)) Q:LRRMR=""  S LRRMSUB=$P(LRRMR,U,1)
 .I LRRMSUB["~U~" F  S LRRMSUB=$P(LRRMSUB,"~U~",1)_"^"_$P(LRRMSUB,"~U~",2,99) Q:LRRMSUB'["~U~" 
 .W !,I," Subj: ",LRRMSUB,"  "
 .S Y=$P(LRRMR,U,3),X1=+$P($G(^XMB(3.9,LRRMZ,2,0)),"^",4)
 .I Y'?7N.E W Y
 .E  W $E(Y,4,5),"/",$E(Y,6,7),"/",$E(Y,2,3)," " S Y=$P(Y,".",2)_"0000" W "@ ",$E(Y,1,2),":",$E(Y,3,4)
 .W "  ",X1," Line",$S(X1>1:"s",1:"")
 Q:LRROUT
 K DIR S DIR(0)="NO^1:"_LRRMC_":0"
 S DIR("A")="Select Message to Extract",DIR("B")=1
 S DIR("?")="Enter the number of the message you want printed"
 D ^DIR K DIR G:$D(DIRUT) ASK S LRRMZ=$G(^TMP($J,"B",Y))
 S %IS="Q" D ^%ZIS I POP D HOME^%ZIS,KILL1 Q
 I $D(IO("Q")) S ZTDESC="Extract Text of Mail Message",ZTSAVE("LRRMZ")="",ZTRTN="WRITE^LRRMM" D ^%ZTLOAD W !,"REQUEST ",$S($D(ZTSK):"",1:"NOT "),"QUEUED" K IO("Q"),ZTSK D ^%ZISC G ASK
 D WRITE,KILL1 G ASK
 ;
WRITE ;Print the text of the message.
 U IO S LRRCN=.9999
 F  S LRRCN=$O(^XMB(3.9,LRRMZ,2,LRRCN)) Q:'LRRCN  S X=^(LRRCN,0) W:X="|TOP|" @IOF W:X'="|TOP|" X,!
 W @IOF D ^%ZISC,KILL1 S:$D(ZTQUEUED) ZTREQ="@" Q
 ;
KILL1 K ^TMP($J),LRRCN,LRRMC,LRRMK,LRRMKN,LRRMR,LRRMZ,LRRMZ1
 K LRRMSUB,LRROUT,%,%IS,DA,DIC,DIR,DIROUT,DIRUT,DUOUT,I,J
 K POP,X,X1,XMZ,XS,Y,ZISDA,ZISPL0
 Q
