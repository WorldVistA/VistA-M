MAGNU003 ;WOIFO/NST - Misc fuctions for image list ; 16 Jan 2018 3:42 AM
 ;;3.0;IMAGING;**185**;Mar 19, 2002;Build 2002;Feb 28, 2011
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
STDINFO(IMGIEN,REFTYPE,REFIEN,MAGNCXT) ; Get study info by image IEN in file #2005 or #2005.1
 ; IMGIEN -- Image IEN
 ; REFTYPE = "RAD", "TIU"
 ; REFIEN  = IEN in respective file of REFTYPE
 ; MAGNCXT  = CPRS Context ID
 ;
 ; Return Study( Image ) info. The code is a copy from MAGSIXG3 
 N X0,X2,X40
 N PKG,TYPE,EVT,SPEC,ORIG,ORIG,CAPTAPP,CLASS
 N IMGNODE,FLTX
 ;
 S IMGNODE=$$NODE^MAGGI11(IMGIEN)  Q:IMGNODE="" 0
 ;
 S X0=$G(@IMGNODE@(0))
 S X2=$G(@IMGNODE@(2))
 S X40=$G(@IMGNODE@(40))
 ;
 S PKG=$P(X40,U)          ; PACKAGE INDEX (40)
 S TYPE=$P(X40,U,3)       ; TYPE INDEX (42)
 S EVT=$P(X40,U,4)        ; PROC/EVENT INDEX (43)
 S SPEC=$P(X40,U,5)       ; SPEC/SUBSPEC INDEX (44)
 S ORIG=$P(X40,U,6)       ; ORIGIN INDEX (45)
 S:ORIG="" ORIG="V"       ; Show VA by default
 S CAPTAPP=$P(X2,U,12)    ; CAPTURE APPLICATION (8.1)
 ;
 S CLASS=$S(TYPE:$P($G(^MAG(2005.83,+TYPE,0)),U,2),1:"")
 ;
 S FLTX=""
 S $P(FLTX,U,3)=$$RPTITLE^MAGSIXG3($P(X2,U,6),$P(X2,U,7))     ; Report title
 S $P(FLTX,U,4)=$$DTE^MAGSIXG3($P(X2,U,5))                    ; Procedure date
 S $P(FLTX,U,5)=$P(X0,U,8)                           ; Procedure
 S $P(FLTX,U,7)=$P(X2,U,4)                           ; Short descr.
 S $P(FLTX,U,8)=PKG                                  ; Package
 S $P(FLTX,U,9)=$P($G(^MAG(2005.82,+CLASS,0)),U)     ; Class
 S $P(FLTX,U,10)=$P($G(^MAG(2005.83,+TYPE,0)),U)     ; Type
 S $P(FLTX,U,11)=$P($G(^MAG(2005.84,+SPEC,0)),U)     ; (Sub)Specialty
 S $P(FLTX,U,12)=$P($G(^MAG(2005.85,+EVT,0)),U)      ; Proc/Event
 S $P(FLTX,U,13)=$$EXTERNAL^DILFD(2005,45,,ORIG)     ; Origin
 S $P(FLTX,U,14)=$$DTE^MAGSIXG3($P(X2,U))            ; Capture date
 S $P(FLTX,U,15)=$$GET1^DIQ(200,+$P(X2,U,2)_",",.01) ; Captured by
 S $P(FLTX,U,16)=IMGIEN                              ; Image IEN
 S $P(FLTX,U,20)=$$ACCNUM(REFTYPE,REFIEN,MAGNCXT)    ; Accession Number 
 Q FLTX_"|"_REFTYPE_"-"_REFIEN_"|"_$S(MAGNCXT'="":MAGNCXT,1:$$CPRSCTX(REFTYPE,REFIEN))
 ;
INSFIMG(DATA,MAGNCNT,OUT) ; Append First Image Info from 2005 image structure 
 N IMGGRP,IMGIEN
 S IMGGRP=$P(DATA,"|",2)
 S IMGIEN=$P(DATA,"|",4)
 S MAGNCNT=MAGNCNT+1,@OUT@(MAGNCNT)="NEXT_SERIES"
 S MAGNCNT=MAGNCNT+1,@OUT@(MAGNCNT)="SERIES_IEN|"_IMGGRP
 S MAGNCNT=MAGNCNT+1,@OUT@(MAGNCNT)="SERIES_NUMBER|1"
 S MAGNCNT=MAGNCNT+1,@OUT@(MAGNCNT)="NEXT_IMAGE"
 S MAGNCNT=MAGNCNT+1,@OUT@(MAGNCNT)="IMAGE_IEN|"_IMGIEN
 S MAGNCNT=MAGNCNT+1,@OUT@(MAGNCNT)="GROUP_IEN|"_IMGGRP
 S MAGNCNT=MAGNCNT+1,@OUT@(MAGNCNT)="IMAGE_INFO|"_"^"_$$INFO^MAGGAII(IMGIEN,"E")
 Q
 ;
ACCNUM(REFTYPE,REFIEN,MAGNCXT)  ; Accession Number
 I REFTYPE="TIU" Q $$ACNTIU(REFIEN)
 I REFTYPE="RAD" Q $$ACNRAD(REFIEN,MAGNCXT)
 Q ""
 ;
ACNRAD(RARPT,MAGNCXT) ; Get Accession number by RAD report IEN
 N ACN,DFN,ENT,INVDTTM,INVDT,INVTM
 I RARPT D  Q ACN
 . S ACN=$P($G(^RARPT(RARPT,0)),"^") ; IA # 1171    ; Get Radiology Accession number
 . Q
 ;
 I MAGNCXT="" Q ""
 ;
 ; Report is not defined
 S DFN=+$P(MAGNCXT,U,3)
 S ENT=+$P($P(MAGNCXT,U,5),"-",2)
 S INVDTTM=$P($P(MAGNCXT,U,5),"-",1)
 S INVDT=$P(INVDTTM,".",1)
 S INVTM=$P(INVDTTM,".",2)
 F  Q:($L(INVDT)<8)  S INVDT=$E(INVDT,2,$L(INVDT))
 S INVDTTM=INVDT_"."_INVTM
 S ACN=$$ACCNUM^RAAPI(DFN,INVDTTM,ENT)
 I $L(ACN,"-")=3 S ACN=$P(ACN,"-",2,3)
 Q ACN
 ;
ACNTIU(MAGTIUDA) ; Get Accession number by TIU Note IEN
 N MAGMRC,IEN
 ;
 D GET1405^TIUSRVR(.MAGMRC,MAGTIUDA)
 S IEN=+MAGMRC
 I (IEN'>0)!'(MAGMRC["GMR(123") Q ""
 Q $$GMRCACN^MAGDFCNV(IEN)  ; site-specific accession number
 ;
CPRSCTX(REFTYPE,REFIEN)  ; Create CPRS Context ID
 ; REFTYPE = "RAD", "TIU"
 ; REFIEN  = IEN in respective file of REFTYPE
 ;
 N CTXID
 I REFTYPE="TIU" D  Q CTXID
 . S CTXID=$$TIUCPRS(REFIEN)
 . Q
 ;
 I REFTYPE="RAD" D  Q CTXID
 . S CTXID=$$RACPRS(REFIEN)
 . Q
 ;
 Q ""
 ;
REFBYACN(REFTYPE,REFIEN,ACNUMB) ; Get report by accession number
 N GMRCIEN,IEN,LST
 S (REFTYPE,REFIEN)=""
 ;
 I ACNUMB="" Q
 S IEN=$O(^MAGV(2005.62,"D",ACNUMB,""))
 I IEN'>0 Q
 S REFTYPE=$$GET1^DIQ(2005.62,IEN,"11:.03","I")  ; Get procedure type (RAD, CON, etc)
 ;
 I REFTYPE="RAD" D  Q
 . N I,DFN,INVDT,ENT
 . D ACCFIND^RAAPI(ACNUMB,.LST) ; IA 5020
 . S I=$O(LST(""))
 . Q:I'>0
 . S DFN=$P(LST(I),"^")
 . S INVDT=$P(LST(I),"^",2)
 . S ENT=$P(LST(I),"^",3)
 . S REFIEN=$P(^RADPT(DFN,"DT",INVDT,"P",ENT,0),U,17)
 . Q
 ;
 I REFTYPE="CON" D  Q
 . S REFTYPE="TIU"
 . S GMRCIEN=$$GMRCIEN(ACNUMB)
 . Q:GMRCIEN'>0  ; invalid IEN
 . D GETDOCS^TIUSRVLR(.LST,GMRCIEN_";GMR(123,") ; IA 3536
 . S REFIEN=$P($G(@LST@(1)),"^")
 . Q
 Q
 ;
GMRCIEN(ACNUMB) ; return the GMRC IEN, given a consult/procedure accession number
 ; ACNUMB is the accession number for a consult/procedure request
 ; OLD Format: GMRC-<gmrcien>, where <gmrcien>is the internal entry number of the request
 ; New Format: <sss>-GMR-<gmrcien>, where <sss> is station number, and <gmrcien>
 ;             is the internal entry number of the request, up to 8 digits (100 million)
 N GMRCIEN ; CPRS Consult Request Tracking GMRC IEN - REQUEST/CONSULTATION file(#123)
 S GMRCIEN=""
 I ACNUMB?1"GMRC-"1N.N S GMRCIEN=$P(ACNUMB,"-",2) ; return the second piece
 E  I ACNUMB?1N.N1"-GMR-"1N.N S:$P(ACNUMB,"-",1)=$$STATNUMB^MAGDFCNV() GMRCIEN=$P(ACNUMB,"-",3) ; return the third piece
 ;
 Q GMRCIEN
 ;
RACPRS(REFIEN) ; Return Radiology CRPS context by Report IEN in file #74
 ; REFIEN - Radiology report IEN in file #74
 I REFIEN'>0 Q ""
 N DAYCASE,CASE,DATETIME,INVDAT,ENT,CONTEXT
 S DAYCASE=$$GET1^DIQ(74,REFIEN,.01)
 S DFN=$$GET1^DIQ(74,REFIEN,2,"I")
 S DATETIME=$$GET1^DIQ(74,REFIEN,3,"I")
 S INVDAT=9999999.9999-DATETIME
 S CASE=$$GET1^DIQ(74,REFIEN,4)
 S ENT=$O(^RADPT("ADC1",DAYCASE,DFN,INVDAT,""))
 I 'ENT S ENT=$O(^RADPT("ADC",DAYCASE,DFN,INVDAT,""))
 S CONTEXT="RPT^CPRS^"_DFN_"^RA^i"_INVDAT_"-"_ENT_"^"_CASE
 Q CONTEXT
 ;
TIUCPRS(REFIEN) ; Return TIU CRPS context by TIU note IEN in file #8925
 ; REFIEN - TIU note IEN in file #8925
 I REFIEN'>0 Q ""
 N DFN,CONTEXT
 S DFN=$$GET1^DIQ(8925,REFIEN,.02,"I")
 S CONTEXT="RPT^CPRS^"_DFN_"^TIU^"_REFIEN
 Q CONTEXT
