KMPDUTL2 ;OAK/RAK - CM Tools Utility ;6/21/05  10:18
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**4**;Mar 22, 2002
 ;
DATERNG(KMPUY,KMPUSTR,KMPUEND) ;-- date range
 ;---------------------------------------------------------------------
 ; KMPUY..... Value returned in four pieces:
 ;            fmstartdate^fmenddate^ouputstartdate^outputenddate
 ;
 ;            Piece one and two are the date ranges in fileman format.
 ;            Piece three and four are the same dates in output format:
 ;                             dy-Mon-yr
 ;
 ;                               ********
 ;                               * NOTE *
 ;                               ********
 ;          - The first piece will always be the earliest date entered.
 ;
 ;  Optional Parameters:
 ;
 ; KMPUSTR... If defined, the earliest date that may be selected.
 ;            (must be in fileman format)
 ;
 ; KMPUEND... If defined, the latest date that may be selected.
 ;            (must be in fileman format)
 ;-----------------------------------------------------------------------
 ;
 N DATE1,DATE2,DIR,DIRUT,LINE,X,Y
 ;
 S KMPUY="",KMPUSTR=$G(KMPUSTR),KMPUEND=$G(KMPUEND)
 ;
RANGE ;-- Ask date ranges
 S DIR(0)="DOA^"_$S(KMPUSTR:KMPUSTR,1:"")_":"_$S(KMPUEND:KMPUEND,1:"")_":ET)"
 S DIR("A")="Start with Date: "
 S:KMPUSTR DIR("B")=$$FMTE^XLFDT(KMPUSTR,2)
 S DIR("?")=" "
 S DIR("?",1)="Enter the starting date.",LINE=2
 ; if starting date.
 I KMPUSTR D 
 .S DIR("?",LINE)="Date must not precede "_$$FMTE^XLFDT(KMPUSTR)
 .S LINE=LINE+1
 ; if ending date.
 I KMPUEND S DIR("?",LINE)="Date must not follow "_$$FMTE^XLFDT(KMPUEND)
 W ! D ^DIR I $D(DIRUT) S KMPUY="" Q
 S DATE1=Y
 S DIR("A")="  End with Date: "
 S:KMPUEND DIR("B")=$$FMTE^XLFDT(KMPUEND,2)
 S DIR("?",1)="Enter the ending date."
 D ^DIR G:Y="" RANGE I Y="^" S KMPUY="" Q
 S DATE2=Y
 ; Set earliest date into first piece.
 S KMPUY=$S(DATE2<DATE1:DATE2,1:DATE1)_U_$S(DATE2>DATE1:DATE2,1:DATE1)
 S $P(KMPUY,U,3)=$$FMTE^XLFDT($P(KMPUY,U))
 S $P(KMPUY,U,4)=$$FMTE^XLFDT($P(KMPUY,U,2))
 Q
 ;
EMAIL(KMPDSUBJ,KMPDTEXT,KMPDTO) ; check and process errors.
 ;-----------------------------------------------------------------------
 ; KMPDSUBJ... Free text - to be included in subject
 ; KMPDTEXT(). Array containing message text.  This must be in a format
 ;             accepted by XMTEXT - TEXT(
 ;                                  ^TMP($J,"TEXT",
 ; KMPDTO..... Address for email recipient:
 ;              G.KMP2-RUM@FO-ALBANY.MED.VA.GOV
 ;              G.KMP4-CMTOOLS@FO-ALBANY.MED.VA.GOV
 ;              G.CAPACITY,MANAGEMENT@FO-ALBANY.MED.GOV
 ;             If no value is passed the default will be 
 ;              G.KMP4-CMTOOLS@FO-ALBANY.MED.VA.GOV
 ;              
 ;-----------------------------------------------------------------------
 ;
 Q:$G(KMPDTEXT)=""
 S KMPDSUBJ=$S($G(KMPDSUBJ)="":"CM Error",1:KMPDSUBJ)
 S KMPDTO=$S($G(KMPDTO)="":"G.KMP4-CMTOOLS@FO-ALBANY.MED.VA.GOV",1:KMPDTO)
 ;
 N H,I,LN,N,O,SITE,TEXT,TL,XMSUB,X,XMTEXT,XMY,XMZ,Y,Z
 ;
 S TL=$$TESTLAB^KMPDUT1
 S SITE=$$SITE^VASITE
 S XMSUB=KMPDSUBJ_" at site "_$P(TL,U,2)_$P(SITE,U,3)_" on "_$$FMTE^XLFDT($$DT^XLFDT)
 S XMTEXT=KMPDTEXT
 S XMY(KMPDTO)=""
 D ^XMD
 W:'$D(ZTQUEUED) !,"Message #"_$G(XMZ)_" sent..."
 ;
 Q
 ;
STRSTP(KMPDAPP,KMPDDW,KMPDBP,KMPDSTM) ;-- record start/stop times
 ;-----------------------------------------------------------------------
 ; KMPDAPP.... CP application:
 ;              1 - sagg
 ;              2 - rum
 ;              3 - hl7
 ;              4 - timing
 ; KMPDDW..... Daily or Weekly
 ;              1 - daily
 ;              2 - weekly
 ; KMPDBP.... Background or Purge
 ;              1 - background
 ;              2 - purge
 ; KMPDSTM.... Start Time in internal fileman format
 ;
 ; This api will calculate END time and DELTA time (END-KMPDSTM) and
 ; store the results in:
 ;    ^XTMP("KMPD","BACKGROUND",KMPDAPP,KMPDDW,KMPDBP,...)
 ;-----------------------------------------------------------------------
 Q:'$G(KMPDAPP)
 Q:KMPDAPP<1!(KMPDAPP>4)
 Q:'$G(KMPDDW)
 Q:KMPDDW<1!(KMPDDW>2)
 Q:'$G(KMPDBP)
 Q:KMPDBP<1!(KMPDBP>2)
 Q:'$G(KMPDSTM)
 ;
 N END,ERROR,FDA,FIELD S END=$$NOW^XLFDT
 ;
 ; starting field for daily or background
 S FIELD=KMPDAPP+($S(KMPDDW=1:5,1:8)*.01)
 ; if purge
 S:KMPDBP=2 FIELD=FIELD+.07
 ;
 ; store start time, end time, and delta
 S FDA($J,8973,"1,",FIELD)=KMPDSTM
 S FDA($J,8973,"1,",FIELD+.01)=END
 S FDA($J,8973,"1,",FIELD+.02)=$$FMDIFF^XLFDT(END,KMPDSTM,3)
 ;
 D FILE^DIE("","FDA($J)","ERROR")
 ;
 Q
