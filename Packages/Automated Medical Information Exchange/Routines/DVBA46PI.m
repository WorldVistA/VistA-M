DVBA46PI ;BPOIFO/ESW - Post Init Exam file Update ; 10/8/02 10:51am
 ;;2.7;AMIE;**46**;Apr 10,1995
 ;
 ; This is the post-install for DVBA*2.7*46 to inactivate the old
 ; entries and create new entries in the AMIE EXAM file (#396.6).
 ;
EN ;
 D BMES^XPDUTL("DVBA*2.7*46 Post Installation --")
 D MES^XPDUTL("   Update to AMIE EXAM file (#396.6).")
 D MES^XPDUTL("  ")
 I '$D(^DVB(396.6)) D BMES^XPDUTL("Missing AMIE EXAM (#396.6) file") Q
 I $D(^DVB(396.6)) D
 .D INACT
 .D NEW
 Q
 ;
INACT ;inactivate exams
 N LINE,IEN,EXM,PNM,BDY,ROU,STAT,WKS,DIE,DR,DA,X,Y,DVBAI
 D BMES^XPDUTL("Inactivating AMIE EXAM file entries..")
 F DVBAI=1:1 S LINE=$P($T(TXTOLD+DVBAI),";;",2) Q:LINE="QUIT"  D
 .D GET K X,Y,DA
 .I $P($G(^DVB(396.6,IEN,0)),"^",1)'=EXM D  Q
 ..D BMES^XPDUTL("  *** Warning - Entry #"_IEN)
 ..D MES^XPDUTL("                for exam "_EXM)
 ..D MES^XPDUTL("                could not be inactivated.")
 .S DIE="^DVB(396.6,",DA=IEN,DR=".5///I" D ^DIE
 .D BMES^XPDUTL("  Entry #"_IEN_" for exam "_EXM)
 .D MES^XPDUTL("     successfully inactivated.")
 D MES^XPDUTL("  ")
 Q
 ;
NEW ;add new exam
 N LINE,IEN,EXM,PNM,BDY,ROU,STAT,WKS,DIC,DIE,DR,DA,X,Y,DINUM,DVBAI
 D BMES^XPDUTL("Adding new AMIE EXAM file entries...")
 F DVBAI=1:1 S LINE=$P($T(TXTNEW+DVBAI),";;",2) Q:LINE="QUIT"  D
 .D GET K X,Y,DA
 .D BMES^XPDUTL("  Attempting to add Entry #"_IEN_"...")
 .I $D(^DVB(396.6,IEN,0)) D  Q
 ..D MES^XPDUTL("  You have an Entry #"_IEN_".")
 ..D MES^XPDUTL("  Updating "_EXM_".")
 ..S DIE="^DVB(396.6,",DA=IEN,DR=".01///"_EXM_";.07///"_WKS_";.5///"_STAT_";2///"_BDY_";6///"_PNM_";7///"_ROU
 ..D ^DIE
 .S DIC="^DVB(396.6,",DIC(0)="LZ",X=EXM,DINUM=IEN
 .S DIC("DR")=".07///"_WKS_";.5///"_STAT_";2///"_BDY_";6///"_PNM_";7///"_ROU
 .K DD,DO D FILE^DICN
 .I +Y=IEN D  Q
 ..D MES^XPDUTL("  Successfully added Entry #"_IEN)
 ..D MES^XPDUTL("  for exam "_EXM_".")
 .I +Y=-1 D
 ..D MES^XPDUTL("  *** Warning - Unable to add Entry #"_IEN)
 ..D MES^XPDUTL("                for exam "_EXM_".")
 Q
GET ;get exam data
 S (IEN,EXM,PNM,BDY,ROU,STAT,WKS)=""
 S IEN=$P(LINE,";",1) ;ien
 S EXM=$P(LINE,";",2) ;exam name
 S PNM=$P(LINE,";",3) ;print name
 S BDY=$P(LINE,";",4) ;body system
 S ROU=$P(LINE,";",5) ;routine name
 S STAT=$P(LINE,";",6) ;status
 S WKS=$P(LINE,";",8) ;worksheet number
 Q
 ;
 ; Entries to be inactivated.
 ; format:  ien;exam name;;;routine;status;;wks#
TXTOLD ;
 ;;132;SPINE (CERVICAL, THORACIC & LUMBAR); ; ;DVBCWNS;I; ;1440
 ;;149;EATING DISORDERS (MENTAL DISORDERS); ; ;DVBCWEA;I; ;0915
 ;;171;REVIEW EXAMINATION FOR POST-TRAUMATIC STRESS DISORDER; ; ;DVBCWPE3;I; ;0920
 ;;172;INITIAL EVALUATION FOR POST-TRAUMATIC STRESS DISORDER (PTSD); ; ;DVBCWPD3;I; ;0910
 ;;173;MENTAL DISORDERS (EXCEPT PTSD AND EATING DISORDERS); ; ;DVBCWME2;I; ;0905
 ;;QUIT
 ;
 ;
 ; New exam to activate 
 ; format:  ien;exam name;print name;body system;routine;status;;wks#
TXTNEW ;
 ;;174;SPINE (CERVICAL, THORACIC & LUMBAR);SPINE;MUSCULOSKELETAL;DVBCWNS2;A; ;1440
 ;;175;EATING DISORDERS (MENTAL DISORDERS);EATING DISORDERS;MENTAL;DVBCWEA2;A; ;0915
 ;;176;REVIEW EXAMINATION FOR POST-TRAUMATIC STRESS DISORDER (PTSD);REV EXAM FOR PTSD;MENTAL;DVBCWPE6;A; ;0920
 ;;177;INITIAL EVALUATION FOR POST-TRAUMATIC STRESS DISORDER (PTSD);STRESS DISORDER;MENTAL;DVBCWPD6;A; ;0910
 ;;178;MENTAL DISORDERS (EXCEPT PTSD AND EATING DISORDERS);MENTAL DISORDER;MENTAL;DVBCWME4;A; ;0905
 ;;QUIT
