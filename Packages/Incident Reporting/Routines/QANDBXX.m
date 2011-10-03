QANDBXX ;GJC/HISC-Database Checker ;4/1/92
 ;;2.0;Incident Reporting;;08/07/1992
 ;
 S (QANFLG,QANPG,QANXIT)=0
 S QANHD1="Quality Assurance Database Integrity Checker"
 S QANHD2="Incident Reporting Version 2.0"
 S QANHD3="No evidence of database corruption found."
 S $P(QANLINE,"*",81)=""
DEV ;Select Device
 K IOP,%ZIS S %ZIS("A")="Print on Device: ",%ZIS="MQ" W ! D ^%ZIS W !!
 G:POP KILL
 I $D(IO("Q")) S ZTRTN="START^QANDBXX",ZTDESC="IR database report",ZTSAVE("QAN*")="" D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued.",1:"Request Cancelled."),! G EXIT
START U IO D HDR
 F QA=0:0 S QA=$O(^QA(742,"BCS",QA)) Q:QA'>0  D CASE Q:QANXIT
 W !?(IOM-$L(QANHD3)\2),$S('QANFLG:QANHD3,1:"")
EXIT ;Exit
 W ! D ^%ZISC,HOME^%ZIS
KILL ;Kill and quit
 K %H,%ZIS,IZ,POP,QANFLG,QANHD1,QANHD2,QANHD3,QANLINE,QANPG,QANXIT,ZTSK
 K D,QA,QAN742,QAN7424,QANCS,QB,TODAY,X,Y,ZTDESC,ZTRTN,ZTSAVE
 Q
CASE ;Case Number information
 S QAN7424=$G(^QA(742.4,QA,0))
 S QANCS(1)=$P(QAN7424,U),QANCS(2)=$P(QAN7424,U,2),QANCS(3)=$P(QAN7424,U,3)
 I QAN7424']"" W !,"Incident Record Number: ",QA," does NOT have data associated with the record!" D:$Y>(IOSL-4) HDH Q:QANXIT
 I QANCS(1)']"" W !,"Incident Record Number: ",QA," does NOT have a Case Number associated with the",!,"record!" D:$Y>(IOSL-4) HDH Q:QANXIT
 I QANCS(2)']"" W !,"Incident Record Number: ",QA," does NOT have a Incident associated with the record!" D:$Y>(IOSL-4) HDH Q:QANXIT
 I QANCS(3)']"" W !,"Incident Record Number: ",QA," does NOT have a Incident Date associated with the",!,"record!" D:$Y>(IOSL-4) HDH Q:QANXIT
 F QB=0:0 S QB=$O(^QA(742,"BCS",QA,QB)) Q:QB'>0  D PAT Q:QANXIT
 Q
PAT ;Patient Information
 S QAN742=$G(^QA(742,QB,0))
 I QAN742']"" W !,"Patient Record Number: ",QB," does NOT have data associated with the record!" D:$Y>(IOSL-4) HDH Q:QANXIT
 I '$D(^QA(742.4,"ACN",QB,QA)) S QANFLG=1 W !,"'ACN' x-ref missing for Patient Record: ",QB," Incident Record: ",QA D:$Y>(IOSL-4) HDH Q:QANXIT
 S QANCS(4)=$P(QAN742,U),QANCS(5)=$P(QAN742,U,2),QANCS(6)=$P(QAN742,U,3)
 I QANCS(4)']"" S QANFLG=1 W !,"Patient Record Number: ",QA," does NOT have a Patient associated with the record!" D:$Y>(IOSL-4) HDH Q:QANXIT
 I QANCS(5)']"" S QANFLG=1 W !,"Patient Record Number: ",QA," does NOT have a Patient ID associated with the record!" D:$Y>(IOSL-4) HDH Q:QANXIT
 I QANCS(6)']"" S QANFLG=1 W !,"Patient Record Number: ",QA," does NOT have a Incident associated with the record!" D:$Y>(IOSL-4) HDH Q:QANXIT
 Q
HDH ;Header Prompt
 I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 QANXIT=1 Q:QANXIT
HDR ;Header
 W @IOF
 S QANPG=QANPG+1,%H=$H D YX^%DTC S TODAY=Y
 W ?69,"Page: ",QANPG,!?58,TODAY,!!
 W ?(IOM-$L(QANHD1)\2),QANHD1,!?(IOM-$L(QANHD2)\2),QANHD2,!!
 F IZ=1:1:2 W QANLINE,!
 W !
 Q
