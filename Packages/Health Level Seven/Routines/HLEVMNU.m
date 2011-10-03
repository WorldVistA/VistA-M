HLEVMNU ;O-OIFO/LJA - Event Monitor VistA HL7 PROGRAMMER Menu ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
INIT ;
 ;
CTRL ;
 D HEADER
 D M
 D ASK I 'A7UOK QUIT  ;->
 D XEC
 D BT QUIT:'A7UOK  ;->
 G CTRL ;->
 ;
BT ;
 W !
 S A7UOK=0
 N DIR
 S DIR(0)="EA",DIR("A")="Press RETURN to continue, or '^' to exit... "
 D ^DIR
 QUIT:+Y'=1  ;->
 S A7UOK=1
 QUIT
 ;
HEADER ;
 W @IOF,$$CJ^XLFSTR("HL7 Event Monitor Utilities for Programmer",IOM)
 W !,$$REPEAT^XLFSTR("=",80)
 QUIT
 ;
M KILL A7UMENU F I=1:1 S T=$T(M+I) QUIT:T'[";;"  S T=$P(T,";;",2,99),A7UMENU(I)=$P(T,"~",2,99) W !,$J(I,2),". ",$P(T,"~")
 ;;Kill all *RUNTIME* Event Monitoring data~D REMOVALL^HLEVUTIL
 ;;Start queued master job now~D MSTNOW^HLEVMST0
 ;;Queued master job (if no master job queued)~D STARTJOB^HLEVMST
 ;;Test previously run server request~D TEST^HLEVSRV1
 ;;Create $QUERY search strings~D QUERYSTR^HLEVSRV2
 ;;Set/delete debug tags~D DEBUGSET^HLEVAPI2
 ;;Run M code repetitively~D START^HLEVUTI2
 ;;Show M code repetitive jobs~D SHOW^HLEVUTI2
 ;;Test monitor~D TEST^HLEVUTI1
 QUIT
 ;
ASK ;
 W !
 S A7UOK=0
 N DIR
 S DIR(0)="NO^1:"_(+I-1),DIR("A")="Select option"
 D ^DIR
 QUIT:'$D(A7UMENU(+Y))  ;->
 S A7UOPT=+Y
 S A7UOK=1
 QUIT
 ;
XEC ;
 S X=A7UMENU(+A7UOPT) X X
 QUIT
 ;
EOR ;HLEVMNU - Event Monitor VistA HL7 PROGRAMMER Menu ;5/16/03 14:42
