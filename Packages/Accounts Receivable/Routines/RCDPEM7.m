RCDPEM7 ;OIFO-BAYPINES/PJH - OVERDUE EFT AND ERA BULLETINS ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**276,298,303,304**;Mar 20, 1995;Build 104
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; Main entry point for overdue EFT/ERA bulletins
 ;
 N TODAY,ERACNT,ERATOT,ERA1CNT,ERA2CNT,ERA1TOT,ERA2TOT,EFTCNT,EFTTOT,RCPROG,RCSUSCNT,RCSUSAMT,RCMXDYS
 ;Clear workfiles
 S RCPROG="RCDPEM7" K ^TMP(RCPROG,$J)
 ;Set counters and totals
 S (EFTCNT,ERACNT,ERA1CNT,ERA2CNT,EFTTOT,ERATOT,ERA1TOT,ERA2TOT,RCSUSCNT,RCSUSAMT)=0
 ;Cuttoff of 12:00 am today
 S TODAY=$P($$NOW^XLFDT,".")
 ;
 ;Retrieve the max days allowed in suspense parameter
 S RCMXDYS=$$GET1^DIQ(342,"1,",7.04)
 ;
 ;Scan for overdue ERA and unposted ERA
 D ERASCAN
 ;Scan for overdue EFT
 D EFTSCAN
 ;Scan for overdue Suspended ERA's - PRCA*4.5*304
 D SUSPSCAN
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
 . ; PRCA*4.5*303 added the FDATE subscript to the global so that the line
 . ; items collate in date ascending order.
 . ;Save ERA#, Payer Name, File Date and Amount Paid
 .S ^TMP(RCPROG,$J,"ERA",FDATE,ERACNT)=$$ERAL(ERAIEN,PNAME,FDATE,AMT)
 ;
 ;Scan for Matched/Unposted ERA
 S SUB="ERA1"
 F STATUS=-1,1,2,3 D
 . S ERAIEN=0 F  S ERAIEN=$O(^RCY(344.4,"AMATCH",STATUS,ERAIEN)) Q:'ERAIEN  D
 .. S REC0=$G(^RCY(344.4,ERAIEN,0))
 .. ;Get ERA file date/time
 .. S FDATE=$P(REC0,U,7) Q:'FDATE
 .. ;Ignore if <31 days overdue
 .. Q:$$FMDIFF^XLFDT(TODAY,FDATE,1)<31
 .. ;Ignore if not unposted posted
 .. Q:$P($G(^RCY(344.4,ERAIEN,0)),U,14)>0
 .. ;Payer Name and Amount
 .. S PNAME=$P(REC0,U,6),AMT=$P(REC0,U,5)
 .. I $L(PNAME)>35 S PNAME=$E(PNAME,1,35) ; limit size of the name
 .. ; PRCA*4.5*303 Split into "ACH" and not "ACH"
 .. ;Update count and totals
 .. S:$P(REC0,U,15)="ACH" ERA1CNT=ERA1CNT+1,ERA1TOT=ERA1TOT+AMT
 .. S:$P(REC0,U,15)'="ACH" ERA2CNT=ERA2CNT+1,ERA2TOT=ERA2TOT+AMT
 .. ;PRCA*4.5*303 added the FDATE subscript to the global so that the line
 .. ;items collate in date ascending order.
 .. ;Save ERA#, Payer Name, File Date and Amount Paid
 .. S:$P(REC0,U,15)="ACH" ^TMP(RCPROG,$J,"ERA1",FDATE,ERA1CNT)=$$ERAL(ERAIEN,PNAME,FDATE,AMT)
 .. S:$P(REC0,U,15)'="ACH" ^TMP(RCPROG,$J,"ERA2",FDATE,ERA2CNT)=$$ERAL(ERAIEN,PNAME,FDATE,AMT)
 .. Q
 . Q
 Q
 ;
