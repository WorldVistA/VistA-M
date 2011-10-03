HLEVSRV0 ;O-OIFO/LJA - Event Monitor SERVER ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
M(TXT) ; Called when M code data requested in...
 ; MXEC,XTMP -- req
 N MCODE,NO,MTAG,WHEN
 ;
 ; Sets...
 S WHEN=$P(TXT,U)
 ;
 ; Has license been sent?
 I WHEN="LICENSE" D  QUIT  ;->
 .  QUIT:$P(MXEC,U,4)]""  ;->
 .  S MCODE=$P(TXT,U,2)
 .  I '$$OKCODE^HLEVSRV1(MCODE) S $P(MXEC,U,4)=0 QUIT  ;->
 .  S $P(MXEC,U,4)=1 ; Force DOWN...
 ;
 QUIT:WHEN'="BEFORE"&(WHEN'="AFTER")  ;->
 S MTAG=$P(TXT,U,2) QUIT:MTAG']""  ;->
 S MCODE=$P(TXT,U,3,999) Q:MCODE']""  ;->
 ;
 ; Is it valid M code?
 S X=MCODE D ^DIM QUIT:'$D(X)  ;->
 ;
 S NO=$O(^XTMP(XTMP,"M",WHEN,MTAG,":"),-1)+1
 S ^XTMP(XTMP,"M",WHEN,MTAG,+NO)=MCODE
 ;
 Q
 ;
MPRE ; Run M code before load of data...
 ; XTMP -- req
 D MRUN("BEFORE")
 Q
 ;
MPST ; Run M code after load of data...
 ; XTMP -- req
 D MRUN("AFTER")
 Q
 ;
