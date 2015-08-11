RCDPEM7 ;OIFO-BAYPINES/PJH - OVERDUE EFT AND ERA BULLETINS ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**276,298**;Mar 20, 1995;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; Main entry point for overdue EFT/ERA bulletins
 ;
 N TODAY,ERACNT,ERATOT,ERA1CNT,ERA1TOT,EFTCNT,EFTTOT,RCPROG
 ;Clear workfiles
 S RCPROG="RCDPEM7" K ^TMP(RCPROG,$J)
 ;Set counters and totals
 S (EFTCNT,ERACNT,ERA1CNT,EFTTOT,ERATOT,ERA1TOT)=0
 ;Cuttoff of 12:00 am today
 S TODAY=$P($$NOW^XLFDT,".")
 ;
 ;Scan for overdue ERA and unposted ERA
 D ERASCAN
 ;Scan for overdue EFT
 D EFTSCAN
 ;Bulletins
 D BULLETIN
 ;Clear workfiles
 K ^TMP(RCPROG,$J)
 Q
 ;
ERASCAN ;Scan ERA
 N AMT,ERAIEN,REC0,SUB,STATUS,FDATE,PNAME
 ;Scan for unmatched ERA
 S ERAIEN=0,STATUS=0,SUB="ERA"
 F  S ERAIEN=$O(^RCY(344.4,"AMATCH",STATUS,ERAIEN)) Q:'ERAIEN  D
 .S REC0=$G(^RCY(344.4,ERAIEN,0))
 .;Get ERA file date/time
 .S FDATE=$P(REC0,U,7) Q:'FDATE
 .;Ignore if <31 days overdue
 .Q:$$FMDIFF^XLFDT(TODAY,FDATE,1)<31
 .;Trace, Payer Name and Amount
 .S PNAME=$P(REC0,U,6),AMT=$P(REC0,U,5)
 .I $L(PNAME)>35 S PNAME=$E(PNAME,1,35) ; limit size of the name
 .;Update count and totals
 .S ERACNT=ERACNT+1,ERATOT=ERATOT+AMT
 .;Save ERA#, Payer Name, File Date and Amount Paid
 .S ^TMP(RCPROG,$J,"ERA",ERACNT)=$$ERAL(ERAIEN,PNAME,FDATE,AMT)
 ;
 ;Scan for Matched/Unposted ERA
 S SUB="ERA1"
 F STATUS=-1,1,2,3 D
 .S ERAIEN=0 F  S ERAIEN=$O(^RCY(344.4,"AMATCH",STATUS,ERAIEN)) Q:'ERAIEN  D
 ..S REC0=$G(^RCY(344.4,ERAIEN,0))
 ..;Get ERA file date/time
 ..S FDATE=$P(REC0,U,7) Q:'FDATE
 ..;Ignore if <31 days overdue
 ..Q:$$FMDIFF^XLFDT(TODAY,FDATE,1)<31
 ..;Ignore if not unposted posted
 ..Q:$P($G(^RCY(344.4,ERAIEN,0)),U,14)>0
 ..;Payer Name and Amount
 ..S PNAME=$P(REC0,U,6),AMT=$P(REC0,U,5)
 ..I $L(PNAME)>35 S PNAME=$E(PNAME,1,35) ; limit size of the name
 ..;Update count and totals
 ..S ERA1CNT=ERA1CNT+1,ERA1TOT=ERA1TOT+AMT
 ..;Save ERA#, Payer Name, File Date and Amount Paid
 ..S ^TMP(RCPROG,$J,"ERA1",ERA1CNT)=$$ERAL(ERAIEN,PNAME,FDATE,AMT)
 ..Q
 .Q
 Q
 ;
EFTSCAN ;Scan EFT
 N DEPN,EFTIEN,IEN3443,EFTDATE,TRACE,REC0,REC31,STATUS,PAYER,DEPAMT
 ;Scan for unmatched EFT
 S EFTIEN=0,STATUS=0
 F  S EFTIEN=$O(^RCY(344.31,"AMATCH",STATUS,EFTIEN)) Q:'EFTIEN  D
 .S REC31=$G(^RCY(344.31,EFTIEN,0))
 .;Get pointer to EFT file
 .S IEN3443=$P(REC31,U) Q:'IEN3443
 .S REC0=$G(^RCY(344.3,IEN3443,0))
 .;Get EFT file date
 .S EFTDATE=$P(REC0,U,2) Q:'EFTDATE
 .;Ignore if <15 days overdue
 .Q:$$FMDIFF^XLFDT(TODAY,EFTDATE,1)<15
 .;Deposit number and payment amount
 .S DEPN=$P(REC0,U,6),DEPAMT=$P(REC31,U,7)
 .;Payer ID and Trace from EFT detail file
 .S PAYER=$P(REC31,U,2),TRACE=$P(REC31,U,4) S:PAYER="" PAYER="NO PAYER NAME RECEIVED" ; PRCA*4.5*298
 .;If payer and trace combined are >40 truncate payer name first
 .I $L(PAYER_TRACE)>40 D
 ..I $L(PAYER)>20 S PAYER=$E(PAYER,1,20) ; limit size of the name
 ..Q:$L(PAYER_TRACE)<41
 ..S TRACE=$E(TRACE,1,20) ; limit size of the trace
 .;Update count and totals
 .S EFTCNT=EFTCNT+1,EFTTOT=EFTTOT+DEPAMT
 .;Save Deposit No, Receipt, Payer ID, EFT Date and Deposit Amount
 .S ^TMP(RCPROG,$J,"EFT",EFTCNT)=$$EFTL(DEPN,TRACE,PAYER,EFTDATE,DEPAMT)
 Q
 ;
