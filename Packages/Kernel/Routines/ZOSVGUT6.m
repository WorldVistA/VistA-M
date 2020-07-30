ZOSVGUT6 ; OSE/SMH - Unit Tests for GT.M VistA Port;2019-12-27  4:52 PM
 ;;8.0;KERNEL;**10006**;;Build 6
 ;
 ; (c) Sam Habiel 2019
 ; Licensed under Apache 2.0
 ;
 D EN^%ut($t(+0),3)
 QUIT
 ;
SHUTDOWN ; [M-Unit Shutdown]
 S $ZSOURCE=$T(+0)
 QUIT
 ;
ZTMGRSET ; @TEST ZTMGRSET Rename Routines ; *10006*
 N IOP S IOP="NULL" D ^%ZIS U IO
 D PATCH^ZTMGRSET(10006)
 D ^%ZISC
 D CHKTF^%ut($T(+2^%ZOSV2)[10006)
 QUIT
 ;
ZOSFGUX1 ; @TEST *10006 NOASK^ZOSFGUX
 kill ^%ZOSF("GSEL")
 kill ^%ZOSF("XY")
 new oldvol set oldvol=^%ZOSF("VOL")
 do NOASK^ZOSFGUX
 do tf^%ut($data(^%ZOSF("GSEL")))
 do tf^%ut($data(^%ZOSF("XY")))
 do eq^%ut(^%ZOSF("VOL"),oldvol)
 quit
 ;
ZOSFGUX2 ; @TEST *10006 ONE^ZOSFGUX
 new gsel set gsel=^%ZOSF("GSEL")
 kill ^%ZOSF("GSEL")
 kill ^%ZOSF("XY")
 new oldvol set oldvol=^%ZOSF("VOL")
 do ONE^ZOSFGUX("XY")
 do tf^%ut('$data(^%ZOSF("GSEL")))
 do tf^%ut($data(^%ZOSF("XY")))
 do eq^%ut(^%ZOSF("VOL"),oldvol)
 set ^%ZOSF("GSEL")=gsel
 quit
 ;
RESJOB ; @TEST *10006 test ^%ZOSF("RESJOB") & RESJOB^ZSY
 ; ZEXCEPT: input,output,error,TESTJOB
 N IOP S IOP="NULL" D ^%ZIS U IO
 X ^%ZOSF("RESJOB")
 D ^%ZISC
 do succeed^%ut
 ;
 J TESTJOB:(input="/dev/null":output="/dev/null":error="/dev/null")
 N %J S %J=$ZJOB
 D CHKTF^%ut($zgetjpi(%J,"isprocalive"))
 D KILLJOB^ZSY(%J)
 H .01
 D CHKTF^%ut('$zgetjpi(%J,"isprocalive"))
 QUIT
 ;
TESTJOB ; [Private] Entry point for a test job to kill
 HANG 100
 QUIT
 ;
DELDEV ; @TEST *10006 DEL^%ZOSV2 does not preserve current device
 N XCN,DIE
 S XCN=0,DIE=$$OREF^DILF($NA(^TMP($J)))
 K ^TMP($J)
 S ^TMP($J,$I(XCN),0)="KBANHELLO ; VEN/SMH - Sample Testing Routine"
 S ^TMP($J,$I(XCN),0)=" ;;"
 S ^TMP($J,$I(XCN),0)=";this is not supposed to be saved"
 S ^TMP($J,$I(XCN),0)=" WRITE ""HELLO WORLD"""
 S ^TMP($J,$I(XCN),0)=" QUIT"
 S XCN=0
 D SAVE^%ZOSV2("KBANHELLO")
 do tf^%ut($T(+1^KBANHELLO)["Sample")
 ;
 n file s file="/tmp/boo-"_$R(9999999)
 o file:newversion
 u file
 do eq^%ut($IO,file,"io 1")
 D DEL^%ZOSV2("KBANHELLO")
 do eq^%ut($IO,file,"io 2")
 c file:delete
 quit
 ;
CNTOLD1 ; @TEST Test Old Process Counting - No XUTL node
 K ^XUTL("XUSYS","CNT")
 n jobs s jobs=$$ACTJ
 d tf^%ut(jobs)
 d tf^%ut($d(^XUTL("XUSYS","CNT")))
 d eq^%ut(^XUTL("XUSYS","CNT"),jobs)
 d tf^%ut($d(^XUTL("XUSYS","CNT","SEC")))
 quit
 ;
CNTOLD2 ; @TEST Test Old Process Counting - XUTL Node for "CNT" not "SEC"
 K ^XUTL("XUSYS","CNT")
 n % f %=1:1:40 D COUNT(1)
 d eq^%ut(^XUTL("XUSYS","CNT"),40)
 d tf^%ut('$d(^XUTL("XUSYS","CNT","SEC")))
 n jobs s jobs=$$ACTJ
 d tf^%ut(jobs<40)
 d tf^%ut($d(^XUTL("XUSYS","CNT")))
 d eq^%ut(^XUTL("XUSYS","CNT"),jobs)
 d tf^%ut($d(^XUTL("XUSYS","CNT","SEC")))
 quit
 ;
CNTOLD3 ; @TEST Test Old Process Counting - Reset the counter at the tok
 n % f %=1:1:40 D COUNT(1)
 n jobs s jobs=$$ACTJ
 d tf^%ut(jobs'<40)
 h 2
 n jobs s jobs=$$ACTJ
 d tf^%ut(jobs<40)
 d eq^%ut(^XUTL("XUSYS","CNT"),jobs)
 d tf^%ut($d(^XUTL("XUSYS","CNT","SEC")))
 quit
 ;
 ;
COUNT(INC,JOB) ; [Private] Old Incremnt Algorithm from COUNT^XUSCNT
 N XUCNT,X
 S JOB=$G(JOB,$J)
 ;Return Current Count
 I INC=0 D TOUCH^XUSCNT Q +$G(^XUTL("XUSYS","CNT"))
 ;Increment Count
 I INC>0 D  Q
 . S X=$G(^XUTL("XUSYS",JOB,"NM")) K ^XUTL("XUSYS",JOB) S ^XUTL("XUSYS",JOB,"NM")=X
 . D TOUCH^XUSCNT
 . L +^XUTL("XUSYS","CNT"):5
 . S XUCNT=$G(^XUTL("XUSYS","CNT"))+1,^XUTL("XUSYS","CNT")=XUCNT
 . L -^XUTL("XUSYS","CNT")
 . Q
 ;Decrement Count
 I INC<0 D  Q
 . L +^XUTL("XUSYS","CNT"):5
 . S XUCNT=$G(^XUTL("XUSYS","CNT"))-1,^XUTL("XUSYS","CNT")=$S(XUCNT>0:XUCNT,1:0)
 . L -^XUTL("XUSYS","CNT")
 . K ^XUTL("XUSYS",JOB)
 Q
 ;
ACTJ() ; [$$ Private] Old Active Jobs
 ; ZEXCEPT: READONLY,SHELL
 N CNT S CNT=$G(^XUTL("XUSYS","CNT"))
 N SEC S SEC=$G(^XUTL("XUSYS","CNT","SEC"))
 N TOK S TOK=SEC+1
 N NOW S NOW=$$SEC^XLFDT($H)
 I (CNT<1)!(SEC<1)!(NOW>TOK) D
 . I $$UP^XLFSTR($ZV)["LINUX" D
 .. N I,IO,LINE
 .. S IO=$IO
 .. O "FTOK":(SHELL="/bin/sh":COMMAND="$gtm_dist/mupip ftok "_$$DEFFILE^ZOSVGUX:READONLY)::"PIPE" U "FTOK"
 .. F I=1:1:3 R LINE
 .. O "IPCS":(SHELL="/bin/sh":COMMAND="ipcs -mi "_$TR($P($P(LINE,"::",3),"[",1)," ",""):READONLY)::"PIPE" U "IPCS"
 .. F I=1:1 R LINE Q:$ZEO  I 1<$L(LINE,"nattch=") S ^XUTL("XUSYS","CNT")=+$P(LINE,"nattch=",2) Q
 .. U IO C "FTOK" C "IPCS"
 . ;
 . I $$UP^XLFSTR($ZV)["DARWIN" D  ; OSEHRA/SMH - Should work on Linux too!
 .. ; We previously used lsof against the default file, but that was TOOOOO SLOOOOW.
 .. ; See https://apple.stackexchange.com/questions/81140/why-is-lsof-on-os-x-so-ridiculously-slow
 .. ; Now we just do lsof against processes called mumps, and grep for the ones that have the default region open. xargs is used for trimming.
 .. N %CMD S %CMD="pgrep mumps | xargs -n 1 -I{} lsof -p{} | grep "_$$DEFFILE^ZOSVGUX_" | wc -l | xargs"
 .. S ^XUTL("XUSYS","CNT")=$$RETURN^%ZOSV(%CMD)
 . ;
 . I $$UP^XLFSTR($ZV)["CYGWIN" D
 .. S ^XUTL("XUSYS","CNT")=+$$RETURN^%ZOSV("ps -as | grep mumps | grep -v grep | wc -l")
 . ;
 . S ^XUTL("XUSYS","CNT","SEC")=$$SEC^XLFDT($H)
 Q ^XUTL("XUSYS","CNT")
