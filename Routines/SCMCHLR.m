SCMCHLR ;BP/DJB - PCMM HL7 Re-transmit Rejects ; 8/25/99 2:29pm
 ;;5.3;Scheduling;**177**;May 01, 1999
 ;
EN ;
 NEW DFN,SCDELETE,SCMSG,VARPTR
TOP ;
 D GETMSG ;............Get SCMSG() array for Austin Mailman message.
 G:'SCMSG("IEN") EXIT ;Quit if no message selected.
 D ARRAY ;.............Build array of message text
 D PARSE G:'DFN EXIT ;.Get DFN, VARPTR, and SCDELETE
 G:'$$ASK() TOP ;......Are they sure they want to re-transmit?
 D RETRAN ;............Re-transmit selected items.
EXIT ;
 KILL ^TMP("REJECTS",$J)
 Q
 ;
GETMSG ;Prompt for reject message number.
 ;Output:
 ;  SCMSG("IEN")  - Message IEN
 ;                  Return SCMSG("IEN")=0 if no msg selected.
 ;  SCMSG("SUBJ") - Message subject
 ;  SCMSG("FROM") - Message sender
 ;
 NEW %,%DT,ANS,DATA,HD,LINE,X,Y
 ;
 S $P(LINE,"-",IOM)=""
 S HD="RE-TRANSMIT PCMM HL7 MESSAGES"
 W @IOF,!?(IOM-$L(HD)\2),HD
 W !,LINE
 W !!,"Select an Austin HL7 rejection Mailman message."
GETMSG1 KILL SCMSG
 S SCMSG("IEN")=0
 W !!,"Enter MESSAGE NUMBER: "
 R ANS:300 S:'$T ANS="^" I "^"[ANS Q
 I ANS=" " D  G:'ANS GETMSG1
 . S ANS=$G(^DISV(DUZ,"PCMM REJECTS"))
 . W ANS
 S DATA=$$NET^XMRENT(ANS)
 I DATA="" D  G GETMSG1
 . W !,"Enter a valid Mailman message number or <RET> to Quit."
 ;
 ;Check if this is a valid reject message.
 S SCMSG("FROM")=$P(DATA,"^",3)
 I SCMSG("FROM")'="Austin" D GETMSG2 G GETMSG1
 S SCMSG("SUBJ")=$P(DATA,"^",6)
 I SCMSG("SUBJ")'?.E D GETMSG2 G GETMSG1
 S SCMSG("IEN")=ANS
 ;
 ;Support for <SPACE BAR><RET> convention
 S ^DISV(DUZ,"PCMM REJECTS")=ANS
 Q
GETMSG2 ;
 W !,"Sorry, not a valid PCMM HL7 reject message number."
 Q
 ;
ARRAY ;Build array of message text.
 NEW CNT,X,XMER,XMPOS,XMRG,XMZ
 ;
 KILL ^TMP("REJECTS",$J)
 S CNT=1
 S XMZ=SCMSG("IEN")
 F  S X=$$READ^XMGAPI1() Q:XMER=-1  D  ;
 . S ^TMP("REJECTS",$J,CNT)=X
 . S CNT=CNT+1
 Q
 ;
PARSE ;Parse out DFN and VARPTR from text of message
 ;Return: DFN    - Patient IEN
 ;        VARPTR - Variable pointer
 ;
 NEW ID,IDLONG,LN,PTPI
 ;
 S LN=$G(^TMP("REJECTS",$J,1))
 S DFN=+LN ;................................Patient IEN
 I 'DFN D  Q
 . W !,"Cannot identify patient. Aborting."
 S LN=$G(^TMP("REJECTS",$J,2))
 S ID=$P(LN," ",1) ;........................Get ID
 S ID=$P(ID,"-",2) ;........................Strip off facility number
 I 'ID D  Q
 . S DFN=0
 . W !,"Cannot identify event ID. Aborting."
 S IDLONG=$P($G(^SCPT(404.49,ID,0)),U,1) ;..Get long form of ID
 S PTPI=$P(IDLONG,"-",1) ;..................File 404.43 IEN
 I 'PTPI D  Q
 . S DFN=0
 . W !,"Cannot identify long ID. Aborting."
 I '$D(^SCPT(404.43,PTPI)) S SCDELETE=1 ;...Flag to process a delete
 S VARPTR=PTPI_";SCPT(404.43," ;............Create event pointer
 Q
 ;
ASK() ;Ask if they want to re-tranmit selected msgs.
 NEW %,%Y
 W !!,"Patient: ",$P($G(^DPT(DFN,0)),U,1)
ASK1 W !!,"Are you sure you want to re-transmit"
 S %=1 D YN^DICN
 I %=0 W " Enter YES or NO" G ASK1
 I %'=1 Q 0
 Q 1
 ;
RETRAN ;Re-transmit selected items.
 ;
 NEW PT,PTPI,RESULT,SCFAC,XMITARRY
 NEW HL,HLECH,HLEID,HLFS,HLQ
 ;
 ;Initialize array
 S XMITARRY="^TMP(""PCMM"",""HL7"","_$J_")" ;..Segments
 KILL @XMITARRY
 ;
 ;Get faciltiy number
 S SCFAC=+$P($$SITE^VASITE(),"^",3)
 ;
 ;Get pointer to sending event
 S HLEID=$$HLEID^SCMCHL()
 I 'HLEID D  Q
 . W "Unable to initialize HL7 variables - protocol not found"
 ;
 ;Initialize HL7 variables
 D INIT^HLFNC2(HLEID,.HL)
 I $O(HL(""))="" W $P(HL,"^",2) Q
 ;
 ;Build segment array
 I $G(SCDELETE) D  I 1 ;....................Process a deletion
 . S PTPI=$P(VARPTR,";",1)
 . D PTPD^SCMCHLB2(PTPI)
 E  D  I +RESULT<0 W $P(RESULT,"^",2) Q  ;..Process a normal entry
 . S RESULT=$$BUILD^SCMCHLB(VARPTR,.HL,.XMITARRY)
 ;
 ;Generate message
 ;S RESULT=$$GENERATE^SCMCHLG()
 ;
 KILL @XMITARRY
 W !!,"Message re-transmitted...",!
 Q
