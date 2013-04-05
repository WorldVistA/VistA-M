ZTMGRSET ;SF/RWF,PUG/TOAD - SET UP THE MGR ACCOUNT FOR THE SYSTEM ;02/13/2008
 ;;8.0;KERNEL;**34,36,69,94,121,127,136,191,275,355,446,584**;JUL 10, 1995;Build 6
 ;Per VHA Directive 2004-038, this routine should not be modified
 ;
 N %D,%S,I,OSMAX,U,X,X1,X2,Y,Z1,Z2,ZTOS,ZTMODE,SCR
 S ZTMODE=0
A W !!,"ZTMGRSET Version ",$P($T(+2),";",3)," Patch level ",$P($T(+2),";",5)
 W !,"HELLO! I exist to assist you in correctly initializing the current account."
 I $D(^%ZOSF("UCI")) X ^%ZOSF("UCI") D  G A:"YNyn"'[$E(X) Q:"Nn"[$E(X)
 . I ZTMODE=2 S X="Y" Q
 . W $C(7),!!,"This is namespace or uci ",Y,".",!
 . R "Should I continue? N//",X:120
 . Q
 S ZTOS=$$OS() I ZTOS'>0 W !,"OS type not selected. Exiting ZTMGRSET." Q
 I ZTMODE D  I (PCNM<1)!(PCNM>999) W !,"Need a Patch number to load." Q
 . I ZTMODE<2 R !!,"Patch number to load: ",PCNM:120 Q:(PCNM<1)!(PCNM>999)
 . S SCR="I $P($T(+2^@X),"";"",5)?.E1P1"_$C(34)_PCNM_$C(34)_"1P.E"
 ;
 K ^%ZOSF("MASTER"),^("SIGNOFF") ;Remove old nodes.
 ;
DOIT D MES("I will now rename a group of routines specific to your operating system.",1)
 D @ZTOS,ALL,GLOBALS:'ZTMODE D MES("ALL DONE",1)
 Q
 ;========================================
RELOAD ;Reload any patched routines
 N %D,%S,I,OSMAX,U,X,X1,X2,Y,Z1,Z2,ZTOS,ZTMODE,SCR
 S ZTMODE=1 G A
 Q
 ;
PATCH(PCNM) ;Post install Reload any patched routines
 N %D,%S,I,OSMAX,U,X,X1,X2,Y,Z1,Z2,ZTOS,ZTMODE,SCR
 I (1>PCNM)!(PCNM>999) D MES("PATCH NUMBER OUT OF RANGE",1) Q
 D MES("Rename the routines in Patch "_PCNM,1)
 S ZTMODE=2 G A
 Q
 ;
MES(T,B) ;Write message.
 S B=$G(B)
 I $L($T(BMES^XPDUTL)) D BMES^XPDUTL(T):B,MES^XPDUTL(T):'B Q
 W:B ! W !,T
 Q
 ;
OS() ;Select the OS
 N Y,X1,X,OSMAX
 S U="^",SCR="I 1" F I=1:1:20 S X=$T(@I) Q:X=""  S OSMAX=I
