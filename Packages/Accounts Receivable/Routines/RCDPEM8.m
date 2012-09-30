RCDPEM8 ;OIFO-BAYPINES/PJH - EOB MOVE/COPY BULLETINS ;10/5/11 10:54am
 ;;4.5;Accounts Receivable;**276**;Mar 20, 1995;Build 87
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ; Main entry point for Moved/Copied EOB bulletins
 ;
 ; Integration Agreement IA 451 allows read of file #361.1 from AR
 ;
 N EOBCNT,RCPROG
 ;Clear workfiles
 S RCPROG="RCDPEM8" K ^TMP(RCPROG,$J)
 ;Set count of EOB found
 S EOBCNT=0
 ;
 ;Scan for today's moved/copied EOB's
 D EOBSCAN
 ;Bulletin
 I EOBCNT D BULLETIN
 ;Clear workfiles
 K ^TMP(RCPROG,$J)
 Q
 ;
EOBSCAN ;Scan EOB
 N CDATE,CNT,DONE,EOBIEN,IEN101,NOW
 ;Start day for scan is yesterday
 S NOW=$$NOW^XLFDT,CDATE=$$FMADD^XLFDT($P(NOW,"."),-1)
 ;Scan AEOB index for changed EOBs
 F  S CDATE=$O(^IBM(361.1,"AEOB",CDATE)) Q:'CDATE  D
 .;Check if change was over 24 hours ago
 .I $$FMDIFF^XLFDT(NOW,CDATE,2)>86400 Q
 .;Skip this transaction if all referenced claims are active
 .Q:'$$INACTIVE(CDATE)
 .;Otherwise save bulletin details for EOB's in the transaction
 .S EOBIEN="",CNT=0,EOBCNT=EOBCNT+1
 .F  S EOBIEN=$O(^IBM(361.1,"AEOB",CDATE,EOBIEN)) Q:'EOBIEN  D
 ..;Update counter
 ..S CNT=CNT+1
 ..S IEN101=$O(^IBM(361.1,"AEOB",CDATE,EOBIEN,"")) Q:'IEN101
 ..;Save to workfile
 ..D SAVE(CDATE,EOBIEN,IEN101,EOBCNT,CNT)
 Q
 ;
INACTIVE(CDATE) ;Search for any bill that is not ACTIVE
 N CBILL,FBILL,FOUND,REC101,SUB,SUB101
 S SUB=0,FOUND=0
 F  S SUB=$O(^IBM(361.1,"AEOB",CDATE,SUB)) Q:'SUB  D  Q:FOUND
 .S SUB101=0
 .F  S SUB101=$O(^IBM(361.1,"AEOB",CDATE,SUB,SUB101)) Q:'SUB101  D  Q:FOUND
 ..S REC101=$G(^IBM(361.1,SUB,101,SUB101,0))
 ..;From bill
 ..S FBILL=$P(REC101,U,4)
 ..I FBILL S FOUND=$$CHECK(FBILL) Q:FOUND
 ..;Current bill on EOB
 ..S CBILL=$P($G(^IBM(361.1,SUB,0)),U)
 ..;AR claim status
 ..I CBILL S FOUND=$$CHECK(CBILL)
 Q FOUND
 ;
CHECK(IEN430) ;Check claim status in AR
 I $$GET1^DIQ(430,IEN430,8)="ACTIVE" Q 0
 Q 1
 ;
SAVE(CDATE,EOBIEN,IEN101,EOBCNT,CNT) ;Put the data into the ^TMP global
 ; INPUTS: EOBIEN = ien of the EOB
 ;         IEN101 = ien of individual copy
 ;         EOBCNT = count of EOB found
 ;         CNT = count of claims within transaction
 ; RETURNS  : Builds each entry in the ^TMP global
 ;
 N BIEN,BEXT,DATE,DOS,PATIEN,PATNAM,PIEN,PEXT,PSQ,PSQEXT,REC0,STAT
 N REC101,ORIG,MODE
 ;Get EOB detail
 S REC0=$G(^IBM(361.1,EOBIEN,0))
 ;Bill pointer
 S BIEN=$P(REC0,U) Q:'BIEN
 ;Get audit detail
 S REC101=$G(^IBM(361.1,EOBIEN,101,IEN101,0))
 ;Mode and Original claim
 S ORIG=$P(REC101,U,4),MODE=$P(REC101,U,5)
 ;
 ;If transaction is a move the only EOB is on the new claim
 ;
 ;Create report line for original claim
 I MODE="M",ORIG D
 .N BIEN
 .S BIEN=ORIG D SAVE1 S CNT=CNT+1
 ;
 ;Save transaction for to bill
 D SAVE1
 Q
 ;
