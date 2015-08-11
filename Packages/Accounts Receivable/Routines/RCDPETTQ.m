RCDPETTQ ; ePayments/CNF, hrubovcak - EDI Testing Tool QUICK actions ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**298**; 20 Dec 2013;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; called by RCDPETT
 Q
 ;
QUICK ; Quick option to copy/edit/send
 ;
 D NTRY^RCDPETTU("Quick ERA Object")
 ;
 N RCMSGSEL,RCCOPY
 S RCMSGSEL=0  ;initialize selected message id to 0
 ;
 N DIR S DIR(0)="YOA",DIR("A")="Copy message? ",DIR("B")="YES"
 D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 S RCCOPY=0 I Y S RCCOPY=1
 I RCCOPY D COPY(.RCMSGSEL) Q:'RCMSGSEL
 I 'RCCOPY D
 .W ! S RCMSGSEL=$$SELECT^RCDPETTU("ERA")  ; only ERA entries
 I '(RCMSGSEL>0) W !!,"No message selected. Exiting.",! Q
 D EDWRK^RCDPETTE(RCMSGSEL,1)  ;Edit message content
 ;
 N RCTRACE,RCEFT,RCSTOP
 K RCDATA("ERA")
 S RCEFT="",RCSTOP=0
 D GETDATA(.RCDATA,.RCTRACE,.RCEFT,.RCSTOP,RCMSGSEL)
 D SNDMM^RCDPETTE(.RCDATA)
 ;
 ;send corresponding EFT message to VistA?
 W !,"EFT has been constructed."
 ;
 K RCDATA
 D GETDATAE(.RCDATA,RCEFT)
 D SNDMM^RCDPETTE(.RCDATA)
 ;
 Q
 ;
COPY(RCMSGSEL) ; Copy ERA message
 ;Output - New internal message id
 ;
 N DIR,J,RCEEOB,RCEXP,RCMSG,RCOB,RCIEN,RCTYPE,X,Y
 S RCTYPE="ERA",RCIEN=$$SELECT^RCDPETTU(RCTYPE) I '(RCIEN>0) Q
 D ARRAY^RCDPETTU(+RCIEN,.RCEEOB)
 I '$D(RCEEOB) W !,"No lines to copy. Exiting.",! Q
 ;
 ; set to auto-import
 S RCOB("AUTOIMP")=1,RCOB("IEN")=0
 ; user response cannot contain '^'
 S DIR(0)="FOA",DIR("A")="EEOB Description: "
 D ^DIR I Y="" W !,"Description is required. Exiting.",! Q
 S RCOB("XMZ")=0  ; no MM message number
 ;
 S RCOB("XMZ",0)=Y  ; instead of the MM message zero node
 ; create text for a single object
 F J=1:1 Q:'$D(RCEEOB(J))  S RCEXP(1,J)=RCEEOB(J)
 S RCEXP("TYPE")=RCTYPE,RCEXP=1
 D NWOBJ^RCDPETTU(.RCOB,.RCEXP)
 ;
 I '$G(RCOB("IEN")) W !,"* Entry not created! *" Q
 S J=$O(RCOB("IEN",0)) W:J !!,?5,"Created #"_J_" "_$P(^RCY(344.81,J,0),U),!
 S RCMSGSEL=J
 ;
 Q
 ;
