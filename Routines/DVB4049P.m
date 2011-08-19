DVB4049P ;ALB/ERC - CHANGE IP ADDR FOR HINQ TO VBA CORPORATE ; 9/1/05 1:46pm
 ;;4.0;HINQ;**49**;03/25/92
 ;
 ;this routine will change the IP address for the HINQ inquiries
 ;to the address for the AAC interface engine, which will communicate
 ;with the new VBA corporate database in addition to the C&P and BIRLS
 ;databases.  There will be only one address for all sites.  This is 
 ;being done for the HINQ replacement, interim solution.
 ;this routine will also add three entries into the Anatomical - Loss 
 ;Code file (#395.2) in the POST subroutine
 ;
 D ADDR
 D POST
 Q
 ;
ADDR ;
 N DVBADD,DVBFDA,DVBMSG,DVBNEW,DVBOLDAD,DVBSTA,X,X1,X2
 K ^XTMP("DVBBACK")
 S DVBSTA=$O(^DVB(395,0))
 I '$D(DVBSTA)!($G(DVBSTA)']"") S DVBMSG="HINQ Parameter file (#395) not set properly." G MSG
 I '$D(^DVB(395,DVBSTA,0)) S DVBMSG="HINQ Parameter file (#395) not set properly." G MSG
 ;new AAC server address DVB*4*49
 S X1=DT,X2=30 D C^%DTC
 S ^XTMP("DVBBACK",0)=X_"^"_$$NOW^XLFDT_"^DVB*4*49 - HINQ REPLACEMENT PATCH"
 S DVBOLDAD=$$GET1^DIQ(395,1,22)
 I $G(DVBOLDAD)']"" S DVBOLDAD="Not populated."
 S ^XTMP("DVBBACK","OLDIP")=DVBOLDAD
 S DVBADD="10.224.132.143"
 S DVBFDA(395,"1,",22)=DVBADD
 D FILE^DIE("E","DVBFDA")
 S DVBNEW=$G(^DVB(395,DVBSTA,"HQIP"))
 I $G(DVBNEW)'=DVBADD S DVBMSG="Address change not successful - update manually." G MSG
 S DVBMSG="IP address successfully updated to "_DVBADD_"." D MSG
 S DVBMSG="Previous IP address was "_DVBOLDAD_"." D MSG
 Q
MSG ;add message to the KIDS build
 D BMES^XPDUTL(.DVBMSG)
 Q
 ;
 ;need to add three entries into file 395.2 (Anat-Loss Code file)
 ;this is patterned after DVB448PT
POST ;entry point for post-install, setting up checkpoints
 N %
 S %=$$NEWCP^XPDUTL("DVBLINE","EN^DVB4049P",1)
 Q
 ;
EN ;begin processing
 ;
 N DVBLINE
 ;
 D BMES^XPDUTL("  >> *** Updating ANATOMICAL-LOSS CODE file (#395.2)")
 D MES^XPDUTL("  ")
 ;
 ;get value from checkpoints, previous run
 S DVBLINE=+$$PARCP^XPDUTL("DVBLINE")
 ;
DVBNEW ;add new codes or modify name if code is in use
 ;
 F DVBI=DVBLINE:1 S DVBJ=$P($T(NEWCODE+DVBI),";;",2) Q:DVBJ["$EXIT"  D
 .S DVBCODE=+DVBJ,DVBLINE=DVBI
 .S DVBDESC=$E($P(DVBJ,"^",2),1,30)
 .;
 .;add new code
 .I '$D(^DVB(395.2,"B",DVBCODE)) D  G UPDATECH
 ..K DD,DO
 ..S DIC="^DVB(395.2,",DIC(0)="L",DIC("DR")="1////"_DVBDESC
 ..S X=$P(DVBJ,U),DLAYGO=31
 ..D FILE^DICN
 ..D MES^XPDUTL("adding new code - "_X)
 ..K DLAYGO,DIC,X
 ..Q
 .;
 .;modify name
 .S DVBIEN=+$O(^DVB(395.2,"B",DVBCODE,0))
 .S DVBREC=$G(^DVB(395.2,DVBIEN,0)),DVBOLDSC=$P(DVBREC,U,2) I DVBREC']"" D  G UPDATECH
 ..D MES^XPDUTL("  >>>> error "_DVBCODE_" in B x-reference and not in file 395.2")
 ..Q
 .S DVBOLDC=$P(DVBREC,"^") I DVBOLDC=DVBCODE,(DVBOLDSC=DVBDESC) G UPDATECH
 .I DVBOLDC'=DVBCODE D
 ..S DA=DVBIEN,DIE="^DVB(395.2,",DR=".01////"_DVBCODE_";1////"_DVBDESC
 ..D ^DIE
 ..K DR,DA,DIE
 .I DVBOLDSC'=DVBDESC D
 ..S DA=DVBIEN,DIE="^DVB(395.2,",DR="1////"_DVBDESC
 ..D ^DIE
 ..K DA,DIE,DR
 ..D MES^XPDUTL(DVBCODE_": changing description...")
 ..D MES^XPDUTL("          from:  "_DVBOLDSC)
 ..D MES^XPDUTL("            to:  "_DVBDESC)
 .;
UPDATECH .;update checkpoint
 .S %=$$UPCP^XPDUTL("DVBLINE",DVBLINE)
 .Q
 K DVBCODE,DVBI,DVBIEN,DVBJ,DVBNAME,DVBOLDC,DVBOLDN,DVBREC,DVBDESC,DVBOLDSC
 Q
 ;
NEWCODE ;codes to be added or changed
 ;;16^Deafness, Total
 ;;17^Aphonia
 ;;29^Deafnessand Aphonia
 ;;$EXIT
 Q
