IBCNHHLI ;ALB/ZEB - HL7 Receiver for NIF transmissions ;25-FEB-14
 ;;2.0;INTEGRATED BILLING;**519**;21-MAR-94;Build 56
 ;;Per VA Directive 6402, this routine should not be modified.
 ;**Program Description**
 ;  This program will process incoming NIF response messages.
 ; Call at tags only
 Q
RCV ; assumes the following from HL7: HLERR,HLNODE,HLQUIT,HLNEXT,HL,HLMTIENS
 Q:+$P($G(^IBE(350.9,1,70)),U,1)'=1  ;abort if secret HL7 flag isn't set
 N MSGID,INSIDS,INSQLS,RTY,PSTAT,RID,RDATA,TID
 N IDCNT,IDTMP,ID,IDS,TYPE,PC,UPDDT
 N HLFS,HLCS,HLRS,ACK,SEG
 K HLERR  ;make sure HL7 error flag isn't set
 S HLFS=HL("FS")
 S HLCS=$E(HL("ECH"),1)
 S HLRS=$E(HL("ECH"),2)
 N DIC,%,%H,%I D NOW^%DTC S UPDDT=%
 S INSIDS="",INSQLS="",RDATA=""
 S RTY="U",RID="",TID="",PSTAT="R"  ;default values if we manage to not get an MSA or QAK
 ;process HL7 segments, build arguments to filing routines
 F  X HLNEXT Q:HLQUIT'>0  D
 . S SEG=$S($E(HLNODE,1)=$C(10):$E(HLNODE,2,4),1:$E(HLNODE,1,3))  ;deal with messages with CRLF (why?!)
 . I SEG="MSA" D  I 1
 . . S MSGID=$P(HLNODE,HLFS,3)
 . . I MSGID]"" D
 . . . S RTY="R"
 . . . S RID=$O(^IBCNH(367,"B",MSGID,""))
 . . . S:RID="" RID=$O(^IBCNH(367,"B",$E(MSGID,$L($P($$SITE^VASITE(),U,3))+1,$L(MSGID)),""))
 . . . S TID=$S(RID="":"",1:$P($G(^IBCNH(367,RID,0)),U,2))
 . . S ACK=$P(HLNODE,HLFS,2),PSTAT=$S(ACK="AE":"X",ACK="AR":"EXR",1:"R")
 . I SEG="QAK" D  I 1
 . . I $P($P(HLNODE,HLFS,4),HLCS,1)="ZHPID02" S RTY="U",RID="",TID=""  ;set this on top of set from MSA
 . E  I SEG="IN1" D
 . . S $P(RDATA,U,4)=$P(HLNODE,HLFS,5)
 . . S IDS=$P(HLNODE,HLFS,4)
 . . F IDCNT=1:1 S IDTMP=$P(IDS,HLRS,IDCNT) Q:IDTMP=""  D
 . . . S ID=$P(IDTMP,HLCS,1)
 . . . S TYPE=$P(IDTMP,HLCS,5)
 . . . I TYPE="INS" S $P(RDATA,U,7)=ID,$P(INSIDS,U,10)=ID Q
 . . . I TYPE="NIF" S $P(INSIDS,U,8)=ID Q
 . . . I TYPE="HPIDC" S $P(RDATA,U,9)="C",$P(INSIDS,U,9)=ID Q
 . . . I TYPE="HPIDS" S $P(RDATA,U,9)="S",$P(INSIDS,U,9)=ID Q
 . . . I TYPE="OEID" S $P(RDATA,U,9)="@",$P(INSIDS,U,9)=ID,$P(RDATA,U,8)="@" Q
 . . . I TYPE="VA" S $P(INSIDS,U,7)=ID Q
 . . . I TYPE="PROF" S $P(INSIDS,U,1)=ID Q
 . . . I TYPE="INST" S $P(INSIDS,U,2)=ID Q
 . . . I TYPE="PARNT" S $P(RDATA,U,8)=ID Q
 . . . I "^2UP^FYP^NFP^TJP^"[(U_TYPE_U) S PC=$S($P(INSIDS,U,3)]"":4,1:3),$P(INSIDS,U,PC)=ID,$P(INSQLS,U,PC)=$E(TYPE,1,2) Q
 . . . I "^2UI^FYI^NFI^TJI^"[(U_TYPE_U) S PC=$S($P(INSIDS,U,5)]"":6,1:5),$P(INSIDS,U,PC)=ID,$P(INSQLS,U,PC)=$E(TYPE,1,2) Q
 I (PSTAT="R")&($P(INSIDS,U,9)="") S $P(INSIDS,U,9)="@",$P(RDATA,U,8)="@",$P(RDATA,U,9)="@"  ;delete existing HPID/OEID if we get an update without one
 S $P(RDATA,U,1)=HLMTIENS  ;don't overwrite sets from optional IN1
 S $P(RDATA,U,2)=TID
 S $P(RDATA,U,3)=RTY
 S $P(RDATA,U,5)=PSTAT
 S $P(RDATA,U,6)=UPDDT
 ;file the response and the data from it
 ;this routine will perform the check to see if we need to file this message
 S %=$$FM367^IBCNHUT2(RID,RDATA,INSIDS,INSQLS)
 Q
