XPDIPM ;SFISC/RSD - Load a Packman Message ;05/05/2008
 ;;8.0;KERNEL;**21,28,68,108,755**;Jul 05, 1995;Build 6
 Q:'$D(^XMB(3.9,+$G(XMZ),0))
 N X,XPD,Y S XPD=0
 F  S XPD=$O(^XMB(3.9,XMZ,2,XPD)) Q:+XPD'=XPD  S X=^(XPD,0) I $E(X,1,11)="$TXT $KIDS " Q
 S Y=$P(X,"$KIDS ",2)
EN I 'XPD!'$L(Y) W !!,"Couldn't find a KIDS package!!",*7 Q
 N DIR,DIRUT,GR,XPDA,XPDST,XPDIT,XPDT,XPDNM,XPDQUIT,XPDREQAB
 S XPDST("H1")=$P(^XMB(3.9,XMZ,0),U),XPDST=0,XPDIT=1
 S XPDA=$$INST^XPDIL1(Y) G:'XPDA NONE^XPDIL
 W !,"Distribution OK!",! ;p755
 S DIR(0)="Y",DIR("A")="Want to Continue with Load",DIR("B")="YES"
 ;p345-rename AND* to XPD*-Patch was Cancelled keep code for future.
 I '$G(XPDAUTO) D ^DIR S:$G(XPDAUTO) Y=1 I 'Y!$D(DIRUT) D ABRTALL^XPDI(1) G NONE^XPDIL
 W !,"Loading Distribution...",!
 S ^XTMP("XPDI",0)=$$FMADD^XLFDT(DT,7)_U_DT
 D GI I $G(XPDQUIT) D ABRTALL^XPDI(1) G NONE^XPDIL
 D PKG^XPDIL1(XPDA)
 Q
GI D NXT Q:$G(XPDQUIT)
 I X'="**INSTALL NAME**"!'$D(XPDT("NM",Y)) S XPDQUIT=1 Q
 S GR="^XTMP(""XPDI"","_XPDA_","
 F  D NXT Q:X=""!$D(XPDQUIT)  D
 .S @(GR_X)=Y
 Q
NXT S (X,Y)="",XPD=$O(^XMB(3.9,XMZ,2,XPD)) G:+XPD'=XPD ERR S X=^(XPD,0)
 I $E(X,1,5)="$END " S X="" Q
 S XPD=$O(^XMB(3.9,XMZ,2,XPD)) G:+XPD'=XPD ERR
 S Y=^XMB(3.9,XMZ,2,XPD,0)
 Q
XMP2 ;called from XMP2
 N X,XPD,Y
 S XPD=XCN,X=$G(^XMB(3.9,XMZ,2,XPD,0)),Y=$P(X,"$KID ",2)
 D EN
 S XMOUT=1
 Q
ERR W !!,"Error in Packman Message, ABORTING load!!"
 S (X,Y)="",XPDQUIT=1
 Q
