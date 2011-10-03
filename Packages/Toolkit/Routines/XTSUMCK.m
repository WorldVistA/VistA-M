XTSUMCK ;Boise/MAW,SFISC/RSD -compute routine checksums ;10/04/96  11:11
 ;;8.0;KERNEL;**44**;Jul 10, 1995
 ;^XTMP("XTSUMCK",DUZ)=end time^home cpu^status^task #^start time^# rtns
 ;^XTMP("XTSUMCK",DUZ,"SYS",system)=end time^active^status^task #^end time^# rtns
 I '$G(DUZ) W *7,!!,"DUZ UNDEFINED...ABORTED." Q
 S:'$D(DT) DT=$$DT^XLFDT S:'$D(U) U="^"
 N DIR,I,XTCKSUM,XTHOME,XTROU,DIRUT,X,Y
 X ^%ZOSF("UCI") S XTHOME=Y
 ;set expiration date on ^XTMP
 S ^XTMP("XTSUMCK",0)=$$FMADD^XLFDT(DT,7)_U_DT
 W !!,"You're on ",XTHOME,".  Checksums for selected routines on other systems",!,"will be compared to those on this system."
 I $G(^XTMP("XTSUMCK",DUZ))'="" S X=^XTMP("XTSUMCK",DUZ) D  Q:$D(DIRUT)
 .W *7,!!,"A checksum job, launched on ",$$FMTE^XLFDT($P(X,U,5))," from ",$P(X,U,2)," is",!," already on file."
 .W:$P(X,U,3)]"" !," It has a status of: ",$P(X,U,3)
 .S DIR(0)="Y",DIR("A")="Okay to delete the existing data",DIR("B")="NO"
 .D ^DIR
 .I Y'=1 W !!,"Nothing deleted...this job aborted." S DIRUT=1 Q
 .K ^XTMP("XTSUMCK",DUZ) S ^(DUZ)=""
 K ^UTILITY($J) W ! X ^%ZOSF("RSEL")
 I '$D(^UTILITY($J)) W !,"No routines selected." Q
 S ^XTMP("XTSUMCK",DUZ)=U_XTHOME_"^Loading routines^^"_$$NOW^XLFDT
 ;move list of routines into XTMP
 M ^XTMP("XTSUMCK",DUZ,"ROU")=^UTILITY($J)
 K ^UTILITY($J),DIR
 ;find systems to move to
 S Y=$P(XTHOME,",",2),I=0
 F  S I=$O(^%ZIS(14.5,I)) Q:'I  S X=$G(^(I,0)) S:$P(X,U)]""&$P(X,U,11)&($P(X,U)'=Y) ^XTMP("XTSUMCK",DUZ,"SYS",$P(X,U))=""
SYS I '$D(^XTMP("XTSUMCK",DUZ,"SYS")) W !!,"No Systems to Check",! G ABORT
 W !!,"I will Check the Routines on the following Systems:",!
 S I="" F  S I=$O(^XTMP("XTSUMCK",DUZ,"SYS",I)) Q:I=""  W ?3,I,!
 W ! S DIR(0)="Y",DIR("A")="Accept this list and continue",DIR("B")="YES"
 S DIR("?",1)="Enter Yes if you want to check the routines on the listed Systems",DIR("?")="Enter No if you want to create your own list of Systems."
 D ^DIR G ZTLD:Y,ABORT:$D(DIRUT) D  G SYS
 .N DIC K ^XTMP("XTSUMCK",DUZ,"SYS")
 .S DIC="^%ZIS(14.5,",DIC(0)="AEMQZ",DIC("S")="S %=^(0) I $P(%,U)'=$P(XTHOME,"","",2),$P(%,U,11)"
 .;ask for systems
 .F  D ^DIC Q:Y'>0  S ^XTMP("XTSUMCK",DUZ,"SYS",Y(0,0))=""
ZTLD ;queue build of master routine set checksums
 N ZTRTN,ZTDESC,ZTIO,ZTSAVE,ZTUCI,ZTCPU,ZTSK
 S ZTRTN="MSTR^XTSUMCK",ZTDESC="Routine Checksum Checker",ZTIO="",ZTSAVE("DUZ")="",ZTSAVE("XTHOME")="",ZTUCI=$P(XTHOME,","),ZTCPU=$P(XTHOME,",",2)
 D ^%ZTLOAD
 W !!
 I '$G(ZTSK) W *7,"Error...not queued!!" G ABORT
 I $G(ZTSK) D
 .S $P(^XTMP("XTSUMCK",DUZ),U,3,4)="Queued to run^"_ZTSK
 .W "Task number ",ZTSK," will calculate checksums for the selected"
 .W !,"routines here on ",XTHOME,"."
 .W !!,"These values will be used for comparison with the same routine set on all"
 .W !,"the other systems.  You will receive an alert when the job finishes.  The"
 .W !,"alert action will allow you to view/print the report that lists any"
 .W !,"routines that do not match the ""master"" calculated checksums."
 K ^UTILITY($J)
 Q
