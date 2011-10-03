HLEVREP0 ;O-OIFO/LJA - Event Monitor REPORTS ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
RECIP ; Called by [HLEV REPORT MONITOR RECIPIENTS]
 N OPTYPE
 S OPTYPE=""
RECIP1 KILL ^TMP($J,"HLMREP")
 D HD("Monitor Recipients Reports")
 D EXRECIP
 S OPTYPE=$$RECIPO(OPTYPE) QUIT:OPTYPE']""  ;->
 D RECIPLD
 D @OPTYPE
 G RECIP1 ;->
 ;
RECIPMR ; List by monitor/recipient...
 D RECIPR("M")
 D BROWSE^DDBR($NA(^TMP($J,"HLMREP","REP")),"N","            Monitor                            Recipient                         ")
 Q
 ;
RECIPRM ; List by recipient/monitor...
 D RECIPR("R")
 D BROWSE^DDBR($NA(^TMP($J,"HLMREP","REP")),"N","            Recipient                          Monitor                           ")
 Q
 ;
RECIPR(SUB) ; Create displayable report...
 N CT,CTIN,SUB1,SUB1L,SUB2,SUB2L,STAT,TXT
 S SUB1="",CT=0,CTIN=0,SUB1L="",SUB2L=""
 F  S SUB1=$O(^TMP($J,"HLMREP",SUB,SUB1)) Q:SUB1']""  D
 .  S SUB2=""
 .  F  S SUB2=$O(^TMP($J,"HLMREP",SUB,SUB1,SUB2)) Q:SUB2']""  D
 .  .  S STAT=$G(^TMP($J,"HLMREP",SUB,SUB1,SUB2))
 .  .  I STAT'="A" S CTIN=CTIN+1 ; Inactive status counter
 .  .  S STAT=$S(STAT'="A":"* ",1:"  ")
 .  .  S TXT=$$PRT(SUB1,SUB1L,STAT)_$$PRT(SUB2,SUB2L)
 .  .  D ADD(TXT)
 .  .  S CT=CT+1
 .  .  S SUB1L=SUB1,SUB2L=SUB2
 Q
 ;
PRT(P1,P1L,ST) ; Format part of display line...
 ; CT -- req
 N TXT
 S TXT=$S($G(ST)]"":"  ",1:"")_$E($S(P1'=P1L:P1,1:"")_$$REPEAT^XLFSTR("-",35),1,33)_"  "
 Q TXT
 ;
ADD(TXT) ;
 N NO
 S NO=$O(^TMP($J,"HLMREP","REP",":"),-1)+1
 S ^TMP($J,"HLMREP","REP",+NO)=TXT
 Q
 ;
RECIPLD ; Load monitor and recipient data...
 N DATA,IEN7761,MONM,STAT
 S IEN7761=0
 F  S IEN7761=$O(^HLEV(776.1,IEN7761)) Q:IEN7761'>0  D
 .  S DATA=$G(^HLEV(776.1,+IEN7761,0)) QUIT:DATA']""  ;->
 .  S MONM=$$UP^XLFSTR($P(DATA,U)) QUIT:DATA']""  ;->
 .  S STAT=$S($P(DATA,U,2)="A":"ACTIVE",1:"INACTIVE")
 .  D RECIPM(MONM,IEN7761,STAT,60) ; Load mail groups...
 .  D RECIPM(MONM,IEN7761,STAT,61) ; Load local recipients...
 .  D RECIPM(MONM,IEN7761,STAT,62) ; Load remotes...
 Q
 ;
RECIPM(MONM,IEN7761,STAT,SUBDD) ; Load two globals...
 N MIEN,RECIP
 S MIEN=0
 F  S MIEN=$O(^HLEV(776.1,+IEN7761,SUBDD,MIEN)) Q:MIEN'>0  D
 .  S RECIP=$$UP^XLFSTR($P($G(^HLEV(776.1,+IEN7761,+SUBDD,MIEN,0)),U))
 .  QUIT:RECIP']""  ;->
 .  I SUBDD=60 D  QUIT:RECIP']""  ;->
 .  .  S RECIP=$P($G(^XMB(3.8,+RECIP,0)),U) QUIT:RECIP']""  ;->
 .  .  S RECIP="G."_RECIP
 .  I SUBDD=61 D  QUIT:RECIP']""  ;->
 .  .  S RECIP=$P($G(^VA(200,+RECIP,0)),U)
 .  S ^TMP($J,"HLMREP","M",MONM_"[#"_IEN7761_"]",RECIP)=STAT
 .  S ^TMP($J,"HLMREP","R",RECIP,MONM_"[#"_IEN7761_"]")=STAT
 Q
 ;
RECIPO(PMT) ; Mon/Recip or Recip/Mon
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="S^1:List monitors/recipients;2:List recipients/monitors;3:Exit"
 S DIR("A")="Select REPORT FORMAT"
 S DIR("B")=$S(PMT="RECIPMR":"List recipients/monitors",1:"List monitors/recipients")
 D ^DIR
 QUIT:+Y<1!(+Y>2) "" ;->
 Q $P("RECIPMR^RECIPRM",U,+Y)
 ;
EXRECIP N I,T F I=1:1 S T=$T(EXRECIP+I) QUIT:T'[";;"  W !,$P(T,";;",2,99)
 ;;This option lists the monitors and monitor recipients in two formats: sorted
 ;;by monitor and within monitor by recipient.  And, by recipient, and withing
 ;;recipient by monitor.
 QUIT
 ;
CONDMON ; Called by [HLEV REPORT CONDENSED MONITOR]
 N BY,DIC,FLDS,L
 D HD("Short Monitor Report")
 W !
 D EXCMON
 S L="",DIC="^HLEV(776.1,",FLDS="[HLEV REPORT MONITOR-ONE LINE]"
 S BY="[HLEV REPORT MONITOR]"
 D EN1^DIP
 D TELL^HLEVMST0("")
 Q
 ;
EXCMON N I,T F I=1:1 S T=$T(EXCMON+I) QUIT:T'[";;"  W !,$P(T,";;",2,99)
 ;;This option displays monitor information in brief format.  If you wish to see
 ;;more of the information for this monitor, please use the 'Expanded monitor
 ;;report' menu option.
 QUIT
 ;
EXPMON ; Called by [HLEV REPORT EXPANDED MONITOR]
 N BY,DIC,FLDS,L
 D HD("Expanded Monitor Report")
 W !
 D EXPCMON
 S L="",DIC="^HLEV(776.1,",FLDS="[CAPTIONED]"
 S BY="[HLEV REPORT MONITOR - FF]"
 D EN1^DIP
 D TELL^HLEVMST0("")
 Q
 ;
EXPCMON N I,T F I=1:1 S T=$T(EXCPMON+I) QUIT:T'[";;"  W !,$P(T,";;",2,99)
 ;;This option displays monitor information in expanded format.  If you wish to
 ;;see more of the information for this monitor, please use the 'Condensed 
 ;;monitor report' menu option.
 QUIT
 ;
 ;
HD(TXT) W @IOF,$$CJ^XLFSTR(TXT,IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 QUIT
 ;
DETAILS ; Show details of an event monitor occurence...
 ;
 W !!,"Not implemented yet..."
 W !
 S X=$$BTE^HLCSMON("Press RETURN to continue... ")
 ;
 Q
 ;
EOR ;HLEVREP0 - Event Monitor REPORTS ;5/16/03 14:42
