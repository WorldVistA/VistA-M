ICD18105O ;ALB/JDG - YEARLY DRG UPDATE; October 01, 2020@15:42
 ;;18.0;DRG Grouper;**105**;October 20, 2000;Build 1
 ;
 ; Inactivating DRG(s) - will add an entry for fiscal year 2021
 ; DRG is being inactivated with an inactive status.
 Q
 ;
 ;
INACTDRG ;
 N ICDLINE,ICDX,ICDDRG,ICDDESC,DA,DIE,DR,ICDMDC,ICDSURG,ICDFDA
 D BMES^XPDUTL(">>> Inactivating DRG(s) for FY 2021...")
 F ICDLINE=1:1 S ICDX=$T(INAC+ICDLINE) S ICDDRG=$P(ICDX,";;",2) Q:ICDDRG="EXIT"  D
 .S ICDDESC="NO LONGER VALID"
 .S DA(ICDLINE)=$P(ICDDRG,U)
 .S DA=1
 .S DIE="^ICD("_DA(ICDLINE)_",1,"
 .S DR=".01///^S X=ICDDESC"
 .D ^DIE
 .; check if already done in case patch being re-installed
 .Q:$D(^ICD($P(ICDDRG,U),66,"B",3201001))
 .; add entry to 80.266
 .S ICDMDC=$P(ICDDRG,U,2)
 .S ICDSURG=$P(ICDDRG,U,3)
 .S ICDDRG=$P(ICDDRG,U)
 .S ICDFDA(80.2,"?1,",.01)=ICDDRG
 .S ICDFDA(80.266,"+2,?1,",.01)=3201001
 .S ICDFDA(80.266,"+2,?1,",.03)=0
 .S ICDFDA(80.266,"+2,?1,",.05)=ICDMDC
 .S ICDFDA(80.266,"+2,?1,",.06)=ICDSURG
 .D UPDATE^DIE("","ICDFDA") K ICDFDA
 .; add entry to 80.268 and 80.2681 
 .S ICDFDA(80.2,"?1,",.01)=ICDDRG
 .S ICDFDA(80.268,"+2,?1,",.01)=3201001
 .D UPDATE^DIE("","ICDFDA") K ICDFDA
 .S ICDFDA(80.2,"?1,",.01)=ICDDRG
 .S ICDFDA(80.2681,"?2,?1,",.01)=3201001
 .S ICDFDA(80.2681,"+3,?2,?1,",.01)=ICDDESC
 .D UPDATE^DIE("","ICDFDA") K ICDFDA
 ;
 ;
INAC ;DRG^MDC^SURG (1=surg, 0=med)
 ;;129^3^1
 ;;130^3^1
 ;;131^3^1
 ;;132^3^1
 ;;133^3^1
 ;;134^3^1
 ;;EXIT
