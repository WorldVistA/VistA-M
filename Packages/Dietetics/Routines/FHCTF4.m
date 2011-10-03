FHCTF4 ; HISC/REL/NCA - Check Ward Patients for a Clinician ;3/8/01  13:13
 ;;5.5;DIETETICS;**20**;Jan 28, 2005;Build 7
 ;FH*5.5*20 adds support for CLINICIAN(S) field (#112)
 D NOW^%DTC S NOW=% D CLN
 F WRD=0:0 S WRD=$O(^FH(119.6,WRD)) Q:WRD<1  D
 . F FHCLN=0:0 S FHCLN=$O(^FH(119.6,WRD,2,FHCLN)) Q:FHCLN<1  D
 . . I ^FH(119.6,WRD,2,FHCLN,0)=FHDUZ!('FHDUZ) D CHK
 Q
CHK D DAT F FHDFN=0:0 S FHDFN=$O(^FHPT("AW",WRD,FHDFN)) Q:FHDFN<1  S ADM=$G(^FHPT("AW",WRD,FHDFN)) D PAT
 Q
CLN ; Clean up ticker file
 F K=0:0 S K=$O(^FH(119,FHDUZ,"I",K)) Q:K<1  S X=^(K,0) D C0
 Q
C0 ;
 S DFN=$P(X,"^",4),A0="",FHZ115="P"_DFN D CHECK^FHOMDPA I FHDFN="" Q
 G:'DFN C1 S ADM=$P(X,"^",5) G:'ADM C1
 S W1=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",8) I W1="" G KIL
 S Y=$G(^FHPT("AW",W1,FHDFN)) I ADM'=Y G KIL
 S (Y,Y1)=0
 F Y=0:0 S Y=$O(^FH(119.6,+W1,2,Y)) Q:Y<1  D
 . I ^FH(119.6,+W1,2,Y,0)="" S Y1=0 Q
 . I ^FH(119.6,+W1,2,Y,0)=FHDUZ S Y=-1,Y1=0 Q
 . S Y1=1
 I Y1 K Y1 G KIL
 K Y1
 S A0=$G(^FHPT(FHDFN,"A",ADM,0))
C1 S TYP=$P(X,"^",2) G C2:TYP="C",C3:TYP="S",C4:TYP="D",C5:TYP="X",C6:TYP="T",C7:TYP="N" Q
C2 S FHDR=$P(X,"^",6),Y=^FHPT(FHDFN,"A",ADM,"DR",FHDR,0) I $P(Y,"^",8)'="A"!($P(Y,"^",5)'=FHDUZ) D KIL
 Q
C3 D:$P(X,"^",6)'=$P(A0,"^",7) KIL Q
C4 D:$P(X,"^",6)'=$P(A0,"^",2) KIL Q
C5 D:+X<NOW KIL Q
C6 D:$P(X,"^",6)'=$P(A0,"^",4) KIL Q
C7 S Y=$O(^FHPT(FHDFN,"S",0)) D:Y<$P(X,"^",6) KIL Q
KIL K ^FH(119,FHDUZ,"I",K)
 ;K ^FH(119,FHDUZ,"I","C",PT,DT)
 Q
PAT ; Check Patient
 D PATNAME^FHOMUTL I DFN="" Q
 S A0=$G(^FHPT(FHDFN,"A",ADM,0)),FHORD=$P(A0,"^",2) I FHORD S X1=$P(A0,"^",3) G P1
 S LST=$P(A0,"^",1),FHLD="X" S:'LST LST=+D("NP") G P2
P1 S X=$G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0)),FHLD=$P(X,"^",7),PD=$P(X,"^",13),LST=$P(X,"^",16) I 'LST S LST=$P(X,"^",9)
 G P4:FHLD="P",P2:'PD S LR=$G(D("D",PD)) G P4:'LR,P4:LST>LR
 S FHTF="D^"_$P(^FH(116.2,PD,0),"^",1)_"^"_DFN_"^"_ADM_"^"_FHORD D FIL
 G P4
