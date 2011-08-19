XU8P360 ;OIFOO/SO- RE-INDEX "AUSER" XREF;10:46 AM  13 May 2005
 ;;8.0;KERNEL;*360*;Jul 10, 1995
 D MES^XPDUTL("Begin re-indexing ""AUSER"" cross reference...")
 K ^VA(200,"AUSER")
 N DIK,DA
 S DIK="^VA(200,"
 S DIK(1)=".01^AUSER"
 D ENALL^DIK
 D MES^XPDUTL("Finished re-indexing ""AUSER"" cross reference.")
 Q
