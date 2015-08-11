RCDPETTM ; ePayments/CNF, hrubovcak - EDI Testing Tool MRA actions ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**298**; 20 Dec 2013;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; called by RCDPETT
 Q
 ;
COPY ; Copy MRA message
 ;
 D NTRY^RCDPETTU("Copy MRA Object")
 D COPY^RCDPETTU("MRA")
 ;
 Q
 ;
DEL ; delete MRA type object
 ;
 D NTRY^RCDPETTU("Delete MRA Object")
 D DEL^RCDPETTU("MRA")
 ;
 Q
 ;
EDMSG ; edit MRA message
 ;
 N RCMSGSEL,X
 S X="Edit MRA Message"
 D NTRY^RCDPETTU(X) W !!,X_" "_$$NOW^RCDPETTU
 ;
 ; Select MRA message to edit
 S RCMSGSEL=0 F  D  Q:'(RCMSGSEL>0)
 .W ! S RCMSGSEL=$$SELECT^RCDPETTU("MRA")  ; only MRA entries
 .I '(RCMSGSEL>0) W !!,"No message selected. Exiting.",! Q
 .D EDWRK(RCMSGSEL)
 ;
 Q
 ;
EDWRK(RCMSG) ; RCMSG = "ien #344.81 ^ .01 field"
 ;
 Q:'($G(RCMSG)>0)  ; required
 D LOG^RCDPETTU("edit MRA "_RCMSG)
 N DIC,DIR,DOSF,DOST,DR,IEN,IEN2,J,K,L,RCBILL,RCEDIT,RCLT,RCLASTNM,RCOA,RCPATID,RCPCE,RCREC,RCRECB,RCTEXT,RCV,RCVAR,TAG,X,Y
 ;Get message content
 D ARRAY^RCDPETTU(+RCMSG,.RCEEOB)
 I '$D(RCEEOB) W !,"No lines to edit. Exiting.",! Q
 ;
 ;Build a list of records that contain editable data
 ; example: RCREC="/05/10/15/20/40/45/"
 S RCREC="/" F J=1:1 S RCTEXT=$T(MRA+J) Q:$E(RCTEXT,1,3)'=" ;;"  S RCREC=RCREC_$P(RCTEXT,";",3)_"/"
 ;
 ;Build an array of records and fields that contain the bill number
 ; RCRECB(Record,Field)=""
 K RCRECB
 F J=1:1 S RCTEXT=$T(MRABILL+J) Q:$E(RCTEXT,1,3)'=" ;;"  S RCRECB($P(RCTEXT,";",3),$P(RCTEXT,";",4))=""
 ;
 ;
 D EDITOBJ^RCDPETTU(+RCMSG)
 ;Get bill number, stored in RCBILL
 N DIR S DIR(0)="FOAU",DIR("A")="Bill #? "
 F J=1:1:20 I +$G(RCEEOB(J))=5 S DIR("B")=$P(RCEEOB(J),"^",2) Q
 D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 I Y="^" Q
 S RCBILL=Y
 ;
 ;Look up the bill #.  If it's valid, set defaults for last name, patient id, date of service, original amount
 S RCPATID="",RCLASTNM="",DOSF="",DOST="",RCOA=""
 ; RCPATID - Patient ID
 ; RCLASTNM - Patient's last name
 ; DOSF - Date of Service (From)
 ; DOST - Date of Service (To)
 ; RCOA - Original Amount of bill
 ;
 S X=Y I RCBILL["-" S X=$P(RCBILL,"-",2)  ;bill number example:  442-K12121G; X will be K12121G
 ; IEN - pointer file #2, IEN2 - pointer file #399
 S DIC="^DGCR(399,",DIC(0)="EQ" D ^DIC S IEN2=+Y
 I Y>0 S:RCBILL["-" $P(RCBILL,"-",2)=$P($G(Y),"^",2) I RCBILL'["-" S RCBILL=$P($G(Y),"^",2)  ;Keep site if entered
 I $G(IEN2) D
 .S IEN=$$GET1^DIQ(399,IEN2,.02,"I")
 .S DOSF=$$GET1^DIQ(399,IEN2,151,"I")
 .S DOST=$$GET1^DIQ(399,IEN2,152,"I")
 .S DOSF=17000000+DOSF  ;convert format to YYYYMMDD, date of service from
 .S DOST=17000000+DOST  ;convert format to YYYYMMDD, date of service to
 I $G(IEN) D
 .S RCLASTNM=$$GET1^DIQ(2,IEN,.01),RCLASTNM=$P(RCLASTNM,",",1)  ;patient's last name
 .S RCPATID=$$GET1^DIQ(2,IEN,.09)  ;patient id
 S X=RCBILL,DIC="^PRCA(430,",DIC(0)="Z" D ^DIC I +Y D    ;bill number example:  442-K12121G; X = bill number
 .S RCOA=$$GET1^DIQ(430,+Y,3),RCOA=RCOA*100   ;original amount
 ;
 ;Loop through the EEOB to modify data
 S RCEDIT=1  ;RCEDIT = 0 if user aborts
 F J=1:1 Q:'$D(RCEEOB(J))  S RCEEOB=RCEEOB(J) D
 .S RCLT=$P(RCEEOB,"^",1)  ;RCLT = Line type field, contains record number
 .;
 .;If line contains bill #, replace with the bill # provided by user
 .I $D(RCRECB(+RCLT)) S K="",L="" F K=1:1 S L=$O(RCRECB(+RCLT,L)) Q:L=""  S $P(RCEEOB,"^",L)=RCBILL
 .;
 .;Quit if no user editable data
 .I RCREC'[("/"_RCLT_"/") S RCEEOB(J)=RCEEOB Q
 .;
 .;Quit if user has stopped editing by entering "^"
 .I 'RCEDIT S RCEEOB(J)=RCEEOB Q
 .
 .;Loop through editable fields
 .S TAG="MRA"_RCLT  ;Example:  TAG="MRA05" (for record 05), RCTEXT=";;Patient ID;6;20;AN;RCPATID" (text under tag)
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
 ..;Pad with leading zeros, if necessary
 ..I RC6="L" S Y=$$LZ^RCDPETTU(Y,RC3)
 ..S $P(RCEEOB,"^",RC2)=Y
 ..S RCEEOB(J)=RCEEOB
 ;
 D WP^DIE(344.81,+RCMSG_",",2,"","RCEEOB")
 ;
 Q
 ;
SNDMRA ; send MRA message to VistA
 W !,"Send MRA message to VistA.",!
 N RCTRACE,RCEFT,RCSTOP
 K RCDATA("MRA")
 S RCEFT="",RCSTOP=0
 D GETDATA(.RCDATA,.RCSTOP)
 I RCSTOP Q   ;user stopped editing before MRA construction completed
 D SNDMM(.RCDATA)
 ;
 ;Note:  MRA is different from ERA.  No EFT is sent into VistA for MRA.
 ;       This routine will not match RCDPETTE exactly.
 Q
 ;
SNDMM(RCDATA) ; Entry point for MailMan message
 ; RCTO = recipients
 ; RCSUBJ = subject
 ; RCXMZR = message number returned (XMZ value)
 N C,J,RCTO,RCSUBJ,RCXMZR,X
 K ^TMP($J,"XMSGTXT")
 ;
 ; put file text into FileMan W-P format
 S J=0,C=0 F  S J=$O(RCDATA("MRA",J)) Q:'J  S X=$G(RCDATA("MRA",J)) D:X]""
 .S C=C+1,^TMP($J,"XMSGTXT",C,0)=X
 .I $L(X)>245 W !,"line longer than 245"
 .;W !,"line "_C_" > "_X
 ;
 ;W !!," "_C_" lines found",!
 ;
 N DIR S DIR(0)="YOA",DIR("A")="Send MailMan message? ",DIR("B")="YES"
 D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 I 'Y W !,"No message sent.",! Q
 ;
 ; send via MailMan
 K ^TMP("XMERR",$J)
 S RCSUBJ="EDI Test "_$$FMTE^XLFDT($$NOW^XLFDT)
 S RCTO(.5)="",RCTO(DUZ)=""
 S RCTO("G.MCH")=""  ; MRA Mail Group
 ;
 D SENDMSG^XMXAPI(DUZ,RCSUBJ,$NA(^TMP($J,"XMSGTXT")),.RCTO,,.RCXMZR)
 ;
 I $D(^TMP("XMERR",$J)) D  ; error from MailMan
 .W !!," MailMan error text "_$$NOW^RCDPETTU,!
 .N G S G=$NA(^TMP("XMERR",$J))
 .F  S G=$Q(@G) Q:G=""  Q:'($QS(G,2)=$J)  ;W !," >> "_$S($QL(G)>3:$P(G,",",4,99)_" = ",1:"")_@G
 .W !!
 ;
 ;check for success
 I $G(RCXMZR) S X="MailMan Message #"_RCXMZR_" sent." W !,X,! D LOG^RCDPETTU(X)
 ;
 Q
 ;
GETDATA(RCDATA,RCSTOP) ;Get data to send into VistA for MRA
 ; RCDATA = Array of EEOB text for the body of the MRA
 ; RCSTOP = Flag to indicate stoppage before MRA construction completed
 ;
 N DIR,J,K,RCAMT,RCCNT,RCEEOB,RCIE,RCIEN,RCMSG,RCPAYIEN,RCPAYID,RCPAYNM,RCSEL,RCTEMP,RCTYPE,Y
 ;
 S RCTYPE="MRA"
 ;
 ;Get template for header
 S RCTEMP(1,1)=$P($T(MRAHDR+1),";;",2)
 S RCTEMP(1,2)=$P($T(MRAHDR+2),";;",2)
 ;
 K DIR S DIR(0)="SA^I:INDIVIDUAL;E:EEOB GROUPING"
 S DIR("A")="Select (I)ndividual EEOBs or (E)EOB Grouping: "
 D ^DIR
 I Y="^" W !,"Exiting.",! S RCSTOP=1 Q
 Q:$D(DTOUT)!$D(DUOUT)
 S RCIE=Y  ;RCIE will be I for Individual selection or E for selection by EEOB Grouping
 ;
 I RCIE="I" D
 .F  D  Q:'(RCMSG>0)
 ..;Select EEOB to send
 ..S RCMSG=+$$SELECT^RCDPETTU(RCTYPE) Q:'(RCMSG>0)
 ..S RCSEL(RCMSG)=""
 ..K DIR S DIR(0)="YA",DIR("A")="Include reversal? "
 ..S DIR("B")="NO"
 ..D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 ..I Y S RCSEL("R"_RCMSG)=""  ;reversal of EEOB
 ;
 I RCIE="E" D
 .N D,D0,DA,DIC,GRP,X,Y
 .;Select EEOB Grouping
 .S DIC="^RCY(344.81,",DIC(0)="AEQ",DIC("A")="Select EEOB Grouping: ",D="C"
 .S DIC("S")="N RC S RC=$G(^RCY(344.81,+Y,1)) I $P(RC,U,2),$P(RC,U)=RCTYPE,+$O(^RCY(344.81,+Y,2,0))"
 .D IX^DIC
 .Q:(Y<1)
 .S GRP="",GRP=$$GET1^DIQ(344.81,+Y,.05)
 .Q:(GRP="")
 .;X = EEOB Grouping
 .M RCSEL=^RCY(344.81,"C",GRP)
 ;
 W !
 I '$D(RCSEL) W !,"No message selected. Exiting.",! S RCSTOP=1 Q
 ;
 N RCREV ;Reversal indicator
 S K="" F J=2:1 S K=$O(RCSEL(K)) Q:K=""  D
 .S RCREV=$S($E(K)="R":1,1:0)
 .;
 .;Get EEOB content
 .K RCEEOB
 .D:'RCREV ARRAY^RCDPETTU(K,.RCEEOB)
 .D:RCREV ARRAY^RCDPETTU($E(K,2,99),.RCEEOB)
 .I '$D(RCEEOB) Q
 .;
 .;If reversal, find record 10, reverse amount, set reversal indicator
 .I RCREV D
 ..N L,M S L=""
 ..F  S L=$O(RCEEOB(L)) Q:'L  D
 ...S M=RCEEOB(L) I +M'=10 Q
 ...S $P(M,"^",6)="Y"
 ...N NEWAMT
 ...S NEWAMT=$P(M,"^",11),NEWAMT="-"_$E(NEWAMT,2,99)
 ...S $P(M,"^",11)=NEWAMT,RCEEOB(L)=M
 .;
 .;Build body of MailMan message
 .M RCTEMP(J)=RCEEOB
 ;
 I '$D(RCTEMP) W !,"No message selected. Exiting.",! Q
 ;
 ;Get Payer IEN for defaults
 S RCPAYIEN="",RCPAYIEN=$$GET1^DIQ(344.82,DUZ,1.01,"I")
 ;
 K DIR S DIR(0)="FOA",DIR("A")="Payer ID: "
 I RCPAYIEN S DIR("B")=$$GET1^DIQ(344.6,RCPAYIEN,.02)
 D ^DIR
 I Y="^" S RCSTOP=1 Q
 Q:$D(DTOUT)!$D(DUOUT)
 S RCPAYID=Y
 S $P(RCTEMP(1,2),"^",7)=RCPAYID
 ;
 K DIR S DIR(0)="FOA",DIR("A")="Payer Name: "
 I RCPAYIEN S DIR("B")=$$GET1^DIQ(344.6,RCPAYIEN,.01)
 D ^DIR
 I Y="^" S RCSTOP=1 Q
 Q:$D(DTOUT)!$D(DUOUT)
 S RCPAYNM=Y
 S $P(RCTEMP(1,2),"^",6)=RCPAYNM
 ;
 ;Payment Method Code, user can override with an invalid value
 K DIR S DIR(0)="FOA",DIR("A")="Payment Method Code: "
 S DIR("B")=$$GET1^DIQ(344.82,DUZ,1.02)  ;default comes from user preferences
 D ^DIR
 I Y="^" S RCSTOP=1 Q
 Q:$D(DTOUT)!$D(DUOUT)
 S $P(RCTEMP(1,2),"^",17)=Y
 ;
 ;Trace Number
 S RCTRACE=+$H_$P($H,",",2)
 S $P(RCTEMP(1,2),"^",8)=RCTRACE
 ;
 ;MRA flag = Yes
 S $P(RCTEMP(1,2),"^",5)="Y"
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
 S RCAMT=0  ;Initialize total amount of MRA
 ;
 ;MRA level adjustments (02, 03 records)
 K DIR S DIR(0)="YA",DIR("A")="Include MRA level adjustments? "
 S DIR("B")="NO"
 D ^DIR
 I Y="^" S RCSTOP=1 Q
 Q:$D(DTOUT)!$D(DUOUT)
 I Y D
 .N RCNUM,RC02,RC03,RCADJ,NEG S NEG=0
 .F J=1:1 D  Q:Y=""
 ..N DIR S DIR(0)="FOA",DIR("A")="  Amount for adjustment #"_J_": "
 ..D ^DIR I $D(DTOUT)!$D(DUOUT) S Y=""
 ..I Y="" Q
 ..S RCADJ=$$LZ^RCDPETTU(Y,14)
 ..;Randomly pick an adjustment line to modify
 ..S RCNUM=$R(5)+1,RC02=$T(MRAADJ02+RCNUM),RC03=$T(MRAADJ03+RCNUM),RC02=$P(RC02,";;",2),RC03=$P(RC03,";;",2)
 ..S $P(RC02,"^",4)=RCADJ,RCTEMP(1,(J*2+1))=RC02,RCTEMP(1,(J*2+2))=RC03
 ..S RCAMT=RCAMT-RCADJ  ;add adjustment to total amount of MRA
 ;
 ;Put array into RCDATA and calculate total
 S RCCNT=0  ;counter
 F J=1:1 Q:'$D(RCTEMP(J))  D
 .F K=1:1 Q:'$D(RCTEMP(J,K))  D
 ..S RCCNT=RCCNT+1,RCDATA("MRA",RCCNT)=RCTEMP(J,K)
 ..I +RCTEMP(J,K)=10 S RCAMT=RCAMT+$P(RCTEMP(J,K),"^",11)  ;add amount paid to total amount of MRA
 S RCCNT=RCCNT+1,RCDATA("MRA",RCCNT)="99^$"
 S RCCNT=RCCNT+1,RCDATA("MRA",RCCNT)="NNNN"
 ;
 ;Total MRA Amount
 K DIR S DIR(0)="FOA",DIR("A")="Total MRA Amount: "
 S DIR("B")=RCAMT
 D ^DIR
 I Y="^" S RCSTOP=1 Q
 Q:$D(DTOUT)!$D(DUOUT)
 S RCAMT=$$LZ^RCDPETTU(Y,13)
 S $P(RCDATA("MRA",2),"^",10)=RCAMT
 ;
 ;Display trace number for user reference
 W !!,"MRA has been constructed.",!,"Trace Number:  ",RCTRACE,!!
 ;
 ;Display content of MRA?
 K DIR S DIR(0)="YA",DIR("A")="Display content of MRA? "
 S DIR("B")="NO" D
 .D ^DIR Q:'Y
 .S K="RCDATA" F  S K=$Q(@K) Q:K=""  W !,@K
 .W ! K DIR S DIR(0)="E" D ^DIR
 ;
 Q
 ;
VWMSG ; view MRA message
 ;
 W !,"View MRA Message."
 D DT^DICRW
 ;
 N DIR,RCMSG,RCEEOB,RCEXIT,RCPG,RCSTOP,Z
 ;Select EEOB to view
 S RCMSG=$$SELECT^RCDPETTU("MRA")
 I '(+RCMSG>0) W !,"No EDI message selected.  Exiting View.",! Q
 ;
 ;Get EEOB content
 K RCEEOB
 D ARRAY^RCDPETTU(+RCMSG,.RCEEOB)
 I '$D(RCEEOB) W !,"No lines to display.  Exiting View.",! Q
 ;
 ;Display Raw Data
 W !!
 S K="RCEEOB",RCEXIT=0
 F  S K=$Q(@K) Q:K=""  W !,@K
 W ! K DIR S DIR(0)="E" D ^DIR
 S RCEXIT=$D(DTOUT)+$D(DUOUT)
 Q:RCEXIT  ; timeout or '^'
 ;
 ;Display Formatted Output with Labels (reused code from PRT^RCDPEX3)
 K ^TMP($J,"RC_SUMOUT"),^TMP($J,"RC_SUMRAW")
 D DISP^RCDPESR0("^RCY(344.81,"_(+RCMSG)_",2)","^TMP($J,""RC_SUMRAW"")",1,"^TMP($J,""RC_SUMOUT"")",75)
 S RCPG=0,Z=0,RCEXIT=0
 F  S Z=$O(^TMP($J,"RC_SUMOUT",Z)) Q:'Z!RCEXIT  D
 . W !,$G(^TMP($J,"RC_SUMOUT",Z))
 . S RCPG=RCPG+1
 . I RCPG>20 W ! K DIR S DIR(0)="E" D ^DIR S RCPG=0,RCEXIT=$D(DTOUT)+$D(DUOUT)
 ;
 Q
 ;
MRA     ;list of MRA records that contain user editable fields
 ;;05
 ;;10
 ;;15
 ;;20
 ;;40
 ;;41
 ;;45
 ;
MRA05 ;Data map for MRA 05 record 
 ;;Patient's Last Name;3;60;ANP;RCLASTNM;
 ;;Patient ID;6;20;AN;RCPATID;
 ;
 ;Field Name; piece; max length; (A)lpha(N)umeric(P)unctuation; Variable name; Pad field with (L)eading zero (T)railing zero
 ;
MRA10 ;Data map for MRA 10 record
 ;;Amount Paid;11;15;N;;L
 ;
 ;Field Name; piece; max length; (A)lpha(N)umeric; Variable name; Pad field with (L)eading zero (T)railing zero
 ;
MRA15 ;Data map for MRA 15 record
 ;;Covered Amount;3;15;N;;L
 ;;Patient Responsibility Amount;9;15;N;;L
 ;
 ;Field Name; piece; max length; (A)lpha(N)umeric; Variable name; Pad field with (L)eading zero (T)railing zero
 ;
MRA20 ;Data map for MRA 20 record
 ;;Adjustment Amount (Claim Level Adjustment);5;15;N;;L
 ;
 ;Field Name; piece; max length; (A)lpha(N)umeric; Variable name; Pad field with (L)eading zero (T)railing zero
 ;
MRA40 ;Data map for MRA 40 record
 ;;Original Charge (Submitted Amt);15;10;N;;L
 ;;Amount Paid;17;10;N;;L
 ;;Service Date From (YYYYMMDD);19;8;N;DOSF;
 ;;Service Date To (YYYYMMDD);20;8;N;DOST;
 ;
 ;Field Name; piece; max length; (A)lpha(N)umeric; Variable name; Pad field with (L)eading zero (T)railing zero
 ;
MRA41 ;Data map for MRA 41 record
 ;;Allowed Amount (Service Line Data);5;15;N;;L
 ;
 ;Field Name; piece; max length; (A)lpha(N)umeric; Variable name; Pad field with (L)eading zero (T)railing zero
 ;
MRA45 ;Data map for MRA 45 record
 ;;Adjustment Amount (Service Line Adjustment);5;15;N;;L
 ;
 ;Field Name; piece; max length; (A)lpha(N)umeric; Variable name; Pad field with (L)eading zero (T)railing zero
 ;
MRABILL ;Data map to determine where the bill number is stored
 ;;5;2
 ;;6;2
 ;;10;2
 ;;11;2
 ;;12;2
 ;;13;2
 ;;15;2
 ;;17;2
 ;;20;2
 ;;30;2
 ;;35;2
 ;;37;2
 ;;40;2
 ;;41;2
 ;;42;2
 ;;45;2
 ;;46;2
 ;
 ;Record;position
 ;
MRAHDR ;Template Header for MRA
 ;;RACUBOTH RUCHMLB0012 2851531-UUUU--RUCHAAR..
 ;;835EOB^X^20100922^1632^Y^MEDICARE PART B^1382242132^20101012031^20100920^0000000040368^830168494^^0007344735^01^Y^004010^NON^
 ;
MRAADJ02 ;Template 02 Adjustment Record for MRA
 ;;02^50^LATE CHARGE 00112233445566779900ABCDEFGHIJKLMNOPQR^00000000000110
 ;;02^51^INTEREST PENALTY CHARGE 0011223344556677889900ABCD^00000000000120
 ;;02^72^AUTHORIZED RETURN 0011223344556677889900ABCDEFGHIJ^-0000000000130
 ;;02^90^EARLY PAYMENT ALLOWANCE 0011223344556677889900AABB^00000000000140
 ;;02^AH^ORIGINATION FEE 0011223344556677889900AABBCCDDEEFF^00000000000150
 ;
MRAADJ03 ;Template 03 Adjustment Record for MRA
 ;;03^These are non-covered services because this is not deemed a `medical necessity' by the payer.
 ;;03^These are non-covered services because this is a pre-existing condition
 ;;03^MESSAGE TEXT FOR AUTHORIZED RETURN
 ;;03^Ingredient cost adjustment.
 ;;03^MESSAGE TEXT UNAVAILABLE
 ;
