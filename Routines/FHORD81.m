FHORD81 ; HISC/REL/NCA - Diet Order Lists (cont) ;11/30/00  13:55
 ;;5.5;DIETETICS;**1,5,17**;Jan 28, 2005;Build 9
 ;patch 5 - added outpatiet SOs & SFs and outpt room-bed.
 K C,^TMP("FH",$J) F L=0:0 S L=$O(^FH(118,L)) Q:L<1  I '$D(^FH(118,L,"I")) S C(L)=$P(^(0),"^",1)
 D NOW^%DTC S NOW=%,DT=NOW\1,X1=DT,X2=-14 D C^%DTC S OLN=+X S X1=NOW,X2=-3 D C^%DTC S OLD=+X
 S X1=DT,X2=2 D C^%DTC S K3=+X
 F W1=0:0 S W1=$O(^FH(119.6,W1)) Q:W1<1  S X=^(W1,0) D F0
 S (PG,REC)=0,NXW="" F  S NXW=$O(^TMP("FH",$J,NXW)) Q:NXW=""  F W1=0:0 S W1=$O(^TMP("FH",$J,NXW,W1)) Q:W1<1  D F2
 ;
OUTP ;Outpatient data
 D GETOUT^FHOMRBL1
 S (ADM,DTP,FHPTSA,RM,FHLSAV,FHI)=""
 I SRT="R" D RMS   ;sort by room-bed
 F  S FHI=$O(^TMP($J,"FH",FHI)) Q:FHI=""  D
 .S FHJ="" F  S FHJ=$O(^TMP($J,"FH",FHI,FHJ)) Q:FHJ=""  D
 ..S FHPTSA=FHJ
 ..F FHK=0:0 S FHK=$O(^TMP($J,"FH",FHI,FHJ,FHK)) Q:FHK'>0  D
 ...S FHDAT=""
 ...S FHL=$O(^TMP($J,"FH",FHI,FHJ,FHK,0))
 ...I $G(FHL) D REC Q
 ...D PROC
 W ! Q
 ;
RMS ;SORT BY ROOM-BED
 M ^TMP($J,"FHR")=^TMP($J,"FH") K ^TMP($J,"FH")
 F  S FHI=$O(^TMP($J,"FHR",FHI)) Q:FHI=""  D
 .S FHJ="" F  S FHJ=$O(^TMP($J,"FHR",FHI,FHJ)) Q:FHJ=""  D
 ..S FHPTSA=FHJ
 ..F FHK=0:0 S FHK=$O(^TMP($J,"FHR",FHI,FHJ,FHK)) Q:FHK'>0  D
 ...S FHDAT=""
 ...S FHL=$O(^TMP($J,"FHR",FHI,FHJ,FHK,0))
 ...I $G(FHL) D RM1 Q
 ...D RM2
 K ^TMP($J,"FHR")
 Q
RM1 F FHL=0:0 S FHL=$O(^TMP($J,"FHR",FHI,FHJ,FHK,FHL)) Q:FHL'>0  D
 .S FHDAT=^TMP($J,"FHR",FHI,FHJ,FHK,FHL)
 .S FHDFN=$P(FHDAT,U,2)
 .S RM=""
 .I $G(FHDFN),$D(^FHPT(FHDFN,"OP",FHL,0)) S RM=$P(^(0),U,18)
 .I $G(RM),$D(^DG(405.4,RM,0)) S RM=$P(^(0),U,1)
 .S:RM'="" RM=$E(RM,1,12)
 .S:RM="" RM=" "
 .S ^TMP($J,"FH",FHI,RM,FHK,FHL)=FHDAT
 Q
RM2 S FHDAT=^TMP($J,"FHR",FHI,FHJ,FHK)
 S FHDFN=$P(FHDAT,U,2)
 S FHTYP=$P(FHDAT,U,1)
 S RM=""
 I $G(FHDFN),FHTYP="GM",$D(^FHPT(FHDFN,"GM",FHK,0)) S RM=$P(^(0),U,11)
 I $G(FHDFN),FHTYP="SM",$D(^FHPT(FHDFN,"SM",FHK,0)) S RM=$P(^(0),U,13)
 I $G(RM),$D(^DG(405.4,RM,0)) S RM=$P(^(0),U,1)
 S:RM'="" RM=$E(RM,1,12)
 S:RM="" RM=" "
 S ^TMP($J,"FH",FHI,RM,FHK)=FHDAT
 Q
 ;
