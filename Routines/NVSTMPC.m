NVSTMPC ;emc/maw-clean inactive jobs nodes in ^TMP ; 07/09/2004
 ;;2.1;EMC SYSTEM UTILITIES; Jul 03, 2002
 ;;vsts/fyb - Modified to run on either Cache or DSM
 ;
 ; -- included in NVSMENU KIDs BUILD  jls/oiofo        1/21/06  NOON
 ;
 S NVSHPID=$$CNV^XLFUTL($J,16)
 S NVSHP3=$E(NVSHPID,1,3)
 D GETENV^%ZOSV
 S NVSHNODE=$P(Y,"^",3)
 W !!,"CLEAN INACTIVE JOB NODES IN ^TMP GLOBAL"
 W !!,"Current Node: ",?18,NVSHNODE
 W !!,"This procedure will process down through the specified"
 W !,"number of subscript levels searching for PID numbers."
 W !,"When a PID is found, for those whose first three digits"
 W !,"match this node's hexidecimal PID prefix, a check is"
 W !,"invoked to determine if that PID is active.  If it is"
 W !,"inactive, you have the choice of either reporting that"
 W !,"PID, or have this procedure delete that global node."
 W !,"If you choose to delete them, you will also be asked"
 W !,"whether you want to be prompted to delete the nodes,"
 W !,"or allow this process to automatically delete them."
 W !!,"*NOTE:  THIS CLEAN UP IS SPECIFIC TO THIS NODE ONLY*"
 W !,"IT MUST BE RUN ON EACH NODE IN YOUR CLUSTER IN ORDER"
 W !,"TO CLEAN UP THE ^TMP GLOBAL ON EACH NODE."
 S DIR(0)="NA^1:3"
 S DIR("A")="How many subscript levels deep should I search (1-3)? "
 S DIR("B")=2
 S DIR("?")="2 subscript levels is usually deep enough."
 W ! D ^DIR K DIR
 I $D(DIRUT) K DIRUT,DTOUT,X,Y Q
 S NVSSUBS=+Y
 S DIR(0)="SA^C:Clean;R:Report"
 S DIR("A")="[C]lean up the nodes or [R]eport only? "
 S DIR("?")="Enter 'R' and inactive PID nodes will be listed -- not deleted."
 S DIR("?",1)="Enter 'C' and inactive PID nodes can be deleted."
 S DIR("B")="Report"
 W ! D ^DIR K DIR
 I $D(DIRUT) K DIRUT,DTOUT,NVSSUBS,X,Y Q
 S NVSTYPE=Y
 I NVSTYPE="C" D
 .S DIR(0)="SA^Y:Yes;N:No"
 .S DIR("A")="Do you wish me to prompt you to delete each node? "
 .S DIR("B")="NO"
 .S DIR("?")="Answer 'NO' and I will automatically delete the nodes."
 .S DIR("?",1)="Answer 'YES' and I will prompt you do delete the nodes."
 .W ! D ^DIR K DIR
 .I $D(DIRUT) D  Q
 ..S NVSASK="Y"
 ..K DIRUT,DTOUT,X,Y
 .S NVSASK=Y
 W !!,"Process type: ",$S(NVSTYPE="R":"Report only",1:"Clean up nodes")
 I NVSTYPE="C" W !,"Action type : ",$S(NVSASK="Y":"Prompt for deletion",1:"Automatic deletion")
 W !,"Subscripts: ",NVSSUBS
 S DIR(0)="YA"
 S DIR("A")="Okay to continue? "
 S DIR("B")="NO"
 W ! D ^DIR K DIR
 I Y=1 D
 .W !!,"Job starting ",$$FMTE^XLFDT($$NOW^XLFDT)
 .I NVSTYPE="R" W !,"**REPORT ONLY**"
 .F NVSSUB=1:1:NVSSUBS D
 ..S NVSLVL="LVL"_NVSSUB
 ..D @NVSLVL
 .W !!,"All processing complete on node ",$ZU(110)
 K DIRUT,DTOUT,NVSASK,NVSHNODE,NVSHPID,NVSHP3,NVSLVL,NVSSUB,NVSSUBS,NVSTYPE,X,Y
 Q
 ;
