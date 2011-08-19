PSJR0103 ;BIR/JLC-PRINT ORDERS WITH 'BAD' SCHEDULES ;07-JUN-04
 ;;5.0; INPATIENT MEDICATIONS ;**103**;16 DEC 97
 ;
 ;Reference to ^PS(50.7 is supported by DBIA# 2180.
 ;Reference to ^PS(52.6 is supported by DBIA# 1231.
 ;Reference to ^PS(52.7 is supported by DBIA# 2173.
 ;
EN I '$D(^XTMP("PSJSC")) W "Nothing on file." Q
 W ! K DIR S DIR(0)="F",DIR("A")="Print by Schedule or Patient",DIR("B")="S"
 S DIR("?")="Enter S to sort the list of orders by Schedule or P to sort by Patient" D ^DIR
 S Y=$TR(Y,"ps","PS") I Y'="P",Y'="S" W "Enter S to sort the list of orders by Schedule or P to sort by Patient" G EN
 I Y="^" G EXIT
 S PSJSORT=Y
SELDEV ;*** Ask for device type for report to output to ***
 K IOP,%ZIS,POP,IO("Q")
 W ! S %ZIS("A")="Select output device: ",%ZIS("B")="",%ZIS="Q"
 D ^%ZIS I POP W !,"** No device selected **" G EXIT
 W:'$D(IO("Q")) !,"this may take a while...(you should QUEUE this report)"
 I $D(IO("Q")) D  G EXIT
 . S XDESC="Problem Schedules on Orders"
 . S ZTRTN="START^PSJR0103"
 . K IO("Q"),ZTSAVE,ZTDTH,ZTSK
 . S ZTDESC=XDESC,PSGIO=ION,ZTIO=PSGIO,ZTDTH=$H,ZTSAVE("PSJSORT")="",%ZIS="QN",IOP=PSGIO
 . D ^%ZIS,^%ZTLOAD
 ;
START ;
 U IO K ^TMP("PSJR0103",$J) S PSJPAG=0 D NOW^%DTC S Y=$P(%,".") D DD^%DT S PSJDATE=Y
NSS D HDRN S PSJSCHD=""
 F  S PSJSCHD=$O(^XTMP("PSJSC","NSSON",PSJSCHD)) Q:PSJSCHD=""  D
 . S PSJPDFN=""
 . F  S PSJPDFN=$O(^XTMP("PSJSC","NSSON",PSJSCHD,PSJPDFN)) Q:PSJPDFN=""  D
 .. S PSJORD=""
 .. F  S PSJORD=$O(^XTMP("PSJSC","NSSON",PSJSCHD,PSJPDFN,"UD",PSJORD)) Q:PSJORD=""  S DRUG=^(PSJORD) D
 ... I PSJSORT="P" S ^TMP("PSJR0103",$J,PSJPDFN,"UD",PSJORD)=PSJSCHD_"^"_DRUG Q
 ... D:($Y+5)>IOSL HDR W PSJSCHD,?24,$P(^DPT(PSJPDFN,0),"^"),?51,$$GET1^DIQ(200,$P(DRUG,"^"),.01),?78,PSJORD,"U",?86,$P(^PS(50.7,$P(DRUG,"^",2),0),"^"),?118,$P(DRUG,"^",3),! Q
 .. F  S PSJORD=$O(^XTMP("PSJSC","NSSON",PSJSCHD,PSJPDFN,"IV",PSJORD)) Q:PSJORD=""  S DRUG=^(PSJORD) D
 ... I PSJSORT="P" S ^TMP("PSJR0103",$J,PSJPDFN,"IV",PSJORD)=PSJSCHD_"^"_DRUG Q
 ... D:($Y+5)>IOSL HDR W PSJSCHD,?24,$P(^DPT(PSJPDFN,0),"^"),"V",?51,$$GET1^DIQ(200,$P(DRUG,"^"),.01),?78,PSJORD,"V",?86,$S($P(DRUG,"^",2)="A":$P(^PS(52.6,$P(DRUG,"^",3),0),"^"),1:$P(^PS(52.7,$P(DRUG,"^",3),0),"^")),?118,$P(DRUG,"^",4),! Q
 G:PSJSORT="S" DAN
 S PSJPDFN=""
 F  S PSJPDFN=$O(^TMP("PSJR0103",$J,PSJPDFN)) Q:PSJPDFN=""  D
 . F TYP="UD","IV" S PSJORD="" D
 .. F  S PSJORD=$O(^TMP("PSJR0103",$J,PSJPDFN,TYP,PSJORD)) Q:PSJORD=""  S A=^(PSJORD) D
 ... D:($Y+5)>IOSL HDR S DRUG=$P(A,"^",3,99) W $P(^DPT(PSJPDFN,0),"^"),?28,$$GET1^DIQ(200,$P(A,"^",2),.01),?57,$P(A,"^"),?78,PSJORD D
 ... I TYP="UD" W "U",?86,$P(^PS(50.7,$P(DRUG,"^"),0),"^"),?118,$P(DRUG,"^",2),! Q
 ... W "V",?86,$S($P(DRUG,"^")="A":$P(^PS(52.6,$P(DRUG,"^",2),0),"^"),1:$P(^PS(52.7,$P(DRUG,"^",2),0),"^")),?118,$P(DRUG,"^",3),!
DAN D HDRD K ^TMP("PSJR0103",$J)
 S PSJSCHD=""
 F  S PSJSCHD=$O(^XTMP("PSJSC","DANON",PSJSCHD)) Q:PSJSCHD=""  D
 . S PSJPDFN=""
 . F  S PSJPDFN=$O(^XTMP("PSJSC","DANON",PSJSCHD,PSJPDFN)) Q:PSJPDFN=""  D
 .. S PSJORD=""
 .. F  S PSJORD=$O(^XTMP("PSJSC","DANON",PSJSCHD,PSJPDFN,"UD",PSJORD)) Q:PSJORD=""  S DRUG=^(PSJORD) D
 ... I PSJSORT="P" S ^TMP("PSJR0103",$J,PSJPDFN,"UD",PSJORD)=PSJSCHD_"^"_DRUG Q
 ... D:($Y+5)>IOSL HDRD W PSJSCHD,?24,$P(^DPT(PSJPDFN,0),"^"),?51,$$GET1^DIQ(200,$P(DRUG,"^"),.01),?78,PSJORD,"U",?86,$P(^PS(50.7,$P(DRUG,"^",2),0),"^"),?118,$P(DRUG,"^",3),! Q
 .. F  S PSJORD=$O(^XTMP("PSJSC","DANON",PSJSCHD,PSJPDFN,"IV",PSJORD)) Q:PSJORD=""  S DRUG=^(PSJORD) D
 ... I PSJSORT="P" S ^TMP("PSJR0103",$J,PSJPDFN,"IV",PSJORD)=PSJSCHD_"^"_DRUG Q
 ... D:($Y+5)>IOSL HDRD W PSJSCHD,?24,$P(^DPT(PSJPDFN,0),"^"),?51,$$GET1^DIQ(200,$P(DRUG,"^"),.01),?78,PSJORD,"V",?86,$S($P(DRUG,"^",2)="A":$P(^PS(52.6,$P(DRUG,"^",3),0),"^"),1:$P(^PS(52.7,$P(DRUG,"^",3),0),"^")),?118,$P(DRUG,"^",4),! Q
 G:PSJSORT="S" EXIT S PSJPDFN=""
 F  S PSJPDFN=$O(^TMP("PSJR0103",$J,PSJPDFN)) Q:PSJPDFN=""  D
 . F TYP="UD","IV" S PSJORD="" D
 .. F  S PSJORD=$O(^TMP("PSJR0103",$J,PSJPDFN,TYP,PSJORD)) Q:PSJORD=""  S A=^(PSJORD) D
 ... D:($Y+5)>IOSL HDRD S DRUG=$P(A,"^",3,99) W $P(^DPT(PSJPDFN,0),"^"),?28,$$GET1^DIQ(200,$P(A,"^",2),.01),?57,$P(A,"^"),?78,PSJORD D
 ... I TYP="UD" W "U",?86,$P(^PS(50.7,$P(DRUG,"^"),0),"^"),?118,$P(DRUG,"^",2),! Q
 ... W "V",?86,$S($P(DRUG,"^")="A":$P(^PS(52.6,$P(DRUG,"^",2),0),"^"),1:$P(^PS(52.7,$P(DRUG,"^",2),0),"^")),?118,$P(DRUG,"^",3),!
EXIT ;
 K %,%H,%I,%ZIS,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTRTN
 W:$E(IOST)="C"&($Y) @IOF
 S:$D(ZTQUEUED) ZTREQ="@"
 S IOP="HOME" D ^%ZISC
 Q
HDRN D HDR W ?55,"Non-Standard Schedules",!! I PSJSORT="S" W "Schedule",?24,"Patient",?51,"Provider",?78,"Order",?86,"OI/Additive/Sol",?118,"Dos/Str/Vol",!! Q
 W "Patient",?28,"Provider",?57,"Schedule",?78,"Order",?86,"OI/Additive/Sol",?118,"Dos/Str/Vol",!! Q
HDRD D HDR W ?54,"Dangerous Abbreviations",!! I PSJSORT="S" W "Schedule",?24,"Patient",?51,"Provider",?78,"Order",?86,"OI/Additive/Sol",?118,"Dos/Str/Vol",!! Q
 W "Patient",?28,"Provider",?57,"Schedule",?78,"Order",?86,"OI/Additive/Sol",?118,"Dos/Str/Vol",!! Q
HDR W:$Y @IOF S PSJPAG=PSJPAG+1
 W PSJDATE,?47,"Inpatient Medications Schedule Issues",?120,"PAGE: ",PSJPAG,!!
 Q
