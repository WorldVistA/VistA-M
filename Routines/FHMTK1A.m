FHMTK1A ; HISC/REL/NCA - Build Tray Tickets ;4/21/95  08:21
 ;;5.5;DIETETICS;**5**;Jan 28, 2005;Build 53
B1 ; Store wards
 K ^TMP($J),DP,N,P,TP,T1 S ALL=0,MFLG=0 D Q1^FHMTK1B D NOW^%DTC S (DTP,TIM)=% D DTP^FH S HD=DTP
 S DTP=D1 D DTP^FH S MDT=DTP S:MEAL="A" MFLG=1
 I 'FHP,'W1,'DFN S ALL=1
 S FHBOT=$P($G(^FH(119.9,1,4)),"^",1)
 I $G(FHOMF)=1 D ^FHOMTK1 Q
 I DFN D  Q
 .S ADM=+$G(^DPT(DFN,.105)),W1=+$P($G(^FHPT(FHDFN,"A",+ADM,0)),"^",8)
 .S K1=$G(^FH(119.6,+W1,0)),WRDN=$P(K1,"^",1),SP=$P(K1,"^",5),SP1=$P(K1,"^",6),FHPAR=$P(K1,"^",24),RM=$G(^DPT(DFN,.101))
 .I 'SP Q:FHPAR'="Y"  S SP=SP1 Q:'SP
 .K MM,PP,S S NBR=0 I MEAL'="A" D BLD^FHMTK11 D:NBR UPD,PRT^FHMTK1C Q
 .F MEAL="B","N","E" D BLD^FHMTK11
 .D UPD
 .D:NBR PRT^FHMTK1C Q
 I W1 S ^TMP($J,"W","01"_$P($G(^FH(119.6,+W1,0)),"^",1))=W1_"^"_$P($G(^FH(119.6,+W1,0)),"^",5,6)_"^"_$P($G(^FH(119.6,+W1,0)),"^",24)
 E  F W1=0:0 S W1=$O(^FH(119.6,W1)) Q:W1<1  D
 .S P0=$G(^FH(119.6,W1,0)),WRDN=$P(P0,"^",1),SP=$P(P0,"^",5,6),D2=$P(P0,"^",8),FHPAR=$P(P0,"^",24),P0=$P(P0,"^",4),P0=$S(P0<1:99,P0<10:"0"_P0,1:P0)
 .I FHP,D2'=FHP Q
 .S ^TMP($J,"W",P0_WRDN)=W1_"^"_SP_"^"_FHPAR Q
 S NX="" F  S NX=$O(^TMP($J,"W",NX)) Q:NX=""  S X1=$G(^(NX)),W1=+X1,FHS=$P(X1,"^",2),SP1=$P(X1,"^",3),FHPAR=$P(X1,"^",4),WRDN=$E(NX,3,99) S:'FHS&(FHPAR="Y") FHS=SP1 I FHS K ^TMP($J,"D") D
 .F FHDFN=0:0 S FHDFN=$O(^FHPT("AW",W1,FHDFN)) Q:FHDFN<1  D
 ..D PATNAME^FHOMUTL I DFN="" Q
 ..S ADM=$G(^FHPT("AW",W1,FHDFN))
 ..I SRT="A" S RM=$P($G(^DPT(DFN,0)),"^",1),R0=0,RMB=$G(^DPT(DFN,.101)) S:RMB="" RMB="***"
 ..E  S RI=$G(^DPT(DFN,.108)),RM=$G(^DPT(DFN,.101)) S:RM="" RM="***" S RE=$S(RI:$O(^FH(119.6,"AR",+RI,W1,0)),1:""),R0=$S(RE:$P($G(^FH(119.6,W1,"R",+RE,0)),"^",2),1:""),RMB=""
 ..S R0=$S(R0<1:99,R0<10:"0"_R0,1:R0)
 ..S ^TMP($J,"D",R0_"~"_RM_"~"_$S(SRT="R":FHDFN,1:RMB))=FHDFN_"^"_ADM Q
 .K MM,PP,S S X9="",NBR=0 F  S X9=$O(^TMP($J,"D",X9)) Q:X9=""  S FHDFN=$P(^(X9),"^",1),ADM=$P(^(X9),"^",2),RM=$S(SRT="R":$P(X9,"~",2),1:$P(X9,"~",3)) S SP=FHS D
 ..D PATNAME^FHOMUTL I DFN="" Q
 ..I 'MFLG D BLD^FHMTK11,UPD Q
 ..F MEAL="B","N","E" D BLD^FHMTK11
 ..D UPD
 ..Q
 .I NBR D PRT^FHMTK1C
 .Q
OMTT ;Display outpatient tray tickets
 K MM,PP,S D ^FHOMTK1
TAB ;Display tabulated recipe list
 D LIST^FHMTK1C
 Q
UPD ; Update the Date/Time Tray Ticket was Printed
 I $G(TABREC)="YES" QUIT
 S $P(^FHPT(FHDFN,"A",ADM,0),"^",15)=TIM Q
