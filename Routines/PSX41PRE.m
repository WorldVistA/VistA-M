PSX41PRE ;BHAM/PDW-ENVIRONMENTAL PRE CHECK ;10/17/2002
 ;;2.0;CMOP;**41**;11 Apr 97
EN ;
 I ^XMB("NETNAME")?1"CMOP-".E Q
 I '$$PATCH^XPDUTL("PSO*7.0*126") S XPDQUIT=1 W !,"PSO*7.0*126 is required to be installed" H 5 Q
 D SET I $G(PSXER) S XPDQUIT=1
 I PSXSYS,$P(^PSX(550,+PSXSYS,0),"^",3)'="H" W !,"A transmission is in progress,try later." S XPDQUIT=1
 I $D(^PSX(550,"AT")) W !!,"NON-CS Auto transmissions are scheduled. Please unschedule all transmissions." S XPDQUIT=1
 I $D(^PSX(550,"ATC")) W !!,"CS Auto transmissions are scheduled. Please unschedule all transmissions." S XPDQUIT=1
 ;
 I $D(^PSX(550.2,"AQ")) W !!,"The CMOP TRANSMISSION file #550.2 has entries that have a 'CREATED' status.",!,"Please consult the patch documentation on how to clear this problem." S XPDQUIT=1
 I $G(XPDQUIT) D
 . W !!!,"The above problem(s) need to be addressed and resolved prior to",!,"PSX*2*41 being able to be installed.",!!
 . K DIR S DIR(0)="E",DIR("A")="<cr> - Continue" D ^DIR K DIR
 I $$PATCH^XPDUTL("PSX*2.0*41"),$G(XPDQUIT) D
 . W !!!,"Patch PSX*2*41 has been previously installed."
 . W !!,"If PSX*2*41 HAS NOT BEEN backed out you may proceed."
 . W !!,"If PSX*2*41 HAS BEEN backed out the problems need to be fixed",!,"before it is installed again.",!!
 . K DIR S DIR(0)="Y",DIR("B")="N",DIR("A")="Do you wish to proceed with this PSX*2*41 installation " D ^DIR
 . I Y=1 K XPDQUIT
 Q
SET ; this is code from SET^PSXSYS
 S PSXSYS=0 Q:'$D(^PSX(550,"C"))
 S (S1,DA)=$$KSP^XUPARAM("INST"),DIC="4",DIQ(0)="IE",DR=".01;99"
 S DIQ="PSXUTIL" D EN^DIQ1 S S3=$G(PSXUTIL(4,S1,99,"I")),S2=$G(PSXUTIL(4,S1,.01,"E")) K DA,DIC,DIQ(0),DR
 S PSXSYS=+$O(^PSX(550,"C",""))_"^"_$G(S3)_"^"_$G(S2)
 I $G(S3)="" S PSXER=1 W !,"I can't seem to find your site # in the INSTITUTION file.  Please call the National Help Desk and report the problem."
 K S3,S2,S1,PSXUTIL
 Q
