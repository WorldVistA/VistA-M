RCDPETTF ; ePayments/CNF, hrubovcak - EDI Testing Tool EFT actions ;Aug 26, 2014@17:00:17
 ;;4.5;Accounts Receivable;**298**; 20 Dec 2013;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; called by RCDPETT
 Q
 ;
COPY ; Copy EFT message
 ;
 D NTRY^RCDPETTU("Copy EFT Object")
 D COPY^RCDPETTU("EFT")
 ;
 Q
 ;
DEL ; delete EFT type object
 ;
 D NTRY^RCDPETTU("Delete EFT Object")
 D DEL^RCDPETTU("EFT")
 ;
 Q
 ;
EDMSG ; edit EFT message
 ;
 N RCMSGSEL,X
 S X="Edit EFT Message"
 D NTRY^RCDPETTU(X) W !,X_" "_$$NOW^RCDPETTU
 ;
 ; Select EFT message to edit
 S RCMSGSEL=0 F  D  Q:'(RCMSGSEL>0)
 .W ! S RCMSGSEL=$$SELECT^RCDPETTU("EFT")  ; only EFT entries
 .I '(RCMSGSEL>0) W !!,"No message selected. Exiting.",! Q
 .D EDWRK(RCMSGSEL)
 ;
 Q
 ;
EDWRK(RCMSG) ; RCMSG = "ien #344.81 ^ .01 field"
 ;
 Q:'($G(RCMSG)>0)  ; required
 D LOG^RCDPETTU("edit EFT "_RCMSG)
 ;
 N DIC,DIR,DR,IEN,J,K,L,RCEDIT,RCEEOB,RCBILL,RCLT,RCLASTNM,RCNAME,RCPATID,RCPAYIEN,RCPAYNAME,RCPAYID,RCPCE,RCREC,RCRECB,RCTEXT,RCV,RCVAR,TAG,X,Y
 ;
 D ARRAY^RCDPETTU(+RCMSG,.RCEEOB)
 I '$D(RCEEOB) W !,"No lines to edit. Exiting.",! Q
 ;
 ;Build a list of records that contain editable data
 ; example: RCREC="/05/10/15/20/40/45/"
 S RCREC="/" F J=1:1 S RCTEXT=$T(EFT+J) Q:$E(RCTEXT,1,3)'=" ;;"  S RCREC=RCREC_$P(RCTEXT,";",3)_"/"
 ;
 D EDITOBJ^RCDPETTU(+RCMSG)
 ;
 ;Default for Payer Name and ID
 S RCPAYIEN="",RCPAYNAME="",RCPAYID=""
 S RCPAYIEN=$$GET1^DIQ(344.82,DUZ,1.01,"I")
 S RCPAYID=$$GET1^DIQ(344.6,RCPAYIEN,.02)
 S RCNAME=$$GET1^DIQ(344.6,RCPAYIEN,.01)
 ;
 ;Loop through the EFT to modify data
 S RCEDIT=1
 F J=1:1 Q:'$D(RCEEOB(J))  S RCEEOB=RCEEOB(J) D
 .S RCLT=$P(RCEEOB,"^",1)  ;Line type field contains record number
 .;
 .;Quit if no user editable data
 .I RCREC'[("/"_RCLT_"/") S RCEEOB(J)=RCEEOB Q
 .;
 .;Quit if user has stopped editing by entering "^"
 .I 'RCEDIT S RCEEOB(J)=RCEEOB Q
 .
 .W !!,RCEEOB,!
 .
 .;Loop through editable fields
 .S TAG="EFT"_RCLT  ;Example:  TAG=EFT01 (for record 01)
 .F K=1:1 S RCTEXT=$T(@TAG+K) Q:$E(RCTEXT,1,3)'=" ;;"  D  I 'RCEDIT Q
 ..;
 ..;Data in RCTEXT, Corresponding variables are in brackets
 ..;[RC1]Field Name; [RC2]piece; [RC3]max length
 ..; [RC4](A)lpha(N)umeric(P)unctuation; [RC5]Variable name; [RC6]Pad field with (L)eading zero (T)railing zero
 ..;
 ..N RC1,RC2,RC3,RC4,RC5,RC6
 ..F L=1:1:6 S @("RC"_L)=$P(RCTEXT,";",(L+2))
 ..
 ..N DIR S DIR(0)="FOA",DIR("A")=RC1_": "
 ..S RCVAR="RCV",RCV="" I RC5'="" S RCVAR=RC5 ;Variable name
 ..I @RCVAR="" S @RCVAR=$P(RCEEOB,"^",RC2) ;Default data either comes from the bill or the EEOB
 ..S DIR("B")=@RCVAR
 ..D ^DIR
 ..I Y="^" S RCEDIT=0,RCEEOB(J)=RCEEOB Q
 ..Q:$D(DTOUT)!$D(DUOUT)
 ..;
 ..;Pad with leading or trailing zeros, if necessary
 ..I RC6="L" S Y=$$LZ^RCDPETTU(Y,RC3)
 ..S $P(RCEEOB,"^",RC2)=Y
 ..S RCEEOB(J)=RCEEOB
 ;
 D WP^DIE(344.81,+RCMSG_",",2,"","RCEEOB")
 ;
 Q
 ;
