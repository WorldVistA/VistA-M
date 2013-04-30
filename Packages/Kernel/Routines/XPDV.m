XPDV ;SFISC/RSD - Verify Build ;10/15/2008
 ;;8.0;KERNEL;**30,44,58,108,511,525,539,547**;Jul 10, 1995;Build 15
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;checks that everything is ready to do a build
 ;XPDA=build ien, loop thru all nodes in ^XPD(9.6,XPDA and verify data
EN ;check a build
 N DA,ERR,FGR,TYPE,XPDFILE,XPDOLDA,Y0,Y2 K ^TMP($J)
 S Y0=$G(^XPD(9.6,XPDA,0)),TYPE=$P(Y0,U,3)
 I $P(Y0,U,2)="" W !,"No Package File Link"
 I '$P(Y0,U,2) W !,$P(Y0,U,2)," in Package File Link field is free text, not a pointer"
 I $P(Y0,U,2),'$D(^DIC(9.4,$P(Y0,U,2),0)) W !,$P(Y0,U,2)," in PACKAGE File  ** NOT FOUND **",*7
 ;type is global package goto CONT
 G CONT:TYPE=2
 I TYPE=1 S Y0=$$MULT(XPDA) G DONE
 S XPDFILE=0
 ;check DD being sent
 F  S XPDFILE=$O(^XPD(9.6,XPDA,4,XPDFILE)) Q:'XPDFILE  D
 .Q:$$FILE(XPDFILE)=""
 .S Y0=0,Y2=$G(^XPD(9.6,XPDA,4,XPDFILE,222))
 .Q:'$$DATA(XPDFILE,Y2)
 .F  S Y0=$O(^XPD(9.6,XPDA,4,XPDFILE,2,Y0)) Q:'Y0  D
 ..I '$D(^DD(Y0)) W !," SubDD #",Y0," in File #",XPDFILE,"  ** NOT FOUND **" Q
 ..S XPDOLDA=0
 ..;check fields being sent for partial DD
 ..F  S XPDOLDA=$O(^XPD(9.6,XPDA,4,XPDFILE,2,Y0,1,XPDOLDA)) Q:'XPDOLDA  D
 ...I '$D(^DD(Y0,XPDOLDA)) W !,"Field #",XPDOLDA," in SubDD #",Y0," in File #",XPDFILE,"  ** NOT FOUND **" Q
 ;
 ;build components files
 S XPDFILE=0
 F  S XPDFILE=$O(^XPD(9.6,XPDA,"KRN",XPDFILE)) Q:'XPDFILE  D
 .;if file doesn't exist, save in ^TMP and deleted at end
 .S FGR=$$FILE(XPDFILE),XPDOLDA=0 I FGR="" S ^TMP($J,XPDFILE)="" Q
 .F  S XPDOLDA=$O(^XPD(9.6,XPDA,"KRN",XPDFILE,"NM",XPDOLDA)) Q:'XPDOLDA  S Y0=$G(^(XPDOLDA,0)) D
 ..;check action, quit if deleting at site
 ..Q:$P(Y0,U,3)=1
 ..;check that entry exist
 ..S:$P(Y0,U,2) $P(Y0,U)=$P(Y0,"    FILE #") S DA=$$ENTRY(Y0)
 ..Q:'$P(Y0,U,3)!($P(Y0,U,3)#2)
 ..;if attach check that parent is sent, if link check that child is sent
 ..Q:'$$MENU(XPDFILE,DA,$P(Y0,U,3))
 ;check Install Questions
 S XPDOLDA=0
 F  S XPDOLDA=$O(^XPD(9.6,XPDA,"QUES",XPDOLDA)) Q:'XPDOLDA  S Y0=$G(^(XPDOLDA,0)),Y2=$G(^(1)) D
 .I $P(Y0,U)="" W !,"Zero node doesn't exist for INSTALL QUESTION #",XPDOLDA Q
 .I Y2="" W !,"DIR(0) field is not defined for INSTALL QUESTION ",$P(Y0,U)
 I $O(^XPD(9.6,XPDA,"GLO",0)) W !,"Package cannot contain Globals, Files, & Components."
 ;check for PRE & POST routines
 F DA="INI","INIT" S Y0=$G(^XPD(9.6,XPDA,DA)),ERR="" I Y0]"",'$$RTN(Y0,.ERR) W !,"Routine ",Y0,ERR
