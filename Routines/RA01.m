RA01 ;HCIOFO/SG - RADIOLOGY/NUCLEAR MEDICINE (VARIABLES) ; 2/27/08 10:11am
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 ; RAERROR ------------- ERROR HANDLING DATA
 ;
 ; RAERROR(
 ;
 ;   "ES",               Error stack. If the error stack is enabled
 ;                       (see CLEAR^RAERR), this node is defined and
 ;                       not zero.
 ;     Index,
 ;       0)              Error Descriptor (see ^RAERR for details)
 ;                         ^01: Error code
 ;                         ^02: Error message
 ;                         ^03: Error location
 ;                         ^04: Type ("I" - information,
 ;                              "W" - warning, "E" - error)
 ;       1,Seq#)         Error details text (optional)
 ;
 ; RAPARAMS ------------ PACKAGE-WIDE API PARAMETERS
 ;
 ; RAPARAMS(
 ;
 ;   "DEBUG")            Debug mode
 ;                         0  Disabled (default; undefined actually)
 ;                         1  Silent debug mode
 ;                         2  Debug mode
 ;
 ;   "KIDS")             This node should be defined and non-zero only
 ;                       during the KIDS pre/post-install process:
 ;                         1  Pre-install
 ;                         2  Post-install
 ;
 ;                       Some APIs (e.g. ABORTMSG^RAKIDS) inspect this
 ;                       node to adjust their behavior to the KIDS
 ;                       environment.
 ;
 ;   "XTMPLOCK")         This node is defined if the ^XTMP("RALOCK",0)
 ;                       has been updated already (see $$LOCKFM^RALOCK
 ;                       for details).
 ;
 ;   "PAGECTRL")         Flags that control the $$PAGE^RAUTL22:
 ;
 ;                         E  Force ",UTIMEOUT," or ",UCANCEL,"
 ;                            run-time errors instead of returning
 ;                            error codes (-2 or -1 respectively).
 ;
 Q
