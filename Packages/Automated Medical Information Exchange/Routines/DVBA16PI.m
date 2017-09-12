DVBA16PI ;ALB/JFP  EXAM FILE UPDATE - POST INT ; 17 FEB 1998
 ;;2.7;AMIE;**16**;Apr 10, 1995
 ;
 ; This is the post-install for patch 16 to inactivate old Exams and
 ; add new Exams into AMIE EXAM file (396.6).
 ;
EN ;
 D BMES^XPDUTL("DVBA*2.7*16 Post Installation --")
 D MES^XPDUTL("   Update to AMIE EXAM file (#396.6).")
 D MES^XPDUTL("  ")
 I '$D(^DVB(396.6)) D BMES^XPDUTL("Missing file 396.6, AMIE EXAM file")
 I $D(^DVB(396.6)) D
 .D INACT
 .D NEW
 Q
 ;
INACT ;inactivate exams
 N LINE,IEN,EXM,PNM,BDY,ROU,STAT,WKS,DIE,DR,DA,X,Y
 D BMES^XPDUTL("Inactivating AMIE EXAM file entries...")
 F I=1:1 S LINE=$P($T(TXTOLD+I),";;",2) Q:LINE="QUIT"  D
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
 N LINE,IEN,EXM,PNM,BDY,ROU,STAT,WKS,DIC,DIE,DR,DA,X,Y
 D BMES^XPDUTL("Adding new AMIE EXAM file entries...")
 F I=1:1 S LINE=$P($T(TXTNEW+I),";;",2) Q:LINE="QUIT"  D
 .D GET K X,Y,DA
 .D BMES^XPDUTL("  Attempting to add Entry #"_IEN_"...")
 .I $D(^DVB(396.6,IEN,0)) D  Q
 ..D MES^XPDUTL("  You already have an Entry #"_IEN_".")
 ..D MES^XPDUTL("  Updating "_EXM_".")
 ..S DIE="^DVB(396.6,",DA=IEN,DR=".01///"_EXM_";.07///"_WKS_";.5///"_STAT_";2///"_BDY_";6///"_PNM_";7///"_ROU
 ..D ^DIE
 .S DIC="^DVB(396.6,",DIC(0)="LZ",X=EXM,DINUM=IEN
 .S DIC("DR")=".07///"_WKS_";.5///"_STAT_";2///"_BDY_";6///"_PNM_";7///"_ROU
 .D FILE^DICN
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
 ; List of exams to be inactivated
 ; format:  ien;exam name;;;routine;status;;wks#
TXTOLD ;
 ;;103;AUDIO;;;DVBCWHW;I;;1305
 ;;111;ARTERIES AND VEINS;;;DVBCWAV;I;;0105
 ;;112;HEART AND HYPERTENSION;;;DVBCWHH;I;;0110
 ;;125;ARRHYTHMIAS;;;DVBCWAW;I;;0115
 ;;128;MENTAL DISORDERS (EXCEPT PTSD AND EATING DISORDERS);;;DVBCWMD;I;;0905
 ;;QUIT
 ;
 ;
 ; List of new exams to activate
 ; format:  ien;exam name;print name;body system;routine;status;;wks#
TXTNEW ;
 ;;153;AUDIO;AUDIO;ORGANS OF SENSE;DVBCWIO;A; ;1305
 ;;154;ARTERIES, VEINS AND MISCELLANEOUS;ARTERIES/VEINS;CARDIOVASCULAR;DVBCWVN;A; ;0105
 ;;155;HEART;HEART;CARDIOVASCULAR;DVBCWHE;A; ;0110
 ;;156;HYPERTENSION;HYPERTENSION;CARDIOVASCULAR;DVBCWHY;A; ;0120
 ;;157;ARRHYTHMIAS;ARRHYTHMIAS;CARDIOVASCULAR;DVBCWAM;A; ;0115
 ;;158;MENTAL DISORDERS (NOT INITIAL PTSD OR EATING DISORDERS);MENTAL DISORDERS;MENTAL;DVBCWMO;A; ;0905
 ;;159;GULF WAR GUIDELINES;GULF WAR GUIDELINES;SPECIAL;DVBCWGW;A; ;1740
 ;;QUIT
