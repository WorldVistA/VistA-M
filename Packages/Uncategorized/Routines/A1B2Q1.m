A1B2Q1 ;JLU/ALB-Contains the logic for the print templates.;1/14/91
 ;;Version 1.55 (local for MAS v5 sites);;
PG D HOME^%ZIS W @IOF
 Q
 ;
E S DIR(0)="E" D ^DIR K DIR W !!
 Q
 ;
A ;Entry point for inpatient list.
 D PG
 W !!!!!!!,*7,"      *** The following report will list ALL the current Admissions. ***      ",!!!!!
 D E I 'Y Q
 S L=0,DIC="^A1B2(11500.2,",FLDS="[A1B2 OUTPUT1]",BY="[A1B2 OUTPUT1]",A1B2FL=11500.2 D DIS^A1B2UTL,EN1^DIP,EX
 Q
 ;
B ;Entry point for dump list.
 W !!!!!,*7,?7,"The following report will list all: ","ADMISSIONS",!,?43,"REGISTRATIONS",!,?43,"DISCHARGES",!!,?7,"  *** This report could be very large. ***",!!!!
 D E I 'Y Q
 S %IS="NQM" D ^%ZIS K %IS,IOP I POP D EX Q
 S ZTIO=ION
 I $D(IO("Q"))!(IO'=IO(0)) W !!,"I will queue this report." S ZTRTN="B1^A1B2Q1",ZTDESC="ODS REPORTS" D ^%ZTLOAD D EX Q
B1 S L=0,IOP=ZTIO,DIC="^A1B2(11500.2,",FLDS="[A1B2 OUTPUT2]",BY="[A1B2 OUTPUT2]",A1B2FL=11500.2 D DIS^A1B2UTL,EN1^DIP
B2 S IOP=ZTIO,DIC="^A1B2(11500.4,",FLDS="[A1B2 OUTPUT2]",BY="[A1B2 OUTPUT2]",A1B2FL=11500.4 D DIS^A1B2UTL,EN1^DIP
 D EX
 Q
 ;
EX K DIC,L,FLDS,BY,DIS,A1B2IOP,POP,IOP,Y,ZTDESC,ZTIO,ZTRTN,A1B2FL
 X ^%ZIS("C")
 Q
