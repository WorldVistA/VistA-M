PX1P204 ;ALB/LLS - update ENTRY ACTION of protocol PXCE NEW ENCOUNTER
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**204**;Aug 12, 1996;Build 14
 ;
 Q 
 ;
PROCESS ; Look at all entries in the PATIENT file (#2).
 N PXIEN,PXNODE
 S PXIEN=$O(^ORD(101,"B","PXCE NEW ENCOUNTER",""))
 ; 
 K ^XTMP("PX1P204",$J)
 I PXIEN="" S ^XTMP("PX1P204",$J,"OLD")="DID NOT EXIST" G SNDMSG
 ; 
 ; set up 0 node of ^XTMP to allow the system to purge after 90 days
 S (^XTMP("PX1P204",0),^XTMP("PX1P204",$J,0))=$$FMADD^XLFDT(DT,90)_U_DT_U_"Update ENTRY ACTION of protocol PXCE NEW ENCOUNTER"
 ;
 I '$D(^ORD(101,PXIEN,20)) S ^XTMP("PX1P204",$J,"OLD")="DID NOT EXIST" G SNDMSG
 S ^XTMP("PX1P204",$J,"OLD")=^ORD(101,PXIEN,20)
 S ^ORD(101,PXIEN,20)="S PXCEVIEN="""" D SDSALONE^PXCEPAT D:$G(PXCEPAT)>0 EN^PXCEVFIL(""SIT"")"
 S ^XTMP("PX1P204",$J,"NEW")=^ORD(101,PXIEN,20)
SNDMSG ;
 D MES^XPDUTL("------------------------------------------------------------------------")
 D MES^XPDUTL("The process to update ENTRY ACTION of protocol PXCE NEW ENCOUNTER is complete")
 D MES^XPDUTL("  OLD value: ")
 D MES^XPDUTL("     "_$G(^XTMP("PX1P204",$J,"OLD")))
 D MES^XPDUTL("  NEW value: ")
 D MES^XPDUTL("     "_$G(^XTMP("PX1P204",$J,"NEW")))
 D MES^XPDUTL("------------------------------------------------------------------------")
 Q
