TIUSUPN ;;SLC/TT - TIU SIGNED/UNSIGNED List Manager ; 04-FEB-2005
 ;;1.0;TEXT INTEGRATION UTILITIES;**180**;Jun 20, 1997
 ;
 Q
EN ; -- main entry point for TIU SIGNED/UNSIGNED PN
 N TIUSDT,TIUEDT
 W @IOF
 K ^TMP("TIUPS180",$J),^TMP("TIUSEL",$J),^TMP("VALMAR",$J),^TMP("TIU180",$J)
 I '$$ASKRNG(.TIUSDT,.TIUEDT) Q
 D EN^VALM("TIU SIGNED/UNSIGNED")
 Q
 ;
HDR ; -- header code
 N HDR1,HDR2
 S HDR1="From "_$$FMTE^XLFDT(TIUSDT)_" to "_$$FMTE^XLFDT(TIUEDT,"D")
 S HDR2=$P(^TMP("TIU180",$J,"TOTAL"),U)_" "_$S($P(^TMP("TIU180",$J,"TOTAL"),U)=0:"Document",$P(^TMP("TIU180",$J,"TOTAL"),U)=1:"Document",1:"Documents")
 S VALMHDR(1)=$$SETSTR^VALM1(HDR1,"",(IOM-$L(HDR1))/2,$L(HDR1))
 S VALMHDR(2)=$$SETSTR^VALM1(HDR2,"",(IOM-$L(HDR2))/2,$L(HDR2))
 D XQORM
 Q
 ;
INIT ; Create list
 N TIUDATE,TIUDA,TIUIEN,TIUTM,TIUCNT,TIUDP,TIUNO,TIUTOTAL
 I '$G(TIUSDT)!'($G(TIUEDT)) Q
 S TIUDATE=TIUSDT,(TIUCNT,VALMCNT,TIUTOTAL)=0
 W !!,"Searching for the documents."
 S TIUTM("STR")=$$NOW^XLFDT
 F  S TIUDATE=$O(^TIU(8925,"F",TIUDATE)) Q:'TIUDATE!(TIUDATE>TIUEDT)  D
 .S TIUIEN=$O(^TIU(8925,"F",TIUDATE,0)),TIUCNT=TIUCNT+1 D GETINFO(TIUIEN)
 .W:TIUCNT#1000'>0 "."
 ;
 S TIUDA="" F  S TIUDA=$O(^TMP("TIUPS180",$J,TIUDA)) Q:TIUDA=""  D
 .S TIUTOTAL=+$G(TIUTOTAL)+1
 .S TIUDP=$$SETSTR^VALM1(TIUTOTAL,"",1,5)
 .S TIUDP=$$SETSTR^VALM1($P($$GET1^DIQ(8925,TIUDA,.02),",")_","_$E($P($$GET1^DIQ(8925,TIUDA,.02),",",2),1),TIUDP,6,18)
 .S TIUDP=$$SETSTR^VALM1("("_$$PATFMAT($P(^TIU(8925,TIUDA,0),U,2))_")",TIUDP,19,26)
 .S TIUDP=$$SETSTR^VALM1(TIUDA,TIUDP,28,36)
 .S TIUDP=$$SETSTR^VALM1($E($$GET1^DIQ(8925,TIUDA,1502),1,19),TIUDP,38,56)
 .S TIUDP=$$SETSTR^VALM1($P($$FMTE^XLFDT($P(^TIU(8925,TIUDA,12),U),2),"@"),TIUDP,58,68)
 .S TIUDP=$$SETSTR^VALM1($$GET1^DIQ(8925,TIUDA,.05),TIUDP,70,100)
 .D SET^VALM10(TIUTOTAL,TIUDP,TIUDA)
 S (VALMCNT,^TMP("TIU180",$J,"TOTAL"))=+$G(TIUTOTAL)
 I +$G(TIUTOTAL)'>0 D
 .S VALMCNT=1
 .D SET^VALM10(1," ",0)
 .S TIUNO="No records found to satisfy search criteria."
 .S TIUNO=$$SETSTR^VALM1(TIUNO,"",(IOM-$L(TIUNO))/2,$L(TIUNO))
 .D SET^VALM10(2,TIUNO,0)
 S TIUTM("END")=$$NOW^XLFDT
 W !!,"Report started:   ",$P($$FMTE^XLFDT(TIUTM("STR")),"@",2)
 W !,"Report finished:  ",$P($$FMTE^XLFDT(TIUTM("END")),"@",2)
 W !,"Total searched:   ",TIUCNT
 Q
 ;
GETINFO(TIUDA1) ;GET SIGNED DOCUMENT BUT UNSIGNED STATUS 
 ; Input  -- TIUDA1 TIU Document file (#8925) IEN
 ;
 N TIUD0,TIUD15
 I TIUDA1'>0 Q
 I '$D(^TIU(8925,TIUDA1,0))!('$D(^TIU(8925,TIUDA1,15))) Q
 S TIUD0=$G(^TIU(8925,TIUDA1,0)),TIUD15=$G(^TIU(8925,TIUDA1,15))
 I $P(TIUD0,U,5)=5,$P(TIUD15,U,1)>0 D
 .S ^TMP("TIUPS180",$J,TIUDA1)=""
 Q
 ;
