FHNO31 ; HISC/REL - Supplemental Feeding Lists (cont) ;4/27/93  11:26 
 ;;5.5;DIETETICS;**5,8**;Jan 28, 2005;Build 28
 K C F L=0:0 S L=$O(^FH(118,L)) Q:L<1  I '$D(^FH(118,L,"I")) S C(L)=$P(^(0),"^",1)
 D NOW^%DTC S (NOW,DTP)=%,DT=%\1 D DTP^FH S X1=DT,X2=-14 D C^%DTC S OLD=+X
 K ^TMP("FH",$J) S PG=0
 F KK=0:0 S KK=$O(^FH(119.6,KK)) Q:KK<1  S X=^(KK,0) D F0
 S NXW="" F KK=0:0 S NXW=$O(^TMP("FH",$J,NXW)) Q:NXW=""  F WRD=0:0 S WRD=$O(^TMP("FH",$J,NXW,WRD)) Q:WRD<1  D F2
 Q
 ;
F0 I XX="S" S K1=$P(X,"^",9) I WRDS,K1'=WRDS Q
 I XX="W",WRDS,KK'=WRDS Q
 S K1=$S(XX="W":"",K1<1:99,K1<10:"0"_K1,1:K1),P0=$P(X,"^",4),P0=$S(P0<1:99,P0<10:"0"_P0,1:P0)
 S WRDN=$P(^FH(119.6,KK,0),"^",1),^TMP("FH",$J,K1_P0_$E(WRDN,1,26),KK)="" Q
 ;
F2 S WRDN=$P(^FH(119.6,WRD,0),"^",1)
 ;I $O(^FHPT("AW",WRD,0))<1 Q
 K ^TMP($J) F FHDFN=0:0 S FHDFN=$O(^FHPT("AW",WRD,FHDFN)) Q:FHDFN<1  S ADM=$G(^FHPT("AW",WRD,FHDFN)) D RM
 ;PROCESS outpatient SF.
 I '$D(^TMP($J)) D OSF I $D(^TMP($J)) D HDR D OSF1 Q
 ;
 Q:'$D(^TMP($J))  D HDR
 S (NR,RM)="",FHPAR=0 I XX="S",WRDS S FHPAR=$P($G(^FH(119.74,WRDS,0)),"^",5)="Y"
L2 S NR=$O(^TMP($J,"P",NR)) I NR="" W ! D:FHPAR ING Q
 S FHDFN=""
L3 S FHDFN=$O(^TMP($J,"P",NR,FHDFN)) G:FHDFN="" L2 S ADM=$G(^TMP($J,"P",NR,FHDFN)) G:ADM<1 L3 D PATNAME^FHOMUTL G:DFN="" L2 S Y(0)=^DPT(DFN,0) D PID^FHDPA
 S RM=$S(PRN="R":NR,$D(^DPT(DFN,.101)):^(.101),1:"")
 S (NO,Y)="" I $D(^FHPT(FHDFN,"A",ADM,0)) S NO=$P(^(0),"^",7),IS=$P(^(0),"^",10)
 G:'NO L3 S Y=^FHPT(FHDFN,"A",ADM,"SF",NO,0),NM=$P(Y,"^",4),LST=$P(Y,"^",30)\1
 I IS S IS=$P($G(^FH(119.4,IS,0)),"^",3) S:IS'="N" IS=""
 I NM S NM=$P(^FH(118.1,NM,0),"^",2) I NM="" S NM=$P(^(0),"^",1)
 D:$Y>(IOSL-8) HDR W !!,RM,?13,$E($P(Y(0),"^",1),1,24),?38,BID
 W ?47,$E(NM,1,10) W:IS'="" ?60,"*NURSE" W ?69,$E(LST,4,5),"-",$E(LST,6,7) W:LST<OLD "*"
 D ALG^FHCLN W !,"ALLERGIES: ",$S(ALG="":"NONE ON FILE",1:ALG)
 S L=4 F K1=1:1:3 S K=0,N(K1)="" F K2=1:1:4 S Z=$P(Y,U,L+1),Q=$P(Y,U,L+2),L=L+2 I Z'="" S:'Q Q=1 S:N(K1)'="" N(K1)=N(K1)_"; " S N(K1)=N(K1)_Q_" "_$S($D(C(Z)):C(Z),$D(^FH(118,+Z,0)):$P(^(0),"^",1),1:"") I FHPAR D L4
 F K1=1:1:3 I N(K1)'="" W !?8,$P("10AM; 2PM; 8PM",";",K1),?14,N(K1)
 G L3
 ;