MRUN(WHEN) ; Run M code's INIT...
 ; XTMP -- req
 N ZZADD,ZZCALL,ZZMCODE,ZZMLNO,ZZMTAG,ZZNEXT,ZZNO,ZZREC
 ;
 ; Get starting M code...
 QUIT:$G(^XTMP(XTMP,"M",WHEN,"INIT",1))']""  ;->
 ;
 ; Values set up as a service for the developer sending in M code...
 ;
 ; NEXT LINE - Executable code to execute next line in "subroutine"...
 S ZZNEXT="S ZZMLNO=ZZMLNO+1,ZZMCODE=$G(^XTMP(XTMP,""M"",WHEN,ZZMTAG,ZZMLNO)) QUIT:ZZMCODE']""""  X ZZMCODE,ZZREC"
 S ZZREC="S ZZCALL=$G(ZZCALL)+1,^XTMP(XTMP,""M"",""REC"",WHEN,ZZCALL)=ZZMLNO_U_ZZMTAG"
 S ZZADD="D ADDMTXT^HLEVSRV0($G(ZZTXT))"
 ;
 ; Set up every "subroutine" in an executable call "tag"
 S ZZMCODE=""
 F  S ZZMCODE=$O(^XTMP(XTMP,"M",WHEN,ZZMCODE)) Q:ZZMCODE']""  D
 .  S @ZZMCODE="S ZZMTAG="""_ZZMCODE_""",ZZMLNO=0 X ZZNEXT"
 ;
 S ZZCALL=0
 ;
 ; Start...
 X INIT
 ;
 Q
 ;
MCOND ; Condense M call data...
 N DATA,TAG,TAGL,TAGN,TXT,WHEN,ZZCALL
 ;
 QUIT:'$D(^XTMP(XTMP,"M","REC"))  ;->
 ;
 KILL ^TMP($J,"HLMCOND")
 ;
 F WHEN="BEFORE","AFTER" D
 .  S ZZCALL=0,TXT=WHEN_": ",POSX=$L(TXT),TAGL="",TAGN=0
 .  F  S ZZCALL=$O(^XTMP(XTMP,"M","REC",WHEN,ZZCALL)) Q:ZZCALL'>0  D
 .  .  S DATA=^XTMP(XTMP,"M","REC",WHEN,ZZCALL),TAG=$P(DATA,U,2) QUIT:TAG']""  ;->
 .  .  I $L(TXT)>55 D
 .  .  .  D ADD(TXT)
 .  .  .  S TXT=$$REPEAT^XLFSTR(" ",POSX)
 .  .  I TAGL'=TAG D
 .  .  .  I TAGL]"",TAGN>0 S TXT=TXT_"(#"_TAGN_")",TAGN=0
 .  .  .  S TXT=TXT_$S($L(TXT)>POSX:"-",1:"")_TAG,TAGN=1
 .  .  I TAGL=TAG S TAGN=TAGN+1
 .  .  S TAGL=TAG
 .  I TAGN>0,$L(TXT)>POSX S TXT=TXT_"(#"_TAGN_")",TAGN=0
 .  I $L(TXT)>POSX D ADD(TXT)
 ;
 QUIT:'$D(^TMP($J,"HLMCOND"))  ;->
 ;
 KILL ^XTMP(XTMP,"M","REC")
 MERGE ^XTMP(XTMP,"M","REC")=^TMP($J,"HLMCOND")
 ;
 Q
 ;
MCALLREC ; Store MCOND data in mail message..
 N NO
 ;
 QUIT:'$D(^XTMP(XTMP,"M","REC"))  ;->
 ;
 D ADDMAIL^HLEVSRV(""),ADDMAIL^HLEVSRV("M Call Record")
 D ADDMAIL^HLEVSRV($$REPEAT^XLFSTR("-",74))
 ;
 S NO=0
 F  S NO=$O(^XTMP(XTMP,"M","REC",NO)) Q:NO'>0  D
 .  D ADDMAIL^HLEVSRV(^XTMP(XTMP,"M","REC",NO))
 ;
 Q
 ;
ADDMTXT(TXT) ;
 N NO
 S NO=$O(^XTMP(XTMP,"MTEXT",":"),-1)+1
 S ^XTMP(XTMP,"MTEXT",+NO)=TXT
 Q
 ;
MTEXT ; Add text to Mailman message created by M code...
 N NO
 ;
 I $G(^XTMP(XTMP,"MTEXT")) D
 .  D ADDMAIL("")
 .  D ADDMAIL($$CJ^XLFSTR(" M-Created Text ",74,"-"))
 ;
 S NO=0
 F  S NO=$O(^XTMP(XTMP,"MTEXT",NO)) Q:NO'>0  D
 .  D ADDMAIL(^XTMP(XTMP,"MTEXT",NO))
 ;
 Q
 ;
ADD(TXT) ;
 N NO
 S NO=$O(^TMP($J,"HLMCOND",":"),-1)+1
 S ^TMP($J,"HLMCOND",+NO)=TXT
 Q
 ;
MTEST ; Test M code embedded in a Mailman message...
 N IOINHI,IOINORM,MIEN,X,XTMP
 ;
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 ;
 W @IOF,$$CJ^XLFSTR("M Code Test",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 W !!,"This utility will execute the code in the BEFORE and AFTER sections of the"
 W !,"M code embedded in a Mailman message.  The message must be in the format"
 W !,"used by the [HLEV-INFORMATION-SERVER] menu option."
 ;
MT1 W !
 F  R !,"Message IEN: ",MIEN:60 Q:MIEN'>0  D  QUIT:$G(^XMB(3.9,+MIEN,0))]""
 .  I $G(^XMB(3.9,+MIEN,0))']"" D  QUIT  ;->
 .  .  W "   no message found..."
 .  W "   ",$P(^XMB(3.9,+MIEN,0),U),"..."
 ;
 QUIT:$G(^XMB(3.9,+MIEN,0))']""  ;->
 ;
 S XTMP="HLEV SERVER 9999999",NOW=$$NOW^XLFDT
 KILL ^XTMP(XTMP)
 S ^XTMP(XTMP,0)=$$FMADD^XLFDT(NOW,0,1)_U_NOW_U_"TEST"
 ;
 W !!,"Loading M code..."
 S LNO=0
 F  S LNO=$O(^XMB(3.9,+MIEN,2,LNO)) Q:LNO'>0  D
 .  S TXT=$G(^XMB(3.9,+MIEN,2,+LNO,0)) QUIT:$E(TXT,1,2)'="M^"  ;->
 .  S TXT=$P(TXT,U,2,999) QUIT:TXT']""  ;->
 .  W "."
 .  D M(TXT)
 ;
 I '$D(^XTMP(XTMP,"M")) D  G MT1 ;->
 .  W !!,"No M code embedded in this Mailman message..."
 ;
 W !
 S LP=$NA(^XTMP(XTMP,"M")),ST="^XTMP("""_XTMP_""",""M"","
 F  S LP=$Q(@LP) Q:LP'[ST  D
 .  W !,IOINHI,"...",$P(LP,",""M"",",2,99),IOINORM," = "
 .  S POSX=$X,DATA=@LP
 .  F  QUIT:DATA']""  D
 .  .  W $E(DATA,1,IOM-POSX)
 .  .  S DATA=$E(DATA,IOM-POSX+1,999)
 ;
 W !!,"You can execute the BEFORE load M code, or the AFTER load M code.  The BEFORE"
 W !,"load M code requires a BEFORE^INIT... node(s).  The AFTER load M code"
 W !,"requires an AFTER^INIT... node(s)."
 ;
 I '$D(^XTMP(XTMP,"M","BEFORE"))&('$D(^XTMP(XTMP,"M","AFTER"))) D  G MT1 ;->
 .  W !!,"You must add a BEFORE and/or AFTER section to the M code embedded in the"
 .  W !,"Mailman message before you can use this utility to test."
 ;
 D MEX("BEFORE")
 D MEX("AFTER")
 ;
 KILL ^XTMP(XTMP)
 ;
 W !!,"Done..."
 ;
 Q
 ;
MEX(WHEN) ; Called by MTEST to execute ^XTMP(XTMP,"M") code...
 N X
 QUIT:'$D(^XTMP(XTMP,"M",WHEN))  ;->
 W !!,"Press RETURN to execute the ",IOINHI,WHEN,IOINORM
 W " code, or '^' to skip... "
 R X:60 I '$T!(X[U) W "  no action taken..." QUIT  ;->
 W !,"Executing the ",WHEN," code..."
 I WHEN="BEFORE" D MPRE
 I WHEN="AFTER" D MPST
 W "  M code finished..."
 Q
 ;
UNIT(TXT) ; Load IEN list found by MSG ID... (TXT=MsgID)
 ; XTMP -- req
 ;
 ; Data request line must equal UNIT^#^TYPE  (#^TYPE passed in here)
 ;
 ; TYPE = "IEN772", "IEN773", or "MSGID"
 ;    # = IEN772, IEN773 or MSGID
 ;
 ; The # used to find any IEN772 in the unit.
 ; All messages in unit found using $$LOAD772S^HLUCM009, and
 ; formatted by LOADUNIT and returned in email to user.
 ;
 N CT,HL772,HLID,HLTYPE,IEN772,IEN773,IEN773,NO772S
 ;
 ; Initial sets...
 S HLID=$P($G(TXT),U) QUIT:HLID']""  ;->
 S HLTYPE=$P(TXT,U,2) ; IEN772, IEN773, or MSGID
 S IEN772=""
 ;
 ; Try to get IEN772 from MSGID...
 I HLTYPE="MSGID" D  QUIT:'IEN772  ;->
 .  S IEN772=$O(^HL(772,"C",HLID,":"),-1)
 .  I IEN772 D  QUIT:IEN772'>0  ;->
 .  .  S IEN773=$O(^HLMA("C",HLID,0)) QUIT:IEN773'>0  ;->
 .  .  S IEN772=+$G(^HLMA(+IEN773,0))
 .  S IEN773=$O(^HLMA("C",HLID,":"),-1) QUIT:'IEN773  ;->
 .  S IEN772=+$G(^HLMA(+IEN773,0))
 ;
 ; If passed IEN772...
 I HLTYPE="IEN772" D  QUIT:IEN772'>0  ;->
 .  QUIT:$G(^HL(772,+HLID,0))']""  ;->
 .  S IEN772=+HLID
 ;
 ; If passed IEN773...
 I HLTYPE="IEN773" D  QUIT:IEN772'>0  ;->
 .  S IEN772=+$G(^HLMA(+HLID,0))
 .  QUIT:$G(^HL(772,+IEN772,0))]""  ;-> It's OK
 .  S IEN772=""
 ;
 QUIT:$G(^HL(772,+$G(IEN772),0))']""  ;->
 ;
 ; Load associated entries...
 S NO772S=$$LOAD772S^HLUCM009(+IEN772,.HL772) QUIT:NO772S'>0  ;->
 ;
 ; Load data...
 S IEN772=0
 F  S IEN772=$O(HL772("HLPARENT",IEN772)) Q:IEN772'>0  D
 .  S IEN772C=0
 .  F  S IEN772C=$O(HL772("HLPARENT",IEN772,IEN772C)) Q:IEN772C'>0  D
 .  .  S ^XTMP(XTMP,"HLUNIT",IEN772,IEN772C)=""
 ;
 Q
 ;
LOADUNIT ; Load data found by UNIT above...
 N IEN772C,IEN772P,POSX,TXT
 ;
 QUIT:'$D(^XTMP(XTMP,"HLUNIT"))  ;->
 ;
 D ADDMAIL(""),ADDMAIL($$CJ^XLFSTR(" Msg ID-requested Message Units ",74,"-"))
 ;
 S IEN772P=0
 F  S IEN772P=$O(^XTMP(XTMP,"HLUNIT",IEN772P)) Q:IEN772P'>0  D
 .  S TXT=IEN772P_": ",POSX=$L(TXT)
 .  S IEN772C=0
 .  F  S IEN772C=$O(^XTMP(XTMP,"HLUNIT",IEN772P,IEN772C)) Q:IEN772C'>0  D
 .  .  I ($L(TXT)+$L(IEN772C)+2)>74 D
 .  .  .  D ADDMAIL(TXT)
 .  .  .  S TXT=$$REPEAT^XLFSTR(" ",POSX)
 .  .  S TXT=TXT_$S($L(TXT)>POSX:",",1:"")_IEN772C
 .  I TXT]"" D ADDMAIL(TXT) S TXT=""
 ;
 Q
 ;
ADDMAIL(TXT) D ADDMAIL^HLEVSRV(TXT)
 Q
 ;
QUITQ(LPVAL,STOP,NOLINE,CT) ; Should looping stop?
 QUIT:LPVAL']"" 1 ;->
 QUIT:LPVAL'[STOP 1 ;->
 QUIT:(CT+1)>NOLINE 1 ;->
 Q ""
 ;
QUITS(LPVAL,SCREEN) ; Should this be included?
 N DATA,DIV,MAXNO,OK,PCE,VAL,X
 S DIV=""
 S MAXNO=$L(LPVAL,",") I $L(SCREEN,",")'=MAXNO QUIT 1 ;->
 F PCE=1:1:MAXNO D  QUIT:'OK
 .  S OK=0
 .  S X=$P(SCREEN,"#",PCE),DIV=$S(DIV]"":",",1:$E(X,$L(X)))
 .  S DATA(1)=$P(LPVAL,DIV,+PCE) QUIT:DATA(1)']""  ;->
 .  S DATA(2)=$P(SCREEN,DIV,+PCE) QUIT:DATA(2)']""  ;->
 .  I DATA(2)="#" QUIT:DATA(1)'?1.N  ;->
 .  I DATA(2)'="#" QUIT:DATA(1)'=DATA(2)  ;->
 .  S OK=1
 S OK='OK ; Because this is a QUIT IF extrinsic function
 Q OK
 ;
ADDLINE(TXT) D ADDLINE^HLEVSRV(TXT)
 Q
 ;
EOR ;HLEVSRV0 - Event Monitor SERVER ;5/16/03 14:42
