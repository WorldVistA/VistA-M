PSODP ;BHAM ISC/JrR - SORT AND PRINT DUE ANSWER SHEETS ; 11/17/92 10:19
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
 ;
PSOSUMM W !,"Do you want a Report Summary"
 S %=2 D YN^DICN
 I '% D QUES,QUES1 G PSOSUMM
 G:%=-1 EXIT
 S PSOSUMM=%=1
 I 'PSOSUMM S PSONLY=0 G DIP
 ;
PSONLY W !,"Do you want a SUMMARY only"
 S %=2 D YN^DICN
 I '% D QUES,QUES2 G PSONLY
 G:%=-1 EXIT
 S PSONLY=%=1
 ;
DIP K FR,TO,PG,DHIT,DIOEND,DIOBEG,DCOPIES,DIS,PSOQL
 S PSCNT=0
 S DIC="^PS(50.0731,",DHD="@"
 S DIOEND="W:'PSCNT !!,?5,""0 matches found!!!"",!"
 S DHIT="S PSCNT=PSCNT+1"
 I PSOSUMM S DIOBEG="K ^TMP(""PSOD"",$J)",DIOEND="D SUMM^PSODP",DHIT="D ACCUM^PSODP"
 S BY="10,@",L="SORT ANSWER SHEETS",FLDS=$S(PSONLY:"",1:"[PSOD PRINT ANSWER SHEET]")
 D EN1^DIP
EXIT K %,D0,DCOPIES,DHD,DHIT,DIC,DIOBEG,DIOEND,DIS,FLDS,FR,L,PG,PSOA,PSOATOT
 K PSODA,PSODN,PSODQA,PSONLY,PSOQ,PSOQA,PSOQAM,PSOQATOT,PSOQL,PSOQM
 K PSOQN,PSOSUMM,PSPOP,PSCNT
 K ^TMP("PSOD",$J)
 QUIT
ACCUM ;Enter here from DHIT="D ACCUM^PSODP"
 ;Requires D0 which is defined from ^DIP call above
 S PSODQA=+$P(^PS(50.0731,D0,0),"^",2)
 S ^(PSODQA)=$S('$D(^TMP("PSOD",$J,PSODQA)):1,1:^(PSODQA)+1)
 Q:'$D(^PS(50.073,PSODQA,0))
 Q:'$D(^PS(50.0731,D0,1,0))
 F PSODN=0:0 S PSODN=$O(^PS(50.0731,D0,1,PSODN)) Q:'PSODN  S PSOQN=$P(^(PSODN,0),"^",2),PSOQM=+$P(^(0),"^") I $D(^PS(50.0732,PSOQN,0)),$P(^(0),"^",2)=1 D COUNT
 QUIT
COUNT S PSODA=$S($D(^PS(50.0731,D0,1,PSODN,1)):^(1),1:"")
 S:PSODA="" PSODA="NULL"
 S ^(PSODA)=$S('$D(^TMP("PSOD",$J,PSODQA,PSOQM,PSODA)):1,1:^(PSODA)+1)
 Q
SUMM ;Enter here from ^DIP to print Summary
 W:$Y @IOF
 S PSOQATOT=0,PSOATOT=0,$P(PSOQL,"-",IOM)=""
 F PSOA=-1:0 S PSOA=$O(^TMP("PSOD",$J,PSOA)) Q:PSOA=""  S PSOQATOT=PSOQATOT+1,PSOATOT=PSOATOT+^(PSOA)
 W !!!,"Following is a Summary of the DUE Questionnaires and the",!,"corresponding Answers found in your report."
 W !,"This Summary contains a cumulative total of the YES/NO/UNKNOWN type answers.",!!
 I $D(^TMP("PSOD",$J,0)),^(0) S %=^(0) W !,%," ANSWER SHEET"_$S(%>1:"S",1:"")_" HAD A MISSING QUESTIONNAIRE FIELD!" S PSOQATOT=PSOQATOT-1
 W !!!,"TOTAL ANSWER SHEETS FOUND: ",PSOATOT
 W !,"TOTAL QUESTIONNAIRES FOUND: ",PSOQATOT
 S PSPOP=0
 F PSOQA=0:0 S PSOQA=$O(^TMP("PSOD",$J,PSOQA)) Q:'PSOQA!PSPOP  D SUMMHD Q:PSPOP  F PSOQ=0:0 S PSOQ=$O(^TMP("PSOD",$J,PSOQA,PSOQ)) Q:'PSOQ  D SUMMOUT
 W:$E(IOST)="P"&$Y @IOF
 Q
SUMMOUT W !?(2-($L(PSOQ)\2)),PSOQ
 S %=$S($D(^TMP("PSOD",$J,PSOQA,PSOQ,"YES")):^("YES"),1:0) W ?(16-($L(%)\2)),%
 S %=$S($D(^TMP("PSOD",$J,PSOQA,PSOQ,"NO")):^("NO"),1:0) W ?(25-($L(%)\2)),%
 S %=$S($D(^TMP("PSOD",$J,PSOQA,PSOQ,"UNKNOWN")):^("UNKNOWN"),1:0) W ?(38-($L(%)\2)),%
 S %=$S($D(^TMP("PSOD",$J,PSOQA,PSOQ,"NULL")):^("NULL"),1:0) W ?(56-($L(%)\2)),%
 Q
SUMMHD I $E(IOST)="C" S DIR(0)="E" W !! D ^DIR I X="^" S PSPOP=1 Q
 W @IOF
 S PSOQAM=$P(^PS(50.073,PSOQA,0),"^")
 W !!?(40-($L(PSOQAM)\2)),PSOQAM
 W !!,"Number of Answer Sheets: ",^TMP("PSOD",$J,PSOQA)
 W !!,"QUEST #",?15,"YES",?25,"NO",?35,"UNKNOWN",?50,"NOT ANSWERED"
 W !,PSOQL
 W:'$O(^TMP("PSOD",$J,PSOQA,0)) !!,"*** This Questionnaire has no YES/NO/UNKNOWN type answers. ***"
 Q
QUES W !?5,"A Summary will be printed at the end of this report detailing the"
 W !?5,"number of times a question was answered YES, NO, UNKNOWN, or NOT ANSWERED."
 Q
QUES2 W !?5,"Answer 'YES' if you want to see the Summary ONLY."
 Q
QUES1 W !?5,"Answer 'YES' if you want to print this Summary."
 Q
