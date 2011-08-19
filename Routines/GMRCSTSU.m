GMRCSTSU ;SLC/DLT - Change status based on current order status ;7/16/98  03:43
 ;;3.0;CONSULT/REQUEST TRACKING;**4**;DEC 27, 1997
CPRSUPD(GMRCO) ;Update CPRS order with new status
 ;GMRCO=IEN from file 123
 Q
 N DFN,CTRLCODE,GMRCSTS,GMRCPROV,GMRCORFN,ORSTS,ORIFN
 S GMRCSTS=$P(^GMR(123,+GMRCO,0),"^",12),GMRCORFN=$P(^(0),"^",3),DFN=$P(^(0),"^",2),GMRCPROV=$P(^(0),"^",14)
 ;S CTRLCODE=$S(GMRCSTS=5:"ZU",GMRCSTS=6:"ZU",1:"ZR")
 ;S DIE="^GMR(123,",DA=GMRCO,DR=".03////^S X=""@"""
 ;D ^DIE
 K GMRCSTS,DIE,DA,DR
 Q
 ;D EN^GMRCHL7(DFN,+GMRCO,"","",CTRLCODE,GMRCPROV,"","") ;Send CPRS an HL-7 message about status of purge - can/can't purge record
 Q
END Q
END1 K DA,GMRCDT,GMRCPCNT,GMRCIDT,GMRCTRLC,GMRCOM
 K ^TMP("GMRCS",$J),^TMP("GMRCSLIST",$J)
 Q
 ;
TIURSL ;Get TIU results to update the Consults package
 ;One time run to get the information TIU has into the consults package.
 ;
 F PASS=1,2 D LOOP
 Q
 ;
LOOP ;LOOP Thru TIU entries to populate the 50th node.
 S TIUDA=0,TIUEDT=2980500,GMRCY=0
 F  S TIUEDT=$O(^TIU(8925,"F",TIUEDT)) Q:'TIUEDT  D
 . S TIUDA=$O(^TIU(8925,"F",TIUEDT,"")) Q:'TIUDA
 . Q:'$D(^TIU(8925,TIUDA,14))
 . S GMRCO=$P($G(^TIU(8925,TIUDA,14)),"^",5)
 . Q:$P(GMRCO,";",2)'="GMR(123,"
 . Q:'$D(^GMR(123,+GMRCO,0))
 . I PASS=1 K ^GMR(123,+GMRCO,50) Q
 . ;PASS 2 ADD
 . S GMRCVDA=TIUDA_";TIU(8925,"
 . D ADDRSLT^GMRCTIUA(+GMRCO,GMRCVDA)
 Q
 ;
ONETIME ;One time run to load the file 123 consult entry multiple results
 ;with the TIU Narrative Result
 ;
 N ZTSK
 S ZTSK=$$QUEUE("ONETIMER^GMRCSTSU","One time run to load the file 123 consult entry multiple results and rebuild cross-references")
 I ZTSK W !,"One time load Queued to run. Task#",ZTSK
 E  W !,"One Time load failed to queue."
 Q
 ;
ONETIMER ;
 D XREF
 D NWXREF
 S GMRCDT=2970100,GMRCY=0
 F  S GMRCDT=$O(^GMR(123,"B",GMRCDT))  Q:'GMRCDT  D
 . S GMRCO=0 F  S GMRCO=$O(^GMR(123,"B",GMRCDT,GMRCO)) Q:'GMRCO  D
 .. I '$D(^GMR(123,+GMRCO,50)),+$P($G(^GMR(123,+GMRCO,0)),"^",20) S GMRCY=$$LOAD^GMRCTIUA(GMRCO)
 ;
 Q
XREF ;re-create cross references for specific fields in files
 N SVC 
 D BMES^XPDUTL("Re-indexing APC cross reference for service entries ")
 K ^GMR(123.5,"APC")
 S SVC=0
 F  S SVC=$O(^GMR(123.5,SVC)) Q:'SVC  D
 . S DA(1)=SVC
 . S DIK="^GMR(123.5,"_DA(1)_",10,"
 . S DIK(1)=".01^APC"
 . D ENALL^DIK
 D BMES^XPDUTL("Re-indexing AC cross reference for sub-service entries ")
 S SVC=0
 F  S SVC=$O(^GMR(123.5,SVC)) Q:'SVC  D
 . K ^GMR(123.5,SVC,10,"AC")
 . S DA(1)=SVC
 . S DIK="^GMR(123.5,"_DA(1)_",10,"
 . S DIK(1)=".01^AC"
 . D ENALL^DIK
 Q
 ;
 ;
NWXREF ;Create new cross references for specific fields in file 123
 N DIK
 D BMES^XPDUTL("Creating new G cross-reference on Sending Provider for consults in 123 ...")
 S DIK="^GMR(123,"
 S DIK(1)="10^G"
 D ENALL^DIK
 ;
 D BMES^XPDUTL("Creating new H cross-reference on FROM location for consults in 123 ...")
 S DIK="^GMR(123,"
 S DIK(1)="2^H"
 D ENALL^DIK
 ;
 D BMES^XPDUTL("Creating new R cross-reference on consult results in file 123 ...")
 N GMRCO,DIK,DA
 S GMRCO=0
 F  S GMRCO=$O(^GMR(123,GMRCO)) Q:'GMRCO  D
 . S DA(1)=GMRCO
 . S DIK="^GMR(123,"_DA(1)_",50,"
 . S DIK(1)=".01^R"
 . D ENALL^DIK
 Q
 ;
QUEUE(ZTRTN,ZTDESC,ZTDTH,ZTIO) ;
 ;
 ; ZTRTN -- ROUTINE TO RUN (MANDATORY)
 ; ZTDESC - DESCRIPTION OF THE TASK (OPTIONAL)
 ; ZTDTH -- TIME TO RUN (OPTIONAL - DEFAULT = NOW)
 ; ZTIO --- DEVICE TO SEND OUTPUT TO (OPTIONAL)
 ;
 N ZTCPU,ZTPAR,ZTPRE,ZTPRI
 N ZTSAVE,ZTSK,ZTUCI
 ;
 Q:'$L($G(ZTRTN)) 0
 S:'$L($G(ZTDESC)) ZTDESC="CONSULT/REQUEST PACKAGE TASK"
 S:'$L($G(ZTIO)) ZTIO=""
 S:'$L($G(ZTDTH)) ZTDTH=$H
 D ^%ZTLOAD
 ;
 Q $G(ZTSK)
 ;
