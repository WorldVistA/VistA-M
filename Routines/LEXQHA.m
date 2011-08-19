LEXQHA ;ISL/KER - Query History - Ask ;10/30/2008
 ;;2.0;LEXICON UTILITY;**62**;Sep 23, 1996;Build 16
 ;               
 ; Global Variables
 ;    ^DIC(81.3,          ICR   4492
 ;               
 ; External References
 ;    ^DIR                ICR  10026
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     LEXEXIT            Exit Flag
 ;     LEXIEN             IEN for file 81.3
 ;     LEXMOD             CPT Modifier
 ;     LEXSO              Source
 ;               
 Q
RAN(X) ; Include CPT Modifier Ranges
 Q:+($G(LEXEXIT))>0 "^^"  N DIR,DIRUT,DIROUT,DTOUT,DUOUT,Y,DIRB S DIRB=$$RET^LEXQD("LEXQHA","RAN",+($G(DUZ)),"Modifier Ranges")
 S:'$L(DIRB) DIRB="Yes"
 S DIR(0)="YAO",DIR("A")=" Include Modifier CPT Code Ranges?  (Y/N)  " S:"^YES^NO^Yes^No^"[("^"_DIRB_"^") DIR("B")=DIRB
 S DIR("PRE")="S:X[""?"" X=""??""" S (DIR("?"),DIR("??"))="^D RANH^LEXQHA"
 W ! D ^DIR S:X["^^"!($D(DTOUT)) LEXEXIT=1 Q:X["^^"!(+($G(LEXEXIT))>0) "^^"  Q:$D(DIRUT)!($D(DIROUT))!($D(DTOUT))!($D(DUOUT)) "^" S DIRB=$S(Y=1:"Yes",Y=0:"No",X["^":"",1:"")
 D:$L(DIRB) SAV^LEXQD("LEXQHA","RAN",+($G(DUZ)),"Modifier Ranges",$G(DIRB)) S X=+Y
 Q X
RANH ;   Include CPT Modifier Ranges Help
 N LEXM S LEXM=$P($G(LEXMOD),U,2) S:'$L(LEXM)&($L($G(LEXSO))) LEXM=$P($G(LEXSO),U,4) S:'$L(LEXM)&($L($G(LEXSO))) LEXM=$G(LEXSO)
 S:'$L(LEXM)&(+($G(LEXIEN))>0)&($D(^DIC(81.3,+($G(LEXIEN)),0))) LEXM=$P($G(^DIC(81.3,+($G(LEXIEN)),0)),U,1)
 I $L($G(LEXM)) D  Q
 . W !,?5,"Answer 'Yes' to include the CPT Code Ranges for for CPT"
 . W !,?5,"Modifier code ",$G(LEXM),".  Answer 'No' to exlcude CPT Code Ranges"
 . W !,?5,"from the display."
 W !,?5,"Answer 'Yes' to include the CPT Code Ranges for the CPT"
 W !,?5,"Modifier.  Answer 'No' to exclude CPT Code Ranges from the"
 W !,?5,"display."
 Q
 ;     
DIS(X) ; Display
 Q:+($G(LEXEXIT))>0 "^^"  N DIR,DIRUT,DIROUT,DTOUT,DUOUT,Y,DIRB S DIRB=$$RET^LEXQD("LEXQHA","DIS",+($G(DUZ)),"Display")
 S:'$L(DIRB) DIRB="Yes"
 S DIR(0)="SAO^C:Chronological History;S:Subjective History",DIR("A")=" Display Chronological or Subjective History?  (C/S)  "
 S:"^CHRONOLOGICAL^SUBJECTIVE^Chronological^Subjective^"[("^"_DIRB_"^") DIR("B")=DIRB
 S DIR("PRE")="S:X[""?"" X=""??""" S (DIR("?"),DIR("??"))="^D DISH^LEXQHA"
 W ! D ^DIR S:X["^^"!($D(DTOUT)) LEXEXIT=1 Q:X["^^"!(+($G(LEXEXIT))>0) "^^"  Q:$D(DIRUT)!($D(DIROUT))!($D(DTOUT))!($D(DUOUT)) "^"
 S DIRB=$S(Y="C":"Chronological",Y="S":"Subjective",X["^":"",1:"")
 D:$L(DIRB) SAV^LEXQD("LEXQHA","DIS",+($G(DUZ)),"Display",$G(DIRB))
 S X=$S(Y="C":"CH",Y="S":"SB",X["^":"",1:"")
 Q X
DISH ;   Display Help
 W !,?5,"C = Chronological"
 W ?25,"MM/DD/YYYY     Event",!
 W ?25,"               Data",!
 W ?25,"MM/DD/YYYY     Event",!
 W ?25,"               Data",!
 W !,?5,"S = Subjective"
 W ?25,"Event",!
 W ?25,"  MM/DD/YYYY   Data",!
 W ?25,"  MM/DD/YYYY   Data"
 Q
 ;
 ; Miscellaneous
CL ;   Clear
 K LEXEXIT,LEXIEN,LEXMOD,LEXSO
 Q
