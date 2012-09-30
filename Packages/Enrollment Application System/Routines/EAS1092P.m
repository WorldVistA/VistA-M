EAS1092P ;ALB/LBD - Patch Post-Install functions ; 9/26/11 4:18pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**92**;15-MAR-01;Build 20
 Q
 ;
 ;Update fields in 1010EZ MAPPING file #711
 ;
EN ;Post Install entry point
 ; Update fields in 1010EZ MAPPING file #711
 D UPD711
 Q
 ;
UPD711 ;Update fields in the 1010EZ MAPPING file #711
 ;For the records related to the Last Service Episode, change the
 ;data dictionary locations in the fields MAP-TO SUB-FILE (#3) and
 ;MAP-TO FIELD (#4) to the new Military Service Episode sub-file
 ;#2.3216
 N RECNAM,FLD,NUM,LINE,IEN,DATA,ERROR,STOP
 D BMES^XPDUTL("Updating records in 1010EZ MAPPING file #711")
 F NUM=1:1 S LINE=$T(REC711+NUM) Q:LINE=""!($P(LINE,";",3)="END")  D  Q:$G(STOP)
 .S RECNAM=$P(LINE,";",3),FLD=$P(LINE,";",4)
 .S IEN=$O(^EAS(711,"B",RECNAM,"")) I 'IEN D ERR711(RECNAM) Q
 .S DATA(3)=2.3216,DATA(4)=FLD
 .D UPD^DGENDBS(711,IEN,.DATA,.ERROR) I $G(ERROR)]"" D ERR711(RECNAM) Q
 .D MES^XPDUTL("  "_RECNAM_"  -- Updated")
 Q
 ;
ERR711(RECNAM) ;Display error message and set STOP=1
 ;
 N ARR
 S STOP=1
 S ARR(1)="===================================================="
 S ARR(2)="=                   ERROR                          ="
 S ARR(3)="===================================================="
 S ARR(4)="Unable to update record "_RECNAM
 S ARR(5)="===================================================="
 ;
 D BMES^XPDUTL(.ARR)
 ;
 Q
REC711 ;;RECORD NAME;NEW FIELD NUMBER
 ;;LAST BRANCH OF SERVICE;.03
 ;;LAST ENTRY DATE;.01
 ;;LAST DISCHARGE DATE;.02
 ;;LAST DISCHARGE TYPE;.06
 ;;SERVICE NUMBER;.05
 ;;END
