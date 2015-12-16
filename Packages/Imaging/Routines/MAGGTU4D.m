MAGGTU4D ;WOIFO/SG/NST/JSL - VERSION CONTROL (CLINICAL DISPLAY) ; 29 Aug 2013 3:58 PM
 ;;3.0;IMAGING;**93,94,106,117,122,131,149,138,156,161**;Mar 19, 2002;Build 20;Sep 1, 2015
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
 ;;| 3.0.161 |   2 |  85 | OCT 2015                                 | 
 ;;| 3.0.149 |   4 |  75 | Sep 2014                                 |
 ;;| 3.0.130 |  18 |  70 | Aug 2013                                 |
 ;;| 3.0.131 |  21 |  65 | Aug 2013                                 |
 ;;| 3.0.122 |  15 |  55 | Jul 2012                                 |
 ;;==================================================================
 ;
 ; Each row of the version control table contains the version and
 ; build number of a supported client. Released patches must also
 ; indicate the sequential numbers.
 ;
 ; Sort order of the rows does not matter. However, the reversed
 ; order of patch sequential numbers is recommended.
 ; In Patch MAG*3.0*161 we stop support for any Display Client
 ; below Patch 122,  specifically we stop support for :
 ; 3.0.117 |   8 |  45 | Jul 2011
 ; 3.0.106 |  13 |  40 | Feb 2011
 ; 3.0.94  |  12 |  35 | May 2010
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
