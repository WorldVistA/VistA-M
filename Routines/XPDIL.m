XPDIL ;SFISC/RSD - load Distribution Global ;05/05/2008
 ;;8.0;KERNEL;**15,44,58,68,108,422,525**;Jul 10, 1995;Build 10
 ;
EN1 N POP,XPDA,XPDST,XPDIT,XPDT,XPDGP,XPDQUIT,XPDREQAB,XPDSKPE
 S:'$D(DT) DT=$$DT^XLFDT S:'$D(U) U="^"
 S XPDST=0
 D ST I $G(XPDQUIT) D ABRTALL^XPDI(1) G NONE
 ;XPDST= starting Build
 ;XPDT("DA",ien)=seq # to install
 ;XPDT("NM",build name)=seq #
 ;XPDT(seq #)=ien^Build name
 ;XPDT("GP",global)= 1-replace, 0-overwrite^ien
 ;XPDGP=globals from a Global Package
 ;XPDSKPE=1 don't run Environment Check^has question been asked
 S XPDIT=0,XPDSKPE="0^0"
 F  S XPDIT=$O(XPDT(XPDIT)) Q:'XPDIT  S XPDA=+XPDT(XPDIT) D  I '$D(XPDT) Q
 .;check if this Build has an Envir. Check
 .I $G(^XTMP("XPDI",XPDA,"PRE"))]"" D  I $G(XPDQUIT) D ABRTALL^XPDI(1) Q
 ..;quit if we already asked this question
 ..Q:$P(XPDSKPE,U,2)
 ..S $P(XPDSKPE,U,2)=1
 ..N DIR,DIRUT
 ..S DIR(0)="Y",DIR("A")="Want to RUN the Environment Check Routine",DIR("B")="YES"
 ..S DIR("A",1)="Build "_$P(XPDT(XPDIT),U,2)_" has an Environmental Check Routine"
 ..D ^DIR I $D(DIRUT) S XPDQUIT=1 Q
 ..S:'Y XPDSKPE="1^1"
 .D PKG^XPDIL1(XPDA)
 ;Global Package
 G:$D(XPDGP) ^XPDIGP
 I $D(XPDT),$D(^XPD(9.7,+XPDST,0)) W !,"Use INSTALL NAME: ",$P(^(0),U)," to install this Distribution.",!
 Q
ST ;global input
 N DIR,DIRUT,GR,IOP,X,Y,Z,%ZIS
 G:'$D(^DD(3.5,0)) OPEN
 I '$D(^%ZIS(1,"B","HFS")) W !!,"You must have a device called 'HFS' in order to load a distribution!",*7 S XPDQUIT=1 Q
 D HOME^%ZIS
 S DIR(0)="F^3:75",DIR("A")="Enter a Host File",DIR("?")="Enter a filename and/or path to input Distribution."
 D ^DIR I $D(DIRUT) S XPDQUIT=1 Q
 S %ZIS="",%ZIS("HFSNAME")=Y,%ZIS("HFSMODE")="R",IOP="HFS"
 D ^%ZIS I POP W !,"Couldn't open file or HFS device!!",*7 S XPDQUIT=1 Q
 ;don't close device if we have a global package, we need to bring in the globals now
 D GI,^%ZISC:'$D(XPDGP)!$G(XPDQUIT)
 Q
 ;
 ;if no device file, Virgin Install
OPEN ;use open command
 N IO,IOPAR,DIR,DIRUT,DTOUT,DUOUT
 S DIR(0)="F^1:79",DIR("A")="Device Name"
 S DIR("?",1)="Device Name is either the name of the HFS file or the name of the HFS Device.",DIR("?",2)="i.e.  for MSM enter  51",DIR("?")="      for DSM enter  DISK$USER::[ANONYMOUS]:KRN8.KID"
 D ^DIR I $D(DIRUT) S POP=1 Q
 S IO=Y,DIR(0)="FO^1:79",DIR("A")="Device Parameters"
 S DIR("?",1)="Device Parameter is the Open parameter this M operating system needs to",DIR("?",2)="open the Device Name.",DIR("?",3)="i.e. for MSM enter  (""B:\KRN8.KID"":""R"")",DIR("?")="     for DSM enter  READONLY"
 D ^DIR I $D(DTOUT)!$D(DUOUT) S POP=1 Q
 S IOPAR=Y
 X "O IO:"_IOPAR_":10" E  U $P W !,"Couldn't open ",IO S POP=1 Q
 S IO(0)=$P
 D GI D ^%ZISC
 Q
 ;
GI N X,XPDSEQ,Y,Z
 U IO R X:10,Y:10 ;rwf was :0
 U IO(0) W !!,X,!,"Comment: ",Y
 S XPDST("H")=Y,XPDST("H1")=Y_"  ;Created on "_$P(X,"KIDS Distribution saved on ",2)
 ;Z is the string of Builds in this file
 U IO F X=1:1 R Z:1 S Z=$P(Z,"**KIDS**",2,99) Q:Z=""  S X(X)=Z
 U IO(0) I $G(X(1))="" W !!,"This is not a Distribution HFS File!" S XPDQUIT=1 Q
 ;global package, set XPDGP=flag;global^flag;global^...  flag=1 replace
 I $P(X(1),":")="GLOBALS" S XPDGP=$P(X(1),U,2,99),X(1)=$P(X(1),U)
 S XPDIT=0,X(1)=$P(X(1),":",2,99)
 W !!,"This Distribution contains Transport Globals for the following Package(s):"
 F X=1:1:X-1 F Z=1:1 S Y=$P(X(X),U,Z) Q:Y=""  D  Q:$G(XPDQUIT)
 . ;can't install if global exist, that means Build never finish install
 . ;INST will show name
 . S XPDIT=XPDIT+1 I '$$INST^XPDIL1(Y) S XPDQUIT=1 Q
 Q:$G(XPDQUIT)
 W !,"Distribution OK!",!
 D:$D(XPDGP) DISP^XPDIGP
 S DIR(0)="Y",DIR("A")="Want to Continue with Load",DIR("B")="YES"
 D ^DIR I $D(DIRUT)!'Y S XPDQUIT=1 Q
 W !,"Loading Distribution...",!
 ;reset expiration date to T+7 on transport global
 S ^XTMP("XPDI",0)=$$FMADD^XLFDT(DT,7)_U_DT
 ;start reading the HFS again
 U IO R X:10,Y:10 ;rwf was :0
 ;the next read must be the INSTALL NAME
 I X'="**INSTALL NAME**"!'$D(XPDT("NM",Y)) U IO(0) W !!,"ERROR in HFS file format!" S XPDQUIT=1 Q
 ;XPDSEQ is the disk sequence number
 S %=XPDT("NM",Y),GR="^XTMP(""XPDI"","_+XPDT(%)_",",XPDSEQ=1
 ;X=global ref, Y=global value. DIRUT is when user aborts
 ;rwf next line was :0
 F  R X:10,Y:10 Q:X="**END**"  D  I $D(DIRUT) S XPDQUIT=1 Q
 .I X="**INSTALL NAME**" D  Q
 ..S %=+$G(XPDT("NM",Y)) I '% S DIRUT=1 Q
 ..S GR="^XTMP(""XPDI"","_+XPDT(%)_","
 .S @(GR_X)=Y
 U IO(0)
 Q
 ;
NONE W !!,"**NOTHING LOADED**",!
 Q
