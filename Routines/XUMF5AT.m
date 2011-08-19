XUMF5AT  ;ISS/PAVEL - XUMF5 MD5 Hash Testing API ;06/17/05
 ;;8.0;KERNEL;**383**;July 10, 1995
 ;
 ;;original name was 'VESOUHSH' ; Secure hash functions
 ;;(c) Copyright 1994 - 2004, ESI Technology Corp, Natick MA
 ;; This source code contains the intellectual property of its copyright holder(s),
 ;; and is made available under a license. If you are not familiar with the terms
 ;; of the license, please refer to the license.txt file that is a part of the
 ;; distribution kit.
 ;  THIS IS TESTING VERSION
 Q
 ;;**************************************************
 ;;MD5 'R'egular portion of the code. This will handle
 ;; one string at a time.
 ;;**************************************************
 ;
TESTR ; Run Regular test suite and verify values
 N OK
 S OK=1
 S:$$HEX^XUMF5AU($$MD5R^XUMF5AU(""))'="d98c1dd404b2008f980980e97e42f8ec" OK=0
 W !,"MD5 for """" =",$$HEX^XUMF5AU($$MD5R^XUMF5AU(""))
 W !,"MD5 reversed for """" =",$$MAIN^XUMF5BYT($$MAIN^XUMF5BYT($$HEX^XUMF5AU($$MD5R^XUMF5AU(""))))
 S:$$HEX^XUMF5AU($$MD5R^XUMF5AU("a"))'="b975c10ca8b6f1c0e299c33161267769" OK=0
 W !,"MD5 for ""a"" =",$$HEX^XUMF5AU($$MD5R^XUMF5AU("a"))
 W !,"MD5 reversed for ""a"" =",$$MAIN^XUMF5BYT($$HEX^XUMF5AU($$MD5R^XUMF5AU("a")))
 S:$$HEX^XUMF5AU($$MD5R^XUMF5AU("abc"))'="98500190b04fd23c7d3f96d6727fe128" OK=0
 W !,"MD5 for ""abc"" =",$$HEX^XUMF5AU($$MD5R^XUMF5AU("abc"))
 W !,"MD5 reversed for ""abc"" =",$$MAIN^XUMF5BYT($$HEX^XUMF5AU($$MD5R^XUMF5AU("abc")))
 S:$$HEX^XUMF5AU($$MD5R^XUMF5AU("message digest"))'="7d696bf98d93b77c312f5a52d061f1aa" OK=0
 W !,"MD5 for ""message digest"" =",$$HEX^XUMF5AU($$MD5R^XUMF5AU("message digest"))
 W !,"MD5 reversed for ""message digest"" =",$$MAIN^XUMF5BYT($$HEX^XUMF5AU($$MD5R^XUMF5AU("message digest")))
 S:$$HEX^XUMF5AU($$MD5R^XUMF5AU("abcdefghijklmnopqrstuvwxyz"))'="d7d3fcc300e492616c49fb7d3be167ca" OK=0
 W !,"MD5 for ""abcdefghijklmnopqrstuvwxyz"" =",$$HEX^XUMF5AU($$MD5R^XUMF5AU("abcdefghijklmnopqrstuvwxyz"))
 W !,"MD5 reversed for ""abcdefghijklmnopqrstuvwxyz"" =",$$MAIN^XUMF5BYT($$HEX^XUMF5AU($$MD5R^XUMF5AU("abcdefghijklmnopqrstuvwxyz")))
 S:$$HEX^XUMF5AU($$MD5R^XUMF5AU("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"))'="98ab74d1f5d977d22c1c61a59f9d419f" OK=0
 W !,"MD5 for ""ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"" =",$$HEX^XUMF5AU($$MD5R^XUMF5AU("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"))
 W !,"MD5 reversed for ""ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"" =",$$MAIN^XUMF5BYT($$HEX^XUMF5AU($$MD5R^XUMF5AU("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789")))
 S:$$HEX^XUMF5AU($$MD5R^XUMF5AU("12345678901234567890123456789012345678901234567890123456789012345678901234567890"))'="a2f4ed5755c9e32b2eda49ac7ab60721" OK=0
 W !,"MD5 for ""12345678901234567890123456789012345678901234567890123456789012345678901234567890"" =",$$HEX^XUMF5AU($$MD5R^XUMF5AU("12345678901234567890123456789012345678901234567890123456789012345678901234567890"))
 W !,"MD5 reversed for ""12345678901234567890123456789012345678901234567890123456789012345678901234567890"" =",$$MAIN^XUMF5BYT($$HEX^XUMF5AU($$MD5R^XUMF5AU("12345678901234567890123456789012345678901234567890123456789012345678901234567890")))
 I OK=1 W !,"Tests passed." Q
 W !,"Tests failed."
 Q
