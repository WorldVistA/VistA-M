ONC2PS23 ;HINES OIFO/RTK - Post-Install Routine for Patch ONC*2.2*23 ;02/11/26
 ;;2.2;ONCOLOGY;**23**;Jul 31, 2013;Build 6
 ;
 D NEWDEV,NEWDEV2,SETMIG
 Q
 ;
NEWDEV ;add new device "ORIS-HFS" to the Device (#3.5) file
 N ONC,ONIEN,ONCSIEN,ONERVIEN,ONRVIEN
 ; QUIT if the "ORIS-HFS" device already exists
 I $$FIND1^DIC(3.5,,"B","ORIS-HFS") D  Q
 .D BMES^XPDUTL("ORIS-HFS already exists...")
 .Q
 ;
 ; If it doesn't exist, go ahead and set up the new device
 K DD,DO
 S DIC="^%ZIS(1,",DIC(0)="Z" S X="ORIS-HFS" D FILE^DICN
 S ONCDVIEN=$O(^%ZIS(1,"B","ORIS-HFS",""))
 I ONCDVIEN="" Q
 S DA=ONCDVIEN,ONCOPPAR="""NWS"""
 S DIE="^%ZIS(1,"
 S DR=".02///^S X=""ORIS-HFS"";1///^S X=""/tmp/onc2oris.utility.txt"";1.95///^S X=1;2///^S X=""HFS"";3///^S X=16;4///^S X=1;5///^S X=1;5.1///^S X=1;5.2///^S X=0;19///^S X=ONCOPPAR;51///^S X=79"
 D ^DIE
 ;
 I $$FIND1^DIC(3.5,,"B","ORIS-HFS") D
 .D BMES^XPDUTL("ORIS-HFS installed...")
 Q
 ;
NEWDEV2 ;add new device "ORIS-HFS-SCHEDULED" to the Device (#3.5) file
 N ONC,ONIEN,ONCSIEN,ONERVIEN,ONRVIEN
 ; QUIT if the "ORIS-HFS-SCHEDULED" device already exists
 I $$FIND1^DIC(3.5,,"B","ORIS-HFS-SCHEDULED") D  Q
 .D BMES^XPDUTL("ORIS-HFS-SCHEDULED already exists...")
 .Q
 ;
 ; If it doesn't exist, go ahead and set up the new device
 K DD,DO
 S DIC="^%ZIS(1,",DIC(0)="Z" S X="ORIS-HFS-SCHEDULED" D FILE^DICN
 S ONCDVIEN=$O(^%ZIS(1,"B","ORIS-HFS-SCHEDULED",""))
 I ONCDVIEN="" Q
 S DA=ONCDVIEN,ONCOPPAR="""NWS"""
 S DIE="^%ZIS(1,"
 S DR=".02///^S X=""ORIS-HFS-SCHEDULED"";1///^S X=""/tmp/onc2oris.scheduler.txt"";1.95///^S X=1;2///^S X=""HFS"";3///^S X=16;4///^S X=1;5///^S X=1;5.1///^S X=1;5.2///^S X=0;19///^S X=ONCOPPAR;51///^S X=79"
 D ^DIE
 ;
 I $$FIND1^DIC(3.5,,"B","ORIS-HFS-SCHEDULED") D
 .D BMES^XPDUTL("ORIS-HFS-SCHEDULED installed...")
 Q
 ;
SETMIG ;set data migration field in the Oncology Site Parameters file
 D BMES^XPDUTL("Set data migration parameters...")
 F ONCSPIEN=0:0 S ONCSPIEN=$O(^ONCO(160.1,ONCSPIEN))  Q:ONCSPIEN'>0  D
 .S ^ONCO(160.1,ONCSPIEN,"ACCESSKEY")="accessKey:IPIMNInMMZP19hU9"
 .S ^ONCO(160.1,ONCSPIEN,"SVPATH")="https://oris.domain.ext/jsonupload"
 .;S ^ONCO(160.1,ONCSPIEN,"ACCESSKEY")="accessKey:8dJ451Br9KLPoi912"
 .;S ^ONCO(160.1,ONCSPIEN,"SVPATH")="https://test.oris.domain.ext/jsonupload"
 Q
