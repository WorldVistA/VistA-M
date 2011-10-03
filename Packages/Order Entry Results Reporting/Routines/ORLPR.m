ORLPR ; slc/CLA - Report formatter for patient lists ;11/27/91 [7/20/00 10:33am]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9,63,82**;Dec 17, 1997
INQ ;called by option ORLP EXAMINE/PRINT - Inquire to review/print lists
 N ORLIST,SORT,TL
 K IO("Q")
 W @IOF
 S SORT=$$GET^XPAR("USR.`"_DUZ,"ORLP DEFAULT LIST ORDER",1,"I") I SORT']"" S SORT="A"
 K DIC S DIC="^OR(100.21,",DIC(0)="AEQMZ"
 S DIC("A")="Select LIST to examine/print: "
 D GETDEF^ORLPL
 D ^DIC K DIC,DTOUT,DUOUT I Y<1 Q
 ;make list the default if type=team, contains users and current user belongs (else kill the default list to prevent confusion)
 S TL=$P(Y(0),U,2)
 I TL["T",$D(^OR(100.21,+Y,1,0))#2,$D(^(DUZ)) S ^TMP("ORLP",$J,"TLIST")=+Y
 ; Next line added by PKS - 3/2000; modified on 7/2000 for patch 82:
 I ((SORT'="R")&(SORT'="T")) S SORT="A" ; Only A, R, or T work here.
 E  K ^TMP("ORLP",$J,"TLIST")
 S ORLIST=Y
 D  Q:$D(DTOUT)!$D(DUOUT)
 . N DIR S DIR(0)="SO^A:ALPHABETIC;R:ROOM/BED;T:TERMINAL DIGIT",DIR("B")=SORT,DIR("A")="Sort by"
 . D ^DIR S SORT=Y
 S %ZIS="PQ",ZTSAVE("ORLIST")="",ZTSAVE("SORT")="",ZTSAVE("^TMP(""ORLP"",$J,""LIST"",")="",ZTSAVE("TL")="",ZTRTN="OUTPUT^ORLPR0",ZTDESC="OERR Patient/Team List Report"
 D IO^ORUTL1,END^ORLPR0 ;queue output then end
 Q
