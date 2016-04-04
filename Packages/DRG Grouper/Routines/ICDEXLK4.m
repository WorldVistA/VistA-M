ICDEXLK4 ;SLC/KER - ICD Extractor - Lookup, Search Text ;12/19/2014
 ;;18.0;DRG Grouper;**57,67,82**;Oct 20, 2000;Build 21
 ;               
 ; Global Variables
 ;    ^TMP(SUB,$J         SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$LOW^XLFSTR        ICR  10104
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables Newed or Killed by calling application
 ;     DIC(0)    Fileman Lookup Parameters
 ;     
 ; Local Variables Newed or Killed Elsewhere
 ;     ICDBYCD   Sort by Code
 ;     CDT       Code Set Date
 ;     OUT       Format of display
 ;     SYS       Coding System
 ;     VER       Versioned Lookup
 ;     SUB       ^TMP Subscript
 ;     SYS       Coding System
 ;
TXT ; Lookup by Text (Requires TXT and ROOT)
 Q:$D(ICDBYCD)  Q:'$L($G(TXT))  Q:'$L($G(ROOT))  Q:$L(TXT)'>1  Q:$G(DIC(0))["B"
 S CDT=$$CDT^ICDEXLK3($G(CDT)) N PARS,ORG,CNT,PRV,EROOT,KEY,LOOK,EXACT,ABBR,PRIME
 S:'$L($G(SUB)) SUB=$TR(ROOT,"^(,","")
 S LOOK=TXT,PRV=+($G(^TMP(SUB,$J,"SEL",0))),(EXACT,ABBR)=0
 S CNT=0,ORG=$$UP^XLFSTR($G(TXT)) K PARS D TOKEN^ICDTOKN(TXT,ROOT,$G(SYS),.PARS)
 N I,TMP S NUM=0,(PRIME,KEY,TMP)="",I=0 F  S I=$O(PARS(I)) Q:+I'>0  D
 . N TX S TX=$G(PARS(I)) S:$L(TX)>$L(TMP) TMP=TX,NUM=I
 S:+NUM>0&($L(TMP)) (PRIME,KEY)=TMP S:+($G(PARS(+NUM,"A")))>0 ABBR=1
 I NUM'>0 S NUM=$O(PARS(0)),(PRIME,KEY)=$G(PARS(+NUM)) S:+($G(PARS(+NUM,"A")))>0 ABBR=1
 K:NUM>0 PARS(+NUM) S:NUM>0&($G(PARS(0))>0) PARS(0)=$G(PARS(0))-1 Q:$L(KEY)'>1
 S EROOT=ROOT_"""D""," S:+($G(SYS))>0&($D(@(ROOT_"""AD"","_+($G(SYS))_")"))) EROOT=ROOT_"""AD"","_+($G(SYS))_","
 S EXACT=0 I $O(PARS(0))'>0,$L(PRIME),$D(@(EROOT_""""_PRIME_""")")) S EXACT=1
 I EXACT>0!(ABBR>0) D
 . N ORD,STR,TKN S STR=PRIME F TKN=STR,(STR_"S"),(STR_"ES") D
 . . S ORD=TKN I $D(@(EROOT_""""_ORD_""")")) D TXT2
 I (EXACT'>0&(ABBR'>0))!('$D(^TMP(SUB,$J,"FND"))) D
 . N I S I=0 F  S I=$O(PARS(+I)) Q:+I'>0  K PARS(+I,"A")
 . N ORD,STR,TKN S STR=PRIME F TKN=STR,(STR_"S"),(STR_"ES") D
 . . S ORD=$E(TKN,1,($L(TKN)-1))_$C(($A($E(TKN,$L(TKN)))-1))_"~"
 . . F  S ORD=$O(@(EROOT_""""_ORD_""")")) Q:'$$ISORD^ICDEXLK3  D TXT2
 D:$D(^TMP(SUB,$J,"FND")) SEL^ICDEXLK5(ROOT,0)
 Q
TXT2 ;   Lookup by Text (loop)
 N IEN S IEN=0 F  S IEN=$O(@(EROOT_""""_ORD_""","_+IEN_")")) Q:+IEN'>0  D
 . N OK,NUM,TDT,TIE,TXT,KEY,VDT S VDT=+CDT+.000001
 . S TDT=$O(@(EROOT_""""_ORD_""","_+IEN_","_VDT_")"),-1)
 . I +($G(VER))'>0,TDT'?7N D
 . . S TDT=$O(@(EROOT_""""_ORD_""","_+IEN_","_(+CDT-.000001)_")"))
 . Q:TDT'?7N  S TIE=$O(@(EROOT_""""_ORD_""","_+IEN_","_+TDT_",0)"))
 . S TXT=$$UP^XLFSTR($G(@(ROOT_+IEN_",68,"_+TIE_",1)")))
 . I $G(DIC(0))'["A",$G(DIC(0))["O" D  Q
 . . Q:CNT>1  I ORG=TXT D FND^ICDEXLK5(ROOT,IEN,CDT,$G(SYS),$G(VER),0,$G(OUT)) S CNT=CNT+1
 . S OK=1,NUM=0
 . F  S NUM=$O(PARS(NUM)) Q:+NUM'>0  D
 . . N EXACT,PR,OR,SP,IN,AB S PR=$G(PARS(NUM)),AB=+($G(PARS(+NUM,"A")))
 . . I AB'>0 S IN=$$IN(TXT,PR),SP=$$SI(ROOT,+IEN,+TIE,PR)
 . . I AB>0 S IN=$$EX(TXT,PR),SP=$$SE(ROOT,+IEN,+TIE,PR)
 . . S:IN'>0&(SP'>0) OK=0
 . D:+OK>0 FND^ICDEXLK5(ROOT,IEN,CDT,$G(SYS),$G(VER),0,$G(OUT))
 Q
 ; 
 ; Miscellaneous
SE(RT,IE,TI,X) ;   Supplemental Word (exact match exist)
 N CNTL,IIEN,PLUR,TEXT,ROOT,TIEN
 S CNTL=$$UP^XLFSTR($G(X)) Q:'$L(CNTL) 0
 S ROOT=$$ROOT^ICDEX($G(RT)) Q:'$L(ROOT) 0
 S IIEN=+($G(IE)),TIEN=+($G(TI))
 S TEXT=$$UP^XLFSTR($G(@(ROOT_+IIEN_",68,"_+TIEN_",1)"))) Q:'$L(TEXT) 0
 Q:'$D(@(ROOT_+IIEN_",68,"_+TIEN_",2,""B"","""_CNTL_""")")) 0
 S PLUR=$$EX(TEXT,(CNTL_"S")) Q:PLUR>0 0
 Q 1
SI(RT,IE,TI,X) ;   Supplemental Word (match exist)
 N CNTL,IIEN,PLUR,TEXT,NEXT,TIEN,ORDR,ROOT
 S CNTL=$$UP^XLFSTR($G(X)) Q:'$L(CNTL) 0
 S ROOT=$$ROOT^ICDEX($G(RT)) Q:'$L(ROOT) 0
 S IIEN=+($G(IE)),TIEN=+($G(TI))
 S:CNTL?1N.N ORDR=CNTL-.00000000000000009 I CNTL'?1N.N D
 . S:$L(CNTL)=1 ORDR=$C($A(CNTL)-1)_"~"
 . S:$L(CNTL)>1 ORDR=$E(CNTL,1,($L(CNTL)-1))_$C($A($E(CNTL,$L(CNTL)))-1)_"~"
 S NEXT=$O(@(ROOT_+IIEN_",68,"_+TIEN_",2,""B"","""_ORDR_""")"))
 Q:$E(NEXT,1,$L(CNTL))=CNTL 1
 Q 0
EX(X,Y) ;   String Y is exactly in X
 N CON,CNTL,TEXT,EXACT S TEXT=$G(X),CNTL=$G(Y),EXACT=1
 S CON=$$CON(TEXT,CNTL) S X=+($G(CON))
 Q X
IN(X,Y) ;   String Y is contained in X
 N CON,CNTL,TEXT S TEXT=$G(X),CNTL=$G(Y)
 S CON=$$CON(TEXT,CNTL) S X=+($G(CON))
 Q X
CON(X,Y) ;   Text X Contains String Y
 N CNTL,CONT,TEXT,LEAD,TRAIL,STR
 S TEXT=$$UP^XLFSTR($G(X)),CNTL=$$UP^XLFSTR($G(Y))
 Q:'$L(TEXT) 0  Q:'$L(CNTL) 0  Q:$L(CNTL)>$L(TEXT) 0
 S (X,CONT)=0 I +($G(EXACT))>0 S X=0 D  Q X
 . F TRAIL=" ","/","-","(","<","{","[","," D  Q:CONT>0
 . . N STR S STR=CNTL_TRAIL S:$E(TEXT,1,$L(STR))=STR CONT=1 S:CONT>0 X=CONT
 . Q:CONT>0  F LEAD=" ","/","-","(","<","{","[","," D  Q:CONT>0
 . . N STR S STR=LEAD_CNTL S:$E(TEXT,($L(TEXT)-$L(STR)),$L(TEXT))=STR CONT=1 S:CONT>0 X=CONT
 . Q:CONT>0  F LEAD=" ","/","-","(","<","{","[","," D  Q:CONT>0
 . . F TRAIL=" ","-",")",">","}","]","," D  Q:CONT>0
 . . . N STR S STR=LEAD_CNTL_TRAIL S:TEXT[STR CONT=1 S:CONT>0 X=CONT
 . S:CONT>0 X=CONT
 S:$E(TEXT,1,$L(CNTL))=CNTL CONT=1
 S:CONT>0 X=CONT Q:CONT>0 X
 F LEAD=" ","/","-","(","<","{","[","," D  Q:CONT>0
 . N STR S STR=LEAD_CNTL S:TEXT[STR CONT=1 S:CONT>0 X=CONT
 Q:CONT>0 X  F LEAD=" ","/","-","(","<","{","[","," D  Q:CONT>0
 . N TRAIL F TRAIL=" ","-",")",">","}","]","," D  Q:CONT>0
 . . N STR S STR=LEAD_CNTL_TRAIL S:TEXT[STR CONT=1 S:CONT>0 X=CONT
 S:CONT>0 X=CONT
 Q X
LC(X) ;   Leading Character
 S X=$G(X) S X=$$UP^XLFSTR($E(X,1))_$$LOW^XLFSTR($E(X,2,$L(X)))
 Q X
SS ;   Show Select/Find Global Arrays
 N NN,NC,EX S EX=0 S NN="^TMP(""ICD9"","_$J_")",NC="^TMP(""ICD9"","_$J_","
 F  S NN=$Q(@NN) Q:'$L(NN)!(NN'[NC)  D  Q:EX>20
 . W !,NN,"=",$E(@NN,1,48) S EX=EX+1
 S EX=0 S NN="^TMP(""ICD0"","_$J_")",NC="^TMP(""ICD0"","_$J_","
 F  S NN=$Q(@NN) Q:'$L(NN)!(NN'[NC)  D  Q:EX>20
 . W !,NN,"=",$E(@NN,1,48) S EX=EX+1
 Q
