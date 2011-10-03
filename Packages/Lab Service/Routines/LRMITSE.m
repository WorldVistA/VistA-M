LRMITSE ;SLC/STAFF - MICRO TREND ENTRY ;3/4/93  17:07
 ;;5.2;LAB SERVICE;**96,257**;Sep 27, 1994
 ; from LRMITS
 ; collect input data for trend report
 ; LRAP(drug node)=organism #  if antibiotic pattern defined
 ; LRDETAIL  detailed report with patient results
 ; LREND  flag to end program
 ; LRHELP  help frame
 ; LRLOS  length of stay
 ; LRMERGE  none/spec/col sample/any  "N"/"S"/"C"/"A"
 ; LRM(type of report,"A")="" all values
 ; LRM(type of report,"S",value #)=value name  selected values
 ; LROTYPE(type of organism)=""  organism types  "B"/"F"/"M"/"P"/"V"
 ; LRSORG(type of organism,organism #)=""  if specific organisms selected
 ; LRSORT Defines antibiotic reporting order by alph or print order
 ; LRSUSR(interp)=""  interpretations forced to 'R'
 ; LRSUSS(interp)=""  interpretations forced to 'S'
 ; LRUNK  "Unknown" - used for any value
 ; LRTBEG  begin time
 ; LRTEND  end time
 ;
 W @IOF,?30,"MICROBIOLOGY TREND REPORT",!
 ; initialize variables and defaults
 K LRAP,LRM,LROTYPE,LRSORG,LRSUSR,LRSUSS
DIV ;MULTIDIVISIONAL PATCH LR*5.2*257 - 3/01
 ;ASK IF WANT REPORT BY DIVISION
 S LRASK="DIV",LRHELP="LRMITS OPTION"
 W !!,"Report by: DIVISION"
 S LRPX=$S($D(LRM(LRASK,"A")):"All",1:"No") K DIC,DIR,LRM(LRASK)
 S DIR(0)="SAM^A:All;S:Selected;N:No",DIR("A")="(A)ll Divisions, (S)elected Divisions, or (N)o Division Report? ",DIR("B")=LRPX
 S DIR("?")="Enter 'A'll, 'S'elected, or 'N'o.",DIR("??")=LRHELP
 S DIR("?",1)="Select 'A' to obtain a report grouped by all divisions."
 S DIR("?",2)="Select 'S' to obtain a report grouped for selected divisions."
 S DIR("?",3)="Select 'N' if you DO NOT want a report grouped by division."
 S DIR("?",4)="Enter '^' to exit."
 D ^DIR I $D(DIRUT) S LREND=1 Q
 I Y="A" S LRM(LRASK,"A")=""
 ; if specific values are requested, obtain selections
 I Y="S" D
 .S DIC=4,DIC(0)="AEMOQ",DIC("A")="Select Division: " F  D ^DIC Q:Y<1  S LRM(LRASK,"S",+Y)=$P(Y,U,2),LRSDIV=+Y
 K DIC I $D(DTOUT) S LREND=1
 ;
 S LRDETAIL=0,LRHELP="LRMITS OPTION",LRLOS=0,LRMERGE="S",LROTYPE("B")="",LRUNK="Unknown"
 S (LRSUSR("I"),LRSUSR("R"),LRSUSS("MS"),LRSUSS("S"))=""
 S OK=1
 S LRBLIK=""
 D FILSCAN ;<------DRH patch 96
 Q:'OK
 I $D(^TMP("LRM",$J)) D QUERY
 F LRX="O","S","L","D","P","C" I $D(^LAB(69.9,1,"MIT","B",LRX)) S LRM(LRX,"A")=""
 ; default reports
 I 'OK S LREND=1 QUIT
SORT K DIR S DIR(0)="SAMO^A:Alphabetically;P:Print Order",DIR("B")="A"
 S DIR("A")="Sort the Antibiotic output by: "
 S DIR("?")="Enter 'A'lphabetically or 'P'rint Order"
 S DIR("?",1)="This allows you to choose how the Antibiotics will be"
 S DIR("?",2)="sorted. Alphabetically will sort by the mnemonics and "
 S DIR("?",3)="Print Order will use the order defined in file #62.06"
 S DIR("?",4)="ANTIMICROBIAL SUSCEPTIBILITY" D ^DIR I $D(DIRUT) S LREND=1 Q
 S LRSORT=$S(Y="P":1,1:0)
 ;
 K DIR S DIR(0)="Y",DIR("A")="Use default reports HERE",DIR("B")="YES"
 S DIR("?")="Enter 'Y'es or 'N'o",DIR("??")=LRHELP
 S DIR("?",1)="Default reports are setup in the Laboratory Site file, 69.9."
 S DIR("?",2)="If you answer 'NO', you can select individual antibiotic trend reports"
 S DIR("?",3)="grouped by: organism, site/specimen, location, patient, physician, and/or"
 S DIR("?",4)="collection sample.  You can select all items or a single item for each group."
 S DIR("?",5)="Example: a trend report on a single patient."
 D ^DIR I $D(DIRUT) G SORT
 K DIR,LRX
 ; get specific input if not using default data
 I 'Y D ^LRMITSEC Q:LREND  D ^LRMITSES Q:LREND
 ; if no reports selected quit
 I '$D(LRM) W !,"No reports were selected!" S LREND=1 Q
 ; get date range
 W ! K DIR S DIR(0)="D^::AE",DIR("A")="Start Date"
 S DIR("?")="^D HELP^%DTC",DIR("??")=LRHELP
 D ^DIR I $D(DIRUT) S LREND=1 Q
 S LRTBEG=Y\1 ;S LRTBEG=$E(Y,1,5)_"00"
 K DIR S DIR(0)="D^::AE",DIR("A")="End Date"
 S DIR("?")="^D HELP^%DTC",DIR("??")=LRHELP
 D ^DIR I $D(DIRUT) S LREND=1 Q
 S LRTEND=Y\1 ;S LRTEND=$E(Y,1,5)_"00"
 I LRTEND<LRTBEG S X=LRTBEG,LRTBEG=LRTEND,LRTEND=X
 W ! K DIR,LRHELP,X,Y
 Q
 ;-------------------LR*5.2*96------------------------------------
FILSCAN ; scan ^LAB(62.06 FOR non std DEFAULT INTERPS ie RES, SUS etc  <--
 K ^TMP("LRM",$J)
 S LRSCN("R")="R",LRSCN("MS")="MS",LRSCN("I")="I",LRSCN("S")="S"
 S LRTIC=0,LRCNT=1
 F  S LRTIC=$O(^LAB(62.06,LRTIC)) Q:+LRTIC'>0  D
 .  S LRCN=0
 .  F  S LRCN=$O(^LAB(62.06,LRTIC,1,LRCN)) Q:+LRCN'>0  S NODE=^(LRCN,0) D
 ..  S NODE=$P(NODE,U,2) Q:NODE?1P.E!(+NODE'=0)  I 'NODE D MISSNG
 ..  F LRTAC="I","S","R","MS" S:LRTAC=NODE LRGOT1=1
 ..  Q:NODE=""  I $G(LRGOT1)'=1 S ^TMP("LRM",$J,NODE)="" S LRCNT=LRCNT+1
 ..  K LRGOT1
 K NODE,LRCN,LRSCN,LRTIC,LRTAC
 Q
MISSNG ;
 Q:$G(LRBLIK)=1
 ;W !!,"You have required fields without data. Please check file 62.06 for deletions.",$C(7)
 ;Commented out for future use
 S LRBLIK=1
 Q
QUERY ; Present to user non std entries from ^TMP classify per std.
 ; LRSUSR(interp)=""  interpretations forced to 'R'
 ; LRSUSS(interp)=""  interpretations forced to 'S'
 W !!,"I scanned your Antimicrobial Susceptibility File and was"
 W !,"surprised to see you have non-standard entries in the default"
 W !,"interpretation field."
 W !!,"In order for me to proceed, I need to know what the entry means."
 K DIR
 S DIR(0)="SOM^1:RESISTANT;2:SUSCEPTIBLE"
 S DIR("A")="Please enter your response here"
 S LRNTRP="",OK=1
 F  S LRNTRP=$O(^TMP("LRM",$J,LRNTRP)) Q:LRNTRP=""!'OK  W !!!,?32,"*****",LRNTRP,"*****" D
 .  Q:'$D(LRNTRP)  D ^DIR
 .  S:$D(DIRUT) OK="" I 'OK QUIT
 .  I Y=1 S LRSUSR(LRNTRP)=""
 .  E  S LRSUSS(LRNTRP)=""
 K ^TMP("LRM")
 K LRNTRP
 ;---------------------------------------------------------------------
 Q
