LRPXSXRA ; SLC/PKR - Build indexes for Lab Anatomic Path. ;10/9/03  14:24
 ;;5.2;LAB SERVICE;**295**;Sep 27, 1994
 Q
 ;===============================================================
AP ; from LRPXSXRL
 ;Build the indexes for LAB DATA - ANATOMIC PATHOLOGY.
 N ANUMS,DATE,DFN,END,ENTRIES,ETIOL,GLOBAL,I,II,III,ICD,ICDX,IND,ITEM
 N LRDFN,ORGAN,NE,NERROR,NODE,SNOMED,SPEC,START,SUB,SUBS,TEMP,TENP,TEXT
 K ANUMS
 ;Dont leave any old stuff around.
 S GLOBAL=$$GET1^DID(63,"","","GLOBAL NAME")_"""AP"")"
 S ENTRIES=$P(^LR(0),U,4)
 S TENP=ENTRIES/10
 S TENP=+$P(TENP,".",1)
 I TENP<1 S TENP=1
 D BMES^XPDUTL("Building indexes for LAB DATA - ANATOMIC PATH")
 S TEXT="There are "_ENTRIES_" entries to process."
 D MES^XPDUTL(TEXT)
 S START=$H
 S (IND,NE,NERROR)=0
 D AANUMS^LRPXSXRB(.ANUMS)
 S LRDFN=.9
 F  S LRDFN=$O(^LR(LRDFN)) Q:LRDFN<1  D
 . S TEMP=$G(^LR(LRDFN,0))
 . I $P(TEMP,U,2)'=2 Q
 . S DFN=+$P(TEMP,U,3)
 . I LRDFN'=$$LRDFN^LRPXAPIU(DFN) Q
 . S IND=IND+1
 . I IND#TENP=0 D
 .. S TEXT="Processing entry "_IND
 .. D MES^XPDUTL(TEXT)
 . D CYEMSP(LRDFN,DFN,.ANUMS) ; cytology, electron microscopy, sugrical path
 . S DATE=$$DOD^LRPXAPIU(DFN) I 'DATE Q  ; date of death
 . I '+$G(^LR(LRDFN,"AU")) Q  ; date of autopsy
 . I '($P(^LR(LRDFN,"AU"),U,3)&($P(^("AU"),U,15))) Q  ; autopsy comp/released
 . S SPEC=0
 . F  S SPEC=$O(^LR(LRDFN,33,SPEC)) Q:SPEC<1  D
 .. I '$L($P($G(^LR(LRDFN,33,SPEC,0)),U)) Q
 .. S ITEM="A;S;1."_$$UP($P(^LR(LRDFN,33,SPEC,0),U))
 .. S NODE=LRDFN_";33;"_SPEC_";0"
 .. D APSET(DFN,ITEM,DATE,NODE)
 . S ICD=0
 . F  S ICD=$O(^LR(LRDFN,80,ICD)) Q:ICD<1  D
 .. S ICDX=+$G(^LR(LRDFN,80,ICD,0))
 .. I 'ICDX Q
 .. S ITEM="A;I;"_ICDX
 .. S NODE=LRDFN_";80;"_ICD_";0"
 .. D APSET(DFN,ITEM,DATE,NODE)
 . S I=0
 . F  S I=$O(^LR(LRDFN,"AY",I)) Q:I<1  D
 .. S ORGAN=+$G(^LR(LRDFN,"AY",I,0))
 .. I 'ORGAN Q
 .. S ITEM="A;O;"_ORGAN
 .. S NODE=LRDFN_";AY;"_I_";0"
 .. D APSET(DFN,ITEM,DATE,NODE)
 .. F SUBS="1D","2M","3F","4P" D
 ... S SUB=+SUBS
 ... S II=0
 ... F  S II=$O(^LR(LRDFN,"AY",I,SUB,II)) Q:II<1  D
 .... S SNOMED=+$G(^LR(LRDFN,"AY",I,SUB,II,0))
 .... I 'SNOMED Q
 .... S ITEM="A;"_$E(SUBS,2)_";"_SNOMED
 .... S NODE=LRDFN_";AY;"_I_";"_SUB_";"_II_";0"
 .... D APSET(DFN,ITEM,DATE,NODE)
 .... I SUB'=2 Q
 .... S III=0
 .... F  S III=$O(^LR(LRDFN,"AY",I,SUB,II,1,III)) Q:III<1  D
 ..... S ETIOL=+$G(^LR(LRDFN,"AY",I,SUB,II,1,III,0))
 ..... I 'ETIOL Q
 ..... S ITEM="A;E;"_ETIOL
 ..... S NODE=LRDFN_";AY;"_I_";"_SUB_";"_II_";1;"_III_";0"
 ..... D APSET(DFN,ITEM,DATE,NODE)
 S TEXT=NE_" LAB DATA (AP) results indexed."
 D MES^XPDUTL(TEXT)
 S END=$H
 D DETIME^PXRMSXRM(START,END) ; dbia 4113
 ;If there were errors send a message.
 I NERROR>0 D ERRMSG^PXRMSXRM(NERROR,GLOBAL) ; dbia 4113
 ;Send a MailMan message with the results.
 D COMMSG^PXRMSXRM(GLOBAL,START,END,NE,NERROR) ; dbia 4113
 Q
 ;
CYEMSP(LRDFN,DFN,ANUMS) ;
 N ACC,APSUB,DATE,ERR,I,ICD,ICDX,ITEM,LRIDT,NODE,ORGAN,PREP,SPEC
 N TEST,TESTS K TESTS
 F APSUB="CY","EM","SP" D
 . I '$D(^LR(LRDFN,APSUB,0)) Q
 . S LRIDT=0
 . F  S LRIDT=$O(^LR(LRDFN,APSUB,LRIDT)) Q:LRIDT<1  D
 .. S DATE=+$G(^LR(LRDFN,APSUB,LRIDT,0))
 .. I 'DATE Q
 .. S DATE=9999999-LRIDT ; use for multiple entries on a date
 .. I '($P(^LR(LRDFN,APSUB,LRIDT,0),U,3)&($P(^(0),U,11))) Q
 .. S SPEC=0
 .. F  S SPEC=$O(^LR(LRDFN,APSUB,LRIDT,.1,SPEC)) Q:SPEC<1  D
 ... I '$L($P($G(^LR(LRDFN,APSUB,LRIDT,.1,SPEC,0)),U)) Q
 ... S ITEM="A;S;1."_$$UP($P(^LR(LRDFN,APSUB,LRIDT,.1,SPEC,0),U))
 ... S NODE=LRDFN_";"_APSUB_";"_LRIDT_";.1;"_SPEC_";0"
 ... D APSET(DFN,ITEM,DATE,NODE)
 ... S PREP=0
 ... F  S PREP=$O(^LR(LRDFN,APSUB,LRIDT,.1,SPEC,1,PREP)) Q:PREP<1  D
 .... S TEST=0
 .... F  S TEST=$O(^LR(LRDFN,APSUB,LRIDT,.1,SPEC,1,PREP,1,TEST)) Q:TEST<1  D
 ..... S TEST=+$G(^LR(LRDFN,APSUB,LRIDT,.1,SPEC,1,PREP,1,TEST,0))
 ..... I 'TEST Q
 ..... S ITEM="A;T;"_TEST
 ..... S NODE=LRDFN_";"_APSUB_";"_LRIDT_";.1;"_SPEC_";1;"_PREP_";1;"_TEST_";0"
 ..... D APSET(DFN,ITEM,DATE,NODE)
 .. ; S ACC=$P(^LR(LRDFN,APSUB,LRIDT,0),U,6) ; do not use tests from acc
 .. ; I $L(ACC) D
 .. ; . S NODE=LRDFN_";"_APSUB_";"_LRIDT_";0"
 .. ; . D ACC^LRPXSXRB(.TESTS,ACC,DATE,.ANUMS,.ERR)
 .. ; . I 'ERR D
 .. ; .. S TEST=0
 .. ; .. F  S TEST=$O(TESTS(TEST)) Q:TEST<1  D
 .. ; ... S ITEM="A;T;"_TEST
 .. ; ... D APSET(DFN,ITEM,DATE,NODE)
 .. S ICD=0
 .. F  S ICD=$O(^LR(LRDFN,APSUB,LRIDT,3,ICD)) Q:ICD<1  D
 ... S ICDX=+$G(^LR(LRDFN,APSUB,LRIDT,3,ICD,0))
 ... I 'ICDX Q
 ... S ITEM="A;I;"_ICDX
 ... S NODE=LRDFN_";"_APSUB_";"_LRIDT_";3;"_ICD_";0"
 ... D APSET(DFN,ITEM,DATE,NODE)
 .. S I=0
 .. F  S I=$O(^LR(LRDFN,APSUB,LRIDT,2,I)) Q:I<1  D
 ... S ORGAN=+$G(^LR(LRDFN,APSUB,LRIDT,2,I,0))
 ... I 'ORGAN Q
 ... S ITEM="A;O;"_ORGAN
 ... S NODE=LRDFN_";"_APSUB_";"_LRIDT_";2;"_I_";0"
 ... D APSET(DFN,ITEM,DATE,NODE)
 ... D SNOMED(LRDFN,DFN,LRIDT,DATE,APSUB,I)
 Q
 ;
SNOMED(LRDFN,DFN,LRIDT,DATE,APSUB,I) ;
 N ETIOL,II,III,ITEM,NODE,SNOMED,SUB,SUBS
 F SUBS="1D","2M","3F","4P" D
 . S SUB=+SUBS
 . S II=0
 . F  S II=$O(^LR(LRDFN,APSUB,LRIDT,2,I,SUB,II)) Q:II<1  D
 .. S SNOMED=+$G(^LR(LRDFN,APSUB,LRIDT,2,I,SUB,II,0))
 .. I 'SNOMED Q
 .. S ITEM="A;"_$E(SUBS,2)_";"_SNOMED
 .. S NODE=LRDFN_";"_APSUB_";"_LRIDT_";2;"_I_";"_SUB_";"_II_";0"
 .. D APSET(DFN,ITEM,DATE,NODE)
 .. I SUB'=2 Q
 .. S III=0
 .. F  S III=$O(^LR(LRDFN,APSUB,LRIDT,2,I,SUB,II,1,III)) Q:III<1  D
 ... S ETIOL=+$G(^LR(LRDFN,APSUB,LRIDT,2,I,SUB,II,1,III,0))
 ... I 'ETIOL Q
 ... S ITEM="A;E;"_ETIOL
 ... S NODE=LRDFN_";"_APSUB_";"_LRIDT_";2;"_I_";"_SUB_";"_II_";1;"_III_";0"
 ... D APSET(DFN,ITEM,DATE,NODE)
 Q
 ;
UP(X) Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
APSET(DFN,ITEM,DATE,NODE) ;
 I '$P(ITEM,";",3) D
 . N ETEXT
 . S ETEXT=NODE_" missing test"
 . D ADDERROR^PXRMSXRM("LR(AP",ETEXT,.NERROR) ; dbia 4113
 E  D
 . D SLAB^LRPX(DFN,DATE,ITEM,NODE)
 . S NE=NE+1
 Q
 ;
