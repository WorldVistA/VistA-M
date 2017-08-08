LEXQC ;ISL/KER - Query - Changes - Extract ;05/23/2017
 ;;2.0;LEXICON UTILITY;**62,80,103**;Sep 23, 1996;Build 2
 ;               
 ; Global Variables
 ;    ^TMP("LEXQC")       SACC 2.3.2.5.1
 ;    ^TMP("LEXQCO")      SACC 2.3.2.5.1
 ;               
 ; External References
 ;    HOME^%ZIS           ICR  10086
 ;    ^%ZTLOAD            ICR  10063
 ;    $$GET1^DIQ          ICR   2056
 ;    ^DIR                ICR  10026
 ;    $$FMADD^XLFDT       ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    ^XMD                ICR  10070
 ;               
EN ; Main Entry Point
 N LEXENV S LEXENV=$$EV^LEXQM Q:+LEXENV'>0
 W:$L($G(IOF)) @IOF W !," ICD/CPT Change List",!," ==================="
 K ^TMP("LEXQCO",$J),^TMP("LEXQC",$J) N LEXEXIT,LEXDSP,LEXOUT
 S LEXDSP=$$DT I "^D^B^"'[("^"_LEXDSP_"^") W !!,"   Display type not selected",! Q
 S LEXOUT=$$OUT I "^0^1^"'[("^"_LEXOUT_"^") W !!,"   Output not selected",! Q
 I LEXDSP="B" D  Q
 . N LEXTASK S:LEXOUT=1 LEXTASK=1 K:LEXOUT'=1 LEXTASK D EN^LEXQC6
 I LEXDSP="D" D  Q
 . N LEXTASK S:LEXOUT=1 LEXTASK=1 K:LEXOUT'=1 LEXTASK D TASK
 Q
SUM ; Summary List (totals only)
 N LEXOUT S LEXOUT=$$OUT D:LEXOUT="0" EN^LEXQC6 D:LEXOUT="1" MAIL^LEXQC6
 Q
TASK ; Task Search for CSV Changes
 W !!," Detailed Display (includes codes)"
 N X,Y,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTQUEUED,ZTREQ,LEXCDT,LEXEDT,LEXEXIT
 S LEXCDT=$$CSD^LEXQM
 I +($G(LEXEXIT))>0 W !!,"   Code Set Change List aborted",! Q
 S LEXEDT=$P(LEXCDT,"^",1),LEXCDT=$P(LEXCDT,"^",2)
 I '$L(LEXCDT)!(LEXCDT'?7N) W !!,"   Code Set Date invalid or not selected",! Q
 I $$CDTOK(LEXCDT)'>0 W !!,"   No Code Set changes found for ",$$FMTE^XLFDT(LEXCDT),! Q
 S LEXCDT=+($G(LEXCDT)) Q:LEXCDT'?7N  S LEXEDT=$G(LEXEDT) Q:'$L(LEXEDT)
 S ZTRTN="SEARCH^LEXQC",ZTSAVE("LEXCDT")="",ZTIO="",ZTDTH=$H
 S ZTDESC="Search for CSV Changes on "_LEXEDT
 D:'$D(LEXTASK) @ZTRTN D:$D(LEXTASK) ^%ZTLOAD D HOME^%ZIS S X=+($G(ZTSK))
 I +X>0 D
 . W !!,"   A search for CSV changes on ",LEXEDT," has been queued"
 . W !,"   (task ",+X,").  Results will be sent to you in a MailMan"
 . W !,"   message.",!
 K Y,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,LEXQUIET,LEXTASK
 Q
SEARCH ; Search for CSV changes
 S:$D(ZTQUEUED) ZTREQ="@" S LEXCDT=$G(LEXCDT) Q:LEXCDT'?7N
 N LEXBDT,LEXADT,LEXRT,LEXQTOT,LEXQLEN,LEXQSTR,LEXIIMP,LEXCIMP
 S LEXBDT=$$FMADD^XLFDT(LEXCDT,-1),LEXADT=$$FMADD^XLFDT(DT,+1)
 Q:LEXBDT'?7N  Q:LEXADT'?7N  K ^TMP("LEXQC",$J)
 S LEXIIMP=$$IMPDATE^LEXU("10D"),LEXCIMP=$$IMPDATE^LEXU("CPT"),LEXQTOT=0
 I LEXCDT<LEXIIMP S LEXQTOT=LEXQTOT+($P($G(^LEX(757.03,1,0)),"^",6))+($P($G(^LEX(757.03,2,0)),"^",6))
 I LEXCDT>(LEXIIMP-.0001) S LEXQTOT=LEXQTOT+($P($G(^LEX(757.03,30,0)),"^",6))+($P($G(^LEX(757.03,31,0)),"^",6))
 I LEXCDT>(LEXCIMP-.0001) S LEXQTOT=LEXQTOT+($P($G(^LEX(757.03,3,0)),"^",6))+($P($G(^LEX(757.03,4,0)),"^",6))
 S:+($G(LEXQTOT))'>0 LEXQTOT=193006
 S LEXQLEN=68,LEXQSTR=+(LEXQTOT\LEXQLEN) S:LEXQSTR=0 LEXQSTR=1
 W:'$D(ZTQUEUED) !!," Gathering data, please wait.",!,"   "
 D:LEXCDT<LEXIIMP D09^LEXQC3,P09^LEXQC3
 D:LEXCDT>(LEXIIMP-.0001) D10^LEXQC3,P10^LEXQC3
 D:LEXCDT>(LEXCIMP-.0001) CPT^LEXQC4,MOD^LEXQC4 D EN^LEXQC2
 D:'$D(ZTQUEUED)&($D(^TMP("LEXQCO",$J))) DSP^LEXQO("LEXQCO")
 D:$D(ZTQUEUED)&($D(^TMP("LEXQCO",$J))) MM
 Q
 ; 
 ; Miscellaneous
