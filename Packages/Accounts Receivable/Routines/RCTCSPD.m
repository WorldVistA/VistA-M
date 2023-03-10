RCTCSPD ;ALBANY/BDB-CROSS-SERVICING TRANSMISSION ;03/15/14 3:34 PM
 ;;4.5;Accounts Receivable;**301,327,315,336,338,351,350,343**;Mar 20, 1995;Build 59
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRCA*4.5*327 a. Add check to insure debtor exists to prevent 
 ;                undefined error and set in XTMP work global to
 ;                be reported via 'TCSP' mailgroup.
 ;             b. Added process controls throughout entire batch
 ;                run and message to mail group 'TCSP' batch run
 ;                is complete
 ;             c. Move SETUP/FINISH to new routine RCTCSPD0
 ;                due to SACC size constraints
 ;             d. Move REC2C tag/code to RCTCSP7 to create space
 ;                for debtor undefined logic
 ;
 ;PRCA*4.5*336 a. Shift code to handle 5B transactions ahead
 ;                of other processing that could cause a 5B
 ;                record to not be sent in batch run at tag 
 ;                $$UPDCHK(BILL), EXCEPT FOR RECALL CHECK.
 ;             b. Ensure address calls to RCTCSP1 include flag
 ;                to handle missing debtor node 1 correctly when
 ;                building address for CS transactions
 ;
 ;PRCA*4.5*343 Added check to ensure bill is cross-service status,
 ;             'active' and bal>25 to send pending tx per node 19.
 ;             Also, add check to ensure a re-established bill is
 ;             NOT ever sent to Treasury.
 ;
ENTER ;          Entry point from nightly process PRCABJ
 N DEBTOR,RC151DT,PRIN,INT,ADMIN,TDEB,TFIL,RCDFN,CNTR,SITE,LN,FN,MN,SITE,F60DT,VADM,PHONE,QUIT,TOTAL,ZIPCODE,FULLNM,RCNT,REPAY,X1,X2,ERROR,ADDR,CAT,BILLDT,CURRTOT,SITECD
 N SEQ,CNTLID,PREPDT,X1,X2,X,DELDT,ACTDT,SITE40,PRCATX,PRCAREST,PRCAREFR   ;PRCA*4.5*343
 D SETUP^RCTCSPD0
 S (DEBTOR,RCNT)=0,SEQ=0
