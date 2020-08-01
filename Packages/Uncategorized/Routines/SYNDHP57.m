SYNDHP57 ; HC/fjf/art - HealthConcourse - get patient allergies ;07/23/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ; ---------------- Get patient allergies ------------------------------
 ;
PATALLI(RETSTA,DHPICN,FRDAT,TODAT,RETJSON) ; Patient allergies for ICN
 ;
 ; Return patient allergies for a given patient ICN
 ;
 ; Input:
 ;   DHPICN  - unique patient identifier across all VistA systems
 ;   FRDAT   - from date (inclusive), optional, compared to origination date/time
 ;   TODAT   - to date (inclusive), optional, compared to origination date/time
 ;   RETJSON - J = Return JSON
 ;             F = Return FHIR
 ;             0 or null = Return allergies string (default)
 ; Output:
 ;   RETSTA  - a delimited string that lists SNOMED CDT codes for the patient allergies
 ;           - ICN^allergen|SCT:code|origination dt/tm|type|verified flag|resource id~reaction:sct code:severity^...
 ;             or if no reaction: ICN^allergen|SCT:code|origination dt/tm|type|verified flag|resource id^...
 ;          or patient allergies in JSON format
 ;
 ; validate ICN
 I $G(DHPICN)="" S RETSTA="-1^What patient?" QUIT
 I '$$UICNVAL^SYNDHPUTL(DHPICN) S RETSTA="-1^Patient identifier not recognised" QUIT
 ;
 S FRDAT=$S($G(FRDAT):$$HL7TFM^XLFDT(FRDAT),1:1000101)
 S TODAT=$S($G(TODAT):$$HL7TFM^XLFDT(TODAT),1:9991231)
 I $G(DEBUG) W !,"FRDAT: ",FRDAT,"   TODAT: ",TODAT,!
 I FRDAT>TODAT S RETSTA="-1^From date is greater than to date" QUIT
 ;
 ; get patient IEN from ICN
 N PATIEN S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 I PATIEN="" S RETSTA="-1^Internal data structure error" QUIT
 ;
 N ALLARRAY
 S RETSTA=$$ALLERGIES(.ALLARRAY,PATIEN,DHPICN,FRDAT,TODAT)
 ;
 ;I $G(RETJSON)="F" D xxx  ;create array for FHIR
 ;
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . S RETSTA=""
 . D TOJASON^SYNDHPUTL(.ALLARRAY,.RETSTA)
 ;
 QUIT
 ;
