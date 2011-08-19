FHORX1 ; HISC/REL/RVD - Diet Activity Report ;9/10/98  15:31
 ;;5.5;DIETETICS;**1,8**;Jan 28, 2005;Build 28
 ;RVD patch #1 - get outpatient info from Nutrition Events file.
 ;
 D NOW^%DTC S NOW=%,TIM=""
R0 D DIV^FHOMUTL G:'$D(FHSITE) KIL
 S FHP=FHSITE
R1 R !!,"Do you want labels? N// ",X:DTIME G:'$T!(X["^") KIL S:X="" X="N" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,"  Enter YES or NO" G R1
 S LAB=X?1"Y".E
 S:$G(FHP) TIM=$P($G(^FH(119.73,FHP,0)),"^",$S(LAB:3,1:2))
 I 'TIM S TIM=DT
 S FHLBFLG=1 I LAB D  I FHLBFLG=0 Q
 .W ! K DIR,LABSTART S DIR(0)="NA^1:10",DIR("A")="If using laser label sheets, what row do you want to begin printing at? ",DIR("B")=1 D ^DIR
 .I $D(DIRUT) S FHLBFLG=0 Q
 .S LABSTART=Y Q
 S DTP=TIM D DTP^FH
R3 W !!,"Changes since Date/Time: ",DTP," // " R X:DTIME G:'$T!(X["^") KIL I X'="" S %DT="EXTS" D ^%DT K %DT G:Y<1 R3 S TIM=Y
 W ! K IOP,%ZIS S %ZIS("A")="Select "_$S(LAB:"LABEL",1:"LIST")_" Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHORX1",FHLST="TIM^LAB^FHP^LABSTART^FHSITE^FHSITENM" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; Print the Diet Activity Report
 S FHTIM=TIM    ;save date/time for recurring meal data.
 K ^TMP($J) D NOW^%DTC S NOW=%,DTP=TIM,TIM=TIM-.000001 D DTP^FH S H1=DTP_" - " S DTP=NOW D DTP^FH S H1=H1_DTP D ^FHDEV
 F W1=0:0 S W1=$O(^FH(119.6,W1)) Q:W1<1  D WRD
 I LAB S LAB=$P($G(^FH(119.9,1,"D",IOS,0)),"^",2) S:'LAB LAB=1
 F LLL=TIM:0 S LLL=$O(^FH(119.8,"AD",LLL)) Q:LLL<1  F DA=0:0 S DA=$O(^FH(119.8,"AD",LLL,DA)) Q:DA<1  D Q3
 ;
OUTP ;get outpatient data
 F LLL=TIM:0 S LLL=$O(^FH(119.8,"AD",LLL)) Q:LLL<1  F DA=0:0 S DA=$O(^FH(119.8,"AD",LLL,DA)) Q:DA<1  D
 .S FHPROR=99,(FHTC,FHCOMO)=""
 .S Z=$G(^FH(119.8,DA,0)) Q:Z=""
 .S FHDTIM=$P(Z,"^",2),FHDFN=$P(Z,"^",3),FHOUTP=$P(Z,"^",5)
 .Q:FHOUTP'="Z"
 .S FHACTI=$P(Z,"^",6)
 .S FHDESC=$P(Z,"^",8),FHLOCN=$P(FHDESC,",",2)
 .S FHLOCN=$E(FHLOCN,2,$L(FHLOCN))
 .S:FHLOCN'="" FHLIEN=$O(^FH(119.6,"B",FHLOCN,0))
 .I $G(FHLIEN) D
 ..S FHPROR=$P($G(^FH(119.6,FHLIEN,0)),U,4)
 ..S FHSERV1=$P($G(^FH(119.6,FHLIEN,0)),U,5)
 ..I $G(FHSERV1),$D(^FH(119.72,FHSERV1,0)) S FHTC=FHTC_$P(^(0),U,2)
 ..S FHSERV2=$P($G(^FH(119.6,FHLIEN,0)),U,6)
 ..I $G(FHSERV2),$D(^FH(119.72,FHSERV2,0)) S FHTC=FHTC_$P(^(0),U,2)
 ..S FHSERV3=$P($G(^FH(119.6,FHLIEN,0)),U,7)
 ..I $G(FHSERV3) S FHTC=FHTC_"D"
 ..S FHCOMO=$P($G(^FH(119.6,FHLIEN,0)),U,8)
 .I $G(FHSITE),FHCOMO'=FHSITE Q
 .S FHCLER=$P(Z,"^",9)
 .S FHPTNM="***"
 .S:FHLOCN="" FHLOCN="***"
 .D PATNAME^FHOMUTL
 .S FHLPAT=FHPROR_"~"_FHLOCN_"~~"_DFN_"~"_FHPTNM
 .S DTP=FHDTIM D DTP^FH
 .S ^TMP($J,"O",FHLPAT,DA)=FHACTI_"^"_DTP_"^"_FHBID_"^"_FHDESC_"^"_FHTC
 ;
 ;D PROSG   ;print outpatient data
 ;go to routines for printing report
 G ^FHORX1A:'LAB,^FHORX1B
