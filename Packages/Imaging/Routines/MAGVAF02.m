MAGVAF02 ;WOIFO/NST - Utilities for RPC calls ; 13 Feb 2012 4:16 PM
 ;;3.0;IMAGING;**118**;Mar 19, 2002;Build 4525;May 01, 2013
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
OK() Q 0   ; Success status
 ;
FAILED() Q -1   ; Failure status
 ;
RESDEL() Q "^"  ; Result delimiter
 ;
RESDATA() Q 3  ; Returns the piece number where the result data value is stored in MAGRY
 ;
ISOK(MAGRY) ; Returns 0 (failed) or 1 (success): Checks if first piece of MAGRY is success
 Q +MAGRY=$$OK^MAGVAF02()
 ;
GETVAL(MAGRY) ; Returns data value in MAGRY
 Q $P(MAGRY,$$RESDEL^MAGVAF02(),$$RESDATA^MAGVAF02())
 ;
SETVAL(MAGRY,VAL) ; Set VAL in MAGRY data piece
 S $P(MAGRY,$$RESDEL^MAGVAF02(),$$RESDATA^MAGVAF02())=VAL
 Q
 ;
XML1LINE() ; Returns the first line in XML formatted RPCs output
 Q "<?xml version=""1.0"" encoding=""utf-8""?>"
 ;
SETOKVAL(MAGRY,VAL) ; Sets data value in MAGRY and set OK status
 S MAGRY=$$OK^MAGVAF02()
 S $P(MAGRY,$$RESDEL^MAGVAF02(),$$RESDATA^MAGVAF02())=VAL
 Q
