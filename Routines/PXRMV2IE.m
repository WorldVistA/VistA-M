PXRMV2IE ; SLC/PKR - Version 2.0 init routine. ;02/3/2005
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;Reminder Exchange install.
 Q
 ;
 ;===============================================================
ARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;
 S ARRAY(1,1)="VA-ANTIPSYCHOTIC MED SIDE EFF EVAL"
 I MODE S ARRAY(1,2)="01/27/2005@10:31:11"
 S ARRAY(2,1)="VA-DEPRESSION SCREENING"
 I MODE S ARRAY(2,2)="01/27/2005@10:31:26"
 S ARRAY(3,1)="VA-POS DEPRESSION SCREEN FOLLOWUP"
 I MODE S ARRAY(3,2)="02/03/2005@14:32:26"
 ;
 S ARRAY(4,1)="VA-IHD ELEVATED LDL"
 I MODE S ARRAY(4,2)="08/25/2004@08:48:27"
 S ARRAY(5,1)="VA-IHD LIPID PROFILE"
 I MODE S ARRAY(5,2)="08/25/2004@08:48:55"
 S ARRAY(6,1)="VA-*IHD ELEVATED LDL REPORTING"
 I MODE S ARRAY(6,2)="08/25/2004@08:49:25"
 S ARRAY(7,1)="VA-*IHD LIPID PROFILE REPORTING"
 I MODE S ARRAY(7,2)="08/25/2004@08:49:59"
 S ARRAY(8,1)="VA-*IHD 412 ELEVATED LDL REPORTING"
 I MODE S ARRAY(8,2)="08/25/2004@08:50:25"
 S ARRAY(9,1)="VA-*IHD 412 LIPID PROFILE REPORTING"
 I MODE S ARRAY(9,2)="08/25/2004@08:51:13"
 ;
 S ARRAY(10,1)="VA-IHD QUERI PARAMETER"
 I MODE S ARRAY(10,2)="09/22/2004@09:49:24"
 S ARRAY(11,1)="VA-MH QUERI PARAMETER"
 I MODE S ARRAY(11,2)="09/22/2004@09:56:01"
 ;
 S ARRAY(12,1)="VA-GEC REFERRAL TERM SET (CC)"
 I MODE S ARRAY(12,2)="08/25/2004@08:51:47"
 S ARRAY(13,1)="VA-GEC REFERRAL TERM SET (CR)"
 I MODE S ARRAY(13,2)="08/25/2004@08:52:28"
 S ARRAY(14,1)="VA-GEC REFERRAL TERM SET (NA)"
 I MODE S ARRAY(14,2)="08/25/2004@08:53:27"
 S ARRAY(15,1)="VA-GEC REFERRAL TERM SET (SS)"
 I MODE S ARRAY(15,2)="08/25/2004@08:54"
 ;
 S ARRAY(16,1)="VA-GEC REFERRAL CARE COORDINATION"
 I MODE S ARRAY(16,2)="08/25/2004@08:54:33"
 S ARRAY(17,1)="VA-GEC REFERRAL CARE RECOMMENDATION"
 I MODE S ARRAY(17,2)="08/25/2004@08:55:03"
 S ARRAY(18,1)="VA-GEC REFERRAL NURSING ASSESSMENT"
 I MODE S ARRAY(18,2)="08/25/2004@08:55:30"
 S ARRAY(19,1)="VA-GEC REFERRAL SOCIAL SERVICES"
 I MODE S ARRAY(19,2)="08/25/2004@08:56:08"
 ;
 S ARRAY(20,1)="VA-IRAQ & AFGHAN POST-DEPLOY SCREEN"
 I MODE S ARRAY(20,2)="01/27/2005@10:31:41"
 ;
 S ARRAY(21,1)="BDI II RESULT GROUP"
 I MODE S ARRAY(21,2)="04/13/2004@15:53:47"
 ;
 ;additional reminders with MRD function finding changes
 S ARRAY(22,1)="VA-HTN ASSESSMENT BP >=140/90"
 I MODE S ARRAY(22,2)="09/21/2004@14:46:58"
 S ARRAY(23,1)="VA-HTN ASSESSMENT BP >=160/100"
 I MODE S ARRAY(23,2)="09/21/2004@14:47:18"
 S ARRAY(24,1)="VA-HTN LIFESTYLE EDUCATION"
 I MODE S ARRAY(24,2)="09/21/2004@14:47:35"
 S ARRAY(25,1)="VA-MST SCREENING"
 I MODE S ARRAY(25,2)="01/27/2005@10:31:56"
 ;
 ;Make sure this old one gets deleted.
 S ARRAY(26,1)="VA-IRAQ &AFGHAN POST-DEPLOY SCREEN"
 I MODE S ARRAY(26,2)="12/23/2003@22:52:03"
 ;
 S ARRAY(26,1)="GMTSMHV"
 I MODE S ARRAY(26,2)="07/06/2004@15:06:21"
 Q
 ;
 ;===============================================================
