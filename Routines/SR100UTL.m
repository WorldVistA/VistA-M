SR100UTL ;BIR/ADM - SR*3*100 INSTALL UTILITY ; [ 02/18/04  10:19 AM ]
 ;;3.0; Surgery ;**100**;24 Jun 93
 ;
 ; Reference to EXTRACT^TIULQ supported by DBIA #2693
 ; Reference to FILE^TIUSRVP supported by DBIA #3540
 ; Reference to $$WHATITLE^TIUPUTU supported by DBIA #3351
 ; Reference to $$DOCCLASS^TIULC1 supported by DBIA #3548
 ;
 Q
PRE ; pre-install entry
 ; delete ADIC, AUD, AUD1 x-refs, delete x-ref nodes
 K DIE,DR,DIK,DA S DIK="^DD(130,.23,1,",DA=3,DA(1)=.23,DA(2)=130 D ^DIK
 K DIK,DA S DIK="^DD(130,.232,1,",DA=2,DA(1)=.232,DA(2)=130 D ^DIK
 K DIK,DA S DIK="^DD(130,15,1,",DA=1,DA(1)=15,DA(2)=130 D ^DIK
 K DIK,DA,^SRF("AUD"),^SRF("ADIC")
 Q
POST ; post-install entry
 ; delete file 136
 I $D(^SRT(0)) S DIU="^SRT(",DIU(0)="DT" D EN^DIU2 K DIU
 N I,SRPOS
 F I=1:1:13 S SRPOS(I)=$G(XPDQUES("POS"_$S(I<10:"0",1:"")_I))
 Q:SRPOS(4)=""
 D PARAM
 D NOW^%DTC S (SRNOW,ZTDTH)=$E(%,1,12),ZTRTN="EN1^SR100UTL",ZTDESC="SR*3*100 - Post-Install Process",ZTIO="",ZTSAVE("SRPOS*")="" D ^%ZTLOAD
 D MES^XPDUTL("  SR*3*100 post-install process queued...")
 ; delete unused new routines associated with SR*3*100 at test sites
DEL F X="SRONP0","SRONP1" X ^%ZOSF("TEST") I $T D
 .D MES^XPDUTL(" Deleting routine "_X_"...")
 .X ^%ZOSF("DEL")
 Q
EN1 ; queued entry point
 D BOST
 D STUBS
 I SRPOS(6) D MOVE
MSG ; send mail message notification that post-insatll process is completed
 S XMY(DUZ)="",XMSUB="SR*3*100 Post-Install Is Completed"
 S SRTXT(1)="The post-install process for patch SR*3*100 is completed."
 S XMDUZ=.5,XMTEXT="SRTXT("
 N I D ^XMD S ZTREQ="@"
 Q
STUBS ; identify and create stub entries in TIU for reports to be signed
 N SRDT,SRTN Q:SRPOS(5)=""
 S SRDT=SRPOS(5)-".0001"
 F  S SRDT=$O(^SRF("AC",SRDT)) Q:'SRDT  S SRTN=0 F  S SRTN=$O(^SRF("AC",SRDT,SRTN)) Q:'SRTN  D
 .I $P($G(^SRF(SRTN,"NON")),"^")="Y" D NONOR Q
 .I $P($G(^SRF(SRTN,.2)),"^",12) D
 ..I '$P($G(^SRF(SRTN,"TIU")),"^") D OR^SROESX
 ..I '$P($G(^SRF(SRTN,"TIU")),"^",2) D NR^SROESX
 ..I '$P($G(^SRF(SRTN,"TIU")),"^",4),$P($G(^SRF(SRTN,.2)),"^",4),$$INUSE^SROESXA(SRTN) D AR^SROESXA
 Q
PARAM ; set default site parameters
 N DIV,J,SRP,Y,Z
 S SRP="^0^0" S $P(SRP,"^",4)=SRPOS(4)
 S DIV=0 F  S DIV=$O(^SRO(133,DIV)) Q:'DIV  S ^SRO(133,DIV,.1)=SRP
SRTAB ; activate surgery tab system-wide
 D PUT^XPAR("SYS","ORWOR SHOW SURGERY TAB",1,1,.SRERR)
 Q
BOST ; convert Boston prototype cases
 N DA,DIC,DIQ,DR,SRBOST,SREQ,SRERR,SRPAR,SRTITL,SRTN,SRX,SRY
 ; quit if Boston software is not installed
 I $$GET1^DID(130,523011,"","LABEL")'["OP NOTE POINTER" Q
 S SRX=$$WHATITLE^TIUPUTU("OPERATION REPORT"),SRTITL=$P(SRX,"^") Q:'SRTITL
 S SRPAR=$$DOCCLASS^TIULC1(SRTITL) Q:'SRPAR
 S SRTN=0 F  S SRTN=$O(^SRF(SRTN)) Q:'SRTN  S SRBOST=$P($G(^SRF(SRTN,523)),"^",4) I SRBOST,'$P($G(^SRF(SRTN,"TIU")),"^") D
 .D EXTRACT^TIULQ(SRBOST,"SRY",.SRERR,"1701")
 .I $G(SRY(SRBOST,1701,"E"))="Case #: "_SRTN D  K SRY
 ..S $P(^SRF(SRTN,"TIU"),"^")=SRBOST
 ..K SREQ S SREQ(.01)=SRTITL,SREQ(.04)=SRPAR,SREQ(1405)=SRTN_";SRF(" D FILE^TIUSRVP(.SRERR,SRBOST,.SREQ,1)
 Q
MOVE ; move reports for historical cases to TIU
 N SRSD,SRRPT,SRINST,SRINSTP I SRPOS(7)="" S SRPOS(7)=SRPOS(5)
 S SRSD=SRPOS(7),SRRPT(1)=SRPOS(8),SRRPT(2)=SRPOS(9),SRRPT(3)=SRPOS(10),SRRPT(4)=SRPOS(11),(SRINST,SRINSTP)="ALL DIVISIONS"
 D MOVE^SROHIS
 Q
NONOR ; if dictated summary expected field is null, set to 0
 I $P($G(^SRF(SRTN,"TIU")),"^",5)="" S $P(^SRF(SRTN,"TIU"),"^",5)=0
 Q
