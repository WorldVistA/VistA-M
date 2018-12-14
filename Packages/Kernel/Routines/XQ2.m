XQ2 ;SEA/MJM - Menu lister & Utilities ;Dec 13, 2018@11:01
 ;;8.0;KERNEL;**273,OSE/SMH**;Jul 10, 1995
 ; Original Routine authored by US Department of Veteans Affairs and in Public Domain
 ; OSE/SMH changes to support VistA Intenationalization
 ; Look for OSE/SMH for specific modifications
 ; (c) Sam Habiel 2018
 ; Licensed Under Apache 2.0
 ;
WRITE ;Get data for this option
 S XQSN=$P(X,U,(J*8+1)),XQNM=$P(X,U,(J*8+2)),XQTXT=$P(X,U,(J*8+3)),XQOO=$P(X,U,(J*8+4)),XQLK=$P(X,U,(J*8+5)),XQTM=$P(X,U,(J*8+6)),XQRD=$P(X,U,(J*8+7)),XQRL=$P(X,U,(J*8+8))
 Q:'$S($L(XQLK):XQUR="??"&(DUZ(0)="@"!(DUZ(0)="#")!($D(DUZ("SAV"))))!$D(^XUSEC(XQLK,DUZ)),1:1)
 Q:'$S($L(XQRL):XQUR="??"&(DUZ(0)="@"!(DUZ(0)="#")!($D(DUZ("SAV"))))!'$D(^XUSEC(XQRL,DUZ)),1:1)
 W !?3,XQSN,?10,XQTXT D MR:XQUR["??" S XQL=XQL-1 I 'XQL D PAUSE Q:'XQL
 I $L(XQOO) W !,?13,"**> "_$$EZBLD^DIALOG(19013)_":  ",XQOO S XQL=XQL-1 I 'XQL D PAUSE Q:'XQL           ; OSE/SMH DIALOG - Out of order
 I $L(XQTM) W !,?13,"**> "_$$EZBLD^DIALOG(19014)_" ",$P(X,U,(J*8+6)) S XQL=XQL-1 I 'XQL D PAUSE Q:'XQL  ; OSE/SMH DIALOG - Not available on
 I XQRD="y" W !,?13,"**> "_$$EZBLD^DIALOG(19015)_"." S XQL=XQL-1 I 'XQL D PAUSE Q:'XQL                  ; OSE/SMH DIALOG - Can't be run on all devices
 Q
MR W " ["_XQNM_"]" I XQLK]"" W !,?13,"**> "_$$EZBLD^DIALOG(19016)_" ",XQLK S XQL=XQL-1 I 'XQL D PAUSE Q:'XQL  ; OSE/SMH DIALOG - Locked with
 I XQRL]"" W !,?13,"**> "_$$EZBLD^DIALOG(19017)_" ",XQRL S XQL=XQL-1 I 'XQL D PAUSE Q:'XQL              ; OSE/SMH DIALOG - Reverse lock
 Q
 ;
 ; OSE/SMH - l10n
 ; was PAUSE R !!?15,"Press 'RETURN' to continue, '^' to stop: ",XQL:DTIME S XQL=$S(XQL[U:-1,1:XQLN) Q  ;W $C(13),$J("",15),$C(13) Q
PAUSE ;
 W !!?15
 W $$EZBLD^DIALOG(19004) ; DIALOG: RETURN, ^ to stop
 R XQL:DTIME
 S XQL=$S(XQL[U:-1,1:XQLN)
 QUIT
 ; /OSE/SMH - l10n
 ;
 ;
EN ;Entry point from XQ and XQT2 with +XQDIC
 I XQUR["????" S XQUR="?"_$G(^DIC(19,XQY,"U")) D:$L(XQUR>4) OPT^XQHLP G M2^XQ
 I XQUR["???" G EN^XQHLP
EN1 S XQLN=$S($D(IOSL):IOSL-2,1:18),XQL=XQLN,XQMMF=""
 L +^XUTL("XQO",XQDIC):5 D:$S('($D(^XUTL("XQO",XQDIC,0))#2):1,'$D(^DIC(19,XQDIC,99)):1,1:^DIC(19,XQDIC,99)'=$P(^XUTL("XQO",XQDIC,0),U,2)) ^XQSET L -^XUTL("XQO",XQDIC)
 S XQK=+$G(^XUTL("XQO",XQDIC,0)) W ! F XQI=1:1:XQK Q:XQL<0  S X=^XUTL("XQO",XQDIC,0,XQI) F J=0:1 Q:XQL<0!'$L($P(X,U,(J*8+1))_$P(X,U,(J*8+2)))  D WRITE
 G:XQL<0 BACK S XQJ=$S('$D(^VA(200,DUZ,200)):0,1:+$P(^(200),U,11)) G:(XQUR'="??")&'XQJ BACK
 ;
 I $S('$D(^VA(200,DUZ,203)):1,$P(^(203,0),U,4)'>0:1,1:0) G COM
 S XQDIC="U"_DUZ,XQL=XQL-3 D:XQL<1 PAUSE G:'XQL BACK W !!,$$EZBLD^DIALOG(19018)_":",! ; OSE/SMH DIALOG - You can also select a secondary option
 D:$S('($D(^XUTL("XQO",XQDIC,0))#2):1,'$D(^VA(200,DUZ,203.1)):1,1:^VA(200,DUZ,203.1)'=$P(^XUTL("XQO",XQDIC,0),U,2)) ^XQSET
 S XQK=+^XUTL("XQO",XQDIC,0) F XQI=1:1:XQK Q:XQL<0  S X=^XUTL("XQO",XQDIC,0,XQI) F J=0:1 Q:XQL<0!'$L($P(X,U,(J*8+1))_$P(X,U,(J*8+2)))  D WRITE G:XQL<0 BACK
 ;
COM S XQL=XQL-3 D:XQL<1 PAUSE G:XQL<0 B2 W !!,$$EZBLD^DIALOG(19019)_":",! D:XQL<1 PAUSE G:XQL<0 B2 S XQDIC=$O(^DIC(19,"B","XUCOMMAND",0)) S:XQDIC="" XQDIC=-1 ; OSE/SMH DIALOG - Or a Common Option
 D:$S('($D(^XUTL("XQO",XQDIC,0)))#2:1,'$D(^DIC(19,XQDIC,99)):1,1:^DIC(19,XQDIC,99)'=$P(^XUTL("XQO",XQDIC,0),U,2)) ^XQSET
 S XQK=+^XUTL("XQO",XQDIC,0) F XQI=1:1:XQK Q:XQL<0  S X=^XUTL("XQO",XQDIC,0,XQI) F J=0:1 Q:XQL<0!'$L($P(X,U,(J*8+1))_$P(X,U,(J*8+2)))  D WRITE
 S XQUR=0
BACK I XQUR["?" W !!,$$EZBLD^DIALOG(19020) ; OSE/SMH DIALOG; was W !!,"Enter " W:XQUR="?" "?? for more options, " W "??? for brief descriptions, ?OPTION for help text."
B2 W ! K XQSN,XQNM,XQTXT,XQOO,XQL,XQLK,XQLN,XQTM,XQRD,XQRL,D
 S XQDIC=+^(^XUTL("XQ",$J,"T"))
 G M2^XQ
 ;
M6 ;
 I $E(XQDIC,1)="U" D:$S('($D(^XUTL("XQO",XQDIC,0))#2):1,'$D(^VA(200,DUZ,203.1)):1,1:^VA(200,DUZ,203.1)'=$P(^XUTL("XQO",XQDIC,0),U,2)) ^XQSET
 I XQDIC=+XQDIC L +^XUTL("XQO",XQDIC):5 D:$S('($D(^XUTL("XQO",XQDIC,0))#2):1,'$D(^DIC(19,XQDIC,99)):1,1:^DIC(19,XQDIC,99)'=$P(^XUTL("XQO",XQDIC,0),U,2)) ^XQSET L -^XUTL("XQO",XQDIC)
 Q
LIST S XQK=+^XUTL("XQO",XQDIC,0),XQLN=$S($D(IOSL):IOSL-2,1:18),XQL=XQLN
 F XQI=1:1:XQK Q:XQL<0  S X=^XUTL("XQO",XQDIC,0,XQI) F J=0:1 Q:XQL<0!'$L($P(X,U,(J*8+1))_$P(X,U,(J*8+2)))  D WRITE
 Q
 ;
HS W " [Extended Help Available]" Q
 Q
DISP ;
 S XQDIC=D0,XQUR="?." S X=^DIC(19,D0,0) I $P(X,U,4)="M" W !,"Menu: " S XQL=999 D M6,LIST W ! S X="" K D Q
 I $P(X,U,4)="A" S X="Action: "_$S($D(^DIC(19,D0,20)):^(20),1:"") W !?3,X,! Q
 I $P(X,U,4)="R" S X="Run routine: "_$S($D(^DIC(19,D0,25)):^(25),1:"") W !?3,X,! Q
 I $P(X,U,4)="E" S X="Edit file: "_$S($D(^DIC(19,D0,50)):^(50),1:"") W !?3,X,! Q
 I $P(X,U,4)="P" S X="Print file "_$S($D(^DIC(19,D0,60)):^(60),1:"") W !?3,X,! Q
 Q
