PXUTL1 ;ISL/dee - Utility routines used by PCE ;06/14/2018
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**25,134,149,199,211**;Aug 12, 1996;Build 454
 ;
 ;Reference to ICDEX supported by ICR #5747.
 ;
 Q
 ;
EXTTEXT(IEN,REQUIRED,FILE,FIELD1,FIELD2) ;Returns the external form.
 ;* 1/24/2012 - ICD-10 REMEDIATION note
 ;* This function was being used mostly to retrieve the diagnosis description.
 ;* The DESCRIPTION field in file #80 is now a multiple and does not work
 ;* with this function so most of the routines that were using this have been
 ;* recoded.  This function is still viable as a DIC wrapper but must be used
 ;* for 'flat' fields and not multiples.
 ;
 ;Parameters:
 ;  IEN       the IEN in the file that the text is wanted for.
 ;  REQUIRED  if this is not zero and no text is found
 ;              then "UNKNOWN" is returned.
 ;  FILE      the file number
 ;  FIELD1    the field number that the text is in
 ;  FIELD2    if the parameter is passed and there is no text
 ;              in field1 then the text in this field will be
 ;              returned if there is some.
 ;
 N DIC,DR,DA,DIQ,PXUTDIQ1,PXTEXT,Y,X
 I $G(FILE)>0,$G(FIELD1)>0 D
 . S DIC=FILE
 . S DR=FIELD1
 . S:$G(FIELD2)>0 DR=DR_";"_FIELD2
 . S DA=IEN
 . S DIQ="PXUTDIQ1("
 . S DIQ(0)="E"
 . D EN^DIQ1
 . I $G(PXUTDIQ1(FILE,DA,FIELD1,"E"))]"" S PXTEXT=PXUTDIQ1(FILE,DA,FIELD1,"E")
 . E  I $G(FIELD2)>0,$G(PXUTDIQ1(FILE,DA,FIELD2,"E"))]"" S PXTEXT=PXUTDIQ1(FILE,DA,FIELD2,"E")
 . E  I REQUIRED S PXTEXT="UNKNOWN"
 E  I REQUIRED S PXTEXT="UNKNOWN"
 Q PXTEXT
 ;
PRIMVPRV(PXUTVST) ;Returns the primary provider if there is one
 ;                 for the passed visit otherwise returns 0.
 N PXCATEMP
 S PXCATEMP=$$PRIMSEC(PXUTVST,"^AUPNVPRV",0,4)
 Q $S(PXCATEMP>0:$P(^AUPNVPRV(PXCATEMP,0),"^"),1:0)
 ;
PRIMVPOV(PXUTVST) ;Returns the primary diagnosis if there is one
 ;         for the passed visit otherwise returns 0.
 N PXCATEMP
 S PXCATEMP=$$PRIMSEC(PXUTVST,"^AUPNVPOV",0,12)
 Q $S(PXCATEMP>0:$P(^AUPNVPOV(PXCATEMP,0),"^"),1:0)
 ;
PRIMSEC(PXUTVST,PXUTAUPN,PXUTNODE,PXUPIECE) ;Returns IEN of the primary one
 ;         if there is one for the passed visit otherwise returns 0.
 ; Parameters:
 ;   PXUTVST   Pointer to the visit
 ;   PXUTAUPN  V-File global e.g. "^AUPNVPRV"
 ;   PXUTNODE  The node that the Primary/Secondary field is on
 ;   PXUPIECE  The piece of the Primary/Secondary field
 ;
 N PXUTPRIM
 S PXUTPRIM=0
 F  S PXUTPRIM=$O(@(PXUTAUPN_"(""AD"",PXUTVST,PXUTPRIM)")) Q:PXUTPRIM'>0  I "P"=$P(@(PXUTAUPN_"(PXUTPRIM,PXUTNODE)"),"^",PXUPIECE) Q
 Q +PXUTPRIM
 ;
DISPOSIT(PXUTLDFN,PXUTLDT,PXUTVIEN) ;Checks to see if a visit is a disposition
 I PXUTVIEN=+$P($G(^SCE(+$P($G(^DPT(+PXUTLDFN,"DIS",9999999-PXUTLDT,0)),"^",18),0)),"^",5) Q +$P($G(^DPT(+PXUTLDFN,"DIS",9999999-PXUTLDT,0)),"^",18)
 Q 0
 ;
APPOINT(PXUTLDFN,PXUTLDT,HLOC) ;Returns 1 if the patient has an appointment
 ;at PXUTLDT for clinic HLOC.
 Q HLOC=+$G(^DPT(+PXUTLDFN,"S",+PXUTLDT,0))
 ;
VST2APPT(VISIT) ;Is this visit related to an appointment
 ;Returns
 ; 1 if the visit is being pointed to by an appointment
 ; 0 if the visit is NOT being pointed to by an appointment
 ;-1 if the visit is invalid
 ;
 N VISIT0
 S VISIT0=$G(^AUPNVSIT($G(VISIT),0))
 Q:VISIT0="" -1
 Q $$VSTAPPT($P(VISIT0,"^",5),$P(VISIT0,"^",1),$P(VISIT0,"^",22),VISIT)
 ;
VSTAPPT(PXUTLPAT,PXUTLDT,PXUTLLOC,PXUTLVST) ;Returns 1 if the visit is being pointed to by an
 ;                appointment otherwise 0.
 I PXUTLLOC]"",PXUTLLOC=+$G(^DPT(+PXUTLPAT,"S",+PXUTLDT,0)),PXUTLVST=+$P($G(^SCE(+$P($G(^DPT(PXUTLPAT,"S",PXUTLDT,0)),"^",20),0)),"^",5) Q 1
 Q 0
 ;
APPT2VST(PXUTLPAT,PXUTLDT,HLOC) ;Returns IEN of visit that the related
 ;appointment points to at PXUTLDT for clinic HLOC otherwise 0.
 I HLOC=+$G(^DPT(+PXUTLPAT,"S",+PXUTLDT,0)) Q +$P($G(^SCE(+$P($G(^DPT(PXUTLPAT,"S",PXUTLDT,0)),"^",20),0)),"^",5)
 Q 0
 ;
DXNARR(CODEIEN,PXUTLDT) ;Returns the versioned full text from file #80,
 ;field #68
 N NARR,PXLDX,PXNO,PXCOD
 I $G(CODEIEN)="" Q ""
 S:$G(PXUTLDT)="" PXUTLDT=DT
 S NARR=$$LD^ICDEX(80,CODEIEN,PXUTLDT,.NARR)
 Q $S($P(NARR,U,1)=-1:"",1:NARR)
 ;