WRD S P0=$G(^FH(119.6,W1,0)),WRDN=$P(P0,"^",1),D2=$P(P0,"^",8),P0=$P(P0,"^",4),P0=$S(P0<1:99,P0<10:"0"_P0,1:P0)
 I $G(FHP),D2=FHP S ^TMP($J,"W",W1)=P0_"~"_WRDN
 I '$G(FHP) S ^TMP($J,"W",W1)=P0_"~"_WRDN
 Q
Q3 S Z=$G(^FH(119.8,DA,0)) Q:Z=""  S TM1=($P(Z,"^",2)\1),FHDFN=$P(Z,"^",3),ADM=$P(Z,"^",4) Q:'$G(ADM)  Q:'$D(^FHPT(FHDFN,"A",ADM,0))
 D PATNAME^FHOMUTL I DFN="" Q
 S WARD=$G(^DPT(DFN,.1)) G:WARD="" Q5 ; Not an inpatient
 I $G(^DPT("CN",WARD,DFN))'=ADM Q  ; Not current admission
 S X0=^FHPT(FHDFN,"A",ADM,0),W1=+$P(X0,"^",8) I '$D(^TMP($J,"W",W1)) Q  ; Not in this Comm Office
 S R1=$G(^DPT(DFN,.101))
 S RI=$G(^DPT(DFN,.108)) S RE=$S(RI:$O(^FH(119.6,"AR",+RI,W1,0)),1:"")
 S R0=$S(RE:$P($G(^FH(119.6,W1,"R",+RE,0)),"^",2),1:"")
 S R0=$S(R0<1:99,R0<10:"0"_R0,1:R0)
 S ^TMP($J,"I",^TMP($J,"W",W1)_"~"_R0_"~"_R1_"~"_FHDFN,DA)=$P(Z,"^",4,9) Q
Q5 ; process discharges
 S W1=+$P(Z,"^",8) Q:'W1  Q:'$D(^TMP($J,"W",W1))
 S ^TMP($J,"I",^TMP($J,"W",W1)_"~~***~"_FHDFN,DA)=$P(Z,"^",4,9)
 Q
 ;
PROSG ;process recurring, special and guest meals.
 S FHPLNM=""
 S:$G(FHP) FHPLNM=$P($G(^FH(119.73,FHP,0)),U,1)