ALLERGIES(ALLARRAY,PATIEN,DHPICN,FRDAT,TODAT) ; get allergies for a patient
 ;
 N ZARR
 N V S V="_"
 N P S P="|"
 N S S S=";"
 N USER S USER=$$DUZ^SYNDHP69
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 I $G(DEBUG) W !,"Allergies",!
 ;
 N x,AID,ADATEFM,ADATE,REACTANT,ALGE,ALLERGENI,ATYPE,ATYPET,AVERT,AEIER
 N RE85IEN,REACTION,ENTBY,ENTDATE,RSEV,IENS,ALLERGIES,FT,TX,O,CS
 N ALLRET S ALLRET=DHPICN
 N FNUM S FNUM=120.8 ;patient allergies
 ; scan Patient Allergies B index
 N ALLIEN S ALLIEN=""
 F x=1:1 S ALLIEN=$O(^GMR(FNUM,"B",PATIEN,ALLIEN)) QUIT:ALLIEN=""  D
 . N ALLERGY
 . D GET1ALLERGY^SYNDHP16(.ALLERGY,ALLIEN,0)
 . I $D(ALLERGY("Allergy","ERROR")) M ALLARRAY("Allergies",ALLIEN)=ALLERGY QUIT
 . S AID=ALLERGY("Allergy","resourceId")
 . S ADATEFM=ALLERGY("Allergy","originationDateTimeFM")
 . QUIT:'$$RANGECK^SYNDHPUTL(ADATEFM,FRDAT,TODAT)  ;quit if outside of requested date range
 . S ADATE=ALLERGY("Allergy","originationDateTimeHL7")
 . S REACTANT=ALLERGY("Allergy","reactant")
 . S FT=" ( FREE TEXT )"
 . I REACTANT[FT S REACTANT=$P(REACTANT,FT)
 . S ALGE=REACTANT
 . S ALLERGENI=ALLERGY("Allergy","gmrAllergyId")
 . I $P(ALLERGENI,S,2)["PS" S REACTANT=$P($$GVREF(ALLERGENI),U,2)
 . S ATYPE=ALLERGY("Allergy","allergyType")
 . S ATYPET=ALLERGY("Allergy","allergyTypeFHIR")
 . S AVERT=ALLERGY("Allergy","verified")
 . S AEIER=ALLERGY("Allergy","enteredInError")
 . S AVERT=$S(AVERT="YES":"confirmed",AEIER="YES":"entered-in-error",1:"unconfirmed")
 . ;get severity from file 120.85
 . S RE85IEN=$O(^GMR(120.85,"C",ALLIEN,""))
 . S RSEV=$$GET1^DIQ(120.85,RE85IEN_",",14.5)
 . S ALLERGY("Allergy","severity")=RSEV
 . S ALLERGY("Allergy","severityCd")=$$GET1^DIQ(120.85,RE85IEN_",",14.5,"I")
 . S ALLERGIES(x)=AID_U_ADATEFM_U_ADATE_U_REACTANT_U_ALLERGENI_U_ATYPE_U_ATYPET_U_AVERT_U_AEIER_U_RSEV
 . ;get reactions
 . N y
 . S IENS=""
 . F y=1:1 S IENS=$O(ALLERGY("Allergy","reactionss","reactions",IENS)) QUIT:IENS=""  D
 . . S REACTION=ALLERGY("Allergy","reactionss","reactions",IENS,"reaction")
 . . S ENTBY=ALLERGY("Allergy","reactionss","reactions",IENS,"enteredBy")
 . . S ENTDATE=ALLERGY("Allergy","reactionss","reactions",IENS,"dateEnteredHL7")
 . . S ALLERGIES(x,y)=AID_U_REACTION_U_ENTBY_U_ENTDATE_U_RSEV_U_ATYPET
 . M ALLARRAY("Allergies",ALLIEN)=ALLERGY ;
 . ;
 . I $G(DEBUG) D
 . . W "ADATE:",ADATE,!
 . . W "REACTANT:",REACTANT,!
 . . W "ALGE:",ALGE,!
 . . W "ALLERGENI:",ALLERGENI,!
 . . W "ATYPE:",ATYPE,!
 . . W "ATYPET:",ATYPET,!
 . . W "AVERT:",AVERT,!
 . . W "AEIER:",AEIER,!
 . . W "RE85IEN:",RE85IEN,!
 . . W "RSEV:",RSEV,!
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("ALLERGIES") W !
 ;
 ; serialize data
 N N,SCT,AIEN,ALGN,ALGE,ADATE,ATYPET,AVERT,RSEV,AID,ATYNODE,ATYPTX,ATYPET,GMRID
 S (SCT,AIEN)=""
 S ALGN=""
 F  S ALGN=$O(ALLERGIES(ALGN)) QUIT:ALGN=""  D
 . S ALGE=$P(ALLERGIES(ALGN),U,4)
 . S ADATE=$P(ALLERGIES(ALGN),U,3)
 . S GMRID=$P(ALLERGIES(ALGN),U,5)
 . S ATYPET=$P(ALLERGIES(ALGN),U,7)
 . S AVERT=$P(ALLERGIES(ALGN),U,8)
 . S RSEV=$P(ALLERGIES(ALGN),U,10)
 . S AID=$P(ALLERGIES(ALGN),U,1)
 . S ATYNODE=$O(ALLERGIES(ALGN,""))
 . S (ATYPTX,ATYPET)=""
 . I ATYNODE'="" D
 . . S ATYPTX=$G(ALLERGIES(ALGN,ATYNODE))
 . . S ATYPET=$P($G(ATYPTX),U,6)
 . N VMAP
 . I $P(GMRID,S,2)["PS" D
 . . S VUID=+$$GVREF(GMRID)
 . . S VMAP=$$MVUID(VUID,"VMAP")
 . I $P(GMRID,S,2)'["PS" D
 . . S CODE=$$MAPR^SYNDHPMP(ALGE,"T","A")
 . . S VMAP("SCT",CODE)=""
 . S (CS,N,O)=""
 . F  S N=$O(VMAP(N)) Q:N=""  F  S O=$O(VMAP(N,O)) Q:O=""  S CS=CS_N_":"_O_"~"
 . S CS=$RE($E($RE(CS),2,$L(CS)))
 . S ALLRET=ALLRET_U_ALGE_P_CS_P_ADATE_P_ATYPET_P_AVERT_P_AID
 . S N=""
 . F  S N=$O(ALLERGIES(ALGN,N)) Q:N=""  D
 . . S TX=ALLERGIES(ALGN,N)
 . . S REACTION=$P(TX,U,2)
 . . S ALLRET=ALLRET_"~"_REACTION_":"_$$MAPR^SYNDHPMP(REACTION,"T","R")_":"_$$LOW^XLFSTR(RSEV)
 . ;
 . I $G(DEBUG) D
 . . W "ALGE:",ALGE,!
 . . W "ADATE:",ADATE,!
 . . W "ATYPET:",ATYPET,!
 . . W "AVERT:",AVERT,!
 . . W "RSEV:",RSEV,!
 . . W "AID:",AID,!
 . . W "ATYNODE:",ATYNODE,!
 . . W "ATYPTX:",ATYPTX,!
 . . W "CS:",CS,!!
 ;
 QUIT ALLRET
 ;
 ;  -------------- Utility functions
 ;
VXMAPR(SURFORM,SFTYPE,MAOR) ; map reactions (SNOMED CT) - - redundant code - remove when sure
 ; map an allergic reaction surface form to an SCT code
 ; Input:
 ;   SURFORM - surface form
 ;   TYPE    - type of surface form
 ;             I - IEN
 ;             T - term
 ;   MAOR    - allergen or reaction
 ;             A - Allergen
 ;             R - Reaction
 ;
 I SFTYPE'="I",SFTYPE'="T" Q "-1^Type unrecognised - should be I or T"
 I MAOR'="A",MAOR'="R" Q "-1^Allergy/Reaction indicator unrecognised - should be A or R"
 N RSUB,INDX
 S RSUB=$S(MAOR="A":"ALLERGENS",1:"REACTIONS")
 S INDX=$S(SFTYPE="I":"ICT",1:"TCI")
 I '$D(^SYN("2002.010",RSUB,INDX,SURFORM)) Q ""  ; <<<<<< this global is missing
 QUIT $O(^SYN("2002.010",RSUB,INDX,SURFORM,""))
 ;
GVREF(ALLERGEN) ; map allergens (SNOMED CT, NDFRT, RxNorm, VANDF, etc)
 ; GMRD - SNOMED CT
 N S S S=";"
 ;I $P(ALLERGEN,S,2)["GMRD" D MAPGMRD QUIT MAPS
 I $P(ALLERGEN,S,2)["PSDRUG" QUIT $$VDRUG()
 I $P(ALLERGEN,S,2)["PSNDF" QUIT $$VPSNDF()
 I $P(ALLERGEN,S,2)["PS(50.416" QUIT $$VP50416()
 I $P(ALLERGEN,S,2)["PS(50.605" QUIT $$VP50605()
 QUIT
 ;
VDRUG() ;
 N PSDIEN,GENNAM,FPFOS,VUID,VMAP
 ;W !,N,"  -  ",INT,"  -  ",EXT
 S PSDIEN=+$P(ALLERGEN,";")
 ;W !,$$GET1^DIQ(50,PSDIEN_",",64,"E")
 S GENNAM=$$GET1^DIQ(50,PSDIEN_",",64,"E")
 ;W !,$O(^PS(50.416,"B",GENNAM,""))
 I '$D(^PS(50.416,"B",GENNAM)) QUIT "not found"
 S FPFOS=$O(^PS(50.416,"B",GENNAM,""))
 S VUID=$$GET1^DIQ(50.416,FPFOS_",","VUID")
 S VMAP=$$MVUID(VUID,"VMAP")
 QUIT VUID_U_GENNAM
 ;
 ;
VPSNDF() ;
 N PSDIEN,GENNAM,VUID
 S PSDIEN=+$P(ALLERGEN,";")
 S GENNAM=$$GET1^DIQ(50.6,PSDIEN_",",.01,"E")
 S VUID=$$GET1^DIQ(50.6,PSDIEN_",","VUID")
 QUIT VUID_U_GENNAM
 ;
VP50416() ;
 N PSDIEN,GENNAM,VUID
 S PSDIEN=+$P(ALLERGEN,";")
 S GENNAM=$$GET1^DIQ(50.416,PSDIEN_",",.01,"E")
 S VUID=$$GET1^DIQ(50.416,PSDIEN_",","VUID")
 QUIT VUID_U_GENNAM
 ;
VP50605() ;
 N PSDIEN,GENNAM,VUID
 S PSDIEN=+$P(ALLERGEN,";")
 S GENNAM=$$GET1^DIQ(50.605,PSDIEN_",",1,"E")
 S VUID=$$GET1^DIQ(50.605,PSDIEN_",","VUID")
 QUIT VUID_U_GENNAM
 ;
LYNX ;
 N EXT,INT
 N N S N=0
 N F S F=120.8
 F  S N=$O(^GMR(F,N)) Q:+N=0  D
 .S INT=$$GET1^DIQ(F,N_",",1,"I")
 .S EXT=$$GET1^DIQ(F,N_",",1,"E")
 .I $P(INT,";",2)["GMRD" Q
 .;I $P(INT,";",2)["PSDRUG" D LPSDRUG Q
 .I $P(INT,";",2)["PSNDF" D LPSNDF Q
 .W !,N,"  -  ",INT,"  -  ",EXT
 Q
 ;
LPSNDF ;
 Q
 W !,N,"  -  ",INT,"  -  ",EXT
 N PSDIEN,VUID
 S PSDIEN=+$P(INT,";")
 S VUID=$$GET1^DIQ(50.6,PSDIEN_",","VUID")
 W !,VUID
 Q
 ;
MVUID(VUID,MAP) ;  ******   needs work  ******
 ; map VUID to RXNORM sources ; Should be RxNorm
 N VMAP,RXCUI,SRC,CODE
 S VMAP("VANDF",VUID)=""
 S RXCUI=""
 F  S RXCUI=$O(^SYN("2002.020","IXVANDF",VUID,RXCUI)) Q:RXCUI=""  D
 .F SRC="RXNORM","NDFRT" D
 ..S CODE=""
 ..F  S CODE=$O(^SYN("2002.020",RXCUI,SRC,CODE)) Q:CODE=""  D
 ...S VMAP(SRC,CODE)=""
 M @MAP=VMAP
 Q MAP
 ;
KILL ;
 ;K AEIER,AID,ALLERGENI,CS,CODE,V,VMAP,SRC,RXCUI,ATYPET,GENNAM,REACT,REACTS,VUID
 ;K ALLERGY,AVERT,ATYPE,S,ALGN,PSDRUG
 Q
 ;
 ; ----------- Unit Test -----------
T1 ;
 N ICN S ICN="10111V183702"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON=""
 N RETSTA
 D PATALLI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA"),!!
 QUIT
 ;
T2 ;
 N ICN S ICN="10111V183702"
 N FRDAT S FRDAT=20000101
 N TODAT S TODAT=20050101
 N JSON S JSON=""
 N RETSTA
 D PATALLI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA"),!!
 QUIT
 ;
T3 ;
 N ICN S ICN="10111V183702"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON="J"
 N RETSTA
 D PATALLI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA"),!!
 QUIT
 ;
TESTS ;
ALLTEST0 ; pass
 D PATALLI(.RETSTA,"10111V183702")
 W $$ZW^SYNDHPUTL("RETSTA"),!!
 Q
PROTEST ; in keeping with the spirit of the times
 n icn,pien
 s icn=""
 f  s icn=$o(^DPT("AFICN",icn)) q:icn=""  d
 .s pien=""
 .f  s pien=$o(^DPT("AFICN",icn,pien)) q:pien=""  d
 ..q:'$d(^GMR(120.8,"B",pien))
 ..k output
 ..k (icn,pien)
 ..d PATALLI(.output,icn)
 ..;i output["RXNORM" q
 ..;i output["NDFRT" q
 ..;i output'["VANDF" q
 ..W !!!!!!!! W $$ZW^SYNDHPUTL("output")
 q