BULLETIN ;Create bulletins only if overdue EFT/ERA found
 ;
 N ARRAY,SBJ,SUB,CNT,CNT1,RCPROG1,GLB
 S RCPROG1="RCDPEM7A",GLB=$NA(^TMP(RCPROG1,$J,"XMTEXT"))
 ;
 ;Unmatched ERA bulletins
 I ERACNT D
 .;Build header
 .S SUB="ERA" K @GLB
 .S SBJ="EDI LBOX-STA# "_$P($$SITE^VASITE,"^",3)_"-ACTION REQ-Unmatched ERAs > 30 days"
 .S @GLB@(1)="The listed ERAs were received more than 30 days ago and have not yet been"
 .S @GLB@(2)="matched."
 .S @GLB@(3)=" "
 .S @GLB@(4)="Total # of ERAs - "_ERACNT
 .S @GLB@(5)="Total Dollar Amount - "_"$"_$FN(ERATOT,",",2)
 .S @GLB@(6)=" "
 .S @GLB@(7)="ERA#        PAYER NAME                                FILE DATE    AMOUNT PAID"
 .;
 .;Move unmatched ERA search findings into message
 .S CNT=0,CNT1=8,SUB="ERA"
 .F  S CNT=$O(^TMP(RCPROG,$J,SUB,CNT)) Q:'CNT  D
 ..S CNT1=CNT1+1,@GLB@(CNT1)=^TMP(RCPROG,$J,SUB,CNT)
 .S @GLB@(CNT1+1)="** END OF REPORT **"
 .D SEND
 .K @GLB
 ;
 ;Unposted ERA bulletins
 I ERA1CNT D
 .;Build header
 .S SUB="ERA1" K @GLB
 .S SBJ="EDI LBOX-STA# "_$P($$SITE^VASITE,"^",3)_"-ACTION REQ-Matched/Not Posted ERAs > 30 days"
 .S @GLB@(1)="The listed ERAs were received more than 30 days ago and have been matched but"
 .S @GLB@(2)="have not been posted"
 .S @GLB@(3)=" "
 .S @GLB@(4)="Total # of ERAs - "_ERA1CNT
 .S @GLB@(5)="Total Dollar Amount - "_"$"_$FN(ERA1TOT,",",2)
 .S @GLB@(6)=" "
 .S @GLB@(7)="ERA#        PAYER NAME                                FILE DATE    AMOUNT PAID"
 .;
 .;Move unposted ERA search findings into message
 .S CNT=0,CNT1=8
 .F  S CNT=$O(^TMP(RCPROG,$J,SUB,CNT)) Q:'CNT  D
 ..S CNT1=CNT1+1,@GLB@(CNT1)=^TMP(RCPROG,$J,SUB,CNT)
 .S @GLB@(CNT1+1)="** END OF REPORT **"
 .D SEND
 .K @GLB
 ;
 ;Unmatched EFT bulletins
 I EFTCNT D
 .;Build header
 .S SUB="EFT" K @GLB
 .S SBJ="EDI LBOX-STA# "_$P($$SITE^VASITE,"^",3)_"-ACTION REQ-EFTs > 14 days"
 .S @GLB@(1)="The following EFTs were received more than 14 days ago and have not yet"
 .S @GLB@(2)="been matched."
 .S @GLB@(3)=" "
 .S @GLB@(4)="Total # of EFTs - "_EFTCNT
 .S @GLB@(5)="Total Dollar Amount - "_"$"_$FN(EFTTOT,",",2)
 .S @GLB@(6)=" "
 .S @GLB@(7)="DEPOSIT#   PAYER NAME/TRACE#                         EFT DATE    DEPOSIT AMT"
 .;
 .;Move EFT search findings into message
 .S CNT=0,CNT1=8,SUB="EFT"
 .F  S CNT=$O(^TMP(RCPROG,$J,SUB,CNT)) Q:'CNT  D
 ..S CNT1=CNT1+1,@GLB@(CNT1)=^TMP(RCPROG,$J,SUB,CNT)
 .S @GLB@(CNT1+1)="** END OF REPORT **"
 .D SEND
 .K @GLB
 Q
 ;
SEND ;Transmit mail message
 N XMDUZ,XMTEXT,XMSUB,XMY,XMINSTR
 S XMDUZ=DUZ,XMTEXT=GLB,XMSUB=SBJ,XMY("I:G.RCDPE AUDIT")=""
 S XMINSTR("FROM")="POSTMASTER"
 S XMINSTR("FLAGS")="P"
 D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY,.XMINSTR)
 Q
 ;
ERAL(X1,X2,X3,X4) ;Format ERA Message line
 N SPACE
 S SPACE=$J("",80)
 S X1=X1_$E(SPACE,1,12-$L(X1))
 S X2=X1_$E(X2,1,43)_$E(SPACE,1,43-$L(X2))
 S X3=$$FMTE^XLFDT(X3,"2D")
 S X4="$"_$FN(X4,",",2)
 Q X2_$J(X3,8)_$J(X4,15)
 ;
EFTL(X1,X2,X3,X4,X5) ;Format EFT Message line
 N SPACE
 S SPACE=$J("",80)
 S X1=X1_$E(SPACE,1,10-$L(X1))_" "
 S X2=X3_"/"_X2 ;Payer and Trace
 S X2=X1_$E(X2,1,41)_$E(SPACE,1,42-$L(X2))
 S X4=$$FMTE^XLFDT(X4,"2D")
 S X5="$"_$FN(X5,",",2)
 Q X2_$J(X4,8)_$J(X5,15)
