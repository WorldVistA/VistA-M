ORCHANG3        ;SLC/MKB - Change view by event ; 08 May 2002  2:12 PM
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**141**;Dec 17, 1997
 ;
EVT ; -- Select new event
 N X,Y,HDR,DOMAIN,DEFAULT,I,PROMPT,HELP,EVT
 S HDR=$P($G(^TMP("OR",$J,ORTAB,0)),U,3),DEFAULT=""
 D LIST^OREVNTX(.DOMAIN,+ORVP)
 I $G(DOMAIN(0))<1 W !,"No events available for this patient.",! H 1 Q
 F I=1:1:DOMAIN(0) S X=$P(DOMAIN(I),U,2)_"  "_$$FMTE^XLFDT($P(DOMAIN(I),U,3),"2P"),DOMAIN("B",$$UP^XLFSTR(X))=I
 S PROMPT="Select Patient Event: "
 S HELP="Enter the event whose orders you wish to see listed here."
 D EN Q:Y="^"  S EVT=+$G(DOMAIN(Y))
 S:EVT $P(HDR,";",3)="",$P(HDR,";",8)=EVT,DEFAULT=""
 I EVT<1,'$P(HDR,";",3) S DEFAULT=1
 S $P(^TMP("OR",$J,ORTAB,0),U,3,4)=HDR_U_DEFAULT
 Q
 ;
EN ; -- Select new event via DOMAIN(), PROMPT, DEFAULT, HELP
 N DONE S DONE=0,Y="" F  D  Q:DONE
 . W !,PROMPT_$S($L(DEFAULT):DEFAULT_"//",1:"")
 . R X:DTIME S:'$T X="^" I X["^" S Y="^",DONE=1 Q
 . S:X="" X=DEFAULT I X="" S Y="^",DONE=1 Q
 . I X="@" S Y="",DONE=1 Q
 . I X["?" W !!,HELP D LIST Q
 . D  I 'Y W $C(7),!,HELP Q
 . . N XP,XY,CNT,MATCH,DIR,I
 . . S X=$$UP^XLFSTR(X),Y=+$G(DOMAIN("B",X)) Q:Y  ; done
 . . S CNT=0,XP=X F  S XP=$O(DOMAIN("B",XP)) Q:XP=""  Q:$E(XP,1,$L(X))'=X  S CNT=CNT+1,XY=+DOMAIN("B",XP),MATCH(CNT)=XY_U_$P(DOMAIN(XY),U,2)
 . . Q:'CNT
 . . I CNT=1 S Y=+MATCH(1),XP=$P(MATCH(1),U,2) W $E(XP,$L(X)+1,$L(XP)) Q
 . . S DIR(0)="NAO^1:"_CNT,DIR("A")="Select 1-"_CNT_": "
 . . F I=1:1:CNT S DIR("A",I)=$J(I,3)_" "_$P(MATCH(I),U,2)
 . . S DIR("?")="Select the desired value, by number"
 . . I CNT>3 D FULL^VALM1 S VALMBCK="R" ;need to scroll
 . . D ^DIR I $D(DIRUT) S Y="" Q
 . . S Y=+MATCH(Y) W "  "_$P(DOMAIN(Y),U,2)
 . S DONE=1
 Q
 ;
LIST ; -- List order events in DOMAIN
 N I,Z,CNT,DONE D FULL^VALM1 S VALMBCK="R"
 S CNT=0 W !,"Choose from:"
 F I=1:1:DOMAIN(0) D  Q:$G(DONE)
 . S CNT=CNT+1 W ! I CNT>(IOSL-3) D  Q:$G(DONE)
 .. W ?3,"'^' TO STOP: " R Z:DTIME S:'$T!(Z["^") DONE=1 S CNT=1
 . W $C(13),"  "_$P(DOMAIN(I),U,2)_"  "_$$FMTE^XLFDT($P(DOMAIN(I),U,3),"2P")
 Q
