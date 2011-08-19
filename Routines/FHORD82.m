FHORD82 ; HISC/REL/NCA - Diet Order Lists (cont) ;3/25/96  08:36
 ;;5.5;DIETETICS;;Jan 28, 2005
 S TF=$P(X0,"^",4) G:'TF L4
 S Y=^FHPT(FHDFN,"A",ADM,"TF",TF,0),X=$P(Y,"^",1),COM=$P(Y,"^",5),CAL=$P(Y,"^",7)
 W !,?13,"Tubefeed.: " S ZZ="" D DT S DTE=X
 F TF2=0:0 S TF2=$O(^FHPT(FHDFN,"A",ADM,"TF",TF,"P",TF2)) Q:TF2<1  S X3=$G(^(TF2,0)),TUN=+X3,XX=$G(^FH(118.2,TUN,0)),TUN=$P(XX,"^",1) D CALC S:ZZ'="" ZZ=ZZ_", " S ZZ=ZZ_P2_" "_TUN
 S ZZ=ZZ_", "_CAL_" Kcal/Day"
 S REC=1 D LNE
L3 W:COM'="" !?15,COM,!
L4 F K1=DT-.00001:0 S K1=$O(^FHPT(FHDFN,"A",ADM,"EL",K1)) Q:K1<1!(K1\1>K3)  S Y=^(K1,0) D EL
 D DISP^FHORD83
 K N F K=0:0 S K=$O(^FHPT("ASP",FHDFN,ADM,K)) Q:K<1  S X=^FHPT(FHDFN,"A",ADM,"SP",K,0),M=$P(X,"^",3),M=$S(M="BNE":"A",1:$E(M,1)),N(M,K)=$P(X,"^",2,4),$P(N(M,K),"^",4,5)=$P(X,"^",8,9)
 W !
 F M="A","B","N","E" F K=0:0 S K=$O(N(M,K)) Q:K<1  S Z=+N(M,K) I Z D
 .I ($Y>(IOSL-6)) D HDR^FHORD81,FLNE
 .D SP S QTY=$P(N(M,K),"^",4)
 .W !?13,"Stng. Order: ",M2,?38,$S(QTY:QTY,1:1)," ",$P($G(^FH(118.3,Z,0)),"^",1),$S($P(N(M,K),"^",5)'="Y":" (I)",1:"")
 .S X=$P(N(M,K),"^",3) D DT W ?72,X Q
 K L,N,M,M1,M2 S NM=$P(X0,"^",7) G:'NM L3^FHORD81 S Y=^FHPT(FHDFN,"A",ADM,"SF",NM,0)
 S L=4 F K1=1:1:3 S K=0,N(K1)="" F K2=1:1:4 S Z=$P(Y,U,L+1),Q=$P(Y,U,L+2),L=L+2 I Z'="" S:'Q Q=1 S:N(K1)'="" N(K1)=N(K1)_"; " S N(K1)=N(K1)_Q_" "_$S($D(C(Z)):C(Z),$D(^FH(118,+Z,0)):$P(^(0),"^",1),1:" ")
 S LST=$P(Y,"^",30)\1,X=LST,P1=0 D DT S:LST<OLN X=X_"*"
 F K1=1:1:3 I N(K1)'="" W !?13,$P("10AM; 2PM; 8PM",";",K1),?19,$E(N(K1),1,52) I 'P1 S P1=1 W ?72,X
 G L3^FHORD81
SP S M1=$P(N(M,K),"^",2) I M1="BNE" S M2="All Meals" Q
 S L=$E(M1,1),M2=$S(L="B":"Break",L="N":"Noon",1:"Even")
 S L=$E(M1,2) Q:L=""  S M2=M2_","_$S(L="B":"Break",L="N":"Noon",1:"Even") Q
EL I ($Y>(IOSL-6)) D HDR^FHORD81,FLNE
 S MEAL=$P(Y,"^",2),TIM=$P(Y,"^",3),BAG=$P(Y,"^",4),DTP=K1\1 D DTP^FH
 W !?13,"Early/Late Tray: ",DTP,?39,$J(TIM,10),"   ",$S(MEAL="B":"Breakfast",MEAL="N":"Noon",1:"Evening") W:BAG="Y" ", Bagged Meal" Q
 Q
DT S X=$J(+$E(X,6,7),2)_"-"_$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",+$E(X,4,5)) Q
CALC ; Figure # of units for TF
 I $E($P(XX,"^",3),$L($P(XX,"^",3)))="G" D GRM Q
 S TU=$P(X3,"^",4)/$S(+$P(XX,"^",3):+$P(XX,"^",3),1:9999),TW=$P(X3,"^",5)
 I TW<6 S TU=TU+.75\1,P2=TU,P2=P2_" "_$S(P2>1:$P(XX,"^",2)_"S",1:$P(XX,"^",2)) Q
 S TU=TU+.2*4\1/4,P2=$S(TU<1:"",1:TU\1) I TU#1 S:P2 P2=P2_"-" S P3=TU#1,P2=P2_$S(P3<.3:"1/4",P3<.6:"1/2",1:"3/4")
 S P2=P2_" "_$S(P2>1:$P(XX,"^",2)_"S",1:$P(XX,"^",2))
 Q
GRM S X=$P(X3,"^",3) D FIX^FHORT10 S Z5="" F LL=1:1:$L(X) I $E(X,LL)'=" " S Z5=Z5_$E(X,LL)
 S Z5=$P(Z5,"/",2),Z5=$P(Z5,"X",2)
 I 'Z5 S Z5=$P("1,24,2,3,12,8,6,4",",",K) G G1
 I Z5'["F" S Z5=$S(K=1:1,K=2:Z5,K=3:2,K=4:3,K=5:Z5\2,K=6:Z5\3,K=7:Z5\4,1:Z5\6)
 E  S:K=1 Z5=1
G1 S TU=+$P(X3,"^",3)*Z5
 S TU=TU/$S(+$P(XX,"^",3):+$P(XX,"^",3),1:9999)
 S P2=$S(TU<1:"",1:TU\1) I P2="" S TU=TU+.95\1,P2=TU
 I TU#1 S:P2 P2=P2_"-" S TU=TU#1,P2=P2_$S(TU<.3:"1/4",TU<.6:"1/2",1:"3/4")
 S P2=P2_" "_$S(P2>1:$P(XX,"^",2)_"S",1:$P(XX,"^",2))
 Q
LNE ; Break Line if longer than 45 chars
 I $L(ZZ)<46 D  Q
 .W ZZ
 .I REC W ?72,DTE S REC=0
 .Q
 ;F L=47:-1:1 Q:$E(ZZ,L-1,L)=", "
 F L=47:-1:1 Q:$E(ZZ,L)=" "!($E(ZZ,L)=",")
 W $E(ZZ,1,L-1) I REC W ?72,DTE S REC=0
 S ZZ=$E(ZZ,L+1,999)
 Q:ZZ=""  W !?24
 G LNE
FLNE I '$G(ADM)!'$G(DFN) Q
 S DTP=$P(^DGPM(ADM,0),"^",1) D DTP^FH
 W !!,RM,?13,$E($P($G(^DPT(DFN,0)),"^",1),1,24),?38,BID,?47,DTP
 I $P($G(^FHPT(FHDFN,"A",ADM,0)),"^",5)'="" W ?67,$P(^FHPT(FHDFN,"A",ADM,0),"^",5)
 Q