TESTE ; Run Enhanced test suite and verify values
 N OK,MYABCD
 S OK=1
 S MYA=$C(1,35,69,103)
 S MYB=$C(137,171,205,239)
 S MYC=$C(254,220,186,152)
 S MYD=$C(118,84,50,16)
 S MYABCD=MYA_MYB_MYC_MYD
 S:$$HEX^XUMF5AU($$MD5E^XUMF5AU(MYABCD,""))'="d98c1dd404b2008f980980e97e42f8ec" OK=0
 S:$$HEX^XUMF5AU($$MD5E^XUMF5AU(MYABCD,"a"))'="b975c10ca8b6f1c0e299c33161267769" OK=0
 S:$$HEX^XUMF5AU($$MD5E^XUMF5AU(MYABCD,"abc"))'="98500190b04fd23c7d3f96d6727fe128" OK=0
 S:$$HEX^XUMF5AU($$MD5E^XUMF5AU(MYABCD,"message digest"))'="7d696bf98d93b77c312f5a52d061f1aa" OK=0
 S:$$HEX^XUMF5AU($$MD5E^XUMF5AU(MYABCD,"abcdefghijklmnopqrstuvwxyz"))'="d7d3fcc300e492616c49fb7d3be167ca" OK=0
 S:$$HEX^XUMF5AU($$MD5E^XUMF5AU(MYABCD,"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"))'="98ab74d1f5d977d22c1c61a59f9d419f" OK=0
 S:$$HEX^XUMF5AU($$MD5E^XUMF5AU(MYABCD,"12345678901234567890123456789012345678901234567890123456789012345678901234567890"))'="a2f4ed5755c9e32b2eda49ac7ab60721" OK=0
 I OK=1 W !,"Tests passed." Q
 W !,"Tests failed."
 Q
 ;Pavel's testing stuff
 ;FIND DEPENDENCY for loaded packages... 
 ;Scann whole environment for discrepances...
FDEP N DIC,Y,X,IEN,TMP,ERR,X0,START,RR
 S X0=0,START=1
 K ^TMP("LIST",$J)
 F  K ^TMP("DEP",$J),^TMP("DEPX",$J) S X0=$O(^XPD(9.6,"B",X0)) Q:'$L(X0)  S IEN=$O(^XPD(9.6,"B",X0,0)) Q:'IEN  D
 .I START W !!,?5,"****** Builds, for which not all required packages have been installed ******",! S START=0
 .I $$GETDEP(IEN,1) W !,"IEN: ",IEN,?10,X0 S ^TMP("LIST",$J,X0)=IEN
 K ^TMP("DEP",$J),^TMP("DEPX",$J)
 R !!,"Do you want detail list tree for each one ?? N// ",RR:60
 Q:'$L(RR)!(RR["^")  Q:$E($TR(RR,"y","Y"))'="Y"
 S X0=""
 F  S X0=$O(^TMP("LIST",$J,X0)) Q:'$L(X0)  S IEN=^(X0) D
 .K ^TMP("DEP",$J),^TMP("DEPX",$J)
 .S LEV=1 I '$$GETDEP(IEN,LEV) W !,"No dependency for: ",$P(Y,U,2) Q
 .S OK=0 F  Q:$$LOOP(LEV)  S LEV=LEV+1
 .S $P(II,"-",79)="-"
 .W !!!,"******  Required builds of ",X0," NOT installed on system ******",!,II
 .S LEV=0 F  S LEV=$O(^TMP("DEP",$J,LEV)) Q:'LEV  S II=0 F  S II=$O(^TMP("DEP",$J,LEV,II)) Q:'II  W !,"LEV: ",LEV,?8,II,?20,$P(^(II),U),?45,$P(^(II),U,2)
 W !!!,"DONE",!
 Q
