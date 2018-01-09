GMPLBLCK ;SLC/JFR/TC - check selection list ICD codes ;07/06/17  12:01
 ;;2.0;Problem List;**28,42,49**;Aug 25, 1994;Build 43
 ;
 ; External References:
 ;   ICR  2056   $$GET1^DIQ
 ;   ICR  5747   $$CODECS^ICDEX,$$STATCHK^ICDEX,$$HIST^ICDEX
 ;   ICR  10026  ^DIR
 ;   ICR  10063  ^%ZTLOAD
 ;   ICR  10070  ^XMD
 ;   ICR  10086  %ZIS,HOME^%ZIS
 ;   ICR  10089  %ZISC
 ;   ICR  10103  $$DT^XLFDT,$$FMTE^XLFDT
 ;   ICR  10104  $$REPEAT^XLFSTR
 Q
CSVPEP ;called from protocol GMPL SELECTION LIST CSV EVENT
 N CAT,LN,LST,LIST,XMSUB,XMTEXT,XMDUZ,XMY
 D CKLISTS,CKCODES
 K ^TMP("GMPLMSG",$J)
 S LN=1
 I $D(^TMP("GMPLSL",$J,"I")) D
 . S ^TMP("GMPLMSG",$J,LN)="The following Problem Selection Lists contain one or more problems that have",LN=LN+1
 . S ^TMP("GMPLMSG",$J,LN)="inactive SNOMED and/or ICD codes attached to them. Any current users or clinics",LN=LN+1
 . S ^TMP("GMPLMSG",$J,LN)="using these Selection Lists, will not be able to add the problems with inactive",LN=LN+1
 . S ^TMP("GMPLMSG",$J,LN)="codes, until the list and the inactive codes are updated. The list may not be",LN=LN+1
 . S ^TMP("GMPLMSG",$J,LN)="assigned to any additional users or clinics until updated.",LN=LN+1
 . S LST=0
 . F  S LST=$O(^TMP("GMPLSL",$J,"I",LST)) Q:'LST  D
 .. S ^TMP("GMPLMSG",$J,LN)="   "_^TMP("GMPLSL",$J,"I",LST)
 .. S LN=LN+1
 ;
 I $D(^TMP("GMPLSL",$J,"F")) D  ;no future inact. dates
 . S ^TMP("GMPLMSG",$J,LN)="",LN=LN+1
 . S ^TMP("GMPLMSG",$J,LN)="",LN=LN+1
 . S ^TMP("GMPLMSG",$J,LN)="The following Problem Selection List categories contain problems with ICD",LN=LN+1
 . S ^TMP("GMPLMSG",$J,LN)="codes that have a future inactivation date. These Categories should be updated",LN=LN+1
 . S ^TMP("GMPLMSG",$J,LN)="as soon as possible after the inactivation date to reduce the interruption of",LN=LN+1
 . S ^TMP("GMPLMSG",$J,LN)="use of the selection list(s) by users or clinics.",LN=LN+1
 . S ^TMP("GMPLMSG",$J,LN)="",LN=LN+1
 . S CAT=0
 . F  S CAT=$O(^TMP("GMPLSL",$J,"F",CAT)) Q:'CAT  D
 .. S ^TMP("GMPLMSG",$J,LN)=" Category name: "_$$GET1^DIQ(125.11,CAT,.01)
 .. S LN=LN+1
 .. S ^TMP("GMPLMSG",$J,LN)="",LN=LN+1
 .. S ^TMP("GMPLMSG",$J,LN)="    Problems with ICD codes due to be inactivated:",LN=LN+1
 .. S ^TMP("GMPLMSG",$J,LN)="",LN=LN+1
 .. N PROB,TXT
 .. S PROB=0
 .. F  S PROB=$O(^TMP("GMPLSL",$J,"F",CAT,PROB)) Q:'PROB  D
 ... S TXT=^TMP("GMPLSL",$J,"F",CAT,PROB)
 ... S ^TMP("GMPLMSG",$J,LN)="       Problem text: "_$P(TXT,U),LN=LN+1
 ... S ^TMP("GMPLMSG",$J,LN)="       Display text: "_$P(TXT,U,2),LN=LN+1
 ... S ^TMP("GMPLMSG",$J,LN)="               Code: "_$P(TXT,U,3),LN=LN+1
 ... S ^TMP("GMPLMSG",$J,LN)="      Inactive Date: "_$$FMTE^XLFDT($P(TXT,U,4),2),LN=LN+1
 ... S ^TMP("GMPLMSG",$J,LN)="",LN=LN+1
 .. I '$D(^TMP("GMPLSL",$J,"F",CAT,"L")) Q  ; category not part of lists
 .. S ^TMP("GMPLMSG",$J,LN)="",LN=LN+1
 .. S ^TMP("GMPLMSG",$J,LN)="    This Category is part of the following Problem Selection Lists:",LN=LN+1
 .. S LIST=0
 .. F  S LIST=$O(^TMP("GMPLSL",$J,"F",CAT,"L",LIST)) Q:'LIST  D
 ... S ^TMP("GMPLMSG",$J,LN)="     "_^TMP("GMPLSL",$J,"F",CAT,"L",LIST)
 ... S LN=LN+1
 .. S ^TMP("GMPLMSG",$J,LN)="",LN=LN+1
 .. S ^TMP("GMPLMSG",$J,LN)="",LN=LN+1
 .. Q
 I '$D(^TMP("GMPLSL",$J)) D  ; no problems found
 . S ^TMP("GMPLMSG",$J,LN)="No Problems Selection List corrections/review required"
 . S LN=LN+1
 S XMY("G.GMPL CODE SET VERSION UPDATES")=""
 S XMSUB="Problem Selection List Code Set Version review"
 S XMDUZ="Code Set Version Install"
 S XMTEXT="^TMP(""GMPLMSG"",$J,"
 D ^XMD
 K ^TMP("GMPLSL",$J),^TMP("GMPLMSG",$J)
 Q
 ;
