LR7OSUM1 ;DALOI/dcm - Silent Patient cum cont. ; Mar 11, 2003
 ;;5.2;LAB SERVICE;**121,187,256,286,384**;Sep 27, 1994;Build 2
 ;
LRIDT ; from LR7OSUM
 F  S LRIDT=$O(^LR(LRDFN,"CH",LRIDT)) Q:LRIDT<1!(LRIDT>LROUT)!(CT1>COUNT)  I $D(^(LRIDT,0)) S X=^(0),CT1=CT1+1 D LRIIDT
 Q
 ;
LRIIDT ;
 S (LRIIDT,LRVIDT)=$P(X,U,1),LRSUB=1,LRTNN=1,LRSPM=$P(X,U,5),LRTLOC=$E($P(X,U,11),1,7),LRVDT=$P(X,U,3),LRAN=$P(X,U,6)
 Q:'$L(LRVDT)
 D LRSUB
 Q
 ;
 ;
LRSUB ;
 N LRTRES
 S LRSUB=1
 F  S LRSUB=$O(^LR(LRDFN,"CH",LRIDT,LRSUB)) Q:LRSUB<1  D
 . S X=^LR(LRDFN,"CH",LRIDT,LRSUB)
 . S LRTRES=$$TSTRES^LRRPU(LRDFN,"CH",LRIDT,LRSUB,"")
 . D SUB1
 Q
