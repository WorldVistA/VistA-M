RMPOLETA ;EDS/PAK - HOME OXYGEN LETTERS ;8/6/98  07:37
 ;;3.0;PROSTHETICS;**29**;Feb 09, 1996
 ;
SELECT ;
 N LSTN,CNT,ANS
 ;
 S ANS="Q"
 D PROMPT
 D:ANS'="Q" PRINT^RMPOLET1(ANS)
 D EXIT
 Q
 ;
PROMPT ;Prompt for letter list groups to print
 W @IOF,!?30,RMPO("NAME"),!?15,"HOME OXYGEN PATIENT LISTING FOR - "
 S CNT=0,Y=DT X ^DD("DD") W Y,!?35,"LETTERS",!!
 S LSTN=1,RMPOLCD=0
 F  S RMPOLCD=$O(^TMP($J,"RMPOLST",RMPOLCD)) Q:RMPOLCD=""  D  S LSTN(LSTN)=RMPOLCD,LSTN=LSTN+1 W CNT," patients."
 . S CNT=0,RMPODFN=""
 . F  S RMPODFN=$O(^TMP($J,"RMPOLST",RMPOLCD,RMPODFN)) Q:RMPODFN=""  S CNT=CNT+1
 . I $E(RMPOLCD,1)="A" W !,?15,LSTN,".",?19,"Welcome to Home Oxygen Program Letter group of "
 . I $E(RMPOLCD,1)="B" W !,?15,LSTN,".",?19,"Prescription Cancellation Letter group of "
 . I $E(RMPOLCD,1)="C" W !,?15,LSTN,".",?19,$E(RMPOLCD,2,4)," day Rx expiration group of "
 I 'CNT W !!,"No patient letters to print today." H 5 Q
ASK ;
 W !!,"The list above shows the letters that have been compiled."
 W !,"and how many patients will receive each letter."
 F  D  Q:ANS'=""
 .W !!,"Enter a number of a letter you wish to print or 'ALL': ALL // "
 .R ANS:DTIME S:ANS="" ANS="A" I '$T!("^"[ANS) S ANS="Q" Q
 .I $E("ALL",1,$L(ANS))'=$TR(ANS,"al","AL"),($S(ANS'?1.N:1,ANS>CNT:1,ANS<1:1,1:0)) S ANS="" W !!,"Please enter a number from 1 to "_CNT_" or 'ALL'."
 S:ANS>0 ANS=LSTN(ANS)  ; translate answer into letter code
 Q
 ;
EXIT D ^%ZISC
 K ^TMP($J),ANS,DIC,X1,X2,Y,ZTSAVE,POP,X,DFN,VADM,VAPA,%,ANSW,%ZIS
 K RMPODAYS,RMPO,RMPOLTR,RMPOLCD,RMPOEXP
 K RMPORXDT,RMPORX,BTYP,DIE,DR,RMPOITEM,VAL
 Q
