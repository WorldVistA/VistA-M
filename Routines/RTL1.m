RTL1 ;TROY ISC/MJK-Routine to Print Labels ; 5/1/87  11:55 AM ; 4/10/03 3:28pm
 ;;2.0;Record Tracking;**27,35**;10/22/91
RTQ Q:'$D(^RTV(190.1,RTQ,0))  S RTIFN=RTQ I $D(^RT(+^(0),0)) S X=+$P(^(0),"^",3),T=6,RTMES="W !?3,""...notice for request #"_RTIFN_" has been queued to print on device "",$E(RTION,1,15)",RTNUM=1
REC I '$D(RTIFN) Q:'$D(^RT(RT,0))  S RTIFN=RT,X=+$P(^(0),"^",3),T=5,RTMES="W !?3,""...label for record #"_RTIFN_" has been queued to print on device "",$E(RTION,1,15)",RTNUM=1
 D FMT,Q:RTFMT K RTMES,RTNUM,RTIFN,RTFMT,T Q
 ;
FMT S RTFMT=$S('$D(^DIC(195.2,X,0)):"",$D(^DIC(194.4,+$P(^(0),"^",T),0)):$P(^DIC(195.2,X,0),"^",T),1:"") Q
 ;
PRT K RTBAR,RTQ,RTBC Q:'$D(^DIC(194.4,RTFMT,0))  S T=$P(^(0),"^",4)
 I $D(RTEST) F RTI=0:0 S RTI=$O(^DIC(194.4,RTFMT,1,RTI)) Q:RTI'>0  I $D(^(RTI,0)),$D(^DIC(194.5,+^(0),0)) S @$P(^(0),"^",5)=$P(^(0),"^",4) S:$P(^(0),"^",6)="y" RTBC=$P(^(0),"^",5)
 I '$D(RTEST) D TYPE G EXIT:RT0="" F RTI=0:0 S RTI=$O(^DIC(194.4,RTFMT,1,RTI)) Q:RTI'>0  I $D(^(RTI,0)) S RTJ=+^(0) I $D(^DIC(194.5,RTJ,0)) S:$P(^(0),"^",6)="y" RTBC=$P(^(0),"^",5) I $D(^("E")) X ^("E")
 F RTII=1:1:RTNUM W @IOF F RTI=0:0 S RTI=$O(^DIC(194.4,RTFMT,"E",RTI)) Q:RTI'>0  X ^DIC(194.4,RTFMT,"E",RTI,0)
 ;reverse video
 ;
 ;"bar1,bar0,barx"; flush for intermec RD
 I $D(RTBC) S RTON=$S($D(^%ZIS(2,IOST(0),"BAR1")):^("BAR1"),1:""),RTON=$S(RTON]"":RTON,1:"*0"),RTOFF=$S($D(^("BAR0")):^("BAR0"),1:""),RTOFF=$S(RTOFF]"":RTOFF,1:"*0"),X=@RTBC W @RTON,X,@RTOFF K RTON,RTOFF
EXIT F RTI=0:0 S RTI=$O(^DIC(194.4,RTFMT,1,RTI)) Q:RTI'>0  I $D(^(RTI,0)),$D(^DIC(194.5,+^(0),0)) K @$P(^(0),"^",5)
 I $D(RTBAR) S T=5,RTIFN=+RTQ,X=+$P(RT0,"^",3) D FMT G PRT:RTFMT
RD I $D(ION),ION["INTERMEC" F ZQ=0:0 R ZQ:0 Q:'$T
 K ZQ,RTCL,RT0,RTQ,T,RTI,RTII,RTIFN,RTNUM,RTFMT D:'$D(RTTASK) CLOSE^RTUTL Q
 ;
TYPE I T="r",$D(^RT(RTIFN,0)) D NOW^%DTC S $P(^(0),"^",8)=%,RT0=^(0),RTCL=$S($D(^RT(RTIFN,"CL")):^("CL"),1:"") Q
 I T="q",$D(^RTV(190.1,RTIFN,0)),$P(^(0),"^",6)'="x" D NOW^%DTC S $P(^(0),"^",13)=%,RTQ=^(0),RT0=$S($D(^RT(+RTQ,0)):^(0),1:0),RTCL=$S($D(^RT(+RTQ,"CL")):^("CL"),1:"") S:$S($P(RT0,"^",8):0,1:$D(^RTV(195.9,"AC",ION))>0) RTBAR="" Q
 I T="b",$D(^RTV(195.9,RTIFN,0)) S RT0=^(0) Q
 S RT0="" Q
 ;
 ;
Q I $S('$D(RTION):1,RTION']"":1,'$D(^%ZIS(1,"B",RTION)):1,'$D(^%ZIS(1,+$O(^(RTION,0)),0)):1,1:0) Q:$D(RTBKGRD)  D ZIS Q:POP  S RTION=ION,RTA=$O(^%ZIS(1,"B",ION,0)) N RTERR D CHKDEV G Q:RTERR I (^%ZIS(1,RTA,"TYPE")="VTRM") D ER G Q
 S RTVAR="RTIFN^RTNUM^RTFMT",RTVAL=RTIFN_"^"_RTNUM_"^"_RTFMT,RTW=$H
 X ^%ZOSF("UCI") S ZTRTN="DQ^RTL1",ZTUCI=Y,ZTDTH=$H,ZTSAVE("RTVAR")="",ZTSAVE("RTVAL")="" S:$D(DUZ(0)) ZTSAVE("DUZ(0)")=""
 ;
 S ZTDESC="Record Tracking Label Print"
 I '$D(RTTASK) S RTHG=$E(RTION,$L(RTION)-5,99),RTION=$S(RTHG'["RTHG":RTION,1:$E(RTION,1,$L(RTION)-1)_(1+($S($D(RTE):$S(RTE[";DPT(":+$P(^DPT(+RTE,0),"^",9)#2,1:+RTE#2),1:0)))) K RTHG
 S ZTIO=RTION
 D ^%ZTLOAD
 D HOME^%ZIS ;returns io to home device
 X:$D(RTMES)&('$D(RTBKGRD))&('$D(RTIRE)) RTMES H:$D(RTMES) 1 K RTW,RTVAR,RTVAL,ZTSK Q
 ;
DQ S IO(0)=IO
 F I=1:1 Q:$P(RTVAR,"^",I)']""  S @($P(RTVAR,"^",I))=$P(RTVAL,"^",I)
 S U="^" S X="T",%DT="" D ^%DT S DT=Y G PRT
 Q
 ;
ER W !!,*7,"You can not queue to a virtual terminal, try again."
 S RTION=""
 Q
 ;
ZIS S %ZIS("A")="Select Label Device: ",%ZIS="NQ" D ^%ZIS K %ZIS,IO("Q")
 Q
CHKDEV ; check that device can be queued to
 N RTDEV,RTSUB
 S RTERR=0
 S RTDEV=$G(^%ZIS(1,RTA,0))
 I $P(RTDEV,U,12)=2 S RTERR=1
 I $P(RTDEV,U)["SLAVE" S RTERR=1
 S RTSUB=+$G(^%ZIS(1,RTA,"SUBTYPE"))
 I RTSUB S RTSUB=$G(^%ZIS(2,RTSUB,0),U)
 I RTSUB["SLAVE" S RTERR=1
 I RTERR S RTION="" W !!,*7,"You cannot queue to this device, try again."
 Q
