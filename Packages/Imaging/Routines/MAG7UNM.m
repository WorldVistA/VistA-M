MAG7UNM ;WOIFO/MLH - imaging HL7 utilities - NEW PERSON name retrieval ; 02 Jul 2013 1:10 PM
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
 Q
NPNAME(OUT,IEN) ; fetch/format elements for name from entry IEN in NEW PERSON File (#200)
 N NAMLKUPELTS ; lookup elements for name
 N NAME ; returned name from file 200 lookup
 N X ; scratch status variable return from extrinsic function call
 K OUT S OUT=0 ; refresh return array & status
 I $G(IEN)'?1.N S OUT="-1001`invalid format for NEW PERSON ien ("_IEN_")" Q OUT
 S NAMLKUPELTS("FILE")=200
 S NAMLKUPELTS("IENS")=IEN
 S NAMLKUPELTS("FIELD")=.01
 S OUT=$$HLNAME^XLFNAME(.NAMLKUPELTS)
 S X=$$FMNAME^XLFNAME(.OUT,"C"),OUT=0
 Q OUT
