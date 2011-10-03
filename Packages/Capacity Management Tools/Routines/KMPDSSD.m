KMPDSSD ;OAK/RAK - CM Tools Status ;2/14/05  11:42
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**3**;Mar 22, 2002
 ;
FORMAT(KMPDLN) ;-format text for display
 ;-----------------------------------------------------------------------------
 ; KMPDLN.... return number of lines - called by reference
 ;-----------------------------------------------------------------------------
 ;
 Q:$G(KMPDNMSP)=""
 ;
 N LN,VERSION,X S LN=0 K TMP
 ;
 ; if no kmpdutl routine
 S X="KMPDUTL" X ^%ZOSF("TEST") I '$T D  Q
 .S LN=LN+1
 .D SET^VALM10(LN,"The CM Tools Package is not installed!")
 ;
 ; version data
 S VERSION=$$VERSION^KMPDUTL
 ;
 ; option data
 D OPT("KMPD BACKGROUND DRIVER")
 ;
 ; bacground data
 D BKGRND
 ;
 ; file data
 D FILES
 ;
 ; routine version check
 D ROUCHK^KMPDSSD1("D")
 ;
 ; node/cpu data
 D CPU^KMPDSSD1
 ;
 ; mailgroup members
 D MGRP^KMPDSSD1
 ;
 ; legend
 D LEGEND
 ;
 S KMPDLN=LN
 ;
 Q
 ;
BKGRND ; hl7 background info
 ;
 N DATA,DELTA,ENDT,I,STAT,STDT,Z
 ;
 D PARAMS^KMPDUT("DATA") Q:'$D(DATA)
 S DATA(3)=$G(DATA(3)),DATA(4)=$G(DATA(4))
 S STDT=$P(DATA(3),U,5),ENDT=$P(DATA(3),U,6),DELTA=$P(DATA(3),U,7)
 S:$E(DELTA)=" " $E(DELTA)="0"
 ; if hl7
 I KMPDNMSP="H" D 
 .S LN=LN+1
 .D SET^VALM10(LN,"")
 .S LN=LN+1
 .D SET^VALM10(LN,"   Hl7 Dly Bckgrnd Last Start.. "_$$FMTE^XLFDT(STDT))
 .S LN=LN+1
 .D SET^VALM10(LN,"   HL7 Dly Bckgrnd Last Stop... "_$$FMTE^XLFDT(ENDT))
 .S LN=LN+1
 .D SET^VALM10(LN,"   HL7 Dly Bkgrnd Total Time... "_DELTA)
 .S STDT=$P(DATA(3),U,8),ENDT=$P(DATA(3),U,9),DELTA=$P(DATA(3),U,10)
 .S:$E(DELTA)=" " $E(DELTA)="0"
 .S LN=LN+1
 .D SET^VALM10(LN,"")
 .S LN=LN+1
 .D SET^VALM10(LN,"   HL7 Wkly Backgrnd Last Start "_$$FMTE^XLFDT(STDT))
 .S LN=LN+1
 .D SET^VALM10(LN,"   HL7 Wkly Bckgrnd Last Stop.. "_$$FMTE^XLFDT(ENDT))
 .S LN=LN+1
 .D SET^VALM10(LN,"   HL7 Wkly Bckgrnd Total Time. "_DELTA)
 .S LN=LN+1
 .D SET^VALM10(LN,"   HL7 Purge Data After........ "_$P(DATA(3),U,11)_" weeks")
 .D TRANSTO^KMPDUTL7(1,3,.Z)
 .I '$D(Z) S LN=LN+1 D SET^VALM10(LN,"   HL7 Transmit Data to........ <>")
 .E  D 
 ..S I=$O(Z("")) I I'="" S LN=LN+1 D SET^VALM10(LN,"   HL7 Transmit Data to........ "_I)
 ..F  S I=$O(Z(I)) Q:I=""  S LN=LN+1 D SET^VALM10(LN,$J(" ",32)_I)
 .S LN=LN+1
 .D SET^VALM10(LN,"")
 ;
 ; timing background info - if available
 I KMPDNMSP="T" D 
 .S LN=LN+1
 .D SET^VALM10(LN,"")
 .I '$D(DATA(4)) S LN=LN+1 D SET^VALM10(LN,"   There is no Timing data to report") Q
 .S STAT=$G(^KMPTMP("KMPD-CPRS"))
 .S LN=LN+1
 .D SET^VALM10(LN,"   TMG Collection Status....... "_$S(STAT:"Running",1:"STOPPED!"))
 .S STDT=$P(DATA(4),U,5),ENDT=$P(DATA(4),U,6),DELTA=$P(DATA(4),U,7)
 .S:$E(DELTA)=" " $E(DELTA)="0"
 .S LN=LN+1
 .D SET^VALM10(LN,"   TMG Dly Bckgrnd Last Start.. "_$$FMTE^XLFDT(STDT))
 .S LN=LN+1
 .D SET^VALM10(LN,"   TMG Dly Bckgrnd Last Stop... "_$$FMTE^XLFDT(ENDT))
 .S LN=LN+1
 .D SET^VALM10(LN,"   TMG Dly Bkgrnd Total Time... "_DELTA)
 .S STDT=$P(DATA(4),U,8),ENDT=$P(DATA(4),U,9),DELTA=$P(DATA(4),U,10)
 .S:$E(DELTA)=" " $E(DELTA)="0"
 .S LN=LN+1
 .D SET^VALM10(LN,"   TMG Purge Data After........ "_$P(DATA(4),U,11)_" weeks")
 .D TRANSTO^KMPDUTL7(1,4,.Z)
 .I '$D(Z) S LN=LN+1 D SET^VALM10(LN,"   TMG Transmit Data to........ <>")
 .E  D 
 ..S I=$O(Z("")) I I'="" S LN=LN+1 D SET^VALM10(LN,"   TMG Transmit Data to........ "_I)
 ..F  S I=$O(Z(I)) Q:I=""  S LN=LN+1 D SET^VALM10(LN,$J(" ",32)_I)
 .S LN=LN+1
 .D SET^VALM10(LN,"")
 ;
 Q
 ;
