FHMTK4 ; HISC/NCA - Patient Diet Pattern Utility ;4/25/95  10:01
 ;;5.5;DIETETICS;;Jan 28, 2005
LIS ; List Diet Pattern of Diet Order
 S ANS="" D SO Q:ANS="^"  S STR=$G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,2))
 W !!!?33,"Diet Pattern"
 W !! F CTR=1:1:3 W ?$S(CTR=1:9,CTR=2:35,1:61),$S(CTR=1:"Breakfast",CTR=2:"Noon",1:"Evening")
 I STR'="" D DECOD G L1
 F MEAL="B","N","E" D L3^FHMTK21
 K MM,P S M1=0 F MEAL="B","N","E" S N1=0,M1=M1+1 D
 .S NX="" F  S NX=$O(^TMP($J,"FHMP",MP,MEAL,NX)) Q:NX=""  S S1=$G(^(NX)),QTY=$S(S1="":1,1:+S1),N1=N1+1,PAD=$E("    ",1,4-$L(QTY)),MM(N1,M1)=PAD_QTY_" "_$P(NX,"~",2),P(M1,$P(S1,"^",2))=QTY
 .;S NX="" F  S NX=$O(^TMP($J,"FHMP",MP,MEAL,NX)) Q:NX=""  S S1=$G(^(NX)),QTY=$S(S1="":1,1:+S1),N1=N1+1,MM(N1,M1)=$S(QTY#1>0:$J(QTY,3,2),1:QTY_"   ")_" "_$P(NX,"~",2),P(M1,$P(S1,"^",2))=QTY
 .Q
L1 W ! F N1=1:1 W ! Q:'$D(MM(N1))  F M1=1:1:3 I $D(MM(N1,M1)) W ?$S(M1=1:2,M1=2:28,1:54),MM(N1,M1)
 Q
LIST ; List Recipe Category of a selected meal
 W ! F NO=1:1 Q:'$D(MM(NO,MEAL))  W !,MM(NO,MEAL)
 Q
SO ; List Standing Orders
 W !?16,"Standing Orders",!
 K N F K=0:0 S K=$O(^FHPT("ASP",FHDFN,ADM,K)) Q:K<1  S X=$G(^FHPT(FHDFN,"A",ADM,"SP",K,0)),M=$P(X,"^",3),M=$S(M="BNE":"A",1:$E(M,1)),N(M,K)=$P(X,"^",2,3)_"^"_$P(X,"^",8,9)
 S LN=0 F M="A","B","N","E" D  Q:ANS="^"
 .F K=0:0 S K=$O(N(M,K)) Q:K<1  S Z=+N(M,K) I Z D  Q:ANS="^"
 ..D L1^FHSPED W ! S NUM=$P(N(M,K),"^",3),LN=LN+1
 ..W ?5,M2,?18,$S(NUM:NUM,1:1)," ",$P(^FH(118.3,Z,0),"^",1),$S($P(N(M,K),"^",4)'="Y":" (I)",1:"")
 ..I LN>15 D PSE S LN=0
 ..Q
 .Q
 Q
SORT ; Sort Recipe Category in print order
 F L1=1:1 Q:'$D(MM(L1,MEAL))  K MM(L1,MEAL)
 S N1=0,M3=$S(MEAL=1:"B",MEAL=2:"N",1:"E"),NX=""
 F  S NX=$O(^TMP($J,"FHMP",MP,M3,NX)) Q:NX=""  S S1=$G(^(NX)),Z=$P(S1,"^",2) I $D(P(MEAL,+Z)) S N1=N1+1,QTY=$S($G(P(MEAL,+Z))="":1,1:+$G(P(MEAL,+Z))),PAD=$E("    ",1,4-$L(QTY)),MM(N1,MEAL)=PAD_QTY_" "_$P(NX,"~",2)
 ;F  S NX=$O(^TMP($J,"FHMP",MP,M3,NX)) Q:NX=""  S S1=$G(^(NX)),Z=$P(S1,"^",2) I $D(P(MEAL,+Z)) S N1=N1+1,QTY=$S($G(P(MEAL,+Z))="":1,1:+$G(P(MEAL,+Z))),MM(N1,MEAL)=$S(QTY#1>0:$J(QTY,3,2),1:QTY_"   ")_" "_$P(NX,"~",2)
 Q
DECOD ; Decode code string
 K MM,P F M1=1:1:3 S S1=$P(STR,";",M1),M3=$S(M1=1:"B",M1=2:"N",1:"E") D
 .F X4=1:1 Q:$P(S1," ",X4,99)=""  D
 ..S X1=$P(S1," ",X4),NAM=$P($G(^FH(114.1,+X1,0)),"^",1),$P(X1,",",2)=$S($P(X1,",",2)'="":$P(X1,",",2),1:1)
 ..S PAD=$E("    ",1,4-$L($P(X1,",",2)))
 ..S MM(X4,M1)=PAD_$P(X1,",",2)_" "_NAM,P(M1,+X1)=$P(X1,",",2)
 ..;S MM(X4,M1)=$S($P(X1,",",2)#1>0:$J($P(X1,",",2),3,2),1:$P(X1,",",2)_"   ")_" "_NAM,P(M1,+X1)=$P(X1,",",2)
 ..S K1=$P($G(^FH(114.1,+X1,0)),"^",3),K1=$S('K1:99,K1<10:"0"_K1,1:K1)_"~"_NAM
 ..S ^TMP($J,"FHMP",MP,M3,K1)=$P(X1,",",2)_"^"_+X1 Q
 .Q
 Q
PSE I IOST?1"C-".E R !!,"Press RETURN to Continue ",X:DTIME W ! S:'$T!(X["^") ANS="^" Q:ANS="^"  I "^"'[X W !,"Enter a RETURN to Continue." G PSE
 Q
