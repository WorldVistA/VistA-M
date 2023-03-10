MAGGTU4T ;WOIFO/SG/NST/JSL/DAC/JSJ - VERSION CONTROL (TELEREADER) ; Oct 25, 2022@05:31:49
 ;;3.0;IMAGING;**93,94,106,117,122,127,182,219,242,281,292,320,328**;Mar 19, 2002;Build 5
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
 ; This routine contains the version control code and data specific
 ; to the TeleReader application. DO NOT ADD ANYTHING ELSE!
 Q
 ;
CLVERCT ;***** VERSION CONTROL TABLE FOR THE TELEREADER CLIENTS
 ;;==================================================================
 ;;| Version |Build|Seq # |                Comment                  |
 ;;|---------+-----+------------------------------------------------|
 ;;| 3.0.328 |   1 |  ??  | Nov 2022                                |
 ;;| 3.0.320 |   2 |  66  | Aug 2022                                |
 ;;| 3.0.292 |   3 |  65  | Apr 2022                                |
 ;;==================================================================
 ;
 ; Each row of the version control table contains the version and
 ; build number of a supported client. Released patches must also
 ; indicate the sequential numbers.
 ;
 ; Sort order of the rows does not matter. However, the reversed
 ; order of patch sequential numbers is recommended.
 ;
 ; NOTE:
 ;  Patch 328 removed support for
 ;        - Patch 281
 ;  Patch 320 removed support for
 ;        - Patch 242
 ;  Patch 292 removed support for
 ;        - Patch 219
 ;  Patch 281 removed support for
 ;        - Patch 182
 ;  Patch 242 removed support for
 ;        - Patch 127
 ;  Patch 219 did not remove support for any clients.
 ;  Patch 182 removed support for 
 ;        - Patch 122
 ;        - Patch 117
 ;        - Patch 106
 ;        - Patch  94 
 Q
 ;
 ;***** ADDS A CLIENT-SPECIFIC WARNING (IF NECESSARY)
 ;
 ; .MAGBUF       Reference to a local array that the warning text
 ;               is returned to. It is appended to the RPC result
 ;               array by the caller (WARNING^MAGGTU41).
 ;
 ; CLVER         Client application version (Major.Minor.Patch.Build)
 ;
 ; CVRC          Version check code returned by the $$CHKVER1^MAGGTU41
 ;
 ; Notes
 ; =====
 ;
 ; If the RPC result array already contains an error message that
 ; will terminate the client, application, this procedure is not
 ; called.
 ;
WARNING(MAGBUF,CLVER,CVRC) ;
 Q
