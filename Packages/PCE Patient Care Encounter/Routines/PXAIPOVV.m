PXAIPOVV ;ISL/JVS,PKR - VALIDATE DIAGNOSIS ;02/04/2021
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**121,194,199,211**;Aug 12, 1996;Build 454
 ;
 ;Reference to ICDEX supported by ICR #5747.
 ;
ERRSET ;Set the rest of the error data.
 S STOP=1
 S PXAERRF("POV")=1
 S PXADI("DIALOG")=8390001.001
 S PXAERR(7)="DX/PL"
 Q
 ;
PRIM(VISITIEN,PXADATA,PXAERRF) ;Make sure there is only one primary diagnosis.
 N DIAG,IND,NPDIAG,NPDN,PDLISTN,PRIM
 S IND=0
 F  S IND=+$O(@PXADATA@("DX/PL",IND)) Q:IND=0  D
 . S DIAG=$G(@PXADATA@("DX/PL",IND,"DIAGNOSIS"))
 . I DIAG="" Q
 . S PRIM=$G(@PXADATA@("DX/PL",IND,"PRIMARY"))
 .;Check for a change to the existing primary diagnosis.
 . I $D(PDLISTE(DIAG)) D
 .. I +$G(@PXADATA@("DX/PL",IND,"DELETE")) K PDLISTE(DIAG) Q
 .. I (PRIM=0)!(PRIM="S") K PDLISTE(DIAG)
 .;Check for adding a new primary diagnosis.
 . I (PRIM=1)!(PRIM="P") S PDLISTN(DIAG)=""
 . I +$G(@PXADATA@("DX/PL",IND,"DELETE")) K PDLISTN(DIAG) Q
 ;
 S DIAG="",NPDN=0
 F  S DIAG=$O(PDLISTN(DIAG)) Q:DIAG=""  S NPDN=NPDN+1,NPDIAG(NPDN)=DIAG
 ;
 I NPDN>1 D  Q
 . S PXAERR(9)="DIAGNOSIS"
 . S PXAERR(12)=NPDN_" diagnoses have been designated as primary, there can only be one."
 . S PXAERR(12)=PXAERR(12)_" They are: "
 . F IND=1:1:NPDN S PXAERR(12)=PXAERR(12)_$S(IND=1:" ",1:",")_NPDIAG(IND)
 . D ERRSET
 Q
 ;