RSDEBTOR ;
 F  S DEBTOR=$O(^PRCA(430,"C",DEBTOR)) Q:DEBTOR'?1N.N  D
 .D NOW^%DTC S ^XTMP("RCTCSPD",$J,"ZZBDEBTOR")=%_U_DEBTOR
 .N X,RCDFN,DEMCS,DOB,GNDR,DEBTOR0,DEBTOR1,DEBTOR3,DEBTOR7,DEBTOR8,BILL
 .I '$D(^RCD(340,DEBTOR,0)) S ^XTMP("RCTCSPD",$J,"ZZUNDEF",DEBTOR)="" Q
 .S DEBTOR0=^RCD(340,DEBTOR,0),DEBTOR1=$G(^(1)),DEBTOR3=$G(^(3)),DEBTOR7=$G(^(7))
 .S DEBTOR8=$O(^RCD(340,DEBTOR,8,"A"),-1) I DEBTOR8?1.N S DEBTOR8=$P($G(^RCD(340,DEBTOR,8,DEBTOR8,0)),U)
 .S RCDFN=+DEBTOR0
 .S DEMCS=$$DEM^RCTCSP1(RCDFN)
 .S DOB=$P(DEMCS,U,2)
 .S GNDR=$P(DEMCS,U) S:"MF"'[GNDR GNDR="U"
 .I $P(DEBTOR7,U,2) I '+$P(DEBTOR7,U,3) D  ;send type 2 recall record
 ..N ACTION,B0,B15,BILL
 ..S ACTION="L"
 ..S B0="",B15="",BILL=0
 ..; The code below is designed to get ONLY one bill #.  It is not a bug! As per VA SME contacts.
 ..F  S BILL=$O(^PRCA(430,"C",DEBTOR,BILL)) Q:BILL'?1N.N  I $D(^PRCA(430,"TCSP",BILL)) I $P(^PRCA(430,BILL,15),U,7)'=1 S B0=$G(^PRCA(430,BILL,0)),B15=$G(^(15)) Q  ;get one bill
 ..I BILL="" S BILL=0 S $P(^RCD(340,DEBTOR,7),U,2,4)="^^",$P(DEBTOR7,U,2,4)="^^" Q  ;cs debtor with no cs bill, clear the debtor recall flag, quit
 ..D REC2
 ..S $P(^RCD(340,DEBTOR,7),U,3)=DT
 ..S DEBTOR7=^RCD(340,DEBTOR,7)
 ..S BILL=0 ;set debtor cross-serviced bills as recalled
 ..F  S BILL=$O(^PRCA(430,"C",DEBTOR,BILL)) Q:BILL'?1N.N  D
 ...D NOW^%DTC S ^XTMP("RCTCSPD",$J,"ZZCRBILL")=%_U_BILL
 ...I $D(^PRCA(430,"TCSP",BILL)) D  Q  ;bill previously sent to TCSP
 ....S $P(^PRCA(430,BILL,15),U)="" ;clear the date referred
 ....S $P(^PRCA(430,BILL,15),U,2)=1 ;set the recall flag
 ....S $P(^PRCA(430,BILL,15),U,3)=DT ;set the recall date
 ....S $P(^PRCA(430,BILL,15),U,4)=$P(DEBTOR7,U,4) ;set the recall reason
 ....S $P(^PRCA(430,BILL,15),U,5)=$$GET1^DIQ(430,BILL,11) ;set the recall amount to the current amount
 ....K ^PRCA(430,"TCSP",BILL) ;kill the cross-servicing cross reference
 ....D RCRSD^RCTCSPD4 ; set debtor recall non-financial transaction PRCA*4.5*315
 .S (BILL,TOTAL,REPAY)=0
