XUTMQ0 ;SEA/RDS - TaskMan: Option, ZTMINQ, Part 2 (Modules) ;4/20/95  10:33
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
ENTRY G ^XUTMQ
 ;
ALL ;BRANCH^XUTMQ--all of one user's tasks.
 ;input: ZTKEY,ZTNAME,XUTMUCI
 N DIR,DIRUT,DTOUT,DUOUT,X,ZT1,ZT2,ZT3,ZTC,ZTDUZ,ZTF,ZTH,ZTI,ZTOUT
 N ZTREC,ZTS,ZTUSER K ^TMP($J)
 S ZTC=0,ZTF=1,ZTH="All tasks created by ",ZTOUT=0
 D KEY I ZTOUT Q
A1 ;
 S ZTS=0 F ZTI=1:1 S ZTS=$O(^%ZTSK(ZTS)) Q:'ZTS  D
 .I '(ZTI#100) W "."
 .I ZTI=10000 D
 ..W !!,$C(7),$C(7)
 ..W "You need to run XUTMQCLEAN more often or keep fewer tasks each run."
 ..W !,"Still searching..."
 ..Q
 .I $$MATCH(ZTS,ZTDUZ,ZTUSER) D SORT(+$P($G(^%ZTSK(ZTS,0)),U,6),ZTS)
 .Q
A2 ;
 S ZTS=0 F  S ZTS=$O(^%ZTSCH("TASK",ZTS)) Q:'ZTS  D
 .I $D(^%ZTSK(ZTS,0))#2 Q
 .S ZTREC=$G(^%ZTSCH("TASK",ZTS))
 .I ZTREC="" Q
 .I $P(ZTREC,U,9)'=ZTDUZ,$P(ZTREC,U,9)'=ZTUSER Q
 .D SORT($H,ZTS)
 .Q
A3 ;
 W "finished!",!
 G:$O(^TMP($J,0))="" A4
 S ZTSAVE("^TMP($J,")="" D EN^XUTMDEVQ("LIST^XUTMQ","TASK LIST",.ZTSAVE)
 K ^TMP($J)
 Q
 S ZT1="" F  S ZT1=$O(^TMP($J,ZT1),-1) Q:ZT1=""  D  I ZTOUT Q
 . S ZTS=0 F  S ZTS=$O(^TMP($J,ZT1,ZTS)) Q:'ZTS  D  I ZTOUT Q
 .. D PRINT
 .Q
 I ZTOUT Q
A4 ;
 I 'ZTC W !! D  W " no tasks in this volume set's Task file.",!
 .I ZTKEY W ZTUSER," has"
 .E  W "You have"
 W !
 S DIR(0)="E"
 S DIR("A")="Press RETURN to continue" I ZTC D
 .S DIR("A")="End of listing.  "_DIR("A")
 D ^DIR K ^TMP($J) Q
 ;
FUT ;BRANCH^XUTMQ--one user's future tasks.
 ;input: ZTKEY,ZTNAME,XUTMUCI
 N DIR,DIRUT,DTOUT,DUOUT,X,ZT,ZT1,ZT2,ZT3,ZTC,ZTDUZ,ZTF,ZTH,ZTOUT
 N ZTREC,ZTS,ZTUSER K ^TMP($J)
 S X=0,ZTC=0,ZTF=1,ZTH="Scheduled and waiting tasks created by ",ZTOUT=0
 D KEY I ZTOUT Q
 ;
F1 S ZT1=0 F  S ZT1=$O(^%ZTSCH("JOB",ZT1)) Q:ZT1'>0  D
 .S ZTS=0 F  S ZTS=$O(^%ZTSCH("JOB",ZT1,ZTS)) Q:ZTS=""  D
 ..I $$MATCH(ZTS,ZTDUZ,ZTUSER) D SORT(ZT1,ZTS)
 .Q
 ;
F2 S ZT1=0 F  S ZT1=$O(^%ZTSCH(ZT1)) Q:'ZT1  D
 .S ZTS=0 F  S ZTS=$O(^%ZTSCH(ZT1,ZTS)) Q:'ZTS  D
 ..I $$MATCH(ZTS,ZTDUZ,ZTUSER) D SORT(ZT1,ZTS)
 .Q
 ;
F3 S ZT1="" F  S ZT1=$O(^%ZTSCH("IO",ZT1)) Q:ZT1=""  D
 .S ZT2="" F  S ZT2=$O(^%ZTSCH("IO",ZT1,ZT2)) Q:'ZT2  D
 ..S ZTS="" F  S ZTS=$O(^%ZTSCH("IO",ZT1,ZT2,ZTS)) Q:ZTS=""  D
 ...I $$MATCH(ZTS,ZTDUZ,ZTUSER) D SORT(ZT2,ZTS)
 .Q
 ;
