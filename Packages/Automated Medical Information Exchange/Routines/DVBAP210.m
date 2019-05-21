DVBAP210 ;ALB/JR - AMIE EXAM (#396.6) FILE UPDATE ;12/6/2018 1:47PM
 ;;2.7;AMIE;**210**;Apr 10, 1995;Build 2
 ;
 ;this routine is used as a post-init in a KIDS build
 ;to modify the AMIE EXAM file (#396.6)
 ;
 Q
 ;
POST ; entry point
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Updating the AMIE EXAM file (#396.6)...")
 D MES^XPDUTL(" ")
 ;
 D NAMECHG ;change exam names
 D INACT   ;inactivate exams
 ;
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Update of AMIE EXAM file (#396.6) completed.")
 D MES^XPDUTL(" ")
 Q
NAMECHG ;* change exam names
 ;
 ;  DVBAXX is in format:
 ;   OLD EXAM NAME^NEW EXAM NAME
 ;
 N DVBAX,DVBAXX,DVBADA,DA,DR,DIC,DIE,X,Y,DVBASTR
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Changing names in AMIE EXAM file (#396.6)...")
 D MES^XPDUTL(" ")
 F DVBAX=1:1 S DVBAXX=$P($T(CHNG+DVBAX),";;",2) Q:DVBAXX="QUIT"  D
 .F DVBADA=0:0 S DVBADA=+$O(^DVB(396.6,"B",$E($P(DVBAXX,U,1),1,30),DVBADA)) Q:DVBADA=0  D
 ..I $D(^DVB(396.6,DVBADA,0)),$P(^DVB(396.6,DVBADA,0),U,5)="A" D
 ...S DA=DVBADA,DR=".01///^S X=$P(DVBAXX,U,2)",DIE="^DVB(396.6," D ^DIE
 ...D MES^XPDUTL(" ")
 ...D MES^XPDUTL("   Entry #"_DVBADA_" for "_$P(DVBAXX,U,1))
 ...D BMES^XPDUTL("      ... field (#.01) updated to  "_$P(DVBAXX,U,2)_".")
 ...D MES^XPDUTL(" ")
 ..I '$D(^DVB(396.6,DVBADA,0)) D
 ...D MES^XPDUTL(" ")
 ...S DVBASTR="Can't find entry for "_$P(DVBAXX,U,1)
 ...D BMES^XPDUTL(DVBASTR_" ...field (#.01) not updated.")
 Q
 ;
CHNG ;name changes - old exam name^new exam name
 ;;DBQ Medical Opinion^DBQ MEDICAL OPINION
 ;;DBQ General Medical Compensation^DBQ GENERAL MEDICAL Compensation
 ;;DBQ General Medical Gulf War (including Burn Pits)^DBQ GENERAL MEDICAL Gulf War (including burn pits)
 ;;DBQ General Medical Pension^DBQ GENERAL MEDICAL Pension
 ;;DBQ HEM Hemic & lymphatic, including leukemia^DBQ HEM Hemic & lymphatic conditions, including leukemia
 ;;DBQ Prisoner of War (POW)^DBQ PRISONER OF WAR (POW)
 ;;DBQ GI Liver Hepatitis, cirrhosis & other liver conditions^DBQ GI Liver hepatitis, cirrhosis & other liver conditions
 ;;Bones (Fractures and Bone Diseases)^Bones (fractures and bone diseases)
 ;;Aid and Attendance or Housebound Examination^Aid and attendance or housebound examination
 ;;DBQ INFECT South West Asia Infectious diseases^DBQ INFECT Southwest Asia infectious diseases
 ;;DBQ MUSC Foot conditions, including Flatfoot (Pes Planus)^DBQ MUSC Foot conditions, including flatfoot (pes planus)
 ;;DBQ NEURO Seizure disorders (Epilepsy)^DBQ NEURO Seizure disorders (epilepsy)
 ;;DBQ NEURO TBI Initial^DBQ NEURO Traumatic brain injury (TBI) initial
 ;;DBQ NEURO TBI Review^DBQ NEURO Traumatic brain injury (TBI) review
 ;;DBQ PSYCH PTSD Initial^DBQ PSYCH Posttraumatic stress disorder (PTSD) initial
 ;;DBQ PSYCH PTSD Review^DBQ PSYCH Posttraumatic stress disorder (PTSD) review
 ;;DBQ Separation Health Assessment^DBQ Separation health assessment (SHA)
 ;;QUIT
 ;
INACT ;* inactivate exams
 ;
 ;  DVBAXX is in format:
 ;   EXAM NAME
 ;
 N DVBAX,DVBAXX,DVBADA,DA,DR,DIC,DIE,X,Y,DVBASTR
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Inactivating procedures AMIE EXAM file (#396.6)...")
 D MES^XPDUTL(" ")
 F DVBAX=1:1 S DVBAXX=$P($T(OLD+DVBAX),";;",2) Q:DVBAXX="QUIT"  D
 .F DVBADA=0:0 S DVBADA=+$O(^DVB(396.6,"B",$E(DVBAXX,1,30),DVBADA)) Q:DVBADA=0  D
 ..I $D(^DVB(396.6,DVBADA,0)),$P(^DVB(396.6,DVBADA,0),U,5)="A" D
 ...S DA=DVBADA,DR=".5///INACTIVE",DIE="^DVB(396.6," D ^DIE
 ...D MES^XPDUTL(" ")
 ...D MES^XPDUTL("   Entry #"_DVBADA_" for "_DVBAXX)
 ...D BMES^XPDUTL("      ... inactivated")
 ...D MES^XPDUTL(" ")
 ..I '$D(^DVB(396.6,DVBADA,0)) D
 ...D MES^XPDUTL(" ")
 ...S DVBASTR="Can't find entry for "_DVBAXX
 ...D BMES^XPDUTL(DVBASTR_" ...exam cannot be inactivated.")
 Q
 ;
OLD ;national procedures to be inactivated - exam name
 ;;DBQ HEM Hairy Cell & other B-cell leukemias
 ;;QUIT
 ;
