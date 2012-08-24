VBECENV ;HOIFO/SAE - VBECS ENVIRONMENT CHECKER; 10/1/2005 ; 10/27/05 10:31am
 ;;1.0;VBECS;;Apr 14, 2005;Build 35
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ;
 ; Integration Agreements:
 ;   References to routine XPDUTL supported by IA 10141
 ;
CHKENV ; Main entry point for environment checker
 ;Input : All variables set by KIDS
 ;Output: Variables required by KIDS to denote success or failure
 ;         of environment check (XPDQUIT and XPDABORT)
 D HDR       ; message to user that environment check is starting
 D PACKAGE   ; check for existence of required packages
 D PATCH     ; check for existence of required patches
 D ROUTINE   ; check for existence of required routines
 D FINALMSG  ; inform user of success or failure of environment check.
 Q
 ;
HDR D BMES^XPDUTL("Environment Check beginning...")
 Q
PACKAGE ; check for existence of required packages for install
 Q:$D(XPDABORT)
 N LINE,VBPKG,VBVERREQ,VBVER
 ;
 I $P($T(PKTXT+1),";",3)]"" D
 . D MES^XPDUTL("   Checking for required packages...")
 ;
 F LINE=1:1:9 D  Q:VBPKG']""!$D(XPDABORT)
 . S VBPKG=$P($T(PKTXT+LINE),";",3)
 . S VBVERREQ=$P($T(PKTXT+LINE),";",4)
 . Q:VBPKG']""!(VBVERREQ']"")
 . S VBVER=+$$VERSION^XPDUTL(VBPKG)
 . I (VBVER=VBVERREQ)!(VBVER>VBVERREQ) D  Q
 .. D MES^XPDUTL("      You have "_VBPKG_" version "_VBVER_" installed.")
 . I (VBVER<VBVERREQ) S XPDABORT=2 D
 .. D MES^XPDUTL("      You do not have "_VBPKG_" version "_VBVERREQ_" installed!")
 Q
PKTXT ;;Package Name;Version;
 ;;;;
 Q
 ;
PATCH ; check for existence of required patches for install
 Q:$D(XPDABORT)
 N LINE,VBPATCH
 ;
 I $P($T(PTXT+1),";",3)]"" D
 . D MES^XPDUTL("   Checking for required patches...")
 ;
 F LINE=1:1:9 D  Q:VBPATCH']""!$D(XPDABORT)
 . S VBPATCH=$P($T(PTXT+LINE),";",3)
 . Q:VBPATCH']""
 . I $$PATCH^XPDUTL(VBPATCH) D  Q
 .. D MES^XPDUTL("      You have patch "_VBPATCH_" installed.")
 . S XPDABORT=2
 . D MES^XPDUTL("      You do not have patch "_VBPATCH_" installed!")
 Q
PTXT ;;Patch designation e.g. OR*3.0*215;
 ;;;
 Q
ROUTINE ; check for existence of required routines for install
 Q:$D(XPDABORT)
 N LINE,VBRTN
 ;
 I $P($T(RTNTXT+1),";",3)]"" D
 . D MES^XPDUTL("   Checking for required routines...")
 ;
 F LINE=1:1:9 D  Q:VBRTN']""!$D(XPDABORT)
 . S VBRTN=$P($T(RTNTXT+LINE),";",3) Q:VBRTN']""
 . S X=VBRTN X ^%ZOSF("TEST") I $T D  Q
 .. D MES^XPDUTL("      You have routine "_VBRTN_" installed.")
 . S XPDABORT=2
 . D MES^XPDUTL("      You do not have routine "_VBRTN_" installed!")
 Q
RTNTXT ;;Routine Name;
 ;;XOBVSKT;
 ;;XOBUM;
 Q
FINALMSG ;
 I '$G(XPDABORT) D
 . D MES^XPDUTL("Environment check successful.  Installation will proceed.")
 I +$G(XPDABORT) D
 . D MES^XPDUTL("Required element missing!")
 . D MES^XPDUTL("**** Environment check failed.  Installation will be aborted. ****")
 D MES^XPDUTL("")  ; pad one blank line
 Q
