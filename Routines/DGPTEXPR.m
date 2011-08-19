DGPTEXPR ;ALB/MTC - PTF Expanded Code List ; 14 MAY 91
 ;;5.3;Registration;;Aug 13, 1993
 ;;MAS 5.1;
 ;
EN ;-- entry point for Expanded Code List
 D INIT G:DGOUT ENQ
 W @IOF,!,"PTF Expanded Code List   "
 S L="",DIC="^DIC(45.89,",FLDS="[DGPT EXPANDED CODE LIST]",BY="[DGPT EXPANDED CODE SORT]",PG=1
 D EN1^DIP
ENQ ;
 K L,DIC,FLDS,BY,FR,PG
 Q
 ;
INIT ;
 S DGOUT=0
 D LO^DGUTL,HOME^%ZIS
 Q
