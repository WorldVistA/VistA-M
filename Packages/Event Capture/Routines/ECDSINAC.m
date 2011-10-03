ECDSINAC ;BIR/RHK,TTH,JPW-Inactivate Event Code Screen ;6 May 96
 ;;2.0; EVENT CAPTURE ;;8 May 96
 ;This routine allows the users to inactive or active procedures.
 ;in the Event Code Screen file.
 I $O(^DIC(4,"LOC",""))="" W !,"You have no locations flagged for event capture.",!,"See your program coordinator.",!! W "Press <RET> to continue  " R X:DTIME K X Q
UNIT ;Allow user to enter DSS Unit.
 K DIRUT W @IOF,!,"Inactivate Event Code Screen",! F XX=0:1:79 W "-"
 S NOTIOF=1 D ^ECL K NOTIOF G END:ECOUT!('$D(ECL))
 K DIC S DIC=724,DIC(0)="QEAMZ",DIC("A")="Select DSS Unit: ",DIC("S")="I $D(^ECJ(""AP"",ECL,+Y))" D ^DIC K DIC G:Y<0 END S (ECC,ECD)=+Y,ECDN=$P(Y,U,2) I $P(^(0),U,11) S ECCT=1
 I $D(ECCT) D  G END:$G(ECOUT)=1
 .I '$O(^ECJ("AP",ECL,ECD,"")) S ECC=0 W !,"Category: None" Q
 .D CAT
 I '$D(ECCT) S ECC=0 W !,"Category: None"
 G PROC
CAT ;Display or allow user to select category.
 S (CNT,ECC)=0
 F ECCAT=0:0 S ECCAT=$O(^ECJ("AP",ECL,ECD,ECCAT)) Q:'ECCAT  S ECC=ECCAT,CNT=CNT+1
 I CNT'>1 S ECCN=$P(^EC(726,ECC,0),U) W !,"Category: ",ECCN Q
 K Y S DIC=726,DIC(0)="AEQMZ",DIC("A")="Select Category: ",DIC("S")="I $D(^ECJ(""AP"",ECL,ECD,+Y))"
 D ^DIC K DIC I Y<0 S ECOUT=1 Q
 S ECC=+Y,ECCN=$P(Y,U,2)
 Q
PROC ;Set Procedures in ^TMP array.
 S ECC1=ECC ;**NOTE**If 'ECC in PROS^ECHECK1, ECC is set to null.
PROC1 K ^TMP("ECPRO",$J) S ECOUT=0,ECACTIV=1 D PROS^ECHECK1
PROC2 W !!,"Enter Procedure: " R XX:DTIME
 I XX="^" K ^TMP("ECPRO",$J) S ECOUT=1
 I XX=""  S:$G(ECDONE) ECOUT=1
 I XX="?" D HELP G PROC2
 I XX="??" D LISTALL I $D(DUOUT)!($D(DTOUT)) S ECOUT=1
 I ECOUT!('$D(XX)&('$G(ECDONE))) G END
 ;Match user selection to specific cross-references in ^TMP("ECPRO".
 D MATCH G:$G(ECPROC) STUFF G:ECOUT END
 I '$G(ECPROC) D LISTALL
 I $G(ECOUT)!('$G(ECDONE)) G END
 ;
STUFF ;Inactive or active Event Code Screen.
 S DA=$P(^TMP("ECPRO",$J,ECPROC),U,2),(ECDEL,ECYES)=0
 I $P($G(^ECJ(DA,0)),"^",2),$P($G(^ECJ(DA,0)),"^",2)'>DT S ECYES=1
 I $G(ECYES)=0 D  G:Y=0 REPET I $D(DIRUT)!(Y<0) S ECOUT=1 G END
 .K Y W ! S DIR(0)="Y",DIR("B")="YES",DIR("A")="Are you sure that you want to inactivate this procedure"
 .D ^DIR
 I $P($G(^ECJ(DA,0)),"^",2),$P($G(^ECJ(DA,0)),"^",2)'>DT D RETURN2 G:$D(DIRUT) END I ECDEL=0  D END0 G PROC2
 S DIE=720.3 D  D ^DIE K DIE,DR,DA
 .I $G(ECDEL)=1 S DR="1////@" Q
 .S DR="1///^S X=DT"
 S PROC=$P(^TMP("ECPRO",$J,ECPROC),U,8)
 S PROCNAM=$P(^TMP("ECPRO",$J,ECPROC),U,4)
 S ECTEST(1)=ECL_"-"_ECD_"-"_ECC1_"-"_PROC
 W !!,"Event Code Screen: ",ECTEST(1)
 W !,"Procedure: ",PROCNAM," is now"_$S($G(ECDEL)=1:" ",1:" in")_"activated."
REPET D END1 G PROC2
 Q
END ;Kill variables.
 I $G(ECOUT)=1 K ^TMP("ECPRO",$J)
 K ECC,ECL,ECD,ECC1,ECHOICE,ECR,ANS,ECOUT,ECPROS,OK
END0 K DIRUT,DTOUT,DUOUT,ECACTIV,ECCT,ECDEL,ECDONE,ECINAC,ECLN,ECP,ECPC,ECPCC,ECPN,ECPNN,ECPRIEN,ECPRO,ECHOICE,ECR
 K ECPROF,ECPRONAM,ECPT,ECUCAT,ECUCATN,FROOT,RK,XX,Y
END1 K CNT,DA,DIC,DIE,DIR,DISYS,DR,ECCAT,ECCN,ECCT,ECDEL,ECDN,ECPROC,ECTEST,ECYES,LOC,PROC,PROCNAM,ECHOICE,ECR,ECDONE
 Q
LISTALL ;Display the available procedures.
 K ECR S ANS="" W @IOF,!!,"Available Procedures: ",!! D LABEL
 S CNT=0 F XX=0:0 S XX=$O(^TMP("ECPRO",$J,XX)) Q:'XX!($D(ECHOICE))  D:($Y+5>IOSL) SPLIT Q:$D(ECHOICE)!($G(ECOUT)=1)  G:$D(ECR) LISTALL  I ANS="" D
 .S CNT=CNT+1 W !,$E(XX,1,4),?7,$E($P(^TMP("ECPRO",$J,XX),U,3),1,32),?41,$E($P(^TMP("ECPRO",$J,XX),U,4),1,30),?73,$P(^TMP("ECPRO",$J,XX),U,5)
 Q:$D(ECHOICE)!($D(ECDONE))!($G(ECOUT)=1)
 W !!,"Select Number (1-"_CNT_"):  " R ANS:DTIME
 I ANS="^"!('$T)!(ANS="") K ^TMP("ECPRO",$J) S ECOUT=1 Q
 I $D(^TMP("ECPRO",$J,+ANS)) S ECOUT=0
 I ANS["?" W !!,"This is a listing of all available, active procedures.",!,"Please enter the correct number corresponding to the desired procedure.",! D RETURN Q:ECOUT   G LISTALL
 I ANS'?1.4N!'ANS W !!,"Select a single number corresponding to the procedure.",! D RETURN Q:ECOUT  G LISTALL
 I '$D(^TMP("ECPRO",$J,+ANS)) W "    **Invalid Number**",! D RETURN Q:ECOUT   G LISTALL
 I $D(^TMP("ECPRO",$J,+ANS)) S ECPROC=+ANS,ECDONE=1 ;Answer selected.
 Q
RETURN ;Ask user to exit or continue.
 W ! S DIR(0)="E" D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) S ECOUT=1
 Q
RETURN2 ;Ask user to activate procedures.
 W !!,"The Event Code Screen for this procedure has a status of inactive."
 S DIR(0)="Y",DIR("A")="However, would you like to activate it",DIR("B")="NO" D ^DIR S ECDEL=+Y I $D(DUOUT)!($D(DIRUT))!($D(DTOUT)) S ECOUT=1
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
 W !,?29,"< Procedure Synonym",!,?29,"< Enter ""??"" to List Procedures",!
 Q
SPLIT ;
 W !!,"Select Number, or press <RET> to continue listing : " R ANS:DTIME
 I '$T!(ANS="^") S (ECOUT,ECHOICE)=1 Q
 I ANS="" W @IOF D LABEL Q
 I ANS["?" W !!,"Please enter the correct number corresponding to the desired procedure.",! D RETURN S ECR=1 Q
 I ANS'?1.4N!'ANS W !!,"Select a single number corresponding to the procedure.",! D RETURN S ECR=1 Q
 I '$D(^TMP("ECPRO",$J,+ANS)) W "   ** Invalid Number **" D RETURN S ECR=1 Q
 I $D(^TMP("ECPRO",$J,+ANS)) S ECPROC=+ANS,(ECDONE,ECHOICE)=1
 Q
