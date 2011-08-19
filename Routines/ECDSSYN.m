ECDSSYN ;BIR/RHK,TTH,JPW-Edit Synonyms and Volume ;30 Apr 96
 ;;2.0; EVENT CAPTURE ;**1,4,5,33**;8 May 96
 ;This routine allows the user to edit the synonyms and volume
 ;associated with an Event Code Screens.
START ;Check Event Capture Locations.
 I $O(^DIC(4,"LOC",""))="" W !,"You have no locations flagged for Event Capture.",!,"See your program coordinator.",!! W "Press <RET> to continue  " R X:DTIME K X Q
 W @IOF,!,"Procedure Synonym/Default Volume (Enter/Edit)",! F XX=0:1:79 W "-"
 S (MSG1,MSG2)=0
LOC ;Allow user to select the availiable locations.
 K ECL S NOTIOF=1 D ^ECL K NOTIOF G END:'$D(ECL)
 I '$D(^ECJ("AP",ECL)) W !,"There are no event code screens set up for your selected location.",!,"Contact your program coordinator." K ECL D RETURN Q
UNIT ;Allow user to select DSS Unit.
 D UNIT^ECDSUTIL G END:'$D(ECL)
 W !
PRO ;Check Event Code Screens Procedures.
 I $O(^ECJ("AP",ECL,ECD,ECC,""))="" W !,"There are no procedures set up for the selected unit and category.",!,"Please contact your Event Capture administrator." D RETURN G END
 ;Set Procedures in ^TMP array.
PROC1 K ^TMP("ECPRO",$J) S ECOUT=0 D PROS^ECHECK1
 I '$O(^TMP("ECPRO",$J,0)) W !!,"There are no procedures available for the selected data." D RETURN S ECOUT=1 G END
