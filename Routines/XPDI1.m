XPDI1 ;SFISC/RSD - Cont of Install Process ;10/28/2002  17:14
 ;;8.0;KERNEL;**58,61,95,108,229,275**;Jul 10, 1995
 ;lookup into file 9.7, XPDS=DIC("S") for lookup
 ;return 0-fail or ien, XPDT=array of linked builds
LOOK(XPDS,XPDL) ;lookup Install
 N DIC,Y,XPD,XPDIT,%
 S DIC(0)="QEAMZ",DIC="^XPD(9.7,"
 S:$L($G(XPDS)) DIC("S")=XPDS
 D ^DIC Q:Y<0 0
 I '$G(XPDL) L +^XPD(9.7,+Y,0):0 E  W !,"Being accessed by another user" Q 0
 S XPD=+Y,XPDIT=0
 W !!,"This Distribution was loaded on ",$$FMTE^XLFDT($P(Y(0),U,3))," with header of ",!?3,$G(^XPD(9.7,XPD,2)),!?3,"It consisted of the following Install(s):",!
 ;build XPDT array
 I '$D(^XPD(9.7,"ASP",XPD)) D XPDT(1,XPD) Q XPD
 F  S XPDIT=$O(^XPD(9.7,"ASP",XPD,XPDIT)) Q:'XPDIT  S Y=+$O(^(XPDIT,0)) D XPDT(XPDIT,Y)
 I '$O(XPDT(0)) S XPDQUIT=1 D QUIT(XPD)
 Q XPD
 ;
QUIT(Y) ;unlock ien Y
 L -^XPD(9.7,+Y) Q
 ;
XPDT(P1,P2) ;Build XPDT array
 N % S %=$P($G(^XPD(9.7,P2,0)),U)
 I %="" W:$X ! W "**ERROR in Install, You need to remove the Distribution and reload it**",!  S XPDQUIT=1 Q
 S XPDT(P1)=P2_U_%,(XPDT("DA",P2),XPDT("NM",%))=P1 W:$X>64 ! W $J(%,15)
 Q
 ;
QUES(XPDA) ;install questions; XPDA=ien in file 9.7
 N XPDANS,XPDFIL,XPDFILN,XPDFILO,XPDFLG,XPDNM,XPDQUES,X,Y
 S XPDNM=$P(^XPD(9.7,XPDA,0),U) W !!,"Install Questions for ",XPDNM,!
 ;pre-init questions
 D DIR^XPDIQ("PRE") I $D(XPDQUIT) D ASKABRT^XPDI Q
 ;file install questions
 S (XPDFIL,XPDFLG)=0
 F  S XPDFIL=$O(^XTMP("XPDI",XPDA,"FIA",XPDFIL)) Q:'XPDFIL  S X=^(XPDFIL),X(0)=^(XPDFIL,0),X(1)=^(XPDFIL),XPDFILO=^(0,1) D  Q:$D(XPDQUIT)
 .;check for DD screening logic
 .I $G(^(10))]"" N XPDSCR S XPDSCR=^(10) ;^(10) is ref to ^XTMP("XPDI",XPDA,"FIA",XPDFIL,0,10) from prev line
 .;XPDFILN=file name^global ref^partial DD
 .;XPDANS=new file^DD screen failed^Data exists^update file name^user
 .;doesn't want to update data  1=yes,0=no
 .S XPDFILN=X_X(0)_U_X(1),XPDANS='($D(^DIC(XPDFIL,0))#2)_"^^"_''$O(@(X(0)_"0)"))
 .I 'XPDFLG W !,"Incoming Files:" S XPDFLG=1
 .W ! D DIR^XPDIQ("XPF",XPDFIL_"#") Q:$D(XPDQUIT)
 .S:$G(XPDQUES("XPF"_XPDFIL_"#2"))=0 $P(XPDANS,U,5)=1
 .S ^XTMP("XPDI",XPDA,"FIA",XPDFIL,0,2)=XPDANS
 .;kill the answers so we can re-ask for next file
 .F I=1:1:2 K XPDQUES("XPF"_XPDFIL_"#"_I)
 ;XPDQUIT is by file questions in previous do loop, set in XPDIQ
 I $D(XPDQUIT) D ASKABRT^XPDI Q
 ;ask for coordinators to incoming mail groups
 S (XPDFIL,XPDFLG)=0
 F  S XPDFIL=$O(^XTMP("XPDI",XPDA,"KRN",3.8,XPDFIL)) Q:'XPDFIL  S X=^(XPDFIL,0),Y=$G(^(-1)) D  Q:$D(XPDQUIT)
 .;XPDANS=Mail Group name
 .Q:$P(Y,U)=1  ;Don't ask if deleting
 .S XPDANS=$P(X,U)
 .I 'XPDFLG W !!,"Incoming Mail Groups:" S XPDFLG=1
 .W ! D DIR^XPDIQ("XPM",XPDFIL_"#") Q:$D(XPDQUIT)
 .;kill the answers so we can re-ask for next MG
 .K XPDQUES("XPM"_XPDFIL_"#1")
 .Q
 I $D(XPDQUIT) D ASKABRT^XPDI Q
 ;ask to rebuild menus if Option is added
 S (XPDFIL,XPDFLG)=0
 S XPDFIL=$O(^XTMP("XPDI",XPDA,"KRN",19,XPDFIL))  D:XPDFIL
 .S X=^XTMP("XPDI",XPDA,"KRN",19,XPDFIL,0)
 .;XPDANS=Menu Rebuild Answer
 .S XPDANS=$P(X,U)
 .W ! D DIR^XPDIQ("XPO") Q:$D(XPDQUIT)
 I $D(XPDQUIT) D ASKABRT^XPDI Q
 ;post-init questions
 W ! D DIR^XPDIQ("POS") I $D(DIRUT)!$D(XPDQUIT) D ASKABRT^XPDI Q
 Q
 ;
XQSET(XPDA) ;get options & protocols to disable
 ;put in ^TMP($J,"XQOO",starting build name)
 N A,I,X,Y
 S I=0 F  S I=$O(^XTMP("XPDI",XPDA,"KRN",19,I)) Q:'I  S X=^(I,0),A=^(-1) D
 .S Y=$O(^DIC(19,"B",$P(X,U),0))
 .;check that option exist and 0=send,1=delete,3=merge or 5=disable
 .I Y,$D(^DIC(19,Y,0)),$S('A:1,1:A#2) S ^TMP($J,"XQOO",XPDSET,19,Y)=$P(^(0),U,1,2)
 S I=0 F  S I=$O(^XTMP("XPDI",XPDA,"KRN",101,I)) Q:'I  S X=^(I,0),A=^(-1) D
 .S Y=$O(^ORD(101,"B",$P(X,U),0))
 .I Y,$D(^ORD(101,Y,0)),$S(A=3:1,A=5:1,1:'A) S ^TMP($J,"XQOO",XPDSET,101,Y)=$P(^(0),U,1,2)
 Q
 ;XPDIJ need to install XPDIJ now & set routine flag to skip
XPDIJ N DIE,XPDA,XCM,XCN,XCS,X
 S XPDA=XPDIJ,DIE="^XTMP(""XPDI"",XPDIJ,""RTN"",""XPDIJ"",",XCN=0,X="XPDIJ"
 X ^%ZOSF("SAVE") D RTNLOG^XPDUTL("XPDIJ") ;Save and update ROUTINE file
 S XCN=$$RTNUP^XPDUTL("XPDIJ",2)
 Q
