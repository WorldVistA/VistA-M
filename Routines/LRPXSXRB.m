LRPXSXRB ; SLC/PKR - Build indexes for Lab Microbiology. ;1/29/04  14:36
 ;;5.2;LAB SERVICE;**295**;Sep 27, 1994
 Q
 ;===============================================================
MICRO ; from LRPXSXRL
 ;Build the indexes for LAB DATA - MICROBIOLOGY.
 N AB,ABDN,ACC,ANUMS,DATE,DNUM,DFN,END,ENTRIES,ERR,GLOBAL,IND,ITEM
 N LRDFN,LRIDT,NE,NERROR,NODE,NUM,ORG,ORGNUM,SPEC,START,SUB
 N TB,TBDN,TEMP,TENP,TEST,TESTS,TEXT
 K ANUMS,TESTS
 ;Dont leave any old stuff around.
 S GLOBAL=$$GET1^DID(63,"","","GLOBAL NAME")_"""MICRO"")"
 S ENTRIES=$P(^LR(0),U,4)
 S TENP=ENTRIES/10
 S TENP=+$P(TENP,".",1)
 I TENP<1 S TENP=1
 D BMES^XPDUTL("Building indexes for LAB DATA - MICROBIOLOGY")
 S TEXT="There are "_ENTRIES_" entries to process."
 D MES^XPDUTL(TEXT)
 S START=$H
 S (IND,NE,NERROR)=0
 K ^TMP("LRPXSXRB",$J)
 S NUM=0
 F  S NUM=$O(^LAB(62.06,NUM)) Q:NUM<1  D
 . S DNUM=+$P($G(^LAB(62.06,NUM,0)),U,2)
 . I DNUM'["2." Q
 . I '$D(^TMP("LRPXSXRB",$J,"AB",DNUM)) S ^TMP("LRPXSXRB",$J,"AB",DNUM)=NUM
 S NUM=2
 F  S NUM=$O(^DD(63.39,NUM)) Q:NUM<1  D  ; dbia 999
 . S DNUM=+$P($G(^DD(63.39,NUM,0)),U,4) ; dbia 999
 . I DNUM'["2." Q
 . S ^TMP("LRPXSXRB",$J,"TB",DNUM)=NUM
 D AANUMS(.ANUMS)
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
 . S LRIDT=0
 . F  S LRIDT=$O(^LR(LRDFN,"MI",LRIDT)) Q:LRIDT<1  D
 .. S DATE=+$G(^LR(LRDFN,"MI",LRIDT,0))
 .. I 'DATE Q
 .. I '$$MIVER^LRPXRM(LRDFN,LRIDT) Q
 .. S SPEC=+$P(^LR(LRDFN,"MI",LRIDT,0),U,5)
 .. I 'SPEC Q
 .. S ITEM="M;S;"_SPEC
 .. S NODE=LRDFN_";MI;"_LRIDT_";0"
 .. D MISET(DFN,ITEM,DATE,NODE)
 .. S ACC=$P(^LR(LRDFN,"MI",LRIDT,0),U,6)
 .. I $L(ACC) D
 ... D ACC(.TESTS,ACC,DATE,.ANUMS,.ERR)
 ... I 'ERR D
 .... S TEST=0
 .... F  S TEST=$O(TESTS(TEST)) Q:TEST<1  D
 ..... S ITEM="M;T;"_TEST
 ..... D MISET(DFN,ITEM,DATE,NODE)
 .. I $G(^LR(LRDFN,"MI",LRIDT,1)) D
 ... S ORGNUM=0
 ... F  S ORGNUM=$O(^LR(LRDFN,"MI",LRIDT,3,ORGNUM)) Q:ORGNUM<1  D
 .... S ORG=+$G(^LR(LRDFN,"MI",LRIDT,3,ORGNUM,0))
 .... I 'ORG Q
 .... S ITEM="M;O;"_ORG
 .... S NODE=LRDFN_";MI;"_LRIDT_";3;"_ORGNUM_";0"
 .... D MISET(DFN,ITEM,DATE,NODE)
 .... S ABDN=1
 .... F  S ABDN=$O(^LR(LRDFN,"MI",LRIDT,3,ORGNUM,ABDN)) Q:ABDN<1  D
 ..... S AB=+$G(^TMP("LRPXSXRB",$J,"AB",ABDN))
 ..... I 'AB Q
 ..... S ITEM="M;A;"_AB
 ..... S NODE=LRDFN_";MI;"_LRIDT_";3;"_ORGNUM_";"_ABDN
 ..... D MISET(DFN,ITEM,DATE,NODE)
 .. F SUB=6,9,12,17 D
 ... I '$G(^LR(LRDFN,"MI",LRIDT,(SUB-1))) Q
 ... S ORGNUM=0
 ... F  S ORGNUM=$O(^LR(LRDFN,"MI",LRIDT,SUB,ORGNUM)) Q:ORGNUM<1  D
 .... S ORG=+$G(^LR(LRDFN,"MI",LRIDT,SUB,ORGNUM,0))
 .... I 'ORG Q
 .... S ITEM="M;O;"_ORG
 .... S NODE=LRDFN_";MI;"_LRIDT_";"_SUB_";"_ORGNUM_";0"
 .... D MISET(DFN,ITEM,DATE,NODE)
 .... I SUB'=12 Q
 .... S TBDN=2
 .... F  S TBDN=$O(^LR(LRDFN,"MI",LRIDT,12,ORGNUM,TBDN)) Q:TBDN<2  D
 ..... S TB=+$G(^TMP("LRPXSXRB",$J,"TB",TBDN))
 ..... I '$L(TB) Q
 ..... S ITEM="M;M;"_TB
 ..... S NODE=LRDFN_";MI;"_LRIDT_";12;"_ORGNUM_";"_TBDN
 ..... D MISET(DFN,ITEM,DATE,NODE)
 K ^TMP("LRPXSXRB",$J)
 S TEXT=NE_" LAB DATA (MICRO) results indexed."
 D MES^XPDUTL(TEXT)
 S END=$H
 D DETIME^PXRMSXRM(START,END) ; dbia 4113
 ;If there were errors send a message.
 I NERROR>0 D ERRMSG^PXRMSXRM(NERROR,GLOBAL) ; dbia 4113
 ;Send a MailMan message with the results.
 D COMMSG^PXRMSXRM(GLOBAL,START,END,NE,NERROR) ; dbia 4113
 S ^PXRMINDX(63,"GLOBAL NAME")=$P(GLOBAL,"""",1) ; dbia 4114
 S ^PXRMINDX(63,"BUILT BY")=DUZ ; dbia 4114
 S ^PXRMINDX(63,"DATE BUILT")=$$NOW^XLFDT ; dbia 4114
 Q
 ;
MISET(DFN,ITEM,DATE,NODE) ;
 I '$P(ITEM,";",3) D
 . N ETEXT
 . S ETEXT=NODE_" missing test"
 . D ADDERROR^PXRMSXRM("LR(MICRO",ETEXT,.NERROR) ; dbia 4113
 E  D
 . D SLAB^LRPX(DFN,DATE,ITEM,NODE)
 . S NE=NE+1
 Q
 ;
AANUMS(ANUMS) ; from LRPXSXRA
 N AA,ABREV K ANUMS
 S AA=0
 F  S AA=$O(^LRO(68,AA)) Q:AA<1  D
 . S ABREV=$P($G(^LRO(68,AA,0)),U,11)
 . I $L(ABREV) S ANUMS(ABREV)=AA
 Q
 ;
ACC(TESTS,ACC,BDN,ANUMS,ERR) ; from LRPXSXRA
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
