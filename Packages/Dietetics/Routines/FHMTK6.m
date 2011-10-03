FHMTK6 ; HISC/NCA/RTK/FAI - History of Diet Patterns ;10/20/04  07:12
 ;;5.5;DIETETICS;;Jan 28, 2005
 S (ANS,O1,FHO1)="",FHALL=1 D ^FHOMDPA G:'FHDFN KIL
 I $O(^FHPT(FHDFN,"A",0))<1 W !!,"NO ADMISSIONS ON FILE!" G FHMTK6
 D ADM I ADM'="" S FHADM=ADM D CUR^FHORD7 G:FHLD'="" KIL S FHO1=FHORD,O1=Y,ANS=""
 S DIC="^FHPT(FHDFN,""A"",",DIC(0)="Q",DA=FHDFN,X="??" D ^DIC
A0 W !!,"Select ADMISSION",$S($D(^DPT(DFN,.1)):" (or C for CURRENT)",1:""),": " R X:DTIME G:'$T!("^"[X) KIL D:X="c" TR^FH
 I X="C" D ADM G P0:ADM'<1,FHMTK6
 S DIC="^FHPT(FHDFN,""A"",",DIC(0)="EQM" D ^DIC G:Y<1 A0 S ADM=+Y
P0 W !!!,"Current Diet: ",$S(O1'="":O1,1:"No Current Diet") S FHORD=""
 K S S (LST,N1)=0 F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"DI",K)) Q:K<1  S X=$G(^(K,0)),X1=$G(^(2)),X2=$G(^(3)) I X1'="" S (FHORD,LST)=K D LIS
 I 'N1 W !!,"No Diet Pattern for this Admission!" G FHMTK6
P1 R !!,"Detailed Display of which Pattern #? ",X:DTIME G:'$T!("^"[X) FHMTK6 I X'?1N.N!(X<1)!(X>N1) W *7," Enter Pattern # to List" G P1
 I '$G(S(+X)) W !!,"No Pattern Saved for this Diet!" G FHMTK6
 S FHORD=+S(+X) W ! S MP=0 D LIS^FHMTK4 G:ANS="^" FHMTK6
 S PD=$P($G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0)),"^",13)
 S CLERK=$P($G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,3)),"^",1)
 W !!?25,"Pattern Entered By: ",$E($P($G(^VA(200,+CLERK,0)),"^",1),1,30),!
 S Z=$O(^FHPT(FHDFN,"P",0)) I Z D PSE G:ANS="^" FHMTK6 D DISP^FHSEL1
 I FHO1="" Q
 S FHOR=$P($G(^FHPT(FHDFN,"A",ADM,"DI",FHO1,0)),"^",2,6)
R5 R !!,"Do You Want to Store this Pattern As the Patient's Individual Pattern? N// ",Y:DTIME G:'$T!(Y="^") FHMTK6 S:Y="" Y="N" S X=Y D TR^FH S Y=X
 I $P("YES",Y,1)'="",$P("NO",Y,1)'="" W *7,!,"  Answer YES to Store this Pattern as the patient's Diet Pattern;  NO, not to store." G R5
 G:Y'?1"Y".E FHMTK6 W !!,"Storing Patient's Diet Pattern ..."
 G:STR="" FHMTK6
 S:$E(STR,$L(STR))=";" STR=$E(STR,1,$L(STR)-1)
 I $L(STR)>240 S LN=$L($E(STR,1,240)," "),STR=$P(STR," ",1,LN-1)
 S ^FHPT(FHDFN,"A",FHADM,"DI",FHO1,2)=STR D NOW^%DTC S TIM=%
 S:$G(^FHPT(FHDFN,"A",FHADM,"DI",FHO1,3))="" ^FHPT(FHDFN,"A",FHADM,"DI",FHO1,3)=DUZ_"^"_TIM
 I PD S $P(^FHPT(FHDFN,"A",FHADM,"DI",FHO1,0),"^",13)=PD
 G FHMTK6
ADM S WARD=$G(^DPT(DFN,.1))
 I WARD="" W *7,!!,"NOT CURRENTLY AN INPATIENT!",! S ADM="" Q
 S ADM=$G(^DPT("CN",WARD,DFN)) Q
LIS I 'N1 W !!,"Pat  Date/Time Entered  Diet Pattern",!
 S D1=$P(X2,"^",2)
 S FHOR=$P(X,"^",2,6),FHLD=$P(X,"^",7),Y=""
 I FHLD'="" Q
 S N1=N1+1,S(N1)=FHORD
 S DTP=D1 S:DTP="" DTP=$P(X,"^",9)
 D:DTP'="" DTP^FH W !,$J(N1,3),"  ",$S(DTP'="":DTP,1:"")
 S Y="" F A1=1:1:5 S D3=$P(FHOR,"^",A1) I D3 S:Y'="" Y=Y_", " S Y=Y_$P(^FH(111,D3,0),"^",7)
 W:Y'="" ?24,Y
 Q
KIL K ^TMP($J) G KILL^XUSCLEAN
PSE I IOST?1"C-".E R !!,"Press RETURN to Continue ",X:DTIME W ! S:'$T!(X["^") ANS="^" Q:ANS="^"  I "^"'[X W !,"Enter a RETURN to Continue." G PSE
 Q
