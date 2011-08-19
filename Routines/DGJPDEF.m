DGJPDEF ;ALB/MAF - PHYSICIAN DEFICIENCY PRINT ROUTINE ; NOV 10 1992@300
 ;;1.0;Incomplete Records Tracking;;Jun 25, 2001
OUT S (DGJFL,DGJTMESS)=0 W !!,"Sort output by: PATIENT// " D ZSET1 S X="" R X:DTIME G QUIT:X="^"!('$T) I X=""!("Pp"[X) S X="3"
 S X=$S("Dd"[X:1,"Ss"[X:2,1:X)
 I X="?" D ZSET1,HELP1 G OUT
 S DGJTSR=$E(X) D IN^DGJHELP W ! I %=-1 D ZSET1,HELP1 G OUT
OUT1 S DGJFL=0 W !!,"Print report for: (I)Inpatients, (O)Outpatients, (B)Both//  " D ZSET2 S X="" R X:DTIME G QUIT:X="^"!('$T) I X=""!("Bb"[X) S X=3
 S X=$S("Ii"[X:1,"Oo"[X:2,1:X)
 I X="?" D ZSET2,HELP2 G OUT1
 S DGJTSR1=$E(X) D IN^DGJHELP W ! I %=-1 D ZSET2,HELP2 G OUT1
 I $D(^DG(43,1,"GL")) S DGJTMUL=$P(^DG(43,1,"GL"),"^",2)
 S DGJTLPG=1
 I $D(^DG(43,1,"GL")) S DGJTMUL=$P(^DG(43,1,"GL"),"^",2)
 S DGJTL=$S(DGJTSR=1:"PHY",DGJTSR=2:"SER",DGJTSR=3:"PAT",1:"QUIT")
 G ^DGJPDEF1
DAT ;DATE RANGE
BEG W ! S %DT="AEX",%DT("A")="START WITH EVENT DATE: " D ^%DT S DGJTBG=Y,DGJTBEG=Y-.0001 S:X="^"!(X="") Y=-1 Q:Y=-1
END W ! S %DT("A")="END WITH EVENT DATE: " D ^%DT S:X="^"!(X="") Y=-1 Q:Y=-1  I Y<1 D HELP^%DTC G END
 S DGJTEND=Y_.9999
 I DGJTEND\1<DGJTBG W !!?5,"The ending date cannot be before the beginning date" G END
 Q
ASK1 S DGJDSC=0 W !!,"Display Summary Deficiencies if patient has not been discharged?" S %=1 D YN^DICN I '% D HLP G ASK1
 I %=-1 S Y=% Q
 I %=2 S DGJDSC=1
 Q
QUIT K %,BY,DHD,DIC,DIOEND,DIS,DIR,DTOUT,DUOUT,FR,FLDS,IFN,K,L,TO,DGJTCK,DGJTDIR,DGJTL,DGJTLPG,DGJTMESS,DGPGM,DGJTMUL,DGJTSR,DGJTSTAT,DGJTUN,POP,DGU,DGJTQF,DGJTDEL,VAUTN,DGJFL,DGJTSR1,DGJ(0),RT,RTDATA,RTE,RTYPE,VAERR,VADATE,VAUTD,VAUTT,X,Y,Z
 K DGJDSC,DFN,DGFLAG,DGJ,DGJADM,DGJJ,DGJTDAT,DGJTDIV,DGJTDL,DGJTDT,DGJTDV,DGJTDV1,DGJTDVN,DGJTF,DGJTFF,DGJTLN,DGJTNODE,DGJTOT,DGJTPAG,DGJTPHY,DGJTPT,DGJTSP,DGJTSV,DGJY,DGVAR,VA,VADAT,VAUTY,^TMP("VAS",$J),DGJTBG,DGJTBEG,DGJTEND,%DT
 D CLOSE^DGJUTQ Q
HELP1 W !!,"Choose a number or first initial :" F K=2:1:4 W !?15,$P(Z,"^",K)
 W ! Q
HELP2 W !!,"Choose a number or first initial:" F K=2:1:4 W !?15,$P(Z,"^",K)
 W ! Q
HLP W !!,"ENTER:"
 W !?10,"Y - YES, if you would like the report to print Deficiencies under",!?10,"    the category SUMMARY if the patient has not been discharged."
 W !!?10,"N - NO, if you would not like the report to print Deficiencies under",!?10,"    the category SUMMARY if the patient has not been discharged."
 Q
ZSET1 S Z="^1 DOCTOR^2 SERVICE/TREATING SPECIALTY^3 PATIENT^" Q
ZSET2 S Z="^1 INPATIENTS ONLY^2 OUTPATIENTS ONLY^3 BOTH INPATIENT and OUTPATIENTS^" Q
SEL S DIR("A")="Select INCOMPLETE RECORD STATUS: ",DIR(0)="SA^A:ALL;D:UNDICTATED;T:NOT TRANSCRIBED;S:UNSIGNED;R:NOT REVIEWED",DIR("B")="ALL"
 S DIR("?")="Enter desired status that you would like to have listed on the report"
 S DIR("?",1)="CHOOSE FROM: "
 S DIR("?",2)="   A FOR ALL",DIR("?",3)="   D FOR UNDICTATED",DIR("?",4)="   T FOR NOT TRANSCRIBED",DIR("?",5)="   S FOR UNSIGNED",DIR("?",6)="   R FOR NOT REVIEWED" D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q
 I Y="A" S DGJTSTAT="^"_$O(^DG(393.2,"B","INCOMPLETE",0))_"^"_$O(^DG(393.2,"B","DICTATED",0))_"^"_$O(^DG(393.2,"B","TRANSCRIBED",0))_"^"_$O(^DG(393.2,"B","SIGNED",0))_"^" Q
 S DGJTSTAT="^"
 D SET
 S $P(DIR(0),"^",1)=$P(DIR(0),"^",1)_"O",$P(DIR(0),"^",2)=$E($P(DIR(0),"^",2),7,999) K DIR("B")
 F I=2:1:6 S DIR("?",I)=$S($D(DIR("?",I+1)):DIR("?",I+1),1:"")
 S DIR("A")="Select another STATUS: "
ASK D ^DIR I $D(DUOUT)!$D(DTOUT) Q
 I X]"" D SET G ASK
 Q
SET S X=$S(Y="D":"INCOMPLETE",Y="T":"DICTATED",Y="S":"TRANSCRIBED",Y="R":"SIGNED",Y="C":"r",1:"INCOMPLETE")
 S X=$O(^DG(393.2,"B",X,0))
 S DGJTSTAT=DGJTSTAT_X_"^"
 Q
CK S X=Y Q
