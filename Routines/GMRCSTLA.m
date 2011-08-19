GMRCSTLA ;SLC/JFR,WAT - DRIVER FOR LOCAL CSLT COMPL RATE ;
 ;;3.0;CONSULT/REQUEST TRACKING;**67**;DEC 27, 1997;Build 1
 ;
 ;This routine invokes the following ICRs:
 ;1519(XUTMDEVQ,10103(XLFDT),10104(XLFSTR),10089(%ZISC),10026(DIR)
 Q
 ;
EN       ; start here
 K GMRCQUT
 N DIROUT,DTOUT,DUOUT,DIR,DIRUT,GMRCTMP,GMRCDG,GMRCSVC,GMRCSVNM,GMRCDT1
 N GMRCDT2,GMRCFMT,GMRCGRP,VALMBCK,GMRCSAVE
 ;
 ;Ask for service
 N Y
 S DIR(0)="PO^123.5:EMQ",DIR("??")="^D LISTALL^GMRCASV"
 S DIR("A")="Select Service/Specialty"
 D ^DIR
 I Y<1 Q
 S GMRCDG=+Y,GMRCSVNM=$P(Y,U,2)
 ;
 ;Ask for date range
 D ^GMRCSPD
 I $D(GMRCQUT) G EXIT
 ;
 ; what type of report
 K DIR,X,Y
 S DIR(0)="S:O^S:Summary;D:Delimited",DIR("A")="What type of report"
 D ^DIR
 I Y="" G EXIT
 S GMRCFMT=$S(Y="S":"CP",1:"DEL")
 ;
 W @IOF
 S GMRCSAVE("GMRCFMT")=""
 S GMRCSAVE("GMRCDG")=""
 S GMRCSAVE("GMRCDT1")=""
 S GMRCSAVE("GMRCDT2")=""
 S GMRCSAVE("GMRCSVNM")=""
 ;
 D EN^XUTMDEVQ("PRNTQ^GMRCSTLA","LOCAL CONSULT COMPLETION RATES",.GMRCSAVE)
 ;
 D EXIT
 ;
 Q
 ;
ENOR(RETURN,GMRCSVC,GMRCDT1,GMRCDT2,GMRCSTAT,GMRCARRN) ;Entry point
 ;.RETURN:   This is the root to the returned temp array.
 ;GMRCSVC:  Service for which consults are to be displayed.
 ;GMRCDT1:  Starting date or "ALL"
 ;GMRCDT2:  Ending date if not GMRCDT1="ALL"
 ;GMRCSTAT: The list of status to include separated by commas
 ;GMRCARRN: Format of report becomes ^TMP array element
 ;          "CP": Summary Report; "DEL": Delimited Report
 ;
 ;This temp array is used internally by the report:
 ;^TMP("GMRCSLIST",$J,n)=ien^name^parient ien^"+" if grouper^status
 ;  status is "" tracking and/or grouper
 ;            1  grouper only
 ;            2  tracking only
 ;            9  disabled
 ;
 N GMRCEDT1,GMRCEDT2,GMRCDG,GMRCHEAD,GMRCGRP,VALMCNT,VALMBCK
 K ^TMP("GMRCR",$J,GMRCARRN)
 S RETURN="^TMP(""GMRCR"",$J,GMRCARRN)"
 I '($D(GMRCSVC)#2) S GMRCSVC=1
 Q:'$D(^GMR(123.5,$G(GMRCSVC),0))
 ;Build service array
 S GMRCDG=GMRCSVC
 D SERV1^GMRCASV
 ;Get external form of date range
 I '($D(GMRCDT1)#2) S GMRCDT1="ALL"
 S:GMRCDT1="ALL" GMRCDT2=0
 D LISTDATE^GMRCSTU1(GMRCDT1,$G(GMRCDT2),.GMRCEDT1,.GMRCEDT2)
 ;
 N GMRCDA,INDEX,STATUS,LOOP,GROUPER
 N STS,GMRCD,GMRCDT,GMRCSVCG,TEMP,GMRCPT,LINETEMP
 N GMRCPTN,GMRCPTSN,GMRCDLA,GMRCXDT,GMRCLOC,GMRCSVCP
 N GRP,GMRCIRF,GMRCIRFN,GMRCIDD,GMRCST,GMRCRDT
 ;
 K ^TMP("GMRCR",$J,GMRCARRN),^TMP("GMRCRINDEX",$J),^TMP("GMRCTOT",$J)
 ;
 S GROUPER=0
 S GROUPER(0)=0
 I GMRCARRN="DEL" D
 . N STR
 . S STR="Service;Total;Unresolved;Complete;Comp w/Results;%Complete;"
 . S STR=STR_"%Comp w/Results"
 . S ^TMP("GMRCR",$J,GMRCARRN,1,0)=STR
 S INDEX=""
 ;Loop on Service
 F  S INDEX=$O(^TMP("GMRCSLIST",$J,INDEX)) Q:INDEX=""  D
 .S GMRCSVC=$P(^TMP("GMRCSLIST",$J,INDEX),"^",1)
 .S GMRCSVCP=$P(^TMP("GMRCSLIST",$J,INDEX),"^",2)
 .S GMRCSVCG=$P(^TMP("GMRCSLIST",$J,INDEX),"^",3)
 .S ^TMP("GMRCTOT",$J,1,GMRCSVC,"T")=0
 .S ^TMP("GMRCTOT",$J,1,GMRCSVC,"P")=0
 .S ^TMP("GMRCTOT",$J,1,GMRCSVC,"R")=0
 .S ^TMP("GMRCTOT",$J,1,GMRCSVC,"C")=0
 .S ^TMP("GMRCTOT",$J,2,GMRCSVC,"T")=0
 .S ^TMP("GMRCTOT",$J,2,GMRCSVC,"P")=0
 .S ^TMP("GMRCTOT",$J,2,GMRCSVC,"R")=0
 .S ^TMP("GMRCTOT",$J,2,GMRCSVC,"C")=0
 . ;Check if starting a new Grouper
 . F  Q:GROUPER(GROUPER)=GMRCSVCG  D
 ..;End of a group so print the group totals
 ..I GROUPER(GROUPER)=GMRCSVCG D
 ... I GMRCARRN="CP" D
 .... D PRTTOT^GMRCSTLB(2,GROUPER(GROUPER),GMRCARRN)
 ... I GMRCARRN="DEL" D
 .... D DELTOT^GMRCSTLB(2,GROUPER(GROUPER),GMRCARRN)
 ..;pop grouper from stack
 ..S GROUPER=GROUPER-1
 .I $P(^TMP("GMRCSLIST",$J,INDEX),"^",4)="+" D
 ..;push new grouper on stack
 ..S GROUPER=GROUPER+1
 ..S GROUPER(GROUPER)=GMRCSVC
 .;Loop for one status at a time
 .F LOOP=1:1:$L(GMRCSTAT,",") S STATUS=$P(GMRCSTAT,",",LOOP) D
 .. D ONESTAT^GMRCSTLB(GMRCARRN,INDEX,STATUS,GMRCDT1,GMRCDT2)
 .F GRP=GROUPER:-1:1 D
 ..;  pending for this service to all of its groupers
 ..S ^TMP("GMRCTOT",$J,2,GROUPER(GRP),"P")=$G(^TMP("GMRCTOT",$J,2,GROUPER(GRP),"P"))+^TMP("GMRCTOT",$J,1,GMRCSVC,"P")
 .. ; completed w/results for all groupers
 .. S ^TMP("GMRCTOT",$J,2,GROUPER(GRP),"R")=$G(^TMP("GMRCTOT",$J,2,GROUPER(GRP),"R"))+^TMP("GMRCTOT",$J,1,GMRCSVC,"R")
 ..;  for all status for this service to all of its groupers
 ..S ^TMP("GMRCTOT",$J,2,GROUPER(GRP),"T")=$G(^TMP("GMRCTOT",$J,2,GROUPER(GRP),"T"))+^TMP("GMRCTOT",$J,1,GMRCSVC,"T")
  .. ; add all completed for all groupers
  .. S ^TMP("GMRCTOT",$J,2,GROUPER(GRP),"C")=$G(^TMP("GMRCTOT",$J,2,GROUPER(GRP),"C"))+^TMP("GMRCTOT",$J,1,GMRCSVC,"C")
  .;
  .;Print the totals for this service that are >0
  . I GMRCARRN="CP" D
  .. D PRTTOT^GMRCSTLB(1,GMRCSVC,GMRCSVCP,GMRCARRN)
  . I GMRCARRN="DEL" D
  .. D DELTOT^GMRCSTLB(1,GMRCSVC,GMRCSVCP,GMRCARRN)
  . Q
  ;
  ;Done, so now list the group totals for the top group
  ;F GROUPER=GROUPER:-1:1 D  ; left for looking at all totals in future
  I $G(GROUPER) S GROUPER=1 D
  . I GMRCARRN="CP" D
  .. D PRTTOT^GMRCSTLB(2,GROUPER(GROUPER),$P(^GMR(123.5,GROUPER(GROUPER),0),"^",1),GMRCARRN)
  . I GMRCARRN="DEL" D
  .. D DELTOT^GMRCSTLB(2,GROUPER(GROUPER),$P(^GMR(123.5,GROUPER(GROUPER),0),"^",1),GMRCARRN)
  Q
  ;
PRNTQ      ;Build report and print it
  ;
 N GMRCPG,GMRCTMP,IDX,GMRCQUT,TEMP
 S GMRCPG=1
 D SERV1^GMRCASV
 D HEAD(GMRCPG) S GMRCPG=GMRCPG+1
 W !,$J("",23)_"Local Consult Completion Rates"
 S TEMP="FROM: "_$$FMTE^XLFDT(GMRCDT1)_"  TO: "_$$FMTE^XLFDT(GMRCDT2)
 I GMRCDT1="ALL" S TEMP="ALL DATES"
 W !,$J("",40-($L(TEMP)/2)+.5)_TEMP,!
 I '$O(^TMP("GMRCSLIST",$J,0)) D  G EXIT
 . W !!,"No records to print"
 D ENOR^GMRCSTLA(.GMRCTMP,GMRCDG,GMRCDT1,GMRCDT2,"5,6,8,2,9",GMRCFMT)
 I '$D(^TMP("GMRCR",$J,GMRCFMT)) D
 . W !!,"No records to print",!
 S IDX=""
 F  S IDX=$O(^TMP("GMRCR",$J,GMRCFMT,IDX)) Q:'IDX!($G(GMRCQUT))  D
 . I IOSL-$Y<3 D
 .. I $E(IOST,1,2)["C-" D
 ... N DIR S DIR(0)="E" D ^DIR
 ... I 'Y S GMRCQUT=1
 .. Q:$G(GMRCQUT)
 .. D HEAD(GMRCPG) S GMRCPG=GMRCPG+1
 . Q:$G(GMRCQUT)
 . W ^TMP("GMRCR",$J,GMRCFMT,IDX,0),!
 I GMRCFMT="CP",'$G(GMRCQUT) D
 . Q:$O(^TMP("GMRCTOT",$J,0,""))=""
 . I IOSL-$Y<6 D HEAD(GMRCPG) S GMRCPG=GMRCPG+1
 . W !!!,$$REPEAT^XLFSTR("-",IOM-5)
 . W !,"Consult services with no activity meeting the criteria of this report in",!,"the specified date range:",!
 . S IDX=""
 . F  S IDX=$O(^TMP("GMRCTOT",$J,0,IDX)) Q:IDX=""!($G(GMRCQUT))  D
 .. I IOSL-$Y<3 D
 ... I $E(IOST,1,2)["C-" D
 .... N DIR S DIR(0)="E" D ^DIR
 .... I 'Y S GMRCQUT=1
 ... Q:$G(GMRCQUT)
 ... D HEAD(GMRCPG) S GMRCPG=GMRCPG+1
 .. Q:$G(GMRCQUT)
 .. W ?4,IDX,!
 D ^%ZISC
 D EXIT
 Q
 ;
HEAD(PAGE) ; print header
 W @IOF
 W "Local Consult Completion Rates",?40,$$HTE^XLFDT($H)
 W ?73,"Page: ",PAGE,!
 W $$REPEAT^XLFSTR("-",IOM-2),!
 Q
 ;
EXIT     F ARR="GMRCR","GMRCS","GMRCSLIST","GMRCTOT" K ^TMP(ARR,$J)
 K ARR
 Q
 ;
