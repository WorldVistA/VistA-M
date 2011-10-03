MPIFBT1 ;SLC/ARS/SFCIO/CMC-BATCH QUERY TO MPI ;FEB 4, 1997
 ;;1.0; MASTER PATIENT INDEX VISTA ;**17,28,33**;30 Apr 99
 ;
 ; Integration Agreements Utilized:
 ;  EXC, START, STOP^RGHLLOG - #2796
 ;  ^DPT("ACMORS" - #2070
 ;  ^RGSITE(991.8,1,"CMOR" - #2746
 ;
GOBKG ;
 K STOP
 ;make sure only one job will run
 L +^XTMP("MPIF BATCH LOAD"):3 E  W !,"JOB ALREADY RUNNING" Q
 ;
 I '$D(^RGSITE(991.8,1,"CMOR")) W !,"CMOR Scores NOT Complete" G EXIT
 I $D(^RGSITE(991.8,1,"CMOR")),$P($G(^RGSITE(991.8,1,"CMOR")),"^",7)'="SN" W !,"CMOR Scores NOT Complete" G EXIT
 ;
 ;Check to see if job had STOPed -start where left off, start over or quit
 I $P($G(^MPIF(984.8,1,0)),"^",6)'="" D AGAIN
 I $D(STOP) W !,"Job NOT Started" K STOP G EXIT
 D BEG
 I $D(STOP) K STOP G EXIT
 S ZTRTN="GO^MPIFBT1",ZTDESC="USE HL7 MSGS AND MAIL TO BUILD ICN"
 S ZTIO="",ZTDTH=START
 I $D(DUZ) S ZTSAVE("DUZ")=DUZ
 I $D(ORDER) S ZTSAVE("ORDER")=ORDER
 D ^%ZTLOAD W:$D(ZTSK) !,"TASK #: ",ZTSK
 D HOME^%ZIS K IO("Q")
 K ZTDESC,ZTDTH,ZTIO,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,ZTSK,ORDER,START,ENDT
 Q
EXIT ;
 L -^XTMP("MPIF BATCH LOAD")
 Q
 ;
BEG K DIR,DIE,DR,DA,X,Y
 S DIR(0)="D^::AEFT",DIR("B")="NOW",DIR("A")="START TIME"
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) W !,"Job NOT Scheduled" K DTOUT,DUOUT,DIR,DA,X,Y S STOP="" Q
 S START=Y
 D DD^%DT
 S ENDT=Y
TRY K DIR,DIE,DR,DA,X,Y
 S DIR(0)="D^::AEFT",DIR("B")=ENDT,DIR("A")="STOP TIME"
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) W !,"Job NOT Scheduled" K DTOUT,DUOUT,DIR,DA,X,Y S STOP="" Q
 I Y'>START W !,"Stop Time must be greater than Start Time" G TRY
 D DD^%DT
 S ENDT=Y
 K DIR,DIE,DR,DA,X,Y
 S DIE="^MPIF(984.8,",DR="9///"_ENDT,DA=1 D ^DIE
 K DIE,X,Y,DA,DR
 I $D(DTOUT)!($D(DUOUT)) W !,"Job NOT Scheduled" K DTOUT,DUOUT,DIR,DA,X,Y S STOP="" Q
 Q
 ;
GO ;ENTRY POINT
 I '$D(ZTQUEUED) L +^XTMP("MPIF BATCH LOAD"):3 E  W !,"JOB ALREADY RUNNING" Q
 I '$D(ZTQUEUED),('$D(^RGSITE(991.8,1,"CMOR"))) W !,"CMOR Scores NOT Complete" G EXIT
 I '$D(ZTQUEUED),$D(^RGSITE(991.8,1,"CMOR")),$P($G(^RGSITE(991.8,1,"CMOR")),"^",7)'="SN" W !,"CMOR Scores NOT Complete" G EXIT
 K STOP
 ;Check to see if job had STOPed-start where left off, start over or quit
 I '$D(ZTQUEUED),$P($G(^MPIF(984.8,1,0)),"^",6)'="" D AGAIN
 I $D(STOP) W !,"Job NOT Started" K STOP G EXIT
 I '$D(ZTQUEUED) D BEG
 I $D(STOP) K STOP G EXIT
GO1 K ^TMP("HLS",$J)
 N MPIMORE,MPITOT
 I $D(ZTQUEUED) S ZTREQ="@"
 S QUITIME=$P(^MPIF(984.8,1,0),"^",10)
 I '$D(ORDER) S ORDER=0
 ;
 K ^TMP("HLS",$J)
 S MPICNT=$S($P(^MPIF(984.8,1,0),"^",9)>1:$P(^MPIF(984.8,1,0),"^",9),1:1)
 I +ORDER<1 S ORDER=0
 D WORK
 I $D(^TMP("HLS",$J)) D SEND
 D STOP^RGHLLOG(0)
 K MPIIT,MPITOT,HLDT,HLDT1,MPICNT,MPIDNUM,MPIEROR,MPIMIDT,MPIMSH
 K MPIOUT,MPIQRYNM,MPISEQ,ORDER,QCNT,QUITIME,MPIMCNT,MPIMTX,ORDER,START
 K ENDT
 L -^XTMP("MPIF BATCH LOAD")
 Q
