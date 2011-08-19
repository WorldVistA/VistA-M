XU8P324 ;OOIFO/SO- REINDEX 'ATR' AND RETRANSMIT DATA;6:30 AM  26 Aug 2003
 ;;8.0;KERNEL;**324**;Jul 10, 1995
RENDX ;DELETE AND RE-INDEX THE 'ATR' CROSS REFERENCE
 D MES^XPDUTL("Reindexing ""ATR"" cross reference...")
 N DIK
 S DIK="^VA(200,"
 S DIK(1)="12.2^ATR"
 D ENALL^DIK ;EXECUTE THE SET LOGIC
 D MES^XPDUTL("Done reindexing ""ATR"" cross reference.")
 ;
RETRANS ;RETRANSMIT ALL OF THE OAA TRAINEES
 I $G(XPDQUES("POS1"))="T" D MES^XPDUTL("Non-production account.  No transmission of OAA data will take place.") K ^VA(200,"ATR") Q
 D MES^XPDUTL("Begin transmission of OAA data...")
 D OAA^XUOAAHL7
 D MES^XPDUTL("Done with transmission of OAA data.")
 Q
