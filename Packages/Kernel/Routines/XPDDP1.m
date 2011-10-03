XPDDP1 ;SFISC/RSD - Continue Display a package ;
 ;;8.0;KERNEL;**525**;Jul 10, 1995;Build 10
 ; Per VHA Directive 2004-038, this routine should not be modified.
PNT(XPDGR) ; Print a package, XPDGR=global root
 ;XPDFL=0 - Build   - ^XPD(9.7 global root
 ;      1 - Install - ^XTMP global root
 ;      2 - Packman - ^TMP($J, global root
 N I,J,K,X,XPD,XPDDT,XPDI,XPD0,XPDFL,XPDPG,XPDUL,XPDTYPE,XPDTRACK,XPDTXT
 Q:$G(XPDGR)=""  S XPDGR="^"_XPDGR
 Q:'$D(@XPDGR@(0))  S XPD0=^(0)
 D ID                     ; Package Identification
 D DESCR Q:$D(DIRUT)      ; Description
 I XPDTYPE=1 D MULT Q     ; Multi-Package
 D PREPOST Q:$D(DIRUT)    ; Environment check & Pre/Post Routines
 I XPDTYPE=2 D GLOBAL Q   ; Global Package
 D FILES Q:$D(DIRUT)      ; Files/DDs
 D COMP Q:$D(DIRUT)       ; Build Components
 Q:XPDFL=2  ; Packman message, called from XMP2 - Summarize
 D QUESTS Q:$D(DIRUT)     ; Install Questions
 D ALFABETA Q:$D(DIRUT)   ; Alpha/Beta Testing
 D NAMESP Q:$D(DIRUT)     ; Include/Exclude Namespaces
 D REQDBLD Q:$D(DIRUT)    ; Required Builds
 Q
ID ; Identify the package
 S XPDPG=1,XPDFL=$S($E(XPDGR,1,5)="^TMP(":2,1:$E(XPDGR,1,5)="^XTMP"),$P(XPDUL,"-",IOM)="",XPDDT=$$HTE^XLFDT($H,"1PM"),XPDTYPE=+$P(XPD0,U,3),XPDTRACK=$P(XPD0,U,5)
 W:$E(IOST,1,2)="C-" @IOF D HDR W !,XPDUL
 W !,"TYPE: ",$$EXTERNAL^DILFD(9.6,2,"",XPDTYPE)
 W ?51,"TRACK NATIONALLY: ",$$EXTERNAL^DILFD(9.6,5,"",XPDTRACK)
 W !,"NATIONAL PACKAGE: ",$P($G(^DIC(9.4,+$P(XPD0,U,2),0),$P(XPD0,U,2)),U)
 W ?49,"ALPHA/BETA TESTING: ",$S($P($G(@XPDGR@("ABPKG")),U)="y":"YES",1:"NO")
 Q
DESCR ; Show patch description
 W !!,"DESCRIPTION:"
 S XPDI=0
 F  S XPDI=$O(@XPDGR@(1,XPDI)) Q:'XPDI  S XPDTXT=$G(^(XPDI,0)) D  Q:$D(DIRUT)
 . I $L(XPDTXT)'<IOM,$E(XPDTXT,$L(XPDTXT))=" " F  S XPDTXT=$E(XPDTXT,1,$L(XPDTXT)-1) Q:$E(XPDTXT,$L(XPDTXT))'=" "
 . F  D  Q:$L(XPDTXT)<IOM!$D(DIRUT)!(IOM<2)  S XPDTXT=$E(XPDTXT,IOM,999)
 . . Q:$$CHK(2)
 . . W !,$S(IOM>1:$E(XPDTXT,1,IOM-1),1:XPDTXT)
 Q
PREPOST ; Environment check and pre/post routines
 Q:$$CHK(3)
 W !!,"ENVIRONMENT CHECK: ",$G(@XPDGR@("PRE"))
 W ?49,"DELETE ENV ROUTINE: " I $G(@XPDGR@("PRE"))]"" W $S($P($G(@XPDGR@("INID")),U)="y":"Yes",1:"No")
 I 'XPDTYPE D  Q:$D(DIRUT)
 . Q:$$CHK(2)
 . W !," PRE-INIT ROUTINE: ",$G(@XPDGR@("INI"))
 . W ?44,"DELETE PRE-INIT ROUTINE: " I $G(@XPDGR@("INI"))]"" W $S($P($G(@XPDGR@("INID")),U,3)="y":"Yes",1:"No")
 Q:$$CHK(2)
 W !,"POST-INIT ROUTINE: ",$G(@XPDGR@("INIT"))
 W ?43,"DELETE POST-INIT ROUTINE: " I $G(@XPDGR@("INIT"))]"" W $S($P($G(@XPDGR@("INID")),U,2)="y":"Yes",1:"No")
 I 'XPDTYPE Q:$$CHK(2)  W !,"PRE-TRANSPORT RTN: ",$G(@XPDGR@("PRET"))
 Q
