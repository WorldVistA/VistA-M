FHMTK3 ; HISC/NCA - Enter/Edit Patient Diet Pattern ;2/21/96  07:59
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Enter/Edit patient Diet Pattern
 S ALL=0 D ^FHDPA G:'DFN KIL G:'FHDFN KIL D NOW^%DTC S TIM=%
 D CUR^FHORD7 G:FHLD'="" KIL G:'FHORD KIL S PD=$P($G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0)),"^",13)
 W !!,"Current Diet: ",$S(Y'="":Y,1:"No current order") G:Y="" KIL
 S MP=$O(^FH(111.1,"AB",FHOR,0))
 I 'MP,$G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,2))="" W !!,"No Diet Pattern for this Diet Order.",! D RET G:'MP KIL
 S:'MP MP=0
 I MP S PD=$P($G(^FH(111.1,+MP,0)),"^",7)
 S:PD $P(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0),"^",13)=PD
 G:PD="" KIL W !,"Production Diet: ",$P($G(^FH(116.2,+PD,0)),"^",1)
 W ! K ^TMP($J) D LIS^FHMTK4
R1 R !!,"Select MEAL (B,N,E): ",MEAL:DTIME G KIL:'$T!(MEAL="^"),R5:MEAL="" S X=MEAL D TR^FH S MEAL=X
 I "BNE"'[MEAL!(MEAL'?1U) W *7,!,"Select B for Breakfast, N for Noon, or E for Evening" G R1
 S MEAL=$F("BNE",MEAL)-1
R2 D LIST^FHMTK4 K DIC W ! S DIC="^FH(114.1,",DIC("A")="Select a Recipe Category: ",DIC(0)="AEQM"
 ;D ^DIC K DIC G KIL:"^"[X!$D(DTOUT),R2:Y<1 S RC=+Y,QTY=""
 D ^DIC K DIC G R4:"^"[X!$D(DTOUT),R2:Y<1 S RC=+Y,QTY=""
 S C1=$G(^FH(114.1,RC,0)),NAM=$P(C1,"^",1),K1=$P(C1,"^",3)
 S K1=$S('K1:99,K1<10:"0"_K1,1:K1),K1=K1_"~"_NAM
 I $D(P(MEAL,RC)) S S1=$G(P(MEAL,RC)),QTY=+S1 G R2A
 W !!,$P($G(^FH(114.1,RC,0)),"^",1)," added",! S P(MEAL,RC)=""
 S M3=$S(MEAL=1:"B",MEAL=2:"N",1:"E"),^TMP($J,"FHMP",MP,M3,K1)="^"_+RC
R2A W !,"Recipe Category: ",$P($G(^FH(114.1,+RC,0)),"^",1)_" // " R X:DTIME G:'$T!(X="^") KIL
 I X="@" K P(MEAL,+RC),^TMP($J,"FHMP",MP,MEAL,K1) D SORT^FHMTK4 W " ...Done" G R4
 I X'="" W *7,!,"Press Return to take Default or ""@"" to Delete" G R2A
R3 W !,"Quantity: ",$S(QTY:QTY_"// ",1:"") R X:DTIME G:'$T!(X["^") KIL S:X="" X=QTY
 I X'?0.1N.1".".2N!(X<0)!(X>9.99) W *7,"  Enter a number between 0-9.99." G R3
 S QTY=X S P(MEAL,RC)=QTY D SORT^FHMTK4
R4 R !!,"Enter/Edit More? Y// ",Y:DTIME G:'$T!(Y="^") KIL S:Y="" Y="Y" S X=Y D TR^FH S Y=X
 I $P("YES",Y,1)'="",$P("NO",Y,1)'="" W *7,!,"  Answer YES to continue modifying Diet Pattern; NO to continue and store patient's pattern" G R4
 I Y?1"Y".E G R1
R5 R !!,"Is this Correct to store? Y// ",Y:DTIME G:'$T!(Y="^") KIL S:Y="" Y="Y" S X=Y D TR^FH S Y=X
 I $P("YES",Y,1)'="",$P("NO",Y,1)'="" W *7,!,"  Answer YES to accept patient's Diet Pattern; NO to modify again" G R5
 G:Y'?1"Y".E R1 W !!,"Storing Patient's Diet Pattern ..."
 S STR="" F M1=1:1:3 S M3=$S(M1=1:"B",M1=2:"N",1:"E") D
 .S NX="" F  S NX=$O(^TMP($J,"FHMP",MP,M3,NX)) Q:NX=""  D
 ..S Z=$P($G(^(NX)),"^",2) I $D(P(M1,+Z)) S STR=STR_+Z_","_$S($G(P(M1,+Z))'=1:$G(P(M1,+Z)),1:"")_" "
 ..Q
 .S:$E(STR,$L(STR))=" " STR=$E(STR,1,$L(STR)-1) S STR=STR_";"
 .Q
 S:$E(STR,$L(STR))=";" STR=$E(STR,1,$L(STR)-1)
 I $L(STR)>240 S LN=$L($E(STR,1,240)," "),STR=$P(STR," ",1,LN-1)
 S ^FHPT(FHDFN,"A",ADM,"DI",FHORD,2)=STR
 S ^FHPT(FHDFN,"A",ADM,"DI",FHORD,3)=DUZ_"^"_TIM
KIL K ^TMP($J,"FHMP") G KILL^XUSCLEAN
RET ; Returns a selected Pattern
 W ! K DIC S DIC="^FH(111.1,",DIC(0)="AEMQ" D ^DIC K DIC
 I "^"[X!($D(DTOUT)) S MP=0 Q
 G:Y<1 RET S MP=+Y
 Q
