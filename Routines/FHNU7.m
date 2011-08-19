FHNU7 ; HISC/REL - Food Item Search ;5/17/93  08:50
 ;;5.5;DIETETICS;;Jan 28, 2005
 S NOD="AQ",(FFN,NAM,AMT)=""
 R !!?2,"Select Food Item: ",Y:DTIME G:'$T!("^"[Y)!(Y?1",".E)!(Y'?.ANP)!($L(Y)>30) END S X=Y D TR^FH S Y=X
 I Y["?" W !,"Enter first few characters of food name, e.g., MILK" G FHNU7
F0 S NM=0,XT="",L=$P(Y,",",1),F=$P(Y,",",2) S:$E(F,1)=" " F=$E(F,2,99)
 S NX=L,J=$L(L),K=$L(F) I $D(^FHNU(NOD,NX)) S FFN=0 G S1
S0 S NX=$O(^FHNU(NOD,NX)) G:NX=""!($P(NX,L,1)'="") SD I K G:$E($P(NX,", ",2),1,K)'=F S0
 S FFN=0
S1 S FFN=$O(^FHNU(NOD,NX,FFN)) G:FFN="" S0 S NM=NM+1,XT=XT_FFN_"," G S1:NM<18,TOO
SD I 'NM G:NOD="AQ" NX W !!?2,"Food item not found " G FHNU7
TOO W ! F LL=1:1:NM S X=^FHNU($P(XT,",",LL),0) W !,$J(LL,3,0),?6,$P(X,"^",1)
 S YN=NOD="AQ"!(NM=18) W !!?2,"Select Food Item #, '",$S(YN:"^",1:"RETURN"),"' to Quit" W:YN ",",!?2,"or 'RETURN' to continue list"
 R " => ",YN:DTIME I '$T!(YN["^") S FFN="" G END
 I YN="",NM>17 S NM=0,XT="" G S1
 G:YN["^" FHNU7 I YN="" G NX:NOD="AQ",FHNU7
 I YN'?1N.N!(YN<1)!(YN>NM) W *7,"  ??" G TOO
 S FFN=$P(XT,",",YN) G OK
OK S X=^FHNU(FFN,0),NAM=$P(X,"^",1),UNT=$P(X,"^",3),WT=$P(X,"^",4)
 I $D(FHM(FFN)) G ED
 S UNIT=$S(TYP="C":UNT,1:"gms.")
D2 W !!?2,NAM,!?5,"Amount (",UNIT W:TYP="C" " at ",WT," gms" W ")  => " R Y:DTIME I '$T!(Y["^") S FFN="" G END
 I Y=0 G FHNU7
 I Y'?.N.1".".N!(Y'>0)!(Y>99999) W *7,!,"  Enter amount of item. Enter 0 to delete;",!,"  otherwise enter a number greater than 0 but less than 99999." G D2
 I TYP="C" W "  ... ",Y*WT," grams"
 I TYP="C",Y'>1,UNIT'["." S L=$L(UNIT)-1,L=$S($E(UNIT,L)'="e":L,"hos"'[$E(UNIT,L-1):L,1:L-1),UNIT=$E(UNIT,1,L) I $E(UNIT,L-1,L)="ie" S UNIT=$E(UNIT,1,L-2)_"y"
 S FHM(FFN)=Y,AMT=Y S:TYP="C" FHM(FFN)=FHM(FFN)_","_UNIT_","_WT
END K NOD,F,J,K,L,LL,NM,NX,XT,X,Y,YN Q
NX S NOD="B",(FFN,NAM,AMT)="" G F0
ED W !!?2,"You have already selected ",NAM
 I TYP="C" S UNIT=$P(FHM(FFN),",",2),WT=$P(FHM(FFN),",",3)
 E  S UNIT="gms."
E1 W !!?2,"Change amount from ",(+FHM(FFN))," ",UNIT," to: " R Y:DTIME I '$T!(Y["^") S FFN="" G END
 I Y'?.N.1".".N!(Y'>0)!(Y>99999) W *7,!,"  Enter an amount greater than 0 but less than 99999" G E1
 W " ",UNIT S (Y,AMT)=+Y,$P(FHM(FFN),",",1)=AMT G END
