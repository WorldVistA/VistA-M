FHNU11 ; HISC/REL - Recipe Analysis ;3/10/95  12:17
 ;;5.5;DIETETICS;;Jan 28, 2005
T0 R !!,"Title of Recipe: ",TIT:DTIME G:'$T!("^"[TIT) KIL I TIT'?.ANP W *7,"  ??" G T0
 I $L(TIT)>60!($L(TIT)<3)!(TIT?1P.E) W *7,!,"Answer must be 3-60 characters in length" G T0
T1 R !!,"Number of Portions: ",POR:DTIME G:'$T!(POR["^") KIL I +POR'=POR!(POR<1)!(POR>1000) W *7,"Enter number from 1 to 1000" G T1
D0 R !!,"Do you wish to use common units rather than grams? YES// ",YN:DTIME G:'$T!(YN["^") KIL S:YN="" YN="Y" S X=YN D TR^FH S YN=X
 I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7,!,"  Answer YES or NO" G D0
 S TYP=$S(YN?1"N".E:"G",1:"C") S:TYP="G" UNIT="gm."
 W !!!,"We will now build the ingredient list." K FHM
D1 D ^FHNU7 I FFN'="" G D1
D2 D LI
D3 R !!,"Do you wish to edit this list? NO// ",YN:DTIME G:'$T!(YN["^") KIL S:YN="" YN="N" S X=YN D TR^FH S YN=X I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7," Answer YES or NO" G D3
 G ED:YN?1"Y".E,KIL:'NM D ^FHNU12
D4 R !,"Do you wish to analyze another Recipe? NO// ",YN:DTIME G:'$T!("^"[YN) KIL S:YN="" YN="N" S X=YN D TR^FH S YN=X G KIL:$P("NO",YN,1)="",T0:$P("YES",YN,1)="" W *7," Answer YES or NO" G D4
KIL G KILL^XUSCLEAN
LI W @IOF,!!,"Here is your final ingredient list:",! S NX=0,XT="",NM=0
L1 S NX=$O(FHM(NX)) I NX="" W:'NM !?5,"No ingredients selected." Q
 S XT=XT_NX_",",NM=NM+1,X=FHM(NX),AMT=+X S:TYP="C" UNIT=$P(X,",",2),WT=$P(X,",",3)
 W !,$J(NM,4,0),"  ",$P(^FHNU(NX,0),"^",1),"  ",AMT," ",UNIT G L1
ED G:'NM E4 R !!,"Do you wish to change any amounts? NO// ",YN:DTIME G:'$T!(YN["^") KIL S:YN="" YN="N" S X=YN D TR^FH S YN=X I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7," Answer YES or NO" G ED
 G:YN?1"N".E E2
E1 R !,"Change item # : ",X:DTIME G KIL:'$T,E2:X="",ED:X["^" I X'?1N.N!(X<1)!(X>NM) W *7,"  Enter an item #." G E1
 S X=$P(XT,",",X) I TYP="C" S UNIT=$P(FHM(X),",",2),WT=$P(FHM(X),",",3)
 W "  from ",(+FHM(X))," ",UNIT," to: " R Y:DTIME G KIL:'$T,E1:Y["^" I Y'?.N.1".".N!(Y'>0)!(Y>99999) W *7,"  Enter a number from 1 to 99999." G E1
 W " ",UNIT S $P(FHM(X),",",1)=+Y G E1
E2 R !!,"Do you wish to delete any items? NO// ",YN:DTIME G:'$T!(YN["^") KIL S:YN="" YN="N" S X=YN D TR^FH S YN=X I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7," Answer YES or NO" G E2
 G:YN?1"N".E E4
E3 R !,"Delete item # : ",X:DTIME G KIL:'$T,E4:X="",ED:X["^" I X'?1N.N!(X<1)!(X>NM) W *7,"  Enter an item #." G E3
 S X=$P(XT,",",X) K FHM(X) W " ... deleted" G E3
E4 R !!,"Do you wish to add more ingredients? NO// ",YN:DTIME G:'$T!(YN["^") KIL S:YN="" YN="N" S X=YN D TR^FH S YN=X I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7," Answer YES or NO" G E4
 G D1:YN?1"Y".E,D3
