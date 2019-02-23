ICD1896O ;ALB/JDG - YEARLY DRG UPDATE;8/9/2010
 ;;18.0;DRG Grouper;**96**;Oct 20, 2000;Build 3
 ;
 ; Inactivating DRG(s) - will add an entry for fiscal year 2019
 ; DRG is being inactivated with an inactive status.
 Q
 ;
 ;
INACTDRG ;
 N ICDLINE,ICDX,ICDDRG,ICDDESC,DA,DIE,DR,ICDMDC,ICDSURG,ICDFDA
 D BMES^XPDUTL(">>> Inactivating DRG(s) for FY 2019...")
 F ICDLINE=1:1 S ICDX=$T(INAC+ICDLINE) S ICDDRG=$P(ICDX,";;",2) Q:ICDDRG="EXIT"  D
 .S ICDDESC="NO LONGER VALID"
 .S DA(ICDLINE)=$P(ICDDRG,U)
 .S DA=1
 .S DIE="^ICD("_DA(ICDLINE)_",1,"
 .S DR=".01///^S X=ICDDESC"
 .D ^DIE
 .; check if already done in case patch being re-installed
 .Q:$D(^ICD($P(ICDDRG,U),66,"B",3181001))
 .; add entry to 80.266
 .S ICDMDC=$P(ICDDRG,U,2)
 .S ICDSURG=$P(ICDDRG,U,3)
 .S ICDDRG=$P(ICDDRG,U)
 .S ICDFDA(80.2,"?1,",.01)=ICDDRG
 .S ICDFDA(80.266,"+2,?1,",.01)=3181001
 .S ICDFDA(80.266,"+2,?1,",.03)=0
 .S ICDFDA(80.266,"+2,?1,",.05)=ICDMDC
 .S ICDFDA(80.266,"+2,?1,",.06)=ICDSURG
 .D UPDATE^DIE("","ICDFDA") K ICDFDA
 .; add entry to 80.268 and 80.2681 
 .S ICDFDA(80.2,"?1,",.01)=ICDDRG
 .S ICDFDA(80.268,"+2,?1,",.01)=3181001
 .D UPDATE^DIE("","ICDFDA") K ICDFDA
 .S ICDFDA(80.2,"?1,",.01)=ICDDRG
 .S ICDFDA(80.2681,"?2,?1,",.01)=3181001
 .S ICDFDA(80.2681,"+3,?2,?1,",.01)=ICDDESC
 .D UPDATE^DIE("","ICDFDA") K ICDFDA
 ;
 ;
INAC ;DRG^MDC^SURG (1=surg, 0=med)
 ;;685^11^0
 ;;765^14^1
 ;;766^14^1
 ;;767^14^1
 ;;774^14^0
 ;;775^14^0
 ;;777^14^0
 ;;778^14^0
 ;;780^14^0
 ;;781^14^0
 ;;782^14^0
 ;;EXIT
