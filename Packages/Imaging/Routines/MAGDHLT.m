MAGDHLT ;WOIFO/MLH/PMK - IHE-based ADT interface for PACS - trigger event vectors ;16 Mar 2017 11:15 AM
 ;;3.0;IMAGING;**49,183**;Mar 19, 2002;Build 11;Apr 07, 2011
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
 ;
A01(XDFN,XOCCURRED) G A01^MAGDHLTA ; patient admission
A02(XDFN,XOCCURRED) G A02^MAGDHLTA ; patient transfer
A03(XDFN,XOCCURRED) G A03^MAGDHLTA ; patient discharge
A08(XDFN,NEWSSN,XOCCURRED) G A08^MAGDHLTA ; patient information update - P183 PMK 3/9/17
A11(XDFN,XDT) G A11^MAGDHLTC ; cancel patient admission
A12(XDFN,XDT) G A12^MAGDHLTC ; cancel patient transfer
A13(XDFN,XDT) G A13^MAGDHLTC ; cancel patient discharge
A40 Q  ;G A40^MAGDHLTM ; patient ID list merge - not now used
A47(XDFN,OLDSSN,NEWSSN,XOCCURRED) G A47^MAGDHLTA ; change patient identifier list - P183 PMK 3/9/17
