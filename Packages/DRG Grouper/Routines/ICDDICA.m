ICDDICA ;SLC/KER - ICD DIC Lookup Prototype ;04/21/2014
 ;;18.0;DRG Grouper;**57**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    ^ICDS(              N/A
 ;    ^XTMP("ICDID")      SACC 2.3.2.5.2
 ;               
 ; External References
 ;    ^%DT                ICR  10003
 ;    ^DIC                ICR  10006
 ;    $$GET1^DIQ          ICR   2056
 ;    ^DIR                ICR  10026
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMADD^XLFDT       ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed in ICDDIC
 ;     ICDCS,ICDDP,ICDFI,ICDFM,ICDOA,ICDVD,ICDVR
 ;               
EN ;
 W:$L($G(IOF)) @IOF
 W ! S ICDDP=$$DP,ICDCS="" Q:ICDDP["^"  Q:$D(DTOUT)!($D(DUOUT))
 S ICDFI=$S(ICDDP="D":"80^ICD DIAGNOSIS",ICDDP="P":"80.1^ICD OPERATION/PROCEDURE",1:"")
 Q:+ICDFI'>0  S ICDOA=$$OA(+ICDFI) Q:ICDOA["^"  Q:$D(DTOUT)!($D(DUOUT))
 S:ICDOA="O" ICDCS=$$CS(+ICDFI)  Q:$D(DTOUT)!($D(DUOUT))
 S ICDVR=$$VR(+ICDFI)  Q:$D(DTOUT)!($D(DUOUT))
 S ICDVD="" S:ICDVR>0 ICDVD=$$VD(+ICDFI)  Q:$D(DTOUT)!($D(DUOUT))
 N ICD10D S ICD10D=$$IMP^ICDEX(30) S ICDSRC=+ICDCS
 S:+ICDCS'>0&(+ICDFI=80) ICDSRC=$S(+ICDVD<+ICD10D:1,1:30)
 S:+ICDCS'>0&(+ICDFI=80.1) ICDSRC=$S(+ICDVD<+ICD10D:2,1:31)
 S ICDFM=$$FM  Q:$D(DTOUT)!($D(DUOUT))
 N ICDTEST
 Q
DP(X) ; Diagnosis or Procedure
 N ICD,DIR,ICDB,ICDN,Y K ICD K DTOUT,DUOUT,DIRUT,DIROUT
 S ICD="",DIR(0)="SAO^D:Diagnosis;P:Procedures"
 S DIR("B")=$$RET("DP") S:'$L(DIR("B")) DIR("B")="Diagnosis"
 S (DIR("?"),DIR("??"))="^D DPH^ICDDICA"
 S DIR("PRE")="S X=$$DPP^ICDDICA($G(X))"
 S DIR("A")=" Search ICD Diagnosis or Procedures (D/P):  "
 D ^DIR S X=Y
 S ICDN="" S:X="D" ICDN="Diagnosis" S:X="P" ICDN="Procedures"
 D:$L(ICDN) SAV("DP",ICDN)
 Q X
DPP(X) ;   Diagnosis or Procedure - Pre-process
 Q:'$L($G(X)) ""  Q:X["?" "??"  Q:X["^^" "^^"  Q:X["^" "^"
 S X=$$UP^XLFSTR(X)   Q:$E("OPERATIONS",1,$L(X))=X "Procedures"
 Q:$E("PROCEDURES",1,$L(X))=X "Procedures" Q:$E("DIAGNOSIS",1,$L(X))=X "Diagnosis"
 Q X
DPH ;   Diagnosis or Procedure - Help
 W !,?5,"Enter 'D' or 'Diagnosis' to search the ICD DIAGNOSIS file #80"
 W !,?5,"Enter 'P' or 'Procedures' to search the ICD PROCEDURE file #80.1"
 W !,?5,"Enter '^' to quit, and 'Return' to accept the default value."
 Q
OA(X) ; One or All Coding System
 N ICD,DIR,ICDB,ICDN,ICDF,Y K ICD K DTOUT,DUOUT,DIRUT,DIROUT
 S ICDF=+($G(X)) Q:'$D(^ICDS("F",+ICDF)) "A"
 S ICD="",DIR(0)="SAO^O:One System;A:All Systems"
 S DIR("B")=$$RET("OA") S:'$L(DIR("B")) DIR("B")="All Coding Systems"
 S (DIR("?"),DIR("??"))="^D OAH^ICDDICA"
 S DIR("PRE")="S X=$$OAP^ICDDICA($G(X))"
 S DIR("A")=" Search One or All Coding Systems in file "_ICDF_" (O/A):  "
 S DIR("A")=" Search One or All Coding Systems (O/A):  "
 D ^DIR S X=Y
 S ICDN="" S:X="O" ICDN="One System" S:X="A" ICDN="All Systems"
 D:$L(ICDN) SAV("OA",ICDN)
 Q X
OAP(X) ;   One or All Coding System - Pre-process
 Q:'$L($G(X)) ""  Q:X["?" "??"  Q:X["^^" "^^"  Q:X["^" "^"  S X=$$UP^XLFSTR(X)
 Q:$E("ONE CODING SYSTEM",1,$L(X))=X "One System"
 Q:$E("ONE SYSTEM",1,$L(X))=X "One System"
 Q:$E("ALL CODING SYSTEMS",1,$L(X))=X "All Systems"
 Q:$E("ALL SYSTEMS",1,$L(X))=X "All Systems"
 S:"^O^A"'[("^"_$E(X,1)_"^") X="??"
 Q X
OAH ;   One or All Coding System - Help
 W !,?5,"Enter 'O' to search one coding system " W:+($G(ICDF))>0 "in file ",$G(ICDF)
 W !,?5,"Enter 'A' to search all coding systems " W:+($G(ICDF))>0 "in file ",$G(ICDF)
 I $D(^ICDS("F",+($G(ICDF)))) D
 . N ICDI,ICDC S (ICDI,ICDC)=0 F  S ICDI=$O(^ICDS("F",+($G(ICDF)),ICDI)) Q:ICDI'>0  D
 . . N ICDS S ICDS=$P($G(^ICDS(ICDI,0)),"^",1) Q:'$L(ICDS)  S ICDC=ICDC+1 W:ICDC=1 !
 . . W !,?15,ICDS
 Q
CS(X) ; Coding System
 N ICD,DIC,ICDB,ICDBI,ICDN,ICDF,ICDI,ICDD,Y K ICD K DTOUT,DUOUT,DIRUT,DIROUT
 S ICDF=+($G(X)) Q:'$D(^ICDS("F",+ICDF)) "^" S ICDI=$O(^ICDS("F",+ICDF," "),-1) Q:+ICDI'>0 "^"
 S ICDD=$P($G(^ICDS(+ICDI,0)),"^",1) Q:'$L(ICDD) "^"  S ICD="",DIC="^ICDS(",DIC(0)="AEQM"
 S ICDB=$$RET("CS"),ICDBI=0 S:$L(ICDB) ICDBI=$O(^ICDS("B",ICDB,0))
 S:$L(ICDB)&(+($G(ICDBI))'>0) ICDBI=$O(^ICDS("C",ICDB,0))
 S:ICDBI>0&($P($G(^ICDS(+ICDBI,0)),"^",3)'=+ICDF) ICDB=""
 S:$L(ICDB) DIC("B")=ICDB S:'$L($G(DIC("B")))&($L(ICDD)) DIC("B")=ICDD
 S DIC("A")="   Select Coding Systems:  "
 S DIC("S")="I $G(ICDF)>0&($P($G(^ICDS(+Y,0)),""^"",3)=$G(ICDF))"
 S (DIC("?"),DIC("??"))="^D CSH^ICDDICA"
 D ^DIC I +Y>0 S ICDD=$P($G(^ICDS(+Y,0)),"^",1) D:$L(ICDD) SAV("CS",ICDD)
 S X=Y
 Q X
CSH ;   One or All Coding System - Help
 W !,?5,"Answer with ICD CODING SYSTEMS (i.e., "
 W $S(+ICDF=80:"ICD-10-CM",+ICDF=80.1:"ICD-10-PCS",1:"ICD-10-CM")
 W " or ICD CODING SYSTEM NOMENCLATURE, or"
 W ?5,"CODING SYSTEM ABBREVIATION"
 Q
 I $D(^ICDS("F",+($G(ICDF)))) D
 . N ICDI,ICDC S (ICDI,ICDC)=0 F  S ICDI=$O(^ICDS("F",+($G(ICDF)),ICDI)) Q:ICDI'>0  D
 . . N ICDS S ICDS=$P($G(^ICDS(ICDI,0)),"^",1) Q:'$L(ICDS)  S ICDC=ICDC+1 W:ICDC=1 !
 . . W !,?15,ICDS
 Q
VR(X) ; Versioned Search
 N ICD,DIR,ICDB,ICDN,Y K ICD K DTOUT,DUOUT,DIRUT,DIROUT
 S ICD="",DIR(0)="YAO" S DIR("B")=$$RET("VR") S:'$L(DIR("B")) DIR("B")="Yes"
 S (DIR("?"),DIR("??"))="^D VRH^ICDDICA"
 S DIR("PRE")="S X=$$VRP^ICDDICA($G(X))"
 S DIR("A")=" Conduct a versioned (date sensitive) Search (Y/N):  "
 D ^DIR S X=Y
 S ICDN="" S:X="1" ICDN="Yes" S:X="0" ICDN="No"
 D:$L(ICDN) SAV("VR",ICDN)
 Q X
VRP(X) ;   Diagnosis or Procedure - Pre-process
 Q:'$L($G(X)) ""  Q:X["?" "??"  Q:X["^^" "^^"  Q:X["^" "^"
 S X=$$UP^XLFSTR(X)   Q:$E("YES",1,$L(X))=X "Yes" Q:$E("NO",1,$L(X))=X "No"
 S X="??"
 Q X
VRH ;   Diagnosis or Procedure - Help
 W !,?5,"Enter 'Yes' to conduct a versioned search (date sensitive) or"
 W !,?5,"enter 'No' to contuct an unversioned search.",!
 W !,?5,"NOTE:  Inactive codes will NOT be displayed during a versioned"
 W !,?5,"       search (date sensitive) and will be displayed during an "
 W !,?5,"       unversioned search (date doesn't matter)."
 Q
VD(X) ; Versioned Date
 N ICD,DIR,ICDB,ICDN,ICDTD,ICDD1,ICDD2,Y K ICD K DTOUT,DUOUT,DIRUT,DIROUT
 S ICDTD=$$DT^XLFDT,ICDD1=2781001,ICDD2=$$FMADD^XLFDT(ICDTD,(365*5))
 S DIR(0)="DAO^"_ICDD1_":"_ICDD2_":"
 S DIR("B")=$$RET("VD") S:'$L(DIR("B")) DIR("B")=$$FMTE^XLFDT(ICDTD)
 S (DIR("?"),DIR("??"))="^D VDH^ICDDICA"
 S DIR("PRE")="S X=$$VDP^ICDDICA($G(X))"
 S DIR("A")="   Enter a versioning date:  "
 S DIR("A")="   Enter a date from "_$$FMTE^XLFDT($G(ICDD1),"5Z")_" to "_$$FMTE^XLFDT($G(ICDD2),"5Z")_":  "
 D ^DIR S X=Y
 S ICDN="" S:$P(X,".",1)?7N ICDN=$$UP^XLFSTR($$FMTE^XLFDT($P(X,".",1)))
 D:$L(ICDN) SAV("VD",ICDN)
 Q X
VDP(X) ;   Diagnosis or Procedure - Pre-process
 S X=$$UP^XLFSTR($G(X)) Q:'$L($G(X)) ""  Q:X["?" "??"  Q:X["^^" "^^"  Q:X["^" "^"
 N ICDI,ICDA,ICDO S (ICDA,ICDI)=$$EFM(X) S:ICDA#10000=0 ICDA=ICDA+101 S:ICDA#100=0 ICDA=ICDA+1
 S:$E(ICDA,4,5)="00" ICDA=$E(ICDA,1,3)_"01"_$E(ICDA,6,7) S:$E(ICDA,6,7)="00" ICDA=$E(ICDA,1,5)_"01"
 S ICDA=$P(ICDA,".",1) S ICDO=$$UP^XLFSTR($$FMTE^XLFDT(ICDA)) Q:ICDA?7N ICDO  S X="??"
 Q X
VDH ;   Diagnosis or Procedure - Help
 W !,?5,"Enter a date from ",$$FMTE^XLFDT($G(ICDD1))," to ",$$FMTE^XLFDT($G(ICDD2)),".  Time is"
 W !,?5,"allowed but not required.  Code Set Business rules apply"
 W !,?5,"for imprecise dates:",!
 W !,?5,"     Month is missing:  Use January"
 W !,?5,"     Day is missing:    Use the 1st"
 Q
FM(X) ; Diagnosis or Procedure
 N ICD,DIR,ICDB,ICDN,ICDSRC,Y K ICD K DTOUT,DUOUT,DIRUT,DIROUT S ICDSRC=$G(X) S ICD=""
 S DIR(0)="SAO^1:FileMan Format;2:Modified FileMan Format;3:Short Lexicon Format;4:Long Lexicon Format"
 S DIR("B")=$$RET("FM") S:'$L(DIR("B")) DIR("B")="FileMan Format"
 S (DIR("?"),DIR("??"))="^D FMH^ICDDICA"
 S DIR("PRE")="S X=$$FMP^ICDDICA($G(X))"
 S DIR("A")=" Select Display Format (1-4):  "
 D ^DIR S X=Y S ICDN="" S:$L($G(Y(0))) ICDN=$G(Y(0))
 D:$L(ICDN) SAV("FM",ICDN)
 Q X
FMP(X) ;   Diagnosis or Procedure - Pre-process
 S X=$$UP^XLFSTR($G(X)) Q:'$L($G(X)) ""  Q:X["?" "??"  Q:X["^^" "^^"  Q:X["^" "^"
 Q:X=1 "FileMan Format" Q:X=2 "Modified FileMan Format" Q:X=3 "Short Lexicon Format" Q:X=4 "Long Lexicon Format"
 Q:$E("FILEMAN FORMAT",1,$L(X))=X "FileMan Format"
 Q:$E("MODIFIED FILEMAN FORMAT",1,$L(X))=X "Modified FileMan Format"
 Q:$E("SHORT LEXICON FORMAT",1,$L(X))=X "Short Lexicon Format"
 Q:$E("LONG LEXICON FORMAT",1,$L(X))=X "Long Lexicon Format"
 S X="??"
 Q X
FMH ;   Display Format - Help
 N ICDCOD,ICDSHRT,ICDLONG,ICDMIX
 I $G(ICDSRC)=1!("^1^2^30^31^"'[("^"_+($G(ICDSRC))_"^")) D
 . S ICDCOD="275.1"
 . S ICDSHRT="DIS COPPER METABOLISM"
 . S ICDLONG="DISORDERS OF COPPER METABOLISM"
 . S ICDMIX="Disorders of Copper Metabolism"
 I $G(ICDSRC)=2 D
 . S ICDCOD="01.21"
 . S ICDSHRT="CRANIAL SINUS I D"
 . S ICDLONG="INCISION AND DRAINAGE OF CRANIAL SINUS"
 . S ICDMIX="Incision and Drainage of Cranial Sinus"
 I $G(ICDSRC)=30 D
 . S ICDCOD="T36.0X1S"
 . S ICDSHRT="Penicillin poisoning , acc, sequela"
 . S ICDLONG="POISONING BY PENICILLINS, ACCIDENTAL, SEQUELA"
 . S ICDMIX="Poisoning by Penicillins, Accidental, Sequela"
 I $G(ICDSRC)=31 D
 . S ICDCOD="0BQ37ZZ"
 . S ICDSHRT="Repair Right Bronchus, Opening"
 . S ICDLONG="REPAIR RIGHT BRONCHUS, VIA NATURAL/ARTIFICIAL OPENING"
 . S ICDMIX="Repair right Bronchus, via Natural/Artificial Opening"
 W !,?5,"Enter  "
 W !,?5,"  1    FileMan format, code followed by short text (default):"
 W !,?5,""
 W !,?5,"       ",ICDCOD,"    ",ICDSHRT
 W !,?5,""
 W !,?5,"  2    Modified FileMan format, code followed by description:"
 W !,?5,""
 W !,?5,"       ",ICDCOD,"    ",ICDLONG
 W !,?5,""
 W !,?5,"  3    Short Lexicon format, short text followed by code:"
 W !,?5,""
 W !,?5,"       ",ICDSHRT," (",ICDCOD,")"
 W !,?5,""
 W !,?5,"  4    Long Lexicon format, description followed by code:"
 W !,?5," "
 W !,?5,"       ",ICDMIX," (",ICDCOD,")"
 W !,?5," "
 Q
SAV(X,ICDV) ;   Save Defaults
 N ICDR,ICDT,ICDU,ICDC,ICDVAL,ICDN,ICDID,ICDD,ICDF,ICDK,Y S ICDR=$P($T(+1)," ",1) Q:$L(ICDR)'>1  Q:$L(ICDR)>8
 S ICDT=$G(X) Q:'$L(ICDT)  S ICDC=$T(@(ICDT_"^"_ICDR)) Q:'$L(ICDC)  S ICDU=+($G(DUZ)) Q:+ICDU'>0
 S ICDN=$$GET1^DIQ(200,(ICDU_","),.01) Q:'$L(ICDN)  S ICDVAL=$G(ICDV) Q:ICDU'>0  Q:'$L(ICDVAL)
 S ICDC=$$TM($P(ICDC,";",2)) Q:'$L(ICDC)  S ICDK=$E(ICDC,1,13) F  Q:$L(ICDK)>12  S ICDK=ICDK_" "
 S ICDD=$$DT^XLFDT,ICDF=$$FMADD^XLFDT(ICDD,30),ICDID=ICDR_" "_ICDU_" "_ICDK
 S ^XTMP(ICDID,0)=ICDF_"^"_ICDD_"^"_ICDC,^XTMP(ICDID,ICDT)=ICDVAL
 Q
RET(X) ;   Retrieve Defaults
 N ICDR,ICDT,ICDU,ICDC,ICDN,ICDID,ICDD,ICDF,ICDK S ICDR=$P($T(+1)," ",1) Q:$L(ICDR)'>1  Q:$L(ICDR)>8
 S ICDT=$G(X) Q:'$L(ICDT)  S ICDC=$T(@(ICDT_"^"_ICDR)) Q:'$L(ICDC)  S ICDU=+($G(DUZ)) Q:+ICDU'>0
 S ICDN=$$GET1^DIQ(200,(ICDU_","),.01) Q:'$L(ICDN)  S ICDC=$$TM($P(ICDC,";",2)) Q:'$L(ICDC)
 S ICDK=$E(ICDC,1,13) F  Q:$L(ICDK)>12  S ICDK=ICDK_" "
 S ICDD=$$DT^XLFDT,ICDF=$$FMADD^XLFDT(ICDD,30),ICDID=ICDR_" "_ICDU_" "_ICDK
 S X=$G(^XTMP(ICDID,ICDT))
 Q X
EFM(X) ; Convert External Date to FM
 N Y,%DT D ^%DT S X=Y K %DT
 Q X
TM(X,Y) ; Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" " Q:X'[Y X
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
