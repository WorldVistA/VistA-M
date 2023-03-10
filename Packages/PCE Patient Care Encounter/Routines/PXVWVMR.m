PXVWVMR ;ISP/LMT - Build VMR Message for input to ICE ;12/13/17  12:23
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**217**;Aug 12, 1996;Build 134
 ;
 ;
 ; Reference to ^PXD(811.9,"B", supported by ICR #3148  ; TODO - subscribe to ICR
 ; Reference to MAINDF^PXRM supported by ICR #2182 ;TODO - subscribe to ICR
 ;
 ;
BLDVMR(DFN) ; Build VMR Message
 ;
 ;Input:
 ;       DFN - Patient (#2) IEN
 ;
 ;Returns:
 ;   Message in ^TMP("PXVWMSG",$J)
 ;
 D BLD^PXVWMSG(DFN,"VMR MESSAGE")
 ;
 Q
 ;
 ;
HASH() ;
 I '$D(^TMP("PXVWMSG",$J)) Q ""
 Q $$GENAREF^XLFSHAN(512,$NA(^TMP("PXVWMSG",$J)),1)
 ;
 ;
GETIMM(PXVARS,DFN) ; get immunizaion history
 ;
 ; Called from Build Logic in #920.77 during template processing.
 ;
 N PXADMINDT,PXCNT,PXCVX,PXDAS,PXDOMAIN,PXVISIT
 ;
 S PXDOMAIN=$$BASE^XLFUTL($$CRC16^XLFCRC($$KSP^XUPARAM("WHERE")),10,16)
 S PXCNT=0
 ;
 S PXCVX=""
 F  S PXCVX=$O(^PXRMINDX(9000010.11,"CVX","PI",DFN,PXCVX)) Q:PXCVX=""  D
 . S PXADMINDT=0
 . F  S PXADMINDT=$O(^PXRMINDX(9000010.11,"CVX","PI",DFN,PXCVX,PXADMINDT)) Q:PXADMINDT=""  D
 . . S PXDAS=0
 . . F  S PXDAS=$O(^PXRMINDX(9000010.11,"CVX","PI",DFN,PXCVX,PXADMINDT,PXDAS)) Q:'PXDAS  D
 . . . S PXCNT=PXCNT+1
 . . . S PXVARS(PXCNT,"IEN")=PXDAS
 . . . S PXVARS(PXCNT,"IMMUID")="urn:va:immunization:"_PXDOMAIN_":"_DFN_":"_PXDAS
 . . . S PXVARS(PXCNT,"CVX")=PXCVX
 . . . S PXVARS(PXCNT,"ADMINDT")=$E($$FMTHL7^XLFDT(PXADMINDT),1,8)
 ;
 Q PXCNT
 ;
 ;
GETDEM(PXVARS,DFN) ; get demographics
 ;
 ; Called from Build Logic in #920.77 during template processing.
 ;
 N PXDOB,PXSEX,VADM,VAHOW,VAPTYP,VAROOT
 ;
 D DEM^VADPT
 S PXDOB=$P(VADM(3),U,1)
 S PXSEX=$P(VADM(5),U,1)
 ;
 S PXVARS("DOB")=$E($$FMTHL7^XLFDT(PXDOB),1,8)
 S PXVARS("SEX")=PXSEX
 ;
 Q
 ;
 ;
GETREM(PXVARS,DFN,PXREMINDER) ; evaluate reminder
 ;
 ; Called from Build Logic in #920.77 during template processing.
 ;
 ;Input:
 ;     PXVARS - Passed by reference (see output).
 ;        DFN - Patient (#2) IEN
 ; PXREMINDER - Reminder Definition (#811.9) Name
 ;
 ;Returns:
 ;  - The function will return:
 ;     1 - Positive finding
 ;     0 - No positive finding (or reminder definition doesn't exist)
 ;  - PXVARS() array will be populated with values from the finding
 ;    evaluation array (FIEVAL).
 ;
 N PXFIEVAL,PXREMIEN
 ;
 K ^TMP("PXRHM",$J)
 K ^TMP("PXRM",$J)
 ;
 I $G(PXREMINDER)="" Q 0
 S PXREMIEN=$O(^PXD(811.9,"B",PXREMINDER,0)) ;ICR 3148 ; TODO - subscibe to ICR
 I 'PXREMIEN Q 0
 ;
 D MAINDF^PXRM(DFN,PXREMIEN,1,$$NOW^XLFDT)  ;ICR 2182 ; TODO - subscibe to ICR
 ;
 M PXFIEVAL=^TMP("PXRHM",$J,PXREMIEN,"FIEVAL")
 I $G(PXFIEVAL(1))=0!($G(PXFIEVAL(1))="") Q 0  ; no positive findings
 ;
 S PXVARS("DATE")=$E($$FMTHL7^XLFDT($G(PXFIEVAL(1,"DATE"))),1,8)
 ;TODO - Perhaps include other fields for future templating use
 ;
 ; TODO - When later displaing the ICE reccomendations, we might want
 ; to tie it back to these findings; if so, see what GPL did in this regard.
 ;
 K ^TMP("PXRHM",$J)
 K ^TMP("PXRM",$J)
 ;
 Q 1
 ;
 ;
TESTVMR ; Build Test VMR Message
 ;
 ;Returns:
 ;   Message in ^TMP("PXVWMSG",$J)
 ;
 D BLD^PXVWMSG("","TEST VMR MESSAGE")
 ;
 Q
 ;
