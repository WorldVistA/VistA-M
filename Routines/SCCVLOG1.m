SCCVLOG1 ;ALB/RMO,TMP - Scheduling Conversion Log Utilities - Error; [ 04/05/95  8:39 AM ]
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
GETERR(SCERRNB,SCE,SCERRIP,SCLOG,SAVERR,SCERRMSG) ;Get error msg
 ;Also log the error in the Scheduling conversion log file
 ;if the conversion log IEN is passed in SCLOG.
 ; Input  -- SCERRNB  Error number
 ;           SCE      Array holding patient/date-tm/enctr/visit data
 ;                    subscripts: "DFN"/"DATE"/"ENC"/"VSIT" [optional]
 ;           SCERRIP  Error input parameter array   [optional]
 ;           SCLOG    Scheduling conversion log IEN [optional]
 ;           SAVERR   Parameter that says whether or not to return the
 ;                    error array or kill it (1=save it, 0=kill it)
 ; Output -- SCERRMSG Error message array subscripted by line # of msg
 D BLD^DIALOG(SCERRNB,.SCERRIP,"","SCERRMSG")
 I $G(SCLOG) D LOGERR(SCLOG,.SCERRMSG,.SCE,.SCCVERRH) K:'$G(SAVERR) SCERRMSG
 Q
 ;
LOGERR(SCLOG,SCERRMSG,SCE,SCCVERRH) ;Log the error in the CST file
 ; Input  -- SCLOG    CST ien
 ;        -- SCERRMSG Error message array subscripted by line #
 ;        -- SCE      Array holding patient/date-tm/enctr/visit data
 ;                    subscripts: "DFN"/"DATE"/"ENC"/"VSIT"
 ; I/O    -- SCCVERRH Error counter, also output - pass by reference
 ;
 N SCDATA,SCERRM1,Z,Z0,Z1,SCCVH
 ;
 IF $G(SCCVERRH)="" N SCCVERRH S SCCVERRH=0
 S SCCVERRH=SCCVERRH+1,SCERRMSG(.9)="ERROR #: "_SCCVERRH
 ;
 S (Z,Z0)=0
 F  S Z=$O(SCERRMSG(Z)) Q:'Z  S Z1=$G(SCERRMSG(Z)) D
 . Q:$S($TR(Z1," ")="":1,$E(Z1,1,7)="Calling":1,$E(Z1,1,6)="Source":1,$E(Z1,1,4)="User":1,$E(Z1,1,5)="Visit":1,$E(Z1,1,3)="TO:":1,$E(Z1,1,33)="ERROR MESSAGE FROM DATA2PCE^PXAPI":1,1:0)
 . S Z0=Z0+1,SCERRM1(Z0,0)=$S(Z0>1:"  ",1:"")_Z1
 ;
 I $L(SCERRM1(1,0))<210 S SCERRM1(1,0)=SCERRM1(1,0)_" - "_$$FMTE^XLFDT($$NOW^XLFDT,5)
 ;
 I $D(SCE) D
 . S SCERRM1(Z0+1,0)="  Patient: ("_$G(SCE("DFN"))_") "_$$EXPAND^SCCVDSP2(409.68,.02,$G(SCE("DFN")))_"   Enctr Dt: "_$$FMTE^XLFDT($G(SCE("DATE")),"5S")
 . S SCERRM1(Z0+2,0)="  Enctr #: "_$G(SCE("ENC"))_"  Visit #:  "_$G(SCE("VSIT"))
 . S SCERRM1(Z0+3,0)=" "
 ;
 I '$G(SCLOG) K SCERRMSG M SCERRMSG=SCERRM1
 I $G(SCLOG) D
 . M SCDATA("WP")=SCERRM1
 . D WP^SCCVDBU(404.98,SCLOG,50,.SCDATA)
 . ;
 . S SCCVH(.07)=SCCVERRH-$G(SCCVERRT)
 . D UPD^SCCVDBU(404.9825,+$$LSTREQ^SCCVLOG(SCLOG)_","_SCLOG,.SCCVH)
 Q
 ;
CREATERR(DFN,SCDTM,SCOE,SCCVT,SCCLN,SCSC,SCLOG) ;
 ; Create error log entry if add of visit or encounter fails
 ; INPUT:
 ;     DFN     == pt ien
 ;     SCDTM   == encounter date/time
 ;     SCOE    == encounter ien
 ;     SCCVT   == origin of encounter (1-4)
 ;     SCCLN   == ien of clinic
 ;     SCSC    == stop code ien
 ;     SCLOG   == ien of request log [optional]
 N SCE,SCERRIP,SCERRMSG,Y
 S SCERRIP(1)=$G(SCSC)
 S SCERRIP(2)=$P($G(^DPT(DFN,0)),U)
 S Y=SCDTM D D^DIQ S SCERRIP(3)=Y
 S SCERRIP(4)=$P($G(^SC(SCCLN,0)),U)
 S SCERRIP(5)=$S('SCOE:"Outpatient encounter",1:"Visit")
 S SCERRIP(6)=$P("appointment^add/edit^disposition^credit stop",U,SCCVT)
 S SCE("DFN")=DFN,SCE("ENC")=$G(SCOE),SCE("VSIT")="",SCE("DATE")=SCDTM
 D GETERR(4049005.004,.SCE,.SCERRIP,$G(SCLOG),0,.SCERRMSG)
 Q
 ;
