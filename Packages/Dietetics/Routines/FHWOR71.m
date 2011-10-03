FHWOR71 ; HISC/CAH - Diet Profile for CPRS ;1/30/97  08:54
 ;;5.5;DIETETICS;**1,2**;Jan 28, 2005
P(DFN) ;Dietetics Profile for CPRS
 ; INPUT:   DFN = Patient file #2 internal record number
 ; OUTPUT:  -1^displayable error text   (if invalid DFN or no profile)
 ;     with version 5.5 selection of outpatients is allowed
 ;          1 if successful, and displayable data in
 ;   ^TMP($J,"FHPROF",DFN,n) = line of text
 ;          where n = sequential number
 ;
 I 'DFN Q "-1^Invalid patient selection"
 S FHZ115="P"_DFN D CHECK^FHOMDPA I FHDFN="" Q "-1^No Report Available"
 N %,%H,%I,%T,%ZIS,A1,ADM,AGE,ALG,ALL,BAG,C,CAL,COM,CON,CT,D3,DA,DAS,FHDU,DOB,DTP,FHI,FHOR,FHLD,FHQ,I,IOP,K,K1,K2,KK,L,L1,LST,MEAL,N,NO,NOW,FHORD,FHWF,FHPV,FHX,FHY
 N POP,Q,QUA,QT,QTY,RM,SEX,PID,BID,ST1,ST2,STR,TYP,TF,TF2,TIM,TQU,TUN,WARD,X,X1,X2,XY,Y,YN,Z,Z1
 S FHQ=1 K ^TMP($J,"FHPROF",DFN) S FHX=0 D F0
 Q FHQ
F0 ; Display Diet
 D NOW^%DTC S NOW=%,DT=NOW\1,QT=""
 S WARD=$G(^DPT(DFN,.1)) I WARD="" D CPRS^FHOMPP Q
 ;S WARD=$G(^DPT(DFN,.1)) I WARD="" S FHQ="-1^Not currently an inpatient" Q
 S ADM=$G(^DPT("CN",WARD,DFN)) I ADM<1 S FHQ="-1^No current diet order" Q
 I '$D(^FHPT(FHDFN,"A",ADM,0)) S FHQ="-1^No current diet order2" Q
 K N S P1=1 F K=0:0 S K=$O(^FHPT(FHDFN,"P",K)) Q:K<1  S X=^(K,0),M=$P(X,"^",2) I M'="" S:M="A" M="BNE" D SP
 I $O(N(""))="" S FHX=$$SPACNG(1,FHX) S ^TMP($J,"FHPROF",DFN,FHX)="No Food Preferences on file" S FHX=$$SPACNG(0,FHX) G A0
 S FHX=$$SPACNG(1,FHX) S ^TMP($J,"FHPROF",DFN,FHX)="Food Preferences Currently on file" S FHX=$$SPACNG(1,FHX)
 K ST1 S $P(ST1," ",81)="",$E(ST1,27,32)="Likes",$E(ST1,59,67)="Dislikes" S ^TMP($J,"FHPROF",DFN,FHX)=ST1 S FHX=$$SPACNG(1,FHX)
 S (M1,M2,MM)="",FHX=$$SPACNG(0,FHX) F  S M1=$O(N(M1)) Q:M1=""  I $D(N(M1)) S ^TMP($J,"FHPROF",DFN,FHX)=$P(M1,"~",2) D
 .  S (P1,P2)=0 F  S:P1'="" P1=$O(N(M1,"L",P1)) S X1=$S(P1>0:N(M1,"L",P1),1:"") S:P2'="" P2=$O(N(M1,"D",P2)) S X2=$S(P2>0:N(M1,"D",P2),1:"") Q:P1=""&(P2="")  D W0 S:M2'=M1 FHX=$$SPACNG(0,FHX)
 .  S M2=M1 Q
 S FHX=$$SPACNG(0,FHX) K L,N,M,M1,M2,MM,P1,P2
A0 S X(0)=^FHPT(FHDFN,"A",ADM,0),X=$P(X(0),"^",10) G:X="" F1
 S FHX=$$SPACNG(1,FHX) S ^TMP($J,"FHPROF",DFN,FHX)="Isolation/Precaution Type is "_$P($G(^FH(119.4,X,0)),"^",1)
