VALM2 ;ALB/MJK - List Manager Utilities;08:52 PM  17 Jan 1993 ;02/01/2001  11:43
 ;;1.0;List Manager;**6**;Aug 13, 1993
SEL ; -- select w/XQORNOD(0) defined
 D EN(XQORNOD(0)) Q
EN(VALMNOD,VALMDIR) ; -- generic selector
 ; input passed: VALMNOD := var in XQORNOD(0) format
 N Y,BG,LST,VALMOUT
 K VALMY
 I '$D(VALMDIR) N VALMDIR S VALMDIR=""
 S BG=+$O(@VALMAR@("IDX",VALMBG,0))
 S LST=+$O(@VALMAR@("IDX",VALMLST,0))
 I BG,BG=LST,$P($P(VALMNOD,U,4),"=",2)="",VALMDIR'["O" S VALMY(BG)="" Q  ; -- only one entry
 I 'BG D  Q
 . W !!,$C(7),"There are no '",VALM("ENTITY"),"s' to select.",!
 . D WAIT^VALM1
 . D OUT
 S Y=$$PARSE(.VALMNOD,.BG,.LST)
 I 'Y D  Q:$G(VALMOUT)
 . N DIR,X,DIRUT,DTOUT,DUOUT,DIROUT
 . S DIR(0)=$S(VALMDIR'["S":"L",1:"N")_$S(VALMDIR["O":"O",1:"")_"^"_BG_":"_LST
 . S DIR("A")="Select "_VALM("ENTITY")_$S(VALMDIR["S":"",1:"(s)")
 . D ^DIR I $D(DIRUT) D OUT S VALMOUT=1
 ; -- check was valid entries
 F I=1:1 S X=$P(Y,",",I) Q:'X  D
 . I '$O(@VALMAR@("IDX",X,0))!(X<BG)!(X>LST) D
 . . W !,$C(7),">>> Selection '",X,"' is not a valid choice."
 . . S VALMOUT=1
 I $G(VALMOUT) D WAIT^VALM1 Q
 F I=1:1 S X=$P(Y,",",I) Q:'X  S VALMY(X)=""
 Q
PARSE(VALMNOD,BEG,END) ; -- split out pre-answers from user
 N Y,J,L,X
 S Y=$TR($P($P(VALMNOD,U,4),"=",2),"/\; .",",,,,,")
 I Y["-" S X=Y,Y="" F I=1:1 S J=$P(X,",",I) Q:J']""  I +J>(BEG-1),+J<(END+1) S:J'["-" Y=Y_J_"," I J["-",+J,+J<+$P(J,"-",2) F L=+J:1:+$P(J,"-",2) I L>(BEG-1),L<(END+1) S Y=Y_L_","
 Q Y
OUT ; -- set variables to quit
 S VALMBCK=$S(VALMCC:"",1:"R")
 Q
MENU ; -- entry point for 'turn' protocol
 N VALMX,DIR,X ;,Y,DIRUT,DUOUT,DTOUT,DIROUT calling app may check?
 S VALMX=$G(^DISV($S($D(DUZ)#2:DUZ,1:0),"VALMMENU",VALM("PROTOCOL"))) S:VALMX="" (VALMX,^(VALM("PROTOCOL")))=1
 W ! S DIR(0)="Y",DIR("A")="Do you wish to turn auto-display "_$S(VALMX:"'OFF'",1:"'ON'")_" for this menu",DIR("B")="NO"
 D ^DIR
 I Y S (VALMMENU,^DISV($S($D(DUZ)#2:DUZ,1:0),"VALMMENU",VALM("PROTOCOL")))='VALMX
 D FINISH^VALM4
 Q
HELP ; -- help entry point
 N VALMANS,VALMHLP,DIR,DIRUT,DUOUT,DTOUT ; ^XQORM1 checks DIROUT
 S VALMANS=X N X ; save answer
 S VALMHLP=$G(^TMP("VALM DATA",$J,VALMEVL,"HLP")),X=VALMANS
 I VALMHLP="" D
 . I VALM("TYPE")=2 S VALMANS="??" Q
 . S X="?" D DISP^XQORM1,PAUSE^VALM1
 E  D
 . X VALMHLP
 I $P($G(VALMKEY),U,2)]"",VALMANS["??" D:'$D(DIRUT) FULL^VALM1,KEYS,PAUSE^VALM1 S VALMBCK="R"
 D:$G(VALMBCK)="R" REFRESH^VALM K VALMBCK
 D:VALMCC RESET^VALM4
 D SHOW^VALM W !
 Q
KEYS ; -- hidden key help
 W !,"The following actions are also available:"
 N XQORM,ORULT S XQORM=$O(^ORD(101,"B",$P(VALMKEY,U,2),0))_";ORD(101,"
 I '$D(^XUTL("XQORM",XQORM)) D XREF^XQORM K ORULT ; build ^XUTL nodes
 D DISP^XQORM1:XQORM
 Q
