SRSLOOK ;B'HAM ISC/MAM - CPT LOOK-UP ; 16 MAR 1992 1:00 pm
 ;;3.0; Surgery ;;24 Jun 93
START S SRSOUT=0 W @IOF,!!,"Based on the free-text procedure name entered, the computer will attempt to",!,"match the appropriate CPT Code."
 W !!,"Do you want to select the CPT Code now ?  YES// " R SRYN:DTIME I '$T!(SRYN["^") K SRSCPT Q
 S SRYN=$E(SRYN) I "YyNn"'[SRYN D HELP G START
 I "Yy"'[SRYN K SRSCPT Q
 W @IOF,!,"Looking for potential CPT Codes based on the entire free-text procedure name...",! K DIC S DIC=81,DIC(0)="QEMZ",DIC("S")="I '$P(^ICPT(Y,0),""^"",4)",X=SRSOP D ^DIC I Y>0 S SRSCPT=+Y Q
 S SRYN="Y" I $P(SRSOP," ",2)'="" D FIRST I SRSOUT S SRSOUT=0 Q
 I $D(SRSCPT) Q
CPT K DIC,X,Y S X="",DIC=81,DIC("S")="I '$P(^ICPT(Y,0),""^"",4)",DIC(0)="QEAMZ",DIC("A")="Select Principal Operation Code (CPT): " W ! D ^DIC I Y>0 S SRSCPT=+Y
 Q
HELP W !!,"Enter 'YES' to utilize the computer for selecting the correct CPT code based",!,"on your free-text procedure name, or if you'd like to select the code on your"
 W !,"own.  Enter 'NO' to skip entering the CPT code and go on to the next prompt.",!!,"Press RETURN to continue  " R X:DTIME
 Q
FIRST ; search on first word of text
 I $P(SRSOP," ")["REPAIR" D REPAIR Q
 W !!,SRSOP,!!,"Do you want to search for the correct CPT code based on the first word",!,"of your free-text procedure name ? YES// " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 Q
 S SRYN=$E(SRYN)
 I "YyNn"'[SRYN W !!,"Enter 'YES' to search for the appropriate CPT code based on the first word of",!,"your free-text procedure name.  Enter 'NO' to select a CPT code on your own." G FIRST
 I "Yy"[SRYN W !!,"Looking for potential CPT Codes based on the first word in your text...",! K DIC S DIC=81,DIC("S")="I '$P(^ICPT(Y,0),""^"",4)",DIC(0)="QEMZ",X=$P(SRSOP," ") D ^DIC I Y>0 S SRSCPT=+Y Q
 Q
REPAIR ; search on remainder of text without 'REPAIR'
 S SRSOP1=SRSOP,SRSOP=$P(SRSOP," ",2,200) W !!,"Searching CPT Codes to match with "_SRSOP_"..."
 K DIC S DIC=81,DIC("S")="I '$P(^ICPT(Y,0),""^"",4)",X=SRSOP,DIC(0)="QEMZ" D ^DIC I Y>0 S SRSCPT=+Y
 S SRSOP=SRSOP1 K SRSOP1
 Q
