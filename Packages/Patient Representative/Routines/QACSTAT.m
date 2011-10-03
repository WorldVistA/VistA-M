QACSTAT ;HISC/RS - This routine will reopen, close, or delete a contact for the Patient Rep. ;3/21/95  10:03
 ;;2.0;Patient Representative;**3,5**;07/25/1995
 S (DIC,DIE)="^QA(745.1,",DIC(0)="AEMQZ",DIC("A")="Select CONTACT NUMBER: "
 D ^DIC I Y<0!(Y="^") K DIC,DIE Q
 ;Display Contact data to be reopen or deleted
 K DA,DR,DIC,DIQ,TMP
 S DA=+Y,DIC=745.1,DIQ="TMP",DR=".01;1;2;3;4;5;6;7" D EN^DIQ1
 W @IOF,!!,?10,"This option will allow the user to open, close, or delete",!,?15,"a Patient Representative Contact record",!
 S N1="" F  S N1=$O(TMP(745.1,N1)) Q:N1=""  S N2="" F  S N2=$O(TMP(745.1,N1,N2)) Q:N2=""  S QACDATA=TMP(745.1,N1,N2) D
 .Q:QACDATA=""
 .S FLD=N2*100\1,TEXT=$P($T(@FLD),";;",2),TAB=$P(TEXT,"^"),LINE=$P(TEXT,"^",2),CODE=$P(TEXT,"^",3,99)
 .W:TAB=0 !
 .W ?TAB,LINE
 .X CODE
 .Q
 K TMP,DIQ,N1,N2,QACDATA,FLD,TAB,TEXT,LINE,CODE
 ;Ask what the user want to to with the record.
 S DIR(0)="SMO^O:Open;C:Closed;D:Delete",DIR("A")="STATUS",QACALERT=1
 S STAT=$P($G(^QA(745.1,DA,7)),"^",2),DIR("B")=$S(STAT="O":"Open",STAT="C":"Closed",1:"") D ^DIR G END:Y<0
 S LINE=$S(Y="O":"OPEN",Y="C":"CLOSE",Y="D":"DELE",1:"END") D @LINE
 G END
OPEN S DR="27///^S X=""O"";26///^S X=""@""" D ^DIE K DR Q
CLOSE S II=0 I $O(^QA(745.1,DA,3,II))']"" D
 . W !!?5,"Reports of Contact cannot be resolved without Issue Code(s)."
 . S QACIFLG=1
 S II=0 F  S II=$O(^QA(745.1,DA,3,II)) Q:II'>0  D
 . S SS=0 I $O(^QA(745.1,DA,3,II,3,SS))']"" D
 . . W !!?5,"Reports of Contact cannot be resolved without a Service/Discipline",!?5,"for each Issue Code."
 . . S QACSFLG=1
 I $G(QACIFLG)=1!($G(QACSFLG)=1) K QACIFLG,QACSFLG Q
 S DR="26///TODAY" D ^DIE K DR Q
DELE N DIR W !,*7,*7 S DIR("A")="SURE YOU WANT TO DELETE THE ENTIRE *"_$P(^QA(745.1,DA,0),"^",1)_"* CONSUMER CONTACT"
 S DIR(0)="Y" D ^DIR I Y'=1 W !,?30,"NOTHING DELETED" Q 
 S DIK=DIC D ^DIK Q
END K DIC,DIC,DIK,DIR,STAT,DR,DIE,DA,D0,DO,LINE,X,Y,%,%Y,D,DI,DQ,QACALERT
 Q
TEXT ;This is for the display of data, tab,description,data info.
1 ;;0^Contact Number:^W ?21,QACDATA
100 ;;45^Date of Contact:^W ?63,QACDATA
200 ;;0^Patient Name:^W ?21,QACDATA
300 ;;45^Patient SSN (c):^W ?63,QACDATA
400 ;;0^Patient DOB (c):^S Y=QACDATA D DD^%DT S QACDATA=Y W ?21,QACDATA
500 ;;45^Patient sex (c):^W ?63,QACDATA
600 ;;0^Eligibility Status:^W ?21,QACDATA
700 ;;45^Patient Category:^W ?63,QACDATA
 Q
