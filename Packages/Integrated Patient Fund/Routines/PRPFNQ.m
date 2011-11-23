PRPFNQ ;ALTOONA/CTB-PATIENT FUNDS MULTIPLE CARD DRIVER ;15 APR 02
V ;;3.0;PATIENT FUNDS;**3,5,6,7,13**;JUNE 1, 1989
 N BDATE W *7,!,"REMEMBER, this option requires a printer with a line length of at least",!,"132 characters and a page length of at least 62 lines.",!
 W !!,"Enter the names(s) of cards required, one at a time.  "
 S LIST=1
 S DIC("A")="Select PATIENT NAME: "
A S DIC=470,DIC(0)="AEQM" D ^DIC K DIC("A") I +Y>0  D ADD S DIC("A")="Select Next PATIENT NAME: " G A
 K DIC
 I $D(LIST)'=11 W !,*7,"No cards selected, Option is Terminated! " R X:3 K IOP D OUT Q
 D DATE IF $D(DTOUT)!($D(DUOUT))!($D(DIROUT)) K BDATE,DTOUT,DUOUT,DIROUT D OUT Q
 S ZTDESC="PRINT SELECTED PATIENT FUND CARDS",ZTSAVE("DIC")="^PRPF(470," S:$D(BDATE) ZTSAVE("BDATE*")="",ZTRTN="DQ^PRPFNQ",ZTSAVE("LIST*")="" D ^PRPFQ
 K LIST,%Y,Y
 QUIT
ADD NEW X
 I $L($G(LIST(LIST))_+Y)>240 S LIST=LIST+1
 S LIST(LIST)=$G(LIST(LIST))_+Y_"^"
 QUIT
DQ K ^TMP("PRPFAD",$J)
 F I=1:1:LIST F J=1:1 S N=$P(LIST(I),"^",J) Q:'N  S ^TMP("PRPFAD",$J,N)=""
 S DIC="^PRPF(470,"
 S IOP=PRIOP
 S BY=".01",(FR,TO)="",BY(0)="^TMP(""PRPFAD"",$J,",FLDS="[PRPF CARD]",L=0,L(0)=1,DIOEND="K ^TMP(""PRPFAD"",$J)"
 D EN1^DIP D OUT
 Q
DATE ;IF PARTIAL LIST IS REQUESTED, ASK EARLIEST DATE  ELSE S DATE=01/01/1900
 S DIR(0)="SA^A:ALL;P:PARTIAL",DIR("A")="Partial List or All Tranactions: ",DIR("B")="ALL"
 S DIR("?")="You may enter (A)LL or (P)ARTIAL",DIR("?",1)="Selecting PARTIAL will allow you to print only those transactions",DIR("?",2)="starting with the date you select."
 D ^DIR K DIR IF $D(DTOUT)!($D(DUOUT))!($D(DIROUT)) Q
 S BDATE=2000101,X=BDATE D CNVD^PRPFQ S BDATE1=X I Y="A" QUIT
 S DIR(0)="DOA^:DT:EX",DIR("A")="Select Earliest Date to Print on Cards: ",DIR("?")="^D HELP^PRPFNQ" D ^DIR K DIR
 IF $D(DTOUT)!($D(DUOUT))!($D(DIROUT)) Q
 IF Y>0 S BDATE=+Y-1,X=+Y D CNVD^PRPFQ S BDATE1=X
 QUIT
DOIT S DIC="^PRPF(470,",L=0,(FLDS,BY)="[PRPF RANGE OF CARDS]" D EN1^DIP
 Q
ALL ;PRINT ALL CARDS
 S %A="This option will print a card for each ACTIVE patient, or for ALL patients,",%A(1)="   regardless of status, within the range selected."
 S %A(2)="Are you sure that you want to run this option now"
 S %B="A 'Yes' will begin the job, after you select a device.  Remember,"
 S %B(1)="this job will take a while to run.  Enter an '^' to terminate the option." D ^PRPFYN Q:%'=1
 D DATE IF $D(DTOUT)!($D(DUOUT))!($D(DIROUT)) K BDATE,BDATE1,DTOUT,DUOUT,DIROUT D OUT Q
 S %A="Do you wish to print only the ACTIVE cards",%B="",%=1 D ^PRPFYN Q:%<0  W !!,"I will now print a card for ",$S(%=1:"ALL ACTIVE ",1:"ALL")," cards."
 K DIS(0) I %=1 S DIS(0)="I $P(^PRPF(470,D0,0),U,2)=""A"""
 S M="PATIENT" D RNG^PRPFQ I '$D(FR)!('$D(TO)) D OUT Q
 S BY="[PRPF RANGE OF CARDS]",%=1,%A="OK TO CONTINUE",%B="" D ^PRPFYN Q:%'=1
 S DIC="^PRPF(470,",L=0,FLDS="[PRPF CARD]" D EN1^DIP
OUT K %,%DT,%H,%I,%W,%X,BDATE,BDATE1,DCC,DFN,DGA1,DG1,DGT,DGX,DIJ,DIOEND,DIOP,DIPT,DIR,DISH,DIYS,DP,F,FLDS,IOX,IOY,L,O,POP,MTR,PAGE,PRPFKEY,PRPFRNG,PRPFRNG2,PTR,W,X,ZTSK
 QUIT
RESEARCH ;;SEARCH OF PATIENT FUNDS FOR DATES OF RESTRICTION OVER 6 MONTHS OLD
 ;HITS ARE STORED IN THE AK CROSSREFERENCE
 D SELRNG^PRPFQ
 I PRPFRNG="" D OUT QUIT
 I PRPFRNG="@" S PRPFRNG2=""
 E  S PRPFRNG2=PRPFRNG
 S ZTSAVE("PRPFRNG")=PRPFRNG,ZTSAVE("PRPFRNG2")=PRPFRNG2
 S ZTRTN="DQRES^PRPFNQ",ZTDESC=$P($T(RESEARCH),";",3) D ^PRPFQ,OUT Q
DQRES ;DQ POINT FOR RESTRICTION SEARCH
 I $D(ZTQUEUED) S IOP=PRIOP,ZTREQ="@"
 K ^TMP("PRPFAK",$J)
 S X="T-181",%DT="" D ^%DT
 S X="Please hold on, I'm searching the file now.*" D MSG^PRPFQ
 S DA=0 F  S DA=$O(^PRPF(470,DA)) Q:'DA  S X=$P($G(^PRPF(470,DA,0)),"^",12) I X]"",X<Y S ^TMP("PRPFAK",$J,DA)=""
 I $D(^TMP("PRPFAK",$J))<9 S X="No matches found today.*" D MSG^PRPFQ G OUTR
 S:$D(PRIOP) IOP=PRIOP S DIC="^PRPF(470,",L=0,L(0)=1,BY="@73:99;S,.01",BY(0)="^TMP(""PRPFAK"",$J,",FLDS="[PRPF OVERDUE PRINT",FR=""_PRPFRNG_"",TO=""_PRPFRNG2_""
 S DIOEND="K ^TMP(""PRPFAK"") W !,""The information contained in this report is protected by the Privacy Act of 1974"""
 S:PRPFRNG="@" BY="@73,@73:99,.01",FR="@,@",TO=","
 D EN1^DIP
OUTR ;
 K IOP,PRIOP,PFM,T5,^TMP("PRPFAK",$J) D DIKILL^PRPFQ G ZTKILL^PRPFQ
 Q
HELP W !,"If you enter a date, ALL entries on the card, before that date",!,"  will be consolidated.",! D HELP^%DTC Q