REC ;for recurring meals
 ;S FHTMPS=$NA(^TMP($J,"OP","R",FHPLNM))
 S FHTMPS="^TMP($J,""OP"",""R"")"
 S FHN="" F  S FHN=$O(@FHTMPS@(FHN)) Q:FHN=""  S FHI="" F  S FHI=$O(@FHTMPS@(FHN,FHI)) Q:FHI=""  S FHJ="" F  S FHJ=$O(@FHTMPS@(FHN,FHI,FHJ)) Q:FHJ=""  D
 .I (FHPLNM'=""),(FHN'=FHPLNM) Q
 .S FHPROR="01",FHLOC=""
 .S:$D(^FH(119.6,"B",FHI)) FHLOC=$O(^FH(119.6,"B",FHI,0))
 .S:$G(FHLOC) FHPROR=$P($G(^FH(119.6,FHLOC,0)),U,4)
 .F FHK=0:0 S FHK=$O(@FHTMPS@(FHN,FHI,FHJ,FHK)) Q:(FHK'>0)!(FHK>NOW)  D
 ..S (FHRDAT,FHIJKDAT)=@FHTMPS@(FHN,FHI,FHJ,FHK)
 ..S $P(FHRDAT,U,3)=$P(FHIJKDAT,U,18)
 ..S $P(FHRDAT,U,4)=$P(FHIJKDAT,U,3)
 ..S $P(FHRDAT,U,9)=$P(FHIJKDAT,U,4)
 ..S $P(FHRDAT,U,5)=$P(FHIJKDAT,U,8)
 ..S $P(FHRDAT,U,8)=$P(FHIJKDAT,U,7)
 ..S $P(FHRDAT,U,13)=$P(FHIJKDAT,U,17)
 ..S FHLPAT=FHPROR_"~"_FHI_"~~~"_$P(FHIJKDAT,U,1)
 ..S ^TMP($J,"O",FHLPAT,FHK)="RECURRING"_"^"_FHJ_"^"_FHRDAT
SPEC ;for special meals
 ;S FHPLNM=$P($G(^FH(119.73,FHP,0)),U,1) Q:FHPLNM=""    ;quit if no comm
 ;S FHTMPS=$NA(^TMP($J,"OP","S"))
 S FHTMPS="^TMP($J,""OP"",""S"")"
 S FHN="" F  S FHN=$O(@FHTMPS@(FHN)) Q:FHN=""  S FHI="" F  S FHI=$O(@FHTMPS@(FHN,FHI)) Q:FHI=""  S FHJ="" F  S FHJ=$O(@FHTMPS@(FHN,FHI,FHJ)) Q:FHJ=""  D
 .I (FHPLNM'=""),(FHN'=FHPLNM) Q
 .S FHPROR="01",FHLOC=""
 .S:$D(^FH(119.6,"B",FHI)) FHLOC=$O(^FH(119.6,"B",FHI,0))
 .S:$G(FHLOC) FHPROR=$P($G(^FH(119.6,FHLOC,0)),U,4)
 .F FHK=0:0 S FHK=$O(@FHTMPS@(FHN,FHI,FHJ,FHK)) Q:(FHK'>0)!(FHK>NOW)  D
 ..S FHIJKDAT=@FHTMPS@(FHN,FHI,FHJ,FHK)
 ..S FHLPAT=FHPROR_"~"_FHI_"~~~"_$P(FHIJKDAT,U,1)
 ..S ^TMP($J,"O",FHLPAT,FHK)="SPECIAL"_"^"_FHJ_"^"_FHIJKDAT
 ;for guest meals
GUEST ;S FHTMPS=$NA(^TMP($J,"OP","G",FHPLNM))
 S FHTMPS="^TMP($J,""OP"",""G"")"
 S FHN="" F  S FHN=$O(@FHTMPS@(FHN)) Q:FHN=""  S FHI="" F  S FHI=$O(@FHTMPS@(FHN,FHI)) Q:FHI=""  S FHJ="" F  S FHJ=$O(@FHTMPS@(FHN,FHI,FHJ)) Q:FHJ=""  D
 .I (FHPLNM'=""),(FHN'=FHPLNM) Q
 .S FHPROR="01",FHLOC=""
 .S:$D(^FH(119.6,"B",FHI)) FHLOC=$O(^FH(119.6,"B",FHI,0))
 .S:$G(FHLOC) FHPROR=$P($G(^FH(119.6,FHLOC,0)),U,4)
 .F FHK=0:0 S FHK=$O(@FHTMPS@(FHN,FHI,FHJ,FHK)) Q:(FHK'>0)!(FHK>NOW)  D
 ..S FHIJKDAT=@FHTMPS@(FHN,FHI,FHJ,FHK)
 ..S FHGDIET=$P($G(^FH(119.9,1,0)),U,2)
 ..S $P(FHIJKDAT,U,9)=$P(FHIJKDAT,U,3)
 ..S $P(FHIJKDAT,U,14)=$P(FHIJKDAT,U,4)
 ..S $P(FHIJKDAT,U,15)=$P(FHIJKDAT,U,5)
 ..S FHGDIETN=$P(FHIJKDAT,U,6)
 ..I $G(FHGDIETN),$D(^FH(111,FHGDIETN,0)) D
 ...S FHGDTNM=$P(^FH(111,FHGDIETN,0),U,1)
 ..E  S:$G(FHGDIET) FHGDTNM=$P($G(^FH(111,FHGDIET,0)),U,1)
 ..S $P(FHIJKDAT,U,4)=FHGDTNM
 ..I $G(FHGDIET),$D(^FH(111,FHGDIET,0)) D
 ...S $P(FHIJKDAT,U,4)=$P(^FH(111,FHGDIET,0),U,1)
 ..S FHLPAT=FHPROR_"~"_FHI_"~~~"_$P(FHIJKDAT,U,1)
 ..S ^TMP($J,"O",FHLPAT,FHK)="GUEST"_"^"_FHJ_"^"_FHIJKDAT
 Q
 ;
KIL K ^TMP($J) G KILL^XUSCLEAN
