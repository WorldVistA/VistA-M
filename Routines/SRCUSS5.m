SRCUSS5 ;B'HAM ISC/MAM - SCREEN SERVER HELP ; [ 03/11/02  13:45 PM ]
 ;;3.0; Surgery ;**66,108**;24 Jun 93
QUES Q:$D(Q3("VIEW"))  W !!,"Enter "_Q(1,Q)_"N to enter only the top level of this multiple, or the number",!,"of your choice followed by an 'R' to make a duplicate entry.",!
 W !,"Press <RET> to continue  " R SRQUIT:DTIME I SRQUIT["?" W !!,"No need to ask, we will continue. "
 Q
