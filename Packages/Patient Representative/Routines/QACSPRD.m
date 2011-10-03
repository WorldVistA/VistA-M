QACSPRD ;HISC/CEW - Spreadsheet reports ;7/17/95  11:04
 ;;2.0;Patient Representative;**3,9,12,17**;07/25/1995
DATE ;
 N QACIFLG,QACXFLG
 S QAQPOP=0
 D DATDIV^QACUTL0 G:QAQPOP EXIT
BEGIN ;
 K DIR
 S DIR(0)="NA^1:13"
 W !!?5,"1   Contact made by (#C)",!?5,"2   Issue Headers (#I)",!?5,"3   Issues"
 W !?5,"4   Location (#I)"
 W !?5,"5   Service (Old field - Service field de-activated 10/97 - #I)"
 W !?5,"6   Service/Discipline (#I)",!?5,"7   Sex (#I)"
 W !?5,"8   Contact Source (#C)",!?5,"9   Treatment Status (#C)"
 W !?5,"10  Treatment Status (#I)",!?5,"11  Discipline (#I)"
 W !?5,"12  Division (#C)",!?5,"13  Division (#I)",!!
 S DIR("A")="Print Spreadsheet Totals for: "
 S DIR("?")="     Select the number or item you want totalled."
 S DIR("?",1)="     #I means total is by Issues. #C means total is by Contacts."
 S DIR("?",2)="     Enter ""^"" or <RET> to exit."
 D ^DIR K DIR G:$D(DIRUT)!$D(DIROUT) EXIT S QACITEM=Y
 K COUNT,QACPCE,QACLABEL,QACDIV
 N QACRTN
 I QACITEM=1 D CONTACT^QACSPRD1
 I QACITEM=2 D HEAD^QACSPRD3
 I QACITEM=3 D CODE^QACSPRD2
 I QACITEM=4 D LOC^QACSPRD2
 I QACITEM=5 D SERVICE^QACSPRD2
 I QACITEM=6 D SRVDS^QACSPRD3
 I QACITEM=7 D SEX^QACSPRD3
 I QACITEM=8 D SOURCE^QACSPRD1
 I QACITEM=9 D TREATC^QACSPRD1
 I QACITEM=10 D TREATI^QACSPRD1
 I QACITEM=11 D DISC^QACSPRD2
 I QACITEM=12 D DIVC^QACSPRD3
 I QACITEM=13 D DIVI^QACSPRD3
 K DIR S DIR(0)="E" D ^DIR G EXIT:$D(DIRUT),DATE
EXIT ;
 K DIR,DIROUT,DIRUT,POP,Y
 K QAC1DIV,QACDT,QACITEM,QACNUM,QACPOP,QAQPOP,QACWW
 K ZTDESC,ZTRTN,ZTSAVE
 D K^QAQDATE
 Q
LOOP1(ROU,NBEG,NEND,QACD0) ;loop through #745.1 within the date range
 S QACDT=NBEG-.0000001 F  S QACDT=$O(^QA(745.1,"D",QACDT)) Q:(QACDT'>0)!(QACDT>NEND)!(QACDT\1'?7N)  D
 . S QACD0=0 F  S QACD0=$O(^QA(745.1,"D",QACDT,QACD0)) Q:QACD0'>0  D
 . . S QACDIV=$P(^QA(745.1,QACD0,0),U,16)
 . . ;S QACWW=""
 . . ;I $G(QACDIV)]"" I $O(^QA(740,1,"QAC2","B",QACDIV,QACWW))']"" S QACDIV=0
 . . I $G(QACDIV)']"" S QACDIV=0
 . . I $O(QACDIV(0))>0 D CHKDIV
 . . I $G(QAC1DIV)]"" I $G(QACDIV)=$G(QAC1DIV) D @ROU
 . . I $G(QAC1DIV)']"" D @ROU
 Q
ZIS1(ZTRTN,DESC,XFLG) ;subroutine sets up and calls ^%ZIS and ^%ZTLOAD
 K QACXFLG
 K %ZIS,IOP S %ZIS="MQ" W ! D ^%ZIS I POP S QACPOP=1 Q
 I $D(IO("Q")) D
 . S (ZTSAVE("QAQNBEG"),ZTSAVE("QAQNEND"))=""
 . S (ZTSAVE("QAC1DIV"),ZTSAVE("QACDIV"),ZTSAVE("QAQPOP"))=""
 . S (ZTSAVE("QACTITLE"),ZTSAVE("QACIFLG"))=""
 . I $G(QACIFLG)=1 K ^TMP("QACSPRD2",$J)
 . I $G(QACIFLG)=1 S (ZTSAVE("^TMP(""QACSPRD2"",$J,"),ZTSAVE("QACODE"))=""
 . S ZTDESC="Patient Rep "_DESC_"Spreadsheet Report"
 . D ^%ZTLOAD S QACXFLG=1
 Q
CHKDIV ;
 N QACD,QACQ
 S QACD=""
 F  S QACD=$O(QACDIV(QACD)) Q:QACD']""  D
 . I QACD=QACDIV S QACQ=1
 I $G(QAC1DIV)']"" I $G(QACQ)'=1 S QACDIV=0
 Q
