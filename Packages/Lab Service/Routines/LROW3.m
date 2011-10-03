LROW3 ;DALOI/CJS - LIST THE TESTS ORDERED AND ALLOW EDITING ;Mar 23, 2004
 ;;5.2;LAB SERVICE;**33,121,286**;Sep 27, 1994
L ;
 ; Only ask nature of order for CPRS - file #2 patients.
 I $G(LRDPF,2)=2 D  Q:'$D(LRNATURE)
 . D NATURE
 . I $G(LRNATURE)=-1 W !!,$C(7),"...process aborted" S %="^" K LRNATURE
 D L3
 W !!,"All satisfactory" S %=1 D YN^DICN D:%=0 HELP G:%=0 L Q:%'=2
L1 W !,"Delete test entry no.: " R X:DTIME W:X["?" !,"Select entry number to be deleted." W:X'?.N !,"Select one entry at a time." D L3:X["?" G L1:X["?"!(X'?.N)
 I X'="",'$D(J(+X)) W !!?5,$C(7),"( "_X_" ) Is not a valid entry number " G LROW3
 I X'="" S X=+X S LRSAMP=$P(J(X),U),LRTEST=$P(J(X),U,2) D X3 G L1
L1A W !!,"Add more tests" S %=2 D YN^DICN D:%=0 HELP G:%=0 L1A I %=1 D L2^LROW1
 G LROW3
 ;
 ;
L2 S LRSAMP=$S($D(^LAB(62,I,0)):$P(^(0),U),1:"")
 S K=0
 F  S K=$O(LRXST(I,K)) Q:K<1  S J=K,J(K)=I_U_K D L4 W !,?5,K,?15,$P(^LAB(60,+LRTEST(K),0),U)," ",?45,LRSAMP W:LRSAMP'=LRSPEC "  ",LRSPEC
 Q
 ;
 ;
L3 ;
 K J S J=0,I=0
 W !!,"You have just selected the following tests for ",PNM,"  ",SSN
 I $G(LRLWC)="LC" W:$G(LRORDTIM) !," for Collection on: ",$$FMTE^XLFDT(LRODT_"."_LRORDTIM,"M")
 W !,?5,"entry no.",?15,"Test",?45,"Sample"
 S I=0 F  S I=$O(LRXST(I)) Q:I<1  D L2
 Q
 ;
 ;
L4 S LRSPEC=$S(I>0:$S($D(^LAB(61,LRXST(I,K),0)):$P(^(0),U),1:""),1:$P(^LAB(61,$P(LRXST(0,K),U,2),0),U))
 Q
 ;
 ;
ENSTIK ;from LRMIBL, LRORD1
 ; Only ask nature of order for CPRS - file #2 patients.
 I $G(LRDPF,2)=2 D  Q:'$D(LRNATURE)
 . D NATURE
 . I $G(LRNATURE)=-1 W !!,$C(7),"...process aborted" S %="^" K LRNATURE
 ;
 D LL3
LL W !!,"All satisfactory" S %=1 D YN^DICN D:%=0 HELP G:%=0 LL Q:%'=2
 ;
LL1 W !,"Delete test entry no.: " R X:DTIME W:X["?" !,"Select entry number to be deleted." W:X'?.N !,"Select one entry at a time." D LL3:X["?" G LL1:X["?"!(X'?.N)
 I '(+X'=X!(X>J)!(X<1)) S LRSAMP=$P(J(X),U),LRSPEC=$P(J(X),U,2),LRTEST=$P(J(X),U,3) K LROT(LRSAMP,LRSPEC,LRTEST) G LL1
 ;
LL1A W !!,"Add more tests" S %=2 D YN^DICN D:%=0 HELP G:%=0 LL1A G ENSTIK:%'=1 K % Q
 ;
 ;
LL2 ;
 S LRSAMP=$P($G(^LAB(62,+I,0)),U)
 S LRSPEC=$P($G(^LAB(61,+L,0)),U)
 S K=0
 F  S K=$O(LROT(I,L,K)) Q:K<1  D
 . S J=J+1,J(J)=I_U_L_U_K
 . W !,?5,J,?15,$P(^LAB(60,+LROT(I,L,K),0),U)," ",?45,LRSAMP
 . W:LRSAMP'=LRSPEC "  ",LRSPEC
 Q
 ;
 ;
LL3 ;
 K J
 S J=0 W !!,"You have just selected the following tests for ",PNM,"  ",SSN
 I LRORDR="LC" W !," for Collection on: ",$$FMTE^XLFDT(LRODT_"."_LRORDTIM,"M")
 W !,?5,"entry no.",?15,"Test",?45,"Sample"
 F I=-1:0 S I=$O(LROT(I)) Q:I=""  D
 . F L=-1:0 S L=$O(LROT(I,L)) Q:L=""  D LL2
 Q
 ;
 ;
HELP W !!,"Answer 'Yes' or 'No' ('^' to cancel)"
 Q
 ;
 ;
X3 K X3(+LRTEST(X),+LRSAMP,+LRXST(LRSAMP,X))
 K LRTEST(X),J(X),LRXST(LRSAMP,X),LRSAMP(X)
 Q
 ;
 ;
NATURE ;Get Nature of order
 I '$D(LRPHSET) D NEW^LROR6()
 Q