SAVE1 ;Save unformatted bill details into ^TMP
 ;
 ;Get Bill number from bill IEN
 S BEXT=$P($G(^PRCA(430,BIEN,0)),U)
 ;Patient IEN
 S PATIEN=$P($G(^DGCR(399,BIEN,0)),U,2)
 ;Patient Name
 S PATNAM=$$EXTERNAL^DILFD(399,.02,,PATIEN)
 ;DOS
 S DOS=$$FMTE^XLFDT($P($G(^DGCR(399,BIEN,0)),U,3),"2D")
 ;Payer
 S PIEN=$P(REC0,U,2)
 ;Payer external form
 S PEXT=$$EXTERNAL^DILFD(361.1,.02,,PIEN)
 ;If no payer name on EOB check AR claim
 I PEXT="" S PEXT=$$GET1^DIQ(430,BIEN,9)
 ;Truncate payer name to 18 characters
 S PEXT=$E(PEXT,1,18)
 ;Payer Sequence
 S PSQ=$P(REC0,U,15)
 ;Payer sequence - external
 S PSQEXT=$$EXTERNAL^DILFD(361.1,.15,,PSQ)
 ;Display sequence if not null
 S:PSQEXT]"" PEXT=PEXT_"/"_PSQEXT
 ;AR claim status
 S STAT=$$GET1^DIQ(430,BIEN,8)
 ;Date/Time EOB was moved/copied
 S DATE=$$FMTE^XLFDT(CDATE,"2S")
 ;
 S ^TMP(RCPROG,$J,EOBCNT,CNT)=DATE_U_BEXT_U_PATNAM_U_DOS_U_PEXT_U_STAT
 Q
 ;
BULLETIN ;Create bulletins only if moved/copied EOB found
 ;
 N ARRAY,BLANK,SBJ,SUB,SUBHDR,SUBHDR1,SUBHDR2,CNT,CNT1,RCPROG1,GLB
 N LINE,DET
 S RCPROG1="RCDPEM8A",GLB=$NA(^TMP(RCPROG1,$J,"XMTEXT"))
 ;
 ;Compile Move/Copy Transactions Bulletin
 ;Build header
 K @GLB
 S SBJ="EDI LBOX-STA# "_$P($$SITE^VASITE,"^",3)_"-Move/Copy Transactions"
 S @GLB@(1)="The listed Move/Copy transaction(s) were performed within the last 24 hours"
 S @GLB@(2)="and at least one of the claims in each of the transactions was NOT ACTIVE."
 S @GLB@(3)=" "
 S @GLB@(4)="Total # of transactions - "_EOBCNT
 S @GLB@(6)=" "
 S @GLB@(7)="BILL #       PATIENT             DOS         PAYER/SEQUENCE"
 S @GLB@(8)="   STATUS"
 S @GLB@(9)="----------------------------------------------------------------------------"
 ;
 ;Sub headers
 S SUBHDR="Transaction "
 S SUBHDR1=" - 'MOVE/COPY FROM' bill "
 S SUBHDR2=" 'MOVE/COPY TO' bill(s)"
 S BLANK=$J("",75)
 ;
 ;Move EOB search findings into message
 S EOBCNT="",CNT1=9
 F  S EOBCNT=$O(^TMP(RCPROG,$J,EOBCNT)) Q:'EOBCNT  D
 .S CNT=0
 .F  S CNT=$O(^TMP(RCPROG,$J,EOBCNT,CNT)) Q:'CNT  D
 ..;EOB data from scan
 ..S DET=$G(^TMP(RCPROG,$J,EOBCNT,CNT))
 ..;Check if 'From' or 'To'
 ..I CNT=1 S LINE=SUBHDR_EOBCNT_SUBHDR1_$P(DET,U)
 ..E  S LINE=SUBHDR2
 ..S CNT1=CNT1+1,@GLB@(CNT1)=LINE
 ..S CNT1=CNT1+1,@GLB@(CNT1)=$$EOBL(DET)
 ..S CNT1=CNT1+1,@GLB@(CNT1)="   "_$P(DET,U,6)
 ..S CNT1=CNT1+1,@GLB@(CNT1)=BLANK
 S @GLB@(CNT1+1)="** END OF REPORT **"
 ;
 ;Transmit mail message
 N XMDUZ,XMTEXT,XMSUB,XMY,XMINSTR
 S XMDUZ=DUZ,XMTEXT=GLB,XMSUB=SBJ,XMY("I:G.RCDPE MOVE COPY")=""
 S XMINSTR("FROM")="POSTMASTER"
 D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY,.XMINSTR)
 K @GLB
 Q
 ;
 ;
EOBL(DET) ;Format EOB line
 N BILL,DOS,PATIENT,PAYER,OUTPUT,SP
 S BILL=$P(DET,U,2),PATIENT=$P(DET,U,3),DOS=$P(DET,U,4),SP=$J("",80)
 S PAYER=$P(DET,U,5)
 ;Truncate patient name
 S PATIENT=$E(PATIENT,1,19)
 ;Bill number
 S OUTPUT=BILL_$E(SP,1,12-$L(BILL))
 ;Patient
 S OUTPUT=OUTPUT_PATIENT_$E(SP,1,20-$L(PATIENT))
 ;DOS
 S OUTPUT=OUTPUT_DOS_$E(SP,1,13-$L(DOS))
 ;Payer
 S OUTPUT=OUTPUT_PAYER
 ;
 Q OUTPUT
