PXAI ;ISL/JVS,PKR ISA/KWP,ESW - PCE DRIVING RTN FOR 'DATA2PCE' API ;04/11/2018
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**15,74,69,102,111,112,130,164,168,215,211**;Aug 12, 1996;Build 244
 Q
 ;
 ;+  1       2       3        4        5       6      7      8       9
DATA2PCE(PXADATA,PXAPKG,PXASOURC,PXAVISIT,PXAUSER,PXANOT,ERRRET,PXAPREDT,PXAPROB,PXACCNT) ;+API to pass data for add/edit/delete to PCE.
 ;+  PXADATA  (required)
 ;+  PXAPKG   (required)
 ;+  PXASOURC (required)
 ;+  PXAVISIT (optional) is pointer to a visit for which the data is to
 ;+        be related.  If the visit is not known then there must be
 ;+        the ENCOUNTER nodes needed to lookup/create the visit.
 ;+  PXAUSER  (optional) this is a pointer to the user adding the data.
 ;+  PXANOT   (optional) set to 1 if errors are to be displayed to the screen should only be set while writing and debugging the initial code.
 ;+  ERRRET   (optional) passed by reference.  If present will return PXKERROR
 ;+                      array elements to the caller.
 ;+  PXAPREDT  (optional) Set to 1 if you want to edit the Primary Provider
 ;+            only use if for the moment that editing is being done. (dangerous)
 ;+  PXAPROB   (optional) A dotted variable name. When errors and
 ;+             warnings occur, They will be passed back in the form
 ;+            of an array with the general description of the problem.
 ;+ IF ERROR1 - (GENERAL ERRORS)
 ;+      PXAPROB($J,SUBSCRIPT,"ERROR1",PASSED IN 'FILE',PASSED IN FIELD,
 ;+              SUBSCRIPT FROM PXADATA)
 ;+      PXAPROB(23432234,2,"ERROR1","PROVIDER","NAME",7)="BECAUSE..."
 ;+ IF WARNING2 - (GENERAL WARNINGS)
 ;+      PXAPROB($J,SUBSCRIPT,"WARNING2",PASSED IN 'FILE',PASSED IN FIELD,
 ;+              SUBSCRIPT FROM PXADATA)
 ;+      PXAPROB(23432234,3,"WARNING2","PROCEDURE","QTY",3)="BECAUSE..."
 ;+ IF WARNING3 - (WARNINGS FOR SERVICE CONNECTION)
 ;+      PXAPROB($J,1,"WARNING3","ENCOUNTER",1,"AO")=REASON
 ;+      PXAPROB($J,1,"WARNING3","ENCOUNTER",1,"EC")=REASON
 ;+      PXAPROB($J,1,"WARNING3","ENCOUNTER",1,"IR")=REASON
 ;+      PXAPROB($J,1,"WARNING3","ENCOUNTER",1,"SC")=REASON
 ;+      PXAPROB($J,1,"WARNING3","ENCOUNTER",1,"MST")=REASON
 ;+      PXAPROB($J,1,"WARNING3","ENCOUNTER",1,"HNC")=REASON
 ;+      PXAPROB($J,1,"WARNING3","ENCOUNTER",1,"CV")=REASON
 ;+      PXAPROB($J,1,"WARNING3","ENCOUNTER",1,"SHAD")=REASON
 ;+ IF ERROR4 - (PROBLEM LIST ERRORS)
 ;+      PXAPROB($J,6,"ERROR4","PX/DL",(SUBSCRIPT FROM PXADATA))=REASON
 ;+ PXACCNT (optional)  passed by reference.  Returns the PFSS Account
 ;           Reference if known. Returned as null if the PFSS Account
 ;           Reference is located in the Order file(#100)
 ;+
 ;+
 ;+ Returns:
 ;+   1  if no errors and process completely
 ;+  -1  if errors occurred but processed completely as possible
 ;+  -2  if could not get a visit
 ;+  -3  if called incorrectly
 ;+  -4  if cannot get a lock on the encounter
 ;+  -5  if there were only warnings
 ;
NEW ;--NEW VARIABLES
 N NOVSIT,PXAK,DFN,PXAERRF,PXAERRW,PXADEC,PXELAP,PXASUB
 N PATIENT,VALQUIET,PRIMFND
 K PXAERROR,PXKERROR,PXAERR,PRVDR
 S PXASUB=0,VALQUIET=1
 ;Lookup or create Visit if it is not passed. 
 I '$G(PXAVISIT),'$D(@PXADATA@("ENCOUNTER")) Q -3
 I $G(PXAUSER)="" S PXAUSER=DUZ
 K ^TMP("PXK",$J),^TMP("DIERR",$J),^TMP("PXAIADDPRV",$J)
 ;
VST ;--VISIT
 I $G(PXAVISIT)'="" D VPTR^PXAIVSTV(PXAVISIT) I $G(PXAERRF) S PXAK=1 D ERR("VISIT",1) Q -2
 D VST^PXAIVST
 I $G(PXAVISIT)<0 Q -2
 I $G(PXAERRF) M ERRRET=PXKERROR D ERR("VISIT",1) K PXAERR Q $S(PXAERRF=4:-4,1:-2)
 ;
SOURCE ;--Validate PACKAGE AND SOURCE.
 N EPKG,ESOURCE
 S EPKG=$P($G(^AUPNVSIT(PXAVISIT,812)),U,2)
 S PXAPKG=$$VPKG^PXAIVSTV(EPKG,PXAPKG)
 I $G(PXAERRF) S PXAK=1 D ERR("PACKAGE",1) Q -3
 I $G(PXAERRW) S PXAK=1 D ERR("PACKAGE",1)
 S ESOURCE=$P($G(^AUPNVSIT(PXAVISIT,812)),U,3)
 S PXASOURC=$$VSOURCE^PXAIVSTV(ESOURCE,PXASOURC)
 I $D(PXAERRF) S PXAK=1 D ERR("SOURCE",1) Q -3
 I $D(PXAERRW) S PXAK=1 D ERR("SOURCE",1)
 D SPKGSRC^PXAIVST(PXAVISIT,EPKG,PXAPKG,ESOURCE,PXASOURC,.PXAERRF,.PXAERR)
 I $G(PXAERRF) S PXAK=1 D ERR("PKG/SOURCE",1) Q -3
 S ^TMP("PXK",$J,"SOR")=PXASOURC
 ;D TMPSOURC^PXAPIUTL(PXASOURC) ;-SAVES & CREATES ^TMP("PXK",$J,"SOR")
 ;
USER ;--If a USER is passed validate it.
 I $G(PXAUSER)'="" D VUSER^PXAIVSTV(PXAUSER)  I $G(PXAERRF) D ERR("USER",1) Q -3
 ;
PRV ;--PROVIDER
 I $D(@PXADATA@("PROVIDER")) D
 .;Check for primary provider issues.
 . D PRIM^PXAIPRVV(PXAVISIT,.PXADATA,.PXAERRF,$G(PXAPREDT))
 . I $G(PXAERRF) S PXAK=1 D ERR("PROVIDER",1) K PXAERR Q
 . I $G(PXAERRW) S PXAK=1 D ERR("PROVIDER",1) K PXAERR
 . S PXAK=0 F  S PXAK=$O(@PXADATA@("PROVIDER",PXAK))  Q:PXAK=""  D
 .. D PRV^PXAIPRV
 .. I $G(PXAERRF) D ERR("PROVIDER",1) K PXAERR
 ;
POV ;--DIAGNOSIS
 I $D(@PXADATA@("DX/PL")) D
 .;Check for more than one primary diagnosis.
 . D PRIM^PXAIPOVV(PXAVISIT,.PXADATA,.PXAERRF)
 . I $G(PXAERRF) S PXAK=1 D ERR("DX/PL",1) K PXAERR Q
 . I $G(PXAERRW) S PXAK=1 D ERR("DX/PL",1) K PXAERR
 . S PXAK=0 F  S PXAK=$O(@PXADATA@("DX/PL",PXAK))  Q:PXAK=""  D
 .. D POV^PXAIPOV
 .. I $G(PXAERRF) S PXAK=1 D ERR("DX/PL",1) K PXAERR
 ;
CPT ;--PROCEDURE
 S PXAK=0 F  S PXAK=$O(@PXADATA@("PROCEDURE",PXAK))  Q:PXAK=""  D
 . D CPT^PXAICPT I $G(PXAERRF) D ERR("PROCEDURE",PXAK)
 K PXAERR
 ;
EDU ;--PATIENT EDUCATION
 S PXAK=0 F  S PXAK=$O(@PXADATA@("PATIENT ED",PXAK))  Q:PXAK=""  D
 . D EDU^PXAIPED I $G(PXAERRF) D ERR("PATIENT ED",PXAK)
 K PXAERR
 ;
EXAM ;--EXAMINATION
 S PXAK=0 F  S PXAK=$O(@PXADATA@("EXAM",PXAK))  Q:PXAK=""  D
 . D EXAM^PXAIXAM I $G(PXAERRF) D ERR("EXAM",PXAK)
 K PXAERR
 ;
HF ;--HEALTH FACTOR
 S PXAK=0 F  S PXAK=$O(@PXADATA@("HEALTH FACTOR",PXAK))  Q:PXAK=""  D
 . D HF^PXAIHF I $G(PXAERRF) D ERR("HEALTH FACTOR",PXAK)
 K PXAERR
 ;
IMM ;--IMMUNIZATION
 S PXAK=0 F  S PXAK=$O(@PXADATA@("IMMUNIZATION",PXAK))  Q:PXAK=""  D
 . D IMM^PXAIIMM I $G(PXAERRF) D ERR("IMMUNIZATION",PXAK)
 K PXAERR
 ;
SKIN ;--SKIN TEST
 S PXAK=0 F  S PXAK=$O(@PXADATA@("SKIN TEST",PXAK))  Q:PXAK=""  D
 . D SKIN^PXAISK I $G(PXAERRF) D ERR("SKIN TEST",PXAK)
 K PXAERR
 ;
ICR ;--IMM CONTRAINDICATION/REFUSAL
 S PXAK=0 F  S PXAK=$O(@PXADATA@("IMM CONTRA/REFUSAL",PXAK))  Q:PXAK=""  D
 . D ICR^PXAIICR I $G(PXAERRF) D ERR("IMM CONTRA/REFUSAL",PXAK)
 K PXAERR
 ;
SC ;--STANDARD CODES
 S PXAK=0 F  S PXAK=$O(@PXADATA@("STD CODES",PXAK))  Q:PXAK=""  D
 . D SC^PXAISC I $G(PXAERRF) D ERR("STD CODES",PXAK)
 K PXAERR
 ;
 D OTHER^PXAIPRV
 ;
 I $D(^TMP("PXK",$J)) D
 . D EN1^PXKMAIN
 . D EVENT^PXKMAIN
 ;
 ;If errors have been recorded in PXKERROR pass them back.
 I $D(PXKERROR) M ERRRET=PXKERROR S PXAERRF=1
 ;
 S PXACCNT=$P($G(^AUPNVSIT(PXAVISIT,0)),"^",26) ;PX*1.0*164 ;Sets the PFSS Account Reference, if any
 K ^TMP("PXK",$J),PXAERR,PXKERROR
 Q $S($G(PXAERRF):-1,$G(PXAERRW):-5,1:1)
 ;
EXIT ;--EXIT AND CLEAN UP
 D EVENT^PXKMAIN
 K ^TMP("PXK",$J),PRVDR
 K PXAERR
 Q
 ;
 ;-----------------SUBROUTINES-----------------------
ERR(DATATYPE,NUM) ;
 I '$D(PXADI("DIALOG")) Q
 N NODE,SCREEN
 S PXAERR(1)=$G(PXADATA),PXAERR(2)=$G(PXAPKG),PXAERR(3)=$G(PXASOURC)
 S PXAERR(4)=$G(PXAVISIT),PXAERR(5)=$G(PXAUSER)_"  "_$P($G(^VA(200,PXAUSER,0)),"^",1)
 D SSCL^PXAIERR(.PXAERR)
 I $G(PXANOT)=1 D EXTERNAL
 E  D INTERNAL(DATATYPE,NUM)
 D SETPROB^PXAIERR
 K PXADI("DIALOG")
 Q
 ;
EXTERNAL ;---SEND ERRORS TO SCREEN
 W !,"-----------------------------------------------------------------"
 D BLD^DIALOG($G(PXADI("DIALOG")),.PXAERR,"","SCREEN","F")
 D MSG^DIALOG("ESW","",50,10,"SCREEN")
 Q
 ;
INTERNAL(DATATYPE,NUM) ;---SET ERRORS TO GLOBAL ARRAY
 N OUTPUT,TEMP
 D BLD^DIALOG($G(PXADI("DIALOG")),.PXAERR,"","TEMP","F")
 D MSG^DIALOG("AES",.OUTPUT,50,10,"TEMP")
 M ERRRET(DATATYPE,NUM)=OUTPUT
 M @PXADATA=TEMP
 Q
 ;
