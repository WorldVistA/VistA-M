PSO635PO ;ALB/BWF^PSO*7*635 POST INIT ; 02/10/2021 1:50pm
 ;;7.0;OUTPATIENT PHARMACY;**635**;DEC 1997;Build 19
 D F5245
 Q
F5245 ;
 N VAL,IEN,OLD,NEW
 S VAL=0,VAL=$O(^PS(52.45,"C","ACR",VAL)) Q:'VAL  D
 .S IEN=0,IEN=$O(^PS(52.45,"C","ACR",VAL,IEN)) Q:'IEN  D
 ..S OLD=$$GET1^DIQ(52.45,IEN,.02,"E")
 ..; only fix the ones that end with a space
 ..I $E(OLD,$L(OLD))'=" " Q
 ..S NEW=$E(OLD,1,$L(OLD)-1)
 ..S FDA(52.45,IEN_",",.02)=NEW
 ..D FILE^DIE(,"FDA")
 Q