SUB1 ;
 S LRTSTVAL=$P(X,U,1),X1=$P(X,U,2)
 S LRNOFL="",LRTST=$O(^LAB(60,"C","CH;"_LRSUB_";"_1,0))
 Q:LRTST=""
 Q:"IN"[$P(^LAB(60,LRTST,0),U,3)
 I '$D(^LAB(64.5,"AC",LRSUB)) D MISC Q
 K LRNON
 D LRMH
 I '$D(LRNON) D MISC
 Q
 ;
LRMH ;
 S LRMH=0
 F  S LRMH=$O(^LAB(64.5,"AC",LRSUB,1,LRMH)) Q:LRMH<1  D LRSH
 Q
 ;
LRSH ;
 S LRSH=0
 F  S LRSH=$O(^LAB(64.5,"AC",LRSUB,1,LRMH,LRSH)) Q:LRSH<1  D TST
 Q
 ;
TST ;
 S LRTSTS=0
 F  S LRTSTS=$O(^LAB(64.5,"AC",LRSUB,1,LRMH,LRSH,LRTSTS)) Q:'LRTSTS  S LRSPM1=^(LRTSTS) D TST1
 Q
 ;
 ;
TST1 ;
 Q:LRSPM'=LRSPM1
SBSET ;
 S LRMHN=$P(^LAB(64.5,1,1,LRMH,0),U,1),LRTF=^(1,LRSH,0),$P(LRTF,U,4)=$P(LRTF,U,3),$P(LRTF,U,3)=$P(^(1,0),U,4),LRNON=1
 Q:$S('$D(SUBHEAD):0,1:'$D(SUBHEAD($P(LRTF,"^"))))
 ;
 ;**  LRTE=Total minor headings
 ;** LRMHN=Major heading name^TE^Lab performing tests
 ;**  LRTF=Minor header^Profile specimen^Total tests^Type of display
 ;
 S LRIIDT=LRVIDT
 S:'$D(^TMP($J,LRDFN,LRMH)) ^(LRMH)=LRMHN
 S:'$D(^TMP($J,LRDFN,LRMH,LRSH))!($D(^(LRSH))=10) ^(LRSH)=LRTF_U
 S:'$D(^TMP($J,LRDFN,LRMH,LRSH,LRIDT,0)) ^(0)=LRTLOC_U_LRVIDT_U_LRVDT_U_LRAN_U_LRIDT
 ;
LRTSTVAL ;
 ;
 S ^TMP($J,LRDFN,LRMH,LRSH,LRIDT,LRTSTS)=$P(LRTRES,"^")_"^"_$P(LRTRES,"^",2)
 S X=$P($G(^LAB(64.5,1,1,LRMH,1,LRSH,1,LRTSTS,0)),"^",3)
 I $L(X) S ^TMP("LRT",$J,X)=$P(LRTF,"^")
 I $D(^LR(LRDFN,"CH",LRIDT,1,0)),'$D(^TMP($J,LRDFN,LRMH,LRSH,LRIDT,"TX",0)) D TEXT
 D CHKUN
 I $O(^LAB(60,LRTST,1,LRSPM,1,0)),'$D(^TMP($J,"EVAL",LRTST,LRSPM)) D
 . S ^TMP($J,"EVAL",LRTST,LRSPM)=""
 . N I,L,X,TST
 . S I=0,TST=$S($L($P($G(^LAB(60,LRTST,.1)),"^")):$P(^(.1),"^"),1:$P(^LAB(60,LRTST,0),"^"))
 . S L=+$O(^TMP($J,LRDFN,LRMH,LRSH,LRIDT,"TX",9999999),-1),L=L+1,^TMP($J,LRDFN,LRMH,LRSH,LRIDT,"TX",L,0)="Evaluation for "_TST_":"
 . F  S I=$O(^LAB(60,LRTST,1,LRSPM,1,I)) Q:'I  S X=^(I,0) S L=L+1,^TMP($J,LRDFN,LRMH,LRSH,LRIDT,"TX",L,0)=X
 Q
 ;
 ;
MISC ;
 Q:$S('$D(SUBHEAD):0,1:'$D(SUBHEAD("MISCELLANEOUS TESTS")))
 S LRTST=$O(^LAB(60,"C","CH;"_LRSUB_";"_1,0))
 Q:LRTST=""
 Q:"IN"[$P(^LAB(60,LRTST,0),U,3)
 S LRTOP=LRSPM
 ;
 S:'$D(^TMP($J,LRDFN,"MISC",LRIDT,0)) ^(0)=LRIDT_U_LRVIDT_U_LRVDT_U_LRAN_U_LRSPM
 ;S ^TMP($J,LRDFN,"MISC",LRIDT,LRTNN)=LRTSTVAL_U_LRSPM_U_LRTST_U_X1_U_LRSUB
 S ^TMP($J,LRDFN,"MISC",LRIDT,LRTNN)=$P(LRTRES,"^")_U_LRSPM_U_LRTST_U_$P(LRTRES,"^",2)_U_LRSUB_U_$P(LRTRES,"^",3,6)
 ;
 S X=$S($D(^LAB(60,LRTST,.1)):$P(^(.1),"^"),1:$P(^LAB(60,LRTST,0),"^")),^TMP("LRT",$J,X)="MISCELLANEOUS TESTS"
 ;
 ; Grab specimen comments
 I $D(^LR(LRDFN,"CH",LRIDT,1,0)),'$D(^TMP($J,LRDFN,"MISC",LRIDT,"TX",0)) D
 . S ^TMP($J,LRDFN,"MISC",LRIDT,"TX",0)="",L=0
 . F  S L=$O(^LR(LRDFN,"CH",LRIDT,1,L)) Q:L<1  S ^TMP($J,LRDFN,"MISC",LRIDT,"TX",L,0)=^LR(LRDFN,"CH",LRIDT,1,L,0)
 ;
 ; Grab test interpretation
 I $O(^LAB(60,LRTST,1,LRSPM,1,0)) D
 . N I,L,X,TST
 . S I=0,TST=$S($L($P($G(^LAB(60,LRTST,.1)),"^")):$P(^(.1),"^"),1:$P(^LAB(60,LRTST,0),"^"))
 . S:'$D(^TMP($J,LRDFN,"MISC",LRIDT,"TX",0)) ^TMP($J,LRDFN,"MISC",LRIDT,"TX",0)=""
 . S L=+$O(^TMP($J,LRDFN,"MISC",LRIDT,"TX",9999999),-1),L=L+1
 . S ^TMP($J,LRDFN,"MISC",LRIDT,"TX",L,0)="Evaluation for "_TST_":"
 . F  S I=$O(^LAB(60,LRTST,1,LRSPM,1,I)) Q:'I  S X=^(I,0) S L=L+1,^TMP($J,LRDFN,"MISC",LRIDT,"TX",L,0)=X
 ;
 S LRTNN=LRTNN+1
 Q
 ;
 ;
TEXT ;
 S LRYESCOM=0
 S M=0
 F  S M=$O(^LR(LRDFN,"CH",LRIDT,1,M)) Q:M<1!(LRYESCOM)  F N=1:1:$L(^LR(LRDFN,"CH",LRIDT,1,M,0)) Q:LRYESCOM  S:$E(^(0),N)'[$C(32) LRYESCOM=1
 Q:'LRYESCOM
 S L=0
 F  S L=$O(^LR(LRDFN,"CH",LRIDT,1,L)) Q:L<1  S ^TMP($J,LRDFN,LRMH,LRSH,LRIDT,"TX",L,0)=^LR(LRDFN,"CH",LRIDT,1,L,0)
 Q
 ;
 ;
MICRO ;from LR7OSUM
 Q:'$D(^LR(LRDFN,"MI"))
 N MICROCNT
 S:'$D(LRUNKNOW) LRUNKNOW=$P(^LAB(69.9,1,1),U,5)
 S (LRONESPC,LRONETST)="",LREND=0,MICROCNT=GCNT+1
 I $O(^LR(LRDFN,"MI",0)) S ^TMP("LRH",$J,"MICROBIOLOGY")=MICROCNT
 S LRWRDVEW="",LRSB=0,LRIDT=LRIN
 F  S LRIDT=$O(^LR(LRDFN,"MI",LRIDT)) Q:LRIDT<1!(LRIDT>LROUT)!(CT1>COUNT)  S LRNLOC=LRLLOC,CT1=CT1+1 D EN1^LR7OSMZ0 S LRLLOC=LRNLOC
 I GCNT'>MICROCNT K ^TMP("LRH",$J,"MICROBIOLOGY")
 K %,A,A1,AGE,B,B1,DFN,DOB,DZ,I,J,LR2ORMOR,LRAA,LRACC,LRACN,LRAD,LRADM,LRADX,LRAFS,LRAX,LRBUG,LRCMNT,LRCS,LRDCOM,LREF,LREND,LRIFN,LRLLT,LRMD,LRNLOC,LRNS,LROK,LRONESPC,LRONETST,LRORG,LRPRE,LRPRINT
 Q
 ;
 ;
CHKUN ; Check units and normals with cumulative report values
 ; Add comment if these differ from file #64.5 values
 ;
 N I,L,LRFLAG,LRHI,LRLO,LRLOHI,LRX,LRY,TST
 S LRX=$G(^LAB(64.5,"A",1,LRMH,LRSH,LRTSTS)),LRFLAG=0
 S TST=$P($G(^LAB(64.5,1,1,LRMH,1,LRSH,1,LRTSTS,0)),"^",3)
 S LRY="*** For test "_TST
 ; Check units - if different generate comment
 I $$UP^XLFSTR($P(LRX,"^",7))'=$$UP^XLFSTR($P(LRTRES,"^",5)) S LRY=LRY_" Units: "_$P(LRTRES,"^",5),LRFLAG=1
 ;
 ; Check normals - if different generate comment
 S @("LRLO="_$S($P(LRX,"^",2)'="":$P(LRX,"^",2),$P(LRX,"^",11)'="":$P(LRX,"^",11),1:""""""))
 ;
 S @("LRHI="_$S($P(LRX,"^",3)'="":$P(LRX,"^",3),$P(LRX,"^",12)'="":$P(LRX,"^",12),1:""""""))
 I LRLO'=$P(LRTRES,"^",3)!(LRHI'=$P(LRTRES,"^",4)) D
 . ; check to see if these values are numeric and are different because of leading or trailing zeroes
 . I '$$REALDIFF Q
 . I LRFLAG S LRY=LRY_" and"
 . S LRY=LRY_" Normals: "_$P(LRTRES,"^",3)_"-"_$P(LRTRES,"^",4),LRFLAG=1
 ;
 I 'LRFLAG Q
 ;
 S L=+$O(^TMP($J,LRDFN,LRMH,LRSH,LRIDT,"TX",9999999),-1),L=L+1
 S LRY=LRY_" ***",^TMP($J,LRDFN,LRMH,LRSH,LRIDT,"TX",L,0)=LRY
 Q
 ;
 ;
REALDIFF() ;
 ; function to determine if values are numeric and are different
 ; solely because of leading or trailing zeroes
 ;     returns 0 if difference is because of leading/trailing zeroes
 ;     returns 1 if differences are meaningful
 N LRTRESLO,LRTRESHI,DIFF
 S LRTRESLO=$P(LRTRES,"^",3),LRTRESHI=$P(LRTRES,"^",4)
 S DIFF=0
 I LRLO'=LRTRESLO S DIFF=1 D
 . I LRLO?.N!(LRLO?.N1".".N) D
 . . I LRTRESLO?.N!(LRTRESLO?.N1".".N) D
 . . . I +LRLO=+LRTRESLO S DIFF=0
 I DIFF Q 1
 I LRHI'=LRTRESHI S DIFF=1 D
 . I LRHI?.N!(LRHI?.N1".".N) D
 . . I LRTRESHI?.N!(LRTRESHI?.N1".".N) D
 . . . I +LRHI=+LRTRESHI S DIFF=0
 I DIFF Q 1
 Q 0
