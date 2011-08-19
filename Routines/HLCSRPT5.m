HLCSRPT5 ;OIFO-O/LJA - Error Listing code ;3/18/02 10:19
 ;;1.6;HEALTH LEVEL SEVEN;**85**;Oct 13, 1995
 ;
ERRRPT ; Format a report line (Moved here by HL*1.6*85 from HLCSRPT2)
 N PROCDT ;HL*1.6*85
 S HLCSY=""
 S HLCSRNO=HLCSJ,SPACE20="                    "
 I VERS22'="" D
 .S HLCSRNO="$.%$CREF$^TMP($J,""MESSAGE"","_HLCSRNO_")$CREF$^"_HLCSRNO_"$.%"
 .S Y=$L(HLCSJ),X=$E(SPACE20,1,13-Y) S HLCSRNO=HLCSRNO_X K X,Y ;HL*1.6*85
 E  S HLCSRNO=HLCSRNO_SPACE20 S HLCSRNO=$E(HLCSRNO,1,13) ;HL*1.6*85
 S HLCSY=HLCSRNO_" "
 ;
 ; Major HL*1.6*85 modifications begin here (to print date/time)
 ; Just add Processed Date/Time to message ID field cow bird fashion
 S HLCSMX=$P(HLCSX,U,2)
 N PROCDT
 S PROCDT=$$PROCDT(+HLCSJ)
 S PROCDT=$$DTORTM(ERRDTB,ERRDTE,PROCDT)
 S PROCDT=$S(PROCDT]"":PROCDT,1:" ") ; Can't be null!! (subscript error)
 I $L(HLCSMX)<17 D
 .  S HLCSMX=$E(HLCSMX_SPACE20,1,16)_" "_PROCDT
 S HLCSMID=HLCSMX_SPACE25 S HLCSMID=$E(HLCSMID,1,25)_" "
 ;End HL*1.6*85 modifications
 ;
 S HLCSPTR=$P(^HLMA(HLCSJ,0),"^",1)
 S HLCSY=HLCSY_HLCSMID_" "
 S HLCSY=HLCSY_$E(HLCSLNK_SPACE20,1,10)_" "
 S HLCSY=HLCSY_HLCSEVN_" "
 S HLCSTYP=$P(HLCSX,U,3) S:HLCSTYP="O" HLCSTYP="OT" S:HLCSTYP="I" HLCSTYP="IN"
 S HLCSY=HLCSY_$E(HLCSTYP_SPACE20,1,2)_" "
 S HLCSSRVR=$P(HLCSX,U,11) I HLCSSRVR'="",($D(^HL(771,HLCSSRVR,0))) S HLCSSRVR=$P(^HL(771,HLCSSRVR,0),U,1)
 S HLCSY=HLCSY_$E(HLCSSRVR_SPACE20,1,8)_" "
 S HLCSCLNT=$P(HLCSX,U,12) I HLCSCLNT'="",($D(^HL(771,HLCSCLNT,0))) S HLCSCLNT=$P(^HL(771,HLCSCLNT,0),U,1)
 S HLCSY=HLCSY_$E(HLCSCLNT_SPACE20,1,8)
 S HLCSER1=HLCSER1_SPACE80,HLCSER1=$E(HLCSER1,1,39)_" "
 S HLCSERMS=HLCSERMS_SPACE80,HLCSERMS=$E(HLCSERMS,1,39)
 S HLCSLN=HLCSLN+1
 I VERS22="" S HLCSY=HLCSY_" "_HLCSER1_HLCSERMS
 D INFO ;HL*1.6*85
 S ^TMP("TMPLOG",$J,PROCDT,+HLCSJ)=HLCSY
 I VERS22'="" S ^TMP($J,"MESSAGE",HLCSJ)="$XC$^D VERS22^HLCSRPT2("_HLCSJ_","_HLCSPTR_")$XC$^MESSAGE"
 Q
 ;
PROCDT(IEN773) ; Return 773'S processing date (1st), or if not available
 ; return the 772 creation date/time. ;HL*1.6*85
 N PROCDT
 S PROCDT=$P($G(^HLMA(+IEN773,"S")),U) QUIT:PROCDT?7N.E PROCDT ;->
 QUIT $P($G(^HL(772,+$G(^HLMA(+IEN773,0)),0)),U)
 ;
DTORTM(DTB,DTE,PDT) ; Show date or time?
 QUIT $S($E(DTB,1,7)=$E(DTE,1,7):$$TM(PDT),1:$$DT(PDT))
 ;
TM(PDT) ; Show the 5 character hh:mm time
 QUIT $E($P($$FMTE^XLFDT(+PDT),"@",2),1,5)
 ;
DT(PDT) ; Show the 8 character mm/dd/yy date
 QUIT $E(PDT,4,5)_"/"_$E(PDT,6,7)_"/"_$E(PDT,2,3)
 ;
INFO ; If TYPEINFO=Error Type, reset HLCSY. (Called from ERRRPT^HLCSRPT4) - HL*1.6*85
 ; HLCSJ,HLCSRNO -- req
 N DATA,ET,ETYPE,I7717
 QUIT:TYPEINFO'=2  ;->
 S DATA=$P(HLCSY,HLCSRNO_" ",2,99) QUIT:DATA']""  ;->
 S I7717=$P($G(^HLMA(+HLCSJ,"P")),U,4)
 S ETYPE=$P($G(^HL(771.7,+I7717,0)),U)
 I ETYPE="Duplicate Message" D
 .  S ET=$P(^HLMA(+HLCSJ,"P"),U,3) ; Free text
 .  QUIT:ET'["Duplicate with ien"  ;->
 .  S ET=$P(ET,"Duplicate with ien ",2) QUIT:ET'?1.N  ;->
 .  S ETYPE="Duplicate w/# "_ET
 I ETYPE="Incorrect Message Received" D
 .  S ET=$P(^HLMA(+HLCSJ,"P"),U,3) ; Free text
 .  QUIT:ET'["Incorrect msg. Id"  ;->
 .  S ETYPE="Incorrect message ID"
 S $E(DATA,39,999)=$E(ETYPE_SPACE80,1,41)
 S HLCSY=HLCSRNO_" "_DATA
 QUIT
 ;
MSGEVN(IEN773,PCE) ; Return MSG~EVN piece (PCE)...
 N DEL,MSGEVN,MSH
 S MSH=$G(^HLMA(+IEN773,"MSH",1,0)) QUIT:MSH']"" "   " ;->
 S DEL=$E(MSH,4) QUIT:DEL']"" "   " ;->
 S MSGEVN=$P(MSH,DEL,9) QUIT:MSGEVN'?1.E1"~"1.E "   " ;->
 QUIT $P(MSGEVN,"~",+PCE)
 ;
EOR ;HLCSRPT5 - Error Listing code ;3/18/02 10:19