PROC ;process/print
 S FHPLD=0
 S:FHDAT="" FHDAT=^TMP($J,"FH",FHI,FHJ,FHK)
 S FHCAT=$P(FHDAT,U,1)
 S FHDFN=$P(FHDAT,U,2)
 S FHDIE=$P(FHDAT,U,3)
 S FHSTA=$P(FHDAT,U,4)
 S FHMEAL=$P(FHDAT,U,5)
 S FHLOC=$P(FHDAT,U,6)
 S FHDAIN=$P(FHDAT,U,7)
 S (FHSERT,FHSERC,FHSERD,FHSER)=""
 I $G(FHLOC),$D(^FH(119.6,FHLOC,0)) D
 .S:$P(^FH(119.6,FHLOC,0),U,5) FHSERT="T"
 .S:$P(^FH(119.6,FHLOC,0),U,6) FHSERC="C"
 .S:$P(^FH(119.6,FHLOC,0),U,7) FHSERD="D"
 .S FHSER=FHSERT_FHSERC_FHSERD
 I (FHXX="C"),(WRD>0),(WRD'=FHSTA) Q
 I (FHXX="L"),(WRD>0),(WRD'=FHLOC) Q
 I (SER'="A"),(FHSER'[SER) Q
 I FHI'=FHLSAV S FHLSAV=FHI,WRDN=$E(FHI,3,$L(FHI)) D HDR
 S FHDIET=""
 D PATNAME^FHOMUTL
 S RM=""
 I FHCAT="OP",$D(^FHPT(FHDFN,"OP",FHDAIN,0)) S RM=$P(^(0),U,18)
 I FHCAT="GM",$D(^FHPT(FHDFN,"GM",FHDAIN,0)) S RM=$P(^(0),U,11)
 I FHCAT="SM",$D(^FHPT(FHDFN,"SM",FHDAIN,0)) S RM=$P(^(0),U,13)
 I $G(RM),$D(^DG(405.4,RM,0)) S RM=$P(^DG(405.4,RM,0),U,1)
 I FHLSAV'=FHI S FHLSAV=FHI D HDR
 W !!,$E(RM,1,12),?13,$E(FHPTNM,1,24),?38,FHBID,?67,FHSER
 I $Y>(IOSL-6) D HDR
 I $D(^FH(111,FHDIE,0)) S FHDIET=$P(^FH(111,FHDIE,0),U,7)
 S FHTYP=$S(FHCAT="OP":"Recurring",FHCAT="GM":"Guest",FHCAT="SM":"Special",1:"")
 S DTP=FHK D DTP^FH
 W !,?14,"Diet Order: ",FHDIET,?40,"Meal: ","(",FHMEAL,")"
 W !,?14,"Service Type: ",FHTYP,?40,"Date: ",DTP
 ;S FHDAIN=$O(^FHPT(FHDFN,""_FHCAT_"","B",FHK,0))
 I $G(FHDAIN),$D(^FHPT(FHDFN,""_FHCAT_"",FHDAIN,"TF")) D OUTF
 I $G(FHDAIN),FHCAT="OP",$D(^FHPT(FHDFN,"OP",FHDAIN,"SP")) D OSO
 I $G(FHDAIN),FHCAT="OP",$D(^FHPT(FHDFN,"OP",FHDAIN,"SF")) D OSF
 S FHPLD=1
 D:'$G(FHL) ^FHORD83
 Q
 ;
OSO ;process outpt SOs.
 ;
 K N F K=0:0 S K=$O(^FHPT(FHDFN,"OP",FHDAIN,"SP",K)) Q:K'>0  S X=^(K,0) Q:$P(X,"^",6)  D
 .S M=$P(X,"^",3),N(M,K)=$P(X,"^",2,4),$P(N(M,K),"^",4,5)=$P(X,"^",8,9)
 F M="B","N","E" F K=0:0 S K=$O(N(M,K)) Q:K<1  S Z=+N(M,K) I Z D
 .I ($Y>(IOSL-6)) D HDR,FLNE^FHORD82
 .S M2=$S(M="B":"Break",M="N":"Noon",1:"Even") S QTY=$P(N(M,K),"^",4)
 .W !?13,"Stng. Order: ",M2,?38,$S(QTY:QTY,1:1)," ",$P($G(^FH(118.3,Z,0)),"^",1),$S($P(N(M,K),"^",5)'="Y":" (I)",1:"")
 .S X=$P(N(M,K),"^",3) D DT W ?72,X Q
 Q
 ;
OSF ;process outpt SFs.
 S NM=$P($G(^FHPT(FHDFN,"OP",FHDAIN,"SF",0)),U,3) Q:'$G(NM)
 K L,N,M,M1,M2 Q:'NM  S Y=^FHPT(FHDFN,"OP",FHDAIN,"SF",NM,0) Q:$P(Y,"^",32)
 S L=4 F K1=1:1:3 S K=0,N(K1)="" F K2=1:1:4 S Z=$P(Y,U,L+1),Q=$P(Y,U,L+2),L=L+2 I Z'="" S:'Q Q=1 S:N(K1)'="" N(K1)=N(K1)_"; " S N(K1)=N(K1)_Q_" "_$S($D(C(Z)):C(Z),$D(^FH(118,+Z,0)):$P(^(0),"^",1),1:" ")
 S LST=$P(Y,"^",30)\1,X=LST,P1=0 D DT S:LST<OLN X=X_"*"
 F K1=1:1:3 I N(K1)'="" W !?13,$P("10AM; 2PM; 8PM",";",K1),?19,$E(N(K1),1,52) I 'P1 S P1=1 W ?72,X
 Q
 ;
REC ;set/get recurring data
 F FHL=0:0 S FHL=$O(^TMP($J,"FH",FHI,FHJ,FHK,FHL)) Q:FHL'>0  D
 .S FHDAT=^TMP($J,"FH",FHI,FHJ,FHK,FHL)
 .D PROC
 D:$G(FHPLD) ^FHORD83
 Q
 ;
OUTF ;outpatient TF
 S REC=1
 S (FHTFPR,FHTFQU,FHTFST,FHTFCOM,FHTFTC,FHTFKD,FHTFCN)=""
 I $G(FHDAIN),$D(^FHPT(FHDFN,"OP",FHDAIN,3)) D
 .S FHRDAT3=$G(^FHPT(FHDFN,"OP",FHDAIN,3))
 .S FHTFCOM=$P(FHRDAT3,U,1)
 .S FHTFTC=$P(FHRDAT3,U,2)
 .S FHTFTKD=$P(FHRDAT3,U,3)
 .S FHTFCN=$P(FHRDAT3,U,5)
 .S:FHTFCN="C" FHTFCN="Cancelled"
 F FHTFDA=0:0 S FHTFDA=$O(^FHPT(FHDFN,"OP",FHDAIN,"TF",FHTFDA)) Q:FHTFDA'>0  D
 .S FHTFDAT=$G(^FHPT(FHDFN,"OP",FHDAIN,"TF",FHTFDA,0))
 .S FHTFPR=$P(FHTFDAT,U,1)
 .I $G(FHTFPR),$D(^FH(118.2,FHTFPR,0)) S FHTFPR=$P(^FH(118.2,FHTFPR,0),U,1)
 .S FHTFST=$P(FHTFDAT,U,2)
 .S:$G(FHTFST) FHTFST=$S(FHTFST=1:"1/4",FHTFST=2:"1/2",FHTFST=3:"3/4",FHTFST=4:"FULL",1:"")
 .S FHTFQU=$P(FHTFDAT,U,3)
 .S FHTFCC=$P(FHTFDAT,U,4)
 .;I FHAOT'="" S ZZ="  Additional Order: "_FHAOT_" "_FHAOCN_" By: "_FHAOC D LNE^FHORD82
 .;I FHELTT'="" S ZZ="  Early/Late Tray Time: "_FHELTT_"  Bag Meal: "_FHELTBM D LNE^FHOR82
 .I $Y>(IOSL-6) D LNE^FHORD82
 .W !,?5,"Tubefeed.:"
 .S ZZ=FHTFCOM_"  TF Total MLs: "_FHTFTC_"  TF Total KCALS/Day: "_FHTFTKD_" "_FHTFCN W ZZ
 .I FHTFPR'="" D
 ..I $Y>(IOSL-6) D LNE^FHORD82
 ..W !,?5
 ..S ZZ="TF Product: "_FHTFPR_"  TF Strength: "_FHTFST_"  TF Quantity: "_FHTFQU
 ..W ZZ
 ..I $Y>(IOSL-6) D LNE^FHORD82
 ..W !,?5
 ..S ZZ="TF Product ML/Day: "_FHTFCC_" "_FHTFCN
 ..W ZZ
 Q
F0 ;
 I $P(X,U,3)="O" Q
 I FHXX="C" S K1=$P(X,"^",8) I WRD,K1'=WRD Q
 I FHXX="L" S K1=$P(X,"^",1) I WRD,W1'=WRD Q
 S K1=$S(FHXX="W":"",K1<1:99,K1<10:"0"_K1,1:K1),P0=$P(X,"^",4),P0=$S(P0<1:99,P0<10:"0"_P0,1:P0)
 S WRDN=$P(^FH(119.6,W1,0),"^",1),^TMP("FH",$J,K1_P0_$E(WRDN,1,26),W1)="" Q
F2 S WRDN=$P(^FH(119.6,W1,0),"^",1)
 K ^TMP($J) F FHDFN=0:0 S FHDFN=$O(^FHPT("AW",W1,FHDFN)) Q:FHDFN<1  S ADM=^(FHDFN) D RM
 Q:'$D(^TMP($J,"FHSRT"))  S NX="" D HDR
L2 S NX=$O(^TMP($J,"FHSRT",NX)) I NX="" W ! Q
 S FHDFN=""
L3 ; Get Next Patient data
 S FHDFN=$O(^TMP($J,"FHSRT",NX,FHDFN)) G:FHDFN="" L2 S ADM=^(FHDFN)
 D PATNAME^FHOMUTL I DFN="" G L3
 G:ADM<1 L3 S Y(0)=^DPT(DFN,0) G:'$D(^DGPM(ADM,0)) L3
 G:'$D(^FHPT(FHDFN,"A",ADM,0)) L3 S LEN=0 D CUR^FHORD7 S MEAL=Y,X0=^FHPT(FHDFN,"A",ADM,0) S:$L(MEAL)>48 LEN=$L($E(MEAL,1,48),",")
 I SER'="A",$P(X0,"^",5)'=SER G L3
 D:$Y>(IOSL-6) HDR S DTP=$P(^DGPM(ADM,0),"^",1) D DTP^FH
 S RM=$S(SRT="R":NX,$D(^DPT(DFN,.101)):^(.101),1:"") D PID^FHDPA
 W !!,RM,?13,$E($P(Y(0),"^",1),1,24),?38,BID,?47,DTP
 S Y=$P(X0,"^",5) I Y'="" W ?67,Y
 D GET I Y'="" W !?13,"Nut. Status: ",Y S X=+X5 D DT W ?72,X
 D ALG^FHCLN I ALG'="" W !?13,"Allergies: " S ZZ=ALG D LNE^FHORD82
 I "NO ORDER"'[MEAL!'$P(X0,"^",4) W !?13,"Diet Order: ",$S(LEN:$P(MEAL,",",1,LEN-1)_",",1:MEAL)
 I  I FHORD S X=$P(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0),"^",9) D DT W ?72,X D:FHLD'="" NPO W:LEN !?24,$P(MEAL,",",LEN,999) D COM
 G ^FHORD82
GET S Y="",X5=$O(^FHPT(FHDFN,"S",0)) Q:X5=""  S X5=^(X5,0)
 Q:$P(X5,"^",1)<$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",1)
 S Y=$P($G(^FH(115.4,+$P(X5,"^",2),0)),"^",2) Q
NPO S LST=0 F K1=0:0 S K1=$O(^FHPT(FHDFN,"A",ADM,"AC",K1)) Q:K1<1!(K1>NOW)  I $P(^(K1,0),"^",2)=FHORD S LST=K1
 W:LST<OLD "*" Q
COM ; List comment if any
 S COM=$G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,1)) Q:COM=""  I $L(COM)<51 W !?16,COM Q
 F LEN=51:-1:1 Q:$E(COM,LEN)=" "
 W !?16,$E(COM,1,LEN-1) S COM=$E(COM,LEN+1,999)
 W:COM'="" !?19,COM Q
DT S X=$J(+$E(X,6,7),2)_"-"_$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",+$E(X,4,5)) Q
RM ;
 D PATNAME^FHOMUTL I DFN="" Q
 I SRT="R" S RM=$G(^DPT(DFN,.101))
 E  S RM=$P($G(^DPT(DFN,0)),"^",1)
 S:RM="" RM=" " S ^TMP($J,"FHSRT",RM,FHDFN)=ADM Q
HDR ;W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1,DTP=NOW D DTP^FH
 W @IOF S PG=PG+1,DTP=NOW D DTP^FH
 W !,DTP,?(67-$L(WRDN)\2),WRDN," DIET ORDERS",?72,"Page ",PG
 I SER'="A" S X=$S(SER="T":"TRAY",SER="C":"CAFETERIA",1:"DINING ROOM")_" Service Only" W !!?(79-$L(X)\2),X
 W !!,"Room",?13,"Patient",?39,"ID#",?48,"Admission Date",?66,"Svc",?71,"Ord Date" Q