EFTSCAN ;Scan EFT
 N DEPN,EFTIEN,IEN3443,EFTDATE,TRACE,REC0,REC31,REC4,STATUS,PAYER,DEPAMT
 ;Scan for unmatched EFT
 S EFTIEN=0,STATUS=0
 ; PRCA*4.5*303 Check all statuses report on unmatched EFTs, Matched EFTs with unposted ERAs
 ; 4-7-2016 Removed F STATUS=-1,0,1 per issue identifying duplicate EFTs this will need to be
 ; addressed in another project
 S STATUS=0 F  S EFTIEN=$O(^RCY(344.31,"AMATCH",STATUS,EFTIEN)) Q:'EFTIEN  D
 .S REC31=$G(^RCY(344.31,EFTIEN,0))
 .;PRCA*4.5*303 Get zero node of the associated ERA if matched
 .S REC4=$S($P(REC31,U,10)'="":$G(^RCY(344.4,$P(REC31,U,10),0)),1:"")
 .;Get pointer to EFT file
 .S IEN3443=$P(REC31,U) Q:'IEN3443
 .S REC0=$G(^RCY(344.3,IEN3443,0))
 .;Get EFT file date
 .S EFTDATE=$P(REC0,U,2) Q:'EFTDATE
 .;Ignore if <15 days overdue
 .Q:$$FMDIFF^XLFDT(TODAY,EFTDATE,1)<15
 .;PRCA*4.5*303 - if we have a ERA check to see if we include this record or quit
 .I REC4'="" Q:$P(REC4,U,14)'=0  ; Not posted status is 0 - everything else is ignored
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
 .; PRCA*4.5*303 added EFTDATE to the subscripts before EFTCNT so report will sort in
 .; date ascending order.
 .;Save Deposit No, Receipt, Payer ID, EFT Date and Deposit Amount
 .S ^TMP(RCPROG,$J,"EFT",EFTDATE,EFTCNT)=$$EFTL(DEPN,TRACE,PAYER,EFTDATE,DEPAMT)
 Q
 ;
 ; PRCA*4.5*304
 ; Scan for ERA's older than allowed by parameter
SUSPSCAN ;
 N RCCT,RCDATA,RCSDATE,RCDATA0,RCDATA2,RCDATA3,RCMAXDAY,RCRECTDA,RCTRANDA
 N RCDEP,RCTRACE,RCPAYER,RCEFTDT,RCDEPAMT,RCDAYS,RCUSER,RCREC,RCDISP,RCRSN,RCSREC
 ;
 ;initialize counters
 S (RCSUSAMT,RCSUSCNT)=0
 ;
 ;calculate the last date to stop gathering entries on
 S RCMAXDAY=TODAY-RCMXDYS
 ;
 ;Loop through the In Suspense index
 S (RCRECTDA,RCCT)=0
 F  S RCRECTDA=$O(^RCY(344,"AN",RCRECTDA)) Q:'RCRECTDA  D
 . S RCDATA=$G(^RCY(344,RCRECTDA,0))
 . S RCREC=$P(RCDATA,U)
 . S RCTRANDA=0 F  S RCTRANDA=$O(^RCY(344,"AN",RCRECTDA,RCTRANDA)) Q:'RCTRANDA  D
 . . S RCDATA0=$G(^RCY(344,RCRECTDA,1,RCTRANDA,0))
 . . S RCDATA2=$G(^RCY(344,RCRECTDA,1,RCTRANDA,2))
 . . S RCDATA3=$G(^RCY(344,RCRECTDA,1,RCTRANDA,3))
 . . ;get date into suspense
 . . S RCSDATE=$P(RCDATA3,U,2)
 . . S RCDAYS=$$FMTH^XLFDT(TODAY,1)-$$FMTH^XLFDT(RCSDATE,1)
 . . Q:RCSDATE=""
 . . ;
 . . ;if younger than the cutoff date, quit
 . . Q:RCDAYS'>RCMXDYS
 . . ;
 . . ; get the user and disposition
 . . S RCUSER=$$GET1^DIQ(200,$P(RCDATA3,U,3)_",",1,"E")
 . . S RCDISP=$$UP^XLFSTR($$GET1^DIQ(344.01,RCTRANDA_","_RCRECTDA_",",3.01))
 . . ;
 . . ;Suspense status has been cleared quit
 . . Q:$P(RCDATA2,U,6)'="" 
 . . ;
 . . ;Extract needed info for report
 . . S RCEFTDT=$P(RCDATA0,U,6),RCDEPAMT=$P(RCDATA0,U,4)
 . . ;
 . . ;update counter and amount info
 . . S RCSUSCNT=RCSUSCNT+1
 . . S RCSUSAMT=RCSUSAMT+RCDEPAMT
 . . S RCRSN=$E($P($G(^RCY(344,RCRECTDA,1,RCTRANDA,1)),U,2),1,12)
 . . S RCSREC=RCREC_"@"_RCTRANDA
 . . ;
 . . ;update temporary array
 . . S ^TMP(RCPROG,$J,"SUSPENSE",RCSDATE,RCSUSCNT)=$$ESUSPL(RCSDATE,RCDAYS,RCUSER,RCSREC,RCDEPAMT,RCDISP,RCRSN)
 ;
 Q
 ;
BULLETIN ;Create bulletins only if overdue EFT/ERA found
 ;
 N ARRAY,SBJ,SUB,CNT,CNT1,RCPROG1,GLB,RCMXDYS,IDX
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
 .S IDX="" F  S IDX=$O(^TMP(RCPROG,$J,SUB,IDX)) Q:'IDX  F  S CNT=$O(^TMP(RCPROG,$J,SUB,IDX,CNT)) Q:'CNT  D
 ..S CNT1=CNT1+1,@GLB@(CNT1)=^TMP(RCPROG,$J,SUB,IDX,CNT)
 .S @GLB@(CNT1+1)="** END OF REPORT **"
 .D SEND
 .K @GLB
 ;
 ;Unposted "ACH" ERA bulletins
 ; PRCA*4.5*303 - modified this bulletin to show only "ACH" expected payments
 I ERA1CNT D
 .;Build header
 .S SUB="ERA1" K @GLB
 .; PRCA*4.5*303 - Changed SBJ to make sure it was less than 65 characters
 .S SBJ="EDI LBOX-STA# "_$P($$SITE^VASITE,"^",3)_"-ACTION REQ-EFT:Matched/Not Posted ERA>30 days"
 .S @GLB@(1)="The listed ERAs were received more than 30 days ago and have been matched but"
 .S @GLB@(2)="have not been posted"
 .S @GLB@(3)=" "
 .S @GLB@(4)="Total # of ERAs - ""MATCHED TO EFT"" - "_ERA1CNT
 .S @GLB@(5)="Total Dollar Amount - "_"$"_$FN(ERA1TOT,",",2)
 .S @GLB@(6)=" "
 .S @GLB@(7)="ERA#        PAYER NAME                                FILE DATE    AMOUNT PAID"
 .;
 .;Move unposted ERA search findings into message
 .S CNT=0,CNT1=8,IDX=""
 .F  S IDX=$O(^TMP(RCPROG,$J,SUB,IDX)) Q:'IDX  F  S CNT=$O(^TMP(RCPROG,$J,SUB,IDX,CNT)) Q:'CNT  D
 ..S CNT1=CNT1+1
 ..S @GLB@(CNT1)=^TMP(RCPROG,$J,SUB,IDX,CNT)
 .S @GLB@(CNT1+1)="** END OF REPORT **"
 .D SEND
 .K @GLB
 ;
 ;Unposted "CHK" ERA bulletins or ERAs, that don't match "ACH"
 ; PRCA*4.5*303 - modified this bulletin to show "CHK" expected payments (or don't match "ACH")
 I ERA2CNT D
 .;Build header
 .S SUB="ERA2" K @GLB
 .; PRCA*4.5*303 - Changed SBJ to make sure it was less than 65 characters
 .S SBJ="EDI LBOX-STA# "_$P($$SITE^VASITE,"^",3)_"-ACTION REQ-PAPER:Matched/Not Posted ERA>30 days"
 .S @GLB@(1)="The listed ERAs were received more than 30 days ago and have been matched but"
 .S @GLB@(2)="have not been posted"
 .S @GLB@(3)=" "
 .S @GLB@(4)="Total # of ERAs - ""MATCHED TO PAPER CHECK"" - "_ERA2CNT
 .S @GLB@(5)="Total Dollar Amount - "_"$"_$FN(ERA2TOT,",",2)
 .S @GLB@(6)=" "
 .S @GLB@(7)="ERA#        PAYER NAME                                FILE DATE    AMOUNT PAID"
 .;
 .;Move unposted ERA search findings into message
 .S CNT=0,CNT1=8,IDX=""
 .F  S IDX=$O(^TMP(RCPROG,$J,SUB,IDX)) Q:'IDX  F  S CNT=$O(^TMP(RCPROG,$J,SUB,IDX,CNT)) Q:'CNT  D
 ..S CNT1=CNT1+1,@GLB@(CNT1)=^TMP(RCPROG,$J,SUB,IDX,CNT)
 .S @GLB@(CNT1+1)="** END OF REPORT **"
 .D SEND
 .K @GLB
 ;
 ;Unmatched EFT bulletins
 ; PRCA*4.5*303 - Changed logic to send "No EFTs more than 14 days..." message if no EFTs
 ;I EFTCNT D
 ;Build header
 S SUB="EFT" K @GLB
 S SBJ="EDI LBOX-STA# "_$P($$SITE^VASITE,"^",3)_"-ACTION REQ-EFTs > 14 days"
 I EFTCNT=0 D  G B1
 . S @GLB@(1)="**** There are NO EFTs more than 14 days old that have not yet been matched."
 . S @GLB@(2)=" "
 . S @GLB@(3)="Total # of EFTs - "_EFTCNT
 . S @GLB@(4)="Total Dollar Amount - $"_$FN(0,",",2)
 . S @GLB@(5)=" "
 . S @GLB@(6)="** END OF REPORT **"
 ;
 I EFTCNT>0 D
 .S @GLB@(1)="The following EFTs were received more than 14 days ago and have not yet"
 .S @GLB@(2)="been matched."
 .S @GLB@(3)=" "
 .S @GLB@(4)="Total # of EFTs - "_EFTCNT
 .S @GLB@(5)="Total Dollar Amount - "_"$"_$FN(EFTTOT,",",2)
 .S @GLB@(6)=" "
 .S @GLB@(7)="DEPOSIT#   PAYER NAME/TRACE#                         EFT DATE    DEPOSIT AMT"
 .;
 .;Move EFT search findings into message
 .S CNT=0,CNT1=8,SUB="EFT",IDX=""
 .F  S IDX=$O(^TMP(RCPROG,$J,SUB,IDX)) Q:'IDX  F  S CNT=$O(^TMP(RCPROG,$J,SUB,IDX,CNT)) Q:'CNT  D
 ..S CNT1=CNT1+1,@GLB@(CNT1)=^TMP(RCPROG,$J,SUB,IDX,CNT)
 .S @GLB@(CNT1+1)="** END OF REPORT **"
B1 ;
 D SEND
 K @GLB
 ;
 ;PRCA*4.5*304 - Add suspense bulletin
 ; Suspense bulletins
 ;
 ; Send bulletin if items in suspense
 I RCSUSCNT D
 . ;
 . N DT
 . ;Retrieve the parameter
 . S RCMXDYS=$$GET1^DIQ(342,"1,",7.04)
 . ;
 . ;Build header
 . S SUB="SUSPENSE" K @GLB
 . S SBJ="EDI LBOX-STA# "_$P($$SITE^VASITE,"^",3)_"-SUSPENSE ENTRIES OVERDUE FOR PROCESSING"
 . S @GLB@(1)="The following entries have been in Suspense past the #days allowed by site"
 . S @GLB@(2)="parameter - which is currently set at "_RCMXDYS_" days."
 . S @GLB@(3)=" "
 . S @GLB@(4)="Total # of Overdue Entries in Suspense  - "_RCSUSCNT
 . S @GLB@(5)="Total Dollar Amount Overdue in Suspense - "_"$"_$FN(RCSUSAMT,",",2)
 . S @GLB@(6)=" "
 . S @GLB@(7)="SUSP DATE  #DAYS USER RECEIPT#               AMOUNT DISP        REASON"
 . ;
 . ;Move Suspense search findings into message
 . S CNT=0,CNT1=8,SUB="SUSPENSE",DT=0
 . F  S DT=$O(^TMP(RCPROG,$J,SUB,DT)) Q:'DT  D
 . . F  S CNT=$O(^TMP(RCPROG,$J,SUB,DT,CNT)) Q:'CNT  D
 . . . S CNT1=CNT1+1,@GLB@(CNT1)=^TMP(RCPROG,$J,SUB,DT,CNT)
 . S @GLB@(CNT1+1)="** END OF REPORT **"
 . D SEND
 . K @GLB
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
 ;
 ;PRCA*4.5*304
ESUSPL(X1,X2,X3,X4,X5,X6,X7) ;Format Suspense Message line
 N SPACE
 S SPACE=$J("",80)
 ;spacing for Suspense Date
 S X1=$$FMTE^XLFDT(X1,"2D")
 S X1=X1_$E(SPACE,1,10-$L(X1))
 ;spacing for # days in suspense
 S X2=$E(SPACE,1,6-$L(X2))_X2
 ;spacing for USER
 S X3=" "_X3_$E(SPACE,1,5-$L(X3))
 ;spacing for RECEIPT NUMBER_TRANS #
 S X4=$E(X4_SPACE,1,16)
 ;spacing for amount in suspense
 S X5=$J("$"_$FN(X5,",",2),13)_" "
 ;spacing for STATUS
 S X6=X6_$E(SPACE,1,12-$L(X6))
 ;spacing for REASON
 S X7=X7_$E(SPACE,1,12-$L(X7))
 ;return concatenated string
 Q X1_X2_X3_X4_X5_X6_X7
 ;
