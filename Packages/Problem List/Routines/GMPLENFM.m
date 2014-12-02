GMPLENFM ; SLC/MKB/KER/TC -- Problem List Enc Form utilities ;06/12/13  09:08
 ;;2.0;Problem List;**3,4,7,26,35,36,42**;Aug 25, 1994;Build 46
 ;
 ; External References
 ;   DBIA  1609  CONFIG^LEXSET
 ;   ICR   5699  $$ICDDATA^ICDXCODE, $$STATCHK^ICDXCODE
 ;   ICR   5747  $$CSI/SAB/CODECS^ICDEX
 ;   DBIA 10006  ^DIC
 ;
ACTIVE ; List of Active Problems for DFN
 ;   Input variables:
 ;             DFN               Patient ID (Required)
 ;             [GMPINDT]         Date of Interest (Optional - defaults to today)
 ;                                 This is the date to use for evalutation of the
 ;                                 Activation status of ICD-9-CM and SNOMED CT codes
 ;
 ;   Sets Global Array:
 ;   ^TMP("IB",$J,"INTERFACES",DFN,"GMP PATIENT ACTIVE PROBLEMS",#) =
 ;
 ;   Piece 1:  Problem text
 ;         2:  ICD code
 ;         3:  Date of Onset     00/00/00 format
 ;         4:  SC/NSC/""         serv-conn/not sc/unknown
 ;         5:  Y/N/""            serv-conn/not sc/unknown
 ;         6:  A/I/E/H/M/C/S/""  If problem is flagged as:
 ;                               A - Agent Orange
 ;                               I - Ionizing Radiation
 ;                               E - Environmental Contaminants
 ;                               H - Head/Neck Cancer
 ;                               M - Mil Sexual Trauma
 ;                               C - Combat Vet
 ;                               S - SHAD
 ;                                 - None
 ;         7:  Special Exposure  Full text of piece 6
 ;         8:  SNOMED-CT Concept Code
 ;         9:  SNOMED-CT Designation Code
 ;        10:  VHAT Concept VUID
 ;        11:  VHAT Designation VUID
 ;        12:  Code Status (#  -> ICD code inactive, $ -> SNOMED CT inactive,
 ;                          #$ -> Both ICD & SNOMED CT inactive, else "")
 ;        13:  ICD Coding System ("ICD": ICD-9-CM, "10D": ICD-10-CM)
 ;
 N IFN,PROB,CNT,SC,NUM,GMPLIST,GMPARAM,GMPLVIEW,GMPTOTAL
 N GMPDFN,NODE
 Q:$G(DFN)'>0  S GMPDFN=DFN,CNT=0,NODE=$G(^GMPL(125.99,1,0))
 S GMPINDT=$G(GMPINDT,$$DT^XLFDT)
 S GMPARAM("VER")=$P(NODE,U,2),GMPARAM("REV")=$P(NODE,U,5)="R",GMPARAM("QUIET")=1
 S GMPLVIEW("ACT")="A",GMPLVIEW("PROV")=0,GMPLVIEW("VIEW")=""
 D GETPLIST^GMPLMGR1(.GMPLIST,.GMPTOTAL,.GMPLVIEW)
 F NUM=0:0 S NUM=$O(GMPLIST(NUM)) Q:NUM'>0  D
 . N GMPL0,GMPL1,GMPL800,GMPL802,GMPCSYS,GMPDT,GMPLCPTR,CODESTAT,ICDC,ICDI,SCTC,SCTD,VHATC,VHATD
 . S IFN=GMPLIST(NUM) Q:IFN'>0
 . S GMPL0=$G(^AUPNPROB(IFN,0)),GMPL1=$G(^(1)),GMPL800=$G(^(800)),GMPL802=$G(^(802)),CODESTAT=""
 . S GMPDT=$S(+$P(GMPL802,U,1):$P(GMPL802,U,1),1:$P(GMPL0,U,8)),GMPLCPTR=$$CSI^ICDEX(80,+GMPL0)
 . S GMPCSYS=$S($P(GMPL802,U,2)]"":$P(GMPL802,U,2),1:$$SAB^ICDEX(GMPLCPTR,GMPDT))
 . S ICDC=$P($$ICDDATA^ICDXCODE(GMPCSYS,+GMPL0,GMPDT,"I"),U,2)
 . S:ICDC]"" CODESTAT=CODESTAT_$S(+$$STATCHK^ICDXCODE(GMPLCPTR,ICDC,GMPINDT):"",1:"#")
 . S ICDI=0 F  S ICDI=$O(^AUPNPROB(IFN,803,ICDI)) Q:+ICDI'>0  D
 .. N ICDM0,ICDMC,ICDMCSYS,ICDMDT,ICDCSPTR
 .. S ICDM0=$G(^AUPNPROB(IFN,803,ICDI,0)),ICDMC=$P(ICDM0,U)
 .. S ICDMCSYS=$P(ICDM0,U,2),ICDMDT=$P(ICDM0,U,3),ICDCSPTR=+$$CODECS^ICDEX(ICDMC,80,ICDMDT)
 .. S ICDC=ICDC_"/"_ICDMC
 .. I CODESTAT'["#" S CODESTAT=CODESTAT_$S(+$$STATCHK^ICDXCODE(ICDCSPTR,ICDMC,GMPINDT):"",1:"#")
 . S SCTC=$P(GMPL800,U),SCTD=$P(GMPL800,U,2),VHATC=$P(GMPL800,U,3),VHATD=$P(GMPL800,U,4)
 . S CODESTAT=CODESTAT_$S(+$$STATCHK^LEXSRC2(SCTC,GMPINDT,,"SCT"):"",1:"$")
 . S PROB=$$PROBTEXT^GMPLX(IFN),CNT=CNT+1
 . I GMPARAM("VER"),$P(GMPL1,U,2)="T" S PROB="$"_PROB
 . S PROB=PROB_U_ICDC
 . S PROB=PROB_U_$$EXTDT^GMPLX($P(GMPL0,U,13)),SC=$P(GMPL1,U,10)
 . S PROB=PROB_U_$S(+SC:"SC^Y",SC=0:"NSC^N",1:"^")
 . S PROB=PROB_U_$$TXFCTR(GMPL1)_U_SCTC_U_SCTD_U_VHATC_U_VHATD_U_CODESTAT_U_GMPCSYS
 . S ^TMP("IB",$J,"INTERFACES",+$G(DFN),"GMP PATIENT ACTIVE PROBLEMS",CNT)=PROB
 S ^TMP("IB",$J,"INTERFACES",+$G(DFN),"GMP PATIENT ACTIVE PROBLEMS",0)=CNT
 Q
 ;
