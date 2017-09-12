PXRMP3I ; SLC/PKR - Patch 3 init routine. ;02/15/2005
 ;;2.0;CLINICAL REMINDERS;**3**;Feb 04, 2005
 ;Reminder Exchange install.
 Q
 ;
 ;===============================================================
ARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;
 S ARRAY(1,1)="VA-MHV BMI > 25.0"
 I MODE S ARRAY(1,2)="04/01/2005@10:11:13"
 S ARRAY(2,1)="VA-MHV CERVICAL CANCER SCREEN"
 I MODE S ARRAY(2,2)="02/15/2005@08:47:44"
 S ARRAY(3,1)="VA-MHV COLORECTAL CANCER SCREEN"
 I MODE S ARRAY(3,2)="02/15/2005@08:48:07"
 S ARRAY(4,1)="VA-MHV DIABETES FOOT EXAM"
 I MODE S ARRAY(4,2)="02/15/2005@08:48:38"
 S ARRAY(5,1)="VA-MHV DIABETES HBA1C"
 I MODE S ARRAY(5,2)="02/15/2005@08:48:55"
 S ARRAY(6,1)="VA-MHV DIABETES RETINAL EXAM"
 I MODE S ARRAY(6,2)="02/15/2005@08:49:15"
 S ARRAY(7,1)="VA-MHV HYPERTENSION"
 I MODE S ARRAY(7,2)="02/15/2005@08:49:36"
 S ARRAY(8,1)="VA-MHV INFLUENZA VACCINE"
 I MODE S ARRAY(8,2)="02/15/2005@08:49:56"
 S ARRAY(9,1)="VA-MHV LDL CONTROL"
 I MODE S ARRAY(9,2)="03/01/2005@13:08:41"
 S ARRAY(10,1)="VA-MHV LIPID MEASUREMENT"
 I MODE S ARRAY(10,2)="03/01/2005@13:08:18"
 S ARRAY(11,1)="VA-MHV MAMMOGRAM SCREENING"
 I MODE S ARRAY(11,2)="03/01/2005@13:08:55"
 S ARRAY(12,1)="VA-MHV PNEUMOVAX"
 I MODE S ARRAY(12,2)="02/15/2005@08:51:39"
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
PRE ;
 D DELEI
 Q
POST ;
 D SMEXINS
 Q
 ;===============================================================
SMEXINS ;Silent mode install.
 N ARRAY,IC,IEN,LUVALUE,PXRMINST
 S PXRMINST=1
 D ARRAY(1,.ARRAY)
 S IC=0
 F  S IC=$O(ARRAY(IC)) Q:'IC  D
 .M LUVALUE=ARRAY(IC)
 .S IEN=+$$FIND1^DIC(811.8,"","KU",.LUVALUE)
 .I IEN'=0 D
 .. N TEXT
 .. I LUVALUE(1)["PARAMETER" S TEXT="Installing entry "_LUVALUE(1)
 .. E  S TEXT="Installing reminder "_LUVALUE(1)
 .. D BMES^XPDUTL(TEXT)
 .. D INSTALL^PXRMEXSI(IEN,1)
 Q
 ;
