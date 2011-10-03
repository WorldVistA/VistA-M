PXRMLABS ; SLC/PKR - Estimate of lab entries to set up. ;8/5/03  16:20
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;===============================================================
NELR() ;.
 N LRDFN,LRDN,LRIDT,NE,TEMP
 ;DBIA #4179
 S NE=0
 S LRDFN=.9
 F  S LRDFN=$O(^LR(LRDFN)) Q:LRDFN<1  D
 . S TEMP=$G(^LR(LRDFN,0))
 . I $P(TEMP,U,2)'=2 Q
 . S LRIDT=0
 . F  S LRIDT=$O(^LR(LRDFN,"CH",LRIDT)) Q:LRIDT<1  D
 .. I '$P($G(^LR(LRDFN,"CH",LRIDT,0)),U,3) Q  ; check for completed
 .. S LRDN=1
 .. F  S LRDN=$O(^LR(LRDFN,"CH",LRIDT,LRDN)) Q:LRDN<1  D
 ... S NE=NE+1
 D AP(.NE)
 D MICRO(.NE)
 Q NE
 ;
 ;===============================================================
AP(NE) ;
 N ETIOL,I,II,III,ICD,ICDX
 N LRDFN,ORGAN,SNOMED,SPEC,SUB,SUBS,TEMP
 ;DBIA #4179
 K ANUMS
 D AANUMS(.ANUMS)
 S LRDFN=.9
 F  S LRDFN=$O(^LR(LRDFN)) Q:LRDFN<1  D
 . S TEMP=$G(^LR(LRDFN,0))
 . I $P(TEMP,U,2)'=2 Q
 . D CYEMSP(LRDFN,.ANUMS,.NE) ; cytology, electron microscopy, sugrical path
 . I '+$G(^LR(LRDFN,"AU")) Q  ; date of autopsy
 . S NE=NE+1
 . S SPEC=0
 . F  S SPEC=$O(^LR(LRDFN,33,SPEC)) Q:SPEC<1  D
 .. I '$L($P($G(^LR(LRDFN,33,SPEC,0)),U)) Q
 .. S NE=NE+1
 . S ICD=0
 . F  S ICD=$O(^LR(LRDFN,80,ICD)) Q:ICD<1  D
 .. S ICDX=+$G(^LR(LRDFN,80,ICD,0))
 .. I 'ICDX Q
 .. S NE=NE+1
 . S I=0
 . F  S I=$O(^LR(LRDFN,"AY",I)) Q:I<1  D
 .. S ORGAN=+$G(^LR(LRDFN,"AY",I,0))
 .. I 'ORGAN Q
 .. S NE=NE+1
 .. F SUBS="1D","2M","3F","4P" D
 ... S SUB=+SUBS
 ... S II=0
 ... F  S II=$O(^LR(LRDFN,"AY",I,SUB,II)) Q:II<1  D
 .... S SNOMED=+$G(^LR(LRDFN,"AY",I,SUB,II,0))
 .... I 'SNOMED Q
 .... S NE=NE+1
 .... I SUB'=2 Q
 .... S III=0
 .... F  S III=$O(^LR(LRDFN,"AY",I,SUB,II,1,III)) Q:III<1  D
 ..... S ETIOL=+$G(^LR(LRDFN,"AY",I,SUB,II,1,III,0))
 ..... I 'ETIOL Q
 ..... S NE=NE+1
 Q
 ;
