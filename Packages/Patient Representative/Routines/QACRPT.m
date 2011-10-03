QACRPT ;HISC/RS,CEW - Print report of contact ;1/17/95  13:06
 ;;2.0;Patient Representative;**3,5,6,9**;07/25/1995
 K DIC
 N QACAUTH S QACAUTH=0
 S DIC="^QA(745.1,",DIC(0)="AEMQZ",DIC("A")="Enter the Contact you wish to generate: "
 ;see if user has QAC EDIT security key, or initially entered the ROC
 I $D(^XUSEC("QAC EDIT",DUZ))#2 S QACAUTH=1
 S DIC("S")="I $G(QACAUTH)!(DUZ=$P(^QA(745.1,+Y,0),U,7))"
 D ^DIC K DIC Q:Y<0  S QAC=+Y
 ;only holders of QAC EDIT security key may see Resolution Comments
 I $G(QACAUTH)=1 K DIR S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you want the Resolution Text included " D ^DIR K DIR Q:$D(DIRUT)  S QACRES=+Y D EN G QACRPT
EN K %ZIS,IOP S %ZIS="MQ"
 W ! D ^%ZIS G:POP QUIT
 I $D(IO("Q")) D  G QUIT
 . K IO("Q")
 . S ZTDESC="Report of Contact"
 . S ZTRTN="START^QACRPT"
 . S (ZTSAVE("QAC"),ZTSAVE("QACRES"))=""
 . D ^%ZTLOAD
START U IO
START1 ;called from QACALRT1 for screen display of ROC for alert
 S QACDA0=$G(^QA(745.1,QAC,0)),QACDA2=$G(^QA(745.1,QAC,2)),QACO=0
 S QACSTR="1,2,3,12,0,10,0,7,8,0,9,6,0,0",QACQUIT=0
 F J=1,2,3,12,8,9,6,4 S QACO($P(QACSTR,",",J))=$P(QACDA0,"^",J)
 I QACO(3)'="" S QACO(4)=$P($G(^DPT(QACO(3),0)),"^",9),QACO(3)=$P($G(^DPT(QACO(3),0)),"^",1)
 E  S QACO(4)=""
 S QACO(5)=$P(QACDA2,"^",2)
 S X1=$P(QACDA2,"^",4),X2=+$P(QACDA2,"^",5) I X1 D C^%DTC I X S Y=X X ^DD("DD") S QACO(9)=Y
 I $G(QACO(9))']"" S QACO(9)="    "
HEADING ;This is for the display of data
 W:$E(IOST)="C" @IOF
 W !!,"** This information is not for the Patient Record **"
 W !!,?28,"Report of Contact" S Y=DT D DD^%DT W ?60,"Date: ",Y,!
 S N1=0 F  S N1=$O(QACO(N1)) Q:N1=""  S QACDATA=QACO(N1) D
 .S FLD=N1*10\1,TEXT=$P($T(@FLD),";;",2),TAB=$P(TEXT,"^"),LINE=$P(TEXT,"^",2),CODE=$P(TEXT,"^",3,99)
 .W:TAB=0 !
 .W ?TAB,LINE
 .X CODE
 .Q
 I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE G QUIT:QACQUIT
SOURCE ; Display either old Source of Contact field or new Sources(s) of
 ; Contact multiple field.
 N JJ,QACSOUR,QACSOURC
 W ?45,"Source of Contact:"
 S QACSOUR=$P($G(^QA(745.1,QAC,0)),U,11)
 I $G(QACSOUR)]"" D
 . W $S(QACSOUR="L":"Letter",QACSOUR="W":"Ward Visit",QACSOUR="V":"Visit",QACSOUR="P":"Phone",1:"")
 I $D(^QA(745.1,QAC,12,0)) D
 . S JJ=0
 . F  S JJ=$O(^QA(745.1,QAC,12,JJ)) Q:JJ'>0  D
 . . S QACSOURC=^QA(745.1,QAC,12,JJ,0)
 . . W ?63,$S(QACSOURC="L":"Letter",QACSOURC="W":"Ward Visit",QACSOURC="V":"Visit",QACSOURC="P":"Phone",QACSOURC="I":"Internet",1:""),!