CNAK ;Make sure all "NAK" characters are converted back to "^" in
 ;the Exchange File.
 N IEN,TEXT
 D BMES^XPDUTL("Clean up Exchange File entries")
 S IEN=0
 F  S IEN=+$O(^PXD(811.8,IEN)) Q:IEN=0  D
 . S TEXT=" Working on Exchange File entry "_IEN
 . D BMES^XPDUTL(TEXT)
 . D POSTKIDS^PXRMEXU5(IEN)
 Q
 ;
 ;===============================================================
DELEI ;If the Exchange File entry already exists delete it.
 N ARRAY,IC,IND,LIST,LUVALUE,NUM
 D ARRAY(1,.ARRAY)
 S IC=0
 F  S IC=$O(ARRAY(IC)) Q:'IC  D
 .S LUVALUE(1)=ARRAY(IC,1)
 .D FIND^DIC(811.8,"","","U",.LUVALUE,"","","","","LIST")
 .I '$D(LIST) Q
 .S NUM=$P(LIST("DILIST",0),U,1)
 .I NUM'=0 D
 ..F IND=1:1:NUM D
 ... N DA,DIK
 ... S DIK="^PXD(811.8,"
 ... S DA=LIST("DILIST",2,IND)
 ... D ^DIK
 Q
 ;
 ;===============================================================
DELEXB ;Delete the "B" index entries on the XML data in the Exchange File.
 N IEN
 D BMES^XPDUTL("Cleaning up Exchange File.")
 S IEN=0
 F  S IEN=+$O(^PXD(811.8,IEN)) Q:IEN=0  K ^PXD(811.8,IEN,100,"B")
 Q
 ;
 ;===============================================================
DELGEC ;Delete the GEC Referal Term sets from the Reminder Definition file
 N DA,DIK,GECREM,REMIEN
 S GECREM="VA-GEC REFERRAL TERM SET (CC)"
 S REMIEN=+$O(^PXD(811.9,"B",GECREM,0)) I REMIEN>0 D
 . S DIK="^PXD(811.9,",DA=REMIEN D ^DIK
 S GECREM="VA-GEC REFERRAL TERM SET (CR)"
 S REMIEN=+$O(^PXD(811.9,"B",GECREM,0)) I REMIEN>0 D
 . S DIK="^PXD(811.9,",DA=REMIEN D ^DIK
 S GECREM="VA-GEC REFERRAL TERM SET (NA)"
 S REMIEN=+$O(^PXD(811.9,"B",GECREM,0)) I REMIEN>0 D
 . S DIK="^PXD(811.9,",DA=REMIEN D ^DIK
 S GECREM="VA-GEC REFERRAL TERM SET (SS)"
 S REMIEN=+$O(^PXD(811.9,"B",GECREM,0)) I REMIEN>0 D
 . S DIK="^PXD(811.9,",DA=REMIEN D ^DIK
 Q
 ;
 ;===============================================================
EXFINC(Y) ;Return a 1 if the Exchange file entry is in the list to
 ;include in the build. This is used in the build to determine which
 ;entries to include.
 N ARRAY,FOUND,IEN,IC,LUVALUE
 D ARRAY(1,.ARRAY)
 S FOUND=0
 S IC=0
 F  S IC=+$O(ARRAY(IC)) Q:(IC=0)!(FOUND)  D
 . M LUVALUE=ARRAY(IC)
 . S IEN=+$$FIND1^DIC(811.8,"","KU",.LUVALUE)
 . I IEN=Y S FOUND=1 Q
 Q FOUND
 ;
 ;===============================================================
SMEXINS ;Silent mode install.
 N ARRAY,IC,IEN,LUVALUE,PXRMINST
 S PXRMINST=1
 D ARRAY(1,.ARRAY)
 S IC=0
 F  S IC=$O(ARRAY(IC)) Q:'IC  D
 .M LUVALUE=ARRAY(IC)
 .I LUVALUE(1)="GMTSMHV" Q
 .S IEN=+$$FIND1^DIC(811.8,"","KU",.LUVALUE)
 .I IEN'=0 D
 .. N TEXT
 .. I LUVALUE(1)["PARAMETER" S TEXT="Installing entry "_LUVALUE(1)
 .. E  S TEXT="Installing reminder "_LUVALUE(1)
 .. D BMES^XPDUTL(TEXT)
 .. D INSTALL^PXRMEXSI(IEN,1)
 Q
 ;
