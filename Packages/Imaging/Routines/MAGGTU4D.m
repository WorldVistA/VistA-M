MAGGTU4D ;WOIFO/SG/NST/JSL/GEK - VERSION CONTROL (CLINICAL DISPLAY) ; 25 May 2014  2:24 PM
 ;;3.0;IMAGING;**93,94,106,117,122,131,149,138,156,161,167,181,191,188**;Mar 19, 2002;Build 61;Mar 18, 2018
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
 ; to the Clinical Display application. DO NOT ADD ANYTHING ELSE!
 Q
 ;
CLVERCT ;***** VERSION CONTROL TABLE FOR THE CLINICAL DISPLAY CLIENTS
 ;;==================================================================
 ;;| Version |Build|Seq #|                Comment                   |
 ;;|---------+-----+------------------------------------------------|
 ;;| 3.0.188 |   6 |  89 | Mar 2018                                 |
 ;;| 3.0.191 |   2 |  88 | Aug 2017                                 |
 ;;| 3.0.181 |   3 |  87 | Jun 2017                                 |
 ;;| 3.0.167 |   8 |  86 | Jan 2017                                 |
 ;;| 3.0.161 |   2 |  85 | May 2015                                 |
 ;;| 3.0.149 |   4 |  75 | Sep 2014                                 |
 ;;| 3.0.130 |  18 |  70 | Aug 2013                                 |
 ;;==================================================================
 ;
 ; Each row of the version control table contains the version and
 ; build number of a supported client. Released patches must also
 ; indicate the sequential numbers.
 ;
 ; Sort order of the rows does not matter. However, the reversed
 ; order of patch sequential numbers is recommended.
 ; NOTE:
 ;  Patch 188 Did not remove support for any Clients
 ; 
 ;  Patch 191 Emergency Patch did not remove support for any clients
 ;  Patch 181 removed support for
 ;        - Patch 131  
 ;  Patch 167 removed support for
 ;        - Patch 122
 ;  Patch 149 removed support for 
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
 ;               Text must be stored at nodes with positive numbers
 ;               or at the 0-node descendent from those nodes.
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
