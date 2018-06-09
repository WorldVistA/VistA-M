PXAICPTV ;ISL/JVS,PKR ISA/KWP,SCK - VALIDATE PROCEDURES(CPT) ;04/11/2018
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**15,73,74,111,121,130,168,194,199,211**;Aug 12, 1996;Build 244
 ;
ERRSET ;Set the rest of the error data.
 S STOP=1
 S PXAERRF=1
 S PXADI("DIALOG")=8390001.001
 S PXAERR(7)="PROCEDURE"
 Q
 ;
VAL ;Validate the input.
 I $G(PXAA("PROCEDURE"))="" D  Q
 . S PXAERR(12)="You are missing a CPT code"
 . D ERRSET
 ;
 ;Save the code or pointer.
 S PXAERR(11)=$G(PXAA("PROCEDURE"))
 ;
 N CODEIEN,CPTDATA,EVENTDT
 S EVENTDT=$G(PXAA("EVENT D/T"))
 I EVENTDT="" S EVENTDT=$P(^AUPNVSIT(PXAVISIT,0),U,1)
 S CPTDATA=$$CPT^ICPTCOD(PXAA("PROCEDURE"),EVENTDT)
 S CODEIEN=$P(CPTDATA,U,1)
 I CODEIEN'>0 D  Q
 . S PXAERR(12)=PXAERR(11)_" is not a valid CPT code or pointer."
 . D ERRSET
 ;
 ;If a code was passed store the IEN.
 S PXAA("PROCEDURE")=CODEIEN
 ;
 ;If this is a deletion no further validation is required.
 I $G(PXAA("DELETE"))=1 Q
 ;
 ;Check that the code is active.
 I $P(CPTDATA,U,7)'=1 D  Q
 . S PXAERR(12)=PXAERR(11)_" is NOT an active CPT code"
 . D ERRSET
 ;
 ;If the number of times is missing set it one.
 I +$G(PXAA("QTY"))'>0 S PXAA("QTY")=1
 ;
 ;Check that modifiers are valid.
 N MOD,MODDATA,MODIEN
 S MOD=""
 F  S MOD=$O(PXAA("MODIFIERS",MOD)) Q:MOD=""!($G(STOP))  D
 .;Try external first.
 . S MODDATA=$$MODP^ICPTMOD(PXAA("PROCEDURE"),MOD,"E",EVENTDT,0)
 . S MODIEN=$P(MODDATA,U,1)
 . I MODIEN>0 S PXAA("MODIFIERS",MOD)=MODIEN
 . E  D
 ..;Try internal.
 .. S MODDATA=$$MODP^ICPTMOD(PXAA("PROCEDURE"),MOD,"I",EVENTDT,0)
 .. S MODIEN=$P(MODDATA,U,1)
 .. I MODIEN>0 S PXAA("MODIFIERS",MOD)=MODIEN
 . I MODIEN'>0 D
 .. D ERRSET
 .. S PXAERR(9)="MODIFIERS"_","_MOD
 .. S PXAERR(11)=""
 .. S PXAERR(12)=MOD_" is not a valid modifier for procedure "_$G(PXAA("PROCEDURE"))
 .. I MODIEN=-1 S PXAERR(13)="Lexicon error: "_$P(MODDATA,U,2)
 I $G(STOP)=1 Q
 ;
 ;Check that ICD diagnosis codes are valid.
 N CODE,DIAGNUM,DIAGSTR,FMT,ICDDATA
 F DIAGNUM=1:1:8 D  Q:$G(STOP)=1
 . S DIAGSTR="DIAGNOSIS"_$S(DIAGNUM>1:" "_DIAGNUM,1:"")
 . I $G(PXAA(DIAGSTR))]"" D
 .. S CODE=PXAA(DIAGSTR)
 .. S FMT=$S(+CODE=CODE:"I",1:"E")
 .. S ICDDATA=$$ICDDX^ICDEX(CODE,EVENTDT,"",FMT,0)
 .. S CODEIEN=$P(ICDDATA,U,1)
 .. I CODEIEN'>0 D  Q
 ... D ERRSET
 ... S PXAERR(9)="PROCEDURE DIAGNOSIS"
 ... S PXAERR(11)=$G(PXAA(DIAGSTR))
 ... S PXAERR(12)="PROCEDURE DIAGNOSIS #"_DIAGNUM_" ("_PXAERR(11)_") is not a valid pointer to the ICD Diagnosis file #80."
 .. I $P(ICDDATA,"^",10)'=1 D
 ... D ERRSET
 ... S PXAERR(9)="PROCEDURE DIAGNOSIS"
 ... S PXAERR(11)=$G(PXAA(DIAGSTR))
 ... S PXAERR(12)="PROCEDURE DIAGNOSIS #"_DIAGNUM_" ("_PXAERR(11)_") is NOT an Active ICD code"
 .. I FMT="E" S PXAA(DIAGSTR)=CODEIEN
 ;
 ;If a Provider Narrative is passed check the length.
 I $G(PXAA("NARRATIVE"))'="",'$$TEXT^PXAIVAL("NARRATIVE",PXAA("NARRATIVE"),2,245,.PXAERR) D  Q
 . D ERRSET
 ;
 ;If a Provider Narrative Category is passed check the length.
 I $G(PXAA("CATEGORY"))'="",'$$TEXT^PXAIVAL("CATEGORY",PXAA("CATEGORY"),2,245,.PXAERR) D  Q
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
 ;If an Order Reference is passed verify it is valid.
 I $G(PXAA("ORD REFERENCE"))'="",'$D(^OR(100,PXAA("ORD REFERENCE"),0)) D  Q
 . S PXAERR(9)="ORD REFERENCE"
 . S PXAERR(11)=PXAA("ORD REFERENCE")
 . S PXAERR(12)=PXAA("ORD REFERENCE")_" is not a valid pointer to the Order file #100."
 . D ERRSET
 ;
 ;If Event D/T is input verify it is a valid FileMan date and not in
 ;the future.
 I $G(PXAA("EVENT D/T"))'="",'$$EVENTDT^PXAIVAL(PXAA("EVENT D/T"),"T",.PXAERR) D  Q
 . D ERRSET
 ;
 ;If PFSS is on and Department is passed verify it is valid.
 I $$SWSTAT^IBBAPI,$G(PXAA("DEPARTMENT"))'="",'$D(^DIC(40.7,PXAA("DEPARTMENT"),0)) D  Q
 . S PXAERR(9)="DEPARTMENT"
 . S PXAERR(11)=PXAA("DEPARTMENT")
 . S PXAERR(12)=PXAA("DEPARTMENT")_" is not a valid Clinic Stop."
 ;
 ;If Comment is passed check the length.
 I $G(PXAA("COMMENT"))'="",'$$TEXT^PXAIVAL("COMMENT",PXAA("COMMENT"),1,245,.PXAERR) D  Q
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
VAL04 ;Setup error array for missing Provider Narrative.
 S PXAERR(9)="NARRATIVE"
 S PXAERR(11)=$G(PXAA("NARRATIVE"))
 S PXAERR(12)="We are unable to retrieve a narrative from the PROVIDER NARRATIVE file #9999999.27"
 D ERRSET
 Q
 ;
VAL802 ;Setup error array for missing Provider Narrative Category.
 S PXAERR(9)="NARRATIVE CATEGORY"
 S PXAERR(11)=$G(PXAA("CATEGORY"))
 S PXAERR(12)="We are unable to retrieve a narrative category from the PROVIDER NARRATIVE file #9999999.27"
 D ERRSET
 Q
 ;
