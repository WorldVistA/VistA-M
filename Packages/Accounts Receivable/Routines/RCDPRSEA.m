RCDPRSEA ;WISC/RFJ,PJH,hrub - extended search ;4 Feb 2019 09:24:27
 ;;4.5;Accounts Receivable;**114,148,208,269,304,332,345**;Mar 20, 1995;Build 34
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; enter at top for [RCDP EXTENDED CHECK/CC SEARCH] option
 N DATEEND,DATESTRT,RCDUP,RCPAYTYP,RCRPRT,RCRTRN,RCSRCH,RCTRGT,X,Y
 ;
 ; search check, credit card, trace #, or All
 W !!,"Extended AR BATCH PAYMENT file search.",!
 S RCSRCH=$$ASKSEA I RCSRCH<1 Q
 ;
 S RCTRGT("Any#")=U F X=1,2,3 S RCTRGT($$SBSCRPT(X))=U  ; initialize all search targets
 ; check # to search for
 I RCSRCH=1 S RCTRGT("Check#")=$$ASKCHEK^RCDPLPL1 I RCTRGT("Check#")=-1 Q
 ; credit card to search for
 I RCSRCH=2 S RCTRGT("CredCard")=$$ASKCRED^RCDPLPL1 I RCTRGT("CredCard")=-1 Q
 ; trace # to search for
 I RCSRCH=3 S RCTRGT("Trace#")=$$ASKTRACE^RCDPLPL1 I RCTRGT("Trace#")=-1 Q
 I RCSRCH=4 D  I RCTRGT("Any#")=U Q
 . S RCTRGT("Any#")=$$ASK4ALL Q:RCTRGT("Any#")=U
 . S (RCTRGT("Check#"),RCTRGT("CredCard"),RCTRGT("Trace#"))=RCTRGT("Any#")  ; for all 3 types of search
 ; ask contains or equals
 S RCSRCH("type")=$$ASKTYPE^RCDPLPL1 I RCSRCH("type")=-1 Q
 S RCSRCH("type")=$E(RCSRCH("type"))  ; will be "E" or "C"
 S RCDUP=0
 I (RCSRCH=3!(RCSRCH=4))&($L($G(RCTRGT("Trace#")))>44) D  I RCDUP=-1 Q
 . S RCDUP=$$ASKDUP()
 ;
 ; ask receipt open dates
 W ! D DATESEL^RCRJRTRA("RECEIPT Opened")
 I '$G(DATESTRT)!('$G(DATEEND)) Q
 ;
 F X=1,2,3 S RCTRGT($$SBSCRPT(X))=$$UP(RCTRGT($$SBSCRPT(X))) ; case-insensitive search
 S RCSRCH("FromDt")=DATESTRT\1,RCSRCH("ToDt")=DATEEND\1  ; start/end dates without time
 S RCRPRT("HdrFrom")=$$FMTE^XLFDT(RCSRCH("FromDt")),RCRPRT("HdrTo")=$$FMTE^XLFDT(RCSRCH("ToDt"))
 ; select device
 W ! N %ZIS S %ZIS="Q" D ^%ZIS I POP Q
 I $D(IO("Q")) D  Q
 . N ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE,ZTSK
 . S ZTDESC="Extended Check/Trace#/Credit Card Search"
 . S ZTSAVE("RC*")="",ZTSAVE("ZTREQ")="@",ZTRTN="DQ^"_$T(+0)
 . D ^%ZTLOAD
 . W !!,$S($G(ZTSK):"Report queued as task #"_ZTSK,1:"Unable to queue this report.")
 . K IO("Q")
 ; from here on for interactive user only
 F  D  Q:RCSRCH("Exit")  ; loop here if no results found
 . D DQ I RCSRCH("Cntr")!RCSRCH("Exit") S RCSRCH("Exit")=1 Q  ; results returned or exit indicated
 . I RCSRCH=4 S RCSRCH("Exit")=1 Q  ; 'All' was selected, don't ask, exit
 . S RCSRCH("PrevType")=RCSRCH  ; save for user interaction
 . S RCSRCH("Exit")='$$ASK2CONT Q:RCSRCH("Exit")
 . F  D  Q:'$L(RCSRCH("PrevType"))!RCSRCH("Exit")
 ..  S RCSRCH("NewType")=$$ASKSEA I RCSRCH("NewType")<1 S RCSRCH("Exit")=1 Q
 ..  I RCSRCH("NewType")=RCSRCH("PrevType") D  Q
 ...   N DIR,DTOUT,DUOUT,X,Y
 ...   S DIR(0)="EA",DIR("A")="Press ENTER to continue, '^' to exit: "
 ...   S DIR("A",1)=" ",DIR("A",2)="That was the previous search type."
 ...   S DIR("A",3)="Please select another type of search." D ^DIR
 ...   S RCSRCH("Exit")=$S(X[U!$D(DUOUT)!$D(DTOUT):1,1:0)
 ..  Q:RCSRCH("Exit")
 ..  F X=1,2,3 S RCTRGT($$SBSCRPT(X))=U  ; re-initialize all search targets
 ..  S RCSRCH=RCSRCH("NewType"),RCSRCH("PrevType")=""  ; set previous type to null to exit loop
 ..  S RCTRGT($$SBSCRPT(RCSRCH))=RCSRCH("PrevTrgt")
 ..  I RCSRCH=4 F X=1,2,3 S RCTRGT($$SBSCRPT(X))=RCSRCH("PrevTrgt")  ; if new search is ALL
 ;
 Q
 ;
DQ ; entry from TaskMan or from above
 N A,B,J,RCACCNT,RCBTCH,RCPAYTYP,RCTRANS,RCTRCNUM,RCXREFDT,X,Y
 ; print report
 S RCRPRT("HdrTime")=$$FMTE^XLFDT($$NOW^XLFDT)  ; NOW in external format
 S RCRPRT("HdrPage#")=1,RCSRCH("Exit")=0,RCSRCH("Cntr")=0  ; page number, exit flag, found count
 ; save target for additional searches
 S RCSRCH("PrevTrgt")=RCTRGT($$SBSCRPT(RCSRCH))
 U IO D H
 S RCXREFDT=RCSRCH("ToDt")+.5  ; initialize to last date plus a fraction, "AO" index has time
 F  S RCXREFDT=$O(^RCY(344,"AO",RCXREFDT),-1) Q:'RCXREFDT!(RCXREFDT<RCSRCH("FromDt"))  D CHKTRANS(RCXREFDT)
 ;
 W:'$G(RCSRCH("Exit")) !!,"Total records found: "_$FN(RCSRCH("Cntr"),",")
 I '($E(IOST,1,2)="C-")!$G(ZTSK) S RCSRCH("Exit")=1  ; continue only if interactive user
 U IO(0) D ^%ZISC
 Q:RCSRCH("Exit")
 D  ; ask user to press ENTER if no '^'
 . N DIR S DIR(0)="EA",DIR("A")="Search Finished. Press ENTER to continue: ",DIR("A",1)=" " D ^DIR
 Q
 ;
CHKTRANS(RCXREFDT) ; check TRANSACTION multiple on date RCXREFDT
 S RCBTCH=0  ; IEN in AR BATCH PAYMENT file (#344)
 F  S RCBTCH=$O(^RCY(344,"AO",RCXREFDT,RCBTCH)) Q:'RCBTCH!($G(RCSRCH("Exit")))  D
 . S RCBTCH(0)=$G(^RCY(344,RCBTCH,0))
 . S RCTRANS=0  ; ^RCY(344,D0,1,0)=^344.01AI^^  (#1) TRANSACTION
 . F  S RCTRANS=$O(^RCY(344,RCBTCH,1,RCTRANS)) Q:'RCTRANS!($G(RCSRCH("Exit")))  D
 ..  I $E(IOST,1,2)="C-" R X:0 I X[U S RCSRCH("Exit")=1 Q  ; exit if user types '^' during search
 ..  S RCTRANS(0)=$G(^RCY(344,RCBTCH,1,RCTRANS,0))
 ..  ;  check # search
 ..  I RCSRCH=1!(RCSRCH=4) D  Q:RCSRCH<4
 ...   S X=$P(RCTRANS(0),U,7) Q:X=""
 ...   I RCSRCH("type")="E" Q:$$UP(X)'=RCTRGT("Check#")  ;equals
 ...   I $$UP(X)'[RCTRGT("Check#") Q                     ;contains
 ...   D DISPLAY(1,X) S RCSRCH("Cntr")=RCSRCH("Cntr")+1
 ..  ;  trace # search
 ..  I RCSRCH=3!(RCSRCH=4) D  Q:RCSRCH<4
 ...   S RCTRCNUM=$$UP($$TRACE(RCBTCH(0))) Q:RCTRCNUM=""
 ...   I '$$CHKTRACE(RCSRCH("type"),RCTRCNUM,RCTRGT("Trace#"),RCDUP) Q
 ...   D DISPLAY(3,RCTRCNUM) S RCSRCH("Cntr")=RCSRCH("Cntr")+1
 ..  ; fall through to credit card # search
 ..  Q:'((RCSRCH=2)!(RCSRCH=4))
 ..  S X=$P(RCTRANS(0),U,11) Q:X=""
 ..  I RCSRCH("type")="E" Q:X'=RCTRGT("CredCard")  ;equals
 ..  I X'[RCTRGT("CredCard") Q                     ;contains
 ..  D DISPLAY(2,X) S RCSRCH("Cntr")=RCSRCH("Cntr")+1
 ;
 Q
 ;
DISPLAY(RCPAYTYP,RCITMFND) ;  display the payment
 ; RCPAYTYP - 1:check #, 2: credit card, 3:trace #
 ; RCITMFND - value found
 Q:$G(RCSRCH("Exit"))  ; exit flag
 ; handle display to screen
 I $E(IOST,1,2)="C-",$Y>(IOSL-6) D  Q:RCSRCH("Exit")
 . S RCSRCH("Exit")=0
 . N DIR,X,Y
 . S DIR(0)="EA",DIR("A")="Press ENTER to continue, '^' to exit: " D ^DIR
 . S RCSRCH("Exit")=$S(X[U!$D(DUOUT)!$D(DTOUT):1,1:0)
 . Q:RCSRCH("Exit")  ; user indicated to stop
 . D H
 ; next line for non-interactive device
 I '($E(IOST,1,2)="C-"),$Y>(IOSL-2) D H
 ; receipt
 S J=$P(RCBTCH(0),U),A=$P(RCBTCH(0),U,3)  ; A is the date opened
 S J=J_$J(" ",15-$L(J))_$E(A,4,5)_"/"_$E(A,6,7)_"/"_$E(A,2,3)  ; format date opened
 S J=J_$J(" ",27-$L(J))_RCTRANS  ; add transaction number
 ; account
 S RCACCNT("Pntr")=$P(RCTRANS(0),U,3),RCACCNT=" -"
 I RCACCNT("Pntr")["PRCA(430," S RCACCNT=$P($G(^PRCA(430,+RCACCNT("Pntr"),0)),U)
 I RCACCNT("Pntr")["DPT(" S RCACCNT=$P($G(^DPT(+RCACCNT("Pntr"),0)),U)
 S J=J_$J(" ",31-$L(J))_RCACCNT  ; add account
 S J=J_$J(" ",55-$L(J))_"$"_$J($P(RCTRANS(0),U,4),8,2)  ; add amount
 W !,J
 ;  check/trace/credit card number
 S J=RCITMFND
 ; if search all types, indicate what was found
 I RCSRCH=4 S J=J_"   ("_$S(RCPAYTYP=1:"Check #",RCPAYTYP=2:"Credit Card",1:"Trace #")_")"
 W !,"   "_J
 Q
 ;
H ;  header
 S A=RCRPRT("HdrTime")_" Page: "_RCRPRT("HdrPage#"),RCRPRT("HdrPage#")=RCRPRT("HdrPage#")+1
 S B="Extended Check #/Trace #/Credit Card Search",$E(B,80-$L(A)+1,80)=A
 W @IOF,B
 W !,"  For the Date Range: "_RCRPRT("HdrFrom")_"  to  "_RCRPRT("HdrTo")
 S B="       Searching for: "_$S(RCSRCH=1:"CHECK ",RCSRCH=2:"CREDIT CARD ",RCSRCH=3:"TRACE # ",1:"ALL TYPES")
 S B=B_$S(RCSRCH("type")="E":" EQUAL",1:" CONTAIN")_$S(RCSRCH<4:"S",1:"ING")_" " ; handle plurals
 S B=B_$C(34)_RCTRGT($$SBSCRPT(RCSRCH))_$C(34)
 W !,B
 W !,"Receipt       Open Date  Trans  Account                   Amount"
 W !,"   "_$S(RCSRCH=1:"Check #",RCSRCH=2:"Credit Card #",RCSRCH=3:"Trace #",1:"Any #")
 W !,$TR($J(" ",80)," ","=")  ; 80 equal signs
 Q
 ;
TRACE(RC344ZRO) ; Return trace # for receipt, RC344ZRO - zero node from file #344
 N P
 S P=+$P(RC344ZRO,U,18) I P Q $P($G(^RCY(344.4,P,0)),U,2)  ; (#.18) ERA REFERENCE [18P:344.4] > 344.4,(#.02) TRACE NUMBER [2F]
 S P=+$P(RC344ZRO,U,17) I P Q $P($G(^RCY(344.31,P,0)),U,4)  ; (#.17) EFT RECORD [17P:344.31] > 344.31,(#.04) TRACE # [4F]
 Q ""  ; no trace # found
 ;
ASKSEA() ;  ask search field
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SAO^1:Check;2:Credit Card;3:Trace #;4:All"
 S DIR("A")="Search for Check, Trace, Credit Card #, or All: "
 S DIR("B")="All"
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q Y
 ;
ASK4ALL() ; Ask the ePayments trace value for ALL types, returns '^' on null or timeout
 N DIR,X,Y
 S DIR(0)="FAO^3:50"
 S DIR("A",1)="Enter the check, credit card, or trace number to Search for"
  S DIR("A")="in All types: "
 S DIR("?")="Enter a search number, 3 to 50 characters free text."
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=U
 Q $S(Y'="":$$UP(Y),1:U)
 ;
ASK2CONT() ; Boolean function, ask user if they want to search again
 ; returns 1 if user wants a new search, else zero
 N DIR,DTOUT,DUOUT,X,Y
 S RCRTRN=0,DIR(0)="YA",DIR("A")="Would you like to perform another search? "
 S DIR("A",1)=" "
 S DIR("A",2)="You can search for "_$C(34)_RCTRGT($$SBSCRPT(RCSRCH("PrevType")))_$C(34)_" in another kind of search."
 S DIR("A",3)=" "
 S DIR("?")="Enter 'YES' to search again using the same ePayments values.",DIR("B")="NO"
 D ^DIR
 Q $S(X[U!$D(DUOUT)!$D(DTOUT)!'Y:0,1:1)
 ;
ASKDUP() ; Boolean function, ask user if they wish to include trace numbers ending in "-DUPn"
 ; returns 1 if user wants to include duplicate trace#, else zero
 N DIR,DTOUT,DUOUT,X,Y
 S RCRTRN=0,DIR(0)="YA",DIR("A")="Include Duplicate Trace#s: "
 S DIR("A",1)="If a trace number is greater than 45 characters and a duplicated ERA is"
 S DIR("A",2)="received, the trace number may be shortened, so that -DUP can be added"
 S DIR("A",3)="to the end.  Answering yes, will cause these trace numbers to be included"
 S DIR("A",4)="in the search results."
 S DIR("A",5)=" "
 S DIR("?")="Enter 'YES' to include duplicate trace numbers.",DIR("B")="NO" D ^DIR
 Q $S(X[U!$D(DUOUT)!$D(DTOUT):-1,1:+Y)
 ;
CHKTRACE(TYPE,TRACE,TARGET,DUP) ; Check if Trace# is a match
 ; Input: TYPE - Type of search E=equals, C=CONTAINS
 ;        TRACE - TRACE# from receipt
 ;        TARGET - String user is searching for
 ;        DUP - 1 - include duplicates, otherwise 0.
 ; Output: 1 - trace number matches the target, otherwise 0.
 ;
 N FOUND,X
 I TYPE="E",TRACE=TARGET Q 1 ;equals
 I TYPE="C",TRACE[TARGET Q 1 ;contains
 I RCDUP S FOUND=0 D  I FOUND Q 1 ; Include duplicates
 . I TRACE'["-DUP" Q  ; not a duplicate
 . S X=$P(TRACE,"-DUP",1)
 . I TYPE="E",X=$E(TARGET,1,$L(X)) S FOUND=1
 . I TYPE="C",X[$E(TARGET,1,$L(X)) S FOUND=1
 Q 0
 ;
 ; return subscript for search type, if type is 4 all search targets are the same
SBSCRPT(X) Q $S(X=1:"Check#",X=2:"CredCard",1:"Trace#")
 ; function, uppercase
UP(T) Q $TR(T,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
