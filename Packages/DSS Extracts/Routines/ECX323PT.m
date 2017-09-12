ECX323PT ;ALB/JAP - PATCH ECX*3*23 Post-Install ; February 26, 1999
 ;;3.0;DSS EXTRACTS;**23**;Dec 22, 1997
 ;
POST ;Entry point
 ;update field #12 in each file #727.1 record with default value
 N DIC,DIE,DA,DR,X,Y,IEN,ECX,ECXX,HEAD,MAX
 D MES^XPDUTL("Updating EXTRACT DEFINITIONS file (#727.1) with default")
 D MES^XPDUTL("value for new MAX. LINES PER MESSAGE field (#12)...")
 D MES^XPDUTL(" ")
 F ECX=1:1 S ECXX=$P($T(TEXT+ECX),";;",2) Q:ECXX="QUIT"  D
 .S IEN=$P(ECXX,U,1),MAX=$P(ECXX,U,2),HEAD=$P(ECXX,U,3)
 .K X,Y S DIC="^ECX(727.1,",DIC(0)="XOM",X=HEAD D ^DIC
 .I Y=-1 D  Q
 ..D MES^XPDUTL("   WARNING: Could not update entry #"_IEN_" for "_HEAD_" extract.")
 ..D MES^XPDUTL("            Please consult with NVS for DSS EXTRACTS support.")
 ..D MES^XPDUTL(" ")
 .S (DA,IEN)=+Y,DIE=DIC,DR="12///^S X=MAX" D ^DIE
 .D MES^XPDUTL("   Setting record #"_IEN_" for the "_HEAD_" extract with a")
 .D MES^XPDUTL("   default value of "_MAX_" in field #12.")
 .D MES^XPDUTL(" ")
 Q
 ;
TEXT ;field #12 defaults for file #727.1 records
 ;;1^100^ADM
 ;;2^150^CLI
 ;;3^200^NOS
 ;;4^200^NUR
 ;;5^200^DEN
 ;;7^200^MOV
 ;;8^200^UDP
 ;;9^200^PRE
 ;;10^200^SUR
 ;;12^200^LAB
 ;;13^200^RAD
 ;;14^200^ECS
 ;;15^200^IVP
 ;;16^200^TRT
 ;;17^200^PAS
 ;;18^200^LAR
 ;;19^200^ECQ
 ;;20^150^PRO
 ;;QUIT
