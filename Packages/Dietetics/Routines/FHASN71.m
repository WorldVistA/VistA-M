FHASN71 ; HISC/NCA - Print Status Average (cont.) ;9/28/95  10:52
 ;;5.5;DIETETICS;**30**;Jan 28, 2005;Build 4
 ;IA # 1071 - DGPMSTAT
 ;IA # 1096 - PATIENT MOVEMENT file cross reference
 ;IA # 2056 - Data Base Server API: Data Retriever Utilities
 ;IA # 2090 - ACCESS TO PATIENT MOVEMENT DATA
Q0 ; Process Screening all patients
 K CLIN,DWRD,LIST,LST,NAME,S,WARD,WC,WLCN,WRD,X,X1
 S TOT=""
 ;Build lists of MAS wards, ward names, ward clinicians, clinician names
 ;DWRD - Array MAS Wards
 ;FHWN - Array Ward Names
 ;FHWC - Array Ward Clinicains
 ;FHWCN - Array Ward Clinican Names
 F WRD=0:0 S WRD=$O(^FH(119.6,WRD)) Q:WRD<1  D
 . F LST=0:0 S LST=$O(^FH(119.6,WRD,"W",LST)) Q:LST<1  D
 . . S X=+$G(^(LST,0))
 . . S:'$D(DWRD(X)) DWRD(X)=WRD
 . S FHWN(WRD)=$P($G(^FH(119.6,WRD,0)),U)
 . F WC=0:0 S WC=$O(^FH(119.6,WRD,2,WC)) Q:WC<1  D
 . . S CLIN=+$G(^FH(119.6,WRD,2,WC,0))
 . . S LIST(WRD,CLIN)=""
 . . I '$D(FHWCN(CLIN)) S FHWCN(CLIN)=$$GET1^DIQ(200,CLIN_",",.01)
 . . S LIST(WRD,CLIN)=""
 . S (X,X1)=""
 . F  S X=$O(LIST(WRD,X)) Q:X=""  S X1=X1_X_"|"
 . I X1'="" S FHWC(WRD)=X1
 . K CLIN,LIST,WC,X,X1
 ;Process all persons in the NUTRITION PERSON file
 F FHDFN=0:0 S FHDFN=$O(^FHPT(FHDFN)) Q:FHDFN<1  I $D(^FHPT(FHDFN,0)) K N S ND=0 D TS,CALC
 ;Build sort array, print summary
 D BSA,PS
 ;Variable clean up and exit
 K ^TMP($J)
 ;D KILL^XUSCLEAN
 Q
TS ; Tabulate status
 D PATNAME^FHOMUTL I DFN="" Q
 S DGT=EDT+1,DGT=DGT+.0000001
 S (DGA1,DG1,DGXFR0)=""
 D ^DGPMSTAT
 Q:DGA1=""!(DG1="")
 S ADM=DGA1,XX=$G(^DGPM(ADM,0))
 S DISC=$P(XX,"^",17)
 S:DISC'="" DISC=$P($G(^DGPM(DISC,0)),"^",1)
 Q:'$D(^FHPT(FHDFN,"A",ADM,0))
 S MW1=$S($P(DG1,"^",1):$P(DG1,"^",1),1:0)
 S W1=$S($D(DWRD(+MW1)):$G(DWRD(+MW1)),1:0)
 I '$D(^FH(119.6,+W1,0)) S MWRD=$P($G(^DIC(42,+MW1,0)),"^",1) S DW1=$O(^FH(119.6,"B",MWRD,0)) Q:DW1<1  S W1=+DW1
 S WD=$G(FHWC(+W1)) S:'WD WD=0
 I '$D(^FHPT(FHDFN,"S",0)) D UC Q
 D NS I '$D(^TMP($J,"FHNS")) D UC Q
 S NX="" F X4=0:0 S X4=$O(^TMP($J,"FHNS",X4)) Q:X4<1  S X5=$G(^(X4,0)),NX=X4 D CHK
 Q