BUILD ;ENTRY FOR CHECKING OF DEPENDENCY TREE
 N DIC,Y,X,IEN,TMP,ERR
1 K ^TMP("DEP",$J),^TMP("DEPX",$J)
 S DIC=9.6,DIC(0)="AZEQZ" D ^DIC Q:Y=-1  S IEN=+Y_","
 S LEV=1
 I '$$GETDEP(IEN,LEV) W !,"No dependency for: ",$P(Y,U,2) G 1
 ;Recursive loop for dependencies
 ;Loop and delete entry which is loaded.
 S OK=0
 F  Q:$$LOOP(LEV)  S LEV=LEV+1
 S $P(II,"-",75)="-"
 W !!,?4,"******  Required builds of ",$P(Y,U,2)," NOT installed on system ******",!,II
 S LEV=0 F  S LEV=$O(^TMP("DEP",$J,LEV)) Q:'LEV  S II=0 F  S II=$O(^TMP("DEP",$J,LEV,II)) Q:'II  W !,"LEV: ",LEV,?8,II,?20,$P(^(II),U),?45,$P(^(II),U,2)
Q W ! G 1
 ;
 Q
LOOP(LEV)       ;LOOP and Kill if not dependencess
 N II,OK,X1,Y,DIC,X,IEN,TMP
 S II=0
 F  S II=$O(^TMP("DEP",LEV,II)) Q:'$L(II)  D
 .I '$$REQB(II,$P(^TMP("DEP",LEV,II),U)) K ^TMP("DEP",$J,LEV,II) Q
 ;Now we have deleted all entries/packages already installed.. and set level + 1 depencencees...
 S II=0,OK=1
 F  S II=$O(^TMP("DEP",$J,LEV,II)) Q:'$L(II)  D
 .Q:'$$GETDEP(II_",",LEV+1)
 .S OK=0
 Q OK
GETDEP(IEN,LEV) ;
 N TMP1,X1,DIC,Y,X
 D GETS^DIQ(9.6,IEN,"11*",,"TMP1","ERR")
 I $D(ERR) D  Q
 .W !,"Error in subfile # 9.611",!
 S X1=0 F  S X1=$O(TMP1(9.611,X1)) Q:'$L(X1)  D
 .S X=TMP1(9.611,X1,.01),DIC=9.6,DIC(0)="XZ" D ^DIC Q:Y=-1
 .Q:'$$REQB(+Y,$G(TMP1(9.611,X1,.01)))
 .S:'$D(^TMP("DEPX",$J,+Y)) ^TMP("DEP",$J,LEV,+Y)=TMP1(9.611,X1,.01)_U_TMP1(9.611,X1,1)
 .S ^TMP("DEPX",$J,+Y,LEV)=""
 Q $S($D(^TMP("DEP",$J,LEV)):1,1:0)
REQB(IEN,XPDX)  ;check for Required Builds
 ;returns 0=ok, 1=failed kill global, 2=failed leave global
 Q:'$L($G(XPDX)) 0
 N XPDACT,XPDBLD,XPDI,XPDQ,XPDQUIT,XPDX0,X,Y,Z
 S XPDQUIT=0,XPDI=0
 S XPDQ=0,X=$$PKG^XPDUTL(XPDX),Y=$$VER^XPDUTL(XPDX),Z=$$VERSION^XPDUTL(X) D
 .Q:Z>Y
 .I XPDX'["*" S:Z<Y XPDQ=2
 .E  S:'$$PATCH^XPDUTL(XPDX) XPDQ=1
 .;quit if patch is already on system
 .Q:'XPDQ
 .;quit if patch is sequenced prior within this build
 .I $D(XPDT("NM",XPDX)),(XPDT("NM",XPDX)<XPDT("NM",XPDNM)) S XPDQ=0 Q
 .S XPDQUIT=1
 Q XPDQUIT
