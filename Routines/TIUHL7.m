TIUHL7 ; SLC/AJB - TIUHL7 Msg Mgr ; 10OCT05
 ;;1.0;TEXT INTEGRATION UTILITIES;**200,228**;Jun 20, 1997
 Q
ACTION(ACT) ;
 N TIUMSG,TIUSEL
 D FULL^VALM1
 I VALMCNT=0 W !,"No documents to select." H 3 Q
 S TIUSEL=$P(XQORNOD(0),"=",2)
 I TIUSEL="" D  Q:'+TIUSEL
 . I VALMLST=1 S TIUSEL=1 Q
 . N DIR,X,Y
 . S DIR("A")=$S(ACT="DELETE":"Select Message(s) to Delete",ACT="VIEW":"Select Message to View")_": (1-"_VALMLST_") "
 . S DIR("?")=$S(ACT="DELETE":"Select one or more messages to be deleted",ACT="VIEW":"Select one message to view")
 . S DIR(0)=$S(ACT="DELETE":"L",ACT="VIEW":"N")_"OA^1:"_VALMLST
 . D ^DIR S TIUSEL=Y
 I TIUSEL["," S TIUSEL=$E(TIUSEL,1,($L(TIUSEL)-1))
 F X=1:1:$L(TIUSEL,",") S TIUMSG($P(TIUSEL,",",X))=$O(@VALMAR@("IDX",$P(TIUSEL,",",X),""))
 I ACT="SELECT" S ACT=$S(+$L(TIUSEL,",")=1:"VIEW",1:"DELETE")
 D @ACT
 Q
DELETE ;
 D FULL^VALM1
 W @IOF,"Deleting the following message(s):",!
 W !,"                                          Receiving     Sending        Message",!
 W IOUON,"    Message ID      Date/Time Processed   Application   Application    Status   ",!,IOUOFF
 S TIUSEL="" F  S TIUSEL=$O(TIUMSG(TIUSEL)) Q:'+TIUSEL  W @VALMAR@(TIUSEL,0),! ; TIUSEL,"   ",TIUMSG(TIUSEL),!
 I $$READ^TIUU("Y","Delete message(s)") D
 . S TIUSEL="" F  S TIUSEL=$O(TIUMSG(TIUSEL)) Q:'+TIUSEL  K ^XTMP("TIUHL7",$P(TIUMSG(TIUSEL),U,2),$P(TIUMSG(TIUSEL),U))
 . W !!,"Deleting...finished."
 W ! I $$READ^TIUU("EA","Press <RETURN> to continue")
 D CLEAN^VALM10,INIT,RE^VALM4
 S VALMBG=1
 Q
REFRESH ;
 D CLEAN^VALM10,INIT,RE^VALM4
 S VALMBG=1
 Q
VIEW ;
 D EN^TIUHL7A
 D CLEAN^VALM10,INIT,RE^VALM4
 S VALMBG=1
 Q
EN ; main entry point for TIUHL7 MSG MGR
 N POP
 D EN^VALM("TIUHL7 MSG MGR")
 Q
HDR ; header code
 N HDR S HDR="TIUHL7 Received Messages"
 S VALMHDR(1)=$$SETSTR^VALM1(HDR,"",(IOM-$L(HDR))/2,$L(HDR))
 S VALMHDR(2)=""
 S VALMHDR(3)="                                          Receiving     Sending        Message"
 D XQORM
 Q
INIT ; init variables and list array
 N TIU,TIUDISP,TIUDT,TIUFS,TIUMID
 S TIU("CUOFF")=$C(27)_"[?25l",TIU("CUON")=$C(27)_"[?25h" ; cursor values
 W TIU("CUOFF"),!!,"Searching for messages..."
 S (TIUDT,VALMCNT)=0,(TIUDISP,TIUMID)=""
 F  S TIUDT=$O(^XTMP("TIUHL7",TIUDT)) Q:'+TIUDT  F  S TIUMID=$O(^XTMP("TIUHL7",TIUDT,TIUMID)) Q:'+TIUMID  D
 . S VALMCNT=VALMCNT+1 W:VALMCNT#3=0 "."
 . S TIUFS=$E($G(^XTMP("TIUHL7",TIUDT,TIUMID,"MSGRESULT",1)),4)
 . S TIUDISP=$$SETSTR^VALM1(VALMCNT,"",1,8)
 . S TIUDISP=$$SETFLD^VALM1($P($G(^XTMP("TIUHL7",TIUDT,TIUMID,"MSGRESULT",1)),TIUFS,3),TIUDISP,"Message ID")
 . S TIUDISP=$$SETFLD^VALM1($$FMTE^XLFDT(TIUDT),TIUDISP,"Date/Time Processed")
 . S TIUDISP=$$SETFLD^VALM1($P($G(^XTMP("TIUHL7",TIUDT,TIUMID,"MSGRESULT",1)),TIUFS,4),TIUDISP,"RecApp")
 . S TIUDISP=$$SETFLD^VALM1($P($G(^XTMP("TIUHL7",TIUDT,TIUMID,"MSGRESULT",1)),TIUFS,5),TIUDISP,"SendApp")
 . S TIU=$P($G(^XTMP("TIUHL7",TIUDT,TIUMID,"MSGRESULT",1)),TIUFS,2),TIU=$S(TIU="AR":"Rejected",TIU="AA":"Accepted",1:"Unknown")
 . S TIUDISP=$$SETFLD^VALM1(TIU,TIUDISP,"Status")
 . D SET^VALM10(VALMCNT,TIUDISP,TIUMID_U_TIUDT)
 ;
 I VALMCNT=0 D
 . S TIU="No records found to satisfy search criteria."
 . D SET^VALM10(2,$$SETSTR^VALM1(TIU,"",(IOM-$L(TIU))/2,$L(TIU)),0)
 Q
HELP ; help code
 I X="?" S POP=1
 D FULL^VALM1
 W !!,"The following actions are available:"
 W !!,"View a Message       - View a selected message"
 W !,"Delete Message(s)    - Delete selected message(s)"
 W !,"Refresh Message List - Refresh display"
 W !!,"If ONE message is selected, default action is VIEW"
 W !,"If multiple messages are selected, default action is DELETE",!
 I +$G(POP) I $$READ^TIUU("EA","Press <RETURN> to continue")
 S VALMBCK="R",POP=0
 Q
EXIT ; exit code
 D XQORM
 Q
EXPND ; expand code
 Q
XQORM ; default action for list manager
 S XQORM("#")=$O(^ORD(101,"B","TIUHL7 MSG MGR SELECT",0))_U_"1:"_VALMCNT
 Q
