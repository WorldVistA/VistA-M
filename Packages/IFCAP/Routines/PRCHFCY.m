PRCHFCY ;WISC/KMB/CR-ENTRY ACTION FOR FINAL CHARGE YES REPORT  6/09/98
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 N AA,J,ORIG,OUT,REM,STA,START,STR,STR1,TIMES,VALUE,XXZ,EN,END,FIN,I,COUNT
 S XXZ="",CCHECK="####"
 S (COUNT,I)=0 F  S I=$O(^PRC(440.5,"C",DUZ,I)) Q:I=""  D
 .Q:$P($G(^PRC(440.5,I,2)),U,2)="Y"
 .S COUNT=COUNT+1,STR=$P($G(^PRC(440.5,I,0)),"^",1),STR1=$P($G(^PRC(440.5,I,0)),"^",11)
 .S AA(DUZ,COUNT)=STR_"^"_STR1_"^"_I
 I COUNT=0 W !,"You are not a purchase card holder." QUIT
 S REM=COUNT#20,END=COUNT-REM,TIMES=END/20
READ ;
 S VALUE=0 R !,"Enter Purchase Card Name: ",XXZ:200
 D LOOK1^PRCSPC
 I XXZ="^" QUIT
 I XXZ="" W !,"Invalid entry." G READ
 I +XXZ<1 W !,"Invalid entry." G READ
 I $G(AA(DUZ,XXZ))="" W !,"This card is not registered to you." G READ
 S CCHECK=$P(AA(DUZ,XXZ),"^") W "    ",$P(AA(DUZ,XXZ),"^",2)
 ;
 QUIT
 ;
ASK ;ask user if they wish to print data for all purchase cards,
 ;inactive cards, or active cards
 W !,"Please select the type of purchase cards you wish to display:",!!
 S DIR(0)="S^A:Active;I:Inactive;B:Both",DIR("A")="TYPE" D ^DIR K DIR Q:Y["^"
 S TYPE=Y QUIT
ASK1 ;
 N SCREEN S SCREEN="I $P($G(^PRC(440.5,D0,2)),""^"",2)"
 S:TYPE="B" TYPE=SCREEN_"[""""" S:TYPE="I" TYPE=SCREEN_"=""Y""" S:TYPE="A" TYPE=SCREEN_"'=""Y"""
 S DIS(0)=TYPE
 QUIT
 ;
OFFI ;get official or alternate for Unreconciled Austin Transactions
 ;Report
 W !! S DIC(0)="AEMQ",DIC="^VA(200," D ^DIC
 S ENTRY=+Y K Y,DIC QUIT
 ;
FIND ;find PC official or alternate for card on CC record
 Q:'$D(D0)
 N SET1,SET2 S (SET3,SET4)=""
 S SET1=$P($G(^PRCH(440.6,D0,0)),"^",4) Q:SET1=""  S SET2=$O(^PRC(440.5,"B",SET1,0))
 I $P($G(^PRC(440.5,+SET2,0)),"^",9)=ENTRY D  Q
 .S SET3=$P($G(^PRC(440.5,+SET2,0)),"^",9),SET4=$P($G(^VA(200,SET3,0)),"^")
 I $P($G(^PRC(440.5,+SET2,0)),"^",10)=ENTRY D
 .S SET3=$P($G(^PRC(440.5,+SET2,0)),"^",10),SET4=$P($G(^VA(200,SET3,0)),"^")
 QUIT