B S Y=0,ZTOS=0 I $D(^%ZOSF("OS")) D
 . S X1=$P(^%ZOSF("OS"),U),ZTOS=$$OSNUM W !,"I think you are using ",X1
 I ZTMODE=2,ZTOS>0 Q ZTOS
 W !,"Which MUMPS system should I install?",!
 F I=1:1:OSMAX W !,I," = ",$P($T(@I),";",3)
 W !,"System: " W:ZTOS ZTOS,"//"
 R X:300 S:X="" X=ZTOS
 I $S(X<1!(X>OSMAX):1,1:$P($T(@X),";",3)="") W !,"NOT A VALID CHOICE" Q:X[U 0 G B
 Q X
 ;
OSNUM() ;Return the OS number
 N I,X1,X2,Y S Y=0,X1=$P($G(^%ZOSF("OS")),"^")
 F I=1:1 S X2=$T(@I) Q:X2=""  I X2[X1 S Y=I Q
 Q Y
 ;
ALL W !!,"Now to load routines common to all systems."
 D TM,ETRAP,DEV,OTHER,FM
 I ZTOS=7!(ZTOS=8) D
 . S ^%ZE="D ^ZE"
 E  D  ;With ZLoad, ZSave, ZInsert
 . W !,"Installing ^%Z editor"
 . D ^ZTEDIT
 I 'ZTMODE W !,"Setting ^%ZIS('C')" K ^%ZIS("C") S ^%ZIS("C")="G ^%ZISC"
 Q
 ;
TM ;Taskman
 S %S="ZTLOAD^ZTLOAD1^ZTLOAD2^ZTLOAD3^ZTLOAD4^ZTLOAD5^ZTLOAD6^ZTLOAD7"
 S %D="%ZTLOAD^%ZTLOAD1^%ZTLOAD2^%ZTLOAD3^%ZTLOAD4^%ZTLOAD5^%ZTLOAD6^%ZTLOAD7"
 D MOVE
 S %S="ZTM^ZTM0^ZTM1^ZTM2^ZTM3^ZTM4^ZTM5^ZTM6"
 S %D="%ZTM^%ZTM0^%ZTM1^%ZTM2^%ZTM3^%ZTM4^%ZTM5^%ZTM6"
 D MOVE
 S %S="ZTMS^ZTMS0^ZTMS1^ZTMS2^ZTMS3^ZTMS4^ZTMS5^ZTMS7^ZTMSH"
 S %D="%ZTMS^%ZTMS0^%ZTMS1^%ZTMS2^%ZTMS3^%ZTMS4^%ZTMS5^%ZTMS7^%ZTMSH"
 D MOVE
 Q
FM ;Rename the FileMan routines
 I ZTMODE>0 Q  ;Only ask on full install
 R !,"Want to rename the FileMan routines: No//",X:600 Q:"Yy"'[$E(X_"N")
 S %S="DIDT^DIDTC^DIRCR",%D="%DT^%DTC^%RCR"
 D MOVE
 Q
 ;
ETRAP ;Error Trap
 S %S="ZTER^ZTER1",%D="%ZTER^%ZTER1"
 D MOVE
 Q
OTHER S %S="ZTPP^ZTP1^ZTPTCH^ZTRDEL^ZTMOVE^ZTBKC"
 S %D="%ZTPP^%ZTP1^%ZTPTCH^%ZTRDEL^%ZTMOVE^%ZTBKC"
 D MOVE
 Q
DEV S %S="ZIS^ZIS1^ZIS2^ZIS3^ZIS5^ZIS6^ZIS7^ZISC^ZISP^ZISS^ZISS1^ZISS2^ZISTCP^ZISUTL"
 S %D="%ZIS^%ZIS1^%ZIS2^%ZIS3^%ZIS5^%ZIS6^%ZIS7^%ZISC^%ZISP^%ZISS^%ZISS1^%ZISS2^%ZISTCP^%ZISUTL"
 D MOVE
 Q
RUM ;Build the routines for Capacity Management (CM)
 S %S=""
 I ZTOS=1 S %S="ZOSVKRV^ZOSVKSVE^ZOSVKSVS^ZOSVKSD" ;DSM
 I ZTOS=2 S %S="ZOSVKRM^ZOSVKSME^ZOSVKSMS^ZOSVKSD" ;MSM
 I ZTOS=3 S %S="ZOSVKRO^ZOSVKSOE^ZOSVKSOS^ZOSVKSD" ;OpenM
 I ZTOS=7!(ZTOS=8) S %S="ZOSVKRG^ZOSVKSGE^ZOSVKSGS^ZOSVKSD" ;GT.M
 S %D="%ZOSVKR^%ZOSVKSE^%ZOSVKSS^%ZOSVKSD"
 D MOVE
 Q
ZOSF(X) ;
 X SCR I $T W ! D @(U_X) W !
 Q
1 ;;VAX DSM(V6), VAX DSM(V7)
 S %S="ZOSVVXD^ZTBKCVXD^ZIS4VXD^ZISFVXD^ZISHVXD^XUCIVXD"
 D DES,MOVE
 S %S="ZOSV2VXD^ZTMDCL",%D="%ZOSV2^%ZTMDCL"
 D MOVE,RUM,ZOSF("ZOSFVXD")
 Q
2 ;;MSM-PC/PLUS, MSM for NT or UNIX
 W !,"- Use autostart to do ZTMB don't resave as STUSER."
 S %S="ZOSVMSM^ZTBKCMSM^ZIS4MSM^ZISFMSM^ZISHMSM^XUCIMSM"
 D DES,MOVE
 S %S="ZOSV2MSM",%D="%ZOSV2"
 D MOVE,RUM,ZOSF("ZOSFMSM")
 I $$VERSION^%ZOSV(1)["UNIX" S %S="ZISHMSU",%D="%ZISH" D MOVE
 Q
3 ;;Cache (VMS, NT, Linux), OpenM-NT
 S %S="ZOSVONT^ZTBKCONT^ZIS4ONT^ZISFONT^ZISHONT^XUCIONT"
 D DES,MOVE
 S %S="ZISTCPS^ZTMDCL",%D="%ZISTCPS^%ZTMDCL"
 D MOVE,RUM,ZOSF("ZOSFONT")
 Q
4 ;;
5 ;;
6 ;;
7 ;;GT.M (VMS)
 S %ZE=".M" D init^%RSEL
 S %S="ZOSVGTM^^ZIS4GTM^ZISFGTM^ZISHGTM^XUCIGTM"
 D DES,MOVE
 S %S="ZOSV2GTM^ZISTCPS^ZTMDCL",%D="%ZOSV2^%ZISTCPS^ZTMDCL"
 D MOVE,ZOSF("ZOSFGTM")
 Q
8 ;;GT.M (Unix)
 S %ZE=".m" D init^%RSEL
 S %S="ZOSVGUX^^ZIS4GTM^ZISFGTM^ZISHGTM^XUCIGTM"
 D DES,MOVE
 S %S="ZOSV2GTM^ZISTCPS",%D="%ZOSV2^%ZISTCPS"
 D MOVE,ZOSF("ZOSFGUX")
 Q
10 ;;NOT SUPPORTED
 Q
MOVE ; rename % routines
 N %,X,Y,M
 F %=1:1:$L(%D,"^") D  D MES(M)
 . S M="",X=$P(%S,U,%) ; from
 . S Y=$P(%D,U,%) ; to
 . Q:X=""
 . S M="Routine: "_$J(X,8)
 . Q:Y=""  I $T(^@X)=""  S M=M_"  Missing" Q
 . X SCR Q:'$T
 . S M=M_" Loaded, "
 . D COPY(X,Y)
 . S M=M_"Saved as "_$J(Y,8)
 Q
 ;
COPY(FROM,TO) ;
 I ZTOS'=7,ZTOS'=8 X "ZL @FROM ZS @TO" Q
 ;For GT.M below
 N PATH,COPY,CMD S PATH=$$R
 S FROM=PATH_FROM_".m"
 S TO=PATH_$TR(TO,"%","_")_".m"
 S COPY=$S(ZTOS=7:"COPY",1:"cp")
 S CMD=COPY_" "_FROM_" "_TO
 X "ZSYSTEM CMD"
 Q
 ;
R() ; routine directory for GT.M
 N ZRO X "S ZRO=$ZRO"
 I ZTOS=7 D  Q $S(ZRO["(":$P($P(ZRO,"(",2),")"),1:ZRO)
 . S ZRO=$P(ZRO,",")
 . I ZRO["/SRC=" S ZRO=$P(ZRO,"=",2) Q  ;Source dir
 . S ZRO=$S(ZRO["/":$P(ZRO,"/"),1:ZRO) Q  ;Source and Obj in same dir
 I ZTOS=8 Q $P($S(ZRO["(":$P($P(ZRO,"(",2),")"),1:ZRO)," ")_"/" ;Use first source dir.
 E  Q ""
 ;
DES S %D="%ZOSV^%ZTBKC1^%ZIS4^%ZISF^%ZISH^%XUCI" Q
 ;
GLOBALS ;Set node zero of file #3.05 & #3.07
 W !!,"Now, I will check your % globals."
 W ".........."
 F %="^%ZIS","^%ZISL","^%ZTER","^%ZUA" S:'$D(@%) @%=""
 S:$D(^%ZTSK(0))[0 ^%ZTSK(-1)=100,^%ZTSCH=""
 S Z1=$G(^%ZTSK(-1),-1),Z2=$G(^%ZTSK(0))
 I Z1'=$P(Z2,"^",3) S:Z1'>0 ^%ZTSK(-1)=+Z2 S ^%ZTSK(0)="TASKS^14.4^"_^%ZTSK(-1)
 S:$D(^%ZUA(3.05,0))[0 ^%ZUA(3.05,0)="FAILED ACCESS ATTEMPTS LOG^3.05^^"
 S:$D(^%ZUA(3.07,0))[0 ^%ZUA(3.07,0)="PROGRAMMER MODE LOG^3.07^^"
 Q
NAME ;Setup the static names for this system
MGR W !,"NAME OF MANAGER'S UCI,VOLUME SET: "_^%ZOSF("MGR")_"// " R X:$S($G(DTIME):DTIME,1:9999) I X]"" X ^("UCICHECK") G MGR:0[Y S ^%ZOSF("MGR")=X
PROD W !,"PRODUCTION (SIGN-ON) UCI,VOLUME SET: "_^%ZOSF("PROD")_"// " R X:$S($G(DTIME):DTIME,1:9999) I X]"" X ^("UCICHECK") G PROD:0[Y S ^%ZOSF("PROD")=X
VOL W !,"NAME OF VOLUME SET: "_^%ZOSF("VOL")_"//" R X:$S($G(DTIME):DTIME,1:9999) I X]"" S:X?3U ^%ZOSF("VOL")=X I X'?3U W "MUST BE 3 Upper case." G VOL
 W ! Q
