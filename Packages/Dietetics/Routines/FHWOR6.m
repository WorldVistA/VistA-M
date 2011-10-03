FHWOR6 ; HISC/NCA - Update Orderable Items For Master File ;5/2/00  10:07
 ;;5.5;DIETETICS;**5**;Jan 28, 2005;Build 53
UPDATE ; Update Diet Orders and Tubefeedings
 K MSG
 I TYP="D" D CHKD
 I TYP="T" D CHKT
 K ACT,FILE,FILNM,K,NAM,N1,N2,PREC,STR,STR1,SYN,Z1
 I $D(MSG) D SEND
 Q
CHKD ; Check which Diet Order transactions
 S FILE="111",FILNM=$P($G(^FH(111,0)),"^",1)
 I $P(IEN,"^",3) S CHK=1,IEN=+IEN D PROCD S CHK=0 D CHKI Q
 S IEN=+IEN
 I $G(^FH(111,IEN,0))="" S CHK=2 D PROCD Q
 I NOD1'=$P($G(^FH(111,IEN,0)),"^",1,4) S CHK=3 D PROCD S CHK=0
 S STR="" F IEN1=0:0 S IEN1=$O(^FH(111,IEN,"AN",IEN1)) Q:IEN1<1  S:STR'="" STR=STR_"," S STR=STR_IEN1
 S STR1="" F IEN1=0:0 S IEN1=$O(^TMP($J,"FHNOD3",IEN1)) Q:IEN1<1  S:STR1'="" STR1=STR1_"," S STR1=STR1_IEN1
 I $L(STR,",")'=$L(STR1,",") S CHK=3 D PROCD S CHK=0 D CHKI Q
 I STR'=STR1 S CHK=3 D PROCD S CHK=0 D CHKI Q
 F K=1:1 Q:$P(STR1,",",K)=""  S IEN1=$P(STR,",",K) D CHKD1
CHKI I NOD2'="Y",$G(^FH(111,IEN,"I"))="Y" S CHK=4 D PROCD Q
 I NOD2="Y",$G(^FH(111,IEN,"I"))'="Y" S CHK=5 D PROCD Q
 Q
CHKD1 I 'IEN1 S CHK=3 D PROCD S CHK=0 Q
 I $G(^FH(111,IEN,"AN",IEN1,0))'=$G(^TMP($J,"FHNOD3",($P(STR1,",",K)))) S CHK=3 D PROCD S CHK=0
 Q
