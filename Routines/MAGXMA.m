MAGXMA ;WOIFO/MLH - Index mapping API routine ; 14 Jan 2004  2:19 PM
 ;;3.0;IMAGING;**11**;14-April-2004
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
FIELD43(XMOD,XSPEC,XPROC) ; API - Determine proc/event based on modality, specialty
 ;
 ; Input parameters:
 ;   XMOD      Abbreviation for the modality in use (required)
 ;   XSPEC     Specialty index in the IMAGE INDEX FOR SPEC/SUBSPEC File
 ;             (#2005.84).  This is what will be populated into the
 ;             SPEC/SUBSPEC Field (#44) of the IMAGE File (#2005).
 ;
 ; Output parameter:
 ;   .XPROC    Associated procedure/event index in the IMAGE INDEX FOR
 ;             PROC/EVENT File (#2005.85).  This can be populated into
 ;             the PROC/EVENT Field (#43) of the IMAGE File (#2005).
 ;             If no procedure/event is associated, null is returned unless
 ;             the function returns an exception code < 0.
 ;
 ; Function return:
 ;    0        Executed normally, found a match
 ;    1        Modality XMOD non-null but is not indexed
 ;   -1        Missing XMOD
 ;   -2        XSPEC non-null, not found in File #2005.84
 ;
 I $G(XMOD)="" Q -1
 I $G(XSPEC),'$D(^MAG(2005.84,XSPEC)) Q -2
 ;
 N IMOD ; ---- modality pointer in 2005.872
 N ISPEC ; --- specialty multiple pointer in 2005.872
 S XPROC=""
 ;
 S IMOD=$O(^MAG(2005.872,"B",XMOD,""))
 I 'IMOD Q 1
 I XSPEC]"" S ISPEC=$O(^MAG(2005.872,IMOD,1,"B",XSPEC,"")) I ISPEC S XPROC=$P(^MAG(2005.872,IMOD,1,ISPEC,0),U,2)
 E  S XPROC=$P(^MAG(2005.872,IMOD,0),U,2)
 Q 0