L4 S:'$D(^TMP($J,"I",K1,Z)) ^TMP($J,"I",K1,Z)=0 S ^(Z)=^(Z)+Q Q
ING Q:'$D(^TMP($J,"I"))  S DTP=DT D DTP^FH W @IOF,!,WRDN," INGREDIENT LIST FOR ",DTP
 W !!,"--- 10 AM ---",?26,"--- 2 PM ---",?52,"--- 8 PM ---",! S (N(1),N(2),N(3))=.5
 F L=0:0 Q:(N(1)+N(2)+N(3))=0  W ! F K=1:1:3 S:N(K)>0 N(K)=$O(^TMP($J,"I",K,N(K))) I N(K)>0 S Z=N(K) W ?(K-1*26),$J(^(Z),4,0)," ",$S($D(C(Z)):C(Z),$D(^FH(118,+Z,0)):$P(^(0),"^",1),1:"")
 W ! Q
RM ;
 D PATNAME^FHOMUTL I DFN="" Q
 Q:'$D(^DPT(DFN,0))  Q:ADM<1
 Q:'$D(^FHPT(FHDFN,"A",ADM,0))  S X1=^(0),NO=$P(X1,"^",7) Q:'NO
 D CHK Q:'NO
 I PRN="R" S RM=$G(^DPT(DFN,.101))
 E  S RM=$P($G(^DPT(DFN,0)),"^",1)
 S:RM="" RM=" "
 S ^TMP($J,"P",RM,FHDFN)=ADM Q
 ;
CHK S FHORD=$P(X1,"^",2),X1=$P(X1,"^",3) G:FHORD<1 C1
 I X1>1,X1'>NOW G C2
C0 I '$D(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0)) G C2
 S X1=$P(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0),"^",7) I X1'="",X1'="X" S NO=""
C1 K FHORD,A1,K,X1 Q
C2 S A1=0 F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"AC",K)) Q:K<1!(K>NOW)  S A1=K
 G:'A1 C1 S FHORD=$P(^FHPT(FHDFN,"A",ADM,"AC",A1,0),"^",2) G:FHORD'<1 C0
 K ^FHPT(FHDFN,"A",ADM,"AC",A1) G C2
 ;
HDR ; Print Header
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1
 W !?10,"W A R D   S U P P L E M E N T A L   F E E D I N G   L I S T",?72,"Page ",PG
 W !!,"Ward: ",WRDN,?61,DTP
 W !!,"ROOM",?13,"PATIENT",?39,"ID#     SUPP MENU",?60,"ISOLAT",?69,"REVIEW" Q
 ;
