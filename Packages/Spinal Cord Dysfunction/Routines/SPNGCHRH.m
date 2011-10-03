SPNGCHRH ;WDE/SD OUTCOME GRID FOR CHART 9/19/2002
 ;;2.0;Spinal Cord Dysfunction;**19**;01/02/1997
EN ;
 D CALC^SPNGCHRI
 I $D(SPNGOAL)=0 D ZAP^SPNOGRDA Q  ;no goal on fil
 I $G(SPNGOAL)="" D ZAP^SPNOGRDA  Q  ;no goal on file..
REASK ;
 W !,"You have entered an INPT REHAB FINISH or INPT FOLLOW/UP (END) or OUTPT"
 W !,"REHAB FINISH or OUTPT FOLLOW/UP (END) CHART for a patient who has a recorded"
 W !,"INPT GOAL or OUTPT GOAL CHART.  Do you want to see a comparison template you"
 W !,"can copy and paste into a CPRS progress note"
1 ;
ASK ;
 S %=2
 D YN^DICN
 I %=0 W !!,"Answer with Yes or No." W !,*7 G REASK
 I %=-1 Q
 Q:%=2
 ;D COPY1^SPNGCOPY  ;display the copy rights
 ;D CALC^SPNGCHRI
 I $D(IOF) W @IOF
 W !,"-------------------------------------------------------------------------"
 W !,"|",?11,"|",?13,"Physical",?22,"|",?24,"Cogntv",?31,"|"
 W ?33,"Mobility",?42,"|",?44,"Occ",?48,"|",?50,"Social",?57,"|",?59,"Econ",?64,"|",?66,"Total |"
 W !,"-------------------------------------------------------------------------"
 W !,"|",XA,?11,"|",?16,SPNR1C1,?22,"|",?27,SPNR1C2,?31,"|"
 W ?37,SPNR1C3,?41,"|",?44,SPNR1C4,?48,"|",?52,SPNR1C5,?57,"|"
 W ?60,SPNR1C6,?64,"|",?67,SPNR1C7,?72,"|"
 W !,"-------------------------------------------------------------------------"
 W !,"|Goal",?11,"|",?16,SPNR2C1,?22,"|",?27,SPNR2C2,?31,"|"
 W ?37,SPNR2C3,?41,"|",?44,SPNR2C4,?48,"|",?52,SPNR2C5,?57,"|",?60,SPNR2C6,?64,"|",?67,SPNR2C7,?72,"|"
 W !,"-------------------------------------------------------------------------"
 W !,"|Difference",?11,"|",?16,SPNR3C1,?22,"|",?27,SPNR3C2,?31,"|"
 W ?37,SPNR3C3,?41,"|",?44,SPNR3C4,?48,"|",?52,SPNR3C5,?57,"|",?60,SPNR3C6,?64,"|",?67,SPNR3C7,?72,"|"
 W !,"-------------------------------------------------------------------------"
 R !!?10,"Press Return to continue ",SPNREAD:DTIME
