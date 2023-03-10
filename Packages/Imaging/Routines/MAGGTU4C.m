MAGGTU4C ;WOIFO/GEK/SG/NST/JSL/DAC/JSJ - VERSION CONTROL (CLINICAL CAPTURE) ; May 20, 2022@10:13:54
 ;;3.0;IMAGING;**93,94,106,117,122,129,140,151,178,189,211,215,223,233,226,264,267,321**;Mar 19, 2002;Build 27
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
 ; to the Clinical Capture application. DO NOT ADD ANYTHING ELSE!
 Q
 ;
 ;
CLVERCT ;***** VERSION CONTROL TABLE FOR THE CLINICAL CAPTURE CLIENTS
 ;;==================================================================
 ;;| Version |Build|Seq #|                Comment                   |
 ;;|---------+-----+------------------------------------------------|
 ;;| 3.0.321 |   2 |  ?? | Apr 2022                                 |
 ;;| 3.0.267 |   2 |  86 | Apr 2021                                 |
 ;;| 3.0.264 |   1 |  85 | Jul 2020                                 |
 ;;==================================================================
 ;
 ; Each row of the version control table contains the version and
 ; build number of a supported client. Released patches must also
 ; indicate the sequential numbers.
 ; Sort order of the rows does not matter. However, the reversed
 ; order of patch sequential numbers is recommended.
 ; NOTE:
 ;  Patch 321 removed support for
 ;     3.0.226 |   2 |  84 | Sep 2019                                 |
 ;  Patch 267 removed support for
 ;     3.0.251 |   3 |  86 | Dec 2020
 ;  Patch 251 removed support for (deleted patch)
 ;     3.0.223 |   1 |  82 | Oct 2018
 ;  Patch 226 removed support for
 ;     3.0.215 |   1 |  81 | Jun 2018
 ;     3.0.211 |   1 |  80 | Jun 2018
 ;     3.0.189 |   2 |  79 | Sep 2017
 ;     3.0.178 |   3 |  78 | May 2017
 ;     3.0.151 |   7 |  75 | Jan 2017
 ;  Patch 223 did not remove support for any older clients.
 ;  Patch 215 did not remove support for any older clients.
 ;  Patch 211 removed Support for
 ;     3.0.140 |  21 |  70 | Sep 2013
 ;     3.0.129 |  18 |  60 | Apr 2013
 ;  Patch 189  
 ;       Did not Remove Support for any previous version
 ;  Patch 178  removed support for
 ;       - 3.0.122
 ;  Patch 151  removed support for
 ;       - 3.0.117
 ;       - 3.0.106 
 ;       - 3.0.94  
 ;
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