P2 ; Check NPO/No Order
 G:$P(A0,"^",4) P4 S LR=$G(D("NP")) G P4:'LR,P4:LST>LR
 S FHTF="D^"_$S(FHLD="P":"NPO",1:"No Order")_" > "_$P(LR,"^",2)_" days^"_DFN_"^"_ADM_"^"_FHORD D FIL
P4 ; Check Supplemental Feeding
 S NO=$P(A0,"^",7) G:'NO P5 S LR=$G(D("SF")) G:'LR P5
 S LST=$P(^FHPT(FHDFN,"A",ADM,"SF",NO,0),"^",30) I 'LST S LST=$P(^(0),"^",2)
 G:LST>LR P5 S Y=$P(^FHPT(FHDFN,"A",ADM,"SF",NO,0),"^",4),Y=$P($G(^FH(118.1,+Y,0)),"^",1)
 S FHTF="S^"_Y_"^"_DFN_"^"_ADM_"^"_NO D FIL
P5 ; Check Tubefeeding
 S TF=$P(A0,"^",4) G:'TF P6 S LR=$G(D("TF")) G:'LR P6
 S LST=$P(^FHPT(FHDFN,"A",ADM,"TF",TF,0),"^",15) I 'LST S LST=$P(^(0),"^",1)
 G:LST>LR P6
 S Y="" F TF2=0:0 S TF2=$O(^FHPT(FHDFN,"A",ADM,"TF",TF,"P",TF2)) Q:TF2<1  S XX=^(TF2,0) S:Y'="" Y=Y_", " S Y=Y_$P($G(^FH(118.2,$P(XX,"^",1),0)),"^",1)
 S FHTF="T^"_Y_"^"_DFN_"^"_ADM_"^"_TF D FIL
P6 ; Check Status
 S F1=$O(^FHPT(FHDFN,"S",0)) G:'F1 P7 S A1=^FHPT(FHDFN,"S",F1,0) I $P(A1,"^",1)<$P(A0,"^",1) G P7
 S S1=$P(A1,"^",2),LR=$G(D("S",S1)) G:'LR P8
 S LST=$P(A1,"^",4) I 'LST S LST=$P(A1,"^",1)
 G:LST>LR P8 S Y=$P(^FH(115.4,S1,0),"^",2)
 S FHTF="N^"_Y_"^"_DFN_"^"_ADM_"^"_F1 D FIL G P8
P7 S LR=$G(D("NS")) G:'LR P8 S LST=$P(A0,"^",1) G P8:LST>LR,P8:'LST
 S FHTF="N^No Admission Status^"_DFN_"^"_ADM_"^"_(9999999-LST) D FIL G P8
P8 Q
FIL ; File entry
 F L=0:0 S L=$O(^FH(119,FHDUZ,"I",L)) Q:L<1  I $P(^(L,0),"^",2,6)=FHTF S FHTF="" Q
 Q:FHTF=""  S X1=LST,X2=$P(LR,"^",2) D C^%DTC S FHTF=X_"^"_FHTF D FILE^FHCTF2 Q
DAT ; Get Review Dates
 K D,T S FHPAR=$G(^FH(119.6,WRD,0)),L=10
 F K="NP","TF","SF","NS" S L=L+1,Z=$P(FHPAR,"^",L),D(K)="" I Z D D1 S D(K)=X_"^"_Z
 F K=1:1:4 S Z=$P(FHPAR,"^",K+19) I Z D D1 S D("S",K)=X_"^"_Z
 F K=0:0 S K=$O(^FH(116.2,K)) Q:K<1  S Z=$P(^(K,0),"^",8) I Z D D1 S D("D",K)=X_"^"_Z
 K T Q
D1 I $D(T(Z)) S X=T(Z) Q
 S X1=NOW,X2=-Z D C^%DTC S T(Z)=X Q