CYEMSP(LRDFN,ANUMS,NE) ;
 N ACC,APSUB,DATE,ERR,I,ICD,ICDX,LRIDT,NODE,ORGAN,PREP,SPEC
 N TEST,TESTS K TESTS
 ;DBIA #4179
 F APSUB="CY","EM","SP" D
 . I '$D(^LR(LRDFN,APSUB,0)) Q
 . S LRIDT=0
 . F  S LRIDT=$O(^LR(LRDFN,APSUB,LRIDT)) Q:LRIDT<1  D
 .. S DATE=+$G(^LR(LRDFN,APSUB,LRIDT,0))
 .. I 'DATE Q
 .. I '($P(^LR(LRDFN,APSUB,LRIDT,0),U,3)&($P(^(0),U,11))) Q
 .. S SPEC=0
 .. F  S SPEC=$O(^LR(LRDFN,APSUB,LRIDT,.1,SPEC)) Q:SPEC<1  D
 ... I '$L($P($G(^LR(LRDFN,APSUB,LRIDT,.1,SPEC,0)),U)) Q
 ... S NE=NE+1
 ... S PREP=0
 ... F  S PREP=$O(^LR(LRDFN,APSUB,LRIDT,.1,SPEC,1,PREP)) Q:PREP<1  D
 .... S TEST=0
 .... F  S TEST=$O(^LR(LRDFN,APSUB,LRIDT,.1,SPEC,1,PREP,1,TEST)) Q:TEST<1  D
 ..... I '$L($P($G(^LR(LRDFN,APSUB,LRIDT,.1,SPEC,1,PREP,1,TEST,0)),U)) Q
 ..... S NE=NE+1
 .. S ACC=$P(^LR(LRDFN,APSUB,LRIDT,0),U,6)
 .. I $L(ACC) D
 ... S NODE=LRDFN_";"_APSUB_";"_LRIDT_";0"
 ... D ACC(.TESTS,ACC,DATE,.ANUMS,.ERR)
 ... I 'ERR D
 .... S TEST=0
 .... F  S TEST=$O(TESTS(TEST)) Q:TEST<1  D
 ..... S NE=NE+1
 .. S ICD=0
 .. F  S ICD=$O(^LR(LRDFN,APSUB,LRIDT,3,ICD)) Q:ICD<1  D
 ... S ICDX=+$G(^LR(LRDFN,APSUB,LRIDT,3,ICD,0))
 ... I 'ICDX Q
 ... S NE=NE+1
 .. S I=0
 .. F  S I=$O(^LR(LRDFN,APSUB,LRIDT,2,I)) Q:I<1  D
 ... S ORGAN=+$G(^LR(LRDFN,APSUB,LRIDT,2,I,0))
 ... I 'ORGAN Q
 ... S NE=NE+1
 ... D SNOMED(LRDFN,LRIDT,DATE,APSUB,I,.NE)
 Q
 ;
SNOMED(LRDFN,LRIDT,DATE,APSUB,I,NE) ;
 N ETIOL,II,III,SNOMED,SUB,SUBS
 ;DBIA #4179
 F SUBS="1D","2M","3F","4P" D
 . S SUB=+SUBS
 . S II=0
 . F  S II=$O(^LR(LRDFN,APSUB,LRIDT,2,I,SUB,II)) Q:II<1  D
 .. S SNOMED=+$G(^LR(LRDFN,APSUB,LRIDT,2,I,SUB,II,0))
 .. I 'SNOMED Q
 .. S NE=NE+1
 .. I SUB'=2 Q
 .. S III=0
 .. F  S III=$O(^LR(LRDFN,APSUB,LRIDT,2,I,SUB,II,1,III)) Q:III<1  D
 ... S ETIOL=+$G(^LR(LRDFN,APSUB,LRIDT,2,I,SUB,II,1,III,0))
 ... I 'ETIOL Q
 ... S NE=NE+1
 Q
 ;
 ;===============================================================
