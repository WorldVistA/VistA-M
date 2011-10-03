LRPXRM ;SLC/STAFF Lab reminder index for micro and ap ;5/6/04  13:21
 ;;5.2;LAB SERVICE;**295**;Sep 27, 1994
 ;
UPDATE(LRDFN,SUB,LRIDT) ; update Micro and AP xrefs in ^PXRMINDX(63
 ; from LRAPDA,LRAPDSR,LRMIEDZ,LRMIEDZ2,LRMISTF1,LRMIV,LRMIV1,LRMIV2
 ; - ^TMP("LRPX",$J, is used for processing any edits of Micro or AP data: 
 ; - All results "AR" are copied when the patient's sample is edited.
 ; - Indexes of the patient's "PDI" are copied before "B" edits.
 ; - Indexes created from the "AR" data provide an index after "A" edits.
 ; - "A" and "B" are compared to determine what has been added "ADD"
 ;   and what has been deleted "DEL".
 ; - The ^PXRMINDX(63 indexes are added or deleted using "ADD" and "DEL".
 N DATE,DFN K ^TMP("LRPX",$J)
 S LRIDT=+$G(LRIDT)
 S DFN=$$DFN^LRPXAPIU(+$G(LRDFN)) I 'DFN Q
 I SUB="AU" D  Q
 . S DATE=$$DOD^LRPXAPIU(DFN) I 'DATE Q
 . I '+$G(^LR(LRDFN,"AU")) Q
 . I '($P(^LR(LRDFN,"AU"),U,3)&($P(^("AU"),U,15))) Q
 . M ^TMP("LRPX",$J,"B")=^PXRMINDX(63,"PDI",DFN,DATE)
 . M ^TMP("LRPX",$J,"AR","AY")=^LR(LRDFN,"AY")
 . M ^TMP("LRPX",$J,"AR",80)=^LR(LRDFN,80)
 . M ^TMP("LRPX",$J,"AR",33)=^LR(LRDFN,33)
 . D AP(DFN,LRDFN,DATE,LRIDT,SUB)
 . K ^TMP("LRPX",$J)
 S DATE=$$LRIDT^LRPXAPIU(LRIDT)
 M ^TMP("LRPX",$J,"B")=^PXRMINDX(63,"PDI",DFN,DATE)
 I SUB="MI" D
 . M ^TMP("LRPX",$J,"AR")=^LR(LRDFN,SUB,LRIDT)
 . D MICRO(DFN,LRDFN,DATE,LRIDT)
 E  D
 . M ^TMP("LRPX",$J,"AR",0)=^LR(LRDFN,SUB,LRIDT,0)
 . M ^TMP("LRPX",$J,"AR",.1)=^LR(LRDFN,SUB,LRIDT,.1)
 . M ^TMP("LRPX",$J,"AR",2)=^LR(LRDFN,SUB,LRIDT,2)
 . M ^TMP("LRPX",$J,"AR",3)=^LR(LRDFN,SUB,LRIDT,3)
 . D AP(DFN,LRDFN,DATE,LRIDT,SUB)
 K ^TMP("LRPX",$J)
 Q
 ;
MICRO(DFN,LRDFN,DATE,LRIDT) ;
 N AB,ABDN,ACC,ITEM,NODE,ORG,ORGNUM,SPEC,SUB,TB,TBDN,TEST,TESTS K TESTS
 S ITEM=0
 F  S ITEM=$O(^TMP("LRPX",$J,"B",ITEM)) Q:ITEM=""  D
 . I $E(ITEM)'="M" K ^TMP("LRPX",$J,"B",ITEM)
 I '+$G(^TMP("LRPX",$J,"AR",0)) Q
 I '$$MIVER(LRDFN,LRIDT) Q
 S SPEC=+$P(^TMP("LRPX",$J,"AR",0),U,5)
 I 'SPEC Q
 S ITEM="M;S;"_SPEC
 S NODE=LRDFN_";MI;"_LRIDT_";0"
 D TMPSET(ITEM,NODE)
 S ACC=$P(^TMP("LRPX",$J,"AR",0),U,6)
 I $L(ACC) D
 . D ACCY^LRPXAPI(.TESTS,ACC,DATE)
 . I $O(TESTS(0)) D
 .. S TEST=0
 .. F  S TEST=+$O(TESTS(TEST)) Q:TEST<1  D
 ... S ITEM="M;T;"_TEST
 ... D TMPSET(ITEM,NODE)
 I $G(^TMP("LRPX",$J,"AR",1)) D
 . S ORGNUM=0
 . F  S ORGNUM=$O(^TMP("LRPX",$J,"AR",3,ORGNUM)) Q:ORGNUM<1  D
 .. S ORG=+$G(^TMP("LRPX",$J,"AR",3,ORGNUM,0))
 .. I 'ORG Q
 .. S ITEM="M;O;"_ORG
 .. S NODE=LRDFN_";MI;"_LRIDT_";3;"_ORGNUM_";0"
 .. D TMPSET(ITEM,NODE)
 .. S ABDN=1
 .. F  S ABDN=$O(^TMP("LRPX",$J,"AR",3,ORGNUM,ABDN)) Q:ABDN<1  D
 ... S AB=$$AB^LRPXAPIU(ABDN)
 ... I 'AB Q
 ... S ITEM="M;A;"_AB
 ... S NODE=LRDFN_";MI;"_LRIDT_";3;"_ORGNUM_";"_ABDN
 ... D TMPSET(ITEM,NODE)
 F SUB=6,9,12,17 D
 . I '$G(^TMP("LRPX",$J,"AR",(SUB-1))) Q
 . S ORGNUM=0
 . F  S ORGNUM=$O(^TMP("LRPX",$J,"AR",SUB,ORGNUM)) Q:ORGNUM<1  D
 .. S ORG=+$G(^TMP("LRPX",$J,"AR",SUB,ORGNUM,0))
 .. I 'ORG Q
 .. S ITEM="M;O;"_ORG
 .. S NODE=LRDFN_";MI;"_LRIDT_";"_SUB_";"_ORGNUM_";0"
 .. D TMPSET(ITEM,NODE)
 .. I SUB'=12 Q
 .. S TBDN=2
 .. F  S TBDN=$O(^TMP("LRPX",$J,"AR",12,ORGNUM,TBDN)) Q:TBDN<2  D
 ... S TB=$$TB^LRPXAPIU(TBDN)
 ... I '$L(TB) Q
 ... S ITEM="M;M;"_TB
 ... S NODE=LRDFN_";MI;"_LRIDT_";12;"_ORGNUM_";"_TBDN
 ... D TMPSET(ITEM,NODE)
 D CKDEL
 D CKADD
 D DEL(DFN,DATE)
 D ADD(DFN,DATE)
 Q
 ;
MIVER(LRDFN,LRIDT) ; $$(lrdfn,lridt) -> 1 if any portion of micro is verified
 N OK,SUB
 S OK=0
 F SUB=1,5,8,11,16 D  Q:OK
 . I $G(^LR(LRDFN,"MI",LRIDT,SUB)) S OK=1
 Q OK
 ;
AP(DFN,LRDFN,DATE,LRIDT,SUB) ;
 N ITEM
 I '$$APVERIFY^LRPXAPI(LRDFN,LRIDT,SUB) Q
 S ITEM=0
 F  S ITEM=$O(^TMP("LRPX",$J,"B",ITEM)) Q:ITEM=""  D
 . I $E(ITEM)'="A" K ^TMP("LRPX",$J,"B",ITEM)
 I SUB="AU" D AUTOPSY(LRDFN)
 E  D CYEMSP(LRDFN,LRIDT,DATE,SUB) ; cyto, electron micro, surg path
 D CKDEL
 D CKADD
 D DEL(DFN,DATE)
 D ADD(DFN,DATE)
 Q
 ;
AUTOPSY(LRDFN) ;
 N ETIOL,I,II,III,ICD,ICDX,ITEM,NODE,ORGAN,SNOMED,SPEC,SUB,SUBS
 S SPEC=0
 F  S SPEC=$O(^TMP("LRPX",$J,"AR",33,SPEC)) Q:SPEC<1  D
 . I '$L($P($G(^TMP("LRPX",$J,"AR",33,SPEC,0)),U)) Q
 . S ITEM="A;S;1."_$P(^TMP("LRPX",$J,"AR",33,SPEC,0),U)
 . S NODE=LRDFN_";33;"_SPEC_";0"
 . D TMPSET(ITEM,NODE)
 S ICD=0
 F  S ICD=$O(^TMP("LRPX",$J,"AR",80,ICD)) Q:ICD<1  D
 . S ICDX=+$G(^TMP("LRPX",$J,"AR",80,ICD,0))
 . I 'ICDX Q
 . S ITEM="A;I;"_ICDX
 . S NODE=LRDFN_";80;"_ICD_";0"
 . D TMPSET(ITEM,NODE)
 S I=0
 F  S I=$O(^TMP("LRPX",$J,"AR","AY",I)) Q:I<1  D
 . S ORGAN=+$G(^TMP("LRPX",$J,"AR","AY",I,0))
 . I 'ORGAN Q
 . S ITEM="A;O;"_ORGAN
 . S NODE=LRDFN_";AY;"_I_";0"
 . D TMPSET(ITEM,NODE)
 . F SUBS="1D","2M","3F","4P" D
 .. S SUB=+SUBS
 .. S II=0
 .. F  S II=$O(^TMP("LRPX",$J,"AR","AY",I,SUB,II)) Q:II<1  D
 ... S SNOMED=+$G(^TMP("LRPX",$J,"AR","AY",I,SUB,II,0))
 ... I 'SNOMED Q
 ... S ITEM="A;"_$E(SUBS,2)_";"_SNOMED
 ... S NODE=LRDFN_";AY;"_I_";"_SUB_";"_II_";0"
 ... D TMPSET(ITEM,NODE)
 ... I SUB'=2 Q
 ... S III=0
 ... F  S III=$O(^TMP("LRPX",$J,"AR","AY",I,SUB,II,1,III)) Q:III<1  D
 .... S ETIOL=+$G(^TMP("LRPX",$J,"AR","AY",I,SUB,II,1,III,0))
 .... I 'ETIOL Q
 .... S ITEM="A;E;"_ETIOL
 .... S NODE=LRDFN_";AY;"_I_";"_SUB_";"_II_";1;"_III_";0"
 .... D TMPSET(ITEM,NODE)
 Q
 ;
CYEMSP(LRDFN,LRIDT,DATE,SUB) ;
 N ACC,I,ICD,ICDX,ITEM,NODE,ORGAN,PREP,SPEC,TEST,TESTS K TESTS
 I '($P($G(^TMP("LRPX",$J,"AR",0)),U,3)&($P($G(^(0)),U,11))) Q
 S SPEC=0
 F  S SPEC=$O(^TMP("LRPX",$J,"AR",.1,SPEC)) Q:SPEC<1  D
 . I '$L($P($G(^TMP("LRPX",$J,"AR",.1,SPEC,0)),U)) Q
 . S ITEM="A;S;1."_$$UP^XLFSTR($P(^TMP("LRPX",$J,"AR",.1,SPEC,0),U))
 . S NODE=LRDFN_";"_SUB_";"_LRIDT_";.1;"_SPEC_";0"
 . D TMPSET(ITEM,NODE)
 . S PREP=0
 . F  S PREP=$O(^TMP("LRPX",$J,"AR",.1,SPEC,1,PREP)) Q:PREP<1  D
 .. S TEST=0
 .. F  S TEST=$O(^TMP("LRPX",$J,"AR",.1,SPEC,1,PREP,1,TEST)) Q:TEST<1  D
 ... S TEST=+$G(^TMP("LRPX",$J,"AR",.1,SPEC,1,PREP,1,TEST,0))
 ... I 'TEST Q
 ... S ITEM="A;T;"_TEST
 ... S NODE=LRDFN_";"_SUB_";"_LRIDT_";.1;"_SPEC_";1;"_PREP_";1;"_TEST_";0"
 ... D TMPSET(ITEM,NODE)
 ; S ACC=$P(^TMP("LRPX",$J,"AR",0),U,6) ; do not use tests on acc
 ; I $L(ACC) D
 ; . S NODE=LRDFN_";"_SUB_";"_LRIDT_";0"
 ; . D ACCY^LRPXAPI(.TESTS,ACC,DATE)
 ; . I $O(TESTS(0)) D
 ; .. S TEST=0
 ; .. F  S TEST=$O(TESTS(TEST)) Q:TEST<1  D
 ; ... S ITEM="A;T;"_TEST
 ; ... D TMPSET(ITEM,NODE)
 S ICD=0
 F  S ICD=$O(^TMP("LRPX",$J,"AR",3,ICD)) Q:ICD<1  D
 . S ICDX=+$G(^TMP("LRPX",$J,"AR",3,ICD,0))
 . I 'ICDX Q
 . S ITEM="A;I;"_ICDX
 . S NODE=LRDFN_";"_SUB_";"_LRIDT_";3;"_ICD_";0"
 . D TMPSET(ITEM,NODE)
 S I=0
 F  S I=$O(^TMP("LRPX",$J,"AR",2,I)) Q:I<1  D
 . S ORGAN=+$G(^TMP("LRPX",$J,"AR",2,I,0))
 . I 'ORGAN Q
 . S ITEM="A;O;"_ORGAN
 . S NODE=LRDFN_";"_SUB_";"_LRIDT_";2;"_I_";0"
 . D TMPSET(ITEM,NODE)
 . D SNOMED(LRDFN,LRIDT,SUB,I)
 Q
 ;
SNOMED(LRDFN,LRIDT,APSUB,I) ;
 N ETIOL,II,III,ITEM,NODE,SNOMED,SUB,SUBS
 F SUBS="1D","2M","3F","4P" D
 . S SUB=+SUBS
 . S II=0
 . F  S II=$O(^TMP("LRPX",$J,"AR",2,I,SUB,II)) Q:II<1  D
 .. S SNOMED=+$G(^TMP("LRPX",$J,"AR",2,I,SUB,II,0))
 .. I 'SNOMED Q
 .. S ITEM="A;"_$E(SUBS,2)_";"_SNOMED
 .. S NODE=LRDFN_";"_APSUB_";"_LRIDT_";2;"_I_";"_SUB_";"_II_";0"
 .. D TMPSET(ITEM,NODE)
 .. I SUB'=2 Q
 .. S III=0
 .. F  S III=$O(^TMP("LRPX",$J,"AR",2,I,SUB,II,1,III)) Q:III<1  D
 ... S ETIOL=+$G(^TMP("LRPX",$J,"AR",2,I,SUB,II,1,III,0))
 ... I 'ETIOL Q
 ... S ITEM="A;E;"_ETIOL
 ... S NODE=LRDFN_";"_APSUB_";"_LRIDT_";2;"_I_";"_SUB_";"_II_";1;"_III_";0"
 ... D TMPSET(ITEM,NODE)
 Q
 ;
TMPSET(ITEM,NODE) ;
 S ^TMP("LRPX",$J,"A",ITEM,NODE)=""
 Q
 ;
CKDEL ;
 N ITEM,NODE
 S ITEM=""
 F  S ITEM=$O(^TMP("LRPX",$J,"B",ITEM)) Q:ITEM=""  D
 . S NODE=""
 . F  S NODE=$O(^TMP("LRPX",$J,"B",ITEM,NODE)) Q:NODE=""  D
 .. I $D(^TMP("LRPX",$J,"A",ITEM,NODE)) Q
 .. S ^TMP("LRPX",$J,"DEL",ITEM,NODE)=""
 Q
 ;
CKADD ;
 N ITEM,NODE
 S ITEM=""
 F  S ITEM=$O(^TMP("LRPX",$J,"A",ITEM)) Q:ITEM=""  D
 . S NODE=""
 . F  S NODE=$O(^TMP("LRPX",$J,"A",ITEM,NODE)) Q:NODE=""  D
 .. I $D(^TMP("LRPX",$J,"B",ITEM,NODE)) Q
 .. S ^TMP("LRPX",$J,"ADD",ITEM,NODE)=""
 Q
 ;
DEL(DFN,DATE) ;
 N ITEM,NODE
 S ITEM=""
 F  S ITEM=$O(^TMP("LRPX",$J,"DEL",ITEM)) Q:ITEM=""  D
 . S NODE=""
 . F  S NODE=$O(^TMP("LRPX",$J,"DEL",ITEM,NODE)) Q:NODE=""  D
 .. D KLAB^LRPX(DFN,DATE,ITEM,NODE)
 Q
 ;
ADD(DFN,DATE) ;
 N ITEM,NODE
 S ITEM=""
 F  S ITEM=$O(^TMP("LRPX",$J,"ADD",ITEM)) Q:ITEM=""  D
 . S NODE=""
 . F  S NODE=$O(^TMP("LRPX",$J,"ADD",ITEM,NODE)) Q:NODE=""  D
 .. D SLAB^LRPX(DFN,DATE,ITEM,NODE)
 .. ; D TIMESTMP^LRLOG(DFN,$P(NODE,";",2),DATE,DUZ) ; *** future lab patch
 Q
 ;
