LEXQIDA ;ISL/KER - Query - ICD Diagnosis - Ask ;10/30/2008
 ;;2.0;LEXICON UTILITY;**62**;Sep 23, 1996;Build 16
 ;               
 ; Global Variables
 ;    ^ICD9(              ICR   4485
 ;    ^TMP("LEXQIDA")     SACC 2.3.2.5.1
 ;               
 ; External References
 ;    ^DIC                ICR  10006
 ;    ^DIR                ICR  10026
 ;    $$ICDDX^ICDCODE     ICR   3990
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;    LEXCDT              Code Set Date
 ;    LEXEXIT             Exit Flag
 ;               
 Q
ICD(X) ; ICD DX Code
 Q:+($G(LEXEXIT))>0 "^^"  N DIC,DTOUT,DUOUT,LEXDX,LEXSO,LEXDTXT,LEXVTXT,LEXVDT,Y,ICDVDT S:$G(LEXCDT)?7N ICDVDT=$G(LEXCDT)
 S DIC(0)="AEQMZ",DIC="^ICD9(",DIC("A")=" Select an ICD Diagnosis code:  " W !
 D ^DIC S:$G(X)["^^"!($D(DTOUT)) LEXEXIT=1 Q:$G(X)["^^"!(+($G(LEXEXIT))>0) "^^"
 Q:$G(X)="^" "^"  Q:$G(X)["^^" "^^"  Q:$D(DTOUT)!($D(DUOUT)) "^"  S LEXSO=$P($G(Y),"^",2) S X="" I +Y>0,$L(LEXSO) D
 . S LEXVDT=$G(LEXCDT) S:LEXVDT'?7N LEXVDT=$$DT^XLFDT S X=Y,LEXDTXT=$P($G(Y(0)),"^",2),LEXDX=$$ICDDX^ICDCODE(LEXSO,LEXVDT)
 . S:$L($G(LEXDTXT)) LEXDTXT=LEXDTXT_" (Text not Versioned)" S LEXVTXT=$P(LEXDX,"^",4) S:'$L(LEXVTXT) LEXVTXT=LEXDTXT
 . S X=+Y_"^"_LEXSO S:$L(LEXVTXT) X=X_"^"_LEXVTXT
 S X=$$UP^XLFSTR(X) Q:'$L(X) "^"
 Q X
 ;          
NOT(X) ; Include ICD Codes not to use with ***.**
 Q:+($G(LEXEXIT))>0 "^^"  N DIR,DIRUT,DIROUT,DTOUT,DUOUT,Y,DIRB,LEXIEN,LEXLSO,LEXCT,LEXCTE,LEXI S LEXIEN=+($G(X)) Q:'$D(^ICD9(+LEXIEN,0)) 0  Q:+($O(^ICD9(+LEXIEN,"N",0)))'>0 0
 S LEXLSO=$P($G(^ICD9(+LEXIEN,0)),"^",1) Q:'$L(LEXLSO) 0  S LEXI="",LEXCT=0 F  S LEXI=$O(^ICD9(+LEXIEN,"N","B",LEXI)) Q:'$L(LEXI)  S LEXCT=LEXCT+1
 Q:+($G(LEXCT))'>0 0  S LEXCTE=$S(LEXCT=1:"one",LEXCT=2:"two",LEXCT=3:"three",LEXCT=4:"four",LEXCT=5:"five",LEXCT=6:"six",LEXCT=7:"seven",LEXCT=8:"eight",LEXCT=9:"nine",1:LEXCT)
 S DIRB=$$RET^LEXQD("LEXQIDA","NOT",+($G(DUZ)),"Include ICD Codes not to use with") S:'$L(DIRB) DIRB="No"
 S DIR(0)="YAO" S:LEXCT=1 DIR("A")=" Include the single ICD Code that can not be used with "_LEXLSO_"?  (Y/N)  "
 S:LEXCT>1 DIR("A")=" Include the "_LEXCTE_" ICD Codes that can not be used with "_LEXLSO_"?  (Y/N)  "
 S:"^YES^NO^Yes^No^"[("^"_DIRB_"^") DIR("B")=DIRB
 S DIR("PRE")="S:X[""?"" X=""??""" S (DIR("?"),DIR("??"))="^D NOTH^LEXQIDA"
 W ! D ^DIR S:X["^^"!($D(DTOUT)) LEXEXIT=1 Q:X["^^"!(+($G(LEXEXIT))>0) "^^"  Q:$D(DIRUT)!($D(DIROUT))!($D(DTOUT))!($D(DUOUT)) "^" S DIRB=$S(Y=1:"Yes",Y=0:"No",X["^":"",1:"")
 D:$L(DIRB) SAV^LEXQD("LEXQIDA","NOT",+($G(DUZ)),"Include ICD Codes not to use with",$G(DIRB)) S X=+Y
 Q X
NOTH ;   Include NOT Help
 W:'$L($G(LEXLSO)) !,?5,"Answer 'Yes' to include in the display all ICD Code(s) that can",!,?5,"not be used with the selected ICD code.  Answer 'No' to exclude",!,?5,"codes that can not not be used with the selected ICD code."
 W:$L($G(LEXLSO)) !,?5,"Answer 'Yes' to include all ICD Code(s) that can not be used with",!,?5,"ICD Code "_$G(LEXLSO)_".  Answer 'No' to exclude codes that can not be",!,?5,"used with ICD code "_$G(LEXLSO)_"."
 Q
 ;          
REQ(X) ; Include ICD Codes required with ***.**
 Q:+($G(LEXEXIT))>0 "^^"  N DIR,DIRUT,DIROUT,DTOUT,DUOUT,Y,DIRB,LEXIEN,LEXLSO,LEXCT,LEXCTE,LEXI S LEXIEN=+($G(X)) Q:'$D(^ICD9(+LEXIEN,0)) 0  Q:+($O(^ICD9(+LEXIEN,"R",0)))'>0 0
 S LEXLSO=$P($G(^ICD9(+LEXIEN,0)),"^",1) Q:'$L(LEXLSO) 0  S LEXI="",LEXCT=0 F  S LEXI=$O(^ICD9(+LEXIEN,"R","B",LEXI)) Q:'$L(LEXI)  S LEXCT=LEXCT+1
 Q:+($G(LEXCT))'>0 0  S LEXCTE=$S(LEXCT=1:"one",LEXCT=2:"two",LEXCT=3:"three",LEXCT=4:"four",LEXCT=5:"five",LEXCT=6:"six",LEXCT=7:"seven",LEXCT=8:"eight",LEXCT=9:"nine",1:LEXCT)
 S DIRB=$$RET^LEXQD("LEXQIDA","REQ",+($G(DUZ)),"Include ICD Required with") S:'$L(DIRB) DIRB="No"
 S DIR(0)="YAO" S:LEXCT=1 DIR("A")=" Include the one ICD Code that is required with "_LEXLSO_"?  (Y/N)  "
 S:LEXCT>1 DIR("A")=" Include the "_LEXCTE_" ICD Codes that are required with "_LEXLSO_"?  (Y/N)  "
 S:"^YES^NO^Yes^No^"[("^"_DIRB_"^") DIR("B")=DIRB
 S DIR("PRE")="S:X[""?"" X=""??""" S (DIR("?"),DIR("??"))="^D REQH^LEXQIDA"
 W ! D ^DIR S:X["^^"!($D(DTOUT)) LEXEXIT=1 Q:X["^^"!(+($G(LEXEXIT))>0) "^^"  Q:$D(DIRUT)!($D(DIROUT))!($D(DTOUT))!($D(DUOUT)) "^" S DIRB=$S(Y=1:"Yes",Y=0:"No",X["^":"",1:"")
 D:$L(DIRB) SAV^LEXQD("LEXQIDA","REQ",+($G(DUZ)),"Include ICD Required with",$G(DIRB)) S X=+Y
 Q X
REQH ;   Include REQ Help
 W:'$L($G(LEXLSO)) !,?5,"Answer 'Yes' to include in the display all ICD Code(s) that are",!,?5,"required with the selected ICD code.  Answer 'No' to exclude",!,?5,"codes that are required with the selected ICD code."
 W:$L($G(LEXLSO)) !,?5,"Answer 'Yes' to include all ICD Code(s) that are required with",!,?5,"ICD Code "_$G(LEXLSO)_".  Answer 'No' to exclude codes that are requried",!,?5,"with ICD code "_$G(LEXLSO)_"."
 Q
 Q
 ;          
NCC(X) ; Include the codes that ***.** is not CC with
 Q:+($G(LEXEXIT))>0 "^^"  N DIR,DIRUT,DIROUT,DTOUT,DUOUT,Y,DIRB,LEXIEN,LEXLSO,LEXCT,LEXCTE,LEXI,LEXNCC S LEXIEN=+($G(X)) Q:'$D(^ICD9(+LEXIEN,0)) 0  Q:+($O(^ICD9(+LEXIEN,"2",0)))'>0 0
 S LEXLSO=$P($G(^ICD9(+LEXIEN,0)),"^",1) Q:'$L(LEXLSO) 0  K ^TMP("LEXQIDA",$J,"NCC") S (LEXI,LEXCT)=0 F  S LEXI=$O(^ICD9(+LEXIEN,"2",LEXI)) Q:+LEXI'>0  D
 . S LEXNCC=$G(^ICD9(+LEXIEN,"2",LEXI,0)) Q:'$L(LEXNCC)  S:'$D(^TMP("LEXQIDA",$J,"NCC",LEXNCC)) LEXCT=LEXCT+1 S ^TMP("LEXQIDA",$J,"NCC",LEXNCC)=""
 K ^TMP("LEXQIDA",$J,"NCC") Q:+($G(LEXCT))'>0 0
 S LEXCTE=$S(LEXCT=1:"one",LEXCT=2:"two",LEXCT=3:"three",LEXCT=4:"four",LEXCT=5:"five",LEXCT=6:"six",LEXCT=7:"seven",LEXCT=8:"eight",LEXCT=9:"nine",1:LEXCT)
 S DIRB=$$RET^LEXQD("LEXQIDA","NCC",+($G(DUZ)),"Include Codes not CC with") S:'$L(DIRB) DIRB="No"
 S DIR(0)="YAO" S:LEXCT=1 DIR("A")=" Include the one ICD Code that "_LEXLSO_" is not CC with?  (Y/N)  "
 S:LEXCT>1 DIR("A")=" Include the "_LEXCTE_" ICD Codes that "_LEXLSO_" are not CC with?  (Y/N)  "
 S:"^YES^NO^Yes^No^"[("^"_DIRB_"^") DIR("B")=DIRB
 S DIR("PRE")="S:X[""?"" X=""??""" S (DIR("?"),DIR("??"))="^D NCCH^LEXQIDA"
 W ! D ^DIR S:X["^^"!($D(DTOUT)) LEXEXIT=1 Q:X["^^"!(+($G(LEXEXIT))>0) "^^"  Q:$D(DIRUT)!($D(DIROUT))!($D(DTOUT))!($D(DUOUT)) "^" S DIRB=$S(Y=1:"Yes",Y=0:"No",X["^":"",1:"")
 D:$L(DIRB) SAV^LEXQD("LEXQIDA","NCC",+($G(DUZ)),"Include Codes not CC with",$G(DIRB)) S X=+Y
 Q X
NCCH ;   Include NCC Help
 I $L($G(LEXLSO)),$L($G(LEXCT)) D
 . W !,?5,"Code ",LEXLSO," is not considered as Complication/Comorbidity (CC)"
 . W !,?5,"with ",$S(+($G(LEXCT))>1:"some codes.",1:"one code."),"  Answer 'Yes' to include "
 . I +($G(LEXCT))>1 W "these codes.  Answer",!,?5,"'No' to exclude these codes."
 . I +($G(LEXCT))'>1 W "this code.  Answer 'No'",!,?5,"to exclude this code."
 . Q
 . W $S(+($G(LEXCT))>1:"these codes.  Answer 'No'",1:"this code.  Answer 'No'")
 . W $S(+($G(LEXCT))>1:"these codes.  Answer 'No'",1:"this code.  Answer 'No'")
 I $L($G(LEXLSO)),'$L($G(LEXCT)) D
 . W !,?5,"Code "_LEXLSO_" is not considered as Complication/Comorbidity (CC)"
 . W !,?5,"with some codes.  Answer 'Yes' to include these codes.  Answer",!,?5,"'No' to exclude these codes."
 I '$L($G(LEXLSO)),'$L($G(LEXCT)) D
 . W !,?5,"This code is not considered as Complication/Comorbidity (CC)"
 . W !,?5,"with some codes.  Answer 'Yes' to include these codes.  Answer ",!,?5,"'No' to exclude these codes."
 Q
 ;          
SD(X) ; Short Date
 Q $TR($$FMTE^XLFDT(+($G(X)),"5DZ"),"@"," ")
CLR ; Clear
 N LEXCDT,LEXEXIT
 Q