CHK ; Check if inpatient with ADM
 I $P(X5,"^",1)<$S($D(^FHPT(FHDFN,"A",ADM,0)):$P(^(0),"^",1),1:9999999) D  Q
 . D GADM
 . I '$D(^FHPT(FHDFN,"A",ADM,0)) D UC Q
 . I $P(X5,"^",1)<$S($D(^FHPT(FHDFN,"A",ADM,0)):$P(^(0),"^",1),1:9999999) D UC Q
 I DISC,$P(X5,"^",1)>DISC D GADM Q:'$D(^FHPT(FHDFN,"A",ADM,0))  Q:DISC&($P(X5,"^",1)>DISC)
 S S1=$P(X5,"^",2),D1=$P(X5,"^",3)_"|"
 S W1=$S($P(X5,"^",6)'="":$P(X5,"^",6),1:W1)
 S:'W1 W1=0
 S WD=$G(FHWC(+W1))
 S:'WD WD=0
 I S1,S1<5 D SC Q 
UC ; Unclassified
 S S1=5
SC ; Set Classification
 S X=$S(SRT="W":W1,1:WD)
 S:'$D(N(X)) N(X)=""
 S $P(N(X),U,S1)=$P(N(X),U,S1)+1
 S ND=ND+1
 Q
GADM ; Get ADM for patient
 D PATNAME^FHOMUTL I DFN="" Q
 S NX=$O(^DGPM("ATID1",DFN,NX)) Q:NX=""  S ADM=+$O(^(NX,0)),XX=$G(^DGPM(ADM,0)),DISC=$P(XX,"^",17) S:DISC'="" DISC=$P($G(^DGPM(DISC,0)),"^",1)
 Q:'$D(^FHPT(FHDFN,"A",ADM,0))  Q:$P(X5,"^",1)<$S($D(^FHPT(FHDFN,"A",ADM,0)):$P(^(0),"^",1),1:9999999)
 S W1=$S($P(XX,"^",6):$P(XX,"^",6),1:0),WD=$G(FHWC(+W1)) S:'WD WD=0
 Q
NS ; Nutrition Status in inverse date order
 K ^TMP($J,"FHNS") S FHX1=9999999-(EDT+.3),FHX2=9999999-(SDT+.0001),ZZ=""
 F XX=FHX1:0 S XX=$O(^FHPT(FHDFN,"S",XX)) Q:XX<1!(XX>FHX2)  S X=$G(^(XX,0)) D STOR
 I '$D(^TMP($J,"FHNS")) S XX=FHX1,FHX1=$O(^FHPT(FHDFN,"S",FHX1)) Q:FHX1=""  S X=$G(^(FHX1,0)) D STOR
 Q
STOR ; Store Nutrition Status by inverse date
 I ZZ'=($P(X,"^",1)\1) S ^TMP($J,"FHNS",XX,0)=X
 S ZZ=$P(X,"^",1)\1
 Q
CALC ;Calculate Average
 I $G(N(0))'="" S L=0 D C1
 I SRT="W" F L=0:0 S L=$O(N(L)) Q:L<1  D C1
 I SRT="C" S L="" F  S L=$O(N(L)) Q:L=""  D C1
 Q
C1 ;Calculate Averages continued
 F K=1:1:5 D
 . S X=$S(ND:$P(N(L),U,K)/ND,1:"")
 . S X=$J(X,0,0)
 . S:'$D(S(L)) S(L)=""
 . S $P(S(L),U,K)=$P(S(L),U,K)+X
 . S $P(S(L),U,6)=$P(S(L),U,6)+X
 . S $P(TOT,U,K)=$P(TOT,U,K)+X
 . S $P(TOT,U,6)=$P(TOT,U,6)+X
 Q
BSA ;Build sort array
 ;SA - Sort Array
 ;SN - Sort Name
 K SA,SN
 S W1=""
 F  S W1=$O(S(W1)) Q:W1=""  D
 . I W1=0 Q
 . I SRT="W" S SN=$G(FHWN(W1))
 . I SRT="C" D
 . . S X=$P(W1,"|"),SN=$G(FHWCN(X))
 . . F X=2:1  S X1=$P($G(W1),"|",X)  Q:X1=""  S SN=SN_" - "_$G(FHWCN(X1))
 . S SN=SN_"~"_W1
 . S SA(SN)=""
 K SN
 Q
PS ; Print summary
 S DTP=SDT D DTP^FH S DTE=DTP_" to " S DTP=EDT D DTP^FH S DTE=DTE_DTP
 D NOW^%DTC S (NOW,DTP)=% D DTP^FH S PG=0,LN="",$P(LN,"-",100)="" D HDR
 S X="" F  S X=$O(SA(X)) Q:X=""  D
 . S NAME=$P(X,"~")
 . S W1=$P(X,"~",2)
 . S D1=S(W1)
 . D PSD
 I $G(S(0))'="" S NAME="UNKNOWN",D1=$G(S(0)) D PSD
 S NAME="Grand Total",D1=TOT W !?16,LN D PSD
 W !
 Q
PSD ;Print summary detail
 D:$Y>(IOSL-8) HDR
 W !?16,NAME
 I NAME[" - " W !
 W ?48
 S D3=$P(D1,U,6)
 F K=1:1:5 D
 . S D2=$P(D1,U,K)
 . W $S(D2:$J(D2,7),1:$J("",7))
 . S D2=$S(D3:D2/D3*100,1:"")
 . W $S(D2:$J(D2,5,0),1:$J("",5))
 W $S(D3:$J(D3,7),1:$J("",7))
 Q
HDR ;Report Page Header
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !?16,DTP,!!?42,"N U T R I T I O N   S T A T U S   A V E R A G E",?109,"Page ",PG
 W !!?(132-$L(DTE)\2),DTE
 W !!?16,$S(SRT="C":"CLINICIAN",1:"WARD"),?54,"I    %     II    %    III    %     IV    %    UNC    %  TOTAL",!?16,LN,!
 Q