DT(X) ; Display Type
 Q:+($G(LEXEXIT))>0 "^^"  N DIR,DIRUT,DIROUT,DTOUT,DUOUT,Y,DIRB S DIRB=$$RET^LEXQD("LEXQC","DT",+($G(DUZ)),"Display Type")
 S:'$L(DIRB) DIRB="Detailed"
 S DIR(0)="SAO^D:Detailed Listing;B:Brief Listing",DIR("A")=" Detailed or Brief Listing?  (D/B)  "
 S:"^DETAILED^BRIEF^Detailed^Brief^"[("^"_DIRB_"^") DIR("B")=DIRB
 S DIR("PRE")="S:X[""?"" X=""??""" S (DIR("?"),DIR("??"))="^D DTH^LEXQC"
 W ! D ^DIR S:X["^^"!($D(DTOUT)) LEXEXIT=1 Q:X["^^"!(+($G(LEXEXIT))>0) "^^"  Q:$D(DIRUT)!($D(DIROUT))!($D(DTOUT))!($D(DUOUT)) "^"
 S DIRB=$S(Y="D":"Detailed",Y="B":"Brief",X["^":"",1:"")
 D:$L(DIRB) SAV^LEXQD("LEXQC","DT",+($G(DUZ)),"Display Type",$G(DIRB))
 S X=$S("^D^B^"[("^"_Y_"^"):Y,1:"^")
 Q X
DTH ;   Display Type Help
 W !,?3,"Listing of Code Set changes for a specified date",!
 W !,?3,"  Enter    For                 To"
 W !,?3,"    D      Detailed Listing    Includes codes"
 W !,?3,"    B      Brief Listing       Include totals only"
 Q
OUT(X) ; Output
 Q:+($G(LEXEXIT))>0 "^^"  N DIR,DIRUT,DIROUT,DTOUT,DUOUT,Y,DIRB S DIRB=$$RET^LEXQD("LEXQC","OUT",+($G(DUZ)),"Output")
 S:'$L(DIRB) DIRB="No"
 S DIR(0)="YAO",DIR("A")=" Save Listing in a MailMan Message?  (Y/N)  "
 S:"^YES^NO^Yes^No^"[("^"_DIRB_"^") DIR("B")=DIRB
 S DIR("PRE")="S:X[""?"" X=""??""" S (DIR("?"),DIR("??"))="^D OUTH^LEXQC"
 W ! D ^DIR S:X["^^"!($D(DTOUT)) LEXEXIT=1 Q:X["^^"!(+($G(LEXEXIT))>0) "^^"  Q:$D(DIRUT)!($D(DIROUT))!($D(DTOUT))!($D(DUOUT)) "^"
 S DIRB=$S(Y="1":"Yes",Y="0":"No",1:"^")
 D:$L(DIRB) SAV^LEXQD("LEXQC","OUT",+($G(DUZ)),"Output",$G(DIRB))
 S X=$S("^0^1^"[("^"_Y_"^"):Y,1:"^")
 Q X
OUTH ;   Output
 W !,?3,"Enter 'Yes' to send the output listing in a MailMan message."
 W !,?3,"Enter 'No' to display the output listing to the screen."
 Q
MM ;   MailMan Message
 G:'$D(^TMP("LEXQCO",$J)) MMQ  N XCNP,XMSCR,XMDUZ,XMY,XMZ,XMSUB,XMTEXT,XMDUZ,LEXJ,LEXNM
 S XMTEXT="^TMP(""LEXQCO"","_$J_",",XMSUB="CSV ICD/CPT Changes",LEXNM=$$GET1^DIQ(200,+($G(DUZ)),.01) G:'$L(LEXNM) MMQ
 S XMY(LEXNM)="",XMDUZ=.5 D ^XMD
MMQ ;   MailMan Quit
 K ^TMP("LEXQCO",$J),LEXNM,LEXSUB
 Q
CDTOK(X) ;   Code Set Date is OK
 N LEXCDT,LEXOK,LEXSAB,LEXI S LEXOK=0,LEXCDT=$G(X) Q:LEXCDT'?7N LEXOK
 F LEXSAB="ICD","ICP","10D","10P","CPT","CPC" D  Q:LEXOK>0
 . S:$D(^LEX(757.02,"AUPD",LEXSAB,LEXCDT)) LEXOK=1
 I LEXOK'>0 S LEXI=0 F  S LEXI=$O(@("^DIC(81.3,"_LEXI_")")) Q:+LEXI'>0  D  Q:LEXOK>0
 . S:$D(@("^DIC(81.3,"_LEXI_",60,""B"","_LEXCDT_")")) LEXOK=1
 . S:$D(@("^DIC(81.3,"_LEXI_",61,""B"","_LEXCDT_")")) LEXOK=1
 . S:$D(@("^DIC(81.3,"_LEXI_",62,""B"","_LEXCDT_")")) LEXOK=1
 S X=LEXOK
 Q X
