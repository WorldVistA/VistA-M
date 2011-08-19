LEXQM ;ISL/KER - Query - Miscellaneous ;10/30/2008
 ;;2.0;LEXICON UTILITY;**62**;Sep 23, 1996;Build 16
 ;               
 ; Global Variables
 ;    ^UTILITY(           ICR  10011
 ;               
 ; External References
 ;    HOME^%ZIS           ICR  10086
 ;    $$GET1^DIQ          ICR   2056
 ;    ^DIR                ICR  10026
 ;    ^DIWP               ICR  10011
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMADD^XLFDT       ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;    LEXEXIT             Exit Flag
 ;               
AD(X) ; Assumed Date
 Q:+($G(LEXEXIT))>0 "^^"  N DIR,DIRUT,DIROUT,DTOUT,DUOUT,DIRB,LEXPAS,LEXNOW,LEXFUT,Y
 S LEXNOW=$$UP^XLFSTR($$FMTE^XLFDT($$DT^XLFDT)),LEXPAS=2760101,LEXFUT=$$FMADD^XLFDT($$DT^XLFDT,(365*2))
 S DIRB=$$RET^LEXQD("LEXQM","AD",+($G(DUZ)),"Assumed Date") S:'$L(DIRB) DIRB=LEXNOW S:$L($G(LEXAD)) DIRB=""
 S:$L(DIRB) DIR("B")=DIRB S DIR("A")=" Assumed Date of Service:  "
 S DIR(0)="DAO^"_LEXPAS_":"_LEXFUT_":EX",(DIR("?"),DIR("??"))="^D ADH^LEXQM"
 S DIR("PRE")="S:X[""?"" X=""??"""
 W ! D ^DIR S:X["^^"!($D(DTOUT)) X="^^",LEXEXIT=1 Q:X["^^"!(+($G(LEXEXIT))>0) "^^"  Q:X["^" "^"
 S X="" S:$E(Y,1,7)?7N X=$$UP^XLFSTR($$FMTE^XLFDT($E(Y,1,7)))_"^"_$E(Y,1,7)
 D:$L($P(X,"^",1)) SAV^LEXQD("LEXQM","AD",+($G(DUZ)),"Assumed Date",$P(X,"^",1))
 Q X
ADH ;   Assumed Date Help
 W !,?5,"This is the date of a fictitious healthcare transaction.  It is the"
 W !,?5,"date that service was provided to a patient and the date that will  "
 W !,?5,"be used during the lookup of a code (ICD/CPT/CPT Modifier)."
 I $L($G(LEXFUT)),$G(LEXFUT)?7N D
 . W !!,?5,"Enter a date from  ",$$UP^XLFSTR($$FMTE^XLFDT(LEXPAS)),"  to  ",$$UP^XLFSTR($$FMTE^XLFDT(LEXFUT))," or"
 . W !,?5,"T   (for TODAY),  T+1 (for TOMORROW),  T+2,  T+7, etc.",!,?5,"T-1 (for YESTERDAY),  T-3W (for 3 WEEKS AGO), etc."
 Q
 ;            
CSD(X) ; Code Set Date
 Q:+($G(LEXEXIT))>0 "^^"  N DIR,DIRUT,DIROUT,DTOUT,DUOUT,DIRB,LEXPAS,LEXNOW,LEXFUT,Y
 S LEXNOW=$$UP^XLFSTR($$FMTE^XLFDT($$DT^XLFDT)),LEXPAS=2760101,LEXFUT=$$FMADD^XLFDT($$DT^XLFDT,(365*2)) S:LEXFUT?7N LEXFUT=$E(LEXFUT,1,3)_"1001"
 S DIRB=$$RET^LEXQD("LEXQM","CSD",+($G(DUZ)),"Code Set Date") S:'$L(DIRB) DIRB=LEXNOW S:$L($G(LEXAD)) DIRB=""
 S:$L(DIRB) DIR("B")=DIRB S DIR("A")=" Enter Code Set Update Date:  "
 S DIR(0)="DAO^"_LEXPAS_":"_LEXFUT_":EX",(DIR("?"),DIR("??"))="^D CSDH^LEXQM",DIR("PRE")="S X=$$CSDX^LEXQM(X)"
 W ! D ^DIR S:X["^^"!($D(DTOUT)) X="^^",LEXEXIT=1 Q:X["^^"!(+($G(LEXEXIT))>0) "^^"  Q:X["^" "^"
 S X="" S:$E(Y,1,7)?7N X=$$UP^XLFSTR($$FMTE^XLFDT($E(Y,1,7)))_"^"_$E(Y,1,7)
 D:$L($P(X,"^",1)) SAV^LEXQD("LEXQM","CSD",+($G(DUZ)),"Code Set Date",$P(X,"^",1))
 Q X
CSDH ;   Code Set Date Help
 W !,?3,"This is a date to used to search for Code Set changes in the ICD and CPT"
 W !,?3,"files.  A future date may be used to search for changes in the Code Sets"
 W !,?3,"with future effective dates.  (HINT:  Most Code Set effective dates are"
 W !,?3,"quarterly, the first of January, April, July or October)"
 I $L($G(LEXFUT)),$G(LEXFUT)?7N D
 . W !!,?5,"Enter a date from  ",$$UP^XLFSTR($$FMTE^XLFDT(LEXPAS)),"  to  ",$$UP^XLFSTR($$FMTE^XLFDT(LEXFUT))," or"
 . W !,?5,"T   (for TODAY),  T+1 (for TOMORROW),  T+2,  T+7, etc."
 . W !,?5,"T-1 (for YESTERDAY),  T-3W (for 3 WEEKS AGO), etc."
 . W !,?5,"Q1 (for first quarter),  Q109 (for first quarter of FY09), etc."
 Q
CSDX(X) ;   Code Set Date Pre-Processing
 Q:$G(X)["?" "??"  N LEXN,LEXY,LEXT,LEXX,LEXQ,LEXF S LEXN=$$DT^XLFDT,LEXY=$E(LEXN,1,3),LEXT=LEXY+1700 S:+($E(LEXN,4,5))>9 LEXY=LEXY+1
 Q:X="Q2" (LEXY_"0101") Q:X="Q3" (LEXY_"0401") Q:X="Q4" (LEXY_"0701") Q:X="Q1" ((LEXY-1)_"1001")
 S LEXX="" I $E(X,1)="Q",$E(X,2,4)?3N D
 . N LEXQ,LEXF S LEXQ=$E(X,2),LEXF=$E(X,3,4) S:LEXF>70 LEXF="19"_LEXF S:LEXF'>70 LEXF="20"_LEXF S:LEXQ=1 LEXF=LEXF-1
 . S LEXQ=$S(+LEXQ=1:"1001",+LEXQ=2:"0101",+LEXQ=3:"0401",+LEXQ=4:"0701",1:"") Q:'$L(LEXQ)
 . S:LEXF?4N&(LEXF>1976)&(LEXF<(+($G(LEXT))+3))&(LEXQ?4N) LEXX=(LEXF-1700)_LEXQ
 S:$L(LEXX) X=LEXX
 Q X
 ;            
PR(LEX,X) ; Parse Array
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,LEXI,LEXLEN,LEXC K ^UTILITY($J,"W") Q:'$D(LEX)
 S LEXLEN=+($G(X)) S:+LEXLEN'>0 LEXLEN=79 S LEXC=+($G(LEX)) S:+($G(LEXC))'>0 LEXC=$O(LEX(" "),-1) Q:+LEXC'>0
 S DIWL=1,DIWF="C"_+LEXLEN S LEXI=0 F  S LEXI=$O(LEX(LEXI)) Q:+LEXI=0  S X=$G(LEX(LEXI)) D ^DIWP
 K LEX S (LEXC,LEXI)=0 F  S LEXI=$O(^UTILITY($J,"W",1,LEXI)) Q:+LEXI=0  D
 . S LEX(LEXI)=$$TM($G(^UTILITY($J,"W",1,LEXI,0))," "),LEXC=LEXC+1
 S:$L(LEXC) LEX=LEXC K ^UTILITY($J,"W")
 Q
 ;            
 ; Miscellaneous
AND(X) ;   Substitute 'and'
 S X=$G(X) Q:$L(X,", ")'>1 X
 S X=$P(X,", ",1,($L(X,", ")-1))_" and "_$P(X,", ",$L(X,", "))
 Q X
CS(X) ;   Trim Comma/Space
 S X=$$TM($G(X),","),X=$$TM($G(X)," "),X=$$TM($G(X),","),X=$$TM($G(X)," ")
 Q X
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" " F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
SD(X) ;   Short Date
 Q $TR($$FMTE^XLFDT(+($G(X)),"5DZ"),"@"," ")
ED(X) ;   External Date
 Q:+($G(X))'>0 "--/--/----"
 Q $TR($$FMTE^XLFDT(+($G(X)),"5DZ"),"@"," ")
ES(X) ;   External Status
 Q $S(+($G(X))="1":"Active",$G(X)="0":"Inactive",1:"")
CLR ;   Clear
 N LEXAD,LEXEXIT
 Q
EV(X) ;   Check environment
 N LEX S DT=$$DT^XLFDT D HOME^%ZIS S U="^" I +($G(DUZ))=0 W !!,?5,"DUZ not defined" Q 0
 S LEX=$$GET1^DIQ(200,(DUZ_","),.01) I '$L(LEX) W !!,?5,"DUZ not valid" Q 0
 Q 1