CSVOPT ; called from option GMPL SELECTION LIST CSV CHECK
 ;
 N %ZIS,POP
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  D ^%ZISC,HOME^%ZIS Q
 . N ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSK
 . S ZTDESC="Review of GMPL SEL LISTS for CSV"
 . S ZTRTN="QUEUE^GMPLBLCK",ZTIO=ION,ZTDTH=$H
 . D ^%ZTLOAD
 . I '$G(ZTSK) W !,"Unable to task report"
 . Q
 ;
QUEUE ; entry point for tasked report
 I $D(ZTQUEUED) S ZTREQ="@"
 U IO
 N CAT,LN,GMPLST,LIST,PAGE,GMPLCAT,GMPLI,GMPLTITL
 D CKLISTS,CKCODES
 S GMPLTITL="Code Set Version Review of Problem Selection Lists"
 S PAGE=1 D PAGE^GMPLSLRP(.PAGE,GMPLTITL)
 I '$D(^TMP("GMPLSL",$J)) D  ; no problems found
 . W !,"No Problems Selection List corrections/review required"
 . I $E(IOST,1,2)="C-" D
 .. N DIR,DTOUT,DIRUT,DUOUT,X,Y
 .. S DIR(0)="E" D ^DIR
 . Q
 ;
 I $D(^TMP("GMPLSL",$J,"I")) D  ; some inactive problem codes
 . W !,"The following Problem Selection List(s) contain one or more problems that have"
 . W !,"inactive SNOMED and/or ICD codes attached to them. Any current users or clinics"
 . W !,"using these Selection Lists, will not be able to add the problems with inactive"
 . W !,"codes, until the list and the inactive codes are updated. The list may not be"
 . W !,"assigned to any additional users or clinics until updated.",!
 . S (GMPLST,GMPLCAT,GMPLI)=0
 . F  S GMPLST=$O(^TMP("GMPLSL",$J,"I",GMPLST)) Q:GMPLST=""!(PAGE<1)  D
 . . W !!," "_GMPLST_":"
 . . F  S GMPLCAT=$O(^TMP("GMPLSL",$J,"I",GMPLST,GMPLCAT)) Q:GMPLCAT=""!(PAGE<1)  D
 . . . W !,"   "_GMPLCAT_":"
 . . . F  S GMPLI=$O(^TMP("GMPLSL",$J,"I",GMPLST,GMPLCAT,GMPLI)) Q:GMPLI=""!(PAGE<1)  D
 . . . . I IOSL-$Y<3 D PAGE^GMPLSLRP(.PAGE,GMPLTITL) Q:'PAGE
 . . . . N GMPLREC,GMPLDTXT,GMPLICD,GMPLCSYS,GMPLPROB,GMPLTEXT,GMPLK
 . . . . S GMPLREC=$G(^TMP("GMPLSL",$J,"I",GMPLST,GMPLCAT,GMPLI)),GMPLK=0
 . . . . S GMPLDTXT=$P(GMPLREC,U),GMPLICD=$P(GMPLREC,U,2),GMPLCSYS=$P(GMPLREC,U,3)
 . . . . S GMPLPROB="     "_GMPLDTXT_" "_GMPLICD_"   <INACTIVE "_GMPLCSYS_" CODE>"
 . . . . D WRAP^GMPLX(GMPLPROB,79,.GMPLTEXT)
 . . . . F  S GMPLK=$O(GMPLTEXT(GMPLK)) Q:GMPLK=""  D
 . . . . . W !,$S(GMPLK>1:"     "_GMPLTEXT(GMPLK),1:GMPLTEXT(GMPLK))
 ;
 I $D(^TMP("GMPLSL",$J,"F")) D  ; future inact. dates
 . D PAGE^GMPLSLRP(.PAGE,GMPLTITL) Q:'PAGE
 . W !,"The following Problem Selection List categories contain problems with ICD"
 . W !,"codes that have a future inactivation date. These Categories should be updated"
 . W !,"as soon as possible after the inactivation date to reduce the interruption of"
 . W !,"use of the selection list(s) by users or clinics.",!
 . S CAT=0
 . F  S CAT=$O(^TMP("GMPLSL",$J,"F",CAT)) Q:'CAT  D
 .. I IOSL-$Y<8 D PAGE^GMPLSLRP(.PAGE,GMPLTITL) Q:'PAGE
 .. W !!!," Category name: "_$$GET1^DIQ(125.11,CAT,.01),!
 .. W !,"    Problems with ICD codes due to be inactivated:",!
 .. N PROB,TXT
 .. S PROB=0
 .. F  S PROB=$O(^TMP("GMPLSL",$J,"F",CAT,PROB)) Q:'PROB!(PAGE<1)  D
 ... S TXT=^TMP("GMPLSL",$J,"F",CAT,PROB)
 ... I IOSL-$Y<5 D PAGE^GMPLSLRP(.PAGE,GMPLTITL) Q:'PAGE
 ... W !,"       Problem text: "_$P(TXT,U)
 ... W !,"       Display text: "_$P(TXT,U,2)
 ... W !,"               Code: "_$P(TXT,U,3)
 ... W !,"      Inactive Date: "_$P(TXT,U,4),!
 .. I '$D(^TMP("GMPLSL",$J,"F",CAT,"L")) Q  ; category not part of lists
 .. I IOSL-$Y<3 D PAGE^GMPLSLRP(.PAGE,GMPLTITL) Q:'PAGE
 .. W !!,"    This Category is part of the following Problem Selection Lists:",!
 .. S LIST=0
 .. F  S LIST=$O(^TMP("GMPLSL",$J,"F",CAT,"L",LIST)) Q:'LIST!(PAGE<1)  D
 ... I IOSL-$Y<3 D PAGE^GMPLSLRP(.PAGE,GMPLTITL) Q:'PAGE
 ... W !,"     "_^TMP("GMPLSL",$J,"F",CAT,"L",LIST)
 .. Q
 . Q
 D:$E(IOST,1,2)'="C-" ^%ZISC
 D HOME^%ZIS
 K ^TMP("GMPLSL",$J)
 Q
 ;
