XUTMG43 ;SEA/RDS - TaskMan: Globals: X-Refs For File 8989.3 ;07/29/98  14:12
 ;;8.0;KERNEL;**18,65,94**;Jul 03, 1995
 ;
SET ;set logic entry point
 N ZTLOG S ZTLOG=(X="Y") G UPDATE
 ;
KILL ;kill logic entry point
 N ZTLOG S ZTLOG=0 G UPDATE
 ;
UPDATE ;shared logic for MUMPS X-ref: Tell MGR to adjust resource logging
 N X,ZTM,ZTN,ZTV
 I $D(^%ZTSCH) D
 . L +^%ZTSCH("LOGRSRC") S:ZTLOG ^%ZTSCH("LOGRSRC")=1 K:'ZTLOG ^%ZTSCH("LOGRSRC") L -^%ZTSCH("LOGRSRC")
 S ZTV=0
U1 ;
 F  S ZTV=$O(^%ZIS(14.5,ZTV)) Q:'ZTV  D
 . S ZTREC=$G(^%ZIS(14.5,ZTV,0))
 . I ZTREC="" Q
 . I $P(ZTREC,U,3)="N" Q
 . I $P(ZTREC,U,4)="Y" Q
 . S X="TRAP^XUTMG43",@^%ZOSF("TRAP")
 . S ZTN=$P(ZTREC,U)
 . S ZTM=$P(ZTREC,U,6)
 . I '$D(^[ZTM,ZTN]%ZTSCH) Q
 . L +^[ZTM,ZTN]%ZTSCH("LOGRSRC")
 . I ZTLOG S ^[ZTM,ZTN]%ZTSCH("LOGRSRC")=1
 . E  K ^[ZTM,ZTN]%ZTSCH("LOGRSRC")
 . L -^[ZTM,ZTN]%ZTSCH("LOGRSRC") Q
 Q
 ;
TRAP ;UPDATE--trap link errors, which represent unaccessible links
 G U1
 ;
