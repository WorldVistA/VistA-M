GMRCSTL7 ;SLC/JFR/WAT - DRIVER FOR CSLT PER MONITOR ;4/8/05 10:28
 ;;3.0;CONSULT/REQUEST TRACKING;**41,60**;DEC 27, 1997;Build 9
 ;
 ;This routine invokes ICRs 
 ;1519(XUTMDEVQ,10103(XLFDT),10104(XLFSTR),3744(VADPT),10089(%ZISC),10026(DIR)
 Q
 ;
EN ; start here
 K GMRCQUT
 N DIROUT,DTOUT,DUOUT,DIR,Y,X,GMRCTMP,GMRCDG,GMRCSVC,GMRCSVNM,GMRCDT1
 N GMRCDT2,GMRCFMT,GMRCGRP,VALMBCK,GMRCSAVE
 N GMRC30ST,GMRC30SP
 D CAVEATS
 ;Ask for service
 S DIR(0)="P^123.5:EMQ",DIR("??")="^D LISTALL^GMRCASV"
 S DIR("A")="Select Service/Specialty"
 D ^DIR
 I $D(DTOUT)!($D(DUOUT))!($D(DIROUT))!(X="") D EXIT Q
 S GMRCDG=+Y,GMRCSVNM=$P(Y,U,2)
  ;Ask for current FY
 N DIROUT,DTOUT,DUOUT,DIR,Y,X,GMRCFY
 S DIR(0)="F^4:4^K:(X-1700)>($E(DT,1,3)+1) X"
 S DIR("A")="Current Fiscal Year (i.e. 2008)"
 S DIR("A",1)="Ensure you are providing fiscal year, NOT calendar year."
 D ^DIR
 I $D(DTOUT)!($D(DUOUT))!($D(DIROUT))!(X="") D EXIT Q
 S GMRCFY=X
 N DIROUT,DTOUT,DUOUT,DIR,Y,X,GMRCQTR,GMRCYR
 S DIR(0)="N^1:4"
 S DIR("A")="Enter a number 1 - 4"
 S DIR("A",1)="For which quarter are you running the report: first, second, third or fourth?"
 D ^DIR
 I $D(DTOUT)!($D(DUOUT))!($D(DIROUT))!(X="") D EXIT Q
 S GMRCQTR=X
 ;if first quarter
 I $G(GMRCQTR)=1 D
 .;use FY-1 to set year part of date range to the previous calendar year
 .S GMRCYR=$G(GMRCFY)-1700 S GMRCYR=$G(GMRCYR)-1,GMRCDT1=$E($G(GMRCYR),1,3)_"1001" S GMRCDT2=$G(GMRCYR)_"1231"
 I $G(GMRCQTR)=2 D
 .S GMRCYR=$G(GMRCFY)-1700 S GMRCDT1=$E($G(GMRCYR),1,3)_"0101" S GMRCDT2=$G(GMRCYR)_"0331"
 I $G(GMRCQTR)=3 D
 .S GMRCYR=$G(GMRCFY)-1700 S GMRCDT1=$E($G(GMRCYR),1,3)_"0401" S GMRCDT2=$G(GMRCYR)_"0630"
 I $G(GMRCQTR)=4 D
 .S GMRCYR=$G(GMRCFY)-1700 S GMRCDT1=$E($G(GMRCYR),1,3)_"0701" S GMRCDT2=$G(GMRCYR)_"0930"
 S GMRC30ST=$$FMADD^XLFDT(GMRCDT1,-30),GMRC30SP=$$FMADD^XLFDT(GMRCDT2,-30)
 ; what type of report
 N DIROUT,DTOUT,DUOUT,DIR,Y,X
 S DIR(0)="S:O^S:Summary;D:Delimited",DIR("A")="What type of report"
 D ^DIR
 I $D(DTOUT)!($D(DUOUT))!($D(DIROUT))!(X="") D EXIT Q
 S GMRCFMT=$S(Y="S":"CP",1:"DEL")
 ;
 W @IOF
 S GMRCSAVE("GMRCFMT")=""
 S GMRCSAVE("GMRCDG")=""
 S GMRCSAVE("GMRCDT1")=""
 S GMRCSAVE("GMRCDT2")=""
 S GMRCSAVE("GMRC30ST")=""
 S GMRCSAVE("GMRC30SP")=""
 S GMRCSAVE("GMRCSVNM")=""
 S GMRCSAVE("GMRCFY")=""
 S GMRCSAVE("GMRCQTR")=""
 ;
 N DIROUT,DTOUT,DUOUT,DIR,Y,X S DIR(0)="FO",DIR("A")="ENTER ""?"" FOR MORE HELP OR RETURN TO CONTINUE"
 S DIR("A",1)="MARGIN WIDTH IS BEST AT 256"
 S DIR("?")="^D MARGHLP^GMRCSTL7"
 D:GMRCFMT="DEL" ^DIR
 I $D(DTOUT)!($D(DUOUT))!($D(DIROUT)) D EXIT Q
 D EN^XUTMDEVQ("PRNTQ^GMRCSTL7","CONSULT PERFORMANCE MONITOR",.GMRCSAVE)
 ;
 D EXIT
 ;
 Q
MARGHLP ;help text to set margins
 W !,"Specify a device with optional parameters in the format"
 W !,?8,"Device Name;Right Margin;Page Length"
 W !,?21,"or"
 W !,?5,"Device Name;Subtype;Right Margin;Page Length"
 W !!,"Or in the new format"
 W !,?14,"Device Name;/settings"
 W !,?21,"or"
 W !,?10,"Device Name;Subtype;/settings"
 W !,"For example"
 W !,?17,"HOME;80;999"
 W !,?21,"or"
 W !,?13,"HOME;C-VT320;/M80L999"
 Q
 ;
ENOR(RETURN,GMRCSVC,GMRC30ST,GMRC30SP,GMRCSTAT,GMRCST2,GMRCARRN) ;Entry point 
 ;.RETURN:   This is the root to the returned temp array.
 ;GMRCSVC:  Service for which consults are to be displayed.
 ;GMRC30ST:  30 days prior to quarter start date
 ;GMRC30SP:  30 days prior to quarter end date
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
 D LISTDATE^GMRCSTU1(GMRCDT1,$G(GMRCDT2),.GMRCEDT1,.GMRCEDT2)
 ;
 N GMRCDA,INDEX,STATUS,STATUS2,LOOP,GROUPER
 N GMRCSVCG,GMRCPT,GMRCSVCP,GRP,PIECE,TYPE
 ;
 K ^TMP("GMRCR",$J,GMRCARRN),^TMP("GMRCRINDEX",$J),^TMP("GMRCT",$J)
 ;
 S GROUPER=0
 S GROUPER(0)=0
 I GMRCARRN="DEL" D
 . N STR
 . S STR="Svc;30DayRng;60DayRng;CmpIn30;Cmp31-60;B4Qtr;PndB4Qtr;%Cmp30;%Cmp60;%UnRsB4Qtr;IS30Rng;IS60Rng;ISCmp30;ISCmp31-60;ISB4Qtr;ISPndB4Qtr;%ISCmp30;%ISCmp60;%ISUnRsB4Qtr;"
 . S STR=STR_"IR30Rng;IR60Rng;IRCmp30;IRCmp31-60;IRB4Qtr;IRPndB4Qtr;%IRCmp30;%IRCmp60;%IRUnRsB4Qtr"
 . S ^TMP("GMRCR",$J,GMRCARRN,1,0)=STR
 S INDEX=""
 ;Loop on Service
 F  S INDEX=$O(^TMP("GMRCSLIST",$J,INDEX)) Q:INDEX=""  D
 .S GMRCSVC=$P(^TMP("GMRCSLIST",$J,INDEX),"^",1)
 .S GMRCSVCP=$P(^TMP("GMRCSLIST",$J,INDEX),"^",2)
 .S GMRCSVCG=$P(^TMP("GMRCSLIST",$J,INDEX),"^",3)
 .N SUBIDX
 .;pieces for tmp arrays, 1 to 6 are local, 7 to 12 are IFC placer, 13 to 18 are IFC filler
 .;;total for 30 day start/end^total for 60 day start/end^results n 30 days^results n 60 days^total before quarter^total pending before quarter
 .S ^TMP("GMRCT",$J,1,GMRCSVC,"DATA")="0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0"
 .S ^TMP("GMRCT",$J,2,GMRCSVC,"DATA")="0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0"
 .;Check if starting a new Grouper
 .F  Q:GROUPER(GROUPER)=GMRCSVCG  D
 ..;End of a group so print the group totals
 ..I GROUPER(GROUPER)=GMRCSVCG D 
 ... I GMRCARRN="CP" D
 ....D PRTTOT^GMRCSTL8(2,GROUPER(GROUPER),GMRCARRN)
 ...I GMRCARRN="DEL" D
 ....D DELTOT^GMRCSTL8(2,GROUPER(GROUPER),GMRCARRN)
 ..;pop grouper from stack
 ..S GROUPER=GROUPER-1
 .I $P(^TMP("GMRCSLIST",$J,INDEX),"^",4)="+" D
 ..;push new grouper on stack
 ..S GROUPER=GROUPER+1
 ..S GROUPER(GROUPER)=GMRCSVC
 .;Loop for one status at a time
 .F LOOP=1:1:$L(GMRCSTAT,",") S STATUS=$P(GMRCSTAT,",",LOOP) D
 ..D ONESTAT^GMRCSTL8(GMRCARRN,INDEX,STATUS,GMRC30ST,GMRC30SP,"30")
 .F LOOP=1:1:$L(GMRCSTAT,",") S STATUS=$P(GMRCSTAT,",",LOOP) D
 ..D ONESTAT^GMRCSTL8(GMRCARRN,INDEX,STATUS,$$FMADD^XLFDT(GMRC30ST,-30),$$FMADD^XLFDT(GMRC30SP,-30),"60")
 .S GMRCDT1=$$FMADD^XLFDT(GMRC30ST,30) ;add 30 days back to set date back to start of FY quarter.
 .F LOOP=1:1:$L(GMRCST2,",") S STATUS2=$P(GMRCST2,",",LOOP) D
 ..D ONESTAT2^GMRCSTL8(GMRCARRN,INDEX,STATUS2,$$FMADD^XLFDT(GMRCDT1,-60))
 .F GRP=GROUPER:-1:1 D
 ..F PIECE=1:1:18 D
 ...S $P(^TMP("GMRCT",$J,2,GROUPER(GRP),"DATA"),U,PIECE)=$P(^TMP("GMRCT",$J,2,GROUPER(GRP),"DATA"),U,PIECE)+$P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,PIECE)
 .;
 .;Print the totals for this service that are >0
 .I GMRCARRN="CP" D
 ..D PRTTOT^GMRCSTL8(1,GMRCSVC,GMRCSVCP,GMRCARRN)
 .I GMRCARRN="DEL" D
 ..D DELTOT^GMRCSTL8(1,GMRCSVC,GMRCSVCP,GMRCARRN)
 .Q
 ;
 ;Done, so now list the group totals for the top group
 ;F GROUPER=GROUPER:-1:1 D  ; left for looking at all totals in future
 I $G(GROUPER) S GROUPER=1 D
 .I GMRCARRN="CP" D
 ..D PRTTOT^GMRCSTL8(2,GROUPER(GROUPER),$P(^GMR(123.5,GROUPER(GROUPER),0),"^",1),GMRCARRN)
 .I GMRCARRN="DEL" D
 ..D DELTOT^GMRCSTL8(2,GROUPER(GROUPER),$P(^GMR(123.5,GROUPER(GROUPER),0),"^",1),GMRCARRN)
 Q
