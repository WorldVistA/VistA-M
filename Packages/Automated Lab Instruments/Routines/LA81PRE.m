LA81PRE ;VMP/RB-PURGE ALL INVALID VITEK NODES ^LRO(68,12,1,DATE,1,ACC#,1,4,WKLD CD,0) 1/7/2013
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**81**;Sep 27, 1994;Build 2
 ;;
 ;  Pre install routine in patch LA*5.2*81 that will purge erroneous
 ;  entries in file# 68 that were caused by an incorrect node set
 ;  when the results were set into file #68 for VITEK.
 ;
 ;Kill example: ^LRO(68,12,1,2980000,1,1596,1,4,1142,0)="^^52;1;3"
 ;Also, will check correct node ^LRO(68,12,1,2980000,1,1596,4,1142,0)
 ;to insure piece 3 is set. If not, will move erroneous node piece 3 to correct node:
 ;ex. ^LRO(68,12,1,2980000,1,1596,4,1142,0)="1142^9^^1315^2980224^^1^7087"
 ;;
 Q
START N LRSTART,IEN68,LREND,LRAA,LRAD,LRAN,LRTEST,LRBAD,LRGOOD,TOT,TOT1,TOT2,TOT3,DATA
 I $D(^XTMP("LA81PRE")) Q
 D NOW^%DTC S LRSTART=%
 S ^XTMP("LA81PRE","START COMPILE")=LRSTART
 S ^XTMP("LA81PRE","END COMPILE")="RUNNING"
 S ^XTMP("LA81PRE",0)=$$FMADD^XLFDT(LRSTART,120)_"^"_LRSTART
 S U="^",LRAA=0,(TOT,TOT1,TOT2,TOT3)=0
1 S LRAA=$O(^LRO(68,LRAA)),LRAD=0 G EXIT:+LRAA=0
2 S LRAD=$O(^LRO(68,LRAA,1,LRAD)),LRAN=0 G 1:'LRAD
3 S LRAN=$O(^LRO(68,LRAA,1,LRAD,1,LRAN)),LRTEST=0 G 2:'LRAN
 S TOT=TOT+1
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,1,4)) G 3
4 S LRTEST=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,1,4,LRTEST)) G 3:'LRTEST
 S TOT1=TOT1+1
 S LRBAD=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,1,4,LRTEST,0)) G 3:LRBAD=""
 S LRGOOD=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTEST,0))
 I LRGOOD'="" D
 . I $P(LRGOOD,U,3)'="" Q
 . S DATA=$P(LRBAD,U,3)
 . S DA=LRTEST,DR="2///^S X=DATA"
 . S DIE="^LRO(68,LRAA,1,LRAD,1,LRAN,4," D ^DIE K DIE,DA,DR
 . S ^XTMP("LA81PRE",68,LRAA,1,LRAD,1,LRAN,1,4,LRTEST,1)=^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTEST,0)
 . S TOT2=TOT2+1
 S ^XTMP("LA81PRE",68,LRAA,1,LRAD,1,LRAN,1,4,LRTEST,0)=^LRO(68,LRAA,1,LRAD,1,LRAN,1,4,LRTEST,0)
 K ^LRO(68,LRAA,1,LRAD,1,LRAN,1,4,LRTEST,0)
 S TOT3=TOT3+1
 G 4
EXIT ;
 D NOW^%DTC S LREND=%
 S ^XTMP("LA81PRE","TOTALS")=TOT_U_TOT1_U_TOT3
 S ^XTMP("LA81PRE","END COMPILE")=LREND
 W !!,"Number of File #68 accessions reviewed: ",TOT
 W !!,"Number of erroneous nodes found: ",TOT1
 W !!,"Number of good node 4 recs updated with DELETED rec field LOAD LIST ENTRY: ",TOT2
 W !!,"Number of erroneous nodes killed: ",TOT3
 K %
 Q