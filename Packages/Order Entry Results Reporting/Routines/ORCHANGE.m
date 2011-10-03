ORCHANGE ;SLC/MKB-Change View utilities ; 08 May 2002  2:12 PM
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**27,72,141,243**;Dec 17, 1997;Build 242
EN ; -- Change view of current list
 N XQORM,Y,ORI
 S XQORM=$G(^TMP("OR",$J,"CURRENT","CHANGE")),VALMBCK=""
 I 'XQORM W !!,"No other views of this list currently available" H 2 Q
 S Y=$S(ORTAB="NOTES"!(ORTAB="SUMMRIES"):"1\",ORTAB="ORDERS":"\",1:"")
 S XQORM(0)=Y_"AD" K Y
 S XQORM("A")=$S($L($G(^ORD(101,+XQORM,28))):^(28),1:"Select attribute(s) to change: ")
 D EN^XQORM S ORI=0
 F  S ORI=$O(Y(ORI)) Q:ORI'>0  X:$D(^ORD(101,+$P(Y(ORI),U,2),20)) ^(20)
 I $G(^TMP("OR",$J,"CURRENT",0))'=$G(^TMP("OR",$J,ORTAB,0)) K VALMBG D TAB^ORCHART(ORTAB,1)
 Q
 ;
RANGE ; -- Get new date range for list
 N HDR,OLD,NEW,REQ,BEG,END
 S HDR=$P($G(^TMP("OR",$J,ORTAB,0)),U,3)
 S REQ=$S(ORTAB="XRAYS":1,ORTAB="REPORTS":1,1:0)
 I ($P(HDR,";",3)=2)!($P(HDR,";",3)=5) D  Q
 . N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,THISTS
 . S THISTS=" only active "
 . I $P(HDR,";",3)=5 S THISTS=" expiring "
 . W !,"Date range can not be selected when viewing"_THISTS_"orders."
 . S DIR(0)="E" D ^DIR
 S OLD=$P(HDR,";"),NEW=$$START(OLD,REQ) Q:NEW="^"  S BEG=NEW
 I BEG="" S END="" G RQ
 S OLD=$P(HDR,";",2),NEW=$$STOP(OLD,REQ) Q:NEW="^"  S END=NEW
 I END<BEG S NEW=END,END=BEG,BEG=NEW ; switch
RQ S $P(HDR,";",1,2)=$P(BEG,U,2)_";"_$P(END,U,2)
 S $P(^TMP("OR",$J,ORTAB,0),U,3,4)=HDR_U
 Q
 ;
START(CURRENT,REQD) ; -- Return new beginning date
 N X,Y,DIR
 S DIR(0)="DA"_$S('$G(REQD):"O",1:"")_"^::ETX",DIR("A")="Beginning Date[/time]: "
 S:$L($G(CURRENT)) DIR("B")=$S(CURRENT?7N.1".".6N:$$FMTE^XLFDT(CURRENT),1:CURRENT)
 S DIR("?")="Enter the earliest date [and time] from which you want to see data; a null response will return all data on this patient"
 D ^DIR S:$D(DTOUT) Y="^" S:X="@" Y="" S:Y Y=Y_U_X
 Q Y
 ;
STOP(CURRENT,REQD) ; -- Return new ending date
 N X,Y,DIR
 S DIR(0)="DA"_$S('$G(REQD):"O",1:"")_"^::ETX",DIR("A")="Ending Date[/time]: "
 S:$L($G(CURRENT)) DIR("B")=$S(CURRENT?7N.1".".6N:$$FMTE^XLFDT(CURRENT),1:CURRENT)
 S DIR("?")="Enter the latest date [and time] for which you want to see data; a null response will assume TODAY"
 D ^DIR S:$D(DTOUT) Y="^" S:X="@" Y="" S:Y Y=Y_U_X
 Q Y
 ;
MAX ; -- Get new max # of items to list
 N X,Y,DIR
 S HDR=$P($G(^TMP("OR",$J,ORTAB,0)),U,3),X=$P(HDR,";",5)
 S DIR(0)="NAO^1:999" S:X DIR("B")=X
 S DIR("A")="Maximum # of items to display: "
 S DIR("?")="Enter the total number of items you wish to be displayed here"
 D ^DIR Q:'Y
 S $P(HDR,";",5)=Y,$P(^TMP("OR",$J,ORTAB,0),U,3,4)=HDR_U
 Q
 ;
AUTHOR(USER) ; -- Select new author of note
 N X,Y,DIC D FULL^VALM1 S VALMBCK="R"
 S DIC=200,DIC(0)="AEQM",DIC("A")="Select AUTHOR: "
 S:$G(USER) DIC("B")=$P($G(^VA(200,+USER,0)),U)
 D ^DIC S:Y'>0 Y=""
 Q +Y
 ;
LISTHDR ; -- List available subhdrs
 N HDR,DONE,CNT D FULL^VALM1
 W !!,"Choose from:" S HDR="",(CNT,DONE)=0,VALMBCK="R"
 F  S HDR=$O(^TMP("OR",$J,"CURRENT","HDR",HDR)) Q:HDR=""  D  Q:DONE
 . S CNT=CNT+1 I CNT>(IOSL-2) S CNT=0 I '$$MORE^ORCD S DONE=1 Q
 . W !,"  "_HDR
 Q
 ;
LRSUB ; -- Return lab subscript to jump to in list
 ;    Available subscripts in ^TMP("OR",$J,"IDX",name)=line #
 I '$D(^TMP("OR",$J,"CURRENT","HDR")) W !!,"There are no section headers defined for this report." H 3 Q
 N X,Y,DIR,XP,P,CNT,MATCH D FULL^VALM1 S VALMBCK="R"
LRS S DIR(0)="FAO^1:30",DIR("A")="Select Lab Section: "
 S DIR("A",1)="Available sections in this report:",X=""
 F I=2:1 S X=$O(^TMP("OR",$J,"CURRENT","HDR",X)) Q:X=""  S DIR("A",I)="   "_X
 S DIR("?")="Enter the lab section from which to wish to see results; the display will scroll to the top of the selected section" ;,DIR("??")="^D LISTHDR^ORCHANGE"
 D ^DIR Q:"^"[Y
 S XP=$$UP^XLFSTR(X)
 I $G(^TMP("OR",$J,"CURRENT","HDR",XP)) S VALMBG=^(XP),VALMBCK="R" Q
 S CNT=0,P=XP F  S P=$O(^TMP("OR",$J,"CURRENT","HDR",P)) Q:$E(P,1,$L(XP))'=XP  S CNT=CNT+1,MATCH(CNT)=+$G(^(P))_U_P ; line# ^ hdr name
 I 'CNT W $C(7),"  ??" G LRS
 I CNT=1 S VALMBG=+MATCH(CNT),VALMBCK="R",P=$P(MATCH(1),U,2) W $E(P,$L(X)+1,$L(P)) Q
LRS1 K DIR S DIR(0)="NAO^1:"_CNT,DIR("A")="Select 1-"_CNT_": "
 F I=1:1:CNT S DIR("A",I)=I_"  "_$P(MATCH(I),U,2)
 S DIR("?")="Select the lab section you want to go to, by number"
 D ^DIR Q:$D(DTOUT)!($D(DUOUT))  I 'Y K DIR G LRS
 S VALMBG=+MATCH(Y),VALMBCK="R"
 Q
 ;
DGROUP ; -- Select new service (display group)
 N X,Y,Z,ZZ,DIC,HDR,DONE,HELP
 D FULL^VALM1 S VALMBCK="R"
 S HDR=$P($G(^TMP("OR",$J,ORTAB,0)),U,3),Z=$P(HDR,";",4),ZZ=+$O(^ORD(100.98,"B",$S($L(Z):Z,1:"ALL"),0))
 S HELP="Enter the service or section from which you wish to see orders for this patient."
 S DONE=0 F  D  Q:DONE
 . W !!,"Select Service/Section: "_$P(^ORD(100.98,+ZZ,0),U)_"//"
 . R X:DTIME S:'$T X="^" I X["^" S DONE=1 Q
 . I X="" S DONE=1 Q  ; no change
 . I X["?" W !!,HELP,!,"Choose from:" D DG^ORCHANG1(1,"DISP") Q
 . S DIC=100.98,DIC(0)="NEQZ" D ^DIC S:Y>0 Z=$P(Y(0),U,3),ZZ=+Y,DONE=1
 S $P(HDR,";",4)=Z,$P(^TMP("OR",$J,ORTAB,0),U,3,4)=HDR_U
 Q
 ;
CS ; -- Select new consult service
 N GMRCDG,GMRCBUF,GMRCACT,GMRCQUT,GMRCGRP,HDR
 D FULL^VALM1,ASRV^GMRCASV S VALMBCK="R" Q:$D(GMRCQUT)
 S:$G(GMRCDG) HDR=$P($G(^TMP("OR",$J,ORTAB,0)),U,3),$P(HDR,";",4)=GMRCDG,$P(^(0),U,3,4)=HDR_U
 K ^TMP("GMRCS",$J),^TMP("GMRCSLIST",$J)
 Q
 ;
REMOVE ; -- Remove preferred view
 N ORDEL S ORDEL=1
SAVE ; -- Save current view as preferred
 Q:'$$OK($G(ORDEL))  N X,Y,PARAM
 S X=$S($G(ORDEL):"@",1:$P($G(^TMP("OR",$J,ORTAB,0)),U,3)),Y=""
 ;S:$G(ORTAB)="MEDS" Y=$S($P(X,";",3):"IN",1:"OUT")_"PT "
 S:$G(ORTAB)="LABS" Y=$S($G(ORWARD):"IN",1:"OUT")_"PT "
 S PARAM="ORCH CONTEXT "_Y_$G(ORTAB)
 D EN^XPAR("USR",PARAM,1,X) W " ...done." H 1
 Q
 ;
OK(DEL) ; -- Are you sure you want to save/remove view of ORTAB?
 N X,Y,DIR S DIR(0)="YA"
 S DIR("A")="Are you sure you want to "_$S($G(DEL):"remove",1:"save the current view as")_" your preference? "
 S:$G(DEL) DIR("?",1)="Enter YES if you wish to remove your preferred view of this chart tab and use",DIR("?")="the default view next time, or NO to quit without changing anything."
 S:'$G(DEL) DIR("?",1)="Enter YES if you wish to use these same parameters again the next time the ",DIR("?")=$$LOWER^VALM1(ORTAB)_" tab is created for you, or NO to quit without saving anything."
 D ^DIR
 Q +Y
 ;
RETURN ; -- Return to preferred view of ORTAB
 S $P(^TMP("OR",$J,ORTAB,0),U,4)=1
 Q