HELP ; -- help code
 N DIR
 I X="?" S DIR("A")="Enter RETURN to continue or '^' to exit",DIR(0)="E"
 D FULL^VALM1
 W !!,"The following actions are available:"
 W !,"Browse Document  - View selected documents (if authorized)"
 W !,"Detailed Display   - View detailed display of selected documents (if authorized)"
 W !,"Update Document  - Update the status of selected documents"
 I $D(DIR("A")) D ^DIR
 S VALMBCK="R"
 Q
 ;
ASKRNG(TIUBEGDT,TIUENDT) ;Prompt for date range
 ; Input  -- None
 ; Output -- 1=Successful and 0=Failure
 ;           BEGDT Begin Date
 ;           ENDT  End Date
 N DIRUT,DTOUT,DUOUT,Y
 W !,"Please specify a date range:",!
 S TIUBEGDT=+$$READ^TIUU("DA^:DT:E","   Start Reference Date: ")
 I +$D(DIRUT)!(TIUBEGDT'>0) G ASKRNGQ
 S TIUENDT=+$$READ^TIUU("DA^"_TIUBEGDT_":DT:E","  Ending Reference Date: ")_"."_235959
 I +$D(DIRUT)!(TIUENDT'>0) G ASKRNGQ
 S Y=1
ASKRNGQ Q +$G(Y)
 ;
PATFMAT(TIUPAT) ; format patient as first letter of last name and last 4 SSN
 N TIUPATN,TIULAST4,TIUINIT
 I 'TIUPAT Q ""
 S TIUPATN=$$EXTERNAL^DILFD(8925,.02,"",TIUPAT)
 S TIULAST4=$E($$GET1^DIQ(2,$G(TIUPAT),.09),6,9)
 S TIUINIT=$E($P(TIUPATN,","))
 Q TIUINIT_TIULAST4
 ;
EXIT ; -- exit code
 D XQORM
 Q
 ;
XQORM ; default action for list manager
 S XQORM("#")=$O(^ORD(101,"B","TIU SIGNED/UNSIGNED SELECT",0))_U_"1:"_VALMCNT
 Q
 ;
ACTIONS ; user selectable actions
 N ACTION
 D
 . N DIR,DIRUT,POP,X,Y
 . S DIR(0)="SA^1:Browse Document;2:Detailed Display;3:Status Update"
 . S DIR("A")="Select Action: "
 . S DIR("B")="Status Update"
 . S DIR("L",1)="1.   Browse Document"
 . S DIR("L",2)="2.   Detailed Display"
 . S DIR("L",3)="3.   Status Update"
 . S DIR("L",4)=""
 . S DIR("L")="Enter selection by typing the name, number, or abbreviation"
 . S DIR("?",1)="The following actions are available:"
 . S DIR("?",2)=""
 . S DIR("?",3)="Browse Document  - View selected documents (if authorized)"
 . S DIR("?",4)="Detailed Display   - Detailed View of selected documents (if authorized)"
 . S DIR("?",5)="Status Update  - Update the status of selected documents"
 . D ^DIR Q:$D(DIRUT) 
 . S ACTION=$S(+Y=1:"BROWSE^TIUSUPN1",+Y=2:"DISP^TIUSUPN1",+Y=3:"UPDTDOC^TIUSUPN1",Y=U:-1,1:-1)
 . Q:ACTION=-1
 . D @ACTION
 . S VALMBCK="R"
 Q
 ;
SELECT(ACTION) ; selects document(s) and calls ACTION
 N TIUDOCS,TIUSEL,TIUQUIT,TIUCNT,TIUDA
 D FULL^VALM1
 I $P(^TMP("TIU180",$J,"TOTAL"),U)=0 W !,"No documents to select." H 3 Q
 S TIUSEL=$P(XQORNOD(0),"=",2),TIUCNT=0
 I TIUSEL="" D  Q:$D(TIUQUIT)
 . N DIR,X,Y
 . S DIR("A")="Select Document(s)"
 . S DIR(0)="L^"_VALMBG_":"_VALMLST
 . D ^DIR I $D(DIRUT)!(Y=U) S TIUQUIT=1 Q
 . S TIUSEL=Y(0)
 F X=1:1  Q:$P(TIUSEL,",",X)=""  D
 . S TIUCNT=TIUCNT+1
 . S TIUDOCS($P(TIUSEL,",",X))=$O(@VALMAR@("IDX",$P(TIUSEL,",",X),""))
 . S ^TMP("TIUSEL",$J,TIUCNT)=$P(TIUSEL,",",X)
 I $D(TIUDOCS)'>1 S VALMBCK="R" Q
 D @ACTION
 Q