SELECT ; Select Common Problems
 ;   Sets Global Array:
 ;   ^TMP("IB",$J,"INTERFACES","GMP SELECT CLINIC COMMON PROBLEMS")
 ;   Piece 1:  Pointer to Clinical Lexicon
 ;         2:  Problem Text
 ;         3:  ICD Code (null if unknown)
 ;
 N X,Y,DIC,PROB D CONFIG^LEXSET("GMPX","PLS")
 K ^TMP("IB",$J,"INTERFACES","GMP SELECT CLINIC COMMON PROBLEMS")
 S DIC("A")="Select PROBLEM: ",DIC(0)="AEQM",DIC="^LEX(757.01,"
 D ^DIC Q:+Y<0  S PROB=Y I +Y'>1 S PROB=+Y_U_X
 S PROB=PROB_U_$G(Y(1))
 S ^TMP("IB",$J,"INTERFACES","GMP SELECT CLINIC COMMON PROBLEMS")=PROB
 Q
 ;
DSELECT ; List of Active Problems for DFN
 ;   Input variables:
 ;             DFN               Patient ID (Required)
 ;             [GMPINDT]        Date of Interest (Optional - defaults to today)
 ;                                 This is the date to use for evalutation of the
 ;                                 Activation status of ICD-9-CM and SNOMED CT codes
 ;
 ;   Sets Global Array"
 ;   ^TMP("IB",$J,"INTERFACES","GMP SELECT PATIENT ACTIVE PROBLEMS",#) =
 ;
 ;   Piece 1:  Problem IEN
 ;         2:  Problem Text
 ;         3:  ICD code
 ;         4:  Date of Onset     00/00/00 format
 ;         5:  SC/NSC/""         serv-conn/not sc/unknown
 ;         6:  Y/N/""            serv-conn/not sc/unknown
 ;         7:  A/I/E/H/M/C/S/""  If problem is flagged as:
 ;                               A - Agent Orange
 ;                               I - Ionizing Radiation
 ;                               E - Environmental Contaminants
 ;                               H - Head/Neck Cancer
 ;                               M - Mil Sexual Trauma
 ;                               C - Combat Vet
 ;                               S - SHAD
 ;                                 - None
 ;         8:  Special Exposure  Full text of piece 6
 ;         9:  SNOMED-CT Concept Code
 ;        10:  SNOMED-CT Designation Code
 ;        11:  VHAT Concept VUID
 ;        12:  VHAT Designation VUID
 ;        13:  Code Status (#  -> ICD code inactive, $ -> SNOMED CT inactive,
 ;                          #$ -> Both ICD & SNOMED CT inactive, else "")
 ;        14:  ICD coding system ("ICD": ICD-9-CM, "10D": ICD-10-CM)
 ;
 N IFN,PROB,CNT,SC,NUM,GMPLIST,GMPARAM,GMPLVIEW,GMPTOTAL,GMPDFN,NODE
 Q:$G(DFN)'>0  S GMPDFN=DFN,CNT=0,NODE=$G(^GMPL(125.99,1,0))
 S GMPINDT=$G(GMPINDT,$$DT^XLFDT)
 S GMPARAM("VER")=$P(NODE,U,2),GMPARAM("REV")=$P(NODE,U,5)="R",GMPARAM("QUIET")=1
 S GMPLVIEW("ACT")="A",GMPLVIEW("PROV")=0,GMPLVIEW("VIEW")=""
 D GETPLIST^GMPLMGR1(.GMPLIST,.GMPTOTAL,.GMPLVIEW)
 F NUM=0:0 S NUM=$O(GMPLIST(NUM)) Q:NUM'>0  D
 . N GMPL0,GMPL1,GMPL800,GMPL802,GMPDT,GMPCSYS,GMPLCPTR,CODESTAT,ICDC,ICDI,SCTC,SCTD,VHATC,VHATD
 . S IFN=GMPLIST(NUM) Q:IFN'>0
 . S GMPL0=$G(^AUPNPROB(IFN,0)),GMPL1=$G(^(1)),GMPL800=$G(^(800)),GMPL802=$G(^(802)),CODESTAT=""
 . S GMPDT=$S(+$P(GMPL802,U,1):$P(GMPL802,U,1),1:$P(GMPL0,U,8)),GMPLCPTR=$$CSI^ICDEX(80,+GMPL0)
 . S GMPCSYS=$S($P(GMPL802,U,2)]"":$P(GMPL802,U,2),1:$$SAB^ICDEX(GMPLCPTR,GMPDT))
 . S ICDC=$P($$ICDDATA^ICDXCODE(GMPCSYS,+GMPL0,GMPDT,"I"),U,2)
 . S:ICDC]"" CODESTAT=CODESTAT_$S(+$$STATCHK^ICDXCODE(GMPLCPTR,ICDC,GMPINDT):"",1:"#")
 . S ICDI=0 F  S ICDI=$O(^AUPNPROB(IFN,803,ICDI)) Q:+ICDI'>0  D
 .. N ICDM0,ICDMC,ICDMCSYS,ICDMDT,ICDCSPTR
 .. S ICDM0=$G(^AUPNPROB(IFN,803,ICDI,0)),ICDMC=$P(ICDM0,U) Q:ICDMC']""
 .. S ICDMCSYS=$P(ICDM0,U,2),ICDMDT=$P(ICDM0,U,3),ICDCSPTR=+$$CODECS^ICDEX(ICDMC,80,ICDMDT)
 .. S ICDC=ICDC_"/"_ICDMC
 .. I CODESTAT'["#" S CODESTAT=CODESTAT_$S(+$$STATCHK^ICDXCODE(ICDCSPTR,ICDMC,GMPINDT):"",1:"#")
 . S SCTC=$P(GMPL800,U),SCTD=$P(GMPL800,U,2),VHATC=$P(GMPL800,U,3),VHATD=$P(GMPL800,U,4)
 . S:SCTC]"" CODESTAT=CODESTAT_$S(+$$STATCHK^LEXSRC2(SCTC,GMPINDT,,"SCT"):"",1:"$")
 . S PROB=$$PROBTEXT^GMPLX(IFN),CNT=CNT+1
 . I GMPARAM("VER"),$P(GMPL1,U,2)="T" S PROB="$"_PROB
 . S PROB=IFN_U_PROB
 . S PROB=PROB_U_ICDC
 . S PROB=PROB_U_$$EXTDT^GMPLX($P(GMPL0,U,13)),SC=$P(GMPL1,U,10)
 . S PROB=PROB_U_$S(+SC:"SC^Y",SC=0:"NSC^N",1:"^")
 . S PROB=PROB_U_$$TXFCTR(GMPL1)_U_SCTC_U_SCTD_U_VHATC_U_VHATD_U_CODESTAT_U_GMPCSYS
 . S ^TMP("IB",$J,"INTERFACES","GMP SELECT PATIENT ACTIVE PROBLEMS",CNT)=PROB
 S ^TMP("IB",$J,"INTERFACES","GMP SELECT PATIENT ACTIVE PROBLEMS",0)=CNT
 Q
 ;
TXFCTR(GMPL1) ;Determine Treatment Factor, if any
 N NXTTF,TXFACTOR
 S TXFACTOR="^"
 F NXTTF=11,12,13,15,16,17,18 I $P(GMPL1,U,NXTTF) S TXFACTOR=$P("A^Agent Orange;I^Ionizing Radiation;E^Env. Contaminants;;H^Head/Neck Cancer;M^Mil Sexual Trauma;C^Combat Vet;S^SHAD",";",NXTTF-10) Q
 Q TXFACTOR
