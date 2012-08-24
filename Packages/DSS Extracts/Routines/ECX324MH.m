ECX324MH ;ALB/JAP - PATCH ECX*3*24 Post-Install for MTL ; June 3, 1999
 ;;3.0;DSS EXTRACTS;**24**;Dec 22, 1997
 ;
EN ;Entry point
 ;update file #727.5 with new record data
 N DIC,DIE,DA,DR,DLAYGO,X,Y,DATA,DATE,IEN,HEAD,MAX,NAME,ECX,ECXX
 D MES^XPDUTL("Updating DSS MH TESTS file (#727.5) with data based on")
 D MES^XPDUTL("your site's MH INSTRUMENT file (#601)...")
 D MES^XPDUTL(" ")
 F ECX=1:1 S ECXX=$P($T(TEXT+ECX),";;",2) Q:ECXX="QUIT"  D
 .S IEN=$P(ECXX,";",1),DATA=$P(ECXX,";",2),NAME=$P(DATA,U,1),DATE=$P(DATA,U,2)
 .S DIC="^YTT(601,",DIC(0)="XO",X=NAME D ^DIC
 .Q:Y=-1
 .K X,Y,DD,DO S DIC="^ECX(727.5,",DIC(0)="L",DLAYGO=727.5,X=NAME,DINUM=IEN
 .D FILE^DICN
 .I Y=-1 D  Q
 ..I $D(^ECX(727.5,IEN)),$P(^ECX(727.5,IEN,0),U)=NAME D  Q
 ...D MES^XPDUTL("   Entry #"_IEN_" for "_NAME_" already exists in File #727.5.")
 ...D MES^XPDUTL(" ")
 ..D MES^XPDUTL("   WARNING: Could not update entry #"_IEN_" for "_NAME_" in File #727.5.")
 ..D MES^XPDUTL("            Please consult with NVS for DSS EXTRACTS support.")
 ..D MES^XPDUTL(" ")
 .D MES^XPDUTL("   Setting record #"_IEN_" for the "_NAME_" in File #727.5 ...")
 .K X,Y,DD,DO,DINUM
 .S DIC="^ECX(727.5,"_IEN_",1,",DIC(0)="L",DLAYGO=727.51,DIC("P")=$P(^DD(727.5,1,0),U,2),DA(1)=IEN,DA=1,X=DATE
 .D FILE^DICN
 .D MES^XPDUTL(" ok.")
 .D MES^XPDUTL(" ")
 Q
 ;
TEXT ;data for file #727.5 records
 ;;1;CRS^2991001
 ;;2;ZUNG^2991001
 ;;3;BDI^2991001
 ;;4;CAGE^2991001
 ;;5;DOM80^2991001
 ;;6;DOM81^2991001
 ;;7;DOM82^2991001
 ;;8;DOMG^2991001
 ;;QUIT
