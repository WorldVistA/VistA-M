PRCOER ;WISC/DJM-EDI REPORTS USING LIST MANAGER ; [10/20/98 11:58am]
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for PRCO EDI REPORTS
 ; First lets see if there is anything to report.  If not - exit.
 Q:$G(PRCOFLG)=-1
 N LIST,LIST1,LIST2,PO,PRCO
 S LIST=""
 S LIST=$O(^PRC(443.75,"AC",LIST))
 S LIST1=""
 S LIST1=$O(^PRC(443.75,"AF",LIST1))
 S LIST2=""
 S LIST2=$O(^PRC(443.75,"AO",LIST2))
 I LIST="",LIST1="",LIST2="" G NOTHING
 N X
 I '$D(IOF)!('$G(IOST(0))) S IOP="HOME" D ^%ZIS K IOP
 S X="IORVON;IORVOFF" D ENDR^%ZISS
 S PRCO("RV1")=$G(IORVON)
 S PRCO("RV0")=$G(IORVOFF)
 S PRCO("XY")="N DX,DY S (DX,DY)=0 "_$G(^%ZOSF("XY"))
 D EN^VALM("PRCO EDI REPORTS")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="EDI Transactions from IFCAP Reports"
 I SENDER>0 D
 . S NAME=$P($G(^VA(200,SENDER,0)),U)
 . S VALMHDR(1)=VALMHDR(1)_"     Sender is "_NAME
 . Q
 Q
 ;
INIT ; -- init variables and list array
 N COUNT,DATE,LINENO,LIST,LIST0,LIST1,LIST2,ERROR,REJECT,RFQ,TXT,TYPE,VENDOR,VENDOR1
 K ^PRC(443.75,"PRCOER",$J)
 S LIST=""
 S LIST=$O(^PRC(443.75,"AC",LIST))
 S LIST1=""
 S LIST1=$O(^PRC(443.75,"AF",LIST1))
 S LIST2=""
 S LIST2=$O(^PRC(443.75,"AO",LIST2))
 I LIST="",LIST1="",LIST2="" G NOTHING
 D CLEAN^VALM10
 S COUNT=0
 S LINENO=0
 G:SENDER>0 INIT0
 ;
 ;  First list all PROGRESS LEVEL 3 records.
 ;
 S LIST=""
 F  S LIST=$O(^PRC(443.75,"AM",3,LIST)) Q:LIST=""  D
 .  S LIST0=""
 .  F  S LIST0=$O(^PRC(443.75,"AM",3,LIST,LIST0),-1) Q:LIST0=""  D
 .  .  S LIST1=""
 .  .  F  S LIST1=$O(^PRC(443.75,"AM",3,LIST,LIST0,LIST1)) Q:LIST1=""  D
 .  .  .  S LIST2=$G(^PRC(443.75,LIST1,0))
 .  .  .  Q:LIST2=""
 .  .  .  D INIT1
 .  .  .  Q
 .  .  Q
 .  Q
 ;
 ;  Next list all PROGRESS LEVEL 2 records.
 ;
 S LIST=""
 F  S LIST=$O(^PRC(443.75,"AL",2,LIST)) Q:LIST=""  D
 .  S LIST0=""
 .  F  S LIST0=$O(^PRC(443.75,"AL",2,LIST,LIST0),-1) Q:LIST0=""  D
 .  .  S LIST1=""
 .  .  F  S LIST1=$O(^PRC(443.75,"AL",2,LIST,LIST0,LIST1)) Q:LIST1=""  D
 .  .  .  S LIST2=$G(^PRC(443.75,LIST1,0))
 .  .  .  Q:LIST2=""
 .  .  .  D INIT1
 .  .  .  Q
 .  .  Q
 .  Q
 ;
 ;  Last list all PROGRESS LEVEL 1 records.
 ;
 S LIST=""
 F  S LIST=$O(^PRC(443.75,"AJ",1,LIST)) Q:LIST=""  D
 .  S LIST0=""
 .  F  S LIST0=$O(^PRC(443.75,"AJ",1,LIST,LIST0),-1) Q:LIST0=""  D
 .  .  S LIST1=""
 .  .  F  S LIST1=$O(^PRC(443.75,"AJ",1,LIST,LIST0,LIST1)) Q:LIST1=""  D
 .  .  .  S LIST2=$G(^PRC(443.75,LIST1,0))
 .  .  .  Q:LIST2=""
 .  .  .  D INIT1
 .  .  .  Q
 .  .  Q
 .  Q
 ;
 ;  Now lets show the list to the users.
 ;
 S VALMCNT=COUNT
 Q
 ;
