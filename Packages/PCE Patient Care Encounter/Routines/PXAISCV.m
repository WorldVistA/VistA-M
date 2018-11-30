PXAISCV ;SLC/PKR - Validate Standard Code entry. ;04/12/2018
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 244
 ;
ERRSET ;Set the rest of the error data.
 S STOP=1
 S PXAERRF=1
 S PXAERR(7)="STD CODES"
 S PXADI("DIALOG")=8390001.001
 Q
 ;
VAL ;Validate the input data.
 I $G(PXAA("CODE"))="" D  Q
 . S PXAERR(9)="CODE"
 . S PXAERR(12)="The Code is missing."
 . D ERRSET
 ;
 I $G(PXAA("CODING SYSTEM"))="" D  Q
 . S PXAERR(9)="CODING SYSTEM"
 . S PXAERR(12)="The Coding System is missing."
 . D ERRSET
 ;
 ;If this is a deletion no further verification is required.
 I $G(PXAA("DELETE"))=1 Q
 ;
 ;Is the coding system valid?
 N CODESYSL
 D CODESYSL^PXLEX(.CODESYSL)
 I '$D(CODESYSL(PXAA("CODING SYSTEM"))) D  Q
 . S PXAERR(9)="CODING SYSTEM"
 . S PXAERR(12)="The "_PXAA("CODING SYSTEM")_" coding system is not supported for V STANDARD CODES."
 . D ERRSET
 ;
 ;Is the coding system, code pair valid?
 I '$$VCODE^PXLEX(PXAA("CODING SYSTEM"),PXAA("CODE")) D  Q
 . S PXAERR(9)="CODING SYSTEM"
 . S PXAERR(11)=PXAA("CODING SYSTEM")_U_PXAA("CODE")
 . S PXAERR(12)="Invalid code for the coding system."
 . D ERRSET
 ;
 ;If Event D/T is input verify it is a valid FileMan date and not in
 ;the future.
 I $G(PXAA("EVENT D/T"))'="",'$$EVENTDT^PXAIVAL(PXAA("EVENT D/T"),"T",.PXAERR) D  Q
 . D ERRSET
 ;
 ;Is the code active on the date of interest?
 N EVENTDT
 S EVENTDT=$G(PXAA("EVENT D/T"))
 I EVENTDT="" S EVENTDT=$P(^AUPNVSIT(PXAVISIT,0),U,1)
 I '$$ISCACT^PXLEX(PXAA("CODING SYSTEM"),PXAA("CODE"),EVENTDT) D  Q
 . S PXAERR(9)="CODE NOT ACTIVE"
 . S PXAERR(11)=PXAA("CODING SYSTEM")_U_PXAA("CODE")_U_EVENTDT
 . S PXAERR(12)="The code was not active on "_$$FMTE^XLFDT(EVENTDT,"5Z")_"."
 . D ERRSET
 ;
 ;If a Comment is passed verify it.
 I $G(PXAA("COMMENT"))'="",'$$TEXT^PXAIVAL("COMMENT",PXAA("COMMENT"),1,245,.PXAERR) D  Q
 . D ERRSET
 ;
 ;If an Ordering Provider is passed verify it is valid.
 I $G(PXAA("ORD PROVIDER"))'="",'$$PRV^PXAIVAL(PXAA("ORD PROVIDER"),"ORD",.PXAA,.PXAERR,PXAVISIT) D  Q
 . D ERRSET
 ;
 ;If an Encounter Provider is passed verify it is valid.
 I $G(PXAA("ENC PROVIDER"))'="",'$$PRV^PXAIVAL(PXAA("ENC PROVIDER"),"ENC",.PXAA,.PXAERR,PXAVISIT) D  Q
 . D ERRSET
 ;
 ;If a Magnitude is being input verify that it is in the allowed range.
 N MPARAMS
 S MPARAMS=-99999999999999_U_99999999999999
 I $G(PXAA("MAGNITUDE"))'="",'$$MAG^PXAIVAL(PXAA("MAGNITUDE"),MPARAMS,.PXAERR) D  Q
 . D ERRSET
 ;
 ;If a UCUM code is being input verify that it is valid.
 I $G(PXAA("UCUM CODE"))'="" D
 . N UCUMCODE
 . S UCUMCODE=$$UCUMCODE^LEXMUCUM(PXAA("UCUM CODE"))
 . I UCUMCODE["unit not defined" D
 .. S PXAERR(9)="UCUM CODE"
 .. S PXAERR(11)=PXAA("UCUM CODE")
 .. S PXAERR(12)=$P(UCUMCODE,U,2)
 .. D ERRSET
 I $G(STOP)=1 Q
 ;
 ;If PKG is input verify it.
 I $G(PXAA("PKG"))'="" D
 . N PKG
 . S PKG=$$VPKG^PXAIVAL(PXAA("PKG"),.PXAERR)
 . I PKG=0 S PXAERR(9)="PKG" D ERRSET Q
 . S PXAA("PKG")=PKG
 I $G(STOP)=1 Q
 ;
 ;If SOURCE is input verify it.
 I $G(PXAA("SOURCE"))'="" D
 . N SRC
 . S SRC=$$VSOURCE^PXAIVAL(PXAA("SOURCE"),.PXAERR)
 . I SRC=0 S PXAERR(9)="SOURCE" D ERRSET Q
 . S PXAA("SOURCE")=SRC
 Q 
 ;