PROC2 W !,"Enter Procedure: " R XX:DTIME
 I XX="^" K ^TMP("ECPRO",$J) S ECOUT=1
 I XX=""  S:$G(ECDONE) ECOUT=1
 I XX="?" D HELP G PROC2
 I XX="??" D LISTALL I $D(DUOUT)!($D(DTOUT)) S ECOUT=1
 I ECOUT!('$D(XX)&('$G(ECDONE))) G END
 ;Match user selection to specific cross-references.
 D MATCH G:$G(ECPROC) STUFF G:ECOUT END
 I '$G(ECPROC) D LISTALL I $D(DUOUT)!($D(DTOUT)) S ECOUT=1
 I $G(ECOUT)!('$G(ECDONE)) G END
 ;Allow user to edit synonym and volume fields.
STUFF K Y S (DA,ECFN)=$P(^TMP("ECPRO",$J,ECPROC),U,2)
 S DIE=720.3
 ;ALB/ESD - Ask procedure reason indicator
 S DR=$S($P(ECPCE,"~",2)="N":"",1:"55T;")_"53T;54T;56T"
 D ^DIE I $D(Y) G END
 ;ALB/ESD - If proc reasons indictor is YES, ask procedure reasons
 I $P($G(^ECJ(ECFN,"PRO")),"^",5)=1 D ADREAS^ECDSUTIL(ECFN)
 ;
 ;ALB/ESD - Always ask associated clinic and do active clinic check
 ;ALB/JAM - Only ask for associated clinic if DSS Unit sends data to PCE
 I $P(ECPCE,"~",2)'="N" D CLIN
 ;Allow user to repeat process.
 W ! K DIE,DR,ECFN,ECPROC,LOC,XX,ECHOICE,ECDONE G PROC1
END ;Kill existing variables and exit.
 W @IOF
 K ^TMP("ECPRO",$J),Y,ECANS,OK,ANS,ECR,RK D ^ECKILL
 Q
LISTALL ;Display the available procedures.
 K ECR S ANS="" W @IOF,!!,"Available Procedures: ",!! D LABEL
 S CNT=0 F XX=0:0 S XX=$O(^TMP("ECPRO",$J,XX)) Q:'XX!($D(ECHOICE))  D:($Y+5>IOSL) SPLIT Q:$D(ECHOICE)!($G(ECOUT)=1)  G:$D(ECR) LISTALL  I ANS="" D
 .S CNT=CNT+1 W !,$E(XX,1,4),?7,$E($P(^TMP("ECPRO",$J,XX),U,3),1,32),?41,$E($P(^TMP("ECPRO",$J,XX),U,4),1,30),?73,$P(^TMP("ECPRO",$J,XX),U,5)
 Q:$D(ECHOICE)!($D(ECDONE))!($G(ECOUT)=1)
 W !!,"Select Number (1-"_CNT_"):  " R ANS:DTIME
 I ANS="^"!('$T)!(ANS="") K ^TMP("ECPRO",$J) S ECOUT=1 Q
 I ANS["?" W !!,"This is a listing of all available, active procedures.",!,"Please enter the correct number corresponding to the desired procedure.",! D RETURN Q:$D(ECOUT)  G LISTALL
 I ANS'?1.4N!'ANS W !!,"Select a single number corresponding to the procedure.",! D RETURN Q:ECOUT  G LISTALL
 I ('$D(^TMP("ECPRO",$J,+ANS))) W "     **Invalid Number**",! D RETURN Q:ECOUT  G LISTALL
 I $D(^TMP("ECPRO",$J,ANS)) S ECPROC=ANS,ECDONE=1 ;Answer selected.
 Q
RETURN ;Ask user to exit or continue.
 F RK=$Y:1:(IOSL-6) W !
 S DIR(0)="E" D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) S ECOUT=1
 Q
MATCH ;Check ^TMP cross-references.
 I XX="" S ECOUT=1 Q
 I $O(^TMP("ECPRO",$J,"B",XX,0)) S ECPROC=+$O(^TMP("ECPRO",$J,"B",XX,0))
 I $O(^TMP("ECPRO",$J,"N",XX,0)) S ECPROC=+$O(^TMP("ECPRO",$J,"N",XX,0))
 I $O(^TMP("ECPRO",$J,"SYN",XX,0)) S ECPROC=+$O(^TMP("ECPRO",$J,"SYN",XX,0))
 Q
LABEL W !,"Num",?7,"Synonym",?41,"Procedure Name",?73,"Nat ID",!
 W "---",?7,"-------",?41,"--------------",?73,"------",!
 Q
HELP ;Display user options.
 W !!,"Enter one of the following:  < Procedure Name",!,?29,"< Procedure Number"
 W !,?29,"< Procedure Synonym"
 W !,?29,"< Enter ""??"" to List Procedures",!
 Q
SPLIT ;
 W !!,"Select Number, or press <RET> to continue listing : " R ANS:DTIME
 I '$T!(ANS="^") S (ECOUT,ECHOICE)=1 Q
 I ANS="" W @IOF D LABEL Q
 I ANS["?" W !!,"Please enter the correct number corresponding to the desired procedure.",! D RETURN S ECR=1 Q
 I ANS'?1.4N!'ANS W !!,"Select a single number corresponding to the procedure.",! D RETURN S ECR=1 Q
 I '$D(^TMP("ECPRO",$J,+ANS)) W "      ** Invalid Number **" D RETURN S ECR=1 Q
 I $D(^TMP("ECPRO",$J,+ANS)) S ECPROC=ANS,(ECDONE,ECHOICE)=1
 Q
CLIN ;check for active associated clinic
 S MSG1=1,MSG2=0
 S EC4=$P($G(^ECJ(+ECFN,"PRO")),"^",4) I EC4']"" S MSG2=1
 D CLIN^ECPCEU
 I 'ECPCL D
 .W !!,"The clinic ",$S(MSG1:"associated with",1:"you selected for")," this event code screen ",$S(MSG2:"has not been entered",1:"is inactive"),"."
 .W !,"Workload data cannot be sent to PCE for this event code screen with ",!,$S(MSG2:"a missing",1:"an inactive")," clinic."
 .W !!,"Please use the Procedure Synonym/Default Volume (Enter/Edit) option to enter",!,"an active clinic.",!!
 S (MSG1,MSG2)=0
 Q
