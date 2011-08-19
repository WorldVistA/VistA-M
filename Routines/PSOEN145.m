PSOEN145 ;BIR/RTR-Patch 145 Environment check routine ;08/15/03
 ;;7.0;OUTPATIENT PHARMACY;**145,268**;DEC 1997;Build 9
 Q:'XPDENV
 N X1,X2,Y
 L +^XTMP("SDPSO145"):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) I '$T W !!,"Cannot load this build, someone else is either installing it now,",!,"or the Post-Init for this build is currently running from another install.",! S XPDABORT=2 Q
 I $G(^XTMP("SDPSO145","PSOTINIT")) W !!,"Cannot load this build, the Post-Init has already been",!,"queued by another process.",! S XPDABORT=2 L -^XTMP("SDPSO145") Q
 W !,"This build contains a post-install that will populate the TPB ELIGIBILITY",!,"(#52.91) File, and the TPB INSTITUTION LETTERS (#52.92) File.",!
 K %DT D NOW^%DTC S %DT="RAEX",%DT(0)=%,%DT("A")="Queue the Post-Install to run at what Date@Time: "
 D ^%DT K %DT I $D(DTOUT)!(Y<0) W !!,"Cannot install patch without queuing the post-install, install aborted!",! S XPDABORT=2 L -^XTMP("SDPSO145") Q
 S ^XTMP("SDPSO145","PSOTINIT")=Y
 S X1=DT,X2=+60 D C^%DTC S ^XTMP("SDPSO145",0)=$G(X)_"^"_DT
 L -^XTMP("SDPSO145")
 Q
TEST ;
 Q:'$G(XPDENV)
 W !,"This build contains a post-install that will populate the TPB ELIGIBILITY",!,"(#52.91) File, and the TPB INSTITUTION LETTERS (#52.92) File.",!
 K %DT D NOW^%DTC S %DT="RAEX",%DT(0)=%,%DT("A")="Queue the Post-Install to run at what Date@Time: "
 D ^%DT K %DT I $D(DTOUT)!(Y<0) W !!,"Cannot install patch without queuing the post-install, install aborted!",! S XPDABORT=2 Q
 S @XPDGREF@("PSOPINIT")=Y
 Q
