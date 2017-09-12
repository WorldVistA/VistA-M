DVB444PT ;ALB/ZJF POST-INSTALL FOR PATCH DVB*4*44
 ;;4.0;HINQ;**44**;03/25/92
 ;
 ;This routine will be run as a post-installation for patch DVB*4*44.
 ;This routine will add eight new disability codes to the DISABILITY
 ;CONDITION file (#31).
 ;
POST ;entry point for post-install, setting up checkpoints
 N %
 S %=$$NEWCP^XPDUTL("DVBLINE","EN^DVB444PT",1)
 Q
 ;
EN ;begin processing
 ;
 N DVBLINE
 ;
 D BMES^XPDUTL("  >> *** Updating DISABILITY CONDITION file (#31)")
 D MES^XPDUTL("  ")
 ;
 ;get value from checkpoints, previous run
 S DVBLINE=+$$PARCP^XPDUTL("DVBLINE")
 ;
DVBNEW ;add new codes or modify name if code is in use
 ;
 F DVBI=DVBLINE:1 S DVBJ=$P($T(NEWCODE+DVBI),";;",2) Q:DVBJ["$EXIT"  D
 .S DVBCODE=+DVBJ,DVBNAME=$E($P(DVBJ,"^",2),1,45),DVBLINE=DVBI
 .S DVBDESC=$E($P(DVBJ,"^",3),1,200)
 .;
 .;add new code
 .I '$D(^DIC(31,"C",DVBCODE)) D  G UPDATECH
 ..K DD,DO
 ..S DIC="^DIC(31,",DIC(0)="L",DIC("DR")="2////"_DVBCODE_";10////"_DVBDESC
 ..S X=DVBNAME,DLAYGO=31
 ..D FILE^DICN
 ..D MES^XPDUTL(DVBCODE_":  adding  "_DVBCODE_"  "_X)
 ..K DLAYGO,DIC,X
 ..Q
 .;
 .;modify name
 .S DVBIEN=+$O(^DIC(31,"C",DVBCODE,0))
 .S DVBREC=$G(^DIC(31,DVBIEN,0)),DVBOLDSC=$G(^DIC(31,DVBIEN,1)) I DVBREC']"" D  G UPDATECH
 ..D MES^XPDUTL("  >>>> error "_DVBCODE_" in C x-reference and not in file 31")
 ..Q
 .S DVBOLDN=$P(DVBREC,"^") I DVBOLDN=DVBNAME&(DVBOLDSC=DVBDESC) G UPDATECH
 .S DA=DVBIEN,DIE="^DIC(31,",DR=".01////"_DVBNAME_";10////"_DVBDESC
 .D ^DIE
 .K DR,DA,DIE
 .I DVBOLDN'=DVBNAME D
 ..D MES^XPDUTL(DVBCODE_": changing name from "_DVBOLDN)
 ..D MES^XPDUTL("                    to   "_DVBNAME)
 .I DVBOLDSC'=DVBDESC D
 ..D MES^XPDUTL(DVBCODE_": changing description...")
 ..D MES^XPDUTL("          from:  "_DVBOLDSC)
 ..D MES^XPDUTL("            to:  "_DVBDESC)
 .;
UPDATECH .;update checkpoint
 .S %=$$UPCP^XPDUTL("DVBLINE",DVBLINE)
 .Q
 K DVBCODE,DVBI,DVBIEN,DVBJ,DVBNAME,DVBOLDN,DVBREC,DVBDESC,DVBOLDSC
 Q
 ;
NEWCODE ;codes to be added or changed
 ;;7812^NODULES,TUMORS OF THE SKIN^NODULES,TUMORS OF THE SKIN
 ;;5228^LIMITATION OF MOTION, THUMB^LIMITATION OF MOTION, THUMB
 ;;5229^LIMITATION OF MOTION, INDEX OR LONG FINGER^LIMITATION OF MOTION, INDEX OR LONG FINGER
 ;;7828^ACNE^ACNE
 ;;7825^URTICARIA^URTICARIA
 ;;9435^MOOD DISORDER^MOOD DISORDER
 ;;7821^SKIN CONDITION^SKIN CONDITION
 ;;6354^CHRONIC FATIGUE SYNDROME^CHRONIC FATIGUE SYNDROME
 ;;$EXIT
 Q
