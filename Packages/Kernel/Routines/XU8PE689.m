XU8PE689 ;ISD/JCH - Patch XU*8*689 Environment Check Routine ;01/26/23  12:04
 ;;8.0;KERNEL;**689**;Jul 10, 1995;Build 113
 ;Per VA Directive 6402, this routine should not be modified.
 ;
ENV ; Environment Check
 N XUHANDLE,XUTITLE,XMISTART,XMIEXP,XUPDBAC
 S XUHANDLE="PSO70684-INSTALL"
 S XUPDBAC=$$XUPDBAC()
 S XMISTART=$P($G(^XTMP(XUHANDLE,0)),"^",2),XMIEXP=0
 I XMISTART,($$FMDIFF^XLFDT($$DT^XLFDT,XMISTART)>7) S XMIEXP=1
 S XUTITLE="REFRESH DEA MIGRATION"
 L +^XTMP(XUHANDLE):0 I '$T D  Q
 . D BMES^XPDUTL("**************************** WARNING ***********************************")
 . D BMES^XPDUTL(XUTITLE_" job is still running.  Halting...")
 . D BMES^XPDUTL(" The DEA Migration must run to completion before installing this patch. ")
 . D BMES^XPDUTL("               >>>> Installation aborted <<<<                           ")
 . D BMES^XPDUTL("************************************************************************")
 . S XPDABORT=1  ; Do not install this transport global and KILL it from ^XTMP.
 I $$PATCH^XPDUTL("XU*8.0*689") D  Q  ; Don't require DEA migration if previously installed
 . L -^XTMP(XUHANDLE)
 I '$$PROD^XUPROD D  Q
 . S ^XTMP(XUHANDLE,0)=$$FMADD^XLFDT($$NOW^XLFDT,90)_"^"_$$NOW^XLFDT_"^PSO DEA Migration"
 . S ^XTMP(XUHANDLE,"COMPLETE")=$$NOW^XLFDT
 . S ^XTMP(XUHANDLE,"STATUS")="Install Completed"
 . L -^XTMP(XUHANDLE)
 I XUPDBAC!'$D(^XTMP(XUHANDLE))!($G(^XTMP(XUHANDLE,"STATUS"))'="Install Completed")!$G(XMIEXP) D  L -^XTMP(XUHANDLE) Q
 . N MISCHDT,MISCH
 . S MISCHDT=$P($G(^XTMP(XUHANDLE,0)),"^",2),MISCH=$S(((MISCHDT?7N.E)&(MISCHDT>$$NOW^XLFDT)):1,1:0)
 . D BMES^XPDUTL("**************************** WARNING ***********************************")
 . I MISCH D
 .. D BMES^XPDUTL("      The DEA Migration is scheduled to run "_$$FMTE^XLFDT(MISCHDT))
 . I 'MISCH D
 .. I $G(XUPDBAC) K ^XTMP("PSO70684-INSTALL")                      ; Require another DEA migration
 .. D BMES^XPDUTL(" The DEA Migration is outdated. Please run the DEA Migration using the  ")
 .. D BMES^XPDUTL("  DEA Migration Report [PSO DEA MIGRATION REPORT] option and entering   ")
 .. D BMES^XPDUTL("     'YES' at the prompt 'Do you want to re-run the DEA Migration?'     ")
 . D BMES^XPDUTL(" The DEA Migration must run to completion before installing this patch. ")
 . D BMES^XPDUTL("               >>>> Installation aborted <<<<                           ")
 . D BMES^XPDUTL("************************************************************************")
 . S XPDABORT=1  ; Do not install this transport global and KILL it from ^XTMP.
 L -^XTMP(XUHANDLE)
 Q
 ;
XUPDBAC() ; Update BAC file with new codes if necessary (CQ, MT, MY)
 N XUBACUPD,XUBACMIS
 S XUBACUPD=$$MISSBAC(.XUBACMIS)
 I 'XUBACUPD Q 0
 S BAC="" F  S BAC=$O(XUBACMIS(BAC)) Q:BAC=""  D
 . N FDA,XUDEAERR
 . S FDA(8991.8,"?+1,",.01)=BAC
 . S FDA(8991.8,"?+1,",.02)=$E(BAC)
 . S FDA(8991.8,"?+1,",.03)=$E(BAC,$L(BAC))
 . S FDA(8991.8,"?+1,",2)=$$NOW^XLFDT
 . D UPDATE^DIE("","FDA",,"XUDEAERR")
 . I $G(XUDEAERR("DIERR")) S XUBACUPD=XUBACUPD-1  ; If not filed, don't count it
 I XUBACUPD<1 Q 0                                 ; Nothing updated
 Q XUBACUPD
 ;
MISSBAC(MISSING) ; New BACs (CQ,MT,MY) missing from file 8991.8?
 N BAC K MISSING S MISSING=0
 F BAC="CQ","MT","MY" D
 . Q:$$FIND1^DIC(8991.8,"","X",BAC)
 . S MISSING(BAC)="",MISSING=$G(MISSING)+1
 Q $S($G(MISSING):1,1:0)