FILES ;-- file data
 ;
 N TEXT,X
 ;
 S LN=LN+1
 D SET^VALM10(LN,$J(" ",35)_" # of     Oldest     Recent")
 S LN=LN+1
 D SET^VALM10(LN,"   File"_$J(" ",28)_"Entries    Date       Date")
 S LN=LN+1
 D SET^VALM10(LN,"   -------------------------       -------   -------   -------")
 ;
 ; if hl7
 I KMPDNMSP="H" D 
 .; file name
 .S TEXT="   8973.1 - "_$P($G(^DIC(8973.1,0)),U)
 .; number of entries
 .S TEXT=TEXT_$J(" ",35-$L(TEXT))_$J($FN($P($G(^KMPD(8973.1,0)),U,4),",",0),7)
 .; oldest date
 .S X=$$FMTE^XLFDT(+$O(^KMPD(8973.1,"B",0)),2)
 .S X=$S(X=0:"---",1:X)
 .S TEXT=TEXT_$J(" ",45-$L(TEXT))_X
 .; current date
 .S X=$$FMTE^XLFDT(+$O(^KMPD(8973.1,"B","A"),-1),2)
 .S X=$S(X=0:"---",1:X)
 .S TEXT=TEXT_$J(" ",55-$L(TEXT))_X
 .S LN=LN+1
 .D SET^VALM10(LN,TEXT)
 ;
 ; if timing data
 I KMPDNMSP="T" D 
 .; file name
 .S TEXT="   8973.2 - "_$P($G(^DIC(8973.2,0)),U)
 .; number of entries
 .S TEXT=TEXT_$J(" ",35-$L(TEXT))_$J($FN($P($G(^KMPD(8973.2,0)),U,4),",",0),7)
 .; oldest date
 .S X=$$FMTE^XLFDT($P(+$O(^KMPD(8973.2,"C",0)),"."),2)
 .S X=$S(X=0:"---",1:X)
 .S TEXT=TEXT_$J(" ",45-$L(TEXT))_X
 .; most recent date
 .S X=$$FMTE^XLFDT($P(+$O(^KMPD(8973.2,"ASTDTTM","A"),-1),"."),2)
 .S X=$S(X=0:"---",1:X)
 .S TEXT=TEXT_$J(" ",55-$L(TEXT))_X
 .S LN=LN+1
 .D SET^VALM10(LN,TEXT)
 ;
 Q
 ;
LEGEND ;-- display legend
 ;
 S LN=LN+1
 D SET^VALM10(LN,"")
 S LN=LN+1
 D SET^VALM10(LN,"")
 I KMPDNMSP="H" D 
 .S LN=LN+1
 .D SET^VALM10(LN,"     HL7 = Health Level Seven")
 I KMPDNMSP="T" D 
 .S LN=LN+1
 .D SET^VALM10(LN,"     TMG = Timing Data")
 ;
 Q
 ;