CONT ;
 ;check Environment Check routine
 S Y0=$G(^XPD(9.6,XPDA,"PRE")),ERR="" I Y0]"",'$$RTN(Y0,.ERR) W !,"Routine ",Y0,ERR
 I TYPE=2 S Y0=$$GLOPKG(XPDA)
DONE I $O(^TMP($J,0)) D
 .N DA,DIK,DIR,DIRUT,Y
 .S DIR(0)="Y",DIR("A")="Do you want to remove the missing Files",DIR("B")="NO"
 .S DIR("?")="Yes means that the missing Files will be removed and you can transport this Build"
 .D ^DIR Q:'Y!$D(DIRUT)
 .S DIK="^XPD(9.6,"_XPDA_",""KRN"",",DA(1)=XPDA,DA=0 F  S DA=$O(^TMP($J,DA)) Q:'DA  D ^DIK
 W !!,"  ** DONE **"
 Q
GLOPKG(X) ;GLOBAL PACKAGE
 ;returns 1 if ok, 0 if failed
 N I,J,Y,Z S Z=1
 I $O(^XPD(9.6,X,4,0)) W !,"GLOBAL PACKAGE cannot contain Files" S Z=0
 S I=0 F  S I=$O(^XPD(9.6,X,"KRN",I)) Q:'I  D:$O(^(I,"NM",0))
 .W !,"GLOBAL PACKAGE cannot contain ",$P(^DIC(I,0),U) S Z=0
 I $O(^XPD(9.6,X,"QUES",0)) W !,"GLOBAL PACKAGE cannot contain Install Questions" S Z=0
 I $G(^XPD(9.6,X,"INI"))]"" W !,"GLOBAL PACKAGE cannot have a Pre-Install Routine" S Z=0
 ;I $G(^XPD(9.6,X,"INIT"))]"" W !,"GLOBAL PACKAGE cannot have a Post-Install Routine" S Z=0
 S I=0 F J=0:1 S I=$O(^XPD(9.6,X,"GLO",I)) Q:'I  S Y=$G(^(I,0)) D
 .I $P(Y,U)]"",'$D(@("^"_$P(Y,U))) W !,"Global ",Y," doesn't exist." S Z=0
 I 'J W !,"No Globals to transport" S Z=0
 Q Z
 ;
QUES(X) ;X=.01 of INSTALL QUESTION multiple
 ;returns ien or 0 if failed
 N Y
 S Y=+$O(^XPD(9.6,XPDA,"QUES","B",X,0))
 I '$D(^XPD(9.6,XPDA,"QUES",Y,0)) W !,"Zero node doesn't exist for INSTALL QUESTION ",X Q 0
 I '$D(^XPD(9.6,XPDA,"QUES",Y,1)) W !,"DIR(0) field is not defined for INSTALL QUESTION ",X Q 0
 Q Y
 ;
FILE(X) ;check file # X
 ;returns global ref or "" if failed
 N %,Y
 S Y=$G(^DIC(X,0,"GL"))
 I Y="" W !," File #",X,"  ** NOT FOUND **" Q ""
 S %=$E(Y,$L(Y)),X=$E(Y,1,$L(Y)-1)_$S(%="(":"",1:")")
 Q X
 ;
 ;Z only contains the file # for Fileman templates and forms
 ;XPDFILE=file #,FGR=file global ref
ENTRY(Z) ;check entry, Z=name^file
 ;returns ien or 0 if failed
 N F,X,Y
 ;check for X, name, in "B" x-ref of file.
 S X=$P(Z,U),Y=0 F  S Y=$O(@FGR@("B",X,Y)) D  Q:X=""
 .I 'Y W !?3,X,"  in ",$P(^DIC(XPDFILE,0),U)," File   ** NOT FOUND **",*7 S X="" Q
 .;if Y is in x-ref but node doesn't exist, quit and try another
 .;if this is a fileman template, the file associated with it is piece 2 of Z
 .;if Form file check piece 8 else 4
 .Q:'$D(@FGR@(Y,0))  I $P(Z,U,2) S F=^(0) S:$P(Z,U,2)=$P(F,U,(4+(4*(FGR["DIST")))) X="" Q
 .;if it is routine file,9.8, check that routine exist
 .I XPDFILE=9.8 S F="" I '$$RTN(X,.F) W !,"Routine ",X,F S X="",Y=0 Q
 .;if this is not a fileman template or routine we found Y
 .S X="" Q
 Q +Y
 ;
