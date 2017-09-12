DVBA26PI ;ALB/JAM  EXAM FILE UPDATE - POST INT ; 19 FEB 1999
 ;;2.7;AMIE;**26**;Apr 10, 1995
 ;
 ; This is the post-install for patch 26 to inactivate the old worksheets
 ; for 'liver, gall bladder and pancreas', 'general medical examination',
 ; 'ear disease' and audio.  New worksheets are added for them into AMIE
 ; AMIE EXAM file (396.6).
 ;
EN ;
 D BMES^XPDUTL("DVBA*2.7*26 Post Installation --")
 D MES^XPDUTL("   Update to AMIE EXAM file (#396.6).")
 D MES^XPDUTL("  ")
 I '$D(^DVB(396.6)) D BMES^XPDUTL("Missing file 396.6, AMIE EXAM file")
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
 ..D MES^XPDUTL("  You already have an Entry #"_IEN_".")
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
 ; Exam to be inactivated (liver, gall bladder and pancreas)
 ; format:  ien;exam name;;;routine;status;;wks#
TXTOLD ;
 ;;101;LIVER, GALL BLADDER, AND PANCREAS; ; ;DVBCWLW;I; ;0305
 ;;118;GENERAL MEDICAL EXAMINATION; ; ;DVBCWGM;I; ;0505
 ;;153;AUDIO; ; ;DVBCWIO;I; ;1305
 ;;104;EAR DISEASE; ; ;DVBCWED;I; ;1310
 ;;QUIT
 ;
 ;
 ; New exam to activate for liver, gall bladder and pancreas.
 ; format:  ien;exam name;print name;body system;routine;status;;wks#
TXTNEW ;
 ;;160;LIVER, GALL BLADDER, AND PANCREAS;LIVER/GALL B/PANCREAS;DIGESTIVE;DVBCWLV;A; ;0305
 ;;161;GENERAL MEDICAL EXAMINATION;GENERAL MEDICAL;GENERAL MEDICAL;DVBCWGX;A; ;0505
 ;;162;AUDIO;AUDIO;ORGANS OF SENSE;DVBCWAU;A; ;1305
 ;;163;EAR DISEASE;EAR DISEASE;ORGANS OF SENSE;DVBCWER;A; ;1310
 ;;QUIT
