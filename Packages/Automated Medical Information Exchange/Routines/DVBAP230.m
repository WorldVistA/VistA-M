DVBAP230 ;ALB/MF - AMIE EXAM (#396.6) FILE UPDATE ; Feb 18, 2021@09:39:25
 ;;2.7;AMIE;**230**;Apr 10, 1995;Build 2
 ;
 ;this routine is used as a post-init in a KIDS build
 ;to modify the AMIE EXAM file (#396.6)
 ;
 Q
 ;
POST ; entry point
 D BMES^XPDUTL("Updating the AMIE EXAM file (#396.6)...")
 ;
 D NAMECHG ;change exam names
 ;
 D BMES^XPDUTL("Update of AMIE EXAM file (#396.6) completed.")
 D MES^XPDUTL(" ")
 Q
NAMECHG ;* change exam names
 ;
 ;  DVBAXX is in format:
 ;   OLD EXAM NAME^NEW EXAM NAME
 ;
 N DVBAX,DVBAXX,DVBADA,DA,DR,DIC,DIE,X,Y,DVBASTR
 D BMES^XPDUTL("Changing names in AMIE EXAM file (#396.6)...")
 D MES^XPDUTL(" ")
 F DVBAX=1:1 S DVBAXX=$P($T(CHNG+DVBAX),";;",2) Q:DVBAXX="QUIT"  D
 .F DVBADA=0:0 S DVBADA=+$O(^DVB(396.6,"B",$E($P(DVBAXX,U,1),1,30),DVBADA)) Q:DVBADA=0  D
 ..I $D(^DVB(396.6,DVBADA,0)),$P(^DVB(396.6,DVBADA,0),U,5)="A" D
 ...S DA=DVBADA,DR=".01///^S X=$P(DVBAXX,U,2)",DIE="^DVB(396.6," D ^DIE
 ...D MES^XPDUTL(" ")
 ...D MES^XPDUTL("   Entry #"_DVBADA_" for "_$P(DVBAXX,U,1))
 ...D BMES^XPDUTL("      ... field (#.01) updated to  "_$P(DVBAXX,U,2)_".")
 ..I '$D(^DVB(396.6,DVBADA,0)) D
 ...S DVBASTR="Can't find entry for "_$P(DVBAXX,U,1)
 ...D BMES^XPDUTL(DVBASTR_" ...field (#.01) not updated.")
 Q
 ;
CHNG ;name changes - old exam name^new exam name
 ;;Bones (fractures and bone diseases)^DBQ MUSC Bones and other skeletal conditions
 ;;QUIT
 ;