OSF ;outpatient SFs
 F FHDFN=0:0 S FHDFN=$O(^FHPT("RM",DT,FHDFN)) Q:FHDFN'>0  F ADM=0:0 S ADM=$O(^FHPT("RM",DT,FHDFN,ADM)) Q:ADM'>0  D
 .S X1=$G(^FHPT(FHDFN,"OP",ADM,0)),FHNO=$P($G(^FHPT(FHDFN,"OP",ADM,"SF",0)),U,3) Q:'$G(FHNO)
 .S FHMEAL=$P(X1,U,4),FHOWARD=$P(X1,U,3)
 .I (WRD'=FHOWARD)!(FHMEAL="") Q
 .S FHSFDAT=""
 .I $D(^FHPT(FHDFN,"OP",ADM,"SF",FHNO,0)) S FHSFDAT=^(0)
 .Q:$P(FHSFDAT,U,32)
 .S RM=$S(FHMEAL="N":2,FHMEAL="E":3,1:1)
 .I $G(FHOWARD),($G(^FH(119.6,FHOWARD,0))) S WRDN=$P($G(^FH(119.6,FHOWARD,0)),U,1)
 .S P1=$S(FHMEAL="N":13,FHMEAL="E":21,1:5)
 .D PATNAME^FHOMUTL
 .S RM="",RMIEN=$P(X1,U,18) I $G(RMIEN),$D(^DG(405.4,RMIEN,0)) S RM=$E($P(^DG(405.4,RMIEN,0),U,1),1,10)
 .S:RM="" RM=" "
 .I PRN="A" S ^TMP($J,"P",FHPTNM,RM,ADM)=FHDFN
 .I PRN="R" S ^TMP($J,"P",RM,FHPTNM,ADM)=FHDFN
 .;S ^TMP($J,"P",FHPTNM,RM,ADM)=FHDFN
 Q
 ;
OSF1 S FHPTN="",FHPAR=0 I XX="S",WRDS S FHPAR=$P($G(^FH(119.74,WRDS,0)),"^",5)="Y"
OL2 S FHPTN=$O(^TMP($J,"P",FHPTN)) I FHPTN="" W ! D:FHPAR ING Q
 S NR="",ADM=0
 ;
OL3 S NR=$O(^TMP($J,"P",FHPTN,NR)) G:NR="" OL2
 S RM=$S(PRN="R":FHPTN,1:NR)
OL4 S ADM=$O(^TMP($J,"P",FHPTN,NR,ADM)) G:ADM<1 OL3 S FHDFN=^TMP($J,"P",FHPTN,NR,ADM) D PATNAME^FHOMUTL
 S (NO,Y,IS)="" I $D(^FHPT(FHDFN,"OP",ADM,0)) S NO=$P(^FHPT(FHDFN,"OP",ADM,"SF",0),"^",3),IS=$P(^FHPT(FHDFN,0),"^",5)
 G:'NO OL4 S Y=^FHPT(FHDFN,"OP",ADM,"SF",NO,0),NM=$P(Y,"^",4),LST=$P(Y,"^",30)\1
 I IS S IS=$P($G(^FH(119.4,IS,0)),"^",3) S:IS'="N" IS=""
 I NM S NM=$P(^FH(118.1,NM,0),"^",2) I NM="" S NM=$P(^(0),"^",1)
 D:$Y>(IOSL-8) HDR I $D(FHPTSAV),FHPTSAV'=FHPTN W !
 W !,RM,?13,$E(FHPTNM,1,24),?38,FHBID
 W ?47,$E(NM,1,10) W:IS'="" ?60,"*NURSE" W ?69,$E(LST,4,5),"-",$E(LST,6,7) W:LST<OLD "*"
 D ALG^FHCLN W !,"ALLERGIES: ",$S(ALG="":"NONE ON FILE",1:ALG)
 S L=4 F K1=1:1:3 S K=0,N(K1)="" F K2=1:1:4 S Z=$P(Y,U,L+1),Q=$P(Y,U,L+2),L=L+2 I Z'="" S:'Q Q=1 S:N(K1)'="" N(K1)=N(K1)_"; " S N(K1)=N(K1)_Q_" "_$S($D(C(Z)):C(Z),$D(^FH(118,+Z,0)):$P(^(0),"^",1),1:"") I FHPAR D L4
 F K1=1:1:3 I N(K1)'="" W !?8,$P("10AM; 2PM; 8PM",";",K1),?14,N(K1)
 S FHPTSAV=FHPTN
 G OL4
