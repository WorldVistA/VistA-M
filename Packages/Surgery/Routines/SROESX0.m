SROESX0 ;BIR/ADM - SURGERY E-SIG UTILITY ; [ 02/13/02  12:03 PM ]
 ;;3.0; Surgery ;**100**;24 Jun 93
 ;
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
 ; Reference to UPDATE^TIUSRVP supported by DBIA #3535
 ; Reference to EXTRACT^TIULQ supported by DBIA #2693
 ; Reference to FILE^TIUSRVP supported by DBIA #3540
 ;
 Q
SET ; set logic for AES1 and AES2 x-refs
 N SRPHY,SRSTAT,SRTN,SRTIU,SRX,ZTDESC,ZTRTN,ZTIO,ZTDTH,ZTSAVE,ZTSK
 S SRPHY=X2 D NEXT Q:'SRTIU
TASK ; task call to TIU
 S ZTDESC="Update Signer in TIU",ZTRTN="SIGNER^SROESX0",ZTIO="",ZTDTH=$H,(ZTSAVE("SRTIU"),ZTSAVE("SRPHY"))="" D ^%ZTLOAD
 Q
SIGNER ; make call to TIU to update author and expected signer
 D STATUS S SRAY(.05)=$S(SRSTAT:SRSTAT,1:1),(SRAY(1202),SRAY(1204))=SRPHY
 D UPDATE^TIUSRVP(.SRDOC,SRTIU,.SRAY,1)
END I $D(ZTQUEUED) S ZTREQ="@"
 Q
NEXT S SRTN=DA,SRX=$G(^SRF(SRTN,"TIU"))
 S SRTIU=$S($P($G(^SRF(SRTN,"NON")),"^")="Y":$P(SRX,"^",3),1:$P(SRX,"^"))
 Q
STATUS ; get TIU document status
 D EXTRACT^TIULQ(SRTIU,"SRY",.SRERR,".05",1) S SRSTAT=$G(SRY(SRTIU,.05,"I"))
 Q
SET1 ; set logic for AES3 and AES4 and x-refs
 N SRPHY,SRSTAT,SRTN,SRTIU,SRX,ZTDESC,ZTRTN,ZTIO,ZTDTH,ZTSAVE,ZTSK
 S SRPHY=X2 D NEXT Q:'SRTIU
TASK1 ; task call to TIU
 S ZTDESC="Update Cosigner in TIU",ZTRTN="COSIG^SROESX0",ZTIO="",ZTDTH=$H,(ZTSAVE("SRTIU"),ZTSAVE("SRPHY"))="" D ^%ZTLOAD
 Q
COSIG ; make call to TIU to update attending and expected cosigner
 D STATUS S SRAY(.05)=$S(SRSTAT:SRSTAT,1:1),(SRAY(1208),SRAY(1209))=SRPHY
 D UPDATE^TIUSRVP(.SRDOC,SRTIU,.SRAY,1) D END
 Q
SET2 ; set logic for AES5 x-ref
 N SRPHY,SRSTAT,SRTN,SRTIU,SRX,ZTDESC,ZTRTN,ZTIO,ZTDTH,ZTSAVE,ZTSK
 S SRPHY=X2,SRTN=DA,SRX=$G(^SRF(SRTN,"TIU")),SRTIU=$P(SRX,"^",4) Q:'SRTIU
 D TASK,ALTSK
 Q
SET3 ; set logic for AES6 x-ref
 N SRPHY,SRSTAT,SRTN,SRTIU,SRX,ZTDESC,ZTRTN,ZTIO,ZTDTH,ZTSAVE,ZTSK
 S SRPHY=X2,SRTN=DA,SRX=$G(^SRF(SRTN,"TIU")),SRTIU=$P(SRX,"^",4) Q:'SRTIU
 D TASK1
ALTSK S ZTDESC="Task Alerts to Anesthesia",ZTRTN="ANLRT^SROESX0",ZTIO="",ZTDTH=$H,(ZTSAVE("SRTIU"),ZTSAVE("SRTN"))="" D ^%ZTLOAD
 Q
ANLRT ; for anesthesia report, delete and re-issue alert
 N SRSTAT D STATUS I SRSTAT=1 D ALERT^SROESXA,END
 Q
SET4 ; set logic for AES7 x-ref
 N SRTN,SRTIU,SRX,ZTDESC,ZTRTN,ZTIO,ZTDTH,ZTSAVE,ZTSK
 S SRTN=DA(1),SRX=$G(^SRF(SRTN,"TIU")),SRTIU=$P(SRX,"^",2) Q:'SRTIU
 S ZTDESC="Update Nurse Report Signer in TIU",ZTRTN="RNSIG^SROESX0",ZTIO="",ZTDTH=$H,(ZTSAVE("SRTIU"),ZTSAVE("SRTN"))="" D ^%ZTLOAD
 S ZTDESC="Task Alerts to Circulating Nurses",ZTRTN="RNLRT^SROESX0",ZTIO="",ZTDTH=$H,(ZTSAVE("SRTIU"),ZTSAVE("SRTN"))="" D ^%ZTLOAD
 Q
RNSIG ; update signer/author of nurse report
 ; get first circulating nurse as author and expected signer
 S SRPHY="",SRRN=$O(^SRF(SRTN,19,0)) S:SRRN SRPHY=$P($G(^SRF(SRTN,19,SRRN,0)),"^")
 D SIGNER
 Q
RNLRT ; for nurse report, delete and re-issue alert
 N SRSTAT D STATUS I SRSTAT=1 D ALERT^SROESX,END
 Q
AES8 ; set logic for AES7 cross-reference
 N II,SR0,SRAY,SRTDA,SRTN,SRTIU
 S SRTN=$S($D(SRTN):SRTN,1:DA)
 S SR0=^SRF(SRTN,0),SRTIU=$G(^SRF(SRTN,"TIU")),SRAY(1301)=$P(SR0,"^",9)
 F II=1,2,3,4 I $P(SRTIU,"^",II) S SRTDA=$P(SRTIU,"^",II) D
 .D FILE^TIUSRVP(.SRERR,SRTDA,.SRAY,1)
 Q