WORK ;
 Q:$P(^MPIF(984.8,1,0),"^",6)="STOP"
 D NOW^%DTC
 S $P(^MPIF(984.8,1,0),"^",2)=%
 I %>QUITIME Q
 S MPIMCNT="",MPIMTX=""
 D HLRDF,LOOP
 Q
 ;
HLRDF ;
 S (MPIOUT,MPIMCNT)=""
 S HL("ECH")="^~\&"
 S HL("FS")="|"
 D INIT^HLFNC2("MPIF ICN-Q02 SERVER",.HL)
 I $O(HL("")) S ^TMP($J,"MPIF","ERR")=HL
 D CREATE^HLTF(.MPIMCNT,.MPIMTX,.HLDT,.HLDT1)
 D START^RGHLLOG()
 Q:$P(^MPIF(984.8,1,0),"^",6)="STOP"
 S $P(^MPIF(984.8,1,0),"^",7)=MPIMCNT
 S $P(^MPIF(984.8,1,0),"^",8)=MPIMTX
 Q
LOOP ;
 Q:$P(^MPIF(984.8,1,0),"^",6)="STOP"
 S MPIDNUM=1
 D MAKE
 Q
SEND ;ready to send
 S $P(^MPIF(984.8,1,0),"^",5)="GENERATE TAG"
 D GENERATE^HLMA("MPIF ICN-Q02 SERVER","GB",1,.MPIMTX,.MPIEROR,.MPIMORE)
 I +MPIEROR=0 S ^TMP($J,"MPIF","ERR")=MPIEROR
 D NOW^%DTC
 S $P(^MPIF(984.8,1,0),"^",3)=%
 K %,MPIMTX,MPIEROR,MPIMORE
 K ^TMP("HLS",$J)
 Q
MAKE ;
 F  S ORDER=$O(^DPT("ACMORS",ORDER)) Q:ORDER=""!($P(^MPIF(984.8,1,0),"^",6)="STOP")  D
 .S MPIIT=0
 .F  S MPIIT=$O(^DPT("ACMORS",ORDER,MPIIT)) Q:MPIIT=""!($P(^MPIF(984.8,1,0),"^",6)="STOP")  D
 ..D MAKE3
 ..D NOW^%DTC
 ..I %>QUITIME S $P(^MPIF(984.8,1,0),"^",6)="STOP"
 Q
MAKE3 ;
 K MPIOUT
 Q:$P(^MPIF(984.8,1,0),"^",6)="STOP"
 S $P(^MPIF(984.8,1,0),"^",5)="LOOPING: "_MPIDNUM
 S:$G(MPIQRYNM)="" MPIQRYNM="VTQ_PID_ICN_LOAD_1"
 D VTQ1^MPIFVTQ(MPIIT,.MPIOUT,.HL,.MPIQRYNM)
 I $P(MPIOUT(0),"^",1)<0,$P(MPIOUT(0),"^",2)="invalid DFN"!($P(MPIOUT(0),"^",2)="no encoding characters") D
 .D EXC^RGHLLOG(206,"DFN = "_MPIIT_"  Problem with building VTQ was "_$P(MPIOUT(0),"^",2),MPIIT) Q
 ;I $P(MPIOUT(0),"^")<0,$P(MPIOUT(0),"^",2)="Missing Required Field(s)" D EXC^RGHLLOG(209,"DFN - "_MPIIT_" Missing Required Field(s)",MPIIT) Q
 Q:$P(MPIOUT(0),"^")<0
 ;call for HL7 header
 S MPIMIDT=MPIMCNT_"-"_MPIDNUM
 D MSH^HLFNC2(.HL,MPIMIDT,.MPIMSH)
 S MPIOUT(1)=MPIMSH
 ;MESSAGE BUILT
 S MPISEQ=0
 F  S MPISEQ=$O(MPIOUT(MPISEQ)) Q:MPISEQ'>0  D
 .S ^TMP("HLS",$J,MPICNT)=MPIOUT(MPISEQ)
 .S MPICNT=MPICNT+1
 S $P(^MPIF(984.8,1,0),"^",11)=ORDER
 S $P(^MPIF(984.8,1,0),"^",9)=MPICNT
 S $P(^MPIF(984.8,1,0),"^",4)=MPIIT
 S MPIDNUM=MPIDNUM+1
 I MPIDNUM>100 D
 .D SEND
 .S (MPICNT,MPIDNUM)=1
 .D HLRDF
 Q
 ;
AGAIN ;job started before
 W !,"Job was started before and has Stopped"
 K DIR,DR
 S DIR(0)="Y",DIR("B")="YES",DIR("A")="Begin Where Left Off? ",DIR("?")="Y for yes to start where job left off, N for no"
 D ^DIR
 I Y=1 S ORDER=$P(^MPIF(984.8,1,0),"^",11),$P(^MPIF(984.8,1,0),"^",6)="" G END
 ;job started but used doesn't want to start where job left off
 W !,"'E' - Exit or 'O' - Start over from the Beginning"
 K DIR,DR
 S DIR(0)="S^E:EXIT;O:OVER",DIR("?")="E for Exit, O to Start Over from the Beginning"
 S DIR("A")="What would you like to do?"
 D ^DIR
 S:Y="E" STOP=""
 S:Y="O" ORDER=0,$P(^MPIF(984.8,1,0),"^",6)=""
END ;
 K DIR,Y,DR,X
 ; wants to start over or from where job left off if '$d(stop)
 Q
