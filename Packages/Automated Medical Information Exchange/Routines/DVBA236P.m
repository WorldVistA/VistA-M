DVBA236P ;ALB/FSB - AMIE EXAM (#396.6) FILE UPDATE ; 8/30/21@09:30
 ;;2.7;AMIE;**236**;Apr 10, 1995;Build 6
 ;
 ;this routine is used as a post-init in a KIDS build
 ;to modify the AMIE EXAM file (#396.6)
 ;
 Q
POST ;
 D BMES^XPDUTL("Updating the AMIE EXAM file (#396.6)...")
 D STATCHG ; status change
 D BMES^XPDUTL("Update of AMIE EXAM file (#396.6) completed.")
 Q
STATCHG ;
 N DVBAX,DVBAXX,DVBADA,DVBARC,DA,DR,DIE,DVBASTR
 F DVBAX=1:1 S DVBAXX=$P($T(CHNG+DVBAX),";;",2) Q:DVBAXX=""  D
 .F DVBADA=0:0 S DVBADA=+$O(^DVB(396.6,"B",$E($P(DVBAXX,U,1),1,30),DVBADA)) Q:DVBADA=0  D
 ..I $D(^DVB(396.6,DVBADA,0)),$P(^DVB(396.6,DVBADA,0),U,5)="A" D
 ...S DIE="^DVB(396.6,",DA=DVBADA,DR=".5///I" D ^DIE
 ...D BMES^XPDUTL("Status for "_$P(DVBAXX,U,1)_" has been updated.")
 ..I '$D(^DVB(396.6,DVBADA,0)) D
 ...S DVBASTR="Can't find the record for "_$P(DVBAXX,U,1)
 ...D BMES^XPDUTL(DVBASTR_"... field (#.5) not updated.")
 Q
CHNG ;
 ;;DBQ GU Prostate cancer
