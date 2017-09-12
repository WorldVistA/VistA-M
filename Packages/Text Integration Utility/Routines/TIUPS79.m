TIUPS79 ; SLC/JM - Post-install for TIU*1*79 ;04:18 PM  20 Jan 2000
 ;;1.0;TEXT INTEGRATION UTILITIES;**79**;Jun 20, 1997
INSTALL ; Main entry point for install
 N DOCOUNT,XPDIDTOT S DOCOUNT=1
 D MAIN
 D BUILDAES ; Build new AES cross-reference
 Q
MAIN ; Main entry point for manual call
 N IDX,USER,CNT
 ; First reorder the ASAVE XRef in ^TMP
 K ^TMP("TIU79",$J)
 S USER=0
 F  S USER=$O(^TIU(8925,"ASAVE",USER)) Q:'USER  D 
 .S IDX=0
 .F  S IDX=$O(^TIU(8925,"ASAVE",USER,IDX)) Q:'IDX  D 
 ..S ^TMP("TIU79",$J,IDX,USER)=""
 S CNT=0
 I $D(DOCOUNT) D
 .D COUNT(.CNT,-2),COUNT(.CNT,"-0;")
 .S XPDIDTOT=CNT,CNT=0
 D FIX(.CNT,-2),FIX(.CNT,"-0;")
 K ^TMP("TIU79",$J)
 Q
 ;
COUNT(CNT,FRSTBASE) ;Count all the -1 entries in "G" XRef
 N BASE,IDX
 S BASE=FRSTBASE
 F  S BASE=$O(^TIU(8925,"G",BASE)) Q:$$BADBASE()  D
 .S IDX=0
 .F  S IDX=$O(^TIU(8925,"G",BASE,IDX)) Q:'IDX  S CNT=CNT+1
 Q
 ;
FIX(CNT,FRSTBASE) ;Fix 1405 fields by searching the "G" XRef for -1
 N BASE,IDX,USER
 S BASE=FRSTBASE
 F  S BASE=$O(^TIU(8925,"G",BASE)) Q:$$BADBASE()  D
 .S IDX=0
 .F  S IDX=$O(^TIU(8925,"G",BASE,IDX)) Q:'IDX  D
 ..S USER=0
 ..F  S USER=$O(^TMP("TIU79",$J,IDX,USER)) Q:'USER  D
 ...K ^TIU(8925,"ASAVE",USER,IDX)
 ..N DIE,DA,DR
 ..S DIE=8925
 ..S DA=IDX
 ..S DR="1405///@"
 ..D ^DIE
 ..I $D(DOCOUNT) D
 ...S CNT=CNT+1
 ...D UPDATE^XPDID(CNT)
 Q
BADBASE() ; Returns TRUE if at the end of this part of the "G" XRef
 N BAD
 S BAD=0
 I FRSTBASE=-2 D  I 1
 .I BASE'=-1,BASE'=0 S BAD=1
 E  I (+BASE)'=-1 S BAD=1
 Q BAD
BUILDAES        ; Build "AES" index on Multi-signature file
 N DA,DIK,CNT,XPDIDTOT
 ; If the index exists, don't rebuild it
 Q:+$O(^TIU(8925.7,"AES",0))
 S DIK="^TIU(8925.7,",DIK(1)=".01^AES",(CNT,DA)=0
 D BMES^XPDUTL(" BUILDING NEW ""AES"" CROSS-REFERENCE ON FILE 8925.7")
 S XPDIDTOT=$P(^TIU(8925.1,0),U,4)
 D UPDATE^XPDID(0)
 F  S DA=$O(^TIU(8925.7,DA)) Q:+DA'>0  D
 . D EN1^DIK
 . S CNT=CNT+1
 . D:'(CNT#10) UPDATE^XPDID(CNT)
 Q
