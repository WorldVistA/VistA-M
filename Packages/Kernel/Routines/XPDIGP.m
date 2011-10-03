XPDIGP ;SFISC/RSD - load Global Distribution ;05/17/2006
 ;;8.0;KERNEL;**41,422**;Jul 10, 1995;Build 2
 ;XPDT is undefine if PKG^XPDIL1 aborted, need to close device
 I '$D(XPDT) D ^%ZISC Q
 N %,XPD,XPDIST,XPDBLD,XPDNM
 S XPDA=+XPDT(1),XPDNM=$P(XPDT(1),U,2),XPDBLD=$O(^XTMP("XPDI",XPDA,"BLD",0))
 ;update Install file, read in the other globals, close device
 D XPCK,GPI:'$G(XPDQUIT),^%ZISC
 I $G(XPDQUIT) D ABRTALL^XPDI(1) Q
 ;run post install routine
 S XPD=$$INRTN^XPDIL1("INIT") I XPD]"" D
 .;% = routine name only, remove tag
 .S %=$P(XPD,U,$L(XPD,U)) Q:'$D(^XTMP("XPDI",XPDA,"RTN",%))
 .W ! D SAVE^XPDIJ(%),BMES^XPDUTL(" Running Post Install routine "_XPD),@XPD
 .;update Package file
 ;XPDIST is flag for site tracking, it is set in PKG^XPDIP
 S XPDIST=0 D BMES^XPDUTL(" Updating KIDS files... "),PKG^XPDIP
 ;sends site tracking bulletin
 I XPDIST S %=$$EN^XPDIST(XPDA) D BMES^XPDUTL(" "_$P("NO ",U,'%)_"Install Message sent to FORUM ")
 W !! D BMES^XPDUTL(" "_XPDNM_" Installed."),STMP^XPDIJ1(17) W !!
 K ^XTMP("XPDI",XPDA),XPD
 ;update the status field
 S XPD(9.7,XPDA_",",.02)=3 D FILE^DIE("","XPD")
 Q
DISP ;display the contents
 N X,Y,Z
 W !,"This is a Global Distribution. It contains Global(s) that will",!,"update your system at this time. The following Global(s) will be installed:",!!
 F Y=1:1 S X=$P(XPDGP,"^",Y) Q:X=""  D
 .S Z=+$P(X,";"),X=$P(X,";",2),XPDT("GP",X)=Z_U_Y
 .W "^"_X,?12,$P("Overwrite^Replace",U,Z+1),!
 .;if unsubscripted global and replacing
 .W:X'["("&Z "**WARNING - Global will be KILLED before install,",!,"Check global protection on ALL systems before continuing.",!
 W !,"If you continue with the Load, the Global(s) will be",!,"Installed at this time.",!
 Q
GPI ;global package input
 N DIRUT,GP,GR,X,XPDSEQ,Y,Z
 ;start reading the HFS again,  rwf, changed all read timeout from 0 to 1.
 U IO R X:10,Y:10
 ;the next read must be the GLOBAL
 I X'="**GLOBAL**" U IO(0) W !!,"ERROR in HFS file format!" S XPDQUIT=1 Q
 U IO(0) D BMES^XPDUTL(" "_Y) U IO
 ;XPDSEQ is the disk sequence number
 S GP=$P(Y,U,2),GR=$S(Y[")":$E(Y,1,$L(Y)-1)_",",1:Y_"("),XPDSEQ=1
 K:XPDT("GP",GP) @Y
 ;X=global ref, Y=global value. DIRUT is when user is prompted for
 ;next disk in NEXTD and they abort
 F  R X:10,Y:10 Q:X="**END**"  D  I $D(DIRUT) S XPDQUIT=1 Q
 .;new global
 .I X="**GLOBAL**" D  Q
 ..;completes last global check point
 ..D XPCOM(GP,Y)
 ..;reset global ref
 ..S GP=$P(Y,U,2),GR=$S(Y[")":$E(Y,1,$L(Y)-1)_",",1:Y_"(")
 ..;kill global if flag is set
 ..K:XPDT("GP",GP) @Y
 .I X="**CONTINUE**" D NEXTD^XPDIL Q
 .S @(GR_X)=Y
 D XPCOM(GP)
 U IO(0)
 Q
 ;
 ;create Global multiple of Install file
XPCK N DIR,DIRUT,X,XPD,XPDJ,X,Y,Z
 S DIR(0)="Y",DIR("A")="Globals will now be installed, OK",DIR("B")="YES",DIR("?")="YES will continue with install, NO will abort install"
 W ! D ^DIR I $D(DIRUT)!'Y S XPDQUIT=1 Q
 W ! D BMES^XPDUTL(" Install Started for "_XPDNM_" : "),STMP^XPDIJ1(11),BMES^XPDUTL(" Installing Globals:")
 S X=""
 F  S X=$O(XPDT("GP",X)) Q:X=""  S Z=$P(XPDT("GP",X),U,2),XPD(9.718,"+"_Z_","_XPDA_",",.01)=X,XPDJ(Z)=Z
 D:$D(XPD)>9 UPDATE^DIE("S","XPD","XPDJ")
 Q
 ;
XPCOM(X,XPDN) ;complete checkpoint for global X,XPDN=next global
 N GR,GP,XPD,Y,Z
 U IO(0)
 S Y=$$NOW^XLFDT,Z=+$P(XPDT("GP",X),U,2),XPD(9.718,Z_","_XPDA_",",1)=Y
 D MES^XPDUTL("               "_$$FMTE^XLFDT(Y)),FILE^DIE("","XPD")
 D:$L($G(XPDN)) BMES^XPDUTL(" "_XPDN)
 U IO
 Q