REFER S QACO(12)=0
 W !,"Refer To:" F  S QACO(12)=$O(^QA(745.1,QAC,11,QACO(12))) Q:QACO(12)'>0  D
 . S QACREFER=$P($G(^QA(745.1,QAC,11,QACO(12),0)),U,1)
 . W ?19,$P($G(^VA(200,QACREFER,0)),U,1),!
WORDP1 G WORDP2:'$D(^QA(745.1,QAC,4,0))!(QACQUIT)
 W !!,"Issue Text:" K ^UTILITY($J,"W") S DIWL=4,DIWR=75,DIWF=""
 F N1=0:0 S N1=$O(^QA(745.1,QAC,4,N1)) Q:N1'>0  S X=^QA(745.1,QAC,4,N1,0) D ^DIWP
 F N1=0:0 S N1=$O(^UTILITY($J,"W",DIWL,N1)) Q:N1'>0!QACQUIT  D
 .W !,?3,^UTILITY($J,"W",DIWL,N1,0) I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE Q:QACQUIT  D HEAD
WORDP2 G QUIT:'$D(^QA(745.1,QAC,6,0))!(QACQUIT)!($G(QACRES)'=1)
 W !!,"Resolution:" K ^UTILITY($J,"W") S DIWL=4,DIWR=75,DIWF=""
 F N1=0:0 S N1=$O(^QA(745.1,QAC,6,N1)) Q:N1'>0  S X=^QA(745.1,QAC,6,N1,0) D ^DIWP
 F N1=0:0 S N1=$O(^UTILITY($J,"W",DIWL,N1)) Q:N1'>0!QACQUIT  D
 .W !,?3,^UTILITY($J,"W",DIWL,N1,0) I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE Q:QACQUIT  D HEAD
QUIT W ! D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K ^UTILITY($J),DIR,DIC,DIWF,DIWL,DIWR,CODE,N1,POP,QAC,QACO,QACDA0
 K QACDA2,QACDATA,QACSTR,QACIS,QACQUIT,TEXT,TAB,LINE,FLD,N1,N2,J,X,Y
 K ZTDESC,ZTRTN,ZTSAVE,%ZIS,%,C,QACRES,%DTC,X1,Y1,X2,QACREFER,DIRUT
 Q
PAUSE ;
 W !! K DIR S DIR(0)="E" D ^DIR S QACQUIT=$S(Y'>0:1,1:0)
 Q
HEAD ;
 W @IOF,!!,"** This information is not for the Patient Record **"
 W !!,?20,"Report of Contact continued" S Y=DT D DD^%DT W ?60,"Date: ",Y,!
 F N2=1:1:4 S:$D(QACO(N2)) QACDATA=QACO(N2) D
 .I QACDATA="" W !! Q
 .S FLD=N2*10\1,TEXT=$P($T(@FLD),";;",2),TAB=$P(TEXT,"^"),LINE=$P(TEXT,"^",2),CODE=$P(TEXT,"^",3,99)
 .W:TAB=0 !
 .W ?TAB,LINE
 .X CODE
 .Q
 W !! Q
TEXT ;
10 ;;0^Contact Number:^W ?19,QACDATA
20 ;;45^Date of Contact:^S Y=QACDATA D DD^%DT S QACDATA=Y W ?63,QACDATA
30 ;;0^Patient Name:^W ?19,QACDATA
40 ;;45^Patient SSN:^W ?63,QACDATA
50 ;;0^Treatment Status:^W ?19,$S(QACDATA="I":"Inpatient",QACDATA="O":"Outpatient",QACDATA="D":"Domiciliary",QACDATA="N":"NHCU",QACDATA="L":"Long Term Psych",QACDATA="E":"Extended/Intermediate Care",QACDATA="H":"HBHC",1:"")
60 ;;45^Location of Event:^W ?63,$P($G(^SC(+QACDATA,0)),"^",1)
70 ;;0^Name of Contact:^W ?19,QACDATA
80 ;;45^Phone of Contact:^W ?63,QACDATA
90 ;;0^Date Due:^W ?19,QACDATA
100 ;;45^Info taken by:^W ?63,$P($G(^VA(200,+QACDATA,0)),"^",1)
120 ;;0^Elig. Status:^W ?19,$G(QACDATA)