FILES ; Show files/DDs
 Q:'$O(@XPDGR@(4,0))  ; Quit if no files
 S I=$$CHK(8,1) Q:I  I '$P(I,"^",2) D HDR1 W !,XPDUL
 S XPDI=0
 F  S XPDI=$O(@XPDGR@(4,XPDI)) Q:'XPDI  S XPD=$G(^(XPDI,222)) Q:$$CHK(3,1)  D
 . ;file number, file name, partial DD
 . W !!,XPDI,?12,$S('XPDFL:$P($G(^DIC(XPDI,0),"**unknown**"),U),1:$G(^XTMP("XPDI",XPDA,"FIA",XPDI)))
 . ; update DD, send security code, data comes with file
 . W ?43,$$EXTERNAL^DILFD(9.64,222.1,"",$P(XPD,U)),?49,$$EXTERNAL^DILFD(9.64,222.2,"",$P(XPD,U,2)),?55,$$EXTERNAL^DILFD(9.64,222.7,"",$P(XPD,U,7))
 . ; override site data, resolve pointers, user override
 . W ?63,$E($$EXTERNAL^DILFD(9.64,222.8,"",$P(XPD,U,8)),1,4),?69,$$EXTERNAL^DILFD(9.64,222.5,"",$P(XPD,U,5)),?75,$$EXTERNAL^DILFD(9.64,222.9,"",$P(XPD,U,9))
 . I $P(XPD,U,3)="p" D  Q:$D(DIRUT)
 . . ; Print partial DD information
 . . N XPDSUB,XPDFLD
 . . Q:$$CHK(2,1)
 . . W !,"Partial DD:"
 . . S (J,XPDSUB)=0
 . . F  S J=$O(@XPDGR@(4,"APDD",XPDI,J)) Q:'J  D  Q:$D(DIRUT)
 . . . I XPDSUB Q:$$CHK(2,1)  W !
 . . . W ?12,"subDD: ",J
 . . . S XPDSUB=1,(I,XPDFLD)=0
 . . . F  S I=$O(@XPDGR@(4,"APDD",XPDI,J,I)) Q:'I  D  Q:$D(DIRUT)
 . . . . I XPDFLD Q:$$CHK(2,1)  W !
 . . . . W ?30,"fld: ",I S XPDFLD=1
 . I "  "'[$G(@XPDGR@(4,XPDI,223)) Q:$$CHK(2,1)  W !,?2,"DD SCREEN  : ",^(223)
 . I "  "'[$G(@XPDGR@(4,XPDI,224)) Q:$$CHK(2,1)  W !,?2,"DATA SCREEN: ",^(224)
 Q
COMP ; Print Build components
 S I=0,XPD=$P(^DD(9.68,.03,0),U,3)
 F  S I=$O(@XPDGR@("KRN",I)) Q:'I  D   Q:$D(DIRUT)
 . Q:'$D(@XPDGR@("KRN",I,"NM","B"))
 . Q:$$CHK(4)
 . W !!,$S($D(^DIC(I,0)):$P(^(0),U),XPDFL:$G(^XTMP("XPDI",XPDA,"FIA",I),"UNKNOWN"),1:"UNKNOWN")_":",?47,"ACTION:"
 . S J=""
 . F  S J=$O(@XPDGR@("KRN",I,"NM","B",J)) Q:J=""  S X=$O(^(J,0)) D  Q:$D(DIRUT)
 . . Q:'X
 . . S X=$G(@XPDGR@("KRN",I,"NM",X,0)) Q:X=""
 . . Q:$$CHK(2)
 . . ;write the entry name and write the action
 . . W !,?3,$P(X,U),?50,$P($P(XPD,";",$P(X,U,3)+1),":",2)
 Q
QUESTS ; Show Install Questions
 I '$O(@XPDGR@("QUES",0)),'($D(@XPDGR@("QDEF"))#2) Q
 Q:$$CHK(6)
 W !!,"INSTALL QUESTIONS: "
 S I=0
 F  S I=$O(@XPDGR@("QUES",I)) Q:'I  S X=$P(^(I,0),U),J=$G(^(1)),K=$G(^("A")) D  Q:$D(DIRUT)
 . Q:$$CHK(4)
 . W !!?5,"SUBSCRIPT: ",X
 . W !,"DIR(0)=",J
 . S J=0
 . F  S J=$O(@XPDGR@("QUES",I,"A1",J)) Q:'J  Q:$$CHK(2)  W !,"DIR(""A"",",J,")=",^(J,0)
 . I K]"" Q:$$CHK(2)  W !,"DIR(""A"")=",K
 . I $G(@XPDGR@("QUES",I,"B"))]"" Q:$$CHK(2)  W !,"DIR(""B"")=",^("B")
 . S J=0
 . F  S J=$O(@XPDGR@("QUES",I,"Q1",J)) Q:'J  Q:$$CHK(2)  W !,"DIR(""?"",",J,")=",^(J,0)
 . I $G(@XPDGR@("QUES",I,"Q"))]"" Q:$$CHK(2)  W !,"DIR(""?"")=",^("Q")
 . I $G(@XPDGR@("QUES",I,"QQ"))]"" Q:$$CHK(2)  W !,"DIR(""??"")=",^("QQ")
 . I $G(@XPDGR@("QUES",I,"M"))]"" Q:$$CHK(2)  W !,"M CODE: ",^("M")
 Q:$D(DIRUT)
 ;Show new Defaults for KIDS questions. p463
 S X=$G(@XPDGR@("QDEF")) Q:X=""
 I '$L($P(X,U,9)),'$L($P(X,U,5)),'$L($P(X,U,11)) Q
 Q:$$CHK(3)  W !
 I $L($P(X,U,9)) Q:$$CHK(2)  W !," Default Rebuild Menu Trees Upon Completion of Install: ",$P(X,U,9)
 I $L($P(X,U,5)) Q:$$CHK(2)  W !," Default INHIBIT LOGONs during the install: ",$P(X,U,5)
 I $L($P(X,U,11)) Q:$$CHK(2)  W !," Default DISABLE Scheduled Options, Menu Options, and Protocols: ",$P(X,U,11)
 Q
