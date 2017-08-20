LEXINF ;ISL/KER - Information - Main ;05/23/2017
 ;;2.0;LEXICON UTILITY;**103**;Sep 23, 1996;Build 2
 ;               
 ; Global Variables
 ;    ^LEX(757.01         SACC 1.3
 ;    ^LEX(757.02         SACC 1.3
 ;    ^LEX(757.03         SACC 1.3
 ;    ^XTMP(              SACC 2.3.2.5.2
 ;               
 ; External References
 ;    HOME^%ZIS           ICR  10086
 ;    $$GET1^DIQ          ICR   2056
 ;    ^DIR                ICR  10026
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMADD^XLFDT       ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;               
EN ; Main Entry Point (interactive)
 N LEXENV,LEXMET,LEXCDT,LEXDSP,LEXTMP K ARY,LEXARY,LEXIIEN S LEXENV=$$ENV I LEXENV'>0 W !!,?3,"Environmental variables missing ",! Q
 S LEXTMP=0,LEXMET=$$CT I "^C^T^"'[("^"_LEXMET_"^") W !!,?3,"Type of information not selected ",! Q
 S LEXCDT=$$DATE I LEXCDT'?7N W !!,?3,"Date not selected",! Q
 S LEXDSP=$$DISP I "^1^0^"'[("^"_LEXDSP_"^") W !!,?3,"Display not selected",! Q
 I LEXDSP>0 S LEXTMP=$$INCI I "^1^0^"'[("^"_LEXTMP_"^") W !!,?3,"IEN inclusion not selected",! Q
 S:LEXTMP>0 LEXIIEN=1 D:LEXMET="C" SO D:LEXMET="T" EX
 Q
SO ;   Code
 N LEXSO,LEXCODE,LEXSRC S LEXDSP=+($G(LEXDSP)) S LEXSO=$$CODE^LEXINF4
 S LEXCODE=$P(LEXSO,"^",1) I '$L(LEXCODE) W !!,?3,"Code not selected",! Q
 S LEXSRC=$P(LEXSO,"^",5) I '$D(^LEX(757.03,+LEXSRC,0)) W !!,?3,"Invalid Coding System selected",! Q
 D CODE^LEXINF2(LEXCODE,LEXSRC,$G(LEXCDT),.LEXARY,LEXDSP) K:+($G(LEXDSP))>0 LEXARY
 Q
EX ;   Expression
 N LEXEX,LEXEIEN S LEXDSP=+($G(LEXDSP)) S LEXEX=$$TERM^LEXINF4
 S LEXEIEN=$P(LEXEX,"^",1) I '$D(^LEX(757.01,+LEXEIEN,0)) W !!,?3,"Term not selected",! Q
 D TERM^LEXINF3(LEXEIEN,LEXCDT,.LEXARY,LEXDSP) K:+($G(LEXDSP))>0 LEXARY
 Q
 ;
 ; Silent Entry Points
CODE(LEXCODE,LEXSRC,LEXCDT,LEXARY,LEXOUT) ; Information about a Code
 D CODE^LEXINF2($G(LEXCODE),$G(LEXSRC),$G(LEXCDT),.LEXARY,$G(LEXOUT)) Q
TERM(LEXEIEN,LEXCDT,LEXARY,LEXOUT) ;     Information about a Term
 D TERM^LEXINF3(+($G(LEXEIEN)),$G(LEXCDT),.LEXARY,$G(LEXOUT)) Q
 ;
 ; Questions
CT(X) ;   Code or Term
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LEXDEF,LEXVAL,Y S LEXDEF=$$RET("CT") S:'$L(LEXDEF) LEXDEF="Code"
 S DIR("B")=LEXDEF,DIR(0)="SAO^C:Code;T:Term",DIR("A")=" Get information for a Code or a Term (C/T):  "
 D ^DIR Q:X["^" "^"  Q:$D(DTOUT)!($D(DUOUT)) "^"  Q:"^C^T^"'[("^"_$E($G(Y),1)_"^") "^"
 S LEXVAL=$S(Y="C":"Code",Y="T":"Term",1:"") D:$L(LEXVAL) SAV("CT",LEXVAL) S:$L(LEXVAL) X=Y
 Q X
DISP(X) ;   Display
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LEXDEF,LEXVAL,Y S LEXDEF=$$RET("DISP") S:'$L(LEXDEF) LEXDEF="Yes"
 S (DIR("?"),DIR("??"))="^D DISPH^LEXINF",DIR(0)="YAO",DIR("B")=LEXDEF,DIR("A")=" Display the results?  (Y/N)  "
 D ^DIR Q:X["^" "^"  Q:$D(DTOUT)!($D(DUOUT)) "^"  Q:"^1^0^"'[("^"_$G(Y)_"^") "^"
 S LEXVAL=$S(Y="1":"Yes",Y="0":"No",1:"") D:$L(LEXVAL) SAV("DISP",LEXVAL) S X=+Y
 Q X
DISPH ;   Display Help
 W !,?4," Enter YES to extract and display the information"
 W !,?4," Enter No to extract to a Local Array (no display)"
 Q
INCI(X) ;   Include IENs
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LEXDEF,LEXVAL,Y S LEXDEF=$$RET("INCI") S:'$L(LEXDEF) LEXDEF="Yes"
 S (DIR("?"),DIR("??"))="^D INCIH^LEXINF",DIR(0)="YAO",DIR("B")=LEXDEF,DIR("A")=" Include IENs in the Display?  (Y/N)  "
 D ^DIR Q:X["^" "^"  Q:$D(DTOUT)!($D(DUOUT)) "^"  Q:"^1^0^"'[("^"_$G(Y)_"^") "^"
 S LEXVAL=$S(Y="1":"Yes",Y="0":"No",1:"") D:$L(LEXVAL) SAV("INCI",LEXVAL) S X=+Y
 Q X
INCIH ;   Include IENs Help
 W !,?4," Enter YES to extract and display the information"
 W !,?4," Enter No to extract to a Local Array (no display)"
 Q
DATE(X) ;   Date
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LEXIND,LEXCUR,LEXDEF,LEXFUT,LEXPAS,Y S LEXPAS=2960923,LEXCUR=$$DT^XLFDT
 S LEXFUT=$$FMADD^XLFDT(LEXCUR,730),LEXDEF=$$RET("DATE") S:'$L(LEXDEF) LEXDEF=LEXCUR
 S:$L(LEXDEF) LEXDEF=$$FMTE^XLFDT(LEXDEF,"5Z") S (DIR("?"),DIR("??"))="^D DATEH^LEXINF"
 S DIR("A")=" Select a Date:  ",DIR("B")=LEXDEF,DIR(0)="DAO^"_LEXPAS_":"_LEXFUT_":EX"
 D ^DIR Q:X["^" "^"  Q:$D(DTOUT)!($D(DUOUT)) "^" D:$P($G(Y),"^",1)?7N SAV("DATE",$P($G(Y),"^",1))
 S X="" S:$P($G(Y),".",1)?7N X=$P($G(Y),".",1)
 Q X
DATEH ;   Date Help
 N LEXIND S LEXIND=4 I $G(LEXPAS)?7N,$G(LEXFUT)?7N,$G(LEXFUT)>$G(LEXPAS) D
 .  W !,?4,"Enter a date from ",$$FMTE^XLFDT($G(LEXPAS),"5Z")," to ",$$FMTE^XLFDT($G(LEXFUT),"5Z"),! S LEXIND=8
 W !,?LEXIND,"Examples of Valid Dates:",!,?LEXIND,"   JAN 20 1957 or 20 JAN 57 or 1/20/57 or 012057"
 W !,?LEXIND,"   T   (for TODAY),  T+1 (for TOMORROW),  T+2",!,?LEXIND,"   T-1 (for YESTERDAY),  T-3W (for 3 WEEKS AGO)",!
 W !,?LEXIND,"If the year is omitted, the computer uses ",!,?LEXIND,"CURRENT YEAR.  A 2-digit year means no more than"
 W !,?LEXIND,"20 years in the future, or 80 years in the past."
 Q
 ; 
 ; Miscellaneous
SRC(X) ;   VA Sources
 N LEXCO,LEXSIEN,LEXSRS,LEXSRSE,LEXSS,LEXCO,LEXS
 S LEXCO=$G(X) Q:'$L(LEXCO) ""
 S LEXSRS="^1^30^2^31^3^4^57^6^17^56^",LEXSRSE=""
 S LEXSIEN=0 F  S LEXSIEN=$O(^LEX(757.02,"CODE",(LEXCO_" "),LEXSIEN)) Q:+LEXSIEN'>0  D
 . N LEXSRC S LEXSRC=$P($G(^LEX(757.02,+LEXSIEN,0)),"^",3) Q:+LEXSRC'>0  Q:'$D(^LEX(757.03,+LEXSRC,0))
 . S:LEXSRS'[("^"_LEXSRC_"^") LEXSRSE="Not used by the VA" Q:LEXSRS'[("^"_LEXSRC_"^")
 . S:'$D(LEXSS(+LEXSRC)) LEXSS(0)=+($G(LEXSS(0)))+1
 . S LEXSS(+LEXSRC)=+($G(LEXSS(+LEXSRC)))+1
 I +($G(LEXSS(1)))>0,+($G(LEXSS(5)))>0,+($G(LEXSS(1)))>+($G(LEXSS(5))) K LEXSS(5) S LEXSS(0)=+($G(LEXSS(0)))-1
 I +($G(LEXSS(1)))>0,+($G(LEXSS(6)))>0,+($G(LEXSS(1)))>+($G(LEXSS(6))) K LEXSS(6) S LEXSS(0)=+($G(LEXSS(0)))-1
 S:+($G(LEXSS(0)))'>0 X="-1^Source not found"
 S:+($G(LEXSS(0)))>1 X="-1^Multiple sources found"
 S:+($G(LEXSS(0)))=1&($O(LEXSS(0))>0) X=$O(LEXSS(0))
 S:+($G(LEXSS(0)))'>0&($L($G(LEXSRSE))) X="-1^"_$G(LEXSRSE)
 Q X
SH(ARY) ;   Display Array
 N LEXS S LEXS="" W ! W:$D(LEXDOC) " ;" F  S LEXS=$O(ARY(LEXS)) Q:'$L(LEXS)  D
 . N LEXN,LEXC,LEXD S LEXN="ARY("""_LEXS_""")",LEXC="ARY("""_LEXS_""","
 . I $D(@LEXN) D
 . . W ! W:$D(LEXDOC) " ;" W ! W:$D(LEXDOC) " ;" W ?4,LEXN,"=",$G(@LEXN)
 . F  S LEXN=$Q(@LEXN) Q:'$L(LEXN)!(LEXN'[LEXC)  D
 . . S LEXD=$G(@LEXN) W ! W:$D(LEXDOC) " ;"  W ?4,LEXN,"=""",LEXD,""""
 W ! W:$D(LEXDOC) " ;" N LEXDOC
 Q
SAV(X,Y) ;   Save Defaults
 N LEXRTN,LEXTAG,LEXNUM,LEXCOM,LEXVAL,LEXNAM,LEXID,LEXNOW,LEXFUT,LEXKEY
 S LEXRTN=$P($T(+1)," ",1) Q:'$L(LEXRTN)  S LEXTAG=$G(X) Q:'$L(LEXTAG)
 S LEXCOM=$E($$TM($TR($P($T(@LEXTAG+0)," ",2,4000),";"," ")),1,13) Q:'$L(LEXCOM)  S LEXNUM=+($G(DUZ)) Q:+LEXNUM'>0  S LEXVAL=$G(Y) Q:'$L(LEXVAL)
 S LEXNAM=$$GET1^DIQ(200,(LEXNUM_","),.01) Q:'$L(LEXNAM)  S LEXKEY=$E(LEXCOM,1,13) S:$L(LEXKEY)'>11 LEXKEY=LEXKEY_$J(" ",12-$L(LEXKEY))
 S LEXNOW=$$DT^XLFDT,LEXFUT=$$FMADD^XLFDT(LEXNOW,60),LEXID=LEXRTN_" "_LEXNUM_" "_LEXKEY S ^XTMP(LEXID,0)=LEXFUT_"^"_LEXNOW_"^"_LEXCOM,^XTMP(LEXID,LEXTAG)=LEXVAL
 Q
RET(X) ;   Retrieve Defaults
 N LEXRTN,LEXTAG,LEXNUM,LEXCOM,LEXNAM,LEXID,LEXKEY S LEXRTN=$P($T(+1)," ",1) Q:'$L(LEXRTN) ""  S LEXTAG=$G(X) Q:'$L(LEXTAG) ""
 S LEXCOM=$E($$TM($TR($P($T(@LEXTAG+0)," ",2,4000),";"," ")),1,13) Q:'$L(LEXCOM) ""  S LEXNUM=+($G(DUZ)) Q:+LEXNUM'>0 ""
 S LEXNAM=$$GET1^DIQ(200,(LEXNUM_","),.01) Q:'$L(LEXNAM) "" S LEXKEY=$E(LEXCOM,1,13) S:$L(LEXKEY)'>11 LEXKEY=LEXKEY_$J(" ",12-$L(LEXKEY))
 S LEXID=LEXRTN_" "_LEXNUM_" "_LEXKEY S X=$G(^XTMP(LEXID,LEXTAG))
 Q X
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
ENV(X) ;   Environment
 D HOME^%ZIS S U="^",DT=$$DT^XLFDT,DTIME=300 K POP
 N LEXNM S LEXNM=$$GET1^DIQ(200,(+($G(DUZ))_","),.01)
 I '$L(LEXNM) W !!,?5,"Invalid/Missing DUZ" Q 0
 S:$G(DUZ(0))'["@" DUZ(0)=$G(DUZ(0))_"@"
 Q 1