MSTR ;TaskMan entry point
 ;first, calculate the checksums for the "master" routine set
 S $P(^XTMP("XTSUMCK",DUZ),U,3)="Calculating checksums",XTDUZ=DUZ,XTX=""
 F XTCNT=0:1  S XTX=$O(^XTMP("XTSUMCK",DUZ,"ROU",XTX)) Q:XTX=""  D
 .S X=XTX
 .X ^%ZOSF("RSUM")
 .S ^XTMP("XTSUMCK",DUZ,"ROU",XTX)=Y
 ;next, job the checksum module on the other systems
 S $P(^XTMP("XTSUMCK",DUZ),U,6)=XTCNT,XTX=""
 F  S XTX=$O(^XTMP("XTSUMCK",DUZ,"SYS",XTX)) Q:XTX=""  D
 .N ZTSK,ZTCPU,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH
 .S ZTCPU=XTX,ZTRTN="CHK^XTSUMCK",ZTSAVE("XTDUZ")="",ZTUCI=$P(XTHOME,","),ZTDESC="Routine Checksum Checker for "_ZTUCI_","_ZTCPU,ZTDTH=$H,ZTIO=""
 .D ^%ZTLOAD
 .I $G(ZTSK) S ^XTMP("XTSUMCK",DUZ,"SYS",XTX)="^^Job Tasked^"_ZTSK,XTSUMCK(XTX)="0^"_$H Q
 .S %=$$NOW^XLFDT,^XTMP("XTSUMCK",DUZ,"SYS",XTX)=%_"^^ERROR -- Job couldn't be tasked^^"_%
 ;monitor background tasks
 ;checking for completion of all checksum jobs.  Once all completed,
 ;an alert is set up to notify the requester.
 S $P(^XTMP("XTSUMCK",DUZ),U,3)="Waiting for jobs to finish",XTSFLG=""
 F  D  Q:XTFLG  H 60
 .S XTFLG=1,XTSYS=""
 .F  S XTSYS=$O(^XTMP("XTSUMCK",DUZ,"SYS",XTSYS)) Q:XTSYS=""  S X=^(XTSYS) D:'X
 ..S XTFLG=0
 ..;not complete, if still active then reset counter
 ..I $P(XTSUMCK(XTSYS),U,2)'=$P(X,U,2) S XTSUMCK(XTSYS)="0^"_$P(X,U,2) Q
 ..;hasn't been active for at least 30 minutes
 ..I XTSUMCK(XTSYS)>30 S X=^XTMP("XTSUMCK",XTDUZ,"SYS",XTSYS),$P(X,U)=$$NOW^XLFDT,$P(X,U,3)="ERROR - was idle for more than 30 minutes",^XTMP("XTSUMCK",XTDUZ,"SYS",XTSYS)=X
 ..S $P(XTSUMCK(XTSYS),U)=XTSUMCK(XTSYS)+1
 ;log the date.time job completed
 S XTX=^XTMP("XTSUMCK",DUZ),XTX=$$NOW^XLFDT_U_$P(XTX,U,2)_"^Completed ^"_$P(XTX,U,4,6),^XTMP("XTSUMCK",DUZ)=XTX
 ;send an alert that the checksum job completed
 S XQA(DUZ)=""
 S XQAMSG="Routine checksum job completed."
 S XQAROU="^XTSUMCK1"
 D SETUP^XQALERT
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
CHK ;jobbed entry point...
 ;XTDUZ=DUZ of the user who started the checksum job...
 X ^%ZOSF("UCI") S XTSYS=$P(Y,",",2)
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^XTSUMCK"
 E  S X="ERR^XTSUMCK",@^%ZOSF("TRAP")
 S XTMST=$P(^XTMP("XTSUMCK",XTDUZ),U,2),XTHM=$P(XTMST,",")_","_XTSYS
 S X=^XTMP("XTSUMCK",XTDUZ,"SYS",XTSYS),$P(X,U,2,3)=$H_"^Checking Routines",$P(X,U,5)=$$NOW^XLFDT,^XTMP("XTSUMCK",XTDUZ,"SYS",XTSYS)=X
 S XTROU=""
 F XTCNT=0:1 S XTROU=$O(^XTMP("XTSUMCK",XTDUZ,"ROU",XTROU)) Q:XTROU=""  D
 .S:'(XTCNT#10) $P(^XTMP("XTSUMCK",XTDUZ,XTSYS),U,2)=$H
 .I $T(^@XTROU)="" S ^XTMP("XTSUMCK",XTDUZ,"SYS",XTSYS,XTROU)="NOT ON THIS SYSTEM" Q
 .S XTCKSUM=+^XTMP("XTSUMCK",XTDUZ,"ROU",XTROU)
 .S X=XTROU
 .X ^%ZOSF("RSUM")
 .I Y=XTCKSUM Q
 .S ^XTMP("XTSUMCK",XTDUZ,"SYS",XTSYS,XTROU)="Checksum on "_XTHM_" = "_Y_" :: on "_XTMST_" = "_XTCKSUM
 S X=^XTMP("XTSUMCK",XTDUZ,"SYS",XTSYS),$P(X,U)=$$NOW^XLFDT,$P(X,U,3)="Normal Completion",$P(X,U,6)=XTCNT,^XTMP("XTSUMCK",XTDUZ,"SYS",XTSYS)=X
 Q
ABORT K ^XTMP("XTSUMCK",DUZ)
 Q
ERR ;error in background job
 S X=^XTMP("XTSUMCK",XTDUZ,"SYS",XTSYS),$P(X,U)=$$NOW^XLFDT,$P(X,U,3)="ERROR - Job terminated before completion",^XTMP("XTSUMCK",XTDUZ,"SYS",XTSYS)=X
 D ^%ZTER,UNWIND^%ZTER
 Q