SNDEFT ; send EFT message to VistA
 W !,"Send EFT message to VistA.",!
 ; RCTO = recipients
 ; RCSUBJ = subject
 ; RCXMZR = message number returned (XMZ value)
 N C,J,RCTO,RCSUBJ,RCXMZR,X
 K RCDATA("ERA")
 D GETDATA(.RCDATA)
 ;
 ; nothing selected, exit
 Q:'$O(RCDATA("ERA",0))
 ;
 K ^TMP($J,"XMSGTXT")
 ;
 ; put file text into FileMan W-P format
 S J=0,C=0 F  S J=$O(RCDATA("ERA",J)) Q:'J  S X=$G(RCDATA("ERA",J)) D:X]""
 .S C=C+1,^TMP($J,"XMSGTXT",C,0)=X
 .I $L(X)>245 W !,"A line longer than 245 characters was found."
 ;
 N DIR S DIR(0)="YOA",DIR("A")="Send MailMan message? ",DIR("B")="YES"
 D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 I 'Y W !,"No message sent.",! Q
 ;
 ; send via MailMan 
 K ^TMP("XMERR",$J)
 S RCSUBJ="EDI Test "_$$FMTE^XLFDT($$NOW^XLFDT)
 S RCTO(.5)="",RCTO(DUZ)=""
 S RCTO("G.MLB")=""  ; 3rd party Lockbox Mail Group
 ;
 D SENDMSG^XMXAPI(DUZ,RCSUBJ,$NA(^TMP($J,"XMSGTXT")),.RCTO,,.RCXMZR)
 ; log MailMan error text
 D:$D(^TMP("XMERR",$J)) LOGARY^RCDPETTU($NA(^TMP("XMERR",$J)))
 ;check for success
 I $G(RCXMZR) S X="MailMan Message #"_RCXMZR_" sent." W !,X,! D LOG^RCDPETTU(X)
 ;
 Q
 ;