CKLISTS ; loop lists and see if any inactive problems
 ;
 ; returns ^TMP("GMPLSL",$J,"I"
 ;
 K ^TMP("GMPLSL",$J,"I")
 N LST,GMPLCNME,GMPLSEQ,GMPLREC,GMPLCNT
 S (LST,GMPLCNME,GMPLSEQ)=0
 F  S LST=$O(^GMPL(125,LST)) Q:'LST  D
 . N GMPLCLST
 . I '$$VALLIST^GMPLBLD2(LST,"GMPLCLST") D
 . . S GMPLCNT=0
 . . I $D(GMPLCLST) D
 . . . F  S GMPLCNME=$O(GMPLCLST(GMPLCNME)) Q:GMPLCNME=""  D
 . . . . F  S GMPLSEQ=$O(GMPLCLST(GMPLCNME,GMPLSEQ)) Q:GMPLSEQ=""  D
 . . . . . S GMPLREC=GMPLCLST(GMPLCNME,GMPLSEQ),GMPLCNT=GMPLCNT+1
 . . . . . S ^TMP("GMPLSL",$J,"I",$P(^GMPL(125,LST,0),U),GMPLCNME,GMPLCNT)=$P(GMPLREC,U)_U_$P(GMPLREC,U,2)_U_$P(GMPLREC,U,3)
 . Q
 Q
 ;
CKCODES ; check probs on lists for future inactivation dates
 ;
 ; returns:
 ;   ^TMP("GMPLSL",$J,"F",category,problem)
 ;   ^TMP("GMPLSL",$J,"F",category,"L",list)
 ;
 K ^TMP("GMPLSL",$J,"F")
 N CAT,LIST,GMPCAT,GMPPSQ,GMPDA,GMPDT
 S (GMPCAT,GMPPSQ,GMPDA)=0,GMPDT=$$DT^XLFDT
 F  S GMPCAT=$O(^GMPL(125.11,"C",GMPCAT)) Q:'GMPCAT  D
 . F  S GMPPSQ=$O(^GMPL(125.11,"C",GMPCAT,GMPPSQ)) Q:'GMPPSQ  D
 . . F  S GMPDA=$O(^GMPL(125.11,"C",GMPCAT,GMPPSQ,GMPDA)) Q:'GMPDA  D
 . . . I $L($P(^GMPL(125.11,GMPCAT,1,GMPDA,0),U,4)) D
 . . . . N GMPL0,GMPPROB,GMPARY,GMPADT,GMPCSPTR,GMPICD
 . . . . S GMPL0=$G(^GMPL(125.11,GMPCAT,1,GMPDA,0)),GMPICD=$P(GMPL0,U,4)
 . . . . S GMPCSPTR=+$$CODECS^ICDEX(GMPICD,80,GMPDT)
 . . . . I '$$STATCHK^ICDEX(GMPICD,GMPDT,GMPCSPTR) Q  ;already inactive
 . . . . S GMPARY=$$HIST^ICDEX(GMPICD,.GMPARY,GMPCSPTR)
 . . . . S GMPADT=+$O(GMPARY(GMPDT))
 . . . . Q:'GMPADT  ; no future activity
 . . . . I $G(GMPARY(GMPADT)) Q  ; no future inactivation = OK
 . . . . S GMPPROB=$$GET1^DIQ(125.111,""_GMPDA_","_GMPCAT_",",.01)
 . . . . S ^TMP("GMPLSL",$J,"F",GMPCAT,GMPDA)=GMPPROB_U_$P(GMPL0,U,3)_U_GMPICD_U_$$FMTE^XLFDT(GMPADT)
 . . . . Q
 ;
 ; find lists that contain the categories
 S CAT=0
 F  S CAT=$O(^TMP("GMPLSL",$J,"F",CAT)) Q:'CAT  D
 . I '$D(^GMPL(125,"AC",CAT)) Q  ; category not part of any lists
 . N LIST S LIST=0
 . F  S LIST=$O(^GMPL(125,"AC",CAT,LIST)) Q:'LIST  D
 .. S ^TMP("GMPLSL",$J,"F",CAT,"L",LIST)=$$GET1^DIQ(125,LIST,.01)
 .. Q
 . Q
 Q
