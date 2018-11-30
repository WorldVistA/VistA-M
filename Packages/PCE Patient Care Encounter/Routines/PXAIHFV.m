PXAIHFV ;ISL/PKR - VALIDATE HEALTH FACTOR DATA ;03/12/2018
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 244
 ;
ERRSET ;Set the rest of the error data.
 S STOP=1
 S PXAERRF=1
 S PXADI("DIALOG")=8390001.001
 S PXAERR(7)="HEALTH FACTOR"
 Q
 ;
VAL ;Validate the input.
 I $G(PXAA("HEALTH FACTOR"))="" D  Q
 . S PXAERR(9)="HEALTH FACTOR"
 . S PXAERR(12)="The Health Factor is missing."
 . D ERRSET
 ;
 ;Check that it is a valid pointer.
 I '$D(^AUTTHF(PXAA("HEALTH FACTOR"))) D  Q
 . S PXAERR(9)="HEALTH FACTOR"
 . S PXAERR(11)=PXAA("HEALTH FACTOR")
 . S PXAERR(12)="The Health Factor pointer is not valid."
 . D ERRSET
 ;
 ;If this is a deletion no further verification is required.
 I $G(PXAA("DELETE"))=1 Q
 ;
 N TEMP S TEMP=$G(^AUTTHF(PXAA("HEALTH FACTOR"),0))
 ;Check that the .01 is not null.
 I $P(TEMP,U,1)="" D  Q
 . S PXAERR(9)="HEALTH FACTOR"
 . S PXAERR(11)=PXAA("HEALTH FACTOR")
 . S PXAERR(12)="The Health Factor does not have a .01."
 . D ERRSET
 ;
 ;Check that it is active.
 I $P(TEMP,U,11)=1 D
 . S PXAERR(9)="INACTIVE"
 . S PXAERR(11)=PXAA("HEALTH FACTOR")
 . S PXAERR(12)="The Health Factor is inactive."
 . D ERRSET
 ;
 ;Make sure the Entry Type is not Category.
 I $P(TEMP,U,10)="C" D  Q
 . S PXAERR(9)="CATEGORY"
 . S PXAERR(11)=PXAA("HEALTH FACTOR")
 . S PXAERR(12)="The Entry Type is Category, patients cannot be given Category health factors."
 . D ERRSET
 ;
 ;If a Level/Severity is being input validate it.
 I $G(PXAA("LEVEL/SEVERITY"))'="",'$$SET^PXAIVAL(9000010.23,"LEVEL/SEVERITY",.04,PXAA("LEVEL/SEVERITY"),.PXAERR) D  Q
 . D ERRSET
 ;
 ;If Event D/T is input verify it is a valid FileMan date .
 I $G(PXAA("EVENT D/T"))'="",'$$EVENTDT^PXAIVAL(PXAA("EVENT D/T"),"T",.PXAERR) D  Q
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
 ;If a measurement is being input verify that it is in the allowed
 ;range.
 I $G(PXAA("MAGNITUDE"))'="",'$$MAG^PXAIVAL(PXAA("MAGNITUDE"),$G(^AUTTHF(PXAA("HEALTH FACTOR"),220)),.PXAERR) D  Q
 . D ERRSET
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
 I $G(STOP)=1 Q
 Q
 ;
