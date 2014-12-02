LEX10DU ;ISL/KER - ICD-10 Diagnosis Utilities ;04/21/2014
 ;;2.0;LEXICON UTILITY;**80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^LEX(757.033        N/A
 ;    ^TMP("DIAGSRCH"     SACC 2.3.2.5.1
 ;    ^TMP("LEXDX")       SACC 2.3.2.5.1
 ;    ^TMP("LEXTKN"       SACC 2.3.2.5.1
 ;               
 ; External References
 ;    ^DIM                ICR  10016
 ;    $$ICDDX^ICDEX       ICR   5747
 ;    $$LD^ICDEX          ICR   5747
 ;    $$SD^ICDEX          ICR   5747
 ;    $$DT^XLFDT          ICR  10103
 ;               
 ; Local Variables NEWed or KILLed by calling 
 ; routine LEX10DBT, LEX10DBC or LEX10CS
 ;     LEXA 
 ;     LEXCS
 ;     LEXDATA
 ;     LEXFI
 ;     LEXINC
 ;     LEXVDT
 ;     
 Q
REDUCE(X) ; Reduce List
 N LEXC,LEXIT,LEXLEN,LEXMAX,LEXPRE,LEXUSE
 S LEXUSE=0,LEXLEN=8,LEXPRE=7,LEXMAX=+($G(X))
 S:LEXMAX'>0 LEXMAX=30 S LEXCT=+($G(LEXCT)) Q:+LEXCT'>0
 S LEXIT=0 F  Q:LEXCT'>LEXMAX!(LEXIT)  D  Q:LEXIT
 . S:LEXPRE=LEXLEN LEXIT=1 Q:LEXIT
 . N LEXC S LEXC="",LEXCT=0
 . F  S LEXC=$O(^TMP("LEXDX",$J,LEXC)) Q:'$L(LEXC)  D
 . . I $L(LEXC)=(LEXLEN+1) D  Q
 . . . N LEXCAT,LEXIS,LEXNCT,LEXNCD,LEXNPR,LEXCE,LEXTX
 . . . S LEXCAT=$$CAT(LEXC),LEXCE=$P(LEXCAT,"^",2)
 . . . S LEXTX=$P(LEXCAT,"^",3),LEXCAT=$P(LEXCAT,"^",1)
 . . . K ^TMP("LEXDX",$J,LEXC) S LEXUSE=1
 . . . Q:$D(^TMP("LEXDX",$J,(LEXCAT_" ")))
 . . . S LEXIS=$$ISCAT(LEXCAT)
 . . . S LEXNCT=$P(LEXIS,"^",2)
 . . . S LEXNCD=$P(LEXIS,"^",3)
 . . . S LEXNPR=$P(LEXIS,"^",4)
 . . . I $L(LEXCAT),LEXCE?7N,$L(LEXTX) D
 . . . . N LEX S LEX=LEXCE_"^"_LEXTX
 . . . . S:+($G(LEXNCD))>0 $P(LEX,"^",3)=+($G(LEXNCD))
 . . . . S ^TMP("LEXDX",$J,(LEXCAT_" "))="^"_LEX S LEXCT=LEXCT+1
 . . S LEXCT=LEXCT+1
 . I LEXPRE>3 S LEXLEN=LEXPRE,LEXPRE=LEXPRE-1 Q
 . S:LEXPRE=3 LEXIT=1
 S LEXC="" F  S LEXC=$O(^TMP("LEXDX",$J,LEXC)) Q:'$L(LEXC)  D
 . S LEXCT=$P($G(^TMP("LEXDX",$J,LEXC)),"^",4) Q:LEXCT'>0
 . N LEXCTL,LEXNXT,LEXCT S LEXCTL=$TR(LEXC," ") Q:'$L(LEXCTL)
 . S LEXNXT=$O(^TMP("LEXDX",$J,(LEXCTL_" "))) Q:'$L(LEXNXT)
 . K:$E(LEXNXT,1,$L(LEXCTL))=LEXCTL ^TMP("LEXDX",$J,(LEXCTL_" "))
 Q
ARY ; Build Local Array
 N LEXC,LEXACT S LEXC="",LEXACT=0
 F  S LEXC=$O(^TMP("LEXDX",$J,LEXC)) Q:'$L(LEXC)  D
 . N LEXSIEN,LEXEIEN,LEXEXP,LEXCAT,LEXND,LEXD,LEXSO,LEXNC
 . S LEXND=$G(^TMP("LEXDX",$J,LEXC))
 . S LEXSIEN=+LEXND,LEXD=$P($P(LEXND,"^",2),".",1)
 . S LEXCAT=$P(LEXND,"^",3),LEXNC=$P(LEXND,"^",4)
 . S LEXEIEN=+($G(^LEX(757.02,+LEXSIEN,0)))
 . S LEXEXP=$G(^LEX(757.01,+LEXEIEN,0)),LEXSO=$$TM(LEXC)
 . I '$L(LEXCAT) Q:LEXSIEN'>0  Q:LEXEIEN'>0  Q:'$L(LEXEXP)
 . Q:($G(LEXCDT)?7N)&(LEXD'?7N)  Q:'$D(LEXCDT)&(LEXD'?7N)  Q:'$L(LEXSO)
 . I +LEXSIEN>0 D
 . . S LEXACT=LEXACT+1 S LEXA(LEXACT)=LEXSIEN_"^"_LEXSO_"^"_LEXD
 . . S LEXA(LEXACT,0)=+LEXEIEN_"^"_LEXEXP
 . I +LEXSIEN'>0,$L(LEXCAT) D
 . . N LEX S LEX="^"_LEXSO_"^"_LEXD
 . . S:+($G(LEXNC))>0 $P(LEX,"^",4)=+($G(LEXNC))
 . . S LEXACT=LEXACT+1 S LEXA(LEXACT)=LEX
 . . S LEXA(LEXACT,0)="^"_LEXCAT
 . S LEXA(0)=LEXACT
 S:+($G(LEXA(0)))'>0 LEXA(0)=-1 Q:+($G(LEXA(0)))'>0
 S:+($G(LEXUSE))>0&($G(LEXA(0))>0) $P(LEXA(0),"^",2)=1
 Q
DXARY ; Build Output Array from Search Results
 N LEXOI,LEXC,LEXCO,LEXCT S LEXFI=+($G(LEXFI)) Q:"^80^"'[("^"_LEXFI_"^")
 S LEXCS=+($G(LEXCS)) Q:+LEXCS'>0  Q:"^1^30^"'[("^"_LEXCS_"^")
 K ^TMP("DIAGSRCH",$J) S (LEXCT,LEXOI)=0
 F  S LEXOI=$O(LEXOUT(LEXOI)) Q:+LEXOI'>0  D
 . N LEXC,LEXI S LEXC=$P($G(LEXOUT(LEXOI)),"^",2) Q:'$L(LEXC)
 . S ^TMP("DIAGSRCH",$J,(LEXC_" "))=$G(LEXOUT(LEXOI))
 . S ^TMP("DIAGSRCH",$J,(LEXC_" "),0)=$G(LEXOUT(LEXOI,0))
 . Q:+($G(LEXCS))'=30  F LEXI=1:1:$L(LEXC) D
 . . Q
 . . N LEXS,LEXSD,LEXSI,LEXSN,LEXF,LEXFA S LEXS=$E(LEXC,1,($L(LEXC)-LEXI))
 . . Q:'$D(^LEX(757.033,"AFRAG",30,(LEXS_" ")))
 . . S LEXSD=$O(^LEX(757.033,"AFRAG",30,(LEXS_" "),0))
 . . Q:LEXSD'?7N  Q:+($G(LEXVDT))<LEXSD
 . . S LEXSI=$O(^LEX(757.033,"AFRAG",30,(LEXS_" "),LEXSD,0))
 . . Q:+LEXSI'>0  S LEXSN=$$LN(+LEXSI)
 . . S:'$L(LEXSN) LEXSN=$$SN(+LEXSI) Q:'$L(LEXSN)
 . . S ^TMP("DIAGSRCH",$J,(LEXS_" "))="-^"_LEXS_"^"_LEXSD
 . . S ^TMP("DIAGSRCH",$J,(LEXS_" "),0)="-^"_LEXSN
 K LEXOUT S LEXCO="" F  S LEXCO=$O(^TMP("DIAGSRCH",$J,LEXCO)) Q:'$L(LEXCO)  D
 . N LEXC,LEXEFF,LEXEIEN,LEXEXP,LEXI,LEXICD,LEXICDT,LEXLD,LEXLDE
 . N LEXN1,LEXN2,LEXND,LEXO,LEXP1,LEXP2,LEXP3,LEXPF,LEXPR,LEXS
 . N LEXSD,LEXSDE,LEXSIEN,LEXSY,LEXMSG
 . S LEXN1=$G(^TMP("DIAGSRCH",$J,LEXCO))
 . S LEXN2=$G(^TMP("DIAGSRCH",$J,LEXCO,0))
 . S LEXSIEN=+LEXN1,LEXEIEN=+LEXN2
 . S LEXC=$P(LEXN1,"^",2),LEXEFF=$P(LEXN1,"^",3)
 . S LEXMSG=$$MSG(LEXC)
 . S LEXEXP=$P(LEXN2,"^",2)
 . I LEXSIEN'>0,LEXEIEN'>0 D  Q
 . . N LEXO,LEXC,LEXE,LEXT,LEXN,LEXNC,LEXMSG
 . . S LEXC=$P(LEXN1,"^",2) Q:'$L(LEXC)
 . . S LEXE=$P(LEXN1,"^",3) Q:LEXE'?7N
 . . S LEXNC=$P(LEXN1,"^",4)
 . . S LEXNC=$S(+LEXNC>0:+LEXNC,1:"")
 . . S LEXN=$P(LEXN2,"^",2) Q:'$L(LEXN)
 . . S LEXT="CAT"
 . . S LEXO=$O(LEXDATA(" "),-1)+1
 . . S LEXDATA(LEXO,0)=LEXC_$S($G(LEXEFF)?7N:("^"_LEXEFF),1:"")
 . . S:+LEXNC>0 $P(LEXDATA(LEXO,0),"^",3)=+LEXNC
 . . S LEXDATA(LEXO,LEXT)=LEXN
 . . S LEXDATA(LEXO,"MENU")=LEXN
 . . S:$L($G(LEXMSG)) LEXDATA(LEXO,"MSG")=$G(LEXMSG)
 . I LEXCS=1!(LEXCS=30) D
 . . S LEXICD=$$ICDDX^ICDEX(LEXC,LEXVDT,LEXCS,"E") S (LEXSD,LEXLD)=""
 . . S:+LEXICD>0 LEXSD=$$SD^ICDEX(80,+LEXICD,LEXVDT,.LEXSD)
 . . I LEXVDT'?7N,$P(LEXSD,"^",1)="-1" D
 . . . N LEXSH,LEXT,LEXE S LEXT=$$SDH^ICDEX(80,+LEXICD,.LEXSH)
 . . . S LEXE=$O(LEXSH(9999999),-1),LEXS=$G(LEXSH(+LEXE)) S:$L(LEXS) LEXSD=LEXS
 . . . S:+($G(LEXSH(0)))>0 LEXSD(0)=$P($G(LEXSH(0)),"^",1,2)
 . . S LEXSDE=$P($G(LEXSD(0)),"^",2) S:LEXSDE'?7N LEXSDE="" S LEXLD=""
 . . S:+LEXICD>0 LEXLD=$$LD^ICDEX(80,+LEXICD,LEXVDT,.LEXLD)
 . . I LEXVDT'?7N,$P(LEXLD,"^",1)="-1" D
 . . . N LEXLH,LEXT,LEXE S LEXT=$$LDH^ICDEX(80,+LEXICD,.LEXLH)
 . . . S LEXE=$O(LEXLH(9999999),-1),LEXS=$G(LEXLH(+LEXE)) S:$L(LEXS) LEXLD=LEXS
 . . . S:+($G(LEXLH(0)))>0 LEXLD(0)=$P($G(LEXLH(0)),"^",1,2)
 . . S LEXLDE=$P($G(LEXLD(0)),"^",2) S:LEXLDE'?7N LEXLDE=""
 . . S:$E(LEXLD,1,2)="-1" LEXLD=""
 . S:LEXSIEN>0&(+LEXEIEN>0) LEXCT=+($G(LEXCT))+1
 . S LEXO=$O(LEXDATA(" "),-1)+1,LEXDATA(LEXO,0)=LEXC
 . I $D(LEXINC) D
 . . S:+LEXSIEN>0 $P(LEXDATA(LEXO,0),"^",2)=+LEXSIEN
 . . S:+LEXSIEN>0&(LEXEFF?7N) $P(LEXDATA(LEXO,0),"^",3)=LEXEFF
 . I '$D(LEXINC) D
 . . S:+LEXSIEN>0&(LEXEFF?7N) $P(LEXDATA(LEXO,0),"^",2)=LEXEFF
 . S (LEXDATA(LEXO,"LEX"),LEXDATA(LEXO,"MENU"))=LEXEXP
 . S:$L($G(LEXMSG)) LEXDATA(LEXO,"MSG")=$G(LEXMSG)
 . S:+LEXEIEN>0 LEXDATA(LEXO,"LEX",1)=+LEXEIEN
 . S:+LEXEIEN>0&(LEXEFF?7N) $P(LEXDATA(LEXO,"LEX",1),"^",2)=LEXEFF
 . S LEXICDT="" S:$L($G(LEXSD)) LEXDATA(LEXO,"IDS")=LEXSD
 . S:$L($G(LEXSD))&(+LEXICD>0) $P(LEXICDT,"^",1)=+LEXICD
 . S:$L($G(LEXSD))&(+LEXICD>0)&(LEXSDE?7N) $P(LEXICDT,"^",2)=+LEXSDE
 . S:$L(LEXICDT) LEXDATA(LEXO,"IDS",1)=LEXICDT
 . S LEXICDT="" S:$L($G(LEXLD)) LEXDATA(LEXO,"IDL")=LEXLD
 . S:$L($G(LEXLD))&(+LEXICD>0) $P(LEXICDT,"^",1)=+LEXICD
 . S:$L($G(LEXLD))&(+LEXICD>0)&(LEXLDE?7N) $P(LEXICDT,"^",2)=+LEXLDE
 . S:$L(LEXICDT) LEXDATA(LEXO,"IDL",1)=LEXICDT
 . S LEXDATA(0)=+($G(LEXCT))
 . S:+($G(LEXPR))>0 $P(LEXDATA(0),"^",2)=+($G(LEXPR))
 . S LEXSY="" D GETSYN^LEXTRAN1("10D",LEXC,LEXVDT,"LEXSY",1)
 . S LEXPF=$G(LEXSY("P")),LEXP1=$P(LEXPF,"^",1),LEXP2=$P(LEXPF,"^",2)
 . S LEXP3=$P(LEXPF,"^",3) I $L(LEXP1),+LEXP2>0 D
 . . S LEXDATA(LEXO,"LEX")=$P(LEXPF,"^",1)
 . . S:LEXP2>0 $P(LEXDATA(LEXO,"LEX",1),"^",1)=LEXP2
 . . S:LEXP3>0 $P(LEXDATA(LEXO,"LEX",1),"^",2)=LEXP3
 . S LEXI=0 F  S LEXI=$O(LEXSY("S",LEXI)) Q:+LEXI'>0  D
 . . N LEXS,LEXND,LEXP1,LEXP2 S LEXND=$G(LEXSY("S",LEXI))
 . . S LEXP1=$P(LEXND,"^",1),LEXP2=+($P(LEXND,"^",2)) Q:LEXP2'>0
 . . Q:'$L(LEXP1)  S LEXS=$O(LEXDATA(LEXO,"SYN"," "),-1)+1
 . . S LEXDATA(LEXO,"SYN",LEXS)=LEXND
 . . S LEXDATA(LEXO,"SYN",0)=+LEXS
 S:$O(LEXDATA(" "),-1)>0 LEXDATA(0)=$O(LEXDATA(" "),-1)
 K ^TMP("DIAGSRCH",$J)
 Q
 ;               
 ; Miscellaneous
ISCAT(CODE) ;   Is Code a Category
 ;
 ;   Input
 ;  
 ;      CODE     Code or Category
 ;
 ;   Output
 ; 
 ;      $$ISCAT  4 Piece "^" Delimited String
 ;    
 ;                1  Category flag
 ;                      1 CODE is a Category
 ;                      0 CODE is not a Category
 ;                  
 ;                2  Number of Sub-Categories belonging
 ;                   to the Category
 ;                
 ;                3  Number of Codes belonging to the 
 ;                   Category
 ;                   
 ;                4  Parent Category 
 ;                      Parent Category
 ;                      Null if no Parent Category
 ;         
 N CATS,PAR S CODE=$P($G(CODE),"^",1) Q:'$L(CODE) 0
 S:$L(CODE)=3&(CODE'[".") CODE=CODE_"."
 Q:$L(CODE)>3&(CODE'[".") 0
 S CATS=$$INC(CODE),PAR=$$PAR(CODE)
 Q:$D(^LEX(757.033,"AFRAG",30,(CODE_" "))) ("1^"_CATS_"^"_PAR)
 Q 0
INC(X) ;   Category includes Cat/Codes
 ;
 ;   Input
 ;  
 ;      CODE     Code or Category
 ;
 ;   Output     
 ;   
 ;      $$INC    2 Piece "^" Delimited String
 ;    
 ;                  1  Number of Sub-Categories belonging
 ;                     to the Category
 ;               
 ;                  2  Number of Codes belonging to the 
 ;                     Category
 ;         
 Q ($$CATS($G(X))_"^"_$$CODES($G(X)))
CATS(X) ;   Number of Categories in a Category
 ;
 ;   Input
 ;  
 ;      X        Category
 ;
 ;   Output     
 ;   
 ;      $$CATS   Number of Sub-Categories belonging to a Category
 ;    
 N CODE,ORG,ORD,CTL S (CTL,CODE)=$G(X),(ORG,ORD)=$E(CODE,1,($L(CODE)-1))_$C($A($E(CODE,$L(CODE)))-1)_"~"
 S X=0 F  S ORD=$O(^LEX(757.033,"AFRAG",30,ORD)) Q:'$L(ORD)!(ORD'[CTL)  S:ORD'=(CODE_" ") X=X+1
 Q X
PAR(X) ;   Parent Category
 N INP,PSN,EXIT,PAR S INP=$G(X),EXIT=0,PAR=""
 F PSN=$L(INP):-1:4 D  Q:EXIT  Q:$L($G(PAR))
 . N STR S STR=$E(INP,1,PSN) Q:$L(STR)'<$L(INP)  Q:$L(STR)'>3
 . Q:'$D(^LEX(757.033,"AFRAG",30,(STR_" ")))
 . S PAR=STR,EXIT=1
 S X=$S($L(PAR):PAR,1:"")
 Q X
CODES(X) ;   Number of Codes in a Category
 ;
 ;   Input
 ;  
 ;      X        Category
 ;
 ;   Output     
 ;   
 ;      $$CODES  Number of codes belonging to a Category
 ;    
 N CODE,ORG,ORD,CTL S (CTL,CODE)=$G(X),(ORG,ORD)=$E(CODE,1,($L(CODE)-1))_$C($A($E(CODE,$L(CODE)))-1)_"~"
 S X=0 F  S ORD=$O(^LEX(757.02,"ADX",ORD)) Q:'$L(ORD)!(ORD'[CTL)  S:ORD'=(CODE_" ") X=X+1
 Q X
CAT(CODE) ;   Get Category for Code
 ;
 ;   Input
 ;  
 ;      CODE    Code or Category
 ;
 ;   Output
 ; 
 ;      $$CAT   3 Piece "^" Delimited String
 ;    
 ;                  1  Category
 ;                  2  Effective Date
 ;                  3  Category  Name
 ;         
 ;                  Null on error
 ; 
 S CODE=$G(CODE) Q:'$L(CODE) ""  N FRAG,MAX,OUT,TDT,LEN S FRAG=$TR(CODE," ","")
 S OUT="",TDT=$P($G(LEXVDT),".",1),MAX=$L(FRAG) F LEN=MAX:-1:3 D  Q:$L(OUT)
 . N EFF,NAM,IEN S FRAG=$E(FRAG,1,(LEN-1))
 . S:$L(FRAG)=3&(FRAG'[".") FRAG=FRAG_"." Q:$L(FRAG)'>3
 . S EFF=$O(^LEX(757.033,"AFRAG",30,(FRAG_" ")," "),-1)
 . S:TDT?7N EFF=$O(^LEX(757.033,"AFRAG",30,(FRAG_" "),(TDT+.0001)),-1)
 . S EFF=$P(EFF,".",1) Q:EFF'?7N  I TDT?7N Q:EFF>TDT
 . S IEN=$O(^LEX(757.033,"AFRAG",30,(FRAG_" "),+EFF," "),-1)
 . S NAM=$$LN(IEN,+EFF) S:'$L(NAM) NAM=$$SN(IEN,+EFF) Q:'$L(NAM)
 . S:$L(FRAG)&(EFF?7N)&($L(NAM)) OUT=(FRAG_"^"_EFF_"^"_NAM)
 Q OUT
MSG(X) ; Message for Unversioned Search
 N LEXCODE,LEXIA,LEXAC,LEXPD,LEXTD S LEXTD=$$DT^XLFDT,LEXCODE=$TR(X," ","")
 S:$G(LEXCDT)?7N&($G(LEXCDT)'=LEXTD) LEXTD=$G(LEXCDT)
 I $G(LEXCDT)="" S:$G(LEXVDT)?7N&($G(LEXVDT)'=LEXTD) LEXTD=$G(LEXVDT)
 Q:'$L(LEXCODE) ""  Q:'$D(^LEX(757.02,"ACT",(LEXCODE_" "))) ""
 S LEXIA=$O(^LEX(757.02,"ACT",(LEXCODE_" "),2,(LEXTD+.0001)),-1)
 S LEXAC=$O(^LEX(757.02,"ACT",(LEXCODE_" "),3,(LEXTD-.0001)),-1)
 S LEXPD=$O(^LEX(757.02,"ACT",(LEXCODE_" "),3,(LEXTD)))
 I LEXIA?7N,LEXAC?7N,LEXIA>LEXAC D  Q X
 . S X="Inactive "_$$FMTE^XLFDT(LEXIA,"5Z")
 I LEXAC'=LEXTD,LEXPD?7N,LEXPD>LEXTD D  Q X
 . S X="Pending "_$$FMTE^XLFDT(LEXPD,"5Z")
 Q ""
SN(X,EFF) ; Short Name
 N IEN,CDT,IMP,EFF,HIS S IEN=+($G(X)),CDT=$G(LEXVDT) S:$G(EFF)?7N CDT=$G(EFF)
 S IMP=$$IMPDATE^LEXU(30) S:CDT'?7N CDT=$$DT^XLFDT
 S:CDT'>IMP&(IMP?7N) CDT=IMP
 S EFF=$O(^LEX(757.033,+IEN,2,"B",(CDT+.001)),-1)
 S HIS=$O(^LEX(757.033,+IEN,2,"B",+EFF," "),-1)
 S X=$G(^LEX(757.033,+IEN,2,+HIS,1))
 Q X
LN(X,EFF) ; Long Name
 N IEN,CDT,IMP,EFF,HIS S IEN=+($G(X)),CDT=$G(LEXVDT) S:$G(EFF)?7N CDT=$G(EFF)
 S IMP=$$IMPDATE^LEXU(30) S:CDT'?7N CDT=$$DT^XLFDT
 S:CDT'>IMP&(IMP?7N) CDT=IMP
 S EFF=$O(^LEX(757.033,+IEN,3,"B",(CDT+.001)),-1)
 S HIS=$O(^LEX(757.033,+IEN,3,"B",+EFF," "),-1)
 S X=$G(^LEX(757.033,+IEN,3,+HIS,1))
 Q X
SCR(X,Y) ;   Screen
 S Y=+($G(Y)) Q:+Y'>0 0  Q:'$D(^LEX(757.01,+Y,0)) 0
 N LEXFIL S LEXFIL=$G(X) Q:'$L(LEXFIL) 1  D ^DIM Q:'$D(X) 1
 X LEXFIL S X=$T
 Q X
SH ; Show TMP
 N LEXNN,LEXNC S LEXNN="^TMP(""LEXDX"","_$J_")",LEXNC="^TMP(""LEXDX"","_$J_","
 W !!,"3",! F  S LEXNN=$q(@LEXNN) Q:'$L(LEXNN)!(LEXNN'[LEXNC)  W !,LEXNN,"=",@LEXNN
 Q
PT ; Entry point where DA is defined and X is unknown
 Q:'$D(DA)  S X=^LEX(757.01,DA,0)
PTX ; Entry point to parse string (X must exist)
 N LEXOK,LEXTOKS,LEXTOKS2,LEXTOKI,LEXTOKW,LEXTOLKN,LEXOKC,LEXOKN,LEXOKP,LEXTOKAA,LEXTOKAB,LEXTOKAC K ^TMP("LEXTKN",$J) N DA
 Q
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
