SRSIND ;B'HAM ISC/MAM - INDICATIONS FOR OPERATION ; 14 NOV 1989  12:35
 ;;3.0; Surgery ;;24 Jun 93
 W !!,"Please enter a brief statement of the indications for this operative",!,"procedure.  It is mandatory that you provide this information before",!,"proceeding with this request."
ASK W !!,"Do you want to continue with this request ?  YES//  " R SRYN:DTIME I '$T!(SRYN="^") K SRTN Q
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN to re-enter the indications for operation and continue with this",!,"request, or 'NO' if you do not want to continue with the request." G ASK
 I "Yy"[SRYN Q
 S DA=SRTN,DIK="^SRF(" D ^DIK K SRTN
 Q