PROCD ; Process Diet Order Msg.
 Q:'CHK
 I REC D CODE^FHWORI S REC=0,N1=2
 S Z1=$S($G(^FH(111,IEN,0))'="":$G(^FH(111,IEN,0)),1:$P(NOD1,"^",1,4))
 G ADD:CHK=1,DLD:CHK=2,UPD:CHK=3,DCD:CHK=4,ACD:CHK=5
 Q
CHKT ; Check which Tubefeeding Transactions
 S FILE="118.2",FILNM=$P($G(^FH(118.2,0)),"^",1)
 I $P(IEN,"^",3) S CHK=1 S IEN=+IEN D PROCT S CHK=0 D CHKIN Q
 S IEN=+IEN
 I $G(^FH(118.2,IEN,0))="" S CHK=2 D PROCT Q
 I NOD1'=$P($G(^FH(118.2,IEN,0)),"^",1) S CHK=3 D PROCT S CHK=0 D CHKIN Q
 S STR="" F IEN1=0:0 S IEN1=$O(^FH(118.2,IEN,1,IEN1)) Q:IEN1<1  S:STR'="" STR=STR_"," S STR=STR_IEN1
 S STR1="" F IEN1=0:0 S IEN1=$O(^TMP($J,"FHNOD2",IEN1)) Q:IEN1<1  S:STR1'="" STR1=STR1_"," S STR1=STR1_IEN1
 I $L(STR,",")'=$L(STR1,",") S CHK=3 D PROCT S CHK=0 D CHKIN Q
 I STR'=STR1 S CHK=3 D PROCT S CHK=0 D CHKIN Q
 F K=1:1 Q:$P(STR1,",",K)=""  S IEN1=$P(STR,",",K) D CHKT1
CHKIN ; Check if more than one transaction
 I NOD3'="Y",$G(^FH(118.2,IEN,"I"))="Y" S CHK=4 D PROCT Q
 I NOD3="Y",$G(^FH(118.2,IEN,"I"))'="Y" S CHK=5 D PROCT Q
 Q
CHKT1 I 'IEN1 S CHK=3 D PROCT S CHK=0 Q
 I $G(^FH(118.2,IEN,1,IEN1,0))'=$G(^TMP($J,"FHNOD2",($P(STR1,",",K)))) S CHK=3 D PROCT S CHK=0
 Q
PROCT ; Process Tubefeeding Msg.
 Q:'CHK
 I REC D CODE^FHWORI S REC=0,N1=2
 S Z1=$S($G(^FH(118.2,IEN,0))'="":$G(^FH(118.2,IEN,0)),1:NOD1)
 G ADT:CHK=1,DLT:CHK=2,UPT:CHK=3,DCT:CHK=4,ACT:CHK=5
 Q
ADD ; Code Add Diet Order
 S ACT="MAD" G DO
DLD ; Code Delete Diet Order
 S ACT="MDL" G DO
UPD ; Code Update Diet Order
 S ACT="MUP" G DO
DCD ; Code Deactivate Diet Order
 S ACT="MDC" G DO
ACD ; Code Reactivate Deactivated Diet Order
 S ACT="MAC" G DO
ADT ; Code Add Tubefeeding
 S ACT="MAD" G TF
DLT ; Code Delete Tubefeeding
 S ACT="MDL" G TF
UPT ; Code Update Tubefeeding
 S ACT="MUP" G TF
DCT ; Code Deactive Tubefeeding
 S ACT="MDC" G TF
ACT ; Code Reactivate Deactivated Tubefeeding
 S ACT="MAC" G TF
DO ; Code Diet Order MFE, ZFH, and ZSY
 S NAM=$P(Z1,"^",1) Q:NAM=""  S PREC=$P(Z1,"^",4) Q:'PREC
 S SYN=$P(Z1,"^",2),N1=N1+1
 S MSG(N1)="MFE|"_ACT_"|||^^^"_IEN_"^"_NAM_"^99FHD"
 S N1=N1+1,MSG(N1)="ZFH|D|"_PREC_"||"_$P(Z1,"^",3)
 I $G(^FH(111,IEN,0))="" S FHK=0 D  Q
 .F IEN1=0:0 S IEN1=$O(^TMP($J,"FHNOD3",IEN1)) Q:IEN1<1  S FHK=IEN1 D
 ..S SYN1=$G(^TMP($J,"FHNOD3",IEN1)) I SYN1'="" S N1=N1+1,MSG(N1)="ZSY|"_IEN1_"|"_SYN1 Q
 .I SYN'="" S N1=N1+1,MSG(N1)="ZSY|"_(FHK+1)_"|"_SYN
 .Q
 S FHK=0 F IEN1=0:0 S IEN1=$O(^FH(111,IEN,"AN",IEN1)) Q:IEN1<1  S SYN1=$G(^(IEN1,0)) D
 .S FHK=IEN1,SYN1=$P(SYN1,"^",1) I SYN1'="" S N1=N1+1,MSG(N1)="ZSY|"_IEN1_"|"_SYN1 Q
 I SYN'="" S N1=N1+1,MSG(N1)="ZSY|"_(FHK+1)_"|"_SYN
 Q
TF ; Code Tubefeeding MFE, ZFH, and ZSY
 S NAM=$P(Z1,"^",1) Q:NAM=""  S N1=N1+1
 S MSG(N1)="MFE|"_ACT_"|||^^^"_IEN_"^"_NAM_"^99FHT"
 S N1=N1+1,MSG(N1)="ZFH|T|"
 I $G(^FH(118.2,IEN,0))="" D  Q
 .F IEN1=0:0 S IEN1=$O(^TMP($J,"FHNOD2",IEN1)) Q:IEN1<1  D
 ..S SYN=$G(^TMP($J,"FHNOD2",IEN1)) I SYN'="" D
 ..S N1=N1+1
 ..S MSG(N1)="ZSY|"_IEN1_"|"_SYN Q
 .Q
 F IEN1=0:0 S IEN1=$O(^FH(118.2,IEN,1,IEN1)) Q:IEN1<1  S SYN=$G(^(IEN1,0)) D
 .S SYN=$P(SYN,"^",1) Q:SYN=""  S N1=N1+1
 .S MSG(N1)="ZSY|"_IEN1_"|"_SYN Q
 Q
SEND ; Send Message to OE/RR
 D MSG^XQOR("FH ORDERABLE ITEM UPDATE",.MSG)
 K MSG Q