ALFABETA ; Alpha/Beta Testing
 S XPD=$G(@XPDGR@("ABPKG")) Q:XPD=""
 Q:$P(XPD,U)'="y"
 Q:$$CHK(4)
 W !!,"ALPHA/BETA TESTING: ",$$EXTERNAL^DILFD(9.6,20,"",$P(XPD,U)),?47,"INSTALLATION MESSAGE: ",$$EXTERNAL^DILFD(9.6,21,"",$P(XPD,U,2))
 W !,"ADDRESS: ",$P(XPD,U,3)
 Q
NAMESP ; Namespaces
 Q:'$O(@XPDGR@("ABNS",0))
 Q:$$CHK(4)
 W !!,"INCLUDE NAMESPACE:",?47,"EXCLUDE NAMESPACE:"
 S I=0
 F  S I=$O(@XPDGR@("ABNS",I)) Q:'I  Q:$$CHK(2)  W !?3,^(I,0) D  Q:$D(DIRUT)
 . N XPDNMSP,XPDLF
 . S (J,XPDLF)=0
 . F  S J=$O(@XPDGR@("ABNS",I,1,J)) Q:'J  S XPDNMSP=^(J,0) D  Q:$D(DIRUT)
 . . I XPDLF Q:$$CHK(2)  W !
 . . W ?50,XPDNMSP
 . . S XPDLF=1
 Q
REQDBLD ; Required Builds
 Q:'$O(@XPDGR@("REQB",0))
 Q:$$CHK(4)
 W !!,"REQUIRED BUILDS:",?47,"ACTION:"
 S XPDI=0
 F  S XPDI=$O(@XPDGR@("REQB",XPDI)) Q:'XPDI  S XPD=$G(^(XPDI,0)) Q:$$CHK(2)  D
 . W !?3,$P(XPD,U),?50,$$EXTERNAL^DILFD(9.611,1,"",$P(XPD,U,2))
 Q
GLOBAL ; Global Package
 Q:$$CHK(4)
 W !!,"GLOBAL:",?47,"KILL GLOBAL BEFORE INSTALL:"
 S XPDI=0
 F  S XPDI=$O(@XPDGR@("GLO",XPDI)) Q:'XPDI  S XPD=$G(^(XPDI,0)) Q:$$CHK(2)  D
 . W !?3,$P(XPD,U),?50,$$EXTERNAL^DILFD(9.65,1,"",$P(XPD,U,2))
 Q
MULT ; Multi-Package
 Q:$$CHK(4)
 W !!,"SEQUENCE OF BUILDS:"
 S XPDI=0
 F  S XPDI=$O(@XPDGR@(10,XPDI)) Q:'XPDI  S XPD=$G(^(XPDI,0)) Q:$$CHK(2)  D
 . W !?2,XPDI,?8,$E($P(XPD,U),1,44),?54,$S($P(XPD,U,2)=1:"",1:"Not ")_"Required to Continue"
 Q
CHK(Y,XPD) ;Y=excess lines XPD=1 print file header, return 1 to exit
 ;return 0 if header was not written, else "0^1"
 Q:$Y<(IOSL-Y) 0
 Q:'$$CONT 1
 S XPD=$G(XPD),XPDPG=XPDPG+1
 W @IOF D HDR,HDR1:XPD
 W !,XPDUL
 Q "0^1"
 ;
CONT() ; Press Return to continue; ^ to exit.
 Q:$D(DIRUT) 0
 Q:$E(IOST,1,2)'="C-" 1
 N DIR,I,J,K,X,Y
 S DIR(0)="E" D ^DIR
 Q Y
 ;
HDR ;
 W "PACKAGE: ",$P(XPD0,U),"     ",XPDDT,?70,$$RJ^XLFSTR("PAGE "_XPDPG,9)
 Q
HDR1 ;
 W !!,?43,"UP    SEND  DATA                USER"
 W !,?43,"DATE  SEC.  COMES   SITE  RSLV  OVER"
 W !,"FILE #",?12,"FILE NAME",?43,"DD    CODE  W/FILE  DATA  PTRS  RIDE"
 Q
