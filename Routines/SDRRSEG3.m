SDRRSEG3 ;10N20/MAH;Display Future Clinic Recalls in Brief Patient Inquiry; 1/15/08  
 ;;5.3;Scheduling;**536**;Aug 13, 1993;Build 53
 N I,Y,CLINIC,C,D,KEY
 W !!,"Future Clinic Recalls:"
 I '$D(^SD(403.5,"B",DFN)) W ?25,"<No Clinic Recall on file>",! G EXIT
 W !
 W ?2,"Clinic",?32,"Recall Date",?55,"Notice Sent",!
 F Q=1:1:79 W "="
EN1 ;
 K ^TMP("SDRRCLR")
 S C=0 F I=0:0 S I=$O(^SD(403.5,"B",DFN,I)) Q:'I  I $D(^SD(403.5,I,0)) S D=^(0),C=C+1 S ^TMP("SDRRCLR",$J,C)=I_"^"_D
 S (ER,OK)=0 W ! F  S I=$O(^TMP("SDRRCLR",$J,I)) Q:'I   S CLINIC=$P($G(^TMP("SDRRCLR",$J,I)),"^",3) D
 .I CLINIC'="" S CLINIC=$$GET1^DIQ(44,CLINIC_",",.01)
 .I CLINIC="" S CLINIC="UNK. CLINIC"
 .S PROV=$P($G(^TMP("SDRRCLR",$J,I)),"^",6) I PROV'="" S PROV=$P($G(^SD(403.54,PROV,0)),"^",1) I PROV'="" S PROV=$$NAME^XUSER(PROV,"F")
 .I PROV="" S PROV="UNK. PROVIDER"
 .S RDT="",RDT=$P(^TMP("SDRRCLR",$J,I),"^",7) I $G(RDT)]"" S Y=RDT D DD^%DT S RDT=Y
 .S RS=$P(^TMP("SDRRCLR",$J,I),"^",11) I $G(RS)]"" S Y=RS D DD^%DT S RS=Y
 .I RS="" S RS="NO"
 .W ?2,$E(CLINIC,1,30),?32,RDT,?55,RS,! S Z=I
EXIT ;
 K ER,OK,PROV,RDT,RS,X,Z,Q
 Q