INIT0 ;  Come here if the user selected one sender to view.
 ;
 ;  First list all PROGRESS LEVEL 3 records for SENDER.
 ;
 S LIST=""
 F  S LIST=$O(^PRC(443.75,"AM1",3,SENDER,LIST)) Q:LIST=""  D
 .  S LIST0=""
 .  F  S LIST0=$O(^PRC(443.75,"AM1",3,SENDER,LIST,LIST0),-1) Q:LIST0=""  D
 .  .  S LIST1=""
 .  .  F  S LIST1=$O(^PRC(443.75,"AM1",3,SENDER,LIST,LIST0,LIST1)) Q:LIST1=""  D
 .  .  .  S LIST2=$G(^PRC(443.75,LIST1,0))
 .  .  .  Q:LIST2=""
 .  .  .  D INIT1
 .  .  .  Q
 .  .  Q
 .  Q
 ;
 ;  Next list all PROGRESS LEVEL 2 records for SENDER.
 ;
 S LIST=""
 F  S LIST=$O(^PRC(443.75,"AL1",2,SENDER,LIST)) Q:LIST=""  D
 .  S LIST0=""
 .  F  S LIST0=$O(^PRC(443.75,"AL1",2,SENDER,LIST,LIST0),-1) Q:LIST0=""  D
 .  .  S LIST1=""
 .  .  F  S LIST1=$O(^PRC(443.75,"AL1",2,SENDER,LIST,LIST0,LIST1)) Q:LIST1=""  D
 .  .  .  S LIST2=$G(^PRC(443.75,LIST1,0))
 .  .  .  Q:LIST2=""
 .  .  .  D INIT1
 .  .  .  Q
 .  .  Q
 .  Q
 ;
 ;  Last list all PROGRESS LEVEL 1 records for SENDER.
 ;
 S LIST=""
 F  S LIST=$O(^PRC(443.75,"AJ1",1,SENDER,LIST)) Q:LIST=""  D
 .  S LIST0=""
 .  F  S LIST0=$O(^PRC(443.75,"AJ1",1,SENDER,LIST,LIST0),-1) Q:LIST0=""  D
 .  .  S LIST1=""
 .  .  F  S LIST1=$O(^PRC(443.75,"AJ1",1,SENDER,LIST,LIST0,LIST1)) Q:LIST1=""  D
 .  .  .  S LIST2=$G(^PRC(443.75,LIST1,0))
 .  .  .  Q:LIST2=""
 .  .  .  D INIT1
 .  .  .  Q
 .  .  Q
 .  Q
 ;
 ;  Now lets show the list to the users.
 ;
 S VALMCNT=COUNT
 Q
 ;
INIT1 ;  ENTER DATA FROM THE RECORD CHOOSEN.
 ;
 S PO=$P(LIST2,U,2)
 S TXT=+$P(LIST2,U,3)
 S RFQ=+$P(LIST2,U,10)
 S RFQ=$S(RFQ=0:"O",1:"C")
 S TYPE=$P(LIST2,U,4)
 S TXT=$S(TYPE="TXT":TXT,TYPE="RFQ":RFQ,1:"")
 S VENDOR=$P(LIST2,U,6)
 S DATE=$P($P(LIST2,U,7),".",1)
 ;
 I TYPE="PHA" D
 . I '$D(^PRC(440,"AG",VENDOR)) S VENDOR="Not Found" Q
 . S VENDOR=$O(^PRC(440,"AG",VENDOR,""))
 . S VENDOR=$E($P($G(^PRC(440,VENDOR,0)),U),1,30)
 . I VENDOR']"" S VENDOR="Not Found"
 . Q
 ;
 I TYPE'="PHA" D
 . I VENDOR="PUBLIC" Q
 . S:$E(VENDOR,1,3)'="DUN" VENDOR="DUN"_VENDOR
 . S VENDOR1=$O(^PRC(440,"DB",VENDOR,""))
 . I VENDOR1>0 S VENDOR=$E($P($G(^PRC(440,VENDOR1,0)),U),1,30) Q
 . S VENDOR1=$O(^PRC(444.1,"DB",VENDOR,""))
 . I VENDOR1>0 S VENDOR=$E($P($G(^PRC(444.1,VENDOR1,0)),U),1,30) Q
 . I VENDOR']"" S VENDOR="Not Found"
 . Q
 ;
 S LIST2=$G(^PRC(443.75,LIST1,1))
 S REJECT=$P(LIST2,U,7)
 S ERROR=$P(LIST2,U,12)
 S:$P(LIST2,U,1)]"" TYPE=$P(LIST2,U,1)
 S:$P(LIST2,U,15)]"" TYPE=$P(LIST2,U,15)
 ;
 ; IN THE NEXT LINE THE $S DEFAULT - THE 1:PART AT THE END- WILL BE
 ; 'POA' IN THE TYPE VARIABLE.
 ;
 S DATE=$S(",PHA,RFQ,TXT,"[TYPE:DATE,",ACT,PRJ,"[TYPE:$P($P(LIST2,U,2),".",1),1:$P($P(LIST2,U,16),"."))
 S DATE=+$E(DATE,4,5)_"/"_+$E(DATE,6,7)_"/"_(+$E(DATE,1,3)+1700)
 S COUNT=COUNT+1
 S X=$$SETFLD^VALM1(COUNT,"","NUMBER")
 S X=$$SETFLD^VALM1(PO,X,"PO")
 S X=$$SETFLD^VALM1(TXT,X,"TXT/RFQ")
 S X=$$SETFLD^VALM1(TYPE,X,"TYPE")
 S X=$$SETFLD^VALM1(VENDOR,X,"VENDOR")
 S X=$$SETFLD^VALM1(REJECT,X,"REJECT")
 S X=$$SETFLD^VALM1(ERROR,X,"ERROR")
 S X=$$SETFLD^VALM1(DATE,X,"DATE")
 S LINENO=LINENO+1
 D SET^VALM10(COUNT,X,LINENO)
 S ^PRC(443.75,"PRCOER",$J,LINENO)=COUNT_"^"_LIST1
 Q
 ;
HELP ; -- help code
 I X["??" G HELP1
 ;
 D EN^DDIOL("Select one of the valid actions above, or enter '??' for extended help.","","!")
 D PAUSE
 Q
HELP1 ;  DISPLAY LIST MANAGER STANDARD HELP SCREEN.
 Q
 ;
PAUSE N DIR,DIRUT,DUOUT,DTOUT
 S DIR("A")="Enter RETURN to continue"
 S DIR(0)="E"
 D ^DIR
 Q
 ;
EXIT ; -- exit code
 D CLEAN^VALM10
 Q
 ;
NOTHING ; Come here if there are no transaction records to report.
 D EN^DDIOL("There are no records to report on at this time.","","!!?5")
 G PAUSE
