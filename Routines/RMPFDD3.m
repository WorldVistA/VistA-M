RMPFDD3 ;DDC/KAW-ENTER/EDIT ELIGIBILITY [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;;JUN 16, 1995
 ;; input: DFN
 ;;output:
 D PAT^RMPFUTL
 W @IOF,!?29,"ENTER/EDIT ELIGIBILITY"
 W !!,"Patient: ",RMPFNAM,?40,"SSN: ",RMPFSSN,?63,RMPFDOB,!
 F I=1:1:79 W "-"
 W !!,"Eligibility for ROES transactions cannot be determined from the DHCP database",!,"for this veteran."
E0 W !!,"Do you wish to enter an eligibility? YES// "
 D READ G END:$D(RMPFOUT)
E01 I $D(RMPFQUT) W !!,"Enter a <Y> if you wish to select an eligibility",!?6,"a <N> if you wish to exit" G E0
 S:Y="" Y="Y" S Y=$E(Y,1) I "YyNn"'[Y S RMPFQUT="" G E01
 G END:"Nn"[Y
E1 W ! S DIC=791810.4,DIC(0)="AEQM" D ^DIC G END:Y=-1
 S RMPFELG=+Y,RMPFELGD=$P(Y,U,2)
END Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1U.E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
