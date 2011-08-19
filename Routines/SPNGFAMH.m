SPNGFAMH ;WDE/SD OUTCOME GRID FOR FAM 9/19/2002
 ;;2.0;Spinal Cord Dysfunction;**19**;01/02/1997
EN ;
 D CALC^SPNGFAMI  ;Create the values for the grid
 I SPNGOAL="" D ZAP Q
REASK ;
 W !!,"You have entered an INPT REHAB FINISH or INPT FOLLOW/UP (END) or OUTPT"
 W !,"REHAB FINISH or OUTPT FOLLOW/UP (END) FAM for a patient who has a recorded"
 W !,"INPT GOAL or OUTPT GOAL FAM.  Do you want to see a comparison template you"
 W !,"can copy and paste into a CPRS progress note"
ASK ;
 S %=2
 D YN^DICN
 I %=0 W !!,"Answer with Yes or No." W !,*7 G REASK
 I %=-1 Q
 Q:%=2
 ;D COPY1^SPNGCOPY  ;display the copy rights
 I $D(IOF) W @IOF
 W !,"-------------------------------------------------------------------------"
 W !,"|",?11,"|",?13,"Swallow",?21,"|",?23,"Car Txfrs",?33,"|"
 W ?35,"Community",?45,"|",?47,"Reading",?55,"|",?57,"Write",?63,"|",?65,"Speech |"
 W !,"-------------------------------------------------------------------------"
 W !,"|",XA,?11,"|",?16,SPNR1C1,?21,"|",?27,SPNR1C2,?33,"|"
 W ?40,SPNR1C3,?45,"|",?50,SPNR1C4,?55,"|",?59,SPNR1C5,?63,"|",?68,SPNR1C6,?72,"|"
 W !,"-------------------------------------------------------------------------"
 W !,"|Goal",?11,"|",?16,SPNR2C1,?21,"|",?27,SPNR2C2,?33,"|"
 W ?40,SPNR2C3,?45,"|",?50,SPNR2C4,?55,"|",?59,SPNR2C5,?63,"|",?68,SPNR2C6,?72,"|"
 W !,"-------------------------------------------------------------------------"
 W !,"|Difference",?11,"|",?16,SPNR3C1,?21,"|",?27,SPNR3C2,?33,"|"
 W ?40,SPNR3C3,?45,"|",?50,SPNR3C4,?55,"|",?59,SPNR3C5,?63,"|",?68,SPNR3C6,?72,"|"
 W !,"-------------------------------------------------------------------------"
 W !
 W !,"-------------------------------------------------------------------"
 W !,"|",?11,"|",?13,"Emot",?18,"|",?20,"Adjust",?27,"|"
 W ?29,"Employ",?36,"|",?38,"Orientation",?50,"|",?52,"Attn",?57,"|",?59,"Safety",?66,"|"
 W !,"-------------------------------------------------------------------"
 W !,"|",XA,?11,"|",?15,SPNR4C1,?18,"|",?23,SPNR4C2,?27,"|"
 W ?32,SPNR4C3,?36,"|",?43,SPNR4C4,?50,"|",?54,SPNR4C5,?57,"|"
 W ?62,SPNR4C6,?66,"|"
 W !,"-------------------------------------------------------------------"
 W !,"|Goal",?11,"|",?15,SPNR5C1,?18,"|",?23,SPNR5C2,?27,"|"
 W ?32,SPNR5C3,?36,"|",?43,SPNR5C4,?50,"|",?54,SPNR5C5,?57,"|"
 W ?62,SPNR5C6,?66,"|"
 W !,"-------------------------------------------------------------------"
 W !,"|Difference",?11,"|",?15,SPNR6C1,?18,"|",?23,SPNR6C2,?27,"|"
 W ?32,SPNR6C3,?36,"|",?43,SPNR6C4,?50,"|",?54,SPNR6C5,?57,"|"
 W ?62,SPNR6C6,?66,"|"
 W !,"-------------------------------------------------------------------"
 R !!?10,"Press Return to continue ",SPNREAD:DTIME
 Q
ZAP ;
