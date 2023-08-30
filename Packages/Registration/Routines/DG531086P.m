DG531086P ;SLC/JLC - POST-INSTALL FOR DG*5.3*1086 ; Feb 28, 2023@14:32
 ;;5.3;Registration;**1086**;Aug 13, 1993;Build 12
 ;
 ; Reference to TIU(8925 supported in ICR #6154
 Q
 ;
EN ; entry point
 N ZTRTN,ZTSAVE,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTSAVE
 S ZTRTN="SEARCH^DG531086P",ZTDESC="Find Note Issues in Patient File"
 S ZTIO="",ZTDTH=$H,ZTSAVE("DUZ")=""
 D ^%ZTLOAD
 I $G(ZTSK) D BMES^XPDUTL("Task to search for bad note pointers queued, task number: "_ZTSK)
 I '$G(ZTSK) D BMES^XPDUTL("ERROR Tasking Search job. Please enter a SNOW ticket.")
 Q
 ;
SEARCH ;search for dangling note pointers
 ;or pointers to notes for different patients 
 ;remove pointer, as necessary
 N S1,ERRCNT,ORNOW,ORNOW180,S2,DFN,SO1,NOTEIEN,PXRMINPUTS,TEMP,XMSUB,XMTEXT,XMY,TEXT,A,I,XMFLG
 S S1=0,ERRCNT=0,ORNOW=$$NOW^XLFDT(),ORNOW180=$$FMADD^XLFDT(ORNOW,180)
 S ^XTMP("DG531086P",0)=ORNOW180_"^"_ORNOW_"^Search for bad note pointers in sexual orientation"
 F  S S1=$O(^DPT("G202501",S1)) Q:'S1  D
 . S S2=0
 . F  S S2=$O(^DPT("G202501",S1,S2)) Q:'S2  D
 .. K PXRMINPUTS S DFN=0
 .. F  S DFN=$O(^DPT("G202501",S1,S2,DFN)) Q:'DFN  D  S ^XTMP("DG531086P",DFN,0)="COMPLETED",^XTMP("DG531086P",0,1)=DFN
 ... S ^XTMP("DG531086P",DFN,0)="STARTED"
 ... S SO1=0
 ... F  S SO1=$O(^DPT(DFN,.025,SO1)) Q:'SO1  D
 .... I $P($G(^DPT(DFN,.025,SO1,0)),"^",5)="" Q
 .... S NOTEIEN=$P($G(^DPT(DFN,.025,SO1,0)),"^",5)
 .... I $$GET1^DIQ(8925,NOTEIEN,.02,"I")=DFN Q
 .... M ^XTMP("DG531086P",DFN,.025)=^DPT(DFN,.025) S ERRCNT=ERRCNT+1,ERRCNT(DFN)=""
 .... S PXRMINPUTS("Note")=NOTEIEN
 .... S TEMP=$$SOGI^VAFCAPI(DFN,.PXRMINPUTS,1)
 .... I 'TEMP Q
 .... S ^XTMP("DG531086P","ERROR",DFN)=TEMP
 S XMY("CRUMLEY.JAMIE@DOMAIN.EXT")="",XMY("THOMPSON.WILLIAM_ANTHONY@DOMAIN.EXT")="",XMY("PULEO.ANTHONY_G@DOMAIN.EXT")=""
 I $G(DUZ) S XMY(DUZ)=""
 K ^TMP("DG531086P",$J)
 S ^TMP("DG531086P",$J,1)="Sexual orientation note IEN cleanup has completed."
 S ^TMP("DG531086P",$J,2)=" "
 S ^TMP("DG531086P",$J,3)=$S('$D(^XTMP("DG531086P","ERROR")):"No e",1:"E")_"rrors have been reported."
 S ^TMP("DG531086P",$J,4)=" "
 S ^TMP("DG531086P",$J,5)=ERRCNT_" notes had cleanup performed."
 S XMSUB="PATCH DG*5.3*1086 CLEANUP COMPLETED",XMTEXT="^TMP(""DG531086P"","_$J_"," D ^XMD
 I 'ERRCNT Q
 K XMY,TEXT
 S TEXT(0,1)="Sexual orientation note IEN cleanup has completed."
 S TEXT(0,2)=" "
 S TEXT(0,3)=$S('$D(^XTMP("DG531086P","ERROR")):"No e",1:"E")_"rrors have been reported."
 S TEXT(0,4)=" "
 S TEXT(0,5)="The following patients had note cleanup performed:"
 S TEXT(0,6)=" "
 S TEXT(0,7)="PATIENT"
 S TEXT(0,8)=" "
 S DFN=""
 F I=9:1 S DFN=$O(ERRCNT(DFN)) Q:DFN=""  D
 . S A=$G(^DPT(DFN,0)),TEXT(0,I)=$E($P(A,"^"),1)_$E($P(A,"^",9),6,9)
 S XMSUB="PATCH DG*5.3*1086 CLEANUP COMPLETED",XMY("G.OR CACS")="",XMTEXT="TEXT(0)",XMFLG("FLAGS")="X"
 D SENDMSG^XMXAPI($G(DUZ),XMSUB,XMTEXT,.XMY,.XMFLG)
 Q
