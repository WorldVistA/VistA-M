LEXQIL ;ISL/KER - Query - ICD Non-Versioned Lookup ;10/10/2017
 ;;2.0;LEXICON UTILITY;**114**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^TMP("LEXQIL"        SACC 2.3.2.5.1
 ;               
 ; External References
 ;    ^DIR                ICR  10026
 ;    $$CODEC^ICDEX       ICR   5747
 ;    $$CSI^ICDEX         ICR   5747
 ;    $$ICDDX^ICDEX       ICR   5747
 ;    $$ICDOP^ICDEX       ICR   5747
 ;    $$ROOT^ICDEX        ICR   5747
 ;    TOKEN^ICDEX         ICR   5747
 ;    $$DT^XLFDT          ICR  10103
 ;    $$UP^XLFSTR         ICR  10103
 ;               
 ; Main Entry Points ICD/ICP
ICD(X) ;   ICD DX Lookup
 N LEXFI,LEXINP,LEXOUT,LEXDIRB S LEXDIRB=$$TM($G(X)),X="^",LEXFI=80
 S:$L($G(LEXDIRB)) LEXINP=LEXDIRB S:'$L($G(LEXDIRB)) LEXINP=$$INP Q:$E(LEXINP,1)="^" "^"  Q:$E(LEXINP,1,2)="^^" "^^"
 K ^TMP("LEXQIL",$J) D BC($G(LEXINP),$G(LEXFI)) I +($G(^TMP("LEXQIL",$J,0)))=1 D  Q X
 . N OUT S LEXFI=80 S LEXOUT=$$ONE,X=-1 S:$E(LEXOUT,1)["^" X="^" S:+LEXOUT>0 X=$G(LEXOUT)
 I +($G(^TMP("LEXQIL",$J,0)))>1 D  Q X
 . N OUT S LEXFI=80 S LEXOUT=$$MUL,X=-1 S:$E(LEXOUT,1)["^" X="^" S:+LEXOUT>0 X=$G(LEXOUT)
 K ^TMP("LEXQIL",$J) D BT($G(LEXINP),$G(LEXFI)) I +($G(^TMP("LEXQIL",$J,0)))=1 D  Q X
 . N OUT S LEXFI=80 S LEXOUT=$$ONE,X=-1 S:$E(LEXOUT,1)["^" X="^" S:+LEXOUT>0 X=$G(LEXOUT)
 I +($G(^TMP("LEXQIL",$J,0)))>1 D  Q X
 . N OUT S LEXFI=80 S LEXOUT=$$MUL,X=-1 S:$E(LEXOUT,1)["^" X="^" S:+LEXOUT>0 X=$G(LEXOUT)
 Q X
ICP(X) ;   ICD PR Lookup
 N LEXFI,LEXINP,LEXOUT,LEXDIRB S LEXDIRB=$$TM($G(X)),X="^",LEXFI=80.1
 S:$L($G(LEXDIRB)) LEXINP=LEXDIRB S:'$L($G(LEXDIRB)) LEXINP=$$INP Q:$E(LEXINP,1)="^" "^"  Q:$E(LEXINP,1,2)="^^" "^^"
 K ^TMP("LEXQIL",$J) D BC($G(LEXINP),$G(LEXFI)) I +($G(^TMP("LEXQIL",$J,0)))=1 D  Q X
 . N OUT S LEXFI=80.1 S LEXOUT=$$ONE,X=-1 S:$E(LEXOUT,1)["^" X="^" S:+LEXOUT>0 X=$G(LEXOUT)
 I +($G(^TMP("LEXQIL",$J,0)))>1 D  Q X
 . N OUT S LEXFI=80.1 S LEXOUT=$$MUL,X=-1 S:$E(LEXOUT,1)["^" X="^" S:+LEXOUT>0 X=$G(LEXOUT)
 K ^TMP("LEXQIL",$J) D BT($G(LEXINP),$G(LEXFI)) I +($G(^TMP("LEXQIL",$J,0)))=1 D  Q X
 . N OUT S LEXFI=80.1 S LEXOUT=$$ONE,X=-1 S:$E(LEXOUT,1)["^" X="^" S:+LEXOUT>0 X=$G(LEXOUT)
 I +($G(^TMP("LEXQIL",$J,0)))>1 D  Q X
 . N OUT S LEXFI=80.1 S LEXOUT=$$MUL,X=-1 S:$E(LEXOUT,1)["^" X="^" S:+LEXOUT>0 X=$G(LEXOUT)
 Q X
 ;
 ; Selections
ONE(X) ;   One Entry Found
 Q:"^80^80.1^"'[("^"_$G(LEXFI)_"^") "^^"  Q:+($G(LEXEXIT))>0 "^^"
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LEX,LEXC,LEXCT,LEXIEN,LEXTX,LEXX,Y
 S LEXTX=$G(^TMP("LEXQIL",$J,1)),LEXIEN=+LEXTX,LEXTX=$P(LEXTX,U,2),LEX(1)=LEXTX D PR^LEXU(.LEX,70)
 S DIR("A",1)=" One code found",DIR("A",2)=" ",DIR("A",3)="     "_$G(LEX(1)),LEXC=3 K LEX(1) D:$O(LEX(0))>0 PR^LEXU(.LEX,64)
 S:$L($G(LEX(1))) LEXC=LEXC+1,DIR("A",LEXC)="                "_$G(LEX(1))
 S:$L($G(LEX(2))) LEXC=LEXC+1,DIR("A",LEXC)="                "_$G(LEX(2))
 S LEXC=LEXC+1,DIR("A",LEXC)=" ",LEXC=LEXC+1,DIR("A")="   OK?  (Yes/No)  ",DIR("B")="Yes",DIR(0)="YAO" W:'$D(LEXQUIET) !
 S (X,Y)="" D:'$D(LEXQUIET) ^DIR S:$D(LEXQUIET) Y=1 S:X["^^"!($D(DTOUT)) LEXEXIT=1,X="^^"
 I X["^^"!(+($G(LEXEXIT))>0)!($D(DIROUT)) K ^TMP("LEXQIL",$J) S LEXEXIT=1 Q "^^"
 S X=-1 S:+Y'>0 X=-1  S:+Y>0 X=$$X(+($G(LEXIEN)),+($G(LEXFI)))
 Q X
MUL(X) ;   Multiple Entries Found
 Q:"^80^80.1^"'[("^"_$G(LEXFI)_"^") "^^"  Q:+($G(LEXEXIT))>0 "^^"
 N LEXENT,LEXI,LEXIEN,LEXIT,LEXMAX,LEXSS,LEXSTR,LEXT1,LEXTTT,Y
 S (LEXMAX,LEXI,LEXSS,LEXIT)=0 S U="^",LEXTTT=$G(^TMP("LEXQIL",$J,0)),LEXSS=0
 G:+LEXTTT=0 MULQ W ! W:+LEXTTT>1 !," ",LEXTTT," matches found"
 F LEXI=1:1:LEXTTT Q:((LEXSS>0)&(LEXSS<LEXI+1))  Q:LEXIT  D  Q:LEXIT
 . S LEXENT=$G(^TMP("LEXQIL",$J,LEXI))
 . S LEXIEN=$P(LEXENT,U,1) Q:'$L($P(LEXENT,"^",2))  S LEXMAX=LEXI W:LEXI#5=1 ! D MULW
 . W:LEXI#5=0 ! S:LEXI#5=0 LEXSS=$$MULS(LEXMAX,LEXI) S:LEXSS["^" LEXIT=1
 I LEXI#5'=0,+LEXSS=0 W ! S LEXSS=$$MULS(LEXMAX,LEXI) S:LEXSS["^" LEXIT=1
 G MULQ
 Q X
MULW ;     Write Multiple
 N LEX,LEXIEN,LEXJ,LEXK,LEXTX S LEXK=+($G(LEXI)) N LEXI S LEXTX=$P(LEXENT,U,2),LEXIEN=+LEXENT
 K LEX S LEX(1)=LEXTX D PR^LEXU(.LEX,70) W !,$J(LEXK,5),".  ",$G(LEX(1)) K LEX(1) D:$O(LEX(0))>0 PR^LEXU(.LEX,59)
 F LEXJ=1:1:5 S LEXTX=$G(LEX(LEXJ)) W:$L(LEXTX) !,"                   ",LEXTX
 Q
MULS(X,Y) ;     Select Multiple
 Q:+($G(LEXEXIT))>0 "^^"
 N DIR,DIRB,DIROUT,DIRUT,DTOUT,DUOUT,LEXI,LEXLAST,LEXMAX,LEXS,LEXTQ,Y
 S (LEXS,LEXMAX)=+($G(X)),(LEXI,LEXLAST)=+($G(Y)) Q:LEXMAX=0 -1
 S:+($O(^TMP("LEXQIL",$J,+LEXLAST)))>0 DIR("A")=" Press <RETURN> for more, '^' to exit, or Select 1-"_LEXMAX_":  "
 S:+($O(^TMP("LEXQIL",$J,+LEXLAST)))'>0 DIR("A")=" Select 1-"_LEXMAX_":  "
 S LEXTQ="    Answer must be from 1 to "_LEXMAX_", or <Return> to continue"
 S DIR("PRE")="S:X[""?"" X=""??""",(DIR("?"),DIR("??"))="^D MULSH^LEXQL"
 S DIR(0)="NAO^1:"_LEXMAX_":0" D ^DIR S:X["^^"!($D(DTOUT)) LEXEXIT=1,X="^^" I X["^^"!(+($G(LEXEXIT))>0) K ^TMP("LEXQIL",$J) Q "^^"
 S LEXS=+Y S:$D(DTOUT)!(X[U) LEXS=U K DIR
 Q LEXS
MULSH ;     Select Multiple Help
 I $L($G(LEXTQ)) W !,$G(LEXTQ) Q
 Q
MULQ ;     Quit Multiple
 Q:+LEXSS'>0 -1  S X=-1 Q:"^80^80.1^"'[("^"_$G(LEXFI)_"^") X I +LEXSS>0 D
 . N LEXIEN S LEXIEN=+($G(^TMP("LEXQIL",$J,+LEXSS))) S:+LEXIEN>0 X=$$X(+($G(LEXIEN)),+($G(LEXFI)))
 Q X
 ; 
 ; Lookups
BC(X,Y) ;   Lookup by Code
 K ^TMP("LEXQIL",$J) N LEXFI,LEXCTL,LEXIEN,LEXINP,LEXORD,LEXRT,LEXSY S LEXFI=+($G(Y)) Q:"^80^80.1^"'[("^"_$G(LEXFI)_"^")
 S LEXINP=$G(X) Q:'$L(X)  S LEXRT=$$ROOT^ICDEX(LEXFI)
 S LEXORD=$E(LEXINP,1,($L(LEXINP)-1))_$C($A($E(LEXINP,$L(LEXINP)))-1)_"~",LEXCTL=LEXINP
 F  S LEXORD=$O(@(LEXRT_"""BA"","""_LEXORD_""")")) Q:'$L(LEXORD)  Q:LEXORD'[LEXCTL  D
 . N LEXIEN S LEXIEN=0,LEXTMP=LEXRT_"""BA"","""_LEXORD_""","_LEXIEN_")"
 . F  S LEXIEN=$O(@(LEXRT_"""BA"","""_LEXORD_""","_LEXIEN_")")) Q:+LEXIEN'>0  D
 . . I +LEXIEN>0&($D(@(LEXRT_+LEXIEN_",0)"))) D
 . . . N LEXCODE,LEXCOM,LEXCT,LEXEFF,LEXHIS,LEXLAS,LEXSPC,LEXSR,LEXSTA,LEXSTR,LEXTD,LEXTXT,LEXTY S LEXTD=$$DT^XLFDT
 . . . S LEXCODE=$P($G(@(LEXRT_LEXIEN_",0)")),"^",1),LEXSR=$P($G(@(LEXRT_LEXIEN_",1)")),"^",1)
 . . . S:"^1^30^"[("^"_LEXSR_"^") LEXTY="Diagnosis" S:"^2^31^"[("^"_LEXSR_"^") LEXTY="Procedure"
 . . . S LEXEFF=$O(@(LEXRT_LEXIEN_",66,""B"","_(LEXTD+.0001)_")"),-1)
 . . . S LEXHIS=0 S:LEXEFF?7N LEXHIS=$O(@(LEXRT_LEXIEN_",66,""B"","_+LEXEFF_","" "")"),-1)
 . . . S LEXSTA=0 S:LEXHIS>0 LEXSTA=$P($G(@(LEXRT_LEXIEN_",66,"_+LEXHIS_",0)")),"^",2)
 . . . S LEXLAS=$O(@(LEXRT_LEXIEN_",66,""B"","" "")"),-1)
 . . . S LEXHIS=$O(@(LEXRT_LEXIEN_",68,""B"","" "")"),-1)
 . . . S:LEXHIS?7N LEXHIS=$O(@(LEXRT_LEXIEN_",68,""B"","_+LEXHIS_","" "")"),-1)
 . . . S LEXTXT="" S:+LEXHIS>0 LEXTXT=$P($G(@(LEXRT_LEXIEN_",68,"_+LEXHIS_",1)")),"^",1)
 . . . S:LEXEFF=""&(LEXLAS?7N) LEXCOM="Pending"
 . . . S:LEXEFF?7N&(+LEXSTA'>0) LEXCOM="Inactive"
 . . . S:LEXSR'>29&($L($G(LEXCOM))) LEXCOM=$G(LEXCOM)_", ICD-9"
 . . . S:LEXSR>29&($L($G(LEXCOM))) LEXCOM=$G(LEXCOM)_", ICD-10"
 . . . S:$L($G(LEXTY))&($L($G(LEXCOM))) LEXCOM=LEXCOM_" "_LEXTY
 . . . S LEXSPC=$S(LEXFI=80:$J(" ",(11-$L($G(LEXCODE)))),1:$J(" ",(10-$L($G(LEXCODE)))))
 . . . S LEXSTR=$G(LEXCODE)_LEXSPC_LEXTXT S:$L($G(LEXCOM)) LEXSTR=LEXSTR_" ("_$G(LEXCOM)_")"
 . . . I $D(LEXQUIET),$L($G(LEXDIRB)) D  Q
 . . . . I $G(LEXDIRB)=LEXCODE S ^TMP("LEXQIL",$J,0)=1,^TMP("LEXQIL",$J,1)=(LEXIEN_"^"_LEXSTR)
 . . . S LEXCT=$O(^TMP("LEXQIL",$J," "),-1)+1
 . . . S ^TMP("LEXQIL",$J,0)=LEXCT
 . . . S ^TMP("LEXQIL",$J,LEXCT)=(LEXIEN_"^"_LEXSTR)
 Q
BT(X,Y) ;   Lookup by Text
 N LEXFI,LEXINP,LEXRT S LEXINP=$G(X) Q:'$L(X)  S LEXFI=+($G(Y)) Q:"^80^80.1^"'[("^"_LEXFI_"^")  S LEXRT=$$ROOT^ICDEX(LEXFI) D BLD(LEXINP,LEXFI)
 Q
BLD(X,Y) ;     Build Selection Array
 K ^TMP("LEXQIL",$J) Q:'$L($G(X))!('$L($G(Y))) "^^"  N LEXFI,LEXINP,LEXRT,LEXSY,LEXTOK K LEXTOK
 S LEXINP=$$UP^XLFSTR($G(X)),LEXFI=+($G(Y)),LEXRT=$$ROOT^ICDEX(LEXFI) D PAR(LEXINP,LEXFI,.LEXTOK) D GET(LEXFI,.LEXTOK)
 Q
PAR(X,Y,LEX) ;     Parse text into tokens
 N LEXFI,LEXI,LEXINP,LEXRT,LEXSY,LEXTK,LEXTMP S LEXINP=$G(X),LEXFI=+($G(Y)),LEXRT=$$ROOT^ICDEX(LEXFI),LEXSY="" K LEX
 Q:'$L(LEXINP)  Q:'$D(LEXRT)  D TOKEN^ICDEX($G(LEXINP),$G(LEXRT),$G(LEXSY),.LEXTMP)
 S LEXI=0 F  S LEXI=$O(LEXTMP(LEXI)) Q:+LEXI'>0  D
 . N LEXTK S LEXTK=$G(LEXTMP(LEXI)) Q:'$L(LEXTK)  Q:'$D(@(LEXRT_"""D"","""_LEXTK_""")"))
 . S LEX(0)=+($G(LEX(0)))+1,LEX(+($G(LEX(0))))=LEXTK
 K LEXTMP
 Q
GET(X,LEX) ;     Get Entries
 N LEXFI,LEXRT,LEXORD,LEXORG,LEXIEN,LEXTD S LEXFI=+($G(X)),LEXRT=$$ROOT^ICDEX(LEXFI),LEXORG=$G(LEX(1)) Q:'$L(LEXORG)  S LEXTD=$$DT^XLFDT
 S LEXIEN=0 F  S LEXIEN=$O(@(LEXRT_"""D"","""_LEXORG_""","_+LEXIEN_")")) Q:+LEXIEN'>0  D
 . N LEXOK,LEXI S LEXOK=1 S LEXI=1 F  S LEXI=$O(LEX(LEXI)) Q:+LEXI'>0  D  Q:'LEXOK
 . . N LEXORD S LEXORD=$G(LEX(LEXI)) I '$D(@(LEXRT_"""D"","""_LEXORD_""","_+LEXIEN_")")) S LEXOK=0 Q
 . I LEXOK D
 . . N LEXCODE,LEXCOM,LEXEFF,LEXHIS,LEXLAS,LEXSPC,LEXSR,LEXSTA,LEXSTR,LEXTXT,LEXTY
 . . S LEXCODE=$P($G(@(LEXRT_LEXIEN_",0)")),"^",1)
 . . S LEXSR=$P($G(@(LEXRT_LEXIEN_",1)")),"^",1)
 . . S:"^1^30^"[("^"_LEXSR_"^") LEXTY="Diagnosis"
 . . S:"^2^31^"[("^"_LEXSR_"^") LEXTY="Procedure"
 . . S LEXEFF=$O(@(LEXRT_LEXIEN_",66,""B"","_(LEXTD+.0001)_")"),-1)
 . . S LEXHIS=0 S:LEXEFF?7N LEXHIS=$O(@(LEXRT_LEXIEN_",66,""B"","_+LEXEFF_","" "")"),-1)
 . . S LEXSTA=0 S:LEXHIS>0 LEXSTA=$P($G(@(LEXRT_LEXIEN_",66,"_+LEXHIS_",0)")),"^",2)
 . . S LEXLAS=$O(@(LEXRT_LEXIEN_",66,""B"","" "")"),-1)
 . . S LEXHIS=$O(@(LEXRT_LEXIEN_",68,""B"","" "")"),-1)
 . . S:LEXHIS?7N LEXHIS=$O(@(LEXRT_LEXIEN_",68,""B"","_+LEXHIS_","" "")"),-1)
 . . S LEXTXT="" S:+LEXHIS>0 LEXTXT=$P($G(@(LEXRT_LEXIEN_",68,"_+LEXHIS_",1)")),"^",1)
 . . S:LEXEFF=""&(LEXLAS?7N) LEXCOM="Pending"
 . . S:LEXEFF?7N&(+LEXSTA'>0) LEXCOM="Inactive"
 . . S:LEXSR'>29&($L($G(LEXCOM))) LEXCOM=$G(LEXCOM)_", ICD-9"
 . . S:LEXSR>29&($L($G(LEXCOM))) LEXCOM=$G(LEXCOM)_", ICD-10"
 . . S:$L($G(LEXTY))&($L($G(LEXCOM))) LEXCOM=LEXCOM_" "_LEXTY
 . . S LEXSPC=$S(LEXFI=80:$J(" ",(11-$L($G(LEXCODE)))),1:$J(" ",(10-$L($G(LEXCODE)))))
 . . S LEXSTR=$G(LEXCODE)_LEXSPC_LEXTXT S:$L($G(LEXCOM)) LEXSTR=LEXSTR_" ("_$G(LEXCOM)_")"
 . . S ^TMP("LEXQIL",$J,"ORD",(LEXCODE_" "))=(LEXIEN_"^"_LEXSTR)
 S LEXORD="" F  S LEXORD=$O(^TMP("LEXQIL",$J,"ORD",LEXORD)) Q:'$L(LEXORD)  D
 . N LEXCT,LEXVAL S LEXVAL=$G(^TMP("LEXQIL",$J,"ORD",LEXORD)) Q:+LEXVAL'>0  Q:'$L($P(LEXVAL,"^",2))
 . S LEXCT=$O(^TMP("LEXQIL",$J," "),-1)+1,^TMP("LEXQIL",$J,LEXCT)=LEXVAL,^TMP("LEXQIL",$J,0)=LEXCT
 K ^TMP("LEXQIL",$J,"ORD")
 Q
 ; 
 ; Miscellaneous
INP(X) ;   Input
 Q:"^80^80.1^"'[("^"_$G(LEXFI)_"^") "^^"  Q:+($G(LEXEXIT))>0 "^^"
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LEXTD,Y,LEX,LEXIT S:LEXFI=80 DIR("A")=" Enter a Diagnosis Code or Term:  "
 S:LEXFI=80.1 DIR("A")=" Enter a Procedure Code or Term:  " Q:'$L($G(DIR("A"))) "^^"  S DIR(0)="FAO^1:70"
 S DIR("PRE")="S:X[""?"" X=""??""",(DIR("?"),DIR("??"))="^D INPH^LEXQIL" W ! D ^DIR
 Q:X="^^"!($D(DTOUT))!(+($G(LEXEXIT))) "^^"  S:$D(DIROUT)!($D(DIRUT))!($D(DTOUT))!($D(DUOUT)) X="^" Q:$E(X,1)="^" X
 S X="^" S:$L(Y) X=$$UP^XLFSTR(Y)
 Q X
INPH ;   Input Help
 I +($G(LEXFI))=80 D  Q
 . W !,"     Enter an ICD Diagnosis code or a term, or '^' to exit",!
 I +($G(LEXFI))=80.1 D  Q
 . W !,"     Enter an ICD Procedure code or a term, or '^' to exit",!
 W !,"     Enter an ICD code or a term, or '^' to exit",!
 Q
X(X,Y) ;   Get X Return Value
 N LEXIEN,LEXFI S LEXIEN=+X,X=-1,LEXFI=$G(Y) Q:"^80^80.1^"'[("^"_LEXFI_"^") -1 I +LEXIEN>0 D
 . N LEXFD,LEXSO,LEXSY,LEXDX,LEXTX,LEXTD S LEXFD=$$FD,LEXTD=$$DT^XLFDT,LEXSO=$$CODEC^ICDEX(LEXFI,LEXIEN)
 . S LEXSY=$$CSI^ICDEX(LEXFI,LEXIEN)
 . I LEXFI=80 S LEXDX=$$ICDDX^ICDEX(LEXSO,LEXFD,LEXSY,"E"),LEXTX=$P(LEXDX,"^",4)
 . I LEXFI=80.1 S LEXDX=$$ICDOP^ICDEX(LEXSO,LEXFD,LEXSY,"E"),LEXTX=$P(LEXDX,"^",5)
 . S X=LEXIEN_"^"_LEXSO_"^"_LEXTX
 S X=$$UP^XLFSTR(X)
 Q X
FD(X) ;   Get Future Date
 S X=$$DT^XLFDT,X=($E(X,1,3)+1)_"1001" N LEXEXIT
 Q X
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
