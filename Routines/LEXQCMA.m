LEXQCMA ;ISL/KER - Query - CPT Modifiers - Ask ;10/30/2008
 ;;2.0;LEXICON UTILITY;**62**;Sep 23, 1996;Build 16
 ;               
 ; Global Variables
 ;    ^DIC(81.3           ICR   4492
 ;               
 ; External References
 ;    ^DIC                ICR  10006
 ;    ^DIR                ICR  10026
 ;    $$MOD^ICPTMOD       ICR   1996
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;    LEXCDT              Code Set Date
 ;    LEXEXIT             Exit Flag
 ;    LEXMOD              CPT Modifier IEN^Text
 ;               
 Q
MOD(X) ; CPT Modifier Code
 Q:+($G(LEXEXIT))>0 "^^"  N DIC,DTOUT,DUOUT,LEXMD,LEXSO,LEXDTXT,LEXVTXT,LEXVDT,Y,ICPTVDT S:$G(LEXCDT)?7N ICPTVDT=$G(LEXCDT)
 S DIC(0)="AEQMZ",DIC="^DIC(81.3,",DIC("A")=" Select a CPT Modifier code:  ",DIC("S")="I +($$OK^LEXQCMA(+($G(Y))))>0" W !
 D ^DIC  S:$G(X)["^^"!($D(DTOUT)) LEXEXIT=1 Q:$G(X)["^^"!(+($G(LEXEXIT))>0) "^^"
 Q:$G(X)="^" "^"  Q:$G(X)["^^" "^^"  Q:$D(DTOUT)!($D(DUOUT)) "^"  S LEXSO=$P($G(Y),"^",2) S X="" I +Y>0,$L(LEXSO) D
 . S LEXVDT=$G(LEXCDT) S:LEXVDT'?7N LEXVDT=$$DT^XLFDT S X=Y,LEXDTXT=$P($G(Y(0)),"^",2),LEXMD=$$MOD^ICPTMOD(+Y,"I",LEXVDT)
 . S:$L($G(LEXDTXT)) LEXDTXT=LEXDTXT_" (Text not Versioned)" S LEXVTXT=$P(LEXMD,"^",3) S:'$L(LEXVTXT) LEXVTXT=LEXDTXT
 . S X=+Y_"^"_LEXSO S:$L(LEXVTXT) X=X_"^"_LEXVTXT
 S X=$$UP^XLFSTR(X) Q:'$L(X) "^"
 Q X
OK(X) ;   Screen for Modifier Lookup
 N LEXE,LEXH,LEXI,LEXIEN,LEXLA,LEXLAI,LEXLE,LEXLI,LEXM,LEXR,LEXS,LEXX S LEXIEN=+($G(X)),LEXM=$P($G(^DIC(81.3,+LEXIEN,0)),"^",1) Q:'$L(LEXM) 0
 N LEXX,LEXI K LEXX S LEXI=0  F  S LEXI=$O(^DIC(81.3,"B",LEXM,LEXI)) Q:+LEXI'>0  D
 . Q:$P($G(^DIC(81.3,+LEXI,0)),"^",4)="V"  N LEXR,LEXH,LEXE,LEXS S LEXR=$S($O(^DIC(81.3,+LEXI,10,0))>0:1,1:0)
 . S:'$D(LEXX(+LEXI)) LEXX(0)=+($G(LEXX(0)))+1 S LEXX(+LEXI)=LEXM_"^"_LEXR
 . M LEXX(LEXI,60)=^DIC(81.3,+LEXI,60) K LEXX(LEXI,60,"B") S LEXH=0 F  S LEXH=$O(LEXX(LEXI,60,LEXH)) Q:+LEXH'>0  D
 . . N LEXE,LEXS S LEXE=$G(LEXX(LEXI,60,LEXH,0)),LEXS=$P(LEXE,"^",2),LEXE=$P(LEXE,"^",1) Q:'$L(LEXS)  Q:'$L(LEXE)
 . . S:+LEXS>0 LEXX("A",LEXE,LEXI)=LEXI,LEXX("S",LEXI,1)="" S:+LEXS'>0 LEXX("I",LEXE,LEXI)=LEXI,LEXX("S",LEXI,0)=""
 S LEXE=0 F  S LEXE=$O(LEXX("S",LEXE)) Q:+LEXE'>0  S:$D(LEXX("S",LEXE,1))&('$D(LEXX("S",LEXE,0))) LEXX("SA",LEXE)=""
 Q:+($G(LEXX(0)))'>1&($D(LEXX(+LEXIEN))) 1  Q:$L($O(LEXX("SA",0)))&($O(LEXX("SA",0))=$O(LEXX("SA"," "),-1))&($D(LEXX("SA",+LEXIEN))) 1
 Q:$L($O(LEXX("SA",0)))&($O(LEXX("SA",0))=$O(LEXX("SA"," "),-1))&('$D(LEXX("SA",+LEXIEN))) 0  S LEXLA=$O(LEXX("A"," "),-1)
 S LEXLAI=$O(LEXX("A",+LEXLA," "),-1),LEXLI=$O(LEXX("I"," "),-1),LEXLE="" S:LEXLA>0&(LEXLA=LEXLI) LEXLE=$O(LEXX("A",LEXLA," "),-1)
 S:LEXLI>0&(LEXLA<LEXLI) LEXLE=$O(LEXX("I",LEXLI," "),-1) S:LEXLA>0&(LEXLA>LEXLI) LEXLE=$O(LEXX("A",LEXLA," "),-1)
 Q:+LEXLE'=+LEXIEN 0
 Q 1
 ;               
INC(X) ; Include CPT Modifier Ranges
 Q:+($G(LEXEXIT))>0 "^^"  N DIR,DIRUT,DIROUT,DTOUT,DUOUT,Y,DIRB S DIRB=$$RET^LEXQD("LEXQCMA","INC",+($G(DUZ)),"Include Modifier Ranges") S:'$L(DIRB) DIRB="Yes"
 S DIR(0)="YAO",DIR("A")=" Include Modifier CPT Code Ranges?  (Y/N)  " S:"^YES^NO^Yes^No^"[("^"_DIRB_"^") DIR("B")=DIRB
 S DIR("PRE")="S:X[""?"" X=""??""" S (DIR("?"),DIR("??"))="^D INCH^LEXQCMA"
 W ! D ^DIR S:X["^^"!($D(DIROUT)) LEXEXIT=1 Q:X["^^"!(+($G(LEXEXIT))>0) "^^"  Q:$D(DIRUT)!($D(DIROUT))!($D(DTOUT))!($D(DUOUT)) "^" S DIRB=$S(Y=1:"Yes",Y=0:"No",X["^":"",1:"")
 D:$L(DIRB) SAV^LEXQD("LEXQCMA","INC",+($G(DUZ)),"Include Modifier Ranges",$G(DIRB)) S X=+Y
 Q X
INCH ;   Include CPT Modifier Ranges Help
 I $L($P($G(LEXMOD),"^",2)),$L($G(LEXCDT)) D  Q
 . W !,?5,"Answer 'Yes' to include the CPT Code Ranges for for CPT"
 . W !,?5,"Modifier code ",$P($G(LEXMOD),"^",2),".  Answer 'No' to exlcude CPT Code Ranges"
 . W !,?5,"from the display."
 W !,?5,"Answer 'Yes' to include the CPT Code Ranges for the CPT"
 W !,?5,"Modifier.  Answer 'No' to exclude CPT Code Ranges from the"
 W !,?5,"display."
 Q
 ;               
INCI(X) ; Include Inactive CPT Modifier Ranges
 Q:+($G(LEXEXIT))>0 "^^"  N DIR,DIRUT,DIROUT,DTOUT,DUOUT,Y,DIRB S DIRB=$$RET^LEXQD("LEXQCMA","INCI",+($G(DUZ)),"Include Inactive Modifier Ranges") S:'$L(DIRB) DIRB="Yes"
 S DIR(0)="YAO",DIR("A")=" Include 'Inactive' Modifier CPT Code Ranges?  (Y/N)  " S:"^YES^NO^Yes^No^"[("^"_DIRB_"^") DIR("B")=DIRB
 S DIR("B")="No" S DIR("PRE")="S:X[""?"" X=""??""" S (DIR("?"),DIR("??"))="^D INCIH^LEXQCMA"
 W ! D ^DIR S:X["^^" LEXEXIT=1!($D(DTOUT)) Q:X["^^"!(+($G(LEXEXIT))>0) "^^"  Q:$D(DIRUT)!($D(DIROUT))!($D(DTOUT))!($D(DUOUT)) "^" S DIRB=$S(Y=1:"Yes",Y=0:"No",X["^":"",1:"")
 D:$L(DIRB) SAV^LEXQD("LEXQCMA","INCI",+($G(DUZ)),"Include Inactive Modifier Ranges",$G(DIRB)) S X=+Y
 Q X
INCIH ;   Include Inactive CPT Modifier Ranges Help
 I $L($P($G(LEXMOD),"^",2)),$G(LEXCDT)?7N D  Q
 . W !,?5,"Answer 'Yes' to include both Active and Inactive CPT Code"
 . W !,?5,"Ranges for the CPT Modifier ",$P($G(LEXMOD),"^",2),".  Answer 'No' to include"
 . W !,?5,"only the Active CPT Code Ranges that were active for the "
 . W !,?5,"CPT Modifier ",$P($G(LEXMOD),"^",2)," on ",$$SD($G(LEXCDT)),"."
 W !,?5,"Answer 'Yes' to include both Active and Inactive CPT Code "
 W !,?5,"Ranges for the selected CPT Modifier.  Answer 'No' to "
 W !,?5,"include only the Active CPT Code Ranges for the selected"
 W !,?5,"CPT Modifier."
 Q
 ;               
INCF(X) ; Include Future CPT Modifier Ranges
 Q:+($G(LEXEXIT))>0 "^^"  N DIR,DIRUT,DIROUT,DTOUT,DUOUT,Y,DIRB S DIRB=$$RET^LEXQD("LEXQCMA","INCF",+($G(DUZ)),"Include Future Modifier Ranges") S:'$L(DIRB) DIRB="Yes"
 S DIR(0)="YAO",DIR("A")=" Include 'Future Active' Modifier CPT Code Ranges?  (Y/N)  " S:"^YES^NO^Yes^No^"[("^"_DIRB_"^") DIR("B")=DIRB
 S DIR("B")="No" S DIR("PRE")="S:X[""?"" X=""??""" S (DIR("?"),DIR("??"))="^D INCFH^LEXQCMA"
 W ! D ^DIR S:X["^^"!($D(DTOUT)) LEXEXIT=1 Q:X["^^"!(+($G(LEXEXIT))>0) "^^"  Q:$D(DIRUT)!($D(DIROUT))!($D(DTOUT))!($D(DUOUT)) "^" S DIRB=$S(Y=1:"Yes",Y=0:"No",X["^":"",1:"")
 D:$L(DIRB) SAV^LEXQD("LEXQCMA","INCF",+($G(DUZ)),"Include Future Modifier Ranges",$G(DIRB)) S X=+Y
 Q X
INCFH ;   Include Future CPT Modifier Ranges Help
 I $G(LEXCDT)?7N D  Q
 . W !,?5,"Answer 'Yes' to include CPT Code Ranges that become Active"
 . W !,?5,"on or after ",$$SD($G(LEXCDT)),".  Answer 'No' to exclude CPT Code"
 . W !,?5,"Ranges activated in the future."
 W !,?5,"Answer 'Yes' to include CPT Code Ranges that become Active"
 W !,?5,"in the future.  Answer 'No' to to exclude CPT Code Ranges"
 W !,?5,"activated in the future."
 Q
 ;               
SD(X) ; Short Date
 Q $TR($$FMTE^XLFDT(+($G(X)),"5DZ"),"@"," ")
CLR ; Clear
 N LEXCDT,LEXEXIT,LEXMOD
 Q
