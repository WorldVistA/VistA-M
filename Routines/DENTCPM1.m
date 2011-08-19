DENTCPM1 ;Wash/HCD,JED-Dental CPM Help Processing ; 11/6/87  3:36 PM ;
 ;VERSION 1.2
 ;
HLP4 D H W !!,?10,"A. Zero to two teeth",!,?10,"B. Three to five teeth",!,?10,"C. Six teeth or more" S B="A,B,C" D DERD I X=""!(X="^") Q
 S:X="A" DENTAPT=0 S:X="B" DENTAPT=1
 I X["C" W !!,?10,"A. Heavy calculus",!,?10,"B. Nominal calculus" S B="A,B" D DERD S:X["A" DENTAPT=2 S:X["B" DENTAPT=1
 G:DENTAPT="" HLP4 S DENTS=3 D DEAPPT Q
HLP6 D H W !!,?10,"A. Less than six teeth",!,?10,"B. Six teeth or more" S B="A,B" D DERD I X=""!(X="^") Q
 I X["A" S DENTAPT=0,DENTS=5 D DEAPPT Q
HLP6A G:X'["B" HLP6 W !!,?10,"Is there a moderate, severe or acute periodontal condition" S %=1 D YN^DICN G HLP6A:%=0 I %=1 S DENTAPT=6,DENTS=5 D DEAPPT Q
 W !!,?10,"A. Patient's Age 40 to 60 years old",!,?10,"B. Patient's age under 40 years old" S B="A,B" D DERD I X=""!(X="^") Q
 I X["A" S DENTAPT=1,DENTS=5 D DEAPPT Q
 W !!,?10,"Are there:",!!,?10,"A. Three or more sextants to receive C&B",!,?10,"B. Less than three sextants to receive C&B" S B="A,B" D DERD I X=""!(X="^") Q
 I X["A" S DENTAPT=1,DENTS=5 D DEAPPT Q
HLP6B W !!,?10,"Is Gingivitis present" S %=1 D YN^DICN G HLP6B:%=0 S DENTAPT=$S(%=1:1,1:0),DENTS=5 D DEAPPT Q
HLP8 D H W !!,?10,"Enter the number (from 1 to 8) of anterior and",!,?10,"bicuspids to receive ENDODONTIC treatment" D DERD I X=""!(X="^") Q
 I X'?.N!(X<1)!(X>8) W *7 G HLP8
 S A=3 S:X>4 A=4 S:X=0 A=0 I X=1!(X=2) S A=2
HLP8A W !!,?10,"Enter the number (from 1 to 12) of molars to receive ENDO treatment" D DERD I X=""!(X="^") Q
 I X'?.N!(X<1)!(X>12) W *7 G HLP8A
 S DENTAPT=A+$S(X=0:0,X=1:2,X=2:3,1:4),DENTS=7 D DEAPPT Q
HLP10 D H W !!,?10,"Enter the number (from 1 to 6) of sextants to receive RESTORATIONS" D DERD I X=""!(X="^") Q
 I X'?.N!(X<1)!(X>6) W *7 G HLP10
 S:X<4 DENTAPT=X S:X>3 DENTAPT=X+1 S DENTS=9 D DEAPPT Q
HLP12 D H W !!,?10,"A. Extractions",!,?10,"B. Other Procedures",!,?10,"C. Extractions and other" S B="A,B,C" D DERD I X=""!(X="^") Q
 G:"ABC"'[X HLP12 I X["B" S DENTAPT=2,DENTS=11 D DEAPPT Q
 S A=0 S:X["C" A=2 W !!,?10,"A. 1 to 6 teeth to be extracted",!,?10,"B. 6 or more teeth to be extracted" S B="A,B" D DERD I X["A" S DENTAPT=A+1,DENTS=11 D DEAPPT Q
 I X["B" S DENTAPT=A+2,DENTS=11 D DEAPPT Q
 G HLP12
HLP14 D H W !!,?10,"Enter the number (from 1 to 6) of sextants to receive C&B" D DERD I X=""!(X="^") Q
 I X'?.N!(X<1)!(X>6) W *7 G HLP14
 S:X=0 DENTAPT=0 S:X>0 DENTAPT=X*3 S DENTS=13 D DEAPPT Q
HLP16 D H W !!,?10,"The patient is in need of:",!,?10,"A. A new removable prosthetic",!,?10,"B. A rebased prosthetic",!,?10,"C. No removable prosthetic" S B="A,B,C" D DERD I X=""!(X="^") Q
 S:X["A" DENTAPT=0 S:X["B" DENTAPT=5 S:X["C" DENTAPT=2 G:DENTAPT="" HLP16
 S DENTS=15 D DEAPPT Q
H W !!,?10,"Answering the following question will calculate the",!,?10,"number of appointments necessary for this category." Q
DEAPPT W !!,"With the information provided, ",DENTAPT," appointment"_$S(DENTAPT=1:" was",1:"s were")," calculated to be necessary.",! W:DENTAPT "This value has been entered.",!
 S:DENTAPT $P(^DENT(220,D0,9,DA,0),"^",DENTS)=DENTAPT,DE(DQ)=DENTAPT K %,A,DENTS,X,DENTAPT Q
DERD S DENTAPT="" R !!,?10,"Enter your selection here: ",X:DTIME Q:X=""!(X="^")  I X["?" D Q G DERD
 I $D(B),B'[X W *7 D Q G DERD
 K B Q
Q W !,?10,"Select ",B," or press return to exit this set of questions." Q
