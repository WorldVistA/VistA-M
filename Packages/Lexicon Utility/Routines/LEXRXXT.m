LEXRXXT ;ISL/KER - Repair/Re-Index - Task ;08/17/2011
 ;;2.0;LEXICON UTILITY;**81**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^LEX(               SACC 1.3
 ;    ^LEXT(              SACC 1.3
 ;    ^TMP("LEXRX")       SACC 2.3.2.5.1
 ;    ^XTMP("LEXRX")      SACC 2.3.2.5.2 
 ;               
 ; External References
 ;    HOME^%ZIS           ICR  10086
 ;    ^%ZTLOAD            ICR  10063
 ;    $$FMDIFF^XLFDT      ICR  10103
 ;    $$NOW^XLFDT         ICR  10103
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     LEXAMSO    User Selection  NEWed/KILLed by LEXRX
 ;     LEXFI      File number     NEWed/KILLed by LEXRX
 ;     LEXINS     Install Flag    NEWed/KILLed by Post-Install
 ;     LEXOK      Continue flag   NEWed/KILLed by LEXRX
 ;               
 Q
ALL ; Repair/Re-Index all Lexicon Files
 Q:+($G(LEXOK))'>0  Q:$G(LEXAMSO)'="A"  N X,Y,ZTQUEUED,ZTREQ,ZTSK
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,LEXI,LEXU,LEXNAM
 N LEXC,LEXL,LEXENV,LEXTSK,LEXMSG,LEXSUBJ
 S LEXNAM="LEXRXALL" I $D(^XTMP(LEXNAM,0)) D PROG(LEXNAM) Q
 K ^TMP("LEXRX",$J) S LEXENV=$$ENV^LEXRXXM Q:+LEXENV'>0
 S LEXSUBJ="Lexicon - Repair/Re-Index All Files"
 S ZTRTN="ALLT^LEXRXXT2",ZTDESC="Lexicon Index Repair/Re-Index"
 S ZTIO="",ZTDTH=$H S:$D(LEXINS) ZTSAVE("LEXINS")=""
 S ZTSAVE("DUZ")="",ZTSAVE("LEXAMSO")="",ZTSAVE("LEXSUBJ")=""
 S LEXMSG="When the task completes a message will be sent"
 S LEXMSG=LEXMSG_" to you reporting the results."
 D ^%ZTLOAD K LEXTSK I +($G(ZTSK))>0&('$D(LEXINS)) D
 . S LEXTSK(1)="A task has been created to repair the cross-references"
 . S LEXTSK(2)="in the major Lexicon files and to re-index the cross-"
 . S LEXTSK(3)="references of the supporting Lexicon files.  This "
 . S LEXTSK(4)="will take several hours, however, users may be on the "
 . S LEXTSK(5)="system during this time. (Task #"_+($G(ZTSK))_"). "
 . S:$L($G(LEXMSG)) LEXTSK(6)=LEXMSG
 I $O(LEXTSK(0))>0&('$D(LEXINS)) D PR^LEXRXXP(.LEXTSK,70)
 I '$D(LEXINS) S LEXI=0 F  S LEXI=$O(LEXTSK(LEXI)) Q:+LEXI'>0  D
 . S LEXC=$$TM^LEXRXXM($G(LEXTSK(LEXI))) W:'$D(LEXINS) !,"  ",LEXC
 D HOME^%ZIS K ZTDESC,ZTDTH,ZTIO,ZTRTN S LEXI=0
 W:+($G(ZTSK))>0&('$D(LEXINS)) ! H:+($G(ZTSK))>0&('$D(LEXINS)) 1 K ZTSK
 Q
MAJ ; Repair/Re-Index all Lookup Related Lexicon Files
 Q:+($G(LEXOK))'>0  Q:$G(LEXAMSO)'="M"
 N X,Y,ZTQUEUED,ZTREQ,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,LEXI
 N LEXU,LEXC,LEXL,LEXENV,LEXTSK,LEXMSG,LEXSUBJ,LEXNAM
 S LEXNAM="LEXRXMAJ" I $D(^XTMP(LEXNAM,0)) D PROG(LEXNAM) Q
 S LEXSUBJ="Lexicon - Repair Major Files (larger files)"
 K ^TMP("LEXRX",$J) S LEXENV=$$ENV^LEXRXXM Q:+LEXENV'>0
 S ZTRTN="MAJT^LEXRXXT2",ZTDESC="Lexicon Look-up Index Repair"
 S ZTIO="",ZTDTH=$H,ZTSAVE("DUZ")="",ZTSAVE("LEXAMSO")=""
 S ZTSAVE("LEXSUBJ")="" S:$D(LEXINS) ZTSAVE("LEXINS")=""
 S LEXMSG="When the task completes a message will be sent"
 S LEXMSG=LEXMSG_" to you reporting the results."
 D ^%ZTLOAD K LEXTSK I +($G(ZTSK))>0&('$D(LEXINS)) D
 . S LEXTSK(1)="A task has been created to repair the "
 . S LEXTSK(2)="cross-references of the major files in the Lexicon "
 . S LEXTSK(3)="(Task #"_+($G(ZTSK))_")."
 . S:$L($G(LEXMSG)) LEXTSK(4)=LEXMSG
 I $O(LEXTSK(0))>0&('$D(LEXINS)) D PR^LEXRXXP(.LEXTSK,70)
 I '$D(LEXINS) S LEXI=0 F  S LEXI=$O(LEXTSK(LEXI)) Q:+LEXI'>0  D
 . S LEXC=$$TM^LEXRXXM($G(LEXTSK(LEXI))) W:'$D(LEXINS) !,"  ",LEXC
 D HOME^%ZIS K ZTDESC,ZTDTH,ZTIO,ZTRTN S LEXI=0
 W:+($G(ZTSK))>0&('$D(LEXINS)) ! H:+($G(ZTSK))>0&('$D(LEXINS)) 1 K ZTSK
 Q
SUP ; Re-Index all Supporting Lexicon Files (non-Lookup Related)
 Q:+($G(LEXOK))'>0  Q:$G(LEXAMSO)'="S"  N X,Y,ZTQUEUED,ZTREQ,ZTSK
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,LEXI,LEXU,LEXC,LEXL,LEXENV
 N LEXTSK,LEXMSG,LEXSUBJ,LEXNAM
 S LEXNAM="LEXRXSUP" I $D(^XTMP(LEXNAM,0)) D PROG(LEXNAM) Q
 S LEXSUBJ="Lexicon - Re-Index Supporting Files (smaller files)"
 K ^TMP("LEXRX",$J) S LEXENV=$$ENV^LEXRXXM Q:+LEXENV'>0
 S ZTRTN="SUPT^LEXRXXT2",ZTDESC="Lexicon Look-up Index Repair"
 S ZTIO="",ZTDTH=$H,ZTSAVE("DUZ")="",ZTSAVE("LEXAMSO")=""
 S ZTSAVE("LEXSUBJ")="" S:$D(LEXINS) ZTSAVE("LEXINS")=""
 S LEXMSG="When the task completes a message will be sent"
 S LEXMSG=LEXMSG_" to you reporting the results."
 D ^%ZTLOAD K LEXTSK I +($G(ZTSK))>0&('$D(LEXINS)) D
 . S LEXTSK(1)="A task has been created to re-index the "
 . S LEXTSK(2)="cross-references of the supporting files in the "
 . S LEXTSK(3)="Lexicon (Task #"_+($G(ZTSK))_")."
 . S:$L($G(LEXMSG)) LEXTSK(4)=LEXMSG
 I $O(LEXTSK(0))>0&('$D(LEXINS)) D PR^LEXRXXP(.LEXTSK,70)
 I '$D(LEXINS) S LEXI=0 F  S LEXI=$O(LEXTSK(LEXI)) Q:+LEXI'>0  D
 . S LEXC=$$TM^LEXRXXM($G(LEXTSK(LEXI))) W:'$D(LEXINS) !,"  ",LEXC
 D HOME^%ZIS K ZTDESC,ZTDTH,ZTIO,ZTRTN S LEXI=0
 W:+($G(ZTSK))>0&('$D(LEXINS)) ! H:+($G(ZTSK))>0&('$D(LEXINS)) 1 K ZTSK
 Q
ONE ; Repair/Re-Index one file X
 Q:+($G(LEXOK))'>0  Q:$G(LEXAMSO)'="O"  Q:'$L($G(LEXFI))
 S LEXFI=$G(LEXFI) Q:'$D(^LEX(LEXFI))&('$D(^LEXT(LEXFI)))
 N Y,ZTQUEUED,ZTREQ,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,LEXI,LEXU
 N LEXC,LEXL,LEXENV,LEXTY,LEXUTY,LEXTSK,LEXMSG,LEXFN,LEXSUBJ,LEXNAM
 S LEXNAM="LEXRXONE" I $D(^XTMP(LEXNAM,0)) D PROG(LEXNAM) Q
 S LEXENV=$$ENV^LEXRXXM Q:+LEXENV'>0  S LEXTY=""
 I "^757^757.001^757.01^757.02^757.1^757.21^757.33^"[("^"_LEXFI_"^") D
 . S LEXTY="repair",LEXUTY="Repair"
 S:'$L(LEXTY) LEXTY="re-index",LEXUTY="Re-Index"
 S LEXFN=$$FN^LEXRXXM(LEXFI)
 S LEXSUBJ="Lexicon - "_LEXUTY_" the "_LEXFN_" file #"_LEXFI
 S ZTRTN="ONET^LEXRXXT2",ZTIO="",ZTDTH=$H
 S ZTDESC="Lexicon Index Repair/Re-Index file "_LEXFI
 S:$D(LEXINS) ZTSAVE("LEXINS")=""
 S ZTSAVE("DUZ")="",ZTSAVE("LEXFI")="",ZTSAVE("LEXAMSO")=""
 S ZTSAVE("LEXSUBJ")="",ZTSAVE("LEXTY")="",ZTSAVE("LEXFN")=""
 S LEXMSG="When the task completes a message will be sent"
 S LEXMSG=LEXMSG_" to you reporting the results."
 D ^%ZTLOAD I +($G(ZTSK))>0&('$D(LEXINS)) D
 . S LEXTSK(1)="A task has been created to "_LEXTY_" the "
 . S LEXTSK(2)="cross-references in "_$S($L(LEXFN):"the ",1:"Lexicon ")
 . S LEXTSK(3)=$S($L(LEXFN):LEXFN,1:"")_" file #"_LEXFI_" "
 . S LEXTSK(4)="(Task #"_+($G(ZTSK))_")."
 . S:$L($G(LEXMSG)) LEXTSK(5)=LEXMSG
 I $O(LEXTSK(0))>0&('$D(LEXINS)) D PR^LEXRXXP(.LEXTSK,70)
 I '$D(LEXINS) S LEXI=0 F  S LEXI=$O(LEXTSK(LEXI)) Q:+LEXI'>0  D
 . S LEXC=$$TM^LEXRXXM($G(LEXTSK(LEXI))) W:'$D(LEXINS) !,"  ",LEXC
 D HOME^%ZIS K ZTDESC,ZTDTH,ZTIO,ZTRTN S LEXI=0
 W:+($G(ZTSK))>0&('$D(LEXINS)) ! H:+($G(ZTSK))>0&('$D(LEXINS)) 1 K ZTSK
 Q
SET ; Set Logic Only
 Q:+($G(LEXFI))'>0  S LEXFI=+($G(LEXFI))
 Q:'$D(^LEX(LEXFI))&('$D(^LEXT(LEXFI)))
 N Y,ZTQUEUED,ZTREQ,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,LEXI,LEXU
 N LEXC,LEXL,LEXENV,LEXTY,LEXUTY,LEXTSK,LEXMSG,LEXFN,LEXSUBJ,LEXNAM
 N LEXQ,LEXSET S LEXNAM="LEXRXSET" S LEXENV=$$ENV^LEXRXXM Q:+LEXENV'>0
 S LEXQ="",ZTRTN="SET^LEXRXXT2",ZTIO="",ZTDTH=$H,LEXSET=""
 S ZTDESC="Re-Index file "_LEXFI_", Set Logic Only"
 S:$D(LEXINS) ZTSAVE("LEXINS")=""
 S ZTSAVE("DUZ")="",ZTSAVE("LEXFI")="",ZTSAVE("LEXQ")=""
 S ZTSAVE("LEXSET")="" D ^%ZTLOAD I +($G(ZTSK))>0&('$D(LEXINS)) D
 . W !," Re-Index file "_LEXFI_", Set Logic Only (Task #"
 . W +($G(ZTSK)),")"
 D HOME^%ZIS K ZTDESC,ZTDTH,ZTIO,ZTRTN
 W:+($G(ZTSK))>0&('$D(LEXINS)) ! H:+($G(ZTSK))>0&('$D(LEXINS)) 1 K ZTSK
 Q
FIX ; Fix File and Execure Set Logic Only
 Q:+($G(LEXFI))'>0  S LEXFI=+($G(LEXFI))
 Q:'$D(^LEX(LEXFI))&('$D(^LEXT(LEXFI)))
 Q:"^757.001^757.21^757.33^"'[("^"_LEXFI_"^")
 N Y,ZTQUEUED,ZTREQ,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,LEXI,LEXU
 N LEXC,LEXL,LEXENV,LEXTY,LEXUTY,LEXTSK,LEXMSG,LEXFN,LEXSUBJ,LEXNAM
 N LEXQ,LEXSET,LEXFIX S LEXNAM="LEXRXFIX" S LEXENV=$$ENV^LEXRXXM
 Q:+LEXENV'>0  S LEXQ="",ZTRTN="FIX^LEXRXXT2",ZTIO="",ZTDTH=$H
 S ZTDESC="Re-Index file "_LEXFI_", Set Logic Only"
 S (LEXSET,LEXFIX)="" S:$D(LEXINS) ZTSAVE("LEXINS")=""
 S ZTSAVE("DUZ")="",ZTSAVE("LEXFI")="",ZTSAVE("LEXQ")=""
 S ZTSAVE("LEXNAM")="",ZTSAVE("LEXSET")="",ZTSAVE("LEXFIX")=""
 D ^%ZTLOAD I +($G(ZTSK))>0&('$D(LEXINS)) D
 . W !," Fix/Re-Index file "_LEXFI_", Set Logic Only (Task #"
 . W +($G(ZTSK)),")"
 D HOME^%ZIS K ZTDESC,ZTDTH,ZTIO,ZTRTN
 W:+($G(ZTSK))>0&('$D(LEXINS)) ! H:+($G(ZTSK))>0&('$D(LEXINS)) 1 K ZTSK
 Q
 ;              
 ; Miscellaneous
PROG(X) ;   Progress
 N LEXNAME S LEXNAM=$G(X)  Q:'$L(LEXNAM)  Q:'$D(^XTMP(LEXNAM,0))
 N LEXBEG,LEXBEGE,LEXBEGD,LEXUPD,LEXUPDE,LEXUPDD,LEXDES,LEXACT,LEXCUR
 N LEXTSK,LEXNOW,LEXND S LEXNOW=$$NOW^XLFDT,LEXND=$G(^XTMP(LEXNAM,0))
 S LEXBEG=$P(LEXND,"^",3),LEXDES=$P(LEXND,"^",4)
 S LEXTSK=$G(^XTMP(LEXNAM,1)),LEXND=$G(^XTMP(LEXNAM,2))
 S LEXUPD=$P(LEXND,"^",1),LEXACT=$P(LEXND,"^",2)
 S LEXBEGE=$$ED^LEXRXXM(LEXBEG),LEXUPDE=$$ED^LEXRXXM(LEXUPD)
 S LEXBEGD=$$FMDIFF^XLFDT(LEXNOW,LEXBEG,3)
 S LEXUPDD=$$FMDIFF^XLFDT(LEXNOW,LEXBEG,3)
 S:$E(LEXBEGD,1)=" "&($E(LEXBEGD,3)=":") LEXBEGD=$TR(LEXBEGD," ","0")
 S:$E(LEXUPDD,1)=" "&($E(LEXUPDD,3)=":") LEXUPDD=$TR(LEXUPDD," ","0")
 W !!," Repair/Re-Index is in progress "
 I $L(LEXBEGE),$L(LEXDES) W !,?4,LEXDES,?49,"Started:  ",LEXBEGE
 I $L(LEXUPDE),$L(LEXACT) W !,?5,LEXACT,?49,"Current:  ",LEXUPDE
 I $L(LEXBEGD) W !,?49,"Running:  ",LEXBEGD
 Q
CLR ;   Clear
 K LEXAMSO,LEXFI,LEXINS,LEXOK
 Q
