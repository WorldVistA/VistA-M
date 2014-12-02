MAGVRS45 ;WOIFO/DAC,MLH - Utilities for RPC calls for DICOM file processing ; 19 Jan 2012 04:41 PM
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
INPUTSEP() ; Name value separator for input data  ie. NAME`TESTPATIENT
 Q "`"
OUTSEP() ; Name value separator for output data ie. NAME|TESTPATIENT
 Q "|"
STATSEP() ; Status and Result separator ie. -3``No record IEN  
 Q "`"
TRAVERSE(OUT,PFILENUM,IEN,DIR,CHILDIEN) ;utility - traverse a file
 N OSEP,ISEP,SSEP,RETIEN,FILE,STATFIELD,ACTIVE
 S OSEP=$$OUTSEP,ISEP=$$INPUTSEP,SSEP=$$STATSEP
 I "^0^1^2^3^4^"'[("^"_(PFILENUM-2005.6*100)_"^") D  Q
 . S OUT(1)="-1"_SSEP_"Invalid file"
 . Q
 I ($G(IEN)'=+$G(IEN))!'IEN D  Q
 . S OUT(1)="-2"_SSEP_"Invalid root IEN"
 . Q
 I '$D(^MAGV(PFILENUM,IEN)) D  Q
 . S OUT(1)="-7"_SSEP_"IEN "_IEN_" not found in file "_PFILENUM
 . Q
 I ".FIRST.PREV.NEXT.LAST."'[("."_$TR(DIR,".")_".") D  Q
 . S OUT(1)="-3"_SSEP_"Invalid direction"
 . Q
 I DIR'="PREV",DIR'="NEXT",$G(CHILDIEN) D  Q
 . S OUT(1)="-4"_SSEP_"Child IEN not to be specified in command "_DIR
 . Q
 I DIR'="FIRST",DIR'="LAST",($G(CHILDIEN)'=+$G(CHILDIEN))!'$G(CHILDIEN) D  Q
 . S OUT(1)="-5"_SSEP_"Invalid child IEN in command "_DIR
 . Q
 I $$GET1^DIQ(PFILENUM,IEN,$$GETFIELD^MAGVRS41(PFILENUM,"STATUS"),"I")'="A" D  Q
 . S OUT(1)="-6"_SSEP_"Can't traverse children of inaccessible parent IEN "_IEN
 . Q
 S FILE=PFILENUM+.01
 I DIR'="FIRST",DIR'="LAST",'$D(^MAGV(FILE,"C",IEN,CHILDIEN)) D  Q
 . S OUT(1)="-8"_SSEP_"Invalid child IEN in command "_DIR
 . Q
 S:DIR="FIRST" DIR="NEXT",CHILDIEN=""
 S:DIR="LAST" DIR="PREV",CHILDIEN=""
 S STATFIELD=$$GETFIELD^MAGVRS41(FILE,"STATUS")
 S RETIEN=CHILDIEN,ACTIVE=0
 F  S RETIEN=$O(^MAGV(FILE,"C",IEN,RETIEN),$S(DIR="PREV":-1,1:1)) Q:'RETIEN  D  Q:ACTIVE
 . S ACTIVE=($$GET1^DIQ(FILE,RETIEN,STATFIELD,"I")="A")
 . Q
 S:RETIEN="" RETIEN=0
 S OUT(1)="0"_SSEP_SSEP_RETIEN
 Q
