XPDCOM ;SFISC/RSD - Compare Transport Global ;08/14/2008
 ;;8.0;KERNEL;**21,58,108,124,393,506,539,547**;Jul 10, 1995;Build 15
 ;Per VHA Directive 2004-038, this routine should not be modified.
EN1 ;compare to current system
 N DIC,DIR,DIRUT,DITCPT,DTOUT,DUOUT,POP,XPD,XPDA,XPDC,XPDNM,XPDT,XPDST,XPDUL,Y,Z,%ZIS
 S XPDST=$$LOOK^XPDI1("I '$P(^(0),U,9),$D(^XTMP(""XPDI"",Y))",1) Q:XPDST'>0
 S DIR(0)="SO^1:Full Comparison;2:Second line of Routines only;3:Routines only;4:Old style Routine compare",DIR("A")="Type of Compare",DIR("?")="Enter the type of comparison." ;rwf
 D ^DIR Q:Y=""!$D(DTOUT)!$D(DUOUT)
 S XPDC=Y,Y="JOB^XPDCOM",Z="Transport Global Compare",XPD("XPDNM")="",XPD("XPDC")="",XPD("XPDT(")=""
 D EN^XUTMDEVQ(Y,Z,.XPD)
 Q
 ;
JOB ;Loop thru XPDT
 N XPDIT
 F XPDIT=0:0 S XPDIT=$O(XPDT(XPDIT)) Q:XPDIT'>0  D COM(+XPDT(XPDIT))
 Q
 ;
COM(XPDA) ;XPDA=ien of package in ^XTMP("XPDI"
 Q:'$D(^XTMP("XPDI",$G(XPDA)))
 S:$D(XPDT("DA",XPDA)) XPDNM=$P(XPDT(+XPDT("DA",XPDA)),U,2)
 D HDR,COMR,EN^XPDCOMG:XPDC=1
 W !!
 Q
 ;
COMR ;compare routines
 N DL,NAME,RM,XL,XPDI,X,XL,Y,YL,XPDHEAD
 S (NAME,XPDI)="",RM=IOM/2-8
 F  S XPDI=$O(^XTMP("XPDI",XPDA,"RTN",XPDI)) Q:XPDI=""  S X=+$G(^(XPDI)) D
 .S NAME=" Routine: "_XPDI,XPDHEAD=0
 .I X W:X=1 !!,"*DELETE*",NAME,! Q
 .S X=XPDI X ^%ZOSF("TEST") E  W !!,"*ADD*",NAME,! Q
 .;check 2nd line only
 .I XPDC=2 D  Q
 ..S XL(2)=$G(^XTMP("XPDI",XPDA,"RTN",XPDI,2,0)),YL(2)=$T(+2^@XPDI)
 ..D EN^XPDCOML("XL","YL",NAME)
 ..W:'XPDHEAD !,?IOM-$L(NAME)\2,NAME
 ..W !
 ..;lines the same or site routine has no patches
 ..I XL(2)=YL(2)!(YL(2)'["**") Q
 ..;check patch string
 ..S X=$P(XL(2),"**",2),XL=$L(X,","),Y=$P(YL(2),"**",2),YL=$L(Y,",")
 ..Q:X=Y
 ..;incoming has more patches than system, remove last patch and check if the same
 ..I XL>YL W:$P(X,",",1,(XL-1))'=Y "*** WARNING, you are missing one or more Patches ***",! Q
 ..;incoming has less patches
 ..I YL>XL W "*** WARNING, your routine has more patches than the incoming routine ***",! Q
 ..;incoming has same number of patches, check if they are the same
 ..I XL=YL,X'=Y W "*** WARNING, your routine has different patches than the incoming routine ***",! Q
 ..Q
 .;get number of lines in rouitine, XL
 .F X=1:1 Q:'$D(^XTMP("XPDI",XPDA,"RTN",XPDI,X))
 .S XL=X-1
 .K ^TMP($J,XPDI)
 .F X=1:1 S Y=$T(+X^@XPDI) Q:Y=""  S ^TMP($J,XPDI,X,0)=Y
 .S DL=X-1 ;number of line in routine on disk
 .D EN^XPDCOML($NA(^XTMP("XPDI",XPDA,"RTN",XPDI)),$NA(^TMP($J,XPDI)),NAME):XPDC<4,COMP:XPDC=4
 .W:'XPDHEAD !,?IOM-$L(NAME)\2,NAME
 .W ! K ^TMP($J,XPDI)
 .Q
 I NAME="" W ?RM,"No Routines"
 Q
 ;
COMP ;taken from XMPC routine
 N D1,DI,I,J,K,NL,X1,XI,Y1
 S (XI,DI)=0,NL=5,XPDHEAD=1
 W !,?IOM-$L(NAME)\2,NAME
 ;check each line in the incoming routine,X1, against the routine on disk,D1
 F  S XI=XI+1,DI=DI+1 Q:XI>XL!(DI>DL)  D:^XTMP("XPDI",XPDA,"RTN",XPDI,XI,0)'=^TMP($J,XPDI,DI,0)
 .S X1=^XTMP("XPDI",XPDA,"RTN",XPDI,XI,0),Y1=0
 .;if lines are not the same, look ahead five lines in D1
 .F I=DI:1:$S(DI+NL<DL:DI+NL,1:DL) S D1=^TMP($J,XPDI,I,0) D  Q:Y1
 ..F K=1:5:26 Q:$L($E(D1,K,K+10))<7  I $F(X1,$E(D1,K,K+10))  D  Q
 ...;print the lines upto the line that are the same
 ...F J=DI:1:I-1 D WP(^TMP($J,XPDI,J,0),2)
 ...;quit if the lines are equal
 ...S DI=I,Y1=1 Q:D1=X1
 ...;if lines are equal, print old and new
 ...D WP(D1,3),WP(X1,4)
 .Q:Y1  D WP(X1,1) S DI=DI-1
 ;check remaining lines in routines
 I XI>XL&(DI<(DL+1)) F I=DI:1:DL D WP(^TMP($J,XPDI,I,0),2)
 I DI>DL&(XI<(XL+1)) F I=XI:1:XL D WP(^XTMP("XPDI",XPDA,"RTN",XPDI,I,0),1)
 Q
WP(X,Y) ;
 W !,"* "_$P("ADD^DEL^OLD^NEW",U,Y)_" *  ",X
 Q
 ;
HDR ;
 S $P(XPDUL,"-",80)=""
 W @IOF,!,"Compare KIDS package ",XPDNM," to current site (Disk)"
 W !,"Site: ",$$KSP^XUPARAM("WHERE")
 D GETENV^%ZOSV W "  UCI: ",$P(Y,U),",",$P(Y,U,2),"  ",?IOM/2+2,$$FMTE^XLFDT($$NOW^XLFDT()),!
 I XPDC>1 W:XPDC=2 "2nd Line of " W "Routines Only",!
 W ?3,"KIDS",?IOM\2+3,"Disk",!
 W XPDUL,!
 Q
