SPNGDINH ;WDE/SD OUTCOME GRID FOR DIENER 9/19/2002
 ;;2.0;Spinal Cord Dysfunction;**19**;01/02/1997
EN ;
 D CALC
 I SPNGOAL="" Q
REASK W !,"You have entered an INPT REHAB FINISH or INPT FOLLOW/UP (END) or OUTPT"
 W !,"REHAB FINISH or OUTPT FOLLOW/UP (END) DIENER for a patient who has a recorded"
 W !,"INPT GOAL or OUTPT GOAL DIENER.  Do you want to see a comparison template you"
 W !,"can copy and paste into a CPRS progress note"
ASK ;
 S %=2
 D YN^DICN
 I %=0 W !!,"Answer with Yes or No." W !,*7 G REASK
 I %=-1 Q
 Q:%=2
 ;D COPY1^SPNGCOPY  ;display the copy rights
 I $D(IOF) W @IOF
 W !,"---------------------------------"
 W !,"|               |    SWLS       |"
 W !,"---------------------------------"
 W !,"|",XA,?16,"|",?22,SPNR1C1,?32,"|"
 W !,"---------------------------------"
 W !,"|Goal",?16,"|",?22,SPNR2C1,?32,"|"
 W !,"---------------------------------"
 W !,"|Difference",?16,"|",?22,$J(SPNR3C1,2),?32,"|"
 W !,"---------------------------------"
 W !!,"Comments:"
 R !!?10,"Press Return to continue ",SPNREAD:DTIME
 Q
CALC ;
 S SPNGOAL=""
 S SPNXX=0 F  S SPNXX=$O(^TMP($J,SPNXX)) Q:SPNXX=""  S SPNYY=0 F  S SPNYY=$O(^TMP($J,SPNXX,SPNYY)) Q:SPNYY=""  S SPNZZ=0 F  S SPNZZ=$O(^TMP($J,SPNXX,SPNYY,SPNZZ)) Q:SPNZZ=""  D  Q:+SPNGOAL
 .I $P(^SPNL(154.1,SPNZZ,0),U,2)=6 I 27[$P(^SPNL(154.1,SPNZZ,2),U,17) S SPNGOAL=SPNZZ
 I SPNGOAL="" S SPNMSG="There is no DIENER start Outcome on file." Q
 S XA=$S(SPNRSCO=4:"Finish",SPNRSCO=5:"F/U (END)",SPNRSCO=9:"Finish",SPNRSCO=10:"F/U (END)",1:"ERROR")
 S SPNR1C1=$P($G(^SPNL(154.1,DA,"SCORE")),U,1) I SPNR1C1="" S SPNR1C1=0
 S SPNR2C1=$P($G(^SPNL(154.1,SPNGOAL,"SCORE")),U,1) I SPNR2C1="" S SPNR2C1=0
 S SPNR3C1=SPNR1C1-SPNR2C1
 Q
ZAP ;
