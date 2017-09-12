DVBA146P ;ALB/RRA - Post Init Exam file Update ; 14 Jun 2005
 ;;2.7;AMIE;**146**;AUG 7,2003;Build 6
 ;
 ; This is the post-install for DVBA*2.7*146 to add relevant.
 ; mailgroups to the new bulletins added by this patch
 ;
 Q
 ;Must be run from EN^DVBA146P
EN ;
 N DVBMG,DVBIEN,DVBBLT,DA,DIE,DR,DVBI,DVBFLG,DVBX,DVBMGRP,DIC,X,Y
 D BMES^XPDUTL("DVBA*2.7*146 Post Installation --")
 D MES^XPDUTL("   Populating mail groups for newly added Bulletins.")
 D MES^XPDUTL("  ")
 F DVBI="DVBA C 2507 CANCELLATION","DVBA C NEW C&P VETERAN"  N DVBMG D FIND(DVBI,.DVBMG) D UPDATE
 D BMES^XPDUTL("DVBA*2.7*146 Post Installation complete!")
 Q
FIND(DVBI,DVBMG) ;FIND IEN'S OF MAIL GROUPS
 S DVBMG=$O(^XMB(3.8,"B",DVBI,0))
 D:'DVBMG MES^XPDUTL("The "_DVBI_" MAIL group does not exist")
 Q
 ;
UPDATE ;UPDATE THE BULLETIN FILE (#3.6) ENTRIES WITH MAIL GROUPS
 Q:'DVBMG
 I DVBI="DVBA C 2507 CANCELLATION" S DVBBLT="DVBA CAPRI 2507 CANCELLATION"
 I DVBI="DVBA C NEW C&P VETERAN" S DVBBLT="DVBA CAPRI NEW C&P VETERAN"
 S DVBIEN=$O(^XMB(3.6,"B",DVBBLT,0))
 Q:'DVBIEN
 N DVBFLG D CHECK(DVBIEN,.DVBFLG)
 ;if it found a match quit because the bulletin already has the 
 ;correct mail group
 Q:DVBFLG=1
 ;no match found, now update the bulletin with the correct mailgroup
 S DA(1)=DVBIEN,DIC="^XMB(3.6,"_DA(1)_",2,",X=DVBMG,DIC("P")=3.62,DIC(0)="X" D FILE^DICN
 D:Y>0 BMES^XPDUTL("The "_DVBBLT_" bulletin has been updated.")
 Q
 ;
CHECK(DVBIEN,DVBFLG) ;check to see if the mailgroup has already been added
 S DVBFLG=0
 I $D(^XMB(3.6,DVBIEN,2))  D
 .S DVBX=0
 .F  S DVBX=$O(^XMB(3.6,DVBIEN,2,DVBX)) Q:DVBX=""  Q:DVBFLG=1  D
 ..S DVBMGRP=$P($G(^XMB(3.6,DVBIEN,2,DVBX,0)),"^")
 ..I DVBMGRP=DVBMG S DVBFLG=1 D BMES^XPDUTL("The "_DVBBLT_" bulletin has already been updated!")
 Q
