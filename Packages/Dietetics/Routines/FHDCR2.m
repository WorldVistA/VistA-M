FHDCR2 ; HISC/REL/NCA - Find Order Changes ;4/20/95  11:33
 ;;5.5;DIETETICS;;Jan 28, 2005
EVT ; Find order changes,SF,FP,Isolation,SO,Location
 ; Except Allergies.
 I SF,$P($G(^FHPT(FHDFN,"A",ADM,"SF",+SF,0)),"^",2)>FHD,$P($G(^FHPT(FHDFN,"A",ADM,"SF",+SF,0)),"^",34)'="Y" S FLG2=1 Q
 F KK=FHD-.0001:0 S KK=$O(^FH(119.8,"AP",FHDFN,KK)) Q:KK>TIM!(KK<1)  F DA=0:0 S DA=$O(^FH(119.8,"AP",FHDFN,KK,DA)) Q:DA<1  D  Q:FLG2
 .S Z=$G(^FH(119.8,DA,0)) Q:Z=""  S D1=$P(Z,"^",2),TYP=$P(Z,"^",5),ACT=$P(Z,"^",6)
 .I TYP="L" D  Q
 ..I "AT"[ACT S FLG2=1 Q
 ..Q
 .I TYP="D" Q
 .I TYP="M" Q
 .I TYP="I" S FLG2=1 Q
 .I TYP="T" Q
 .I TYP="O" Q
 .I TYP="P" S FLG2=1 Q
 .I TYP="S" S FLG2=1 Q
 .Q
 Q
