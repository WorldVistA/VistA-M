EDPCDBG ;SLC/KCM - Debugging for Controller ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
DEBUG(SWFID) ; return TRUE if debugging
 N CTS,DTS,DIF
 S CTS=$H,DTS=$$GET^XPAR("SYS","EDPF DEBUG START TIME",1,"I")
 Q:'DTS 0                           ;no debug param
 Q:($P(CTS,",")'=$P(DTS,",")) 0     ;not the same day
 S DIF=$P(CTS,",",2)-$P(DTS,",",2)
 I DIF<0 Q 0                        ;future debug time
 I DIF<1800 Q $$NEXTSEQ(SWFID)      ;TRUE, within 30 minutes of start
 Q 0
 ;
NEXTSEQ(LOGID) ; return sequence for this session as EDPF-DEBUG-LOG-swfid^sequence
 S:'$L(LOGID) LOGID="init"
 I '$D(^XTMP("EDP-DEBUG-LOG",0)) S ^XTMP("EDP-DEBUG-LOG",0)=$$FMADD^XLFDT(DT,1)_U_DT_U_"ED debug log"
 L +^XTMP("EDP-DEBUG-LOG",LOGID,"SEQ"):2 E  Q 0
 S ^XTMP("EDP-DEBUG-LOG",LOGID,"SEQ")=+$G(^XTMP("EDP-DEBUG-LOG",LOGID,"SEQ"))+1
 L -^XTMP("EDP-DEBUG-LOG",LOGID,"SEQ")
 Q ^XTMP("EDP-DEBUG-LOG",LOGID,"SEQ")_U_LOGID
 ;
PUTREQ(SEQ,REQ) ; save the request at this sequence number
 M ^XTMP("EDP-DEBUG-LOG",$P(SEQ,U,2),+SEQ,"REQ")=REQ
 Q
PUTXML(SEQ,XML) ; save the XML result at this sequence number
 M ^XTMP("EDP-DEBUG-LOG",$P(SEQ,U,2),+SEQ,"XML")=XML
 Q
 ;
SETON ; turn on debugging for EDIS
 N DIR,X,Y
 W !,"Enable EDIS Debugging Log"
 W !,"Logging will occur for 30 minutes after start time."
 W !,"Log is stored in ^XTMP(""EDP-DEBUG-LOG"")",!
 S DIR(0)="DO^::EFR"
 S DIR("A")="Logging Start Time"
 S DIR("B")="NOW"
 D ^DIR
 Q:'Y
 K ^XTMP("EDP-DEBUG-LOG")
 D EN^XPAR("SYS","EDPF DEBUG START TIME",1,$$FMTH^XLFDT(Y))
 Q
SETOFF ; turn off debugging for EDIS
 W !,"EDIS Debugging Log Stopped"
 D DEL^XPAR("SYS","EDPF DEBUG START TIME",1)
 Q
