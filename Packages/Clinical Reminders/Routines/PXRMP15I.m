PXRMP15I ; SLC/AGP - Patch 15 init routine. ;12/11/2008
 ;;2.0;CLINICAL REMINDERS;**15**;Feb 04, 2005;Build 35
 ;Reminder Exchange install.
 Q
 ;
 ;===============================================================
ARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;
 S ARRAY(1,1)="VA-TBI/POLYTRAUMA REHAB/REINTEGRATION PLAN OF CARE"
 I MODE S ARRAY(1,2)="01/08/2009@18:15:44"
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
 .. D INSTALL^PXRMEXSI(IEN,"I",1)
 Q
 ;
