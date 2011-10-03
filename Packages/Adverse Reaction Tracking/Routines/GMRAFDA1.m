GMRAFDA1 ;HIRMFO/WAA-SELECT PATIENT AND PRINTER FOR REPORTS PRINT OUT ;12/1/95  11:23
 ;;4.0;Adverse Reaction Tracking;**2**;Mar 29, 1996
EN1 ;Entry to PRINT AN FDA REPORT FOR A PATIENT option
 S GMRAOUT=0,GMRALAGO=0 D EN1^GMRAU85 G:GMRAPA1'>0 EXIT
 S GMRANAM=$P($G(^DPT($P(GMRAPA(0),U),0)),U)
 D DEV1
 D EXIT
 Q
DEV1 W !,"THIS REPORT SHOULD BE SENT TO A 132 COLUMN PRINTER.",!
 S GMRAZIS="QM132S60" D DEV^GMRAUTL I POP W !,"PLEASE TRY AGAIN LATER" S GMRAOUT=1 Q
 I $D(IO("Q")) D  Q
 .S ZTSAVE("GMRAPA1")="",ZTRTN="PRINT^GMRAFDA1",ZTDESC="Produce FDA Report for "_GMRANAM
 .D ^%ZTLOAD K IO("Q")
 .W !!,$S($D(ZTSK):"Request queued...",1:"Request NOT queued please try later...")
 .Q
 D PRINT Q
 Q
PRINT ; ENTRY POINT TO BEGIN PRINTING THIS REPORT
 U IO D PRT U IO(0)
 D CLOSE^GMRAUTL
 Q
PRT D ^GMRAFN1
 I $D(^TMP($J,"GMR")) D PRINT2 W @IOF
 Q
PRINT2 ;PRINT THE SECOND PAGE OF ANY REMAINING DATA
 D  ;HEADER INFORMATION
 .N GMRASUS,GMRATAB
 .W !,"ATTACHMENT PAGE"
 .W !,"PATIENT ID: ",GMRAID
 .S GMRASUS=$P(GMRAPA1(0),U,15)
 .I GMRASUS>0 S GMRATAB=66-((20+$L($P($G(^GMR(120.8,GMRASUS,0)),U,2)))/2) W ?GMRATAB,"SUSPECT MEDICATION: ",$P($G(^GMR(120.8,GMRASUS,0)),U,2)
 .W ?100,"DATE OF EVENT: ",$$FMTE^XLFDT($P(GMRAPA1(0),U),2)
 .Q
 I $D(^TMP($J,"GMR","R")) D
 .W ! F I=1:1:132 W "-"
 .W !,"Section B. Part 5. Describe event Continued" S GMRAX=0
 .S DIWL=5,DIWR=128,DIWF="" K ^UTILITY($J,"W",5) S GMRAX=0 ;D   K ^UTILITY($J,"W",5)
 .F  S GMRAX=$O(^TMP($J,"GMR","R",GMRAX)) Q:GMRAX<1  S X=^TMP($J,"GMR","R",GMRAX) D ^DIWP
 .K ^TMP($J,"GMR","R")
 .S X=0 F  S X=$O(^UTILITY($J,"W",5,X)) Q:X<1  S ^TMP($J,"GMR","R",X)=$G(^UTILITY($J,"W",5,X,0))
 .F  S GMRAX=$O(^TMP($J,"GMR","R",GMRAX)) Q:GMRAX<1  D  Q:GMRAOUT
 ..W !,$S($D(^TMP($J,"GMR","R",GMRAX+1)):^TMP($J,"GMR","R",GMRAX),1:$E(^TMP($J,"GMR","R",GMRAX),1,($L(^TMP($J,"GMR","R",GMRAX))-2)))
 ..Q
 .Q
 I $D(^TMP($J,"GMR","T")) D
 .W ! F I=1:1:132 W "-"
 .W !,"Section B. Part 6. Relevant Test/Laboratory Data Continued:"
 .S GMRAX=0 F  S GMRAX=$O(^TMP($J,"GMR","T",GMRAX)) Q:GMRAX'>0  D  Q:GMRAOUT
 ..W !,"TEST: ",$P(^TMP($J,"GMR","T",GMRAX),U)," RESULTS: ",$P(^(GMRAX),U,2) S Y=$P(^(GMRAX),U,3) W:Y'="" " COLLECTION DATE: ",$$FMTE^XLFDT(Y,"2") K Y
 ..Q
 .Q
 I $D(^TMP($J,"GMR","O")) D
 .S DIWL=5,DIWR=128,DIWF="" K ^UTILITY($J,"W",5) S GMRAX=0 ;D  K ^UTILITY($J,"W",5)
 .F  S GMRAX=$O(^TMP($J,"GMR","O",GMRAX)) Q:GMRAX<1  S X=^TMP($J,"GMR","O",GMRAX) D ^DIWP
 .K ^TMP($J,"GMR","O")
 .S X=0 F  S X=$O(^UTILITY($J,"W",5,X)) Q:X<1  S ^TMP($J,"GMR","O",X)=$G(^UTILITY($J,"W",5,X,0))
 .W ! F I=1:1:132 W "-"
 .W !,"Section B. Part 7. Other Relevant History Continued" S GMRAX=0
 .F  S GMRAX=$O(^TMP($J,"GMR","O",GMRAX)) Q:GMRAX<1  D  Q:GMRAOUT
 ..W !,^TMP($J,"GMR","O",GMRAX)
 ..Q
 .Q
 I $D(^TMP($J,"GMR","C")) D
 .W ! F I=1:1:132 W "-"
 .W !,"Section C. Part 10. Concomitant Drugs Continued" S GMRAX=0
 .F  S GMRAX=$O(^TMP($J,"GMR","C",GMRAX)) Q:GMRAX<1  D  Q:GMRAOUT
 ..W !,$P(^TMP($J,"GMR","C",GMRAX),"^"),?60 S X=$P(^(GMRAX),"^",2) W:X]"" $E(X,4,5),"/",$E(X,6,7),"/",$E(X,2,3) S X=$P(^(GMRAX),"^",3) W:X]"" "-",$E(X,4,5),"/",$E(X,6,7),"/",$E(X,2,3)
 ..Q
 .Q
 Q
EXIT ;
 K ^TMP($J,"GMR")
 D KILL^XUSCLEAN
 Q
LKP ; ADDITIONAL LOOKUP ON 120.85
 N GMRA S GMRA=$G(^GMR(120.85,+Y,0))
 I $P(GMRA,U)'="" W "   ",$$FMTE^XLFDT($P(^GMR(120.85,+Y,0),U),"2S")
 I $P(GMRA,U,15)'="" W "   ",$P($G(^GMR(120.8,$P(GMRA,U,15),0)),U,2)
 W $E(@(DIC_+Y_",0)"),0)
 Q
SET ; set up variables for question mark help
 S X=GMRANAM,DLAYGO=120.85,DIC="^GMR(120.85,",DIC(0)="E",D="D",DIC("W")="D LKP^GMRAFDA1",DZ="??"
 S DIC("S")="I $P(^(0),U,2)=DFN S GMRA1208=+$P(^(0),U,15) I $$ERCHK^GMRAFDA1"
 Q
ERCHK() ; check for "ER" node to screen out entered-in-error entries
 I '$D(^GMR(120.8,+GMRA1208,0)) Q 1
 I '$D(^GMR(120.8,+GMRA1208,"ER")) Q 1
 Q 0
