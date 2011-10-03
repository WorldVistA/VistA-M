GMPLBLCK ;SLC/JFR - check selection list ICD9 codes; 3/20/03 09:05
 ;;2.0;Problem List;**28**;Aug 25, 1994
 ;
 ; This routine invokes IA #3990
 Q
CSVPEP ;called from protocol GMPL SELECTION LIST CSV EVENT
 N CAT,LN,LST,LIST,XMSUB,XMTEXT,XMDUZ,XMY
 D CKLISTS,CKCODES
 K ^TMP("GMPLMSG",$J)
 S LN=1
 I $D(^TMP("GMPLSL",$J,"I")) D
 . S ^TMP("GMPLMSG",$J,LN)="The following Problem Selection Lists contain one or more problems that",LN=LN+1
 . S ^TMP("GMPLMSG",$J,LN)="have inactive ICD-9 codes attached to them. Any current users or clinics using",LN=LN+1
 . S ^TMP("GMPLMSG",$J,LN)="these Selection Lists, will not be able to add the problems with inactive ",LN=LN+1
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
 . S ^TMP("GMPLMSG",$J,LN)="The following Problem Selection List categories contain problems with ICD9 ",LN=LN+1
 . S ^TMP("GMPLMSG",$J,LN)="codes that have a future inactivation date. These Categories should be updated",LN=LN+1
 . S ^TMP("GMPLMSG",$J,LN)="as soon as possible after the inactivation date to reduce the interruption of",LN=LN+1
 . S ^TMP("GMPLMSG",$J,LN)="use of the selection list(s) by users or clinics.",LN=LN+1
 . S ^TMP("GMPLMSG",$J,LN)="",LN=LN+1
 . S CAT=0
 . F  S CAT=$O(^TMP("GMPLSL",$J,"F",CAT)) Q:'CAT  D
 .. S ^TMP("GMPLMSG",$J,LN)=" Category name: "_$$GET1^DIQ(125.11,CAT,.01)
 .. S LN=LN+1
 .. S ^TMP("GMPLMSG",$J,LN)="",LN=LN+1
 .. S ^TMP("GMPLMSG",$J,LN)="    Problems with ICD9 codes due to be inactivated:",LN=LN+1
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
 N CAT,LN,LST,LIST,PAGE
 D CKLISTS,CKCODES
 S PAGE=1 D PAGE(.PAGE)
 I '$D(^TMP("GMPLSL",$J)) D  ; no problems found
 . W !,"No Problems Selection List corrections/review required"
 . I $E(IOST,1,2)="C-" D
 .. N DIR,DTOUT,DIRUT,DUOUT,X,Y
 .. S DIR(0)="E" D ^DIR
 . Q
 ;
 I $D(^TMP("GMPLSL",$J,"I")) D  ; some inactive problem codes
 . W !,"The following Problem Selection List(s) contain one or more problems that"
 . W !,"have inactive ICD-9 codes attached to them. Any current users or clinics using"
 . W !,"these Selection Lists, will not be able to add the problems with inactive "
 . W !,"codes, until the list and the inactive codes are updated. The list may not be"
 . W !,"assigned to any additional users or clinics until updated.",!
 . S LST=0
 . F  S LST=$O(^TMP("GMPLSL",$J,"I",LST)) Q:'LST!(PAGE<1)  D
 .. I IOSL-$Y<3 D PAGE(.PAGE) Q:'PAGE
 .. W !,"   "_^TMP("GMPLSL",$J,"I",LST)
 ;
 I $D(^TMP("GMPLSL",$J,"F")) D  ; future inact. dates
 . D PAGE(.PAGE) Q:'PAGE
 . W !,"The following Problem Selection List categories contain problems with ICD9 "
 . W !,"codes that have a future inactivation date. These Categories should be updated"
 . W !,"as soon as possible after the inactivation date to reduce the interruption of"
 . W !,"use of the selection list(s) by users or clinics.",!
 . S CAT=0
 . F  S CAT=$O(^TMP("GMPLSL",$J,"F",CAT)) Q:'CAT  D
 .. I IOSL-$Y<8 D PAGE(.PAGE) Q:'PAGE
 .. W !!!," Category name: "_$$GET1^DIQ(125.11,CAT,.01),!
 .. W !,"    Problems with ICD9 codes due to be inactivated:",!
 .. N PROB,TXT
 .. S PROB=0
 .. F  S PROB=$O(^TMP("GMPLSL",$J,"F",CAT,PROB)) Q:'PROB!(PAGE<1)  D
 ... S TXT=^TMP("GMPLSL",$J,"F",CAT,PROB)
 ... I IOSL-$Y<5 D PAGE(.PAGE) Q:'PAGE
 ... W !,"       Problem text: "_$P(TXT,U)
 ... W !,"       Display text: "_$P(TXT,U,2)
 ... W !,"               Code: "_$P(TXT,U,3)
 ... W !,"      Inactive Date: "_$P(TXT,U,4),!
 .. I '$D(^TMP("GMPLSL",$J,"F",CAT,"L")) Q  ; category not part of lists
 .. I IOSL-$Y<3 D PAGE(.PAGE) Q:'PAGE
 .. W !!,"    This Category is part of the following Problem Selection Lists:",!
 .. S LIST=0
 .. F  S LIST=$O(^TMP("GMPLSL",$J,"F",CAT,"L",LIST)) Q:'LIST!(PAGE<1)  D
 ... I IOSL-$Y<3 D PAGE(.PAGE) Q:'PAGE
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
 N LST
 S LST=0
 F  S LST=$O(^GMPL(125,LST)) Q:'LST  I '$$VALLIST^GMPLBLD2(LST) D
 . S ^TMP("GMPLSL",$J,"I",LST)=$P(^GMPL(125,LST,0),U)
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
 N PROB,CAT,LIST
 S PROB=0
 F  S PROB=$O(^GMPL(125.12,PROB)) Q:'PROB  I $L($P(^(PROB,0),U,5)) D
 . N PROB0,PROBTX,APIDATA,PROBCAT,ACTDT
 . S PROB0=^GMPL(125.12,PROB,0)
 . I '$$STATCHK^ICDAPIU($P(PROB0,U,5),DT) Q  ;already inactive
 . S APIDATA=$$HIST^ICDAPIU($P(PROB0,U,5),.APIDATA)
 . S ACTDT=+$O(APIDATA(DT))
 . Q:'ACTDT  ; no future activity
 . I $G(APIDATA(ACTDT)) Q  ; no future inactivation = OK
 . S PROBTX=$$GET1^DIQ(125.12,PROB,2)
 . S PROBCAT=$P(PROB0,U)
 . S ^TMP("GMPLSL",$J,"F",PROBCAT,PROB)=PROBTX_U_$P(PROB0,U,4)_U_$P(PROB0,U,5)_U_$$FMTE^XLFDT(ACTDT)
 . Q
 ;
 ; find lists that contain the categories
 S CAT=0
 F  S CAT=$O(^TMP("GMPLSL",$J,"F",CAT)) Q:'CAT  D
 . I '$D(^GMPL(125.1,"G",CAT)) Q  ; category not part of any lists
 . N LIST S LIST=0
 . F  S LIST=$O(^GMPL(125.1,"G",CAT,LIST)) Q:'LIST  D
 .. S ^TMP("GMPLSL",$J,"F",CAT,"L",LIST)=$$GET1^DIQ(125.1,LIST,.01)
 .. Q
 . Q
 Q
 ;
PAGE(NUM) ;print header and raise page number
 Q:'$G(NUM)
 I NUM'=1,$E(IOST,1,2)="C-" D  Q:'NUM
 . N DIR,DTOUT,DIRUT,DUOUT,X,Y
 . S DIR(0)="E" D ^DIR
 . I $D(DTOUT)!($D(DUOUT)) S NUM=0
 W @IOF
 W "Code Set Version review of Problem Selection Lists"
 W ?70,"Page: ",NUM
 W !,$$REPEAT^XLFSTR("-",78)
 S NUM=NUM+1
 Q
