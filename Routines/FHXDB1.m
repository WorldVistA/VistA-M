FHXDB1 ; HISC/REL/NCA - Verify data base pointers (cont.) ;12/13/91  14:00 
 ;;5.5;DIETETICS;;Jan 28, 2005
 W !!,"Verifying file 119.71 - Production Facility"
 W !!,"Verifying file 119.72 - Service Point"
 F K=0:0 S K=$O(^FH(119.7,K)) Q:K<1  D D0
 W !!,"Verifying file 119.73 - Communication Office"
 W !!,"Verifying file 119.74 - Supplemental Feeding Site"
 F K=0:0 S K=$O(^FH(119.74,K)) Q:K<1  D SF
 W !!,"Verifying file 119.9 - Site Paramaters"
 W !!,"Verifying file 113 - Ingredients"
 F K=0:0 S K=$O(^FHING(K)) Q:K<1  D I0
 W !!,"Verifying file 114 - Recipes"
 F K=0:0 S K=$O(^FH(114,K)) Q:K<1  D R1
 W !!,"Verifying file 116 - Menu Cycle"
 F K=0:0 S K=$O(^FH(116,K)) Q:K<1  D C0
 W !!,"Verifying file 116.1 - Meals"
 F K=0:0 S K=$O(^FH(116.1,K)) Q:K<1  D R2
 W !!,"Verifying file 116.3 - Holiday Meals"
 F K=0:0 S K=$O(^FH(116.3,K)) Q:K<1  D C1
 G ^FHXDB2
I0 S X=^FHING(K,0),N=$P(X,"^",4) I N,'$D(^FH(113.2,N,0))#2 W !?5,"Vendor ",N," missing from Ingredient ",K," - ",$P(X,"^",1)
 S N=$P(X,"^",12) I N,'$D(^FH(113.1,N,0))#2 W !?5,"Storage Location ",N," missing from Ingredient ",K," - ",$P(X,"^",1)
 ;S N=$P(X,"^",21) I N,'$D(^FH(112,N,0))#2 W !?5,"Default Nutrient ",N," missing from Ingredient ",K," - ",$P(X,"^",1)
 Q
C0 F L=0:0 S L=$O(^FH(116,K,"DA",L)) Q:L<1  S X=^(L,0) F M=2:1:4 S N=$P(X,"^",M) I N,'$D(^FH(116.1,N,0))#2 W !?5,"Meal ",N," missing in Cycle ",K," Day ",L," - ",$P(^FH(116,K,0),"^",1)
 Q
C1 S X=^FH(116.3,K,0) F L=2:1:4 S N=$P(X,"^",L) I N,'$D(^FH(116.1,N,0))#2 W !?5,"Meal ",N," missing in Holiday Meals ",$E(K,4,5),"/",$E(K,6,7),"/",$E(K,2,3)," - ",$P(^FH(116.3,K,0),"^",5)
 Q
D0 F L=0:0 S L=$O(^FH(119.72,K,"A",L)) Q:L<1  S N=+^(L,0) I '$D(^FH(116.2,N,0))#2 W !?5,"Prod. Diet ",N," missing from Service Point ",K," - ",$P(^FH(119.72,K,0),"^",1)
 F L=0:0 S L=$O(^FH(119.72,K,"B",L)) Q:L<1  S N=+^(L,0) I '$D(^FH(116.2,N,0))#2 W !?5,"Prod. Diet ",N," missing from Service Point ",K," - ",$P(^FH(119.72,K,0),"^",1)
 S X=$G(^FH(119.72,K,0))
 S N=$P(X,"^",3) I N,'$D(^FH(119.71,N,0))#2 W !?5,"Production Facility ",N," missing from Service Point ",K," - ",$P(^FH(119.72,K,0),"^",1)
 Q
SF S N=$P(^FH(119.74,K,0),"^",3) I N,'$D(^FH(119.71,N,0))#2 W !?5,"Production Facility ",N," missing from Supplemental Fdg. Site ",K," - ",$P(^FH(119.74,K,0),"^",1)
 Q
R1 F L=0:0 S L=$O(^FH(114,K,"I",L)) Q:L<1  S N=+^(L,0) I '$D(^FHING(N,0))#2 W !?5,"Ingredient ",N," missing in Recipe ",K," - ",$P(^FH(114,K,0),"^",1)
 F L=0:0 S L=$O(^FH(114,K,"R",L)) Q:L<1  S N=+^(L,0) I '$D(^FH(114,N,0))#2 W !?5,"Embedded recipe ",N," missing in Recipe ",K," - ",$P(^FH(114,K,0),"^",1)
 S X=^FH(114,K,0)
 F L=0:0 S L=$O(^FH(114,K,"E",L)) Q:L<1  S N=+^(L,0) I '$D(^FH(114.4,N,0))#2 W !?5,"Equipment ",N," missing in Recipe ",K," - ",$P(X,"^",1)
 S N=$P(X,"^",6) I N,'$D(^FH(114.3,N,0))#2 W !?5,"Serving Utensil ",N," missing in Recipe ",K," - ",$P(X,"^",1)
 S N=$P(X,"^",7) I N,'$D(^FH(114.1,N,0))#2 W !?5,"Recipe Category ",N," missing in Recipe ",K," - ",$P(X,"^",1)
 S N=$P(X,"^",12) I N,'$D(^FH(114.2,N,0))#2 W !?5,"Preparation Area ",N," missing in Recipe ",K," - ",$P(X,"^",1)
 Q
R2 F L=0:0 S L=$O(^FH(116.1,K,"RE",L)) Q:L<1  S N=+^(L,0) D:$D(^FH(116.1,K,"RE",L,"D")) R3 I '$D(^FH(114,N,0))#2 W !?5,"Recipe ",N," missing in Meal ",K," - ",$P(^FH(116.1,K,0),"^",1)
 Q
R3 F X9=0:0 S X9=$O(^FH(116.1,K,"RE",L,"D",X9)) Q:X9<1  I '$D(^FH(119.72,X9)) W !?5,"Service Point ",X9," missing in Meal ",$P(^FH(116.1,K,0),"^",1),", Recipe ",$S($D(^FH(114,N,0)):$P(^(0),"^",1),1:N)
 Q:'$D(^FH(116.1,K,"RE",L,"R"))
 F CAT=0:0 S CAT=$O(^FH(116.1,K,"RE",L,"R",CAT)) Q:CAT<1  S MCA=+^(CAT,0) I '$D(^FH(114.1,MCA,0)) W !?5,"Recipe Category ",CAT," missing in Meal ",$P(^FH(116.1,K,0),"^",1),", Recipe ",$S($D(^FH(114,N,0)):$P(^(0),"^",1),1:N)
 Q