PRNTQ   ;Build report and print it
 ;
 N GMRCPG,GMRCTMP,IDX,GMRCQUT,TEMP
 S GMRCPG=1
 D SERV1^GMRCASV
 D HEAD(GMRCPG) S GMRCPG=GMRCPG+1
 S TEMP=$S($G(GMRCQTR)=4:"4",$G(GMRCQTR)=3:"3",$G(GMRCQTR)=2:"2",1:"1")_"Q"_"FY"_$E($G(GMRCFY),3,4)
 S TEMP="Consult/Request Performance Monitor - "_TEMP
 W $J("",40-($L(TEMP)/2)+.5)_TEMP
 S TEMP="Fiscal Quarter Dates: "_$$FMTE^XLFDT(GMRCDT1)_" - "_$$FMTE^XLFDT(GMRCDT2)
 W !,$J("",40-($L(TEMP)/2)+.5)_TEMP
 S TEMP="30 Days Before Start/End: "_$$FMTE^XLFDT(GMRC30ST)_" - "_$$FMTE^XLFDT(GMRC30SP)
 W !,$J("",40-($L(TEMP)/2)+.5)_TEMP
 S TEMP="60 Days Before Start/End: "_$$FMTE^XLFDT($$FMADD^XLFDT(GMRC30ST,-30))_" - "_$$FMTE^XLFDT($$FMADD^XLFDT(GMRC30SP,-30))
 W !,$J("",40-($L(TEMP)/2)+.5)_TEMP,!
 I '$D(IO("Q")) D WAIT^DICD W !!
 I '$O(^TMP("GMRCSLIST",$J,0)) D  G EXIT
 .W !!,"No records to print"
 D ENOR^GMRCSTL7(.GMRCTMP,GMRCDG,GMRC30ST,GMRC30SP,"2,5,6,8,9","1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,99",GMRCFMT)
 I '$D(^TMP("GMRCR",$J,GMRCFMT)) D
 .W !!,"No records to print",!
 S IDX=""
 F  S IDX=$O(^TMP("GMRCR",$J,GMRCFMT,IDX)) Q:'IDX!($G(GMRCQUT))  D
 .I IOSL-$Y<3 D
 ..I $E(IOST,1,2)["C-" D
 ...N DIR S DIR(0)="E" D ^DIR
 ...I 'Y S GMRCQUT=1
 ..Q:$G(GMRCQUT)
 ..D HEAD(GMRCPG) S GMRCPG=GMRCPG+1
 .Q:$G(GMRCQUT)
 .W ^TMP("GMRCR",$J,GMRCFMT,IDX,0),!
 D:$D(^TMP("GMRCR",$J,GMRCFMT)) CAVEATS
 I GMRCFMT="CP",'$G(GMRCQUT) D
 .Q:$O(^TMP("GMRCT",$J,0,""))=""
 .I IOSL-$Y<6 D HEAD(GMRCPG) S GMRCPG=GMRCPG+1
 .W !!!,$$REPEAT^XLFSTR("-",IOM-5)
 .W !,"Consult services not meeting the criteria of this report for",!,"the specified date range:",!
 .S IDX=""
 .F  S IDX=$O(^TMP("GMRCT",$J,0,IDX)) Q:IDX=""!($G(GMRCQUT))  D
 ..I IOSL-$Y<3 D
 ...I $E(IOST,1,2)["C-" D
 ....N DIR S DIR(0)="E" D ^DIR
 ....I 'Y S GMRCQUT=1
 ...Q:$G(GMRCQUT)
 ...D HEAD(GMRCPG) S GMRCPG=GMRCPG+1
 ..Q:$G(GMRCQUT)
 ..W ?4,IDX,!
 D ^%ZISC
 D EXIT
 Q
 ;
HEAD(PAGE) ; print header for CPM
 W @IOF
 I PAGE>1 D
 .S TEMP=$S($G(GMRCQTR)=4:"4",$G(GMRCQTR)=3:"3",$G(GMRCQTR)=2:"2",1:"1")_"Q"_"FY"_$E($G(GMRCFY),3,4)
 .S TEMP="Consult/Request Performance Monitor - "_TEMP
 .W !,$J("",40-($L(TEMP)/2)+.5)_TEMP,!
 W !,$J("Run Date: "_$$HTE^XLFDT($H),0),$J("Page: "_PAGE,48)
 W !,$$REPEAT^XLFSTR("-",IOM-2),!!
 Q
 ;
CAVEATS ; brief explanatory text
 W !!,"Resubmitted requests are evaluated based on the original Date of Request."
 W !!,"The following are excluded from this report:"
 W !," -Requests sent to test patients."
 W !," -Requests not marked as Outpatient in the REQUEST/CONSULTATION file."
 W !," -Services flagged as part of the interface between Consults/Request Tracking"
 W !,?2,"and Prosthetics."
 W !," -Administrative requests flagged via the Administrative fields in the"
 W !,?2,"REQUEST SERVICES and REQUEST/CONSULTATION files. This is not retroactive"
 W !,?2,"and only applies to services/requests leveraging the Administrative-flagging"
 W !,?2,"capability included in GMRC*3.0*60, available on or about June 2008.",!!
 Q
 ;
EXIT F ARR="GMRCR","GMRCS","GMRCSLIST","GMRCT" K ^TMP(ARR,$J)
 K ARR
 Q
 ;
