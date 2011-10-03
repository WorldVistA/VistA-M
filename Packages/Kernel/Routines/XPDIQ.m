XPDIQ ;SFISC/RSD - Install Questions ;03/21/2008
 ;;8.0;KERNEL;**21,28,58,61,95,108,399**;Jul 10, 1995;Build 12
 Q
DIR(XPFR,XPFP) ;XPFR=prefix, XPFP=file no._# or Mail Group ien
 ;XPFP is for XPF  or XPM questions
 N DIR,DR,XPDI,XPDJ,X,Y,Z
 S XPFP=$G(XPFP),XPDI=$S(XPFP:XPFR_XPFP,1:XPFR)
 D QUES(XPDI)
 ;ask questions
 S X=XPFR
 F  S X=$O(^XTMP("XPDI",XPDA,"QUES",X)),Z="" Q:X=""!($P(X,XPFR)]"")  D  I $D(DIRUT) S XPDQUIT=1 Q
 .S XPDJ=$S('XPFP:X,1:XPDI_$P(X,XPFR,2))
 .F  S Z=$O(^XTMP("XPDI",XPDA,"QUES",X,Z)) Q:Z=""  M DIR(Z)=^(Z)
 .;if there was a previous answer, reset DIR("B") to external or internal answer
 .S:$L($G(XPDQUES(XPDJ))) DIR("B")=$G(XPDQUES(XPDJ,"B"),XPDQUES(XPDJ)) D  Q:'$D(Y)
 ..N FLAG,X,Z K Y
 ..;this is the M CODE node that was set to DIR("M") in prev for loop
 ..;FLAG is used by KIDS questions
 ..I $D(DIR("M")) S %=DIR("M"),FLAG="" K DIR("M") X %
 ..Q:'$D(DIR)
 ..;'|' is used to mark variable in prompt, reset prompt with value of variable
 ..S:$G(DIR("A"))["|" DIR("A")=$P(DIR("A"),"|")_@$P(DIR("A"),"|",2)_$P(DIR("A"),"|",3)
 ..K:$G(DIR("B"))="" DIR("B")
 ..D ^DIR
 .S %=$P(DIR(0),U)
 .;read was optional and didn't timeout and user didn't enter anything
 .I %["O",'$D(DTOUT),$S(%["P":Y=-1,1:Y="") K DIRUT Q
 .;quit if the user up-arrowed out
 .Q:$D(DIRUT)
 .;if pointer, reset Y & Y(0)
 .I %["P" S Y(0)=$S(%["Z":$P(Y(0),U),1:$P(Y,U,2)),Y=+Y
 .;if Y(0) is not defined, but Y is
 .S:$D(Y)#2&'($D(Y(0))#2) Y(0)=Y
 .S XPDQUES(XPDJ)=Y,XPDQUES(XPDJ,"A")=$G(DIR("A")),XPDQUES(XPDJ,"B")=$G(Y(0))
 .K DIR
 K XPDJ S XPDI=XPFR
 ;code to save XPDQUES to INSTALL ANSWERS in file 9.7, loop thru the answers starting with the from value, XPFR
 F Y=1:1 S XPDI=$O(XPDQUES(XPDI)) Q:XPDI=""!($P(XPDI,XPFR)]"")  D
 .S X="XPDJ(9.701,""?+"_Y_","_XPDA_","")",@X@(.01)=XPDI,@X@(1)=$G(XPDQUES(XPDI,"A")),@X@(2)=$G(XPDQUES(XPDI,"B")),@X@(3)=XPDQUES(XPDI)
 K XPDI D:$D(XPDJ)>9 UPDATE^DIE("","XPDJ","XPDI")
 Q
 ;
QUES(X) ;build XPDQUES array, X="INI","INIT","XPF","XPM"
 ;move INSTALL ANSWERS from file 9.7 to XPDQUES
 ;XPDQUES(X)=internal answer, XPDQUES(X,"A")=prompt, XPDQUES(X,"B")=external answer.
 N Y,Z K XPDQUES S Z=X
 F  S Z=$O(^XPD(9.7,XPDA,"QUES","B",Z)) Q:Z=""!($P(Z,X)]"")  S Y=$O(^(Z,0)) D
 .Q:'$D(^XPD(9.7,XPDA,"QUES",Y,0))
 .S XPDQUES(Z)=$G(^(1)),XPDQUES(Z,"A")=$G(^("A")),XPDQUES(Z,"B")=$G(^("B")) ; ^(1) refer to prev line ^XPD(9.7,XPDA,"QUES","B",Z)
 Q
 ;
ANSWER(QUES) ;E.F. Return answer to question
 N IEN I '$D(XPDA)!($G(QUES)="") Q ""
 S IEN=$O(^XPD(9.7,XPDA,"QUES","B",QUES,0)) I IEN'>0 Q ""
 Q $G(^XPD(9.7,XPDA,"QUES",IEN,1))
 ;codes for install process questions
 ;XPDFIL=file #, XPDFILN=file name^global ref^partial DD
 ;XPDFILO=update DD^security codes^^^resolve pt^list template^data with file^add,merge,overwrite,replace^user override data update
 ;XPDSCR=screen to determine DD update
 ;XPDANS is define in QUES^XPDI
XPF1 ;write over existing file
 N XPDI
 W !!?3,XPDFIL,?13,$P(XPDFILN,U),$P("  (Partial Definition)",U,$P(XPDFILN,U,3)),$P("  (including data)",U,$P(XPDFILO,U,7)="y")
 ;file doesn't exists
 I XPDANS K DIR Q
 I $L($G(XPDSCR)) S XPDI=1 D  Q:'XPDI
 .X XPDSCR S XPDI=$T Q:XPDI
 .W !,"Data Dictionary FAILED the screening logic, file will NOT be installed!"
 .S $P(XPDANS,U,2)="1" K DIR
 S FLAG=$P($G(^DIC(XPDFIL,0)),U)
 ;file exist and has the same name
 I $P(FLAG,$P(XPDFILN,U))="" W !,"Note:  You already have the '",$P(XPDFILN,U),"' File." K DIR Q
 W *7,!,"*BUT YOU ALREADY HAVE '",FLAG,"' AS FILE #",XPDFIL,"!"
 S $P(XPDANS,U,4)=1
 Q
XPF2 ;data
 ;if they don't want to overwrite a file with a different name then set the DIRUT flag and ABORT, this will stop the rest of the questions and abort the install
 I $G(XPDQUES("XPF"_XPFP_1))=0 S DIRUT=1 K DIR Q
 ;if Data doesn't exists or DD failed screen or data wasn't sent, don't ask question
 I '$P(XPDANS,U,3)!$P(XPDANS,U,2)!($P(XPDFILO,U,7)'="y") K DIR Q
 S %=$F("amor",$P(XPDFILO,U,8))-1
 ;if this is add and file is not new
 I %=1 W !,"Data will NOT be added." K DIR Q
 ;check if dev. doesn't want to ask user
 I $P(XPDFILO,U,9)'="y" W !,"I will ",$P("^MERGE^OVERWRITE^REPLACE",U,%)," your data with mine." K DIR Q
 S FLAG=$P("^merged with^to overwrite^to replace",U,%)
 Q
 ;XPDDIQ(name)=internal value, (name,"A")=prompt, (name,"B")=external
XPQ(NM) ;Build XPDDIQ
 Q:'$D(XPDDIQ(NM))
 I $D(XPDDIQ(NM))#2 S XPDQUES(NM)=XPDDIQ(NM) K DIR Q
 S:$D(XPDDIQ(NM,"A")) DIR("A")=XPDDIQ(NM,"A")
 S:$D(XPDDIQ(NM,"B")) DIR("B")=XPDDIQ(NM,"B")
 Q
XPI1 ;Inhibit Logons
 D XPQ("XPI1")
 Q
XPM1 ;mail groups
 S FLAG=XPDANS
 ;DIR("B") is null if first time here
 I DIR("B")="" D
 .;check if mail group already exist
 .S X=$$FIND1^DIC(3.8,"","XQf",XPDANS,"","","")
 .;get the current coordinator
 .Q:'X  S X=$P($G(^XMB(3.8,X,0)),U,7)
 .;set the default to current coordinator
 .I X,$D(^VA(200,X,0))#10 S DIR("B")=$P(^(0),U)
 D XPQ("XPM1")
 Q
XPO1 ;rebuild menu trees
 D XPQ("XPO1")
 Q
XPZ1 ;disable options
 D XPQ("XPZ1")
 Q
XPZ2 ;move routines
 N Y
 ;if they are not in production UCI don't ask
 X ^%ZOSF("UCI") I Y'=^%ZOSF("PROD") K DIR Q
 ;if they are not running MSM don't ask
 I ^%ZOSF("OS")'["MSM" K DIR Q
 Q:'$D(XPDDIQ("XPZ2"))
 I $D(XPDDIQ("XPZ2"))#2 S XPDQUES("XPZ2")=XPDDIQ("XPZ2") K DIR Q
 S:$D(XPDDIQ("XPZ2","A")) DIR("A")=XPDDIQ("XPZ2","A")
 S:$D(XPDDIQ("XPZ2","B")) DIR("B")=XPDDIQ("XPZ2","B")
 Q
