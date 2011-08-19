ECTSBED ;B'ham ISC/PTD-Bedsection Workload Report ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;;
 I '$D(^DGAM(334)) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"The 'AMIS 334-341' File - #42.6 is not loaded on your system.",!! S XQUIT="" Q
 I '$O(^DGAM(334,0)) W *7,!!,"'AMIS 334-341' File - #42.6 has not been populated on your system.",!! S XQUIT="" Q
 ;CHOOSE ALL SEGMENTS OR A SINGLE SEGMENT
CHS W !!,"You may choose to print the report for:",!!,"1.  A selected AMIS segment.",!?10,"OR",!,"2.  All AMIS segments.",!!,"Select a number (1 or 2): "
 R CHS:DTIME G:'$T!("^"[CHS) EXIT I CHS'?1N!(CHS<1)!(CHS>2) W !!,*7,"You MUST answer ""1"" or ""2""." G CHS
 ;IF CHS=2, THEN SORT BY DATE FOR ALL SEGMENTS; ELSE SORT BY DATE FOR A SELECTED SEGMENT
 S QFLG=0 D SGMT G:QFLG EXIT
DIP S DIC="^DGAM(334,",L=0,FLDS="10,.01,10,.01;L25,18,(#5+#6+#7+#8);R6;""DISCHARGES"",(#12+#21);""PATIENT DAYS OF CARE"""
 S BY=$S(CHS=2:"#+.01,10,.01",1:".01,10,.01")
 S DHD="BEDSECTION WORKLOAD REPORT" D EN1^DIP
EXIT K ANS,B,BY,CHS,DHD,DIC,ECT1,FLDS,FR,J,L,QFLG,SGMT,TO,X,Y
 Q
 ;
SGMT ;SET FR,TO VARIABLES
 I CHS=2 S (FR,TO)="?" Q
PICK W !!,"Choose the SEGMENT to SORT BY:",!,"1.  PSYCHIARTY",!,"2.  INTERMEDIATE",!,"3.  MEDICINE",!,"4.  NEUROLOGY",!,"5.  REHAB MEDICINE",!,"6.  BLIND REHAB",!,"7.  SPINAL CORD INJURY",!,"8.  SURGERY",!!,"Select a number (1 - 8): "
 R ANS:DTIME S:'$T!("^"[ANS) QFLG=1 Q:QFLG  I ANS'?1N!(ANS<1)!(ANS>8) W !!,*7,"You MUST answer with a number from 1 to 8." G PICK
 S SGMT=$S(ANS=8:341,ANS=7:340,ANS=6:339,ANS=5:338,ANS=4:337,ANS=3:336,ANS=2:335,1:334)
 S (FR,TO)="?,"_SGMT
 Q
 ;
