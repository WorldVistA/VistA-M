ORCHANG2 ;SLC/MKB-Change View status ; 08 May 2002  2:12 PM
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**27,72,68,141,215,243**;Dec 17, 1997;Build 242
ORDERS ; -- Select new order status
 N X,Y,HDR,I,DOMAIN,DEFAULT,PROMPT,HELP,STS
 S HDR=$P($G(^TMP("OR",$J,ORTAB,0)),U,3),DEFAULT=""
 F I=1:1 S X=$T(ORDSTS+I) Q:$P(X,";",4)="ZZZZ"  D SET
 S DOMAIN(0)=I-1,PROMPT="Select Order Status: "
 S HELP="Enter the status of orders you wish to see listed here."
 D EN Q:Y="^"  S STS=+$G(DOMAIN(Y))
 I "^8^9^10^20^"[(U_STS_U) D  Q:Y="^"
 . N STRT,STOP,Z
 . S STRT=$$START^ORCHANGE("NOW-24H") I STRT="^" S Y="^" Q
 . S STOP=$$STOP^ORCHANGE("NOW") I STOP="^" S Y="^" Q
 . I STOP<STRT S Z=STRT,STRT=STOP,STOP=Z
 . S $P(HDR,";",1,2)=$P(STRT,U,2)_";"_$P(STOP,U,2)
 S $P(HDR,";",3)=STS,$P(HDR,";",8)=""
 I (STS=2)!(STS=5) D
 . I $P(HDR,";")'="" D
 . . N THISTS,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 . . S THISTS=" only active "
 . . S:STS=5 THISTS=" expiring "
 . . W !,"Date range can not be selected when viewing"_THISTS_"orders"
 . . W !,"and will be cleared."
 . . S DIR(0)="E" D ^DIR
 . S $P(HDR,";",1,2)=";"
 I STS=6,$P(HDR,";")="" S $P(HDR,";",1,2)="T;T@23:59"
 S $P(^TMP("OR",$J,ORTAB,0),U,3,4)=HDR_U
 Q
 ;
STSLST(ORY)     ; -- Returns array of order views as 
 ;            ORY(n) = id ^ name ^ parent id [^+ if has members]
 N I,X,CNT S CNT=0
 F I=1:1 S X=$T(ORDSTS+I) Q:$P(X,";",4)="ZZZZ"  S CNT=CNT+1,ORY(CNT)=$TR($P(X,";",3,6),";","^")
 ; include specific patient events??
 Q
 ;
ORDSTS ;;#;Name of Order Context
 ;;1;All;0;+
 ;;2;Active (includes pending, recent activity);1
 ;;23;Current (Active & Pending status only);1
 ;;3;Discontinued;1
 ;;28;Discontinued/Entered in Error;1
 ;;4;Completed/Expired;1
 ;;5;Expiring;1
 ;;7;Pending;1
 ;;18;On Hold;1
 ;;19;New Orders;1
 ;;11;Unsigned;1
 ;;8;Unverified by anyone;1;+
 ;;9;Unverified by Nursing;8
 ;;10;Unverified by Clerk;8
 ;;20;Unverified/Chart Review;8
 ;;13;Verbal/Phoned;1;+
 ;;14;Verbal/Phoned unsigned;13
 ;;12;Flagged;1
 ;;6;Recent Activity (defaults to today's orders);1
 ;;24;Delayed (all events);1;+
 ;;15;Delayed Admission;24
 ;;17;Delayed Transfer;24
 ;;16;Delayed Discharge;24
 ;;25;Delayed Return from O.R.;24
 ;;26;Delayed for Manual Release;24
 ;;22;Lapsed (never processed);1
 ;;;ZZZZ
 ;
STS ; -- Select new [order or consult] status
 N HDR,DEFAULT,DOMAIN,PROMPT,HELP,X,Y,I
 S HDR=$P($G(^TMP("OR",$J,ORTAB,0)),U,3),DEFAULT=""
 S (I,Y)=0 F  S I=$O(^ORD(100.01,I)) Q:I'>0  Q:I=99  S X=$G(^(I,0)) D
 . Q:"^1^2^5^6^8^9^13^"'[(U_I_U)  S Y=Y+1
 . S DOMAIN(Y)=I_U_$$LOWER^VALM1($P(X,U)),DOMAIN("B",$P(X,U))=Y
 . S:I=$P(HDR,";",3) DEFAULT=$P(DOMAIN(Y),U,2)
 S Y=Y+1,DOMAIN(Y)="^All Statuses",DOMAIN("B","ALL STATUSES")=Y
 S DOMAIN(0)=Y,PROMPT="Select Consult Status: "
 S HELP="Enter the status of consults you wish to see listed here."
 D EN Q:Y="^"
 S $P(HDR,";",3)=$P(DOMAIN(Y),U),$P(^TMP("OR",$J,ORTAB,0),U,3,4)=HDR_U
 Q
 ;
TIU ; -- Select new document status
 N X,Y,ORY,I,CNT,HDR,DOMAIN,DEFAULT,PROMPT,HELP
 S HDR=$P($G(^TMP("OR",$J,ORTAB,0)),U,3),DEFAULT=$P(HDR,";",3)
 D STATUS^TIUSRVL(.ORY)
 S (I,CNT)=0 F  S I=$O(ORY(I)) Q:I'>0  S CNT=CNT+1,DOMAIN(CNT)=ORY(I),DOMAIN("B",$$UP^XLFSTR($P(ORY(I),U,2)))=CNT
 S DOMAIN(0)=CNT,PROMPT="Select Signature Status: "
 S HELP="Enter the signature status you would like to screen on"
 D EN Q:Y="^"
 S $P(HDR,";",3)=$P(DOMAIN(Y),U,2),$P(^TMP("OR",$J,ORTAB,0),U,3,4)=HDR_U
 Q
 ;
PLIST ; -- Select problem status
 N X,Y,HDR,I,ID,NAME,DOMAIN,DEFAULT,PROMPT,HELP
 S HDR=$P($G(^TMP("OR",$J,ORTAB,0)),U,3)
 F I=1:1 S X=$T(PLSTS+I) Q:$P(X,";",4)="ZZZZ"  D SET
 S DOMAIN(0)=I-1,PROMPT="Select Problem Status: "
 S HELP="Enter the status of the problems you wish to see listed here."
 D EN Q:Y="^"
 S $P(HDR,";",3)=$P(DOMAIN(Y),U),$P(^TMP("OR",$J,ORTAB,0),U,3,4)=HDR_U
 Q
 ;
PLSTS ;;I;name
 ;;A;active
 ;;I;inactive
 ;;B;both active & inactive
 ;;;ZZZZ
 ;
SET ; -- set DOMAIN(I)=ID^NAME, DEFAULT from X=";;ID;NAME"
 N ID,NAME
 S ID=$P(X,";",3),NAME=$P(X,";",4)
 S DOMAIN(I)=ID_U_NAME,DOMAIN("B",$$UP^XLFSTR(NAME))=I
 S:ID=$P(HDR,";",3) DEFAULT=NAME
 Q
 ;
EN ; -- Select new status via DOMAIN(), PROMPT, DEFAULT, HELP
 N DONE S DONE=0,Y="" F  D  Q:DONE
 . W !,PROMPT_$S($L(DEFAULT):DEFAULT_"//",1:"")
 . R X:DTIME S:'$T X="^" I X["^" S Y="^",DONE=1 Q
 . S:X="" X=DEFAULT I X="" S Y="^",DONE=1 Q
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
LIST ; -- List order statuses in DOMAIN
 N I,Z,CNT,DONE D FULL^VALM1 S VALMBCK="R"
 S CNT=0 W !,"Choose from:"
 F I=1:1:DOMAIN(0) D  Q:$G(DONE)
 . S CNT=CNT+1 W ! I CNT>(IOSL-3) D  Q:$G(DONE)
 .. W ?3,"'^' TO STOP: " R Z:DTIME S:'$T!(Z["^") DONE=1 S CNT=1
 . W $C(13),"  "_$P(DOMAIN(I),U,2)
 Q
