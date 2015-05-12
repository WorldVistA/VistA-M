LEXQL ;ISL/KER - Query - Lookup Code ;12/19/2014
 ;;2.0;LEXICON UTILITY;**62,80,86**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^DIC(81.3,          ICR   4492
 ;    ^ICPT(              ICR   4489
 ;    ^ICPT("BA")         ICR   4489
 ;    ^TMP("LEXQL")       SACC 2.3.2.5.1
 ;    ^UTILITY($J)        ICR  10011
 ;               
 ; External References
 ;    ^DIR                ICR  10026
 ;    $$ICDDX^ICDEX       ICR   5747
 ;    $$ICDOP^ICDEX       ICR   5747
 ;    $$ROOT^ICDEX        ICR   5747
 ;    $$CODEABA^ICDEX     ICR   5747
 ;    $$CPT^ICPTCOD       ICR   1995
 ;    $$MOD^ICPTMOD       ICR   1996
 ;    $$DT^XLFDT          ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 N DIR,DIRB,DIROUT,DIRUT,DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,DTOUT,DUOUT,LEX,LEXC,LEXCOM,LEXCT,LEXCTY,LEXD,LEXDS,LEXDT,LEXE,LEXENT,LEXFD
 N LEXFI,LEXI,LEXIEN,LEXIN,LEXIT,LEXIX,LEXKEY,LEXL,LEXLAST,LEXLEN,LEXMAX,LEXN,LEXNM,LEXO,LEXOC,LEXRTN,LEXS,LEXSEL,LEXSO,LEXSS,LEXSTR,LEXT
 N LEXT1,LEXT2,LEXT3,LEXTAG,LEXTD,LEXTMP,LEXTN,LEXTOT,LEXTQ,LEXTS,LEXTTT,LEXTY,LEXUSR,LEXV,LEXVAL,LEXX,Y
 K ^TMP("LEXQL",$J),^UTILITY($J) S X=$$SO K ^TMP("LEXQL",$J),^UTILITY($J)
 Q
SO(X) ; Select a Code
 ;               
 ; Input    None
 ;             
 ; Output   X - "^" delimited string
 ;              1 - IEN
 ;              2 - Global Root
 ;              3 - File #
 ;              4 - Coding System (if available)
 ;              5 - Code
 ;              6 - Short Name
 ;            
 ;            or "^" if no code is found/selected
 ;               
 K ^TMP("LEXQL",$J) Q:+($G(LEXEXIT))>0 "^^"  N DIR,DIROUT,DIRUT,DTOUT,DUOUT,DIRB,LEXTD,Y,LEX,LEXIT
 S LEXTD=$G(LEXVDT) S:LEXTD'?7N LEXTD=$$DT^XLFDT S LEXIT=0
 S DIR(0)="FAO^1:30",DIR("A")=" Select a Code:  "
 S DIRB=$$RET^LEXQD("LEXQL","SO",+($G(DUZ)),"Select a Code") S:$L(DIRB) DIR("B")=DIRB
 S DIR("PRE")="S:'$L(X)&($L($G(DIR(""B"")))) X=$G(DIR(""B"")) S X=$TR($$UP^XLFSTR(X),""#"""""",""""),X=$$VSO^LEXQL2(X) S X=$$SEL^LEXQL(X)"
 S (DIR("?"),DIR("??"))="^D SOH^LEXQL" D ^DIR S X=$TR(X,"#""",""),Y=$TR(Y,"#""","")
 I X="^^"!($D(DTOUT))!(+($G(LEXEXIT))) K ^TMP("LEXQL",$J) Q "^^"
 I '$D(^TMP("LEXQL",$J,"X")) S:$L(Y)&(Y=$P(DIRB,U,4)) ^TMP("LEXQL",$J,"X")=DIRB
 S:$D(DIROUT)!($D(DIRUT))!($D(DTOUT))!($D(DUOUT)) X="^" Q:$E(X,1)="^" X
 S X="" S:$L($G(^TMP("LEXQL",$J,"X"))) X=$G(^TMP("LEXQL",$J,"X"))
 S LEX=$P(X,U,5) D:$L(LEX) SAV^LEXQD("LEXQL","SO",+($G(DUZ)),"Select a Code",LEX) K ^TMP("LEXQL",$J)
 Q X
SOH ;   Select a Code Help
 W !,"     Enter a code from either:",!
 W !,"       ICD-9 Diagnosis file       #80       4-7 Characters"
 W !,"       ICD-9 Procedure file       #80.1     3-5 Characters"
 W !,"       ICD-10 Diagnosis file      #80       4-8 Characters"
 W !,"       ICD-10 Procedure file      #80.1     7 Characters"
 W !,"       CPT/HCPCS Procedure file   #81       5 Characters"
 W !,"       CPT Modifier file          #81.3     2 Characters",!
 W !,"     Or enter keywords, 2-30 characters, to search for in"
 W !,"     the above files.",!
 Q
SOGD(X) ;   Select a Code Global/Data
 N LEX,LEXTD S LEX=$G(X) Q:'$L(LEX) "^"  S LEXTD=$$DT^XLFDT
 ; 80 ICD-9
 Q:$$CODEABA^ICDEX(X,80,1)>0 ($TR($$ROOT^ICDEX(80),"^","")_"^"_$$ICDDX^ICDEX(X,LEXTD,1,"E"))
 Q:$$CODEABA^ICDEX($$UP^XLFSTR(X),80,1)>0 ($TR($$ROOT^ICDEX(80),"^","")_"^"_$$ICDDX^ICDEX($$UP^XLFSTR(X),LEXTD,1,"E"))
 ; 80 ICD-10
 Q:$$CODEABA^ICDEX(X,80,30)>0 ($TR($$ROOT^ICDEX(80),"^","")_"^"_$$ICDDX^ICDEX(X,LEXTD,30,"E"))
 Q:$$CODEABA^ICDEX($$UP^XLFSTR(X),80,30)>0 ($TR($$ROOT^ICDEX(80),"^","")_"^"_$$ICDDX^ICDEX($$UP^XLFSTR(X),LEXTD,30,"E"))
 ; 80.1 ICD-9
 Q:$$CODEABA^ICDEX(X,80.1,2)>0 ($TR($$ROOT^ICDEX(80.1),"^","")_"^"_$$ICDOP^ICDEX(X,LEXTD,2,"E"))
 Q:$$CODEABA^ICDEX($$UP^XLFSTR(X),80.1,2)>0 ($TR($$ROOT^ICDEX(80.1),"^","")_"^"_$$ICDOP^ICDEX($$UP^XLFSTR(X),LEXTD,2,"E"))
 ; 80.1 ICD-10
 Q:$$CODEABA^ICDEX(X,80.1,31)>0 ($TR($$ROOT^ICDEX(80.1),"^","")_"^"_$$ICDOP^ICDEX(X,LEXTD,31,"E"))
 Q:$$CODEABA^ICDEX($$UP^XLFSTR(X),80.1,31)>0 ($TR($$ROOT^ICDEX(80.1),"^","")_"^"_$$ICDOP^ICDEX($$UP^XLFSTR(X),LEXTD,31,"E"))
 ; 81 CPT
 Q:$D(^ICPT("BA",(X_" "))) ("ICPT("_"^"_$$CPT^ICPTCOD(X,$G(LEXTD)))
 Q:$D(^ICPT("BA",($$UP^XLFSTR(X)_" "))) ("ICPT("_"^"_$$CPT^ICPTCOD($$UP^XLFSTR(X),$G(LEXTD)))
 ; 81.3 CPT Modifier
 Q:$D(^DIC(81.3,"BA",(X_" "))) ("DIC(81.3,"_"^"_$$MOD^ICPTMOD(X,"E",$G(LEXTD)))
 Q:$D(^DIC(81.3,"BA",($$UP^XLFSTR(X)_" "))) ("DIC(81.3,"_"^"_$$MOD^ICPTMOD($$UP^XLFSTR(X),"E",$G(LEXTD)))
 Q ""
 ;            
SEL(X) ; Select from List
 Q:'$L($G(X)) ""  Q:$G(X)["^" $G(X)  Q:$G(X)["?" "??"  K ^TMP("LEXQL",$J) D ADD^LEXQL2($G(X)) Q:'$D(^TMP("LEXQL",$J)) "??"  D ASK
 K ^TMP("LEXQL",$J) Q:+($G(LEXEXIT))>0 "^^"  Q:+X'>0 "??"  S:+($G(X))>0 ^TMP("LEXQL",$J,"X")=X S:+($G(X))>0 X=$P($G(X),"^",4)
 Q X
ASK ;   Ask for Selection
 K X N LEXTOT S LEXTOT=+($G(^TMP("LEXQL",$J,0))) S:+LEXTOT'>0 X="^" Q:+LEXTOT'>0  K X
 S:+LEXTOT=1 X=$$ONE Q:+LEXTOT=1  S:+LEXTOT>1 X=$$MUL
 Q
ONE(X) ;     One Entry Found
 Q:+($G(LEXEXIT))>0 "^^"  N LEXT1,LEXT2,LEXT3,LEX,LEXC,LEXCT,LEXIEN,LEXX,DIR,Y,DTOUT,DUOUT,DIROUT,DIRUT
 S LEXT1=$G(^TMP("LEXQL",$J,1)),LEXCT=$$CT(LEXT1),LEXIEN=+LEXT1,LEXT1=$P(LEXT1,U,2),LEXT2=$G(^TMP("LEXQL",$J,1,2))
 S:$L(LEXT1)&($L(LEXT2)) LEXT1=LEXT1_" "_LEXT2 S (LEXT3,LEX(1))=LEXT1
 S LEXX=LEXIEN_U_$$FI(LEXT3)_U_LEXCT D PR^LEXQL2(.LEX,64)
 S DIR("A",1)=" One code found",DIR("A",2)=" ",DIR("A",3)="     "_$G(LEX(1)),LEXC=3
 S:$L($G(LEX(2))) LEXC=LEXC+1,DIR("A",LEXC)="                         "_$G(LEX(2))
 S LEXC=LEXC+1,DIR("A",LEXC)=" ",LEXC=LEXC+1,DIR("A")="   OK?  (Yes/No)  ",DIR("B")="Yes",DIR(0)="YAO" W !
 D ^DIR S:X["^^"!($D(DTOUT)) LEXEXIT=1,X="^^" I X["^^"!(+($G(LEXEXIT))>0)!($D(DIROUT)) K ^TMP("LEXQL",$J) S LEXEXIT=1 Q "^^"
 S X=$S(+Y>0:$$X(1),1:-1)
 Q X
MUL(X) ;     Multiple Entries Found
 Q:+($G(LEXEXIT))>0 "^^"  N LEXIEN,LEXENT,LEXT1,LEXTTT,LEXMAX,LEXI,LEXSS,LEXIT,LEXSTR,Y S (LEXMAX,LEXI,LEXSS,LEXIT)=0 S U="^"
 S LEXTTT=$G(^TMP("LEXQL",$J,0)),LEXSS=0 G:+LEXTTT=0 MULQ W ! W:+LEXTTT>1 !," ",LEXTTT," matches found"
 F LEXI=1:1:LEXTTT Q:((LEXSS>0)&(LEXSS<LEXI+1))  Q:LEXIT  D  Q:LEXIT
 . S LEXENT=$G(^TMP("LEXQL",$J,LEXI)) S LEXSTR=$P(LEXENT,U,1) Q:'$L(LEXSTR)  S LEXMAX=LEXI W:LEXI#5=1 ! D MULW
 . W:LEXI#5=0 ! S:LEXI#5=0 LEXSS=$$MULS(LEXMAX,LEXI) S:LEXSS["^" LEXIT=1
 I LEXI#5'=0,+LEXSS=0 W ! S LEXSS=$$MULS(LEXMAX,LEXI) S:LEXSS["^" LEXIT=1
 G MULQ
 Q X
MULW ;       Write Multiple
 N LEXT1,LEXT2,LEXT3,LEXIEN,LEX S LEXT1=$P(LEXENT,U,2),LEXT2=$G(^TMP("LEXQL",$J,LEXI,2)),LEXCT=$$CT(LEXT1),LEXIEN=+LEXENT
 K LEX S:$L(LEXT1)&($L(LEXT2)) LEXT1=LEXT1_" "_LEXT2
 S (LEXT3,LEX(1))=LEXT1 D PR^LEXQL2(.LEX,63)
 W !,$J(LEXI,5),".  ",$G(LEX(1)) F LEXT1=2:1:5 S LEXT2=$G(LEX(LEXT1)) W:$L(LEXT2) !,"                            ",LEXT2
 Q
MULS(LEXS,LEXI) ;       Select Multiple
 Q:+($G(LEXEXIT))>0 "^^"  N X,Y,LEXMAX,LEXLAST,DIR,DIRB,DTOUT,DUOUT,DIRUT,DIROUT,LEXTQ S LEXMAX=+($G(LEXS)),LEXLAST=+($G(LEXI)) Q:LEXMAX=0 -1
 S:+($O(^TMP("LEXQL",$J,+LEXLAST)))>0 DIR("A")=" Press <RETURN> for more, '^' to exit, or Select 1-"_LEXMAX_":  "
 S:+($O(^TMP("LEXQL",$J,+LEXLAST)))'>0 DIR("A")=" Select 1-"_LEXMAX_":  "
 S LEXTQ="    Answer must be from 1 to "_LEXMAX_", or <Return> to continue"
 S DIR("PRE")="S:X[""?"" X=""??""",(DIR("?"),DIR("??"))="^D MULSH^LEXQL"
 S DIR(0)="NAO^1:"_LEXMAX_":0" D ^DIR S:X["^^"!($D(DTOUT)) LEXEXIT=1,X="^^" I X["^^"!(+($G(LEXEXIT))>0) K ^TMP("LEXQL",$J) Q "^^"
 S LEXS=+Y S:$D(DTOUT)!(X[U) LEXS=U K DIR
 Q LEXS
MULSH ;       Select Multiple Help
 I $L($G(LEXTQ)) W !,$G(LEXTQ) Q
 Q
MULQ ;       Quit Multiple
 Q:+LEXSS'>0 -1  S X=-1 S:+($G(LEXIT))'>0 X=$$X(+LEXSS)
 Q X
 ; 
 ; Miscellaneous
X(X) ;   Set X
 N LEXCT,LEXFI,LEXIEN,LEXSEL,LEXT1,LEXT2,LEXT3 S LEXSEL=+($G(X))
 S LEXT1=$G(^TMP("LEXQL",$J,+($G(LEXSEL)))),LEXT2=$G(^TMP("LEXQL",$J,+($G(LEXSEL)),2))
 S LEXT3=LEXT1 S:$L(LEXT2) LEXT3=LEXT3_" "_LEXT2 S LEXCT=$$CT(LEXT3),LEXFI=$$FI(LEXT3)
 S LEXIEN=+LEXT1 S X=$$UP^XLFSTR((LEXIEN_U_LEXFI_U_LEXCT))
 Q X
CT(X) ;   Code and Text
 S X=$G(X) N LEXIEN,LEXC,LEXN,LEXT S LEXIEN=+X Q:+LEXIEN'>0 ""  S LEXT=$P(X,U,2) Q:'$L(LEXT) ""
 I LEXT["ICD-9 Dx"!(LEXT["ICD-9 Diag") D
 . S LEXN=$$ICDDX^ICDEX(LEXIEN,$G(LEXVDT),1,"I"),LEXC=$P(LEXN,"^",2),LEXN=$P(LEXN,"^",4)
 I LEXT["ICD-9 Op"!(LEXT["ICD-9 Proc") D
 . S LEXN=$$ICDOP^ICDEX(LEXIEN,$G(LEXVDT),2,"I"),LEXC=$P(LEXN,"^",2),LEXN=$P(LEXN,"^",5)
 I LEXT["ICD-10 Dx"!(LEXT["ICD-10 Diag") D
 . S LEXN=$$ICDDX^ICDEX(LEXIEN,$G(LEXVDT),30,"I"),LEXC=$P(LEXN,"^",2),LEXN=$P(LEXN,"^",4)
 I LEXT["ICD-10 Op"!(LEXT["ICD-10 Proc") D
 . S LEXN=$$ICDOP^ICDEX(LEXIEN,$G(LEXVDT),31,"I"),LEXC=$P(LEXN,"^",2),LEXN=$P(LEXN,"^",5)
 I LEXT["CPT-4"!(LEXT["CPT P")!(LEXT["HCPCS") D
 . S LEXC=$P($G(^ICPT(+LEXIEN,0)),U,1),LEXN=$P($$CPT^ICPTCOD(LEXC,$G(LEXVDT)),U,3)
 I LEXT["CPT Mod" D
 . S LEXC=$P($G(^DIC(81.3,+LEXIEN,0)),U,1),LEXN=$P($$MOD^ICPTMOD(LEXIEN,"I",$G(LEXVDT)),U,3)
 S X="" S:$L($G(LEXC))&($L($G(LEXN))) X=LEXC_U_LEXN
 Q X
FI(X) ;   File
 S X=$G(X)
 Q:X["ICD-9 Dx"!(X["ICD-9 Diag") ($TR($$ROOT^ICDEX(80),"^","")_"^80^1")
 Q:X["ICD-9 Op"!(X["ICD-9 Proc") ($TR($$ROOT^ICDEX(80.1),"^","")_"^80.1^2")
 Q:X["ICD-10 Dx"!(X["ICD-10 Diag") ($TR($$ROOT^ICDEX(80),"^","")_"^80^30")
 Q:X["ICD-10 Op"!(X["ICD-10 Proc") ($TR($$ROOT^ICDEX(80.1),"^","")_"^80.1^31")
 Q:X["CPT-4"!(X["CPT Proc") "ICPT(^81^3"  Q:X["HCPCS" "ICPT(^81^4"
 Q:X["CPT Mod" "DIC(81.3,^81.3^"
 Q ""
SHO ;   Show TMP
 N LEXNN,LEXNC S LEXNN="^TMP(""LEXQL"","_$J_")",LEXNC="^TMP(""LEXQL"","_$J_","
 W ! F  S LEXNN=$Q(@LEXNN) Q:'$L(LEXNN)!(LEXNN'[LEXNC)  W !,LEXNN,"=",@LEXNN
 W !
 Q
 ; Miscellaneous
CL ;   Clear
 K LEXVDT,LEXEXIT
 Q