F1 D CUR^FHORD7 S FHX=$$SPACNG(1,FHX) S ^TMP($J,"FHPROF",DFN,FHX)="Current Diet: "_$S(Y'="":Y,1:"No current order")
 I Y'="",FHORD>0 I $D(^FHPT(FHDFN,"A",ADM,"DI",FHORD,1)) S COM=^(1) D
 . I COM'="" S FHX=$$SPACNG(0,FHX) S ^TMP($J,"FHPROF",DFN,FHX)="Comment: "_COM
 S TYP=$P(X,"^",8) I TYP'="" D
 . S FHX=$$SPACNG(0,FHX)
 . S ^TMP($J,"FHPROF",DFN,FHX)="Service: "_$S(TYP="T":"Tray",TYP="D":"Dining Room",1:"Cafeteria")
 S DTP=$P(X(0),"^",3) I DTP D DTP^FH S FHX=$$SPACNG(0,FHX) S ^TMP($J,"FHPROF",DFN,FHX)="Expires: "_DTP
 S TF=$P(X(0),"^",4) G:TF<1 F2
 S Y=^FHPT(FHDFN,"A",ADM,"TF",TF,0)
 S DTP=$P(Y,"^",1),COM=$P(Y,"^",5),TQU=$P(Y,"^",6),CAL=$P(Y,"^",7)
 D DTP^FH S FHX=$$SPACNG(1,FHX) S ^TMP($J,"FHPROF",DFN,FHX)="Tubefeed Ordered: "_DTP
 F TF2=0:0 S TF2=$O(^FHPT(FHDFN,"A",ADM,"TF",TF,"P",TF2)) Q:TF2<1  S XY=^(TF2,0) D LP
 S FHX=$$SPACNG(0,FHX) K ST1 S ST1="Total Quantity: "_TQU_" ml",$E(ST1,43,(56+$L(CAL)))="Total KCAL: "_CAL S ^TMP($J,"FHPROF",DFN,FHX)=ST1
 I COM'="" S FHX=$$SPACNG(0,FHX) S ^TMP($J,"FHPROF",DFN,FHX)="Comment: "_COM
F2 S NO=$P(X(0),"^",7),Y=$S('NO:"",1:^FHPT(FHDFN,"A",ADM,"SF",NO,0))
 S L=$P(Y,"^",4) S FHX=$$SPACNG(1,FHX) S ^TMP($J,"FHPROF",DFN,FHX)="Supplemental Feeding: "_$S('L:"No Order",1:$P(^FH(118.1,L,0),"^",1)) G:'NO F3
 S DTP=$P(Y,"^",30) D DTP^FH S ^TMP($J,"FHPROF",DFN,FHX)=^(FHX)_"    Reviewed: "_DTP
 S L=4 F K1=1:1:3 S K=0,N(K1)="" F K2=1:1:4 S Z=$P(Y,U,L+1),Q=$P(Y,U,L+2),L=L+2 I Z'="" S:'Q Q=1 S:N(K1)'="" N(K1)=N(K1)_"; " S N(K1)=N(K1)_Q_" "_$P(^FH(118,Z,0),"^",1)
 S FHX=$$SPACNG(0,FHX) F K1=1:1:3 I N(K1)'="" S FHX=$$SPACNG(0,FHX) S ^TMP($J,"FHPROF",DFN,FHX)=$P("     10am;      2pm;      8pm",";",K1)_":    "_N(K1)
F3 G ^FHWOR72
LP S TUN=$P(XY,"^",1),STR=$P(XY,"^",2),QUA=$P(XY,"^",3)
 I QUA["CC" S QUAFI=$P(QUA,"CC",1),QUASE=$P(QUA,"CC",2),QUA=QUAFI_"ML"_QUASE
 S FHX=$$SPACNG(0,FHX) S ^TMP($J,"FHPROF",DFN,FHX)="Product: "_$P($G(^FH(118.2,TUN,0)),"^",1)_", "_$S(STR=4:"Full",STR=1:"1/4",STR=2:"1/2",1:"3/4")_" Str., "_QUA Q
SP S Z=$G(^FH(115.2,+X,0)),L1=$P(Z,"^",1),KK=$P(Z,"^",2),M1="",DAS=$P(X,"^",4)
 I KK="L" S Q=$P(X,"^",3),L1=$S(Q:Q,1:1)_" "_L1
 I M="BNE" S M1="1~All Meals" G SP1
 S Z1=$E(M,1) I Z1'="" S M1=$S(Z1="B":"2~Break",Z1="N":"3~Noon",1:"4~Even")
 S Z1=$E(M,2) I Z1'="" S M1=M1_","_$S(Z1="B":"Break",Z1="N":"Noon",1:"Even")
SP1 S:'$D(N(M1,KK,P1)) N(M1,KK,P1)="" I $L(N(M1,KK,P1))+$L(L1)<255 S N(M1,KK,P1)=N(M1,KK,P1)_$S(N(M1,KK,P1)="":"",1:", ")_L1_$S(DAS="Y":" (D)",1:"")
 E  S:'$D(N(M1,KK,K)) N(M1,KK,K)="" S N(M1,KK,K)=L1_$S(DAS="Y":" (D)",1:"") S P1=K
 Q
W0 I X1'="" K ST2 S $P(ST2," ",13)="" S FHY=$G(^TMP($J,"FHPROF",DFN,FHX)) S ^TMP($J,"FHPROF",DFN,FHX)=FHY_$E(ST2,1,(11-$L(FHY))) S X=X1 D W1 S X1=X
 I X2'="" K ST2 S $P(ST2," ",47)="" S FHY=$G(^TMP($J,"FHPROF",DFN,FHX)) S ^TMP($J,"FHPROF",DFN,FHX)=FHY_$E(ST2,1,(46-$L(FHY))) S X=X2 D W1 S X2=X
 Q:X1=""&(X2="")  S FHX=$$SPACNG(0,FHX) G W0
W1 I $L(X)<34 S FHY=$G(^TMP($J,"FHPROF",DFN,FHX)) S ^TMP($J,"FHPROF",DFN,FHX)=FHY_" "_X S X="" Q
 F KK=35:-1:1 Q:$E(X,KK-1,KK)=", "
 S ^TMP($J,"FHPROF",DFN,FHX)=^(FHX)_" "_$E(X,1,KK-2) S X=$E(X,KK+1,999)
 Q
SPACNG(FHI,FHX) ;Multiple spacing before next line of text in ^TMP global
 N I F I=1:1:FHI S FHX=FHX+1 S ^TMP($J,"FHPROF",DFN,FHX)=" "
 S FHX=FHX+1
 Q FHX
TEST ; FOR TESTING ONLY - DFN must be defined
 S I="" F  S I=$O(^TMP($J,"FHPROF",DFN,I)) Q:I=""  W !,^TMP($J,"FHPROF",DFN,I)
 Q