DATA(F,Y) ;
 ;return 1 if ok or 0 if failed
 I $P(Y,U,3)="p",$P(Y,U,7)="y" W !,"You can only send Data with a Full Data Dictionary,",!,"** File #",F," cannot be Sent **" Q 0
 Q 1
 ;
RTN(X,MSG) ;verify tag^routine
 ;INPUT: X=[tag^]routine, MSG(passed by reference)
 ;OUTPUT: returns 1=exists, 0=doesn't; MSG=error message
 N L,S,T,R
 S MSG=""
 I X["(" S X=$P(X,"(") ;Handle tag^rtn(param) rwf
 I X["^" S T=$P(X,"^"),R=$P(X,"^",2)
 E  S T="",R=X
 I (R'?1A.E) S MSG=" Name violates the SAC!!" Q 0
 I $T(^@R)="" S MSG=" DOESN'T EXIST!!" Q 0
 ;2nd line must begin with "[label] ;;n[n.nn];A[APN];"
 S S=$T(+2^@R) D  I MSG]"" Q 0
 .I $L($P(S," ")) S L=$P(S," "),S=$P(S,L,2,99) I L'?1U.7UN S MSG=" 2nd line violates the SAC!!" Q
 .I S'?.1" ;;"1.2N.1".".2N1";"1.APN1";".E S MSG=" 2nd line violates the SAC!!"
 ;if no tag or tag^routine exists, then return 1
 Q:T="" 1 Q:$T(@T^@R)]"" 1
 S MSG=" Tag DOESN'T EXIST!!" Q 0
 ;
MULT(DA) ;multi-package
 ;returns 1 if ok or 0 if failed
 N I,J,X,Y,Z
 S I=0,Z=1
 F J=0:1 S I=$O(^XPD(9.6,DA,10,I)) Q:'I  S X=$P($G(^(I,0)),U),Y=0 D
 .S:X]"" Y=$O(^XPD(9.6,"B",X,0))
 .I Y,$D(^XPD(9.6,Y,0)) Q
 .W !,"Package ",X," doesn't exist." S Z=0
 I 'J W !,"No Packages to transport" S Z=0
 Q Z
MENU(F,X,Y) ;check for Parent or Children, F=file (19 or 101), X=ien,
 ;Y=action (2=link or 4=attach)
 ;returns 1 if ok or 0 if failed
 Q:'X 0
 N I,J,GR,Z
 S GR=$S(F=19:"^DIC(19)",1:"^ORD(101)"),(I,Z)=0
 ;link, check that at least 1 menu item or subscribers was sent
 I Y=2 D
 . F  S I=$O(@GR@(X,10,"B",I)) Q:'I  S J=$P($G(@GR@(I,0)),U) I J]"",$D(^XPD(9.6,XPDA,"KRN",F,"NM","B",J)) S Z=1 Q
 . ;if it didn't find menu item and this is a protocol, check the subscribers, 775
 . I 'Z,F=101 F  S I=$O(@GR@(X,775,"B",I)) Q:'I  S J=$P($G(@GR@(I,0)),U) I J]"",$D(^XPD(9.6,XPDA,"KRN",F,"NM","B",J)) S Z=1 Q
 ;attach, check that the parent was sent
 I Y=4 F  S I=$O(@GR@("AD",X,I)) Q:'I  S J=$P($G(@GR@(I,0)),U) I J]"",$D(^XPD(9.6,XPDA,"KRN",F,"NM","B",J)) S Z=1 Q
 D:'Z
 .W !,$S(F=19:"Option ",1:"Protocol "),$P($G(@GR@(X,0)),U)," has an Action of "
 .W:Y=2 "'USE AS LINK FOR MENU ITEMS' and no 'Menu Items' were sent."
 .W:Y=4 "'ATTACH TO MENU' and a 'Parent Menu' wasn't sent."
 Q Z
