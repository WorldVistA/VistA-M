LEXHLP2 ;ISL/KER - Look-up Response (Help Text) ;04/21/2014
 ;;2.0;LEXICON UTILITY;**80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^UTILITY($J         ICR  10011
 ;               
 ; External References
 ;    ^DIWP               ICR  10011
 ;    $$FMTE^XLFDT        ICR  10103
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     LEX     Help Array KILLed in LEXAR3
 ;     LEX2    Example Text NEWed in LEXAR3
 ;     LEX3    Example Text NEWed in LEXAR3
 ;     LEX4    Example Text NEWed in LEXAR3
 ;     LEXCT   Counter NEWed in LEXAR3
 ;     LEXEX   Expression NEWed in LEXAR3
 ;     LEXFIL  Search Filter NEWed in LEXAR3
 ;     LEXHDT  Search Date NEWed in LEXAR3
 ;     LEXIDT  Implementation Date NEWed in LEXAR3
 ;     LEXOK   Text OK NEWed in LEXAR3
 ;     LEXY    Help System  NEWed in LEXAR3
 ;               
HICD ;     ICD-9 Dx Help
 S LEXC="V18.0",LEXS="ICD-9-CM",LEX2="DIABETES MELL"
 S LEX3="HIST DIAB MELL",LEX4="FAM HIST DIAB MELL" S LEXOK=1
 S LEXEX="Family History of Diabetes Mellitus"
 N ICD10 S ICD10=$$IMPDATE^LEXU("10D")
 I +($G(LEXHDT))>0&($G(LEXHDT)?7N)&(+($G(LEXHDT))'<ICD10) D
 . D:$G(LEXFIL)["$$DX^LEXU" H10D
 Q
N10D ;     No ICD-10 Dx
 N LEXSD,LEXED,LEXSP S LEXSP="      "
 S LEXSD=$TR($$FMTE^XLFDT($G(LEXHDT),"5DZ"),"@"," ") Q:$L(LEXSD)'=10
 S LEXED=$TR($$FMTE^XLFDT($G(LEXIDT),"5DZ"),"@"," ") Q:$L(LEXED)'=10
 K LEXP S LEXP(1)="This is not a valid search.  You are searching "
 S LEXP(1)=LEXP(1)_"for terminology that is linked to an ICD-10 "
 S LEXP(1)=LEXP(1)_"diagnosis code on "_LEXSD_".  There are no "
 S LEXP(1)=LEXP(1)_"ICD-10-CM codes active before "_LEXED_"."
 K LEX("HLP") D PR(.LEXP,70) S LEXCT=$O(LEX("HLP"," "),-1),LEXI=0
 F  S LEXI=$O(LEXP(LEXI)) Q:+LEXI'>0  D
 . N LEXT S LEXT=$G(LEXP(LEXI)),LEXCT=LEXCT+1
 . S LEX("HLP",LEXCT)=LEXSP_LEXT
 . S LEX("HLP",0)=LEXCT,LEXOK=1
 Q
N10P ;     No ICD-10 Pr
 N LEXSD,LEXED,LEXSP S LEXSP="      "
 S LEXSD=$TR($$FMTE^XLFDT($G(LEXHDT),"5DZ"),"@"," ") Q:$L(LEXSD)'=10
 S LEXED=$TR($$FMTE^XLFDT($G(LEXIDT),"5DZ"),"@"," ") Q:$L(LEXED)'=10
 K LEXP S LEXP(1)="This is not a valid search.  You are searching "
 S LEXP(1)=LEXP(1)_"for terminology that is linked to an ICD-10 "
 S LEXP(1)=LEXP(1)_"procedure code on "_LEXSD_".  There are no "
 S LEXP(1)=LEXP(1)_"ICD-10-PCS codes active before "_LEXED_"."
 K LEX("HLP") D PR(.LEXP,70) S LEXCT=$O(LEX("HLP"," "),-1),LEXI=0
 F  S LEXI=$O(LEXP(LEXI)) Q:+LEXI'>0  D
 . N LEXT S LEXT=$G(LEXP(LEXI)),LEXCT=LEXCT+1
 . S LEX("HLP",LEXCT)=LEXSP_LEXT
 . S LEX("HLP",0)=LEXCT,LEXOK=1
 Q
N10 ;     No ICD-10 Dx/Pr
 N LEXSD,LEXED,LEXSP S LEXSP="      "
 S LEXSD=$TR($$FMTE^XLFDT($G(LEXHDT),"5DZ"),"@"," ") Q:$L(LEXSD)'=10
 S LEXED=$TR($$FMTE^XLFDT($G(LEXIDT),"5DZ"),"@"," ") Q:$L(LEXED)'=10
 K LEXP S LEXP(1)="This is not a valid search.  You are searching "
 S LEXP(1)=LEXP(1)_"for terminology that is linked to an ICD-10 "
 S LEXP(1)=LEXP(1)_"diagnosis or procedure code on "_LEXSD_".  "
 S LEXP(1)=LEXP(1)_"There are no ICD-10-CM or ICD-10-PCS codes "
 S LEXP(1)=LEXP(1)_"active before "_LEXED_"."
 K LEX("HLP") D PR(.LEXP,70) S LEXCT=$O(LEX("HLP"," "),-1),LEXI=0
 F  S LEXI=$O(LEXP(LEXI)) Q:+LEXI'>0  D
 . N LEXT S LEXT=$G(LEXP(LEXI)),LEXCT=LEXCT+1
 . S LEX("HLP",LEXCT)=LEXSP_LEXT
 . S LEX("HLP",0)=LEXCT,LEXOK=1
 Q
 ; P70.2     NEONATAL DIABETES MELLITUS
H10D ;     ICD-10 Dx Help
 S LEXC="P70.2",LEXS="ICD-10-CM",LEX2="NEO DIAB MELL"
 S LEX3="DIABE MELL NEO",LEX4="NEONATAL DIAB" S LEXOK=1
 S LEXEX="Neonatal diabetes mellitus"
 Q
HCPT ;     CPT-4 Help
 S LEXC="49560",LEXS="CPT-4",LEX2="REPAIR HERNIA"
 S LEX3="REP VENT HERNIA",LEX4="REP VENT HERNIA REDUC" S LEXOK=1
 S LEXEX="Repair Reducible Incisional or Ventral Hernia"
 Q
HCPC ;     HCPCS Help
 S LEXC="L2680",LEXS="HCPCS",LEX2="THORAC CONTROL"
 S LEX3="THORA CONTROL LAT",LEX4="THORA CONTROL LAT SUPP" S LEXOK=1
 S LEXEX="Lateral Support Uprights for Thoracic Control"
 Q
H10P ;     ICD-10 Pr Help
 S LEXC="6A550ZT",LEXS="ICD-10-PCS",LEX2="STEM CELL"
 S LEX3="CORD STEM CELL",LEX4="PHERESIS CORD STEM CELL" S LEXOK=1
 S LEXEX="Pheresis of Cord Blood Stem Cells, single"
 Q
HDS4 ;     DSM-IV Dx Help
 S LEXC="296.32",LEXS="DSM-IV",LEX2="MAJOR DEPRESSION"
 S LEX3="MAJ DEPRESS RECCUR",LEX4="MAJ DEP RECCUR MOD" S LEXOK=1
 S LEXEX="Major Depressive Disorder, Recurrent, Moderate"
 Q
HNAN ;     Nanda
 S LEXC="1.2.2.1",LEXS="NANDA",LEX2="BODY TEMPERATURE"
 S LEX3="BODY TEMP ALT",LEX4="BODY TEMP POT ALTER" S LEXOK=1
 S LEXEX="Body Temperature, Potential Altered"
 Q
HSCC ;     Title 38
 S LEXC="7914",LEXS="Title 38",LEX2="MALIGANT GROW"
 S LEX3="MALIG NEW GROW",LEX4="MALIG NEW GROW ENDOCRINE" S LEXOK=1
 S LEXEX="Malignant new Growth of the Endocrine System"
 Q
HOMA ;     Omaha
 S LEXC="H36.02",LEXS="Omaha Diagnosis",LEX2="SLEEP PATTERN"
 S LEX3="SLEEP REST PATTERN",LEX4="SLEEP REST PATTERN IMPAIR" S LEXOK=1
 S LEXEX="Sleep and Rest Patterns, Impairment"
 Q
HSYS(X,Y) ;   Help System
 N LEXF,LEXD,ICD10 S LEXF=$G(X),LEXD=$G(Y),ICD10=$$IMPDATE^LEXU("10D")
 Q:'$L(LEXF) ""  I LEXF["$$SC^LEXU" D
 . S LEXY=$TR($P($P(LEXF,",",2),";",3),"""","")
 . S:LEXF["BEH" LEXY=LEXY_"/DS4" S:LEXF["DIS" LEXY=LEXY_"/SCC"
 I LEXF["$$",LEXF["ONE^" D
 . S LEXY="" S:LEXF["$$ICDONE" LEXY=LEXY_"/ICD"
 . S:LEXF["$$10DO" LEXY=LEXY_"/10D" S:LEXF["$$10PO" LEXY=LEXY_"/10P"
 . S:LEXF["$$CPTO" LEXY=LEXY_"/CPT" S:LEXF["$$CPCO" LEXY=LEXY_"/CPC"
 . S:LEXF["$$DSMO" LEXY=LEXY_"/DS4"
 S:LEXF["$$DX^LEXU"&(+LEXD<ICD10) LEXY="ICD"
 S:LEXF["$$DX^LEXU"&(+LEXD'<ICD10) LEXY="10D"
 S:LEXF["$$SO^LEXU" LEXY=$TR($P(LEXF,",",2),"""","")
 S LEXT="" I $L($G(LEXY)) F LEXI=1:1:$L(LEXY,"/") D
 . N LEXS,LEXO S LEXS=$P(LEXY,"/",LEXI) Q:'$L(LEXS)  Q:$L(LEXS)'=3
 . S:LEXS="ICD" LEXO="ICD-9"
 . S:LEXS="10D"&(LEXY'["10P") LEXO="ICD-10"
 . S:LEXS="10D"&(LEXY["10P") LEXO="ICD-10-CM"
 . S:LEXS="10D"&($L(LEXY,"/")=1) LEXO="ICD-10-CM"
 . S:LEXS="10P"&(LEXY'["10D") LEXO="ICD-10"
 . S:LEXS="10P"&(LEXY["10D") LEXO="ICD-10-PCS"
 . S:LEXS="10P"&($L(LEXY,"/")=1) LEXO="ICD-10-PCS"
 . S:LEXS="CPT" LEXO="CPT-4" S:LEXS="CPC" LEXO="HCPCS"
 . S:LEXS="SCC" LEXO="Title 38" S:LEXS="SCT" LEXO="SNOMED CT"
 . S:LEXS="DS4" LEXO="DSM-IV" S:LEXS="NAN"!(LEXS="OMA") LEXO="Nursing"
 . Q:'$L($G(LEXO))  S:LEXT'[LEXO LEXT=LEXT_"/"_LEXO
 S LEXT=$$TM(LEXT,"/") S X="" S:$L(LEXT) X=LEXT
 Q X
 Q
 ; 
 ; Miscellaneous
PR(LEXA,X) ;   Parse Array
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,LEXI,LEXLEN,LEXC
 K ^UTILITY($J,"W") Q:'$D(LEXA)  S LEXLEN=+($G(X))
 S:+LEXLEN'>0 LEXLEN=79 S LEXC=$O(LEXA(" "),-1) Q:+LEXC'>0
 S DIWL=1,DIWF="C"_+LEXLEN S LEXI=0
 F  S LEXI=$O(LEXA(LEXI)) Q:+LEXI=0  S X=$G(LEXA(LEXI)) D ^DIWP
 K LEXA S (LEXC,LEXI)=0
 F  S LEXI=$O(^UTILITY($J,"W",1,LEXI)) Q:+LEXI=0  D
 . S LEXA(LEXI)=$$TM($G(^UTILITY($J,"W",1,LEXI,0))," ")
 . S LEXC=LEXC+1
 S:$L(LEXC) LEXA=LEXC K ^UTILITY($J,"W")
 Q
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
