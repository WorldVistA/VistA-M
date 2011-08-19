SOWKDB ;B'HAM ISC/SAB,DLR - ROUTINE TO PRODUCE DATA BASE ASSESSMENT PROFILE ; 23 Feb 94 / 12:23 PM
 ;;3.0;Social Work;**17,23,63**;27 Apr 93
 ;External reference to ^DGPM supported by DBIA 419
 ;
 K DIC S DIC="^SOWK(655.2,",DIC(0)="AEQMZ",DIC("A")="Select Patient: " D ^DIC G:"^"[X CL G:Y<0 SOWKDB S (DFN,DA)=+Y K DIC
EN K ZTSK,%ZIS,IOP S SOWKION=ION,%ZIS="QM" D ^%ZIS K %ZIS I POP S IOP=SOWKION D ^%ZIS K IOP,SOWKION,DIC,DA,DFN,Y,X G CL
 K SOWKION I $D(IO("Q")) K IO("Q") S ZTRTN="ENQ^SOWKDB",ZTDESC="Data Base Assessment Profile" F G="Y(0)","DA","DFN","Y(0,0)" S:$D(@G) ZTSAVE(G)=""
 I  D ^%ZTLOAD I '$D(ZTSK) W:$E(IOST)'["C" @IOF D ^%ZISC K ZTDESC,DFN,ZTRTN,ZTSAVE,DIC,POP,G,X,Y,DA Q
 I $D(ZTSK) W:$E(IOST)'["C" @IOF D ^%ZISC K DA,DFN,X,Y,ZTSAVE,DIC,POP,ZTSK,ZTRTN W !!,"Task Queued to Print",!! Q
ENQ K ^TMP($J) S DIWL=10,DIWR=75,DIWF="WN",(VARRAY("DEM"),VARRAY("INP"),VARRAY("ADD"),VARRAY("OPD"),VARRAY("MB"),VARRAY("ELIG"),VARRAY("SVC"))="" D SEL^VADPT,PID^VADPT6
 S ADM=+VAIN(7),G=$S(ADM:9999999.9999999-ADM,1:0)
 S G=+$O(^DGPM("ATID1",DFN,G)),L=+$O(^DGPM("ATID1",DFN,G,0)) S PRD=$S(L:$P(^DGPM(L,0),"^"),1:"NONE"),ADM=$S(ADM:$P(VAIN(7),"^",2),PRD:"DISCHARGED",1:"UNAVAILABLE")
 I PRD S Y=PRD X ^DD("DD") S PRD=Y
 S Y=DT X ^DD("DD") S PG=0 U IO D HDR^SOWKDB1
 W !!?23,"SOCIAL WORK DATA BASE/ASSESSMENT",!,"Date Printed: "_Y,!,"Source of Referral: "_$P(^SOWK(655.2,DFN,0),"^",21)
 W !,"Source of Information: "_$S($D(^SOWK(655.2,DFN,18)):$P(^SOWK(655.2,DFN,18),"^"),1:"UNSPECIFIED")
 S Y=$P(^SOWK(655.2,DFN,0),"^",24) X ^DD("DD") W !,"Referral Date: "_Y,!!,"I.",?5,"Demographic",!?5,"1.  Date of Admission: "_ADM,!?5,"2.  Date of Previous Admission: "_PRD D CHK G:$G(SWX)["^" CL W !?5,"3.  Veteran's Home Address:"
 W:VAPA(1)]"" !?9,VAPA(1)_" "_VAPA(2)_" "_VAPA(3)_" "_VAPA(4)_", "_$P(VAPA(5),"^",2)_" "_VAPA(6) W:VAPA(1)']"" " PATIENT ADDRESS UNAVAILABLE"
 D CHK G:$G(SWX)["^" CL W !?5,"4.  Veteran's Telephone:  HOME #: "_VAPA(8) S VAOA("A")=5 D OAD^VADPT D CHK G:$G(SWX)["^" CL W ?57," WORK #: "_VAOA(8) K VAOA
 D OAD^VADPT D CHK G:$G(SWX)["^" CL W !?5,"5.  Next-of-kin: "_$S(VAOA(9)]"":VAOA(9)_" / "_VAOA(10),1:"UNSPECIFIED"),!?9,"ADDRESS:"
 W:VAOA(1)]"" VAOA(1)_" "_VAOA(2)_" "_VAOA(3),!?9,VAOA(4)_", "_$P(VAOA(5),"^",2)_" "_VAOA(6) D CHK G:$G(SWX)["^" CL W !?8," HOME #: "_VAOA(8),?38 K VAOA S VAOA("A")=6 D OAD^VADPT D CHK G:$G(SWX)["^" CL W "WORK #: "_VAOA(8)
 D CHK G:$G(SWX)["^" CL W !?5,"6.  Veteran's date of birth: "_$P(VADM(3),"^",2),!?5,"7.  Veteran's place of birth: " W $S(VAPD(1)]"":VAPD(1)_", "_$P(VAPD(2),"^",2),1:"UNSPECIFIED") S ST=$S(+VAPD(7):$P(VAPD(7),"^",2),1:"UNSPECIFIED")
 D CHK G:$G(SWX)["^" CL W !?5,"8.  Veteran's sex: "_$P(VADM(5),"^",2)
 ;--------- ethnicity/race retrieval and display
 K ERT,SEQ
 S (ERT,SEQ)=""   ;ERT=ethnicity race type;display multiple for both
 I $D(VADM(11)) I VADM(11)>0 S SEQ=SEQ+1,ERT(SEQ)="" D
 . F I=1:1 Q:'$D(VADM(11,I))  I $TR($P(VADM(11,I),"^",2),"")'="" D
 .. ;length of race or ethnicity; plus 25 characters for field label; plus length of data to be added to the field; minus 2 char for comma and space; up to 80 characters.
 .. I ($L(ERT(SEQ))+25+$L($P(VADM(11,I),"^",2))-2)'>80 D  Q
 ... S ERT(SEQ)=ERT(SEQ)_", "_$P(VADM(11,I),"^",2)
 .. I ($L(ERT(SEQ))+25+$L($P(VADM(11,I),"^",2))-2)>80 D
 ... S ERT(SEQ)=ERT(SEQ)_",",SEQ=SEQ+1,ERT(SEQ)=""
 .. S ERT(SEQ)=ERT(SEQ)_", "_$P(VADM(11,I),"^",2)
 S:'$D(ERT(1)) ERT(1)=", UNANSWERED"
 W !?5,"9.  Veteran's ethnicity: "_$E(ERT(1),3,999)
 I SEQ>1 F I=2:1:SEQ W !?30,$E(ERT(I),3,999)
 K ERT S (ERT,SEQ)=""
 I $D(VADM(12)) I VADM(12)>0 S SEQ=SEQ+1,ERT(SEQ)="" D
 . F I=1:1:VADM(12) Q:'$D(VADM(12,I))  I $TR($P(VADM(12,I),"^",2),"")'="" D
 .. I ($L(ERT(SEQ))+25+$L($P(VADM(12,I),"^",2))-2)'>80 D  Q
 ... S ERT(SEQ)=ERT(SEQ)_", "_$P(VADM(12,I),"^",2)
 .. I ($L(ERT(SEQ))+25+$L($P(VADM(12,I),"^",2))-2)>80 D
 ... S ERT(SEQ)=ERT(SEQ)_",",SEQ=SEQ+1,ERT(SEQ)=""
 .. S ERT(SEQ)=ERT(SEQ)_", "_$P(VADM(12,I),"^",2)
 S:'$D(ERT(1)) ERT(1)=", UNANSWERED"
 W !?5,"10. Veteran's race: "_$E(ERT(1),3,999)
 I SEQ>1 F I=2:1:SEQ W !?25,$E(ERT(I),3,999)
 K ERT,SEQ
 D CHK G:$G(SWX)["^" CL W !?4,"11.  Veteran's religious preference: "_$P(VADM(9),"^",2),!!,"II.  Employment/Financial",!?5,"1.  Veteran's employment status: "_ST
 D ^SOWKDB1
CL W:$E(IOST)'["C" @IOF D ^%ZISC K SWX,SWXX,C,DIC,DIWL,DIWR,DIWF,X,DA,DFN,Y S:$D(ZTQUEUED) ZTREQ="@"
 K %I,ADM,E,G,L,PG,PRD,Q,ST,TI,W D KVA^VADPT
 Q
TR W "Veteran's Name: "_VADM(1),!,"ID#: "_VA("PID"),!,"WARD NO.: "_$P(VAIN(4),"^",2),!,"BED-SECTION: "_$P(VAIN(5),"^")
 W ?30,$P(^VA(200,$P(^SOWK(655.2,DFN,0),"^",3),20),"^",2)_", Social Worker",!!!!?25,"Social Work Service Reports and Summaries",!?25,"10-9034 VAF VICE 10-1349",!
 Q
CHK I $E(IOST)["C",$Y+5>IOSL R !!,"PRESS RETURN TO CONTINUE or '^' TO EXIT: ",SWX:DTIME W @IOF S:SWX["^"!'$T SWXX=1 Q
 Q:$E(IOST)["C"
 I ($Y+15)>IOSL W !! D TR,HDR^SOWKDB1
 Q
