MAGJTU4V ;WOIFO/MAT,DAC,GXT - VERSION CONTROL (VISTARAD) ; Apr 29, 2020@22:26:55
 ;;3.0;IMAGING;**90,115,120,133,152,153,184,199,255**;Mar 19, 2002;Build 5
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
 ; to the VistARad application. DO NOT ADD ANYTHING ELSE!
 Q
 ;
CLVERCT ;***** VERSION CONTROL TABLE FOR THE VistARad CLIENTS
 ;;==================================================================
 ;;| Version |Build|Seq #|                Comment                   |
 ;;|---------+-----+------------------------------------------------|
 ;;| 3.0.255 |   1 | ??  | Jun 2020  <*> Projected Seq # & Release  |
 ;;| 3.0.199 |   2 | 159 | Mar 2018                                 |
 ;;| 3.0.184 |   2 | 135 | Jun 2017                                 |
 ;;==================================================================
 ;
 ; Each row of the version control table contains the version and
 ; build number of a supported client. Released patches must also
 ; indicate the sequential numbers.
 ;
 ; Sort order of the rows does not matter. However, the reversed
 ; order of patch sequential numbers is recommended.
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
