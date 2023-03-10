GMTSORPD ; ISP/LMT - CPRS PDMP component ;Apr 02, 2020@08:27:12
 ;;2.7;Health Summary;**134**;Oct 20, 1995;Build 25
 ;
 ; This routine uses the following ICRs:
 ;   7144 - EN^ORPDMPHS   (controlled)
 ;
PDMPAODX ; PDMP Accounting of disclosure report when no note was created
 ;
 D PDMPAOD("X")
 ;
 Q
 ;
 ;
PDMPAODA ; All PDMP Accounting of disclosure report, including when note was created manually or automatically
 ;
 D PDMPAOD("A")
 ;
 Q
 ;
 ;
PDMPAOD(GMTSSCREEN) ;
 ; GMTSSCREEN = A: All; X: Exception Cases
 ;
 ; ZEXCEPT: DFN,GMTSBEG,GMTSEND,GMTSQIT
 N GMTSDISCTO,GMTSFILTER,GMTSI,GMTSJ,GMTSNODE,GMTSPG1,GMTSQDT,GMTSRSLTS,GMTSUSER,X
 ;
 S GMTSSCREEN=$G(GMTSSCREEN)
 ;
 S GMTSFILTER("STATUS")="EZCXNAM"  ; Return: Everything
 I GMTSSCREEN="X" S GMTSFILTER("STATUS")="EZCXN"  ; Return: Error, Cancelled, and Never Viewed Report
 S GMTSFILTER("DATES")=GMTSBEG_":"_GMTSEND
 S GMTSFILTER("SHARED")=1
 K ^TMP("ORPDMPHS",$J)
 D EN^ORPDMPHS(.GMTSRSLTS,DFN,.GMTSFILTER)  ;ICR 7144
 ;
 I '$O(^TMP("ORPDMPHS",$J,0)) Q  ; No Data
 ;
 S GMTSPG1=1
 D CKP
 I $D(GMTSQIT) Q
 S GMTSPG1=0
 ;
 S GMTSI=0
 F  S GMTSI=$O(^TMP("ORPDMPHS",$J,GMTSI)) Q:'GMTSI!($D(GMTSQIT))  D
 . S GMTSJ=""
 . F  S GMTSJ=$O(^TMP("ORPDMPHS",$J,GMTSI,GMTSJ)) Q:GMTSJ=""!($D(GMTSQIT))  D
 . . S GMTSNODE=$G(^TMP("ORPDMPHS",$J,GMTSI,GMTSJ))
 . . ;
 . . S X=$P(GMTSNODE,U,1)  ;Query D/T
 . . D REGDTM^GMTSU
 . . S GMTSQDT=X
 . . ;
 . . S GMTSUSER=$P(GMTSNODE,U,2)  ; User
 . . S GMTSUSER=$$NAME^XUSER(GMTSUSER,"F")
 . . S GMTSDISCTO=$P(GMTSNODE,U,5)  ; Disclosed To
 . . ;
 . . D CKP
 . . I $D(GMTSQIT) Q
 . . W GMTSQDT,?16,$E(GMTSUSER,1,25),?43,GMTSDISCTO,!
 ;
 K ^TMP("ORPDMPHS",$J)
 ;
 Q
 ;
 ;
HDR1 ;
 W !,"Info Disclosed: Patient Demographics"
 W !,"Purpose: Accessing Prescription Drug Monitoring Program (PDMP) databases for"
 W !,"         review of controlled substances prescribed outside of the VA, and any"
 W !,"         additional information that may become available, as an important"
 W !,"         component of standard clinical care and in accordance with VHA policy."
 W !!
 Q
 ;
 ;
HDR ;
 W "Date/Time       User/Author                Disclosed To"
 W !!
 Q
 ;
 ;
CKP ;
 ;
 ; ZEXCEPT: GMTSPG1,GMTSNPG,GMTSQIT
 ;
 D CKP^GMTSUP
 I $D(GMTSQIT) Q
 I GMTSPG1 D HDR1
 I GMTSNPG D HDR
 Q
 ;
 ;
