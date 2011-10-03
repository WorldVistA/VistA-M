RGMSENV ;B'HAM/PTD-CIRN MESSAGING SUPPORT build environment check routine ;4/6/99
 ;;1.0; CLINICAL INFO RESOURCE NETWORK ;;30 Apr 99
 ;If this is a production account, ensure that HL*1.6*39 is installed.
 Q:XPDENV=1  ;do not run environment check at install time
 ;run environment check only during Load a Distribution
 ;Determine if this is a production account.  If NOT, quit.
DIR K DIR S DIR(0)="SAM^P:Production;T:Test;"
 S DIR("A",1)="Identify this account as 'Production' or 'Test'."
 S DIR("A")="This installation is taking place in which account? "
 S DIR("B")="TEST"
 S DIR("?")="Enter 'P' for Production or 'T' for Test"
 S DIR("??")="^D HLP^RGMSENV"
 D ^DIR G:$D(DIRUT) ABORT S RGANS=Y
 I RGANS="T" G END
 ;For production account, check for patch HL*1.6*39.
 S RGPCH=$$PATCH^XPDUTL("HL*1.6*39") I RGPCH=1 G END
 ;
ABORT ;Patch HL*1.6*39 missing; abort install; leave transport global.
 W !!,"You must have patch HL*1.6*39 installed."
 S XPDQUIT=2
 ;
END I '$D(XPDQUIT) W !!,"Environment check is ok.",!
 K DIR,DIRUT,DTOUT,DUOUT,RGANS,RGPCH,X,Y
 Q
 ;
HLP ;Help text.
 W !!,"Enter 'P' if this installation is taking place in your"
 W !,"PRODUCTION account.  This will require patch HL*1.6*39."
 W !,"Enter 'T' if this installation is taking place in your"
 W !,"TEST account.  HL*1.6*39 should NOT be installed in any"
 W !,"test account.",!
 Q
 ;