GETDATA(RCDATA) ;Get data to send into VistA
 ; RCDATA = Array of object text for the body of the EFT
 ;
 N DIR,J,K,RCAMT,RCCNT,RCDEPN,RCEEOB,RCIE,RCIEN,RCMSG,RCPAYIEN,RCSEL,RCTEMP,RCTRACE,RCTYPE,Y
 ;
 K RCTEMP
 S RCTYPE="EFT"
 ;
 ;Get template for header
 S RCTEMP(1,1)=$P($T(EFTHDR+1),";;",2)
 S RCTEMP(1,2)=$P($T(EFTHDR+2),";;",2)
 ;
 S DIR(0)="SB^I:Individual Objects;T:Trace Numbers;E:EFT Grouping"
 S DIR("A")="Select (I)ndividual Objects, (T)race Numbers or (E)FT Grouping"
 D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 S RCIE=Y
 ;
 I RCIE="I" D  I '$D(RCSEL) W !,"No message selected. Exiting.",! Q
 .F  D  Q:'(RCMSG>0)
 ..;Select Object to send
 ..S RCMSG=+$$SELECT^RCDPETTU(RCTYPE)
 ..Q:'(RCMSG>0)
 ..S RCSEL(+RCMSG)=""
 ;
 I RCIE="E" D  I '$D(RCSEL) W !,"No message selected. Exiting.",! Q
 .N D0,DA,DIC,X,Y
 .;Select EFT Grouping
 .S DIC="^RCY(344.81,",DIC(0)="AEQ",DIC("A")="Select EFT Grouping: ",D="C"
 .S DIC("S")="N RC S RC=$G(^RCY(344.81,+Y,1)) I $P(RC,U,2),$P(RC,U)=RCTYPE,+$O(^RCY(344.81,+Y,2,0))"
 .D IX^DIC
 .Q:(Y<1)
 .;X = EEOB Grouping
 .M RCSEL=^RCY(344.81,"C",X)
 ;
 I RCIE="T" S K=1 D  I '$D(RCTEMP) W !,"No trace number selected. Exiting.",! Q
 .F  D  I (RCTRACE="")!(RCTRACE=-1) Q
 ..;Select Trace Numbers
 ..S DIR(0)="FOA",DIR("A")="Trace #: "
 ..D ^DIR S RCTRACE=Y
 ..I (RCTRACE="")!(RCTRACE=-1) Q
 ..;Find the EFT detail line created when the ERA was constructed and sent into VistA
 ..I '$D(^XTMP("RCDPETT "_RCTRACE)) W "  Invalid Trace Number" Q
 ..I $G(^XTMP("RCDPETT "_RCTRACE,"EFT",1))="" W "  Unable to use this Trace Number to generate EFT" Q
 ..S K=K+1,RCTEMP(K,1)=^XTMP("RCDPETT "_RCTRACE,"EFT",1)
 ;
 ;If objects have been selected instead of trace numbers, get the body of the object
 I "/I/E/"[("/"_RCIE_"/") D  I '$D(RCTEMP) W !,"No message selected. Exiting.",! Q
 .S K="" F J=2:1 S K=$O(RCSEL(K)) Q:K=""  D
 ..;Get EFT content
 ..K RCEEOB
 ..D ARRAY^RCDPETTU(K,.RCEEOB)
 ..I '$D(RCEEOB) Q
 ..;
 ..;Build body of MailMan message
 ..M RCTEMP(J)=RCEEOB
 ;
 I '$D(RCTEMP) W !,"No message selected. Exiting.",! Q
 ;
 ;ACH Trace Number in header
 S $P(RCTEMP(1,2),"^",5)=+$H_$P($H,",",2)
 ;
 S RCAMT=0  ;Initialize total amount of EFT
 ;
 ;Put array into RCDATA and calculate total
 S RCCNT=0  ;counter
 F J=1:1 Q:'$D(RCTEMP(J))  D
 .F K=1:1 Q:'$D(RCTEMP(J,K))  D
 ..S RCCNT=RCCNT+1,RCDATA("ERA",RCCNT)=RCTEMP(J,K)
 ..I +RCTEMP(J,K)=1 S RCAMT=RCAMT+$P(RCTEMP(J,K),"^",4)  ;add amount paid to total amount of ERA
 ;DIR("A")="Include ERA level adjustments? (Y/N): "
 S RCCNT=RCCNT+1,RCDATA("ERA",RCCNT)="99^$"
 S RCCNT=RCCNT+1,RCDATA("ERA",RCCNT)="NNNN"
 ;
 ;Deposit Number
 ;if $H = 63229,53304 then RCDEPN = TT2295330
 S RCDEPN="TT"_$E(+$H,3,5)_$E($P($H,",",2),1,4)
 K DIR S DIR(0)="FOA",DIR("A")="Deposit Number: "
 S DIR("B")=RCDEPN
 D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 S $P(RCDATA("ERA",2),"^",6)=Y
 ;
 ;Deposit Date
 S $P(RCDATA("ERA",2),"^",7)=$P(RCDATA("ERA",3),"^",3)
 ;
 ;Total EFT Amount
 K DIR S DIR(0)="FOA",DIR("A")="Total EFT Amount: "
 S DIR("B")=RCAMT
 D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 S Y=$$LZ^RCDPETTU(Y,14)
 S $P(RCDATA("ERA",2),"^",8)=Y
 ;
 ;Display content of EFT?
 K DIR S DIR(0)="YA",DIR("A")="Display content of EFT? "
 S DIR("B")="NO"
 D ^DIR Q:'Y
 S K="RCDATA" F  S K=$Q(@K) Q:K=""  W !,@K
 W ! K DIR S DIR(0)="E" D ^DIR
 ;
 Q
 ;
VWMSG ; view EFT message
 ;
 W !,"View EFT Message."
 D DT^DICRW
 ;
 N DIR,K,RCMSG,RCEEOB,RCPG,RCSTOP
 ;Select EFT to view
 S RCMSG=$$SELECT^RCDPETTU("EFT")
 I '(+RCMSG>0) W !,"No EFT message selected.  Exiting View.",! Q
 ;
 ;Get content
 K RCEEOB
 D ARRAY^RCDPETTU(+RCMSG,.RCEEOB)
 I '$D(RCEEOB) W !,"No lines to display.  Exiting View.",! Q
 ;
 ;Display Raw Data
 W !!
 S K="RCEEOB" F  S K=$Q(@K) Q:K=""  W !,@K
 W ! K DIR S DIR(0)="E" D ^DIR
 ;
 Q
 ;
ACPT ; change EFT status to Accepted
 ; In a production environment, the EFT is accepted by FMS
 ;
 N R S R="ZZRCDPET" I $T(^@R)="" W !,"Option is not available",! Q
 ;
 D DONOTUSE^RCDPETTU
 W !!,"Change FMS status to Accepted"
 ;
 K DIR S DIR(0)="YA",DIR("A")="Do you want to continue? ",DIR("B")="NO"
 D ^DIR I 'Y W !,"Nothing changed." Q
 ;
 D NTRY^RCDPETTU("Change EFT status")
 D LOG^RCDPETTU("Change EFT status, DUZ= "_DUZ)
 ;
 W !
 ;
 ;Do SETEFT^ZZRCDPET using indirection to execute
 S R="D SETEFT^ZZRCDPET" X R
 ;
 Q
 ;
EFT     ;list of EFT records that contain user editable fields
 ;;01
 ;
EFT01 ;Data map for EFT 01 record
 ;;Trace #;2;30;AN;;
 ;;Date Claims Paid;3;8;N;;
 ;;Total Amount Paid;4;14;N;;L
 ;;Payer Name;5;35;AN;RCPAYNAME
 ;;Payer ID;6;20;AN;RCPAYID
 ;
 ;Field Name; piece; max length; (A)lpha(N)umeric; Variable name; Pad field with (L)eading zero (T)railing zero
 ;
EFTHDR ;Template Header for EFT
 ;;RACUBOTH RUCHMLB0001 0241910-UUUU--RUEVDRN.
 ;;835EFT^X^20140124^1033^^569469563^20140124^00000003293751
 ;
