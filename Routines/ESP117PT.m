ESP117PT ;ALB/CJM - ESP *1*17 POST-INSTALL ROUTINE [9/30/96 12:08pm]
 ;;1.0;POLICE & SECURITY;**17**;Mar 31, 1994
 ;
START ;
 D SSNRPT ;report on duplicate SSN's
 D SNDXCHG ;fix soundex x-ref on file 910
 D IDNTFR ;to update multiple 916.05 headers
 D NEWXREFS ;cross-references files on new x-refs
 Q
 ;
 ;
SSNRPT ;
 ;lists duplicate SSN's allowed by faulty input transform
 ;
 N SSN,NAME,IEN,TEXT,FLAG
 D BMES^XPDUTL("...Searching for duplicate SSNs in file #910")
 S TEXT="IEN      SSN",$E(TEXT,46)="NAME" D MES^XPDUTL(TEXT)
 S TEXT="===      ====",$E(TEXT,46)="===" D MES^XPDUTL(TEXT)
 S (FLAG,SSN)=""
 F  S SSN=$O(^ESP(910,"SSN",SSN)) Q:SSN=""  D
 .S IEN=$O(^ESP(910,"SSN",SSN,0))
 .Q:'IEN
 .I $O(^ESP(910,"SSN",SSN,IEN)) D MES^XPDUTL("") F  Q:'IEN  D  S IEN=$O(^ESP(910,"SSN",SSN,IEN))
 ..S FLAG=1
 ..S NAME=$P($G(^ESP(910,IEN,0)),"^")
 ..S TEXT=IEN,$E(TEXT,10)="",TEXT=TEXT_SSN,$E(TEXT,46)="",TEXT=TEXT_NAME
 ..D MES^XPDUTL(TEXT)
 D:FLAG MES^XPDUTL("")
 D:'FLAG MES^XPDUTL(" **** NO DUPLICATE SSN ENTRIES WERE FOUND **** ")
 D MES^XPDUTL("...Duplicate entry search Completed.")
 Q
 ;
SNDXCHG ;fixes the SOUN x-ref on file 910
 ;
 N DIK,DA
 D BMES^XPDUTL("...Deleting non-Fileman soundex x-ref on file #910")
 K ^ESP(910,"SOUN")
 D MES^XPDUTL("...Creating FileMan soundex x-ref on file #910")
 S DIK="^ESP(910,",DIK(1)=".01^SOUN" D ENALL^DIK
 Q
 ;
IDNTFR ;
 ;add I to all time multiple headers in file 916
 N JRNL
 S JRNL=0
 D BMES^XPDUTL("...Adding identifiers to subfile #916.05")
 F  S JRNL=$O(^ESP(916,JRNL)) Q:'JRNL  I $D(^ESP(916,JRNL,4,0)) D
 .S $P(^ESP(916,JRNL,4,0),U,2)="916.05I"
 Q
 ;
NEWXREFS ;
 ;cross references files on new x-refs added by patch
 ;
 N DIK,DA
 D BMES^XPDUTL("...Creating FileMan ""I"" x-ref on file #910.2")
 S DIK="^ESP(910.2,",DIK(1)="4.05^I" D ENALL^DIK
 ;
 D BMES^XPDUTL("...Creating FileMan ""J"" x-ref on file #910.2")
 K DIK S DIK="^ESP(910.2,",DIK(1)="5.01^J" D ENALL^DIK
 ;
 D BMES^XPDUTL("...Creating FileMan ""J"" x-ref on file #912.09")
 K DA
 S DA(1)=0
 F  S DA(1)=$O(^ESP(912,DA(1))) Q:'DA(1)  D
 .Q:'$D(^ESP(912,DA(1),80))
 .S DA="",DIK="^ESP(912,"_DA(1)_",80,",DIK(1)=".11^J" D ENALL^DIK
 ;
 D BMES^XPDUTL("...Creating FileMan ""D"" x-ref on file #910.85")
 K DA
 S DA(1)=0
 F  S DA(1)=$O(^ESP(910.8,DA(1))) Q:'DA(1)  D
 .Q:'$D(^ESP(910.8,DA(1),5))
 .S DA="",DIK="^ESP(910.8,"_DA(1)_",5,",DIK(1)=".03^D" D ENALL^DIK
 Q
 ;
SSNDUP ;  entry point to run ssn duplicate report.
 N POP
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN="SSNRPT^ESP117PT",ZTDESC="DUP SSN REPORT ON #910"
 . D ^%ZTLOAD
 . D HOME^%ZIS K IO("Q") Q
 U IO
 D SSNRPT
 D ^%ZISC
 Q