RSBILL .F  S BILL=$O(^PRCA(430,"C",DEBTOR,BILL)) Q:BILL'?1N.N  D
 ..I $G(ONEBILL)'="",BILL'=ONEBILL Q  ; Test single bill ; PRCA*4.5*350
 ..D NOW^%DTC S ^XTMP("RCTCSPD",$J,"ZZCTRACKER")=%_U_DEBTOR_U_BILL
 ..N B0,B4,B6,B7,B9,B12,B121,B14,B15,B16,B19,B20,ACTION,RR
 ..S B0=$G(^PRCA(430,BILL,0)),B4=$G(^(4)),B6=$G(^(6)),B7=$G(^(7)),B9=$G(^(9)),B12=$G(^(12)),B121=$G(^(12.1)),B14=$G(^(14)),B15=$G(^(15)),B16=$G(^(16)),B19=$G(^(19)),B20=$G(^(20))
 ..S RR=$$RR^RCTCSPU(BILL) ;PRCA*4.5*350
 ..Q:($P(B6,U,21)\1)<ACTDT  ;cs activation date cutoff
 ..I $D(^PRCA(430,"TCSP",BILL)),$$RCLLCHK^RCTCSP2(BILL) Q  ;bill previously sent to TCSP
 ..I $$UPDCHK(BILL) Q
 ..Q:B4  ;repayment plan
 ..; Do we clear stop flag if RR TBD ; PRCA*4.5*350
 ..I +$P(B15,U,7),RR'=0 Q  ;quit if bill is stopped
 ..Q:+$P(B14,U)  ;bill referred to TOP
 ..Q:$P(DEBTOR1,"^",9)=1  ;quit if debtor address marked unknown
 ..Q:$E($P(DEMCS,U,3),1,5)="00000"  ;quit if the ssn is not valid
 ..Q:DEBTOR8="S"  ;quit if debtor is stopped PRCA*4.5*350
 ..Q:SITE40="S"  ; quit if site is stopped PRCA*4.5*350
 ..I +$P(B12,U,1) Q  ;check date bill sent to dmc
 ..Q:($P(B121,U,1)="N")!($P(B121,U,1)="P")  ;dmc debt valid
 ..I $P(B6,U,4),($P(B6,U,5)="DOJ") Q
 ..Q:+$P(DEMCS,U,4)  ;deceased patient
 ..Q:'$P(B0,U,2)  ;no category
 ..S CAT=$P($G(^PRCA(430.2,$P(B0,U,2),0)),U,7)
 ..Q:'CAT
 ..;PRCA*4.5*338 - Use RFCHK^RCTOPD to determine if the Category can be referred
 ..;               using the new date based algorithm.
 ..Q:'$$RFCHK^RCTOPD(CAT,"N",1.03,$P(B6,U,21))
 ..;end PRCA*4.5*338 ..;dpn checks
 ..I $P(B20,U,3)=1,(10000+$G(^RC(342,1,"CS")))>DT,'$P(B20,U,4) D DUEPROC^RCTCSP3 Q  ;check to send dpn file to aitc
 ..I $P(B20,U,3)=1,(10000+$G(^RC(342,1,"CS")))>DT,$P(B20,U,4),'$P(B20,U,5) Q  ;check for print letter date
 ..I $P(B20,U,3)=1,(10000+$G(^RC(342,1,"CS")))>DT,$P(B20,U,4),$P(B20,U,5) D  I X<60 Q  ;check for 60 day wait from print letter date
 ...N X1,X2
 ...S X1=DT,X2=$P(B20,U,5) D ^%DTC
 ...I X'<60 S $P(B20,U,6)=DT,^PRCA(430,BILL,20)=B20 ;set the bill referral date to the current date
 ..S BILLDT=$P(B6,U),PREPDT=$P(B0,U,10) ; PRCA*4.5*343 - change BILLDT from DATE ACCOUNT ACTIVATED (#60) to LETTER1(#61)
 ..I BILLDT>RC151DT Q  ; PRCA*4.5*343 - Must be 151 days or more after LETTER1 date
 ..I ($P(B0,U,8)=16),('$P(B6,U,3)) D  Q
 ...;no 3rd letter being sent
 ...N DNM
 ...S DNM=$$NAMEFF^RCTCSPRS(+DEBTOR0),^XTMP("RCTCSPD",$J,"THIRD",DNM,$P(B0,U))=""
 ..I $P(B0,U,8)=16 I $$ADDCHKND(BILL) Q
 ..I $P(B0,U,8)=16 I $$ADDCHKNB(BILL) Q
 ..Q
 .Q
 ;
 D NOW^%DTC S ^XTMP("RCTCSPD",$J,"ZZDEND")=%
 D THIRD^RCTCSP2
 D NOW^%DTC S ^XTMP("RCTCSPD",$J,"ZZETRANSMIT CS RECS")=%
 D COMPILE^RCTCSP2 ;compile cross-serviced records
 D NOW^%DTC S ^XTMP("RCTCSPD",$J,"ZZFTRANSMIT DPN")=%
 D COMPILED^RCTCSP3 ;compile the aitc due process notification records
 D NOW^%DTC S ^XTMP("RCTCSPD",$J,"ZZGTRANSMIT FINISHED")=%
 D NOW^%DTC S ^XTMP("RCTCSPD",$J,"ZZHCOMPLETE")=%
 D FINISH^RCTCSPD0
 Q
 ;
ADDCHKND(BILL) ;add a new bill referral, new debtor
 N TOTAL,ACTION,X
 S ACTION="A"
 I $D(^RCD(340,"TCSP",DEBTOR)) Q 0 ;check debtor previously referred
 I $P(DEBTOR7,U,2) Q 0 ;check debtor recall
 I $D(^PRCA(430,"TCSP",BILL)) Q 0 ;bill previously sent to TCSP
 S TOTAL=$P(B7,U)+$P(B7,U,2)+$P(B7,U,3)+$P(B7,U,4)+$P(B7,U,5)
 I TOTAL<25 Q 1 ;no adds for bills less than $25
 I RR=0 D RRMARK^RCTCSPD0 ; PRCA*4.5*350
 I $P(B15,U,7) Q 0 ;check stop tcsp referral flag
 I $P(B15,U,2) Q 0 ;check tcsp bill recall flag
 D REC1,REC2,REC2A
 S $P(^PRCA(430,BILL,16),U,13)=DOB,B16=^(16)
 S $P(^PRCA(430,BILL,15),U,14)=GNDR,B15=^(15)
 D REC2C^RCTCSP7    ;PRCA*4.5*327
 S ADDRCS=$$ADDR^RCTCSP1(RCDFN,1)     ;PRCA*4.5*336
 S $P(^PRCA(430,BILL,16),U,4,8)=$P(ADDRCS,U,1,5),$P(^(16),U,11)=$P(ADDRCS,U,6),$P(^(16),U,12)=$P(ADDRCS,U,7)
 S B16=^PRCA(430,BILL,16)
 D REC3^RCTCSP2
 S TAXID=$$TAXID^RCTCSP1(DEBTOR)
 S NAME=$$NAME^RCTCSP7(+DEBTOR0),NAME=$P(NAME,U)
 S $P(^PRCA(430,BILL,15),U,1)=DT,$P(^(16),U,1)=TAXID,$P(^(16),U,2)=NAME
 S X1=BILLDT,X2=+30 D C^%DTC S DELDT=X
 S $P(^PRCA(430,BILL,16),U,3)=DELDT,^PRCA(430,"TCSP",BILL)=""
 I $P($G(^PRCA(430,BILL,21)),U)="" S $P(^PRCA(430,BILL,21),U)=DT    ;PRCA*4.5*336
 I '$D(^RCD(340,"TCSP",DEBTOR)) S $P(^RCD(340,DEBTOR,7),U,5)=DT,^RCD(340,"TCSP",DEBTOR)=""
 D:RR'=0 NEWDEBTR^RCTCSPD4  D:RR=0 RRSEND^RCTCSPD4 ; set CS new debtor new bill non-financial transaction PRCA*4.5*315
 Q 1
 ;
ADDCHKNB(BILL) ;add a new bill referral, existing debtor
 N TOTAL,ACTION,TAXID,NAME,ADDRCS,X
 I '$D(^RCD(340,"TCSP",DEBTOR)) Q 0 ;check debtor previously referred
 I $D(^PRCA(430,"TCSP",BILL)) Q 0 ;bill previously sent to TCSP
 S TOTAL=$P(B7,U)+$P(B7,U,2)+$P(B7,U,3)+$P(B7,U,4)+$P(B7,U,5)
 I TOTAL<25 Q 0 ;no adds for bills less than $25
 I RR=0 D RRMARK^RCTCSPD0 ; PRCA*4.5*350
 I $P(B15,U,2) Q 0 ;check tcsp bill recall flag
 I $P(B15,U,7) Q 0 ;check stop tcsp referral flag
 S ACTION="A" D REC1
 S ACTION="B" D REC2
 S ACTION="A" D REC3^RCTCSP2
 S TAXID=$$TAXID^RCTCSP1(DEBTOR)
 S NAME=$$NAME^RCTCSP7(+DEBTOR0),NAME=$P(NAME,U)
 S $P(^PRCA(430,BILL,15),U,1)=DT,$P(^(16),U,1)=TAXID,$P(^(16),U,2)=NAME,$P(^(16),U,3)=BILLDT,^PRCA(430,"TCSP",BILL)=""
 I $P($G(^PRCA(430,BILL,21)),U)="" S $P(^PRCA(430,BILL,21),U)=DT    ;PRCA*4.5*336
 S ADDRCS=$$ADDR^RCTCSP1(RCDFN,1)     ;PRCA*4.5*336
 S $P(^PRCA(430,BILL,16),U,4,8)=$P(ADDRCS,U,1,5),$P(^(16),U,11)=$P(ADDRCS,U,6),$P(^(16),U,12)=$P(ADDRCS,U,7)
 S $P(^PRCA(430,BILL,16),U,13)=DOB,B16=^(16)
 S $P(^PRCA(430,BILL,15),U,14)=GNDR,B15=^(15)
 I '$D(^RCD(340,"TCSP",DEBTOR)) S $P(^RCD(340,DEBTOR,7),U,5)=DT,^RCD(340,"TCSP",DEBTOR)=""
 D:RR'=0 DEBTOR^RCTCSPD4 D:RR=0 RRSEND^RCTCSPD4 ; set CS debtor new bill non-financial transaction PRCA*4.5*315, PRCA*4.5*350
 Q 1
 ;
UPDCHK(BILL) ;update 5b or existing bill
 I $P(B15,U,2) Q 0 ;check tcsp bill recall flag
 N TOTAL,TAXID,OTAXID,NAME,ONAME,ADDR,OADDR,ADDRCS,COUNTRY,OCOUNTRY,OPHONE,ODOB,OGNDR,TRNIDX,TRN1,TRN8,TRNAMT,TRNNUM,TRNFLG,FIVBFLG,PRCATTYP
 ;5b check
 S FIVBFLG=0
 S TRNIDX=0 F  S TRNIDX=$O(^PRCA(430,BILL,17,TRNIDX)) Q:+TRNIDX=0  D
 .S TRNNUM=$P($G(^PRCA(430,BILL,17,TRNIDX,0)),U,1),TRNFLG=$P($G(^PRCA(430,BILL,17,TRNIDX,0)),U,2)
 .Q:+TRNFLG=0
 .S TRN1=$G(^PRCA(433,TRNNUM,1)),TRNAMT=$P(TRN1,U,5) S:TRNAMT<0 TRNAMT=-TRNAMT
 .S TRN8=$G(^PRCA(433,TRNNUM,8))
 .S ACTION="U"
 .D REC5B^RCTCSP1
 .S $P(^PRCA(430,BILL,17,TRNIDX,0),U,2)=""
 .S FIVBFLG=1
 ;I '$D(^PRCA(430,BILL,16)) Q 0 ;quit null node 16 old address   ;PRCA*4.5*336
 I $P(B15,U,7) Q 0 ;check stop tcsp referral flag               ;PRCA*4.5*336
 S TOTAL=$P(B7,U)+$P(B7,U,2)+$P(B7,U,3)+$P(B7,U,4)+$P(B7,U,5)
 S (PRCAREST,PRCAREFR)=0
 I FIVBFLG,(TOTAL=0) S DR="151///@",DIE="^PRCA(430,",DA=BILL D ^DIE K DR,DIE,DA
 I $P($G(^PRCA(430,BILL,30)),U) D  S:PRCAREFR PRCAREST=0 Q:PRCAREST 1   ;PRCA*4.5*343
 . S PRCATX=0 F  S PRCATX=$O(^PRCA(433,"C",BILL,PRCATX)) Q:'PRCATX  D
 . . S PRCATTYP=$P($G(^PRCA(433,PRCATX,1)),U,2)
 . . I PRCATTYP=43 S PRCAREST=1,PRCAREFR=0
 . . I PRCATTYP=86!(PRCATTYP=87) S PRCAREFR=1
 . . I PRCATTYP=88 S PRCAREFR=0
 I $D(^PRCA(430,"TCSP",BILL)),$P(B0,U,8)=16,TOTAL'<25 D    ;PRCA*4.5*343
 . I $P(B19,U,1)=1 S ACTION="U" D REC1 S $P(B19,U,1)="" S $P(^PRCA(430,BILL,19),U,1)=""
 . I $P(B19,U,2)=1 S ACTION="U" D REC2 S $P(B19,U,2)="" S $P(^PRCA(430,BILL,19),U,2)=""
 . I $P(B19,U,3)=1 S ACTION="U" D REC2A S $P(B19,U,3)="" S $P(^PRCA(430,BILL,19),U,3)=""
 . I $P(B19,U,4)=1 S ACTION="A" D REC2C^RCTCSP7 S $P(B19,U,4)="" S $P(^PRCA(430,BILL,19),U,4)="" ;PRCA*4.5*327
 I FIVBFLG=1 Q 1 ;if 5b sent, then do not continue to referral check
 I '$D(^PRCA(430,"TCSP",BILL)) Q 0 ;if not cross-serviced, then continue referral check
 S TAXID=$$TAXID^RCTCSP1(DEBTOR)
 I '$D(^PRCA(430,BILL,16)) Q 0 ;quit null node 16 old address   ;PRCA*4.5*343
 S OTAXID=$P(B16,U,1)
 S NAME=$$NAME^RCTCSP7(+DEBTOR0),NAME=$P(NAME,U)
 S ONAME=$P(B16,U,2)
 I $P(B0,U,8)=16,$D(^PRCA(430,"TCSP",BILL)) I (NAME'=ONAME)!(TAXID'=OTAXID) D
 .S ACTION="U"
 .D REC2
 .S $P(^PRCA(430,BILL,16),U,1)=TAXID,$P(^(16),U,2)=NAME,$P(^(19),U,2)="",$P(B19,U,2)=""
 S OADDR=$P(^PRCA(430,BILL,16),U,4,8),OPHONE=$P(^(16),U,11),OCOUNTRY=$P(^(16),U,12)
 S ADDRCS=$$ADDR^RCTCSP1(RCDFN,1),PHONE=$P(ADDRCS,U,6),COUNTRY=$P(ADDRCS,U,7)     ;PRCA*4.5*336
 I $P(DEBTOR1,"^",9)'=1 D  ;if debtor address is not marked unknown, then check address
 .I $P(B0,U,8)=16,$D(^PRCA(430,"TCSP",BILL)) I ($P(ADDRCS,U,1,5)'=$P(OADDR,U,1,5))!(PHONE'=OPHONE)!(COUNTRY'=OCOUNTRY) D
 ..S ACTION="A" ;2c records have action code 'a'
 ..D REC2C^RCTCSP7
 ..S $P(B19,U,4)=""
 ..S $P(^PRCA(430,BILL,16),U,4,8)=$P(ADDRCS,U,1,5),$P(^(16),U,11)=PHONE,$P(^(16),U,12)=$P(ADDRCS,U,7)
 S B16=^PRCA(430,BILL,16)
 S ODOB=$P(^PRCA(430,BILL,16),U,13)
 S OGNDR=$P(^PRCA(430,BILL,15),U,14)
 I $P(B0,U,8)=16,$D(^PRCA(430,"TCSP",BILL)) I (DOB'=ODOB)!(GNDR'=OGNDR) D
 .S ACTION="U"
 .D REC2A
 .S $P(^PRCA(430,BILL,16),U,13)=DOB,B16=^(16)
 .S $P(^PRCA(430,BILL,15),U,14)=GNDR,B15=^(15)
 .Q
 Q 1 ;bill is cross-serviced so do not continue referral check
 ;
REC1 ;record type 1
 N REC,KNUM,DEBTNR,AMTORIG,AMTPBAL,AMTIBAL,AMTABAL,AMTFBAL,AMTCBAL,AMTRFRRD,AMOUNT,DELDT,X,X1,X2,BILLDT,PREPDT
 S REC="C1 "_ACTION_"3636001200"_"DM1D "
 S KNUM=$P($P(B0,U,1),"-",2)
 S DEBTNR=$$AGDEBTID,REC=REC_DEBTNR_" " ; PRCA*4.5*350
 S REC=REC_"I   A MSCC"
 S BILLDT=$P(B6,U,21),PREPDT=$P(B0,U,10)
 S REC=REC_$$DATE8(PREPDT)
 S X1=BILLDT,X2=+30 D C^%DTC S DELDT=X
 S REC=REC_$$DATE8(DELDT)
 S AMTPBAL=$P(B7,U,1) ;principle balance
 S AMTIBAL=$P(B7,U,2) ;interest balance
 S AMTABAL=$P(B7,U,3) ;administrative balance
 S AMTFBAL=$P(B7,U,4) ;marshal fee
 S AMTCBAL=$P(B7,U,5) ;court cost
 S AMTRFRRD=AMTPBAL+AMTIBAL+AMTABAL+AMTFBAL+AMTCBAL
 S AMTORIG=$P(B0,U,3)
 D  ;
 .I ACTION="A" S REC=REC_$$AMOUNT(AMTRFRRD)_$$AMOUNT(AMTRFRRD) Q
 .I ACTION="L" S AMTRFRRD=0 S REC=REC_$$AMOUNT(AMTRFRRD)_$$AMOUNT(AMTRFRRD) Q
 .S REC=REC_$$BLANK(28)
 S REC=REC_"                                             N        "
 S AMOUNT=$$AMOUNT(AMTPBAL)_$$AMOUNT(AMTIBAL)_$$AMOUNT(AMTABAL)_$$AMOUNT(AMTFBAL+AMTCBAL)
 I ACTION="L" S AMOUNT=$$AMOUNT(0)_$$AMOUNT(0)_$$AMOUNT(0)_$$AMOUNT(0) ;by iai spec
 I ACTION="U" S AMOUNT=$$BLANK(56) ;by iai spec
 S REC=REC_AMOUNT
 I ACTION="L" D
 .S REC=REC_$$BLANK(252-$L(REC))
 .S RCD=$P(B15,U,4)
 .S REC=REC_$S(RCD="01":"01",RCD="07":"07",RCD="08":"08",RCD="15":"01",RCD="03":"01",RCD="05":"01",RCD="06":"01",1:"01")
 S REC=REC_$$BLANK(450-$L(REC))
 I ACTION="A" S $P(^PRCA(430,BILL,16),U,9)=AMTRFRRD,$P(^(16),U,10)=AMTRFRRD
 I ACTION="L" S $P(^PRCA(430,BILL,16),U,9)="",$P(^(16),U,10)=""
 S ^XTMP("RCTCSPD",$J,BILL,ACTION,1)=REC
 S ^XTMP("RCTCSPD",$J,"BILL",ACTION,BILL)=$$TAXID^RCTCSP1(DEBTOR)_"^"_+$E(REC,91,102)_"."_$E(REC,103,104) ;sends mailman message of documents sent to user
 D CLR19(BILL,1)
 Q
 ;
REC2 ;
 N REC,KNUM,DEBTNR,DEBTORNB,TAXID,NAME,RCD
 S REC="C2 "_ACTION_"3636001200"_"DM1D "
 S KNUM=$P($P(B0,U,1),"-",2)
 S DEBTNR=$$AGDEBTID,REC=REC_DEBTNR ; PRCA*4.5*350
 S DEBTORNB=$E(SITE,1,3)_$TR($J(DEBTOR,12)," ",0)
 S REC=REC_DEBTORNB
 S TAXID=$$TAXID^RCTCSP1(DEBTOR)
 S REC=REC_TAXID_"SSN"
 S NAME=$$NAME^RCTCSP7(+DEBTOR0),NAME=$P(NAME,U)
 S REC=REC_NAME_$$BLANK(5)_"I"
 I ACTION="L" D
 .S REC=REC_$$BLANK(232-$L(REC))
 .S RCD=$P(B15,U,4)
 .S REC=REC_$S(RCD="01":"12",RCD="07":"12",RCD="08":"12",RCD="15":"12",RCD="03":"03",RCD="05":"05",RCD="06":"06",1:"12")
 S REC=REC_$$BLANK(450-$L(REC))
 S ^XTMP("RCTCSPD",$J,BILL,ACTION,2)=REC
 S $P(^XTMP("RCTCSPD",$J,"BILL",ACTION,BILL),U,1)=$$TAXID^RCTCSP1(DEBTOR)
 D CLR19(BILL,2)
 Q
 ;
REC2A ;
 N REC,KNUM,DEBTNR,DEBTORNB
 S REC="C2A"_ACTION_"3636001200"_"DM1D "
 S KNUM=$P($P(B0,U,1),"-",2)
 S DEBTNR=$$AGDEBTID,REC=REC_DEBTNR ; PRCA*4.5*350
 S DEBTORNB=$E(SITE,1,3)_$TR($J(DEBTOR,12)," ",0)
 S REC=REC_DEBTORNB
 S REC=REC_$$BLANK(3)
 S REC=REC_GNDR
 S REC=REC_$$DATE8($P(DEMCS,U,2))
 S REC=REC_$$BLANK(450-$L(REC))
 S ^XTMP("RCTCSPD",$J,BILL,ACTION,"2A")=REC
 S $P(^XTMP("RCTCSPD",$J,"BILL",ACTION,BILL),U,1)=$$TAXID^RCTCSP1(DEBTOR)
 D CLR19(BILL,3)
 Q
AGDEBTID() ; Return Agency Debt ID accoring to new logic PRCA*4.5*350
 ; Input: SITE,KNUM,BILL,B15
 N TRAIL S TRAIL=$P($G(^PRCA(430,BILL,21)),U,2)
 I TRAIL="" Q $E(SITE,1,3)_$$LJZF(KNUM,7)_$TR($J(BILL,20)," ",0)
 Q $E(SITE,1,3)_$$LJZF(KNUM,7)_$TR($J(BILL,18)," ",0)_TRAIL
 ;
DATE8(X) ;changes fileman date into 8 digit date yyyymmdd
 I +X S X=X+17000000
 S X=$E(X,1,8)
 Q X
 ;
AMOUNT(X) ;changes amount to zero filled, right justified
 S:X<0 X=-X
 S X=$TR($J(X,0,2),".")
 S X=$E("000000000000",1,14-$L(X))_X
 Q X
 ;
BLANK(X) ;returns 'x' blank spaces
 N BLANK
 S BLANK="",$P(BLANK," ",X+1)=""
 Q BLANK
 ;
NOW() ;compiles current date,time
 N X,Y,%,%H
 S %H=$H D YX^%DTC
 Q Y
 ;
RJZF(X,Y) ;right justify zero fill width Y
 S X=$E("000000000000",1,Y-$L(X))_X
 Q X
 ;
LJSF(X,Y) ;x left justified, y space filled
 S X=$E(X,1,Y)
 S X=X_$$BLANK(Y-$L(X))
 Q X
 ;
LJZF(X,Y) ;x left justified, y zero filled
 S X=X_"0000000000"
 S X=$E(X,1,Y)
 Q X
 ;
RECALL(BILL) ; set the recall flag
 S $P(^PRCA(430,BILL,15),U,2)=1
 Q
 ;
CLR19(BILL,X) ; clear the send flag
 S $P(^PRCA(430,BILL,19),U,X)=""
 ;