OPT(KMPDOPT) ;-- option data
 ;-----------------------------------------------------------------------------
 ; KMPDOPT... Option name - free text
 ;-----------------------------------------------------------------------------
 ;
 Q:$G(KMPDOPT)=""
 ;
 N DIR,DOW,FREQ,KMPDX,KMPDX1,OPTEXT,STATUS,TEXT,X,Y
 ;
 S STATUS=$$TSKSTAT^KMPDUTL1(KMPDOPT)
 ;
 ; option not in system
 Q:(+STATUS)=3
 ;
 S OPTEXT=""
 S:KMPDOPT="KMPD BACKGROUND DRIVER" OPTEXT="CM Tools Background Driver"
 S:KMPDOPT="KMPR BACKGROUND DRIVER" OPTEXT="RUM Background Driver"
 S:KMPDOPT="KMPS SAGG REPORT" OPTEXT="SAGG Master Background Task"
 ;
 ; if background option is missing
 I (+STATUS)=3 D  Q
 .S LN=LN+1
 .D SET^VALM10(LN,"   The "_OPTEXT_" option [KMPD BACKGROUND DRIVER] is missing!")
 ;
 ; background option is present
 ;
 ; if cm tools and not scheduled or no task id
 I KMPDOPT="KMPD BACKGROUND DRIVER"&(+(STATUS)=3) D  Q:'Y
 .K DIR S DIR(0)="YO",DIR("B")="YES"
 .S DIR("A")="Do you want to queue this option to run each night at 1:30am"
 .W ! D ^DIR I 'Y D  Q
 ..S LN=LN+1
 ..D SET^VALM10(LN,"   The "_OPTEXT_" ["_KMPDOPT_"] is not scheduled")
 ..S LN=LN+1
 ..D SET^VALM10(LN,"   to run!"),SET^VALM10(LN,"")
 .D QUEBKG^KMPDUTL("KMPD BACKGROUND DRIVER","T+1@0130","1D",0)
 ;
 ; if not scheduled or no task id
 I KMPDOPT="KMPR BACKGROUND DRIVER"&(+(STATUS)=3) D   Q:'Y
 .K DIR S DIR(0)="YO",DIR("B")="YES"
 .S DIR("A")="Do you want to queue this option to run each night at 1am"
 .W ! D ^DIR I 'Y D  Q
 .. S LN=LN+1
 ..D SET^VALM10(LN,"   The "_OPTEXT_" ["_KMPDOPT_"] is not scheduled")
 ..S LN=LN+1
 ..D SET^VALM10(LN,"   to run!"),SET^VALM10(LN,"")
 .D QUEBKG^KMPRUTL1
 ;
 ; check status again in case it has been requeued
 S STATUS=$$TSKSTAT^KMPDUTL1(KMPDOPT)
 ;
 ; not scheduled
 I (+STATUS)=1 S LN=LN+1 D SET^VALM10(LN,"   The "_OPTEXT_" [KMPD BACKGROUND DRIVER] is not scheduled") Q
 ;
 S TEXT="   "_OPTEXT
 S TEXT=TEXT_$$REPEAT^XLFSTR(".",31-$L(TEXT))
 S TEXT=TEXT_" "_KMPDOPT
 S LN=LN+1
 D SET^VALM10(LN,TEXT)
 S LN=LN+1
 D SET^VALM10(LN,"   QUEUED TO RUN AT............ "_$P(STATUS,U,3))
 S LN=LN+1
 D SET^VALM10(LN,"   RESCHEDULING FREQUENCY...... "_$P(STATUS,U,5))
 ;
 ; check to see if SAGG is not running on the weekend (Fri-Sun)
 S DOW=$P(STATUS,U,4),FREQ=$P(STATUS,U,6)
 I KMPDOPT="KMPS SAGG REPORT" I (DOW<0)!((DOW>0)&(DOW<5))!(FREQ<0)!(FREQ'="28D") D 
 .S LN=LN+1
 .D SET^VALM10(LN,"                                ***It is STRONGLY recommended that this job be")
 .S LN=LN+1
 .D SET^VALM10(LN,"                                   rescheduled to run over the weekend every 28 days.***")
 ;
 S LN=LN+1
 D SET^VALM10(LN,"   TASK ID..................... "_$P(STATUS,U,7))
 ; user info.
 S TEXT="   QUEUED BY................... "_$P(STATUS,U,8)
 ; user
 S TEXT=TEXT_"  ("_$S($P(STATUS,U,9)["NOT ACTIVE":"Not Active - ",1:"Active")_")"
 S LN=LN+1
 D SET^VALM10(LN,TEXT)
 ; if user is not active
 I $P(STATUS,U,9)="NOT ACTIVE" D 
 .S LN=LN+1
 .D SET^VALM10(LN,"                                ***The user that originally queued this task is no ")
 .S LN=LN+1
 .D SET^VALM10(LN,"                                   longer active. Therefore the 'SAGG Master Background")
 .S LN=LN+1
 .D SET^VALM10(LN,"                                   Task' [KMPS SAGG REPORT] must be scheduled again by")
 .S LN=LN=1
 .D SET^VALM10(LN,"                                   an active user.***")
 ;
 Q