MICRO(NE) ;
 N AB,ABDN,ACC,ANUMS,DATE,ERR
 N LRDFN,LRIDT,ORG,ORGNUM,SPEC,SUB
 N TB,TBDN,TEMP,TEST,TESTS
 ;DBIA #4179
 K ANUMS,TESTS
 D AANUMS(.ANUMS)
 S LRDFN=.9
 F  S LRDFN=$O(^LR(LRDFN)) Q:LRDFN<1  D
 . S TEMP=$G(^LR(LRDFN,0))
 . I $P(TEMP,U,2)'=2 Q
 . S LRIDT=0
 . F  S LRIDT=$O(^LR(LRDFN,"MI",LRIDT)) Q:LRIDT<1  D
 .. S DATE=+$G(^LR(LRDFN,"MI",LRIDT,0))
 .. I 'DATE Q
 .. S SPEC=+$P(^LR(LRDFN,"MI",LRIDT,0),U,5)
 .. I 'SPEC Q
 .. S NE=NE+1
 .. S ACC=$P(^LR(LRDFN,"MI",LRIDT,0),U,6)
 .. I $L(ACC) D
 ... D ACC(.TESTS,ACC,DATE,.ANUMS,.ERR)
 ... I 'ERR D
 .... S TEST=0
 .... F  S TEST=$O(TESTS(TEST)) Q:TEST<1  D
 ..... S NE=NE+1
 .. I $G(^LR(LRDFN,"MI",LRIDT,1)) D
 ... S ORGNUM=0
 ... F  S ORGNUM=$O(^LR(LRDFN,"MI",LRIDT,3,ORGNUM)) Q:ORGNUM<1  D
 .... S ORG=+$G(^LR(LRDFN,"MI",LRIDT,3,ORGNUM,0))
 .... I 'ORG Q
 .... S NE=NE+1
 .... S ABDN=1
 .... F  S ABDN=$O(^LR(LRDFN,"MI",LRIDT,3,ORGNUM,ABDN)) Q:ABDN<1  D
 ..... S AB=+$G(^TMP("LRPXSXRB",$J,"AB",ABDN))
 ..... I 'AB Q
 ..... S NE=NE+1
 .. F SUB=6,9,12,17 D
 ... I '$G(^LR(LRDFN,"MI",LRIDT,(SUB-1))) Q
 ... S ORGNUM=0
 ... F  S ORGNUM=$O(^LR(LRDFN,"MI",LRIDT,SUB,ORGNUM)) Q:ORGNUM<1  D
 .... S ORG=+$G(^LR(LRDFN,"MI",LRIDT,SUB,ORGNUM,0))
 .... I 'ORG Q
 .... S NE=NE+1
 .... I SUB'=12 Q
 .... S TBDN=2
 .... F  S TBDN=$O(^LR(LRDFN,"MI",LRIDT,12,ORGNUM,TBDN)) Q:TBDN<2  D
 ..... S TB=+$G(^TMP("LRPXSXRB",$J,"TB",TBDN))
 ..... I '$L(TB) Q
 ..... S NE=NE+1
 Q
 ;
AANUMS(ANUMS) ;
 N AA,ABREV K ANUMS
 ;DBIA #4185
 S AA=0
 F  S AA=$O(^LRO(68,AA)) Q:AA<1  D
 . S ABREV=$P($G(^LRO(68,AA,0)),U,11)
 . I $L(ABREV) S ANUMS(ABREV)=AA
 Q
 ;
ACC(TESTS,ACC,BDN,ANUMS,ERR) ;
 ; returns TESTS from micro accession, ACC, BDN required
 ; BDN is beginning date number
 ; ANUMS is array of accession name numbers (avoids lookup on repeated calls)
 N DIC,LRAA,LRAAB,LRAD,LRAN,TEST,X,Y K DIC,TESTS
 S ERR=0
 I '$L($G(ACC)) S ERR=1 Q
 S LRAAB=$P(ACC," ")
 I LRAAB="" Q
 S BDN=$E($G(BDN))
 I BDN'>1 S ERR=1 Q
 S LRAN=+$P(ACC," ",3)
 I 'LRAN S ERR=1 Q
 S LRAA=+$G(ANUMS(LRAAB))
 I 'LRAA D
 . S DIC=68,DIC(0)="M"
 . S X=LRAAB
 . D ^DIC K DIC
 . S LRAA=+Y
 . S ANUMS(LRAAB)=LRAA
 I LRAA'>0 S ERR=1 Q
 S LRAD=BDN_$P(ACC," ",2)_"0000" ; yearly acc areas are assumed
 S TEST=0
 F  S TEST=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,TEST)) Q:TEST<1  D
 . S TESTS(TEST)=TEST
 Q
 ;