F4 S ZT1="" F  S ZT1=$O(^%ZTSCH("LINK",ZT1)) Q:ZT1=""  D
 .S ZT2="" F  S ZT2=$O(^%ZTSCH("LINK",ZT1,ZT2)) Q:'ZT2  D
 ..S ZTS=0 F  S ZTS=$O(^%ZTSCH("LINK",ZT1,ZT2,ZTS)) Q:'ZTS  D
 ...I $$MATCH(ZTS,ZTDUZ,ZTUSER) D SORT(ZT2,ZTS)
 .Q
 W "finished!",!
 ;
F5 ;
 G:$O(^TMP($J,0))="" F6
 S ZTSAVE("^TMP($J,")="" D EN^XUTMDEVQ("LIST^XUTMQ","TASK LIST",.ZTSAVE)
 K ^TMP($J)
 Q
 S ZT1="" F  S ZT1=$O(^TMP($J,ZT1),-1) Q:ZT1=""  D  I ZTOUT Q
 . S ZTS=0 F  S ZTS=$O(^TMP($J,ZT1,ZTS)) Q:'ZTS  D  I ZTOUT Q
 .. D PRINT
 . Q
 I ZTOUT Q
 ;
F6 I 'ZTC W !! D
 .I ZTKEY W ZTUSER," has"
 .E  W "You have"
 .W " no scheduled or waiting tasks in this volume set's Task File.",!
 W ! S DIR(0)="E"
 S DIR("A")="Press RETURN to continue" I ZTC D
 .S DIR("A")="End of listing.  "_DIR("A")
 D ^DIR K ^TMP($J) Q
 ;
KEY ;ALL/FUT--set up variables for chosen user
 ;input: ZTKEY,ZTNAME
 ;input/output: ZTH,ZTOUT
 ;output: ZTDUZ,ZTUSER
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 I 'ZTKEY S ZTDUZ=DUZ,ZTUSER=ZTNAME,ZTH=ZTH_"you." Q
 W !!,"Select the user whose tasks you wish to see.",!!
 S DIR(0)="P^200:AEMNQ"
 S DIR("B")=ZTNAME
 S DIR("?")="Select the user whose tasks you wish to see."
K D ^DIR K DIR
 I $D(DTOUT) W "     ** TIMEOUT **",$C(7)
 I $D(DUOUT) W "     ** ^ ESCAPE **"
 I $D(DIRUT) S ZTOUT=1 Q
 W !!,"Please wait while I search for the tasks...searching..."
 S ZTDUZ=$P(Y,U),ZTUSER=$P(Y,U,2)
 I ZTUSER'=ZTNAME S ZTH=ZTH_$P(ZTUSER,",",2,999)_" "_$P(ZTUSER,",")_"."
 E  S ZTH=ZTH_"you."
 Q
 ;
MATCH(ZTS,ZTDUZ,ZTREC) ;
 ;ALL/FUT--determine whether task was created by user
 ;input: task #, user #, user name
 ;output: Boolean, does task belong to user?
 S ZTREC=$G(^%ZTSK(ZTS,0))
 I ZTREC="" Q 0
 I $P(ZTREC,U,3)'=ZTDUZ Q 0
 I $P(ZTREC,U,10)="" Q 1
 Q $P(ZTREC,U,10)=ZTUSER
 ;
SORT(ZTDTH,ZTSK) ;
 ;ALL/FUT--sort task by start time.
 ;input: start time, task number
 ;output: ^TMP($J) node
 I ZTDTH["," S ZTDTH=$$H3^%ZTM(ZTDTH)
 S ^TMP($J,ZTDTH,ZTSK)=""
 Q
 ;
PRINT ;ALL/FUT--print a task
 ;input: ZTH,ZTKEY,ZTNAME,ZTS,XUTMUCI
 ;input/output: ZTC,ZTF
 ;output: ZTOUT
 N DIR,DIRUT,DTOUT,DUOUT,X,Y,ZTSK
 I 'ZTC W @IOF,!,ZTH,!
 I 'ZTF W !,"-------------------------------------------------------------------------------"
 S ZTF=0
 D EN^XUTMTP(ZTS)
 I $Y'>18 S ZTC=ZTC+1 Q
 W ! S ZTF=1,DIR(0)="E" D ^DIR
 S ZTOUT=$D(DTOUT)!$D(DUOUT) I ZTOUT Q
 W @IOF Q
 ;