VAL ;Validate the input data.
 I $G(PXAA("DIAGNOSIS"))="" D  Q
 . S PXAERR(9)="DIAGNOSIS"
 . S PXAERR(12)="The ICD diagnosis is missing."
 . D ERRSET
 ;
 ;Save the code or the pointer.
 S PXAERR(11)=$G(PXAA("DIAGNOSIS"))
 ;
 N CODE,CODEIEN,CODESYS,EVENTDT,FMT,ICDDATA,SERVCAT,TEMP
 S TEMP=^AUPNVSIT(PXAVISIT,0)
 S SERVCAT=$P(TEMP,U,7)
 ;For historical encounters use the Date the Visit was created.
 S EVENTDT=$S(SERVCAT="E":$P(TEMP,U,2),$G(PXAA("EVENT D/T"))'="":PXAA("EVENT D/T"),1:$P(TEMP,U,1))
 S FMT=$S(PXAA("DIAGNOSIS")?1.N:"I",1:"E")
 I FMT="E" S CODE=PXAA("DIAGNOSIS"),CODEIEN=$P($$CODEN^ICDEX(CODE,80),"~",1)
 I FMT="I" S CODEIEN=PXAA("DIAGNOSIS"),CODE=$$CODEC^ICDEX(80,CODEIEN)
 I CODEIEN'>0 D  Q
 . S PXAERR(9)="DIAGNOSIS"
 . S PXAERR(11)=PXAA("DIAGNOSIS")
 . S PXAERR(12)=PXAERR(11)_" is not a valid code or pointer."
 . D ERRSET
 ;
 ;If a code was passed store the pointer.
 I FMT="E" S PXAA("DIAGNOSIS")=CODEIEN
 ;
 ;If this is a deletion no further validation is required.
 I $G(PXAA("DELETE"))=1 Q
 ;
 ;Make sure the code is active.
 S CODESYS=$$CSI^ICDEX(80,CODEIEN)
 I '$$ISCACT^PXLEX(CODESYS,CODE,EVENTDT) D
 . S PXAERR(9)="DIAGNOSIS"
 . S PXAERR(11)=PXAA("DIAGNOSIS")
 . S PXAERR(12)=PXAERR(11)_" is not an active ICD code."
 . D ERRSET
 ;
 ;If Primary is input validate it.
 ;* N PRIM
 ;* S PRIM=$G(PXAA("PRIMARY"))
 ;* S PXAA("PRIMARY")=$S(PRIM=1:"P",PRIM=0:"S",1:PRIM)
 ;* I $G(PXAA("PRIMARY"))'="",'$$SET^PXAIVAL(9000010.07,"PRIMARY",.12,PXAA("PRIMARY"),.PXAERR) D  Q
 ;* . S PXAERR(9)="PRIMARY"
 ;* . S PXAERR(11)=PXAA("PRIMARY")
 ;* . D ERRSET
 ;
 ;If ORD/RES is input validate it.
 ;* I $G(PXAA("ORD/RES"))'="",'$$SET^PXAIVAL(9000010.07,"ORD/RES",.17,PXAA("ORD/RES"),.PXAERR) D  Q
 ;* . S PXAERR(9)="ORD/RES"
 ;* . S PXAERR(11)=PXAA("ORD/RES")
 ;* . D ERRSET
 ;
 ;If Lexicon Term is input validate it.
 ;* I $G(PXAA("LEXICON TERM"))'="",'$D(^LEX(757.01,PXAA("LEXICON TERM"),0)) D  Q
 ;* . S PXAERR(9)="LEXICON TERM"
 ;* . S PXAERR(11)=PXAA("LEXICON TERM")
 ;* . S PXAERR(12)=PXAA("LEXICON TERM")_" is not a valid point to the Clinical Expression file #757.01."
 ;* . D ERRSET
 ;
 ;If Narrative is input validate it.
 ;* I $G(PXAA("NARRATIVE"))'="",'$$TEXT^PXAIVAL("PROVIDER NARRATIVE",PXAA("NARRATIVE"),2,245,.PXAERR) D  Q
 ;* . D ERRSET
 ;*Control characters are not allowed.
 ;*I '$$VPNARR^PXPNARR(PXAA("NARRATIVE")) D  Q
 ;*. S PXAERR(9)="PROVIDER NARRATIVE"
 ;*. S PXAERR(11)=PXAA("NARRATIVE")
 ;*. S PXAERR(12)="Control characters are not allowed."
 ;*. D ERRSET
 ;
 ;Provider Narrative is required so if it is not input create one from
 ;the code description.
 I $G(PXAA("NARRATIVE"))="" S PXAA("NARRATIVE")=$$DXNARR^PXUTL1(CODEIEN,EVENTDT)
 ;
 ;If Provider Narrative Category is input validate it.
 ;* I $G(PXAA("CATEGORY"))'="",'$$TEXT^PXAIVAL("PROVIDER NARRATIVE CATEGORY",PXAA("CATEGORY"),2,245,.PXAERR) D  Q
 ;* . D ERRSET
 ;*Control characters are not allowed.
 ;*I '$$VPNARR^PXPNARR(PXAA("PROVIDER NARRATIVE CATEGORY")) D  Q
 ;*. S PXAERR(9)="PROVIDER NARRATIVE CATEGORY"
 ;*. S PXAERR(11)=PXAA("CATEGORY")
 ;*. S PXAERR(12)="Control characters are not allowed."
 ;*. D ERRSET
 ;
 ;If an Ordering Provider is passed verify it is valid.
 ;* I $G(PXAA("ORD PROVIDER"))'="",'$$PRV^PXAIVAL(PXAA("ORD PROVIDER"),"ORD",.PXAA,.PXAERR,PXAVISIT) D  Q
 ;* . D ERRSET
 ;
 ;If an Encounter Provider is passed verify it is valid.
 ;* I $G(PXAA("ENC PROVIDER"))'="",'$$PRV^PXAIVAL(PXAA("ENC PROVIDER"),"ENC",.PXAA,.PXAERR,PXAVISIT) D  Q
 ;* . D ERRSET
 ;
 ;If Event D/T is input verify it is a valid FileMan date and not in
 ;the future.
 ;* I $G(PXAA("EVENT D/T"))'="",'$$EVENTDT^PXAIVAL(PXAA("EVENT D/T"),"T",.PXAERR) D  Q
 ;* . D ERRSET
 ;
 ;If a Comment is input verify it.
 ;* I $G(PXAA("COMMENT"))'="",'$$TEXT^PXAIVAL("COMMENT",PXAA("COMMENT"),1,245,.PXAERR) D  Q
 ;* . D ERRSET
 ;
 ;If PKG is input verify it.
 ;* I $G(PXAA("PKG"))'="" D
 ;* . N PKG
 ;* . S PKG=$$VPKG^PXAIVAL(PXAA("PKG"),.PXAERR)
 ;* . I PKG=0 S PXAERR(9)="PKG" D ERRSET Q
 ;* . S PXAA("PKG")=PKG
 ;* I $G(STOP)=1 Q
 ;
 ;If SOURCE is input verify it.
 ;* I $G(PXAA("SOURCE"))'="" D
 ;* . N SRC
 ;* . S SRC=$$VSOURCE^PXAIVAL(PXAA("SOURCE"),.PXAERR)
 ;* . I SRC=0 S PXAERR(9)="SOURCE" D ERRSET Q
 ;* . S PXAA("SOURCE")=SRC
 ;* I $G(STOP)=1 Q
 ;
 ;If PL IEN is input validate it.
 ;* I $G(PXAA("PL IEN"))'="",'$D(^AUPNPROB(PXAA("PL IEN"),0)) D  Q
 ;* . S PXAERR(9)="PL IEN"
 ;* . S PXAERR(11)=PXAA("PL IEN")
 ;* . S PXAERR(12)=PXAA("PL IEN")_" is not a valid point to the Problem file #9000011."
 ;* . D ERRSET
 ;
 ;There is nothing to verify for PL ADD.
 ;
 ;If PL ACTIVE is input validate it.
 ;* I $G(PXAA("PL ACTIVE"))'="",PXAA("PL ACTIVE")'="A",PXAA("PL ACTIVE")'="I" D  Q
 ;* . S PXAERR(9)="PL ACTIVE"
 ;* . S PXAERR(11)=PXAA("PL ACTIVE")
 ;* . S PXAERR(12)=PXAA("PL ACTIVE")_" is not a valid value for PL ACTIVE,  A or I are allowed."
 ;* . D ERRSET
 ;
 ;If PL Onset Date is input verify it.
 ;* I $G(PXAA("PL ONSET DATE"))'="",'$$DATETIME^PXAIVAL("PL ONSET DATE",PXAA("PL ONSET DATE"),"",.PXAERR) D  Q
 ;* . S PXAERR(9)="PL ONSET DATE"
 ;* . S PXAERR(11)=PXAA("PL ONSET DATE")
 ;* . D ERRSET
 ;
 ;If PL Resolved Date is input verify it.
 ;* I $G(PXAA("PL RESOLVED DATE"))'="",'$$DATETIME^PXAIVAL("PL RESOLVED DATE",PXAA("PL RESOLVED DATE"),"",.PXAERR) D  Q
 ;* . S PXAERR(9)="PL RESOLVED DATE"
 ;* . S PXAERR(11)=PXAA("PL RESOLVED DATE")
 ;* . D ERRSET
 ;
 ;If PL SC is input verify it.
 ;* I $G(PXAA("PL SC"))'="",'$$SET^PXAIVAL(9000010.07,"PL SC",80001,PXAA("PL SC"),.PXAERR) D  Q
 ;* . S PXAERR(9)="PL SC"
 ;* . S PXAERR(11)=PXAA("PL SC")
 ;* . D ERRSET
 ;
 ;If PL AO is input verify it.
 ;* I $G(PXAA("PL AO"))'="",'$$SET^PXAIVAL(9000010.07,"PL AO",80002,PXAA("PL AO"),.PXAERR) D  Q
 ;* . S PXAERR(9)="PL AO"
 ;* . S PXAERR(11)=PXAA("PL AO")
 ;* . D ERRSET
 ;
 ;If PL IR is input verify it.
 ;* I $G(PXAA("PL IR"))'="",'$$SET^PXAIVAL(9000010.07,"PL IR",80003,PXAA("PL IR"),.PXAERR) D  Q
 ;* . S PXAERR(9)="PL IR"
 ;* . S PXAERR(11)=PXAA("PL IR")
 ;* . D ERRSET
 ;
 ;If PL EC is input verify it.
 ;* I $G(PXAA("PL EC"))'="",'$$SET^PXAIVAL(9000010.07,"PL EC",80004,PXAA("PL EC"),.PXAERR) D  Q
 ;* . S PXAERR(9)="PL EC"
 ;* . S PXAERR(11)=PXAA("PL EC")
 ;* . D ERRSET
 ;
 ;If PL MST is input verify it.
 ;* I $G(PXAA("PL MST"))'="",'$$SET^PXAIVAL(9000010.07,"PL MST",80005,PXAA("PL MST"),.PXAERR) D  Q
 ;* . S PXAERR(9)="PL MST"
 ;* . S PXAERR(11)=PXAA("PL MST")
 ;* . D ERRSET
 ;
 ;If PL HNC is input verify it.
 ;* I $G(PXAA("PL HNC"))'="",'$$SET^PXAIVAL(9000010.07,"PL HNC",80006,PXAA("PL HNC"),.PXAERR) D  Q
 ;* . S PXAERR(9)="PL HNC"
 ;* . S PXAERR(11)=PXAA("PL HNC")
 ;* . D ERRSET
 ;
 ;If PL CV is input verify it.
 ;* I $G(PXAA("PL CV"))'="",'$$SET^PXAIVAL(9000010.07,"PL CV",80007,PXAA("PL CV"),.PXAERR) D  Q
 ;* . S PXAERR(9)="PL CV"
 ;* . S PXAERR(11)=PXAA("PL CV")
 ;* . D ERRSET
 ;
 ;If PL SHAD is input verify it.
 ;* I $G(PXAA("PL SHAD"))'="",'$$SET^PXAIVAL(9000010.07,"PL SHAD",80008,PXAA("PL SHAD"),.PXAERR) D  Q
 ;* . S PXAERR(9)="PL SHAD"
 ;* . S PXAERR(11)=PXAA("PL SHAD")
 ;* . D ERRSET
 Q
 ;
VAL04 ;Setup error array for missing or invalid Provider Narrative.
 S PXAERR(9)="PROVIDER NARRATIVE"
 S PXAERR(11)=$G(PXAA("NARRATIVE"))
 S PXAERR(12)="We are unable to retrieve a provider narrative from the PROVIDER NARRATIVE file #9999999.27"
 D ERRSET
 Q
 ;
VAL802 ;Setup error array for missing or invalid Provider Narrative Category.
 ;Provider Narrative Category is not required, so make this a warning.
 S PXAERR(9)="PROVIDER NARRATIVE CATEGORY"
 S PXAERR(11)=$G(PXAA("CATEGORY"))
 S PXAERR(12)="We are unable to retrieve a provider narrative category from the PROVIDER NARRATIVE file #9999999.27"
 S PXADI("DIALOG")=8390001.002
 S PXAERR(7)="DX/PL"
 S PXAERRW("POV")=1
 Q
 ;
