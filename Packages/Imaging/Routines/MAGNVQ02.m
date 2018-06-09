MAGNVQ02 ;WOIFO/NST - Image query by Context ; 16 Oct 2017 3:59 PM
 ;;3.0;IMAGING;**185**;Mar 19, 2002;Build 4525;May 01, 2013
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
 ;*****  Check for images by context
 ;       
 ; RPC: MAGN IMAGE EXIST BY CONTEXT
 ; 
 ; Input Parameters
 ; ================
 ; 
 ; DATA - Array contexts in format
 ;         e.g. 'RPT^CPRS^29027^RA^79029185.9998-1'
 ;                or
 ;               RPT^CPRS^4658^TIU^2243408^^^^^^^^1
 ;           
 ; Return Values
 ; =============
 ; 
 ; if error MAGRY(0) = 0 ^Error message^
 ; if success MAGRY(0) = 1
 ;            MAGRY(1..n) = CONTEXTID | 0 | error message
 ;                          CONTEXTID | 1 | 0 or 1 (has images)
 ;
IMGEXIST(MAGRY,DATA) ;RPC [MAGN IMAGE EXIST BY CONTEXT]
 N MAGNI,MAGNCNT,MAGNX,RESULT,HASIMAGE
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 K MAGRY
 S MAGRY(0)=0
 S MAGNCNT=0
 S MAGNI=""
 I $G(DATA)'="" S DATA(1)=DATA  ; in case of a single context ID
 F  S MAGNI=$O(DATA(MAGNI)) Q:MAGNI=""  D
 . S MAGNCXT=DATA(MAGNI)  ; contextID
 . I $P(MAGNCXT,"^",1,2)'="RPT^CPRS" D  Q
 . . D SETRES(.MAGRY,.MAGNCNT,MAGNCXT,"0^Unsupported ContextId Type",0)
 . . Q
 . ;
 . S MAGNX=$P(MAGNCXT,"^",4)
 . I MAGNX="RA" D  Q
 . . S HASIMAGE=$$IMAGERA(MAGNCXT)  ; get image list for a single Radiology contextID
 . . D SETRES(.MAGRY,.MAGNCNT,MAGNCXT,1,HASIMAGE)
 . . Q
 . I MAGNX="TIU" D  Q
 . . N MAGNTIU
 . . S MAGNTIU=$P(MAGNCXT,"^",5)
 . . S RESULT=$$IMAGETIU(MAGNTIU)  ; get image list for a single TIU contextID
 . . D SETRES(.MAGRY,.MAGNCNT,MAGNCXT,1,HASIMAGE)
 . . Q
 . D SETRES(.MAGRY,.MAGNCNT,MAGNCXT,"0^Unsupported ContextId Type",0)
 . Q
 S MAGRY(0)=1
 Q
 ;
IMAGERA(DATA) ;A copy from MAGGTRAI
 ;   DATA is in format of Windows message received from CPRS
 ;    example   'RPT^CPRS^29027^RA^i79029185.9998-1'
 N DFN,ENT,INVDTTM,INVDT,INVTM,X,RARPT,ACN
 S DFN=+$P(DATA,U,3)
 S ENT=+$P($P(DATA,U,5),"-",2)
 S INVDTTM=$P($P(DATA,U,5),"-",1)
 S INVDT=$P(INVDTTM,".",1)
 S INVTM=$P(INVDTTM,".",2)
 F  Q:($L(INVDT)<8)  S INVDT=$E(INVDT,2,$L(INVDT))
 S INVDTTM=INVDT_"."_INVTM
 S RARPT=0
 I '$D(^RADPT(DFN,"DT",INVDTTM,"P",ENT,0)) Q "0^INVALID Data : Attempt to access Exam failed."
 S RARPT=$P(^RADPT(DFN,"DT",INVDTTM,"P",ENT,0),U,17)
 I RARPT,($P($G(^RARPT(RARPT,0)),U,2)'=DFN) Q "0^Patient Mismatch. Radiology File"
 ;
 I $P($G(^RARPT(RARPT,2005,0)),U,4) Q 1
 ;
 S ACN=$$ACCNUM^RAAPI(DFN,INVDTTM,ENT)
 I $L(ACN,"-")=3 S ACN=$P(ACN,"-",2,3)
 ;
 S X=$$IMAGVX(ACN,"RAD") ; Check for images in P34 data structure
 Q X
 ;
IMAGVX(ACCN,TYPE) ; Image in P34 data structure by Accession
 N PROCIEN,AOF
 ; Check for images in P34 data structure
 I ACCN="" Q 0
 S PROCIEN=""
 S AOF=0
 F  S PROCIEN=$O(^MAGV(2005.61,"B",ACCN,PROCIEN)) Q:'PROCIEN  D  Q:AOF
 . I TYPE'=$$GET1^DIQ(2005.61,PROCIEN,.03,"I") Q  ; Not the same procedure type
 . S AOF=+$$GET1^DIQ(2005.61,PROCIEN,2,"I")  ; Artifact on file
 . Q
 Q AOF
 ;
IMAGETIU(MAGTIU) ; 
 N ACCN,CONSIX,MAGARR,MAGDFN,MAGMRC
 ;
 S MAGDFN=$$GET1^DIQ(8925,MAGTIU,.02,"I") ;MAGQI 8/22/01
 I 'MAGDFN Q "0^Invalid Patient DFN for Note ID: '"_MAGTIU_"'"
 ;
 D GETILST^TIUSRVPL(.MAGARR,MAGTIU)  ; get Images from old data structure (2005)
 I $D(MAGARR) Q 1
 ;
 D GET1405^TIUSRVR(.MAGMRC,MAGTIU)
 S CONSIX=+MAGMRC
 I (CONSIX'>0)!'(MAGMRC["GMR(123") Q 0
 S ACCN=$$GMRCACN^MAGDFCNV(CONSIX)  ; site-specific accession number
 ;
 S X=$$IMAGVX(ACCN,"CON")
 Q X
 ;
SETRES(MAGRY,MAGNCNT,MAGNCXT,RESULT,HASIMAGE) ; Append result for one context
 S MAGNCNT=MAGNCNT+1
 S MAGRY(MAGNCNT)=MAGNCXT_"|"_RESULT_"|"_HASIMAGE
 Q
