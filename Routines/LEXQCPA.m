LEXQCPA ;ISL/KER - Query - CPT Procedures - Ask ;10/30/2008
 ;;2.0;LEXICON UTILITY;**62**;Sep 23, 1996;Build 16
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    ^DIC                ICR  10006
 ;    ^DIR                ICR  10026
 ;    $$CPT^ICPTCOD       ICR   1995
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;    LEXCDT              Code Set Date
 ;    LEXEXIT             Exit Flag
 ;    LEXCPT              CPT Code IEN^Text
 ;           
 Q
CPT(X) ; CPT Code
 Q:+($G(LEXEXIT))>0 "^^"  N DIC,DTOUT,DUOUT,LEXCP,LEXSO,LEXDTXT,LEXVTXT,LEXVDT,Y,ICPTVDT S:$G(LEXCDT)?7N ICPTVDT=$G(LEXCDT)
 S DIC(0)="AEQMZ",DIC="^ICPT(",DIC("A")=" Select a CPT/HCPCS Procedure code:  " W !
 D ^DIC  S:$G(X)["^^"!($D(DTOUT)) LEXEXIT=1 Q:$G(X)["^^"!(+($G(LEXEXIT))>0) "^^"
 Q:$G(X)="^" "^"  Q:$G(X)["^^" "^^"  Q:$D(DTOUT)!($D(DUOUT)) "^"  S LEXSO=$P($G(Y),"^",2) S X="" I +Y>0,$L(LEXSO) D
 . S LEXVDT=$G(LEXCDT) S:LEXVDT'?7N LEXVDT=$$DT^XLFDT S X=Y,LEXDTXT=$P($G(Y(0)),"^",2),LEXCP=$$CPT^ICPTCOD(LEXSO,LEXVDT)
 . S:$L($G(LEXDTXT)) LEXDTXT=LEXDTXT_" (Text not Versioned)" S LEXVTXT=$P(LEXCP,"^",3) S:'$L(LEXVTXT) LEXVTXT=LEXDTXT
 . S X=+Y_"^"_LEXSO S:$L(LEXVTXT) X=X_"^"_LEXVTXT
 S X=$$UP^XLFSTR(X) Q:'$L(X) "^"
 Q X
INC(X) ; Include CPT Modifiers
 Q:+($G(LEXEXIT))>0 "^^"  N DIR,DIRUT,DIROUT,DTOUT,DUOUT,Y,DIRB S DIRB=$$RET^LEXQD("LEXQCPA","INC",+($G(DUZ)),"Include Modifiers") S:'$L(DIRB) DIRB="Yes"
 S DIR(0)="YAO",DIR("A")=" Include CPT Modifiers?  (Y/N)  " S:"^YES^NO^Yes^No^"[("^"_DIRB_"^") DIR("B")=DIRB
 S DIR("PRE")="S:X[""?"" X=""??""" S (DIR("?"),DIR("??"))="^D INCH^LEXQCPA"
 W ! D ^DIR S:X["^^"!($D(DTOUT)) LEXEXIT=1 Q:X["^^"!(+($G(LEXEXIT))>0) "^^"  Q:$D(DIRUT)!($D(DIROUT))!($D(DTOUT))!($D(DUOUT)) "^" S DIRB=$S(Y=1:"Yes",Y=0:"No",X["^":"",1:"")
 D:$L(DIRB) SAV^LEXQD("LEXQCPA","INC",+($G(DUZ)),"Include Modifiers",$G(DIRB)) S X=+Y
 Q X
INCH ;   Include Help
 I $L($P($G(LEXCPT),"^",2)),$G(LEXCDT)?7N D  Q
 . W !,?5,"Answer 'Yes' to include active CPT Modifiers that are appropriate for"
 . W !,?5,"CPT code ",$P($G(LEXCPT),"^",2)," on ",$$SD($G(LEXCDT))
 W !,?5,"Answer 'Yes' to include active CPT Modifiers that are appropriate"
 W !,?5,"for the CPT code, 'No' to exclude CPT Modifiers from the display"
 Q
SD(X) ; Short Date
 Q $TR($$FMTE^XLFDT(+($G(X)),"5DZ"),"@"," ")
CLR ; Clear
 N LEXCDT,LEXCPT,LEXEXIT
 Q
