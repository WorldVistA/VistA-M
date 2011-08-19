FHORT11 ; HISC/REL/NCA - File Tubefeeding Order ;9/4/96  09:18
 ;;5.5;DIETETICS;;Jan 28, 2005
 L +^FHPT(FHDFN,"A",ADM,"TF",0) S:'$D(^FHPT(FHDFN,"A",ADM,"TF",0)) ^FHPT(FHDFN,"A",ADM,"TF",0)="^115.04^^"
 S TF=$P(^FHPT(FHDFN,"A",ADM,"TF",0),"^",3)+1,$P(^(0),"^",3,4)=TF_"^"_TF L -^FHPT(FHDFN,"A",ADM,"TF",0)
 D NOW^%DTC S NOW=%,DT=NOW\1
 S ^FHPT(FHDFN,"A",ADM,"TF",TF,0)=NOW_"^^^^"_TFCOM_"^"_TC_"^"_TK_"^^^"_DUZ
 S TF2=0 F P=0:0 S P=$O(TUN(P)) Q:P<1  D TF1
 S ^FHPT(FHDFN,"A",ADM,"TF",TF,"P",0)="^115.1P^"_TF2_"^"_TF2
 S $P(^FHPT(FHDFN,"A",ADM,0),"^",4)=TF,^FHPT("ADTF",FHDFN,ADM)="",EVT="T^O^"_TF D ^FHORX
 S:FHWF'=2 (FHORN,FHSAV)=""
 I CAN S FHOR="^^^^",FHLD="X",TYP="",D1=NOW,D2="",D4=0,COM="Hold Tray due to Tubefeeding" D STR^FHORD7 I $P(^FHPT(FHDFN,"A",ADM,0),"^",7) S CAN=CAN+1 D CAN^FHNO5 K NO
 D POST^FHORT3 W:FHWF'=2 "  ... filed" Q
TF1 S TF2=TF2+1,^FHPT(FHDFN,"A",ADM,"TF",TF,"P",TF2,0)=$P(TUN(P),"^",1,6)
 S ^FHPT(FHDFN,"A",ADM,"TF",TF,"P","B",+TUN(P),TF2)="" Q
