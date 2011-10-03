SRSLOOK1 ;B'HAM ISC/MAM - ICD DIAGNOSIS LOOK-UP ; 17 MAR 1992 8:45 am
 ;;3.0; Surgery ;;24 Jun 93
START S SRSOUT=0 W @IOF,!!,"Based on the free-text procedure name entered, the computer will attempt to",!,"match the appropriate ICD Diagnosis Code."
 W !!,"Do you want to select the ICD Diagnosis Code now ?  YES// " R SRYN:DTIME I '$T!(SRYN["^") K SRICDD Q
 S SRYN=$E(SRYN) I "YyNn"'[SRYN D HELP G START
 I "Yy"'[SRYN K SRICDD Q
 W @IOF,!,"Looking for potential ICD Diagnosis Codes based on the entire ",!,"free-text procedure name...",! K DIC S DIC=80,DIC(0)="QEMZ",X=SRDIAG D ^DIC I Y>0 S SRICDD=+Y Q
 S SRYN="Y" I $P(SRDIAG," ",2)'="" D FIRST I SRSOUT S SRSOUT=0 Q
 I $D(SRICDD) Q
 K DIC,X,Y S X="",DIC=80,DIC(0)="QEAMZ",DIC("A")="Select Principal Diagnosis Code (ICD Diagnosis): " W ! D ^DIC I Y>0 S SRICDD=+Y
 Q
HELP W !!,"Enter 'YES' to utilize the computer for selecting the correct ICD Diagnosis ",!,"code based on your free-text procedure name, or if you'd like to select ",!,"the code on your"
 W " own.  Enter 'NO' to skip entering the CPT code and go on",!,"to the next prompt.",!!,"Press RETURN to continue  " R X:DTIME
 Q
FIRST ; search on first word of text
 I $P(SRDIAG," ")["REPAIR" D REPAIR Q
 W !!,SRDIAG,!!,"Do you want to search for the correct CPT code based on the first word",!,"of your free-text procedure name ? YES// " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 Q
 S SRYN=$E(SRYN)
 I "YyNn"'[SRYN W !!,"Enter 'YES' to search for the appropriate ICD Diagnosis code based on the first ",!,"word of your free-text procedure name.  Enter 'NO' to select a CPT code on ",!,"your own." G FIRST
 I "Yy"[SRYN W !!,"Looking for potential ICD Diagnosis Codes based on the first word ",!,"in your text...",! K DIC S DIC=80,DIC(0)="QEMZ",X=$P(SRDIAG," ") D ^DIC I Y>0 S SRICDD=+Y Q
 Q
REPAIR ; search on remainder of text without 'REPAIR'
 S SRDIAG1=SRDIAG,SRDIAG=$P(SRDIAG," ",2,200) W !!,"Searching ICD Diagnosis Codes to match with "_SRDIAG_"..."
 K DIC S DIC=80,X=SRDIAG,DIC(0)="QEMZ" D ^DIC I Y>0 S SRSCPT=+Y
 S SRDIAG=SRDIAG1 K SRDIAG1
 Q
