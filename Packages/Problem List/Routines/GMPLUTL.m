GMPLUTL ; SLC/MKB/KER/TC -- PL Utilities ;03/30/2020
 ;;2.0;Problem List;**3,6,8,10,16,26,35,39,36,42,40,50,53**;Aug 25, 1994;Build 159
 ;
 ; External References
 ;   DBIA    348  ^DPT(
 ;    ICR   5699  $$ICDDATA^ICDXCODE
 ;   DBIA  10006  ^VA(200
 ;
ACTIVE(GMPDFN,GMPL) ; Returns list of Active Problems for a Patient
 ;
 ;   GMPDFN   Pointer to Patient
 ;   GMPL     Array in which the problems will be
 ;            returned, passed by reference
 ;
 ;   GMPL(#,0)  Problem file (#9000011) IEN
 ;   GMPL(#,1)  Piece 1:  Pointer to Problem (Lexicon file #757.01)
 ;                    2:  Provider Narrative
 ;                 NOTE:  the provider narrative may be different
 ;                        from the Lexicon term in file 757.01
 ;   GMPL(#,2)  Piece 1:  Pointer to ICD Diagnosis (file #80)
 ;                    2:  ICD-9/10 Code
 ;   GMPL(#,3)  Piece 1:  Internal Date of Onset
 ;                    2:  External Date of Onset 00/00/00
 ;   GMPL(#,4)  Piece 1:  Abbreviated Service Connection
 ;                            SC^Service Connected
 ;                            NSC^Not Service Connected
 ;                            null
 ;                    2:  Full text Service Connection
 ;   GMPL(#,5)  Piece 1:  Abbreviated Exposure
 ;                        Full text Exposure
 ;                            AO^Agent Orange
 ;                            IR^Radiation
 ;                            EC^Evn Contaminants
 ;                            HNC^Head/Neck Cancer
 ;                            MST^Mil Sexual Trauma
 ;                            CV^Combat Vet
 ;                            SHD^SHAD
 ;                            null
 ;
 N IFN,CNT,SP,NUM,GMPLIST,GMPLVIEW,GMPARAM,GMPTOTAL
 Q:$G(GMPDFN)'>0  S CNT=0,SP=""
 S GMPARAM("QUIET")=1,GMPARAM("REV")=$P($G(^GMPL(125.99,1,0)),U,5)="R"
 S GMPLVIEW("ACT")="A",GMPLVIEW("PROV")=0,GMPLVIEW("VIEW")=""
 D GETPLIST^GMPLMGR1(.GMPLIST,.GMPTOTAL,.GMPLVIEW)
 F NUM=0:0 S NUM=$O(GMPLIST(NUM)) Q:NUM'>0  D
 . N I,GMPL0,GMPL1,GMPL802,ICDC,GMPCSYS,GMPDT,ONSET
 . S IFN=+GMPLIST(NUM) Q:IFN'>0
 . S GMPL0=$G(^AUPNPROB(IFN,0)),GMPL1=$G(^(1)),GMPL802=$G(^(802)),CNT=CNT+1,GMPL(CNT,0)=IFN
 . S GMPDT=$S(+$P(GMPL802,U,1):$P(GMPL802,U,1),1:$P(GMPL0,U,8)),GMPCSYS=$S($P(GMPL802,U,2)]"":$P(GMPL802,U,2),1:$$SAB^ICDEX($$CSI^ICDEX(80,+GMPL0),GMPDT))
 . S ICDC=$P($$ICDDATA^ICDXCODE(GMPCSYS,+GMPL0,GMPDT,"I"),U,2)
 . S GMPL(CNT,1)=+GMPL1_U_$$PROBTEXT^GMPLX(IFN)
 . S GMPL(CNT,2)=+GMPL0_U_ICDC,ONSET=$P(GMPL0,U,13)
 . S GMPL(CNT,3)=$S(ONSET:ONSET_U_$$EXTDT^GMPLX(ONSET),1:"")
 . S GMPL(CNT,4)=$S(+$P(GMPL1,U,10):"SC^SERVICE-CONNECTED",$P(GMPL1,U,10)=0:"NSC^NOT SERVICE-CONNECTED",1:"")
 . F I=11,12,13,15,16,17,18 S:$P(GMPL1,U,I) SP=$S(I=11:"A",I=12:"I",I=13:"P",I=15:"H",I=16:"M",I=17:"C",1:"S")
 . S GMPL(CNT,5)=$S(SP="A":"AO^AGENT ORANGE",SP="I":"IR^RADIATION",SP="P":"EC^ENV CONTAMINANTS",SP="H":"HNC^HEAD AND/OR NECK CANCER",SP="M":"MST^MILIARY SEXUAL TRAUMA",SP="C":"CV^COMBAT VET",SP="S":"SHD^SHAD",1:"")
 S GMPL(0)=CNT
 Q
 ;
CREATE(PL,PLY) ; Creates a new problem
 ;
 ;  Input array, passed by reference
 ;    Required
 ;      PL("PATIENT")    Pointer to Patient #2
 ;      PL("NARRATIVE")  Text as entered by provider
 ;      PL("PROVIDER")   Pointer to provider #200
 ;    Optional
 ;      PL("DIAGNOSIS")  Pointer to ICD-9 #80
 ;      PL("LEXICON")    Pointer to Lexicon #757.01
 ;      PL("STATUS")     A = Active   I = Inactive
 ;      PL("ONSET")      Internal Date of Onset
 ;      PL("RECORDED")   Internal Date Recorded
 ;      PL("RESOLVED")   Internal Date Problem was Resolved
 ;      PL("COMMENT")    Comment text, up to 60 characters
 ;      PL("LOCATION")   Pointer to Hospital Location
 ;      PL("SC")         Service Connected 1 = Yes 0 = No
 ;      PL("AO")         Agent Orange      1 = Yes 0 = No
 ;      PL("IR")         Radiation         1 = Yes 0 = No
 ;      PL("EC")         Env Contamination 1 = Yes 0 = No
 ;      PL("HNC")        Head/Neck Cancer  1 = Yes 0 = No
 ;      PL("MST")        Mil Sexual Trauma 1 = Yes 0 = No
 ;      PL("CV")         Combat Vet        1 = Yes 0 = No
 ;      PL("SHD")        Shipboard Hazard & Defense 1=Yes  0=No
 ;      PL("DX_DATE_OF_INTEREST") For historical encounters (=Today's date) & all other encounters (=encounter date/time)
 ;
 ;  Output, passed by reference
 ;      PLY              Equivalent of Fileman Y, DA
 ;      PLY(0)           Equivalent of Fileman Y(0)
 ;
 N GMPI,GMPQUIT,GMPVAMC,GMPVA,GMPFLD,GMPSC,GMPAGTOR,GMPION,GMPGULF
 N GMPHNC,GMPMST,GMPCV,GMPSHD,DA,GMPDFN,GMPROV
 K PLY S PLY=-1,PLY(0)=""
 S GMPVAMC=+$G(DUZ(2)),GMPVA=$S($G(DUZ("AG"))="V":1,1:0)
 I '$L($G(PL("NARRATIVE"))) S PLY(0)="Missing problem narrative" Q
 ;ICR #6953
 I $P($$PROVNARR^PXAPI(PL("NARRATIVE"),""),U,1)=-1 S PLY(0)="Invalid problem narrative" Q
 I '$D(^DPT(+$G(PL("PATIENT")),0)) S PLY(0)="Invalid patient" Q
 I '$D(^VA(200,+$G(PL("PROVIDER")),0)) S PLY(0)="Invalid provider" Q
 S GMPDFN=+PL("PATIENT"),(GMPSC,GMPAGTOR,GMPION,GMPGULF,GMPHNC,GMPMST,GMPCV,GMPSHD)=0
 S:'$L($G(PL("DX_DATE_OF_INTEREST"))) PL("DX_DATE_OF_INTEREST")=$$DT^XLFDT
 D:GMPVA VADPT^GMPLX1(GMPDFN)
 F GMPI="DIAGNOSI","LEXICON","DUPLICAT","LOCATION","STATUS" D @(GMPI_"^GMPLUTL1") Q:$D(GMPQUIT)
 Q:$D(GMPQUIT)
 F GMPI="ONSET","RESOLVED","RECORDED","SC","AO","IR","EC","HNC","MST","CV","SHD" D @(GMPI_"^GMPLUTL1") Q:$D(GMPQUIT)
 Q:$D(GMPQUIT)
CR1 ; Ok to Create
 I $S(PL("LEXICON")=1:1,PL("LEXICON")="":1,$P(PL("LEXICON"),U,2)']"":1,1:0),(PL("NARRATIVE")["SNOMED CT") D FIXLEX(.PL)
 S GMPFLD(.01)=PL("DIAGNOSIS")_U_$S(PL("NARRATIVE")["(ICD-9-CM":$P($P(PL("NARRATIVE"),"ICD-9-CM ",2),")"),1:"")
 S GMPFLD(1.01)=PL("LEXICON")
 S GMPFLD(.05)=U_$E(PL("NARRATIVE"),1,80)
 S (GMPROV,GMPFLD(1.04),GMPFLD(1.05))=+PL("PROVIDER")
 S GMPFLD(1.06)=$$SERVICE^GMPLX1(+PL("PROVIDER"))
 S GMPFLD(.13)=PL("ONSET"),GMPFLD(1.09)=PL("RECORDED")
 S GMPFLD(1.02)=$S('$P(^GMPL(125.99,1,0),U,2):"P",$G(GMPLUSER):"P",1:"T")
 S GMPFLD(.12)=PL("STATUS"),GMPFLD(1.14)="",GMPFLD(1.07)=PL("RESOLVED")
 S GMPFLD(10,0)=0,GMPFLD(1.03)=$G(DUZ),GMPFLD(1.08)=PL("LOCATION")
 S:$L($G(PL("COMMENT"))) GMPFLD(10,"NEW",1)=$E(PL("COMMENT"),1,60)
 S GMPFLD(1.1)=PL("SC"),GMPFLD(1.11)=PL("AO"),GMPFLD(1.12)=PL("IR")
 S GMPFLD(1.13)=PL("EC"),GMPFLD(1.15)=$G(PL("HNC")),GMPFLD(1.16)=$G(PL("MST"))
 S GMPFLD(1.17)=$G(PL("CV")),GMPFLD(1.18)=$G(PL("SHD"))
 S GMPFLD(80201)=$G(PL("DX_DATE_OF_INTEREST"))
 D NEW^GMPLSAVE S PLY=DA
CRQ ; Quit Create
 Q
 ;
FIXLEX(PL) ; Fix Lexicon expression pointer value for SNOMED Concepts
 N SCT,LEXS,ICDS
 S SCT=+$P(PL("NARRATIVE"),"SNOMED CT ",2) I +SCT'>0 Q
 D EN^LEXCODE(SCT) I '$D(LEXS("SCT",1)) Q
 S PL("NARRATIVE")=$P(PL("NARRATIVE")," (SNOMED CT")
 S PL("LEXICON")=$P(LEXS("SCT",1),U)_U_PL("NARRATIVE")_" (SNOMED CT "_SCT_")"
 S ICDS=$$GETDX(SCT,$G(PL("DX_DATE_OF_INTEREST")))
 S:($L(ICDS,"/")>1)&(ICDS'=$P($G(PL("DIAGNOSIS")),U,2)) $P(PL("DIAGNOSIS"),U,2)=ICDS
 Q
 ;
GETDX(CODE,GMPDT) ; Get ICD associated with SNOMED CT Code
 N LEX,ORI,ORY,GMPIMPDT,GMPMPDEF S GMPDT=$G(GMPDT,$$DT^XLFDT)
 S ORY=0,GMPIMPDT=$$IMPDATE^LEXU("10D")
 S GMPMPDEF=$S(GMPDT<GMPIMPDT:"SCT2ICD",1:"SCT210D")
 S ORY=$$GETASSN^LEXTRAN1(CODE,GMPMPDEF,GMPDT)
 I $S(+ORY'>0:1,+$P(ORY,U,2)'>0:1,+LEX'>0:1,1:0) S ORY=$S(GMPDT<GMPIMPDT:"799.9",1:"R69.") G GETDXX
 S (ORI,ORY)=0
 F  S ORI=$O(LEX(ORI)) Q:+ORI'>0  D
 . N ICD
 . S ICD=$O(LEX(ORI,""))
 . I ICD]"" S ORY=$S(ORY'=0:ORY_"/",1:"")_ICD
 I ORY'["." S ORY=ORY_"."
GETDXX Q ORY
 ;
UPDATE(PL,PLY) ; Update a Problem/Create if Not Found
 ;
 ;  Input array, passed by reference
 ;    Required
 ;      PL("PROBLEM")    Pointer to Problem #9000011
 ;      PL("PROVIDER")   Pointer to provider #200
 ;
 ;    Optional
 ;      PL("NARRATIVE")  Text as entered by provider
 ;      PL("DIAGNOSIS")  Pointer to ICD-9 #80
 ;      PL("LEXICON")    Pointer to Lexicon #757.01
 ;      PL("STATUS")     A = Active   I = Inactive
 ;      PL("ONSET")      Internal Date of Onset
 ;      PL("RECORDED")   Internal Date Recorded
 ;      PL("RESOLVED")   Internal Date Problem was Resolved
 ;      PL("COMMENT")    Comment text, up to 60 characters
 ;      PL("LOCATION")   Pointer to Hospital Location
 ;      PL("SC")         Service Connected 1 = Yes 0 = No
 ;      PL("AO")         Agent Orange      1 = Yes 0 = No
 ;      PL("IR")         Radiation         1 = Yes 0 = No
 ;      PL("EC")         Env Contamination 1 = Yes 0 = No
 ;      PL("HNC")        Head/Neck Cancer  1 = Yes 0 = No
 ;      PL("MST")        Mil Sexual Trauma 1 = Yes 0 = No
 ;      PL("CV")         Combat Veteran    1 = Yes 0 = No
 ;      PL("SHD")        SHAD              1 = Yes 0 = No
 ;      PL("SCTC")       SNOMED CT Concept Code
 ;      PL("SCTD")       SNOMED CT Designation Code
 ;      PL("CODEDT")     Date of interest for the primary ICD Diagnosis
 ;      PL("CODESYS")    Coding system of the primary ICD Diagnosis
 ;      PL("DX_DATE_OF_INTEREST") For historical encounters (=Today's date) & all other encounters (=encounter date/time)
 ;
 ;  Output, passed by reference
 ;      PLY              Equivalent of Fileman Y, DA
 ;      PLY(0)           Equivalent of Fileman Y(0)
 ;
 N GMPORIG,GMPFLD,FLD,ITEMS,SUB,GMPI,DIFFRENT,GMPIFN,GMPVAMC,GMPVA,GMPROV,GMPQUIT,GMPDFN
 N GMPSC,GMPAGTOR,GMPION,GMPGULF
 S GMPVAMC=+$G(DUZ(2)),GMPVA=$S($G(DUZ("AG"))="V":1,1:0),PLY=-1,PLY(0)=""
 S GMPIFN=$G(PL("PROBLEM")) I GMPIFN="" D CREATE(.PL,.PLY) Q
 I '$D(^AUPNPROB(GMPIFN,0)) S PLY(0)="Invalid problem" Q
 I '$D(^VA(200,+$G(PL("PROVIDER")),0)) S PLY(0)="Invalid provider" Q
 S GMPROV=+$G(PL("PROVIDER")),GMPDFN=+$P(^AUPNPROB(GMPIFN,0),U,2)
 D GETFLDS^GMPLEDT3(GMPIFN) I '$D(GMPFLD) S PLY(0)="Invalid problem" Q
 I +$G(PL("PATIENT")),+PL("PATIENT")'=GMPDFN S PLY(0)="Patient does not match for this problem" Q
 I $L($G(PL("RECORDED"))) S PLY(0)="Date Recorded is not editable" Q
 S (GMPSC,GMPAGTOR,GMPION,GMPGULF)=0 D:GMPVA VADPT^GMPLX1(GMPDFN)
 S:'$L($G(PL("DX_DATE_OF_INTEREST"))) PL("DX_DATE_OF_INTEREST")=$$DT^XLFDT
 I '$L($G(PL("CODESYS"))),$L($G(PL("DIAGNOSIS"))) D
 . S PL("CODESYS")=$$SAB^ICDEX($$CSI^ICDEX(80,+PL("DIAGNOSIS")),PL("DX_DATE_OF_INTEREST"))
 S ITEMS="LEXICON^DIAGNOSIS^LOCATION^STATUS^ONSET^RESOLVED^SC^AO^IR^EC^HNC^MST^CV^SHD",FLD="1.01^.01^1.08^.12^.13^1.07^1.1^1.11^1.12^1.13^1.15^1.16^1.17^1.18"
 F GMPI=1:1 S SUB=$P(ITEMS,U,GMPI) Q:SUB=""  D  Q:$D(GMPQUIT)
 . I '$L($G(PL(SUB))) S PL(SUB)=$P(GMPFLD($P(FLD,U,GMPI)),U) Q
 . I SUB="STATUS",PL(SUB)="@" S GMPQUIT=1,PLY(0)="Cannot delete problem status" Q
 . I PL(SUB)'="@" D @($E(SUB,1,8)_"^GMPLUTL1") Q:$D(GMPQUIT)
 . S GMPFLD($P(FLD,U,GMPI))=$S(PL(SUB)="@":"",1:PL(SUB)),DIFFRENT=1
 Q:$D(GMPQUIT)
 I +GMPFLD(1.07),GMPFLD(1.07)<GMPFLD(.13) S PLY(0)="Date Resolved cannot be prior to Date of Onset" Q
 I +GMPFLD(1.09),GMPFLD(1.09)<GMPFLD(.13) S PLY(0)="Date Recorded cannot be prior to Date of Onset" Q
 I $P($G(PL("NARRATIVE")),U,1)=-1 S PLY(0)="Invalid Provider Narrative" Q
 S:$L($G(PL("NARRATIVE"))) GMPFLD(.05)=U_PL("NARRATIVE"),DIFFRENT=1
 S:$L($G(PL("COMMENT"))) GMPFLD(10,"NEW",1)=$E(PL("COMMENT"),1,60),DIFFRENT=1
 D:$D(DIFFRENT) EN^GMPLSAVE S PLY=GMPIFN,PLY(0)=""
 Q