GETDATA(RCDATA,RCTRACE,RCEFT,RCSTOP,RCMSGSEL) ;Get data to send into VistA for ERA
 ; RCDATA = Array of EEOB text for the body of the ERA
 ; RCTRACE = ERA trace number, also used for matching EFT
 ; RCEFT = Array of EFT detail line that matches the ERA
 ; RCSTOP = Flag to indicate stoppage before ERA construction completed
 ; RCMSGSEL = Message to send into VistA
 ;
 N DIR,J,K,RCAMT,RCCNT,RCEEOB,RCIE,RCIEN,RCMSG,RCPAYIEN,RCPAYID,RCPAYNM,RCSEL,RCTEMP,RCTYPE,Y
 ;
 S RCTYPE="ERA"
 ;
 ;Get template for header
 S RCTEMP(1,1)=$P($T(ERAHDR+1),";;",2)
 S RCTEMP(1,2)=$P($T(ERAHDR+2),";;",2)
 ;
 ;Get EEOB content
 K RCEEOB
 D ARRAY^RCDPETTU(+RCMSGSEL,.RCEEOB)
 I '$D(RCEEOB) S RCSTOP=1 Q
 ;
 ;Build body of MailMan message
 M RCTEMP(2)=RCEEOB
 ;
 I '$D(RCTEMP) W !,"No message selected. Exiting.",! S RCSTOP=1 Q
 ;
 ;Get Payer IEN for defaults, set payer id and payer name, comes from user preferences
 S RCPAYIEN="",RCPAYIEN=$$GET1^DIQ(344.82,DUZ,1.01,"I")
 S RCPAYID="",RCPAYNM=""
 I RCPAYIEN S RCPAYID=$$GET1^DIQ(344.6,RCPAYIEN,.02),RCPAYNM=$$GET1^DIQ(344.6,RCPAYIEN,.01)
 S $P(RCTEMP(1,2),"^",7)=RCPAYID
 S $P(RCTEMP(1,2),"^",6)=RCPAYNM
 ;
 ;Payment Method Code, comes from user preferences
 S $P(RCTEMP(1,2),"^",17)=$$GET1^DIQ(344.82,DUZ,1.02)
 ;
 ;Trace Number
 S RCTRACE=+$H_$P($H,",",2)
 S $P(RCTEMP(1,2),"^",8)=RCTRACE
 ;
 ;MRA flag = No
 S $P(RCTEMP(1,2),"^",5)="N"
 ;
 ;Control Number
 S $P(RCTEMP(1,2),"^",13)=+$H_$P($H,",",2)
 ;
 ;Sequence Number
 S $P(RCTEMP(1,2),"^",14)="01"
 ;
 ;Last Sequence Number = "Y"
 S $P(RCTEMP(1,2),"^",15)="Y"
 ;
 ;HIPAA Version
 S $P(RCTEMP(1,2),"^",16)="005010"
 ;
 ;File Date, set to today's date
 S $P(RCTEMP(1,2),"^",3)=$$Y4MD^RCDPETTU
 ;
 ;Date Claim Paid, set to today's date
 S $P(RCTEMP(1,2),"^",9)=$$Y4MD^RCDPETTU
 ;
 S RCAMT=0  ;Initialize total amount of ERA
 ;
 ;Put array into RCDATA and calculate total
 S RCCNT=0  ;counter
 F J=1:1 Q:'$D(RCTEMP(J))  D
 .F K=1:1 Q:'$D(RCTEMP(J,K))  D
 ..S RCCNT=RCCNT+1,RCDATA("ERA",RCCNT)=RCTEMP(J,K)
 ..I +RCTEMP(J,K)=10 S RCAMT=RCAMT+$P(RCTEMP(J,K),"^",11)  ;add amount paid to total amount of ERA
 S RCCNT=RCCNT+1,RCDATA("ERA",RCCNT)="99^$"
 S RCCNT=RCCNT+1,RCDATA("ERA",RCCNT)="NNNN"
 ;
 ;Total ERA Amount
 S RCAMT=$$LZ^RCDPETTU(RCAMT,13)
 S $P(RCDATA("ERA",2),"^",10)=RCAMT
 ;
 ;Display trace number for user reference
 W !!,"ERA has been constructed.",!,"Trace Number:  ",RCTRACE,!!
 ;
 ;Build matching EFT
 N RCDATE,RCSUB,X,X1,X2
 S RCSUB="RCDPETT "_RCTRACE
 ;purge date is 30 days from today
 S ^XTMP(RCSUB,0)=$$HTE^XLFDT($H+30)_"^"_DT_"^RCDPETT DATA"
 S RCDATE=$$Y4MD^RCDPETTU
 S RCEFT="01^"_RCTRACE_"^"_RCDATE_"^"_RCAMT_"^"_RCPAYNM_"^"_RCPAYID_"^^"
 S ^XTMP(RCSUB,"EFT",1)=RCEFT
 ;
 Q
 ;
GETDATAE(RCDATA,RCEFT)  ;Get data to send into VistA for EFT
 ;
 N K,RCAMT,RCDEPN
 S RCDATA("ERA",1)=$P($T(EFTHDR+1^RCDPETTF),";;",2)
 S RCDATA("ERA",2)=$P($T(EFTHDR+2^RCDPETTF),";;",2)
 S RCDATA("ERA",3)=RCEFT
 S RCDATA("ERA",4)="99^$"
 S RCDATA("ERA",5)="NNNN"
 S RCAMT=$P(RCEFT,"^",4)
 ;
 ;Total EFT Amount
 S RCAMT=$$LZ^RCDPETTU(RCAMT,14)
 S $P(RCDATA("ERA",2),"^",8)=RCAMT
 ;
 ;Deposit Number
 ;if $H = 63229,53304 then RCDEPN = TT2295330
 S RCDEPN="TT"_$E(+$H,3,5)_$E($P($H,",",2),1,4)
 W !,"Deposit Number ",RCDEPN,!
 S $P(RCDATA("ERA",2),"^",6)=RCDEPN
 ;
 ;Deposit Date
 S $P(RCDATA("ERA",2),"^",7)=$P(RCDATA("ERA",3),"^",3)
 ;
 Q
 ;
ERAHDR ;Template Header for ERA
 ;;RACUBOTH RUCHMLB0012 2851531-UUUU--RUCHAAR..
 ;;835ERA^X^20100922^1632^Y^FEDERAL EMPLOYEES HEALTH BENEFIT A COVENTRY HEALTH CARE PLAN^1382242132^20101012031^20100920^0000000040368^830168494^^0007344735^01^Y^004010^CHK^1164471991
 ;