LVL1 ; first-level subscript...
 W !!,"First level..."
 S NVSICNT=0
 S X1=""
 F  S X1=$O(^TMP(X1)) Q:X1=""  D
 .; is X1 a PID?...
 .I +X1=0 Q
 .I X1\1'=X1 Q
 .I $E($$CNV^XLFUTL(X1,16),1,3)'=NVSHP3 Q
 .; X1 is a PID on this node, is PID active?...
 .I $D(^$JOB(X1))'=0 Q  ; Job is active
 .S NVSICNT=NVSICNT+1
 .W !?2,"^TMP(",X1,"..."
 .I NVSTYPE="R" Q
 .S NVSDEL=$S(NVSASK="N":1,1:0)
 .I NVSASK="Y" D OKDEL(.NVSDEL)
 .I 'NVSDEL W " -- not deleted." Q
 .K ^TMP(X1)
 .W " -- deleted."
 W !!,NVSICNT," inactive PID",$S(NVSICNT>1:"s",1:"")," at first subscript level."
 K NVSDEL,NVSICNT,X1
 Q
 ;
LVL2 ; second-level subscript...
 W !!,"Second level..."
 S NVSICNT=0
 S X1=" "
 F  S X1=$O(^TMP(X1)) Q:X1=""  D
 .S X2=""
 .F  S X2=$O(^TMP(X1,X2)) Q:X2=""  D
 ..; is X2 a PID?...
 ..I +X2=0 Q
 ..I X2\1'=X2 Q
 ..I $E($$CNV^XLFUTL(X2,16),1,3)'=NVSHP3 Q
 ..; X2 is a PID on this node, is PID active?...
 ..I $D(^$JOB(X2))'=0 Q  ; Job is active
 ..S NVSICNT=NVSICNT+1
 ..W !?2,"^TMP(",X1,",",X2,"..."
 ..I NVSTYPE="R" Q
 ..S NVSDEL=$S(NVSASK="N":1,1:0)
 ..I NVSASK="Y" D OKDEL(.NVSDEL)
 ..I 'NVSDEL W " -- not deleted." Q
 ..K ^TMP(X1,X2)
 ..W " -- deleted."
 W !!,NVSICNT," inactive PID",$S(NVSICNT>1:"s",1:"")," at second subscript level."
 K NVSDEL,NVSICNT,X1,X2
 Q
 ;
LVL3 ; third-level subscript...
 W !!,"Third level..."
 S NVSICNT=0
 S X1=" "
 F  S X1=$O(^TMP(X1)) Q:X1=""  D
 .S X2=" "
 .F  S X2=$O(^TMP(X1,X2)) Q:X2=""  D
 ..S X3=""
 ..F  S X3=$O(^TMP(X1,X2,X3)) Q:X3=""  D
 ...; is X3 a PID?...
 ...I +X3=0 Q
 ...I X3\1'=X3 Q
 ...I $E($$CNV^XLFUTL(X3,16),1,3)'=NVSHP3 Q
 ...; X3 is a PID on this node, is the PID active?...
 ...I $D(^$JOB(X3))'=0 Q  ; Job is active
 ...S NVSICNT=NVSICNT+1
 ...W !?2,"^TMP(",X1,",",X2,",",X3,"..."
 ...I NVSTYPE="R" Q
 ...S NVSDEL=$S(NVSASK="N":1,1:0)
 ...I NVSASK="Y" D OKDEL(.NVSDEL)
 ...I 'NVSDEL W " -- not deleted." Q
 ...K ^TMP(X1,X2,X3)
 ...W " -- deleted."
 W !!,NVSICNT," inactive PID",$S(NVSICNT>1:"s",1:"")," at third subscript level."
 K NVSDEL,NVSICNT,X1,X2,X3
 Q
 ;
OKDEL(OK) ; ask okay to delete...
 ; OK is passed by reference, returned 0 if NO 1 if YES
 N DIR,DIRUT,DTOUT,X,Y
 S DIR(0)="YA"
 S DIR("A")="  Okay to delete? "
 S DIR("B")="NO"
 D ^DIR K DIR
 S OK=+Y
 Q
