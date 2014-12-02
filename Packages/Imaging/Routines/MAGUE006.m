MAGUE006 ;WOIFO/MLH - IMAGING - utilities - ICN lookup ; 19-Jul-2013 3:44 PM
 ;;3.0;IMAGING;**138**;Mar 19, 2002;Build 5380;Sep 03, 2013
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q  ;
 ;
 ;+++++ GET ICN GIVEN DFN
 ;
 ; MAGDFN        DFN of patient (internal entry number on PATIENT file (#2) )
 ; 
 ; DELIM         (optional) single punctuation character (e.g., comma (,))
 ;               to which to change the up-arrow (^) delimiter returned
 ;               by $$GETICN^MPIF001
 ;               
 ; SUPPRESS      (optional) set nonzero if error text only (no code) is desired
 ; 
 ; RETURN VALUES
 ; =============
 ; 
 ; OUTPUT        Description
 ;                 ^01: -97 if invalid DELIM;
 ;                       else -98 if MAGDFN parameter missing;
 ;                       else -99 if no ICN (e.g., IHS);
 ;                       else -1 if ICN fetch raises exception;
 ;                       else ICN value
 ;                 ^02: "INVALID DELIMITER VALUE" if invalid DELIM;
 ;                       else "MAGDFN PARAMETER MISSING" if MAGDFN parameter missing;
 ;                       else "ICN NOT USED" if no ICN (e.g., IHS);
 ;                       else error message if ICN fetch raises exception;
 ;                       else empty
 ;                      
 ;                 Note:  on exception, ^02 -> ^01 if code suppressed     
 ;                 
GETICN(MAGDFN,DELIM,SUPPRESS) ;
 N OUTPUT
 D  ; is ICN used / defined?
 . I $D(DELIM)#10,DELIM'?1ANP D  Q
 . . S OUTPUT="-97^INVALID DELIMITER VALUE"
 . . Q
 . I $D(MAGDFN)#10=0 D  Q
 . . S OUTPUT="-98^MAGDFN PARAMETER MISSING"
 . . Q
 . I $T(GETICN^MPIF001)="" D  Q
 . . S OUTPUT="-99^ICN NOT USED"
 . . Q
 . S OUTPUT=$$GETICN^MPIF001(MAGDFN) ; Supported IA #2701
 . S:OUTPUT="" OUTPUT="-1^ICN UNDEFINED"
 . Q
 I $D(DELIM)#10,DELIM?1ANP S OUTPUT=$TR(OUTPUT,"^",DELIM)
 I $G(SUPPRESS),OUTPUT["^" S OUTPUT=$P(OUTPUT,"^",2)
 Q $G(OUTPUT)
 ;
 ; MAGUE006
