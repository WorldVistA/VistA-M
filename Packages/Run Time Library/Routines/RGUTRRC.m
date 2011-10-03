RGUTRRC ;CAIRO/DKM - Remote routine checksum utility;04-Sep-1998 11:26;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
 ; Performs a routine checksum on selected routines across all CPUs.
 ;=================================================================
 N RGX,RGY,RGRTN,RGCPU,RGUCI,RGCS,RGPID,RGZ,RGZ1,X
 S RGPID=$J
 D HOME^%ZIS
 D TITLE^RGUT("Remote Routine Checksum","1.0")
RSEL X ^%ZOSF("RSEL")
 W !!
 Q:'$D(^UTILITY(RGPID))
 K %IS,%ZIS
 D ^%ZIS
 G:POP RSEL
 U IO
 S RGUCI=$P($ZU(0),","),RGCPU=$P($ZU(0),",",2),RGRTN=$C(1)
NXT S RGRTN=$O(^UTILITY(RGPID,RGRTN))
 I RGRTN="" W !! Q
 W RGRTN,"..."
 K RGX,^RGUTL("RRC",RGPID)
 F RGY="CSA","CSB","CSC","PSA","PSB" D:RGY'=RGCPU JOBIT
 S RGCS=$$CHKSUM(RGRTN),RGCNT=0
 W ?15,RGCPU," ",RGCS,!
AGAIN I '$D(RGX) W ! G NXT
 S RGZ="",RGCNT=RGCNT+1
 I RGCNT>20 D FAIL G NXT
 H:RGCNT>1 1
NXT2 S RGZ=$O(RGX(RGZ))
 G:RGZ="" AGAIN
 G:'$D(^RGUTL("RRC",RGPID,RGZ)) NXT2
 S RGZ1=^(RGZ)
 K ^(RGZ),RGX(RGZ)
 I RGCS=RGZ1 W ?15,RGZ," same",!
 E  W ?15,RGZ," different: ",RGZ1,"  ************",!
 G NXT2
FAIL S RGZ=$O(RGX(RGZ))
 Q:RGZ=""
 W ?15,RGZ," failed to report",!
 G FAIL
JOBIT Q:RGY=RGCPU
 S @$$TRAP^RGZOSF("NOCPU^RGUTRRC")
 J JOB^RGUTRRC(RGPID,RGRTN)[RGUCI,RGY]::1
 I '$ZB W "Failed to start remote job on "_RGUCI_","_RGY,!
 E  S RGX(RGY)=""
NOCPU Q
JOB(RGJ,RGRTN) ;
 H 1
 S RGCPU=$P($ZU(0),",",2),@$$TRAP^RGZOSF("JERR^RGUTRRC")
 I $$TEST^RGZOSF(RGRTN) S ^RGUTL("RRC",RGJ,RGCPU)=$$CHKSUM(RGRTN)
 E  S ^RGUTL("RRC",RGJ,RGCPU)=0
 Q
JERR S ^RGUTL("RRC",RGJ,RGCPU)=$$EC^%ZOSV
 Q
CHKSUM(X) ;
 N Y
 X ^%ZOSF("RSUM")
 Q Y
