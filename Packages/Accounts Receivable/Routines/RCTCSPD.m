RCTCSPD ;ALBANY/BDB-CROSS-SERVICING TRANSMISSION ;03/15/14 3:34 PM
 ;;4.5;Accounts Receivable;**301**;Mar 20, 1995;Build 144
 ;;Per VA Directive 6402, this routine should not be modified.
ENTER ;Entry point from nightly process PRCABJ
 N DEBTOR,P150DT,PRIN,INT,ADMIN,TDEB,TFIL
 N RCDFN,CNTR,SITE,LN,FN,MN,SITE,F60DT,VADM
 N PHONE,QUIT,TOTAL,ZIPCODE,FULLNM,RCNT,REPAY,X1,X2
 N ERROR,ADDR,CAT,BILLDT,CURRTOT,SITECD
 N SEQ,CNTLID,PREPDT,X1,X2,X,DELDT,ACTDT
 ;
 ;initialize temporary global, variables
 ;
 K ^TMP("RCTCSPD",$J)
 K ^XTMP("RCTCSPD",$J)
 K ^XTMP("RCTCSPDN",$J)
 S ^XTMP("RCTCSPD",0)=$$FMADD^XLFDT(DT,3)_"^"_DT
 S ^XTMP("RCTCSPDN",0)=$$FMADD^XLFDT(DT,3)_"^"_DT
 S SITE=$E($$SITE^RCMSITE(),1,3),SITECD=$P(^RC(342,1,3),U,5)
 S ACTDT=3150801 ;activation date for all sites except beckley, little rock, upstate ny 
 S:SITE=598 ACTDT=3150201 ;activation date for little rock
 S:SITE=517 ACTDT=3150201 ;activation date for beckley
 S:SITE=528 ACTDT=3150201 ;activation date for upstate ny
 S X1=DT,X2=-150 D C^%DTC S P150DT=X
 S X1=DT,X2=+60 D C^%DTC S F60DT=X
 S (CNTR(1),CNTR(2),CNTR("2A"),CNTR("2C"),CNTR(3),CNTR("5A"),CNTR("5B"))=0
 S (DEBTOR,RCNT)=0,SEQ=0
 ;
 F  S DEBTOR=$O(^PRCA(430,"C",DEBTOR)) Q:DEBTOR'?1N.N  D
 .N X,RCDFN,DEMCS,DOB,GNDR,DEBTOR0,DEBTOR1,DEBTOR3,DEBTOR7,BILL
 .S DEBTOR0=^RCD(340,DEBTOR,0),DEBTOR1=$G(^(1)),DEBTOR3=$G(^(3)),DEBTOR7=$G(^(7))
 .S RCDFN=+DEBTOR0
 .S DEMCS=$$DEM^RCTCSP1(RCDFN)
 .S DOB=$P(DEMCS,U,2)
 .S GNDR=$P(DEMCS,U,1) S:"MF"'[GNDR GNDR="U"
 .I $P(DEBTOR7,U,2) I '+$P(DEBTOR7,U,3) D  ;send type 2 recall record
 ..N ACTION,B0,B15,BILL
 ..S ACTION="L"
 ..S B0="",B15="",BILL=0
 ..F  S BILL=$O(^PRCA(430,"C",DEBTOR,BILL)) Q:BILL'?1N.N  I $D(^PRCA(430,"TCSP",BILL)) I $P(^PRCA(430,BILL,15),U,7)'=1 S B0=$G(^PRCA(430,BILL,0)),B15=$G(^(15)) Q  ;get one bill
 ..I BILL="" S BILL=0 S $P(^RCD(340,DEBTOR,7),U,2,4)="^^",$P(DEBTOR7,U,2,4)="^^" Q  ;cs debtor with no cs bill, clear the debtor recall flag, quit
 ..D REC2
 ..S $P(^RCD(340,DEBTOR,7),U,3)=DT
 ..S DEBTOR7=^RCD(340,DEBTOR,7)
 ..S BILL=0 ;set debtor cross-serviced bills as recalled
 ..F  S BILL=$O(^PRCA(430,"C",DEBTOR,BILL)) Q:BILL'?1N.N  D
 ...I $D(^PRCA(430,"TCSP",BILL)) D  Q  ;bill previously sent to TCSP
 ....S $P(^PRCA(430,BILL,15),U,1)="" ;clear the date referred
 ....S $P(^PRCA(430,BILL,15),U,2)=1 ;set the recall flag
 ....S $P(^PRCA(430,BILL,15),U,3)=DT ;set the recall date
 ....S $P(^PRCA(430,BILL,15),U,4)=$P(DEBTOR7,U,4) ;set the recall reason
 ....S $P(^PRCA(430,BILL,15),U,5)=$$GET1^DIQ(430,BILL,11) ;set the recall amount to the current amount
 ....K ^PRCA(430,"TCSP",BILL) ;set the bill to not sent to cross-servicing
 .S (BILL,TOTAL,REPAY)=0
 .F  S BILL=$O(^PRCA(430,"C",DEBTOR,BILL)) Q:BILL'?1N.N  D
 ..N B0,B4,B6,B7,B9,B12,B121,B14,B15,B16,B19,B20,ACTION
 ..S B0=$G(^PRCA(430,BILL,0)),B4=$G(^(4)),B6=$G(^(6)),B7=$G(^(7)),B9=$G(^(9)),B12=$G(^(12)),B121=$G(^(12.1)),B14=$G(^(14)),B15=$G(^(15)),B16=$G(^(16)),B19=$G(^(19)),B20=$G(^(20))
 ..Q:($P(B6,U,21)\1)<ACTDT  ;cs activation date cutoff
 ..I $D(^PRCA(430,"TCSP",BILL)),$$RCLLCHK^RCTCSP2(BILL) Q  ;bill previously sent to TCSP
 ..I $$UPDCHK(BILL) Q
 ..Q:B4  ;repayment plan
 ..Q:+$P(B15,U,7)  ;quit if bill is stopped
 ..Q:+$P(B14,U,1)  ;bill referred to TOP
 ..Q:$P(DEBTOR1,"^",9)=1  ;quit if debtor address marked unknown
 ..Q:$E($P(DEMCS,U,3),1,5)="00000"  ;quit if the ssn is not valid
 ..I +$P(B12,U,1) Q  ;check date bill sent to dmc
 ..Q:($P(B121,U,1)="N")!($P(B121,U,1)="P")  ;dmc debt valid
 ..I $P(B6,U,4),($P(B6,U,5)="DOJ") Q
 ..Q:+$P(DEMCS,U,4)  ;deceased patient
 ..Q:'$P(B0,U,2)  ;no category
 ..S CAT=$P($G(^PRCA(430.2,$P(B0,U,2),0)),U,7)
 ..Q:'CAT
 ..I ",4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,25,26,27,28,33,34,35,36,37,38,39,"[(","_CAT_",") Q
 ..;dpn checks
 ..I $P(B20,U,3)=1,(10000+$G(^RC(342,1,"CS")))>DT,'$P(B20,U,4) D DUEPROC^RCTCSP3 Q  ;check to send dpn file to aitc
 ..I $P(B20,U,3)=1,(10000+$G(^RC(342,1,"CS")))>DT,$P(B20,U,4),'$P(B20,U,5) Q  ;check for print letter date
 ..I $P(B20,U,3)=1,(10000+$G(^RC(342,1,"CS")))>DT,$P(B20,U,4),$P(B20,U,5) D  I X<60 Q  ;check for 60 day wait from print letter date
 ...N X1,X2
 ...S X1=DT,X2=$P(B20,U,5) D ^%DTC
 ...I X'<60 S $P(B20,U,6)=DT,^PRCA(430,BILL,20)=B20 ;set the bill referral date to the current date
 ..S BILLDT=$P(B6,U,21),PREPDT=$P(B0,U,10)
 ..I BILLDT>P150DT Q  ;150 day old check
 ..I ($P(B0,U,8)=16),('$P(B6,U,3)) D  Q
 ...;no 3rd letter being sent
 ...N DNM
 ...S DNM=$$NAMEFF(+DEBTOR0),^XTMP("RCTCSPD",$J,"THIRD",DNM,$P(B0,U))=""
 ..I $P(B0,U,8)=16 I $$ADDCHKND(BILL) Q
 ..I $P(B0,U,8)=16 I $$ADDCHKNB(BILL) Q
 ..Q
 .Q
 ;
 D THIRD^RCTCSP2
 D COMPILE^RCTCSP2 ;compile cross-serviced records
 D COMPILED^RCTCSP3 ;compile the aitc due process notification records
 Q
 ;
ADDCHKND(BILL) ;add a new bill referral, new debtor
 N TOTAL,ACTION,X
 S ACTION="A"
 I $D(^RCD(340,"TCSP",DEBTOR)) Q 0 ;check debtor previously referred
 I $P(B15,U,2) Q 0 ;check tcsp bill recall flag
 I $P(DEBTOR7,U,2) Q 0 ;check debtor recall
 I $P(B15,U,7) Q 0 ;check stop tcsp referral flag
 I $D(^PRCA(430,"TCSP",BILL)) Q 0 ;bill previously sent to TCSP
 S TOTAL=$P(B7,U)+$P(B7,U,2)+$P(B7,U,3)+$P(B7,U,4)+$P(B7,U,5)
 I TOTAL<25 Q 1 ;no adds for bills less than $25
 D REC1
 D REC2
 D REC2A
 S $P(^PRCA(430,BILL,16),U,13)=DOB,B16=^(16)
 S $P(^PRCA(430,BILL,15),U,14)=GNDR,B15=^(15)
 D REC2C
 S ADDRCS=$$ADDR^RCTCSP1(RCDFN)
 S $P(^PRCA(430,BILL,16),U,4,8)=$P(ADDRCS,U,1,5),$P(^(16),U,11)=$P(ADDRCS,U,6),$P(^(16),U,12)=$P(ADDRCS,U,7)
 S B16=^PRCA(430,BILL,16)
 D REC3^RCTCSP2
 S TAXID=$$TAXID(DEBTOR)
 S NAME=$$NAME(+DEBTOR0),NAME=$P(NAME,U)
 S $P(^PRCA(430,BILL,15),U,1)=DT,$P(^(16),U,1)=TAXID,$P(^(16),U,2)=NAME
 S X1=BILLDT,X2=+30 D C^%DTC S DELDT=X
 S $P(^PRCA(430,BILL,16),U,3)=DELDT,^PRCA(430,"TCSP",BILL)=""
 I '$D(^RCD(340,"TCSP",DEBTOR)) S $P(^RCD(340,DEBTOR,7),U,5)=DT,^RCD(340,"TCSP",DEBTOR)=""
 Q 1
 ;
ADDCHKNB(BILL) ;add a new bill referral, existing debtor
 N TOTAL,ACTION,TAXID,NAME,ADDRCS,X
 I '$D(^RCD(340,"TCSP",DEBTOR)) Q 0 ;check debtor previously referred
 I $P(B15,U,2) Q 0 ;check tcsp bill recall flag
 I $P(B15,U,7) Q 0 ;check stop tcsp referral flag
 I $D(^PRCA(430,"TCSP",BILL)) Q 0 ;bill previously sent to TCSP
 S TOTAL=$P(B7,U)+$P(B7,U,2)+$P(B7,U,3)+$P(B7,U,4)+$P(B7,U,5)
 I TOTAL<25 Q 0 ;no adds for bills less than $25
 S ACTION="A" D REC1
 S ACTION="B" D REC2
 S ACTION="A" D REC3^RCTCSP2
 S TAXID=$$TAXID(DEBTOR)
 S NAME=$$NAME(+DEBTOR0),NAME=$P(NAME,U)
 S $P(^PRCA(430,BILL,15),U,1)=DT,$P(^(16),U,1)=TAXID,$P(^(16),U,2)=NAME,$P(^(16),U,3)=BILLDT,^PRCA(430,"TCSP",BILL)=""
 S ADDRCS=$$ADDR^RCTCSP1(RCDFN)
 S $P(^PRCA(430,BILL,16),U,4,8)=$P(ADDRCS,U,1,5),$P(^(16),U,11)=$P(ADDRCS,U,6),$P(^(16),U,12)=$P(ADDRCS,U,7)
 S $P(^PRCA(430,BILL,16),U,13)=DOB,B16=^(16)
 S $P(^PRCA(430,BILL,15),U,14)=GNDR,B15=^(15)
 I '$D(^RCD(340,"TCSP",DEBTOR)) S $P(^RCD(340,DEBTOR,7),U,5)=DT,^RCD(340,"TCSP",DEBTOR)=""
 Q 1
 ;
UPDCHK(BILL) ;update 5b or existing bill
 I '$D(^PRCA(430,BILL,16)) Q 0 ;quit null node 16 old address
 N TOTAL,TAXID,OTAXID,NAME,ONAME,ADDR,OADDR,ADDRCS,COUNTRY,OCOUNTRY,OPHONE
 N ODOB,OGNDR
 N TRNIDX,TRN1,TRN8,TRNAMT,TRNNUM,TRNFLG,FIVBFLG
 I $P(B15,U,2) Q 0 ;check tcsp bill recall flag
 I $P(B15,U,7) Q 0 ;check stop tcsp referral flag
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
 S TOTAL=$P(B7,U)+$P(B7,U,2)+$P(B7,U,3)+$P(B7,U,4)+$P(B7,U,5)
 I FIVBFLG,(TOTAL=0) S DR="151///@",DIE="^PRCA(430,",DA=BILL D ^DIE K DR,DIE,DA
 I $P(B19,U,1)=1 S ACTION="U" D REC1 S $P(B19,U,1)="" S $P(^PRCA(430,BILL,19),U,1)=""
 I $P(B19,U,2)=1 S ACTION="U" D REC2 S $P(B19,U,2)="" S $P(^PRCA(430,BILL,19),U,2)=""
 I $P(B19,U,3)=1 S ACTION="U" D REC2A S $P(B19,U,3)="" S $P(^PRCA(430,BILL,19),U,3)=""
 I $P(B19,U,4)=1 S ACTION="A" D REC2C S $P(B19,U,4)="" S $P(^PRCA(430,BILL,19),U,4)=""
 I FIVBFLG=1 Q 1 ;if 5b sent, then do not continue to referral check
 I '$D(^PRCA(430,"TCSP",BILL)) Q 0 ;if not cross-serviced, then continue referral check
 S TAXID=$$TAXID(DEBTOR)
 S OTAXID=$P(B16,U,1)
 S NAME=$$NAME(+DEBTOR0),NAME=$P(NAME,U)
 S ONAME=$P(B16,U,2)
 I $P(B0,U,8)=16,$D(^PRCA(430,"TCSP",BILL)) I (NAME'=ONAME)!(TAXID'=OTAXID) D
 .S ACTION="U"
 .D REC2
 .S $P(^PRCA(430,BILL,16),U,1)=TAXID,$P(^(16),U,2)=NAME,$P(^(19),U,2)="",$P(B19,U,2)=""
 S OADDR=$P(^PRCA(430,BILL,16),U,4,8),OPHONE=$P(^(16),U,11),OCOUNTRY=$P(^(16),U,12)
 S ADDRCS=$$ADDR^RCTCSP1(RCDFN),PHONE=$P(ADDRCS,U,6),COUNTRY=$P(ADDRCS,U,7)
 I $P(DEBTOR1,"^",9)'=1 D  ;if debtor address is not marked unknown, then check address
 .I $P(B0,U,8)=16,$D(^PRCA(430,"TCSP",BILL)) I ($P(ADDRCS,U,1,5)'=$P(OADDR,U,1,5))!(PHONE'=OPHONE)!(COUNTRY'=OCOUNTRY) D
 ..S ACTION="A" ;2c records have action code 'a'
 ..D REC2C
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
 S DEBTNR=$E(SITE,1,3)_$$LJZF(KNUM,7)_$TR($J(BILL,20)," ",0),REC=REC_DEBTNR_" "
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
 S ^XTMP("RCTCSPD",$J,"BILL",ACTION,BILL)=$$TAXID(DEBTOR)_"^"_+$E(REC,91,102)_"."_$E(REC,103,104) ;sends mailman message of documents sent to user
 D CLR19(BILL,1)
 Q
 ;
REC2 ;
 N REC,KNUM,DEBTNR,DEBTORNB,TAXID,NAME,RCD
 S REC="C2 "_ACTION_"3636001200"_"DM1D "
 S KNUM=$P($P(B0,U,1),"-",2)
 S DEBTNR=$E(SITE,1,3)_$$LJZF(KNUM,7)_$TR($J(BILL,20)," ",0),REC=REC_DEBTNR
 S DEBTORNB=$E(SITE,1,3)_$TR($J(DEBTOR,12)," ",0)
 S REC=REC_DEBTORNB
 S TAXID=$$TAXID(DEBTOR)
 S REC=REC_TAXID_"SSN"
 S NAME=$$NAME(+DEBTOR0),NAME=$P(NAME,U)
 S REC=REC_NAME_$$BLANK(5)_"I"
 I ACTION="L" D
 .S REC=REC_$$BLANK(232-$L(REC))
 .S RCD=$P(B15,U,4)
 .S REC=REC_$S(RCD="01":"12",RCD="07":"12",RCD="08":"12",RCD="15":"12",RCD="03":"03",RCD="05":"05",RCD="06":"06",1:"12")
 S REC=REC_$$BLANK(450-$L(REC))
 S ^XTMP("RCTCSPD",$J,BILL,ACTION,2)=REC
 S $P(^XTMP("RCTCSPD",$J,"BILL",ACTION,BILL),U,1)=$$TAXID(DEBTOR)
 D CLR19(BILL,2)
 Q
 ;
REC2A ;
 N REC,KNUM,DEBTNR,DEBTORNB
 S REC="C2A"_ACTION_"3636001200"_"DM1D "
 S KNUM=$P($P(B0,U,1),"-",2)
 S DEBTNR=$E(SITE,1,3)_$$LJZF(KNUM,7)_$TR($J(BILL,20)," ",0),REC=REC_DEBTNR
 S DEBTORNB=$E(SITE,1,3)_$TR($J(DEBTOR,12)," ",0)
 S REC=REC_DEBTORNB
 S REC=REC_$$BLANK(3)
 S REC=REC_GNDR
 S REC=REC_$$DATE8($P(DEMCS,U,2))
 S REC=REC_$$BLANK(450-$L(REC))
 S ^XTMP("RCTCSPD",$J,BILL,ACTION,"2A")=REC
 S $P(^XTMP("RCTCSPD",$J,"BILL",ACTION,BILL),U,1)=$$TAXID(DEBTOR)
 D CLR19(BILL,3)
 Q
 ;
REC2C ;
 N REC,KNUM,DEBTNR,DEBTORNB,TAXID,RCDFN,PHONE,ADDRCS
 S REC="C2C"_ACTION_"3636001200"_"DM1D "
 S KNUM=$P($P(B0,U,1),"-",2)
 S DEBTNR=$E(SITE,1,3)_$$LJZF(KNUM,7)_$TR($J(BILL,20)," ",0),REC=REC_DEBTNR
 S DEBTORNB=$E(SITE,1,3)_$TR($J(DEBTOR,12)," ",0)
 S REC=REC_DEBTORNB
 S TAXID=$$TAXID(DEBTOR)
 S REC=REC_TAXID
 S REC=REC_"SLFIND"
 S REC=REC_$$BLANK(20)
 S RCDFN=+DEBTOR0
 S REC=REC_$$LJSF($$NAMEFF(RCDFN),60)_"Y"
 S ADDRCS=$$ADDR^RCTCSP1(RCDFN),PHONE=$P(ADDRCS,U,6)
 S REC=REC_$$LJSF($P(ADDRCS,U,1),35)_$$LJSF($P(ADDRCS,U,2),35)_$$LJSF($P(ADDRCS,U,3),15)_$$LJSF($P(ADDRCS,U,4),2)_$$LJSF($P(ADDRCS,U,5),9)
 S REC=REC_$$COUNTRY^RCTCSP1($P(ADDRCS,U,7))
 S REC=REC_"Y"
 S REC=REC_$S(PHONE]"":"P",1:" ")
 S REC=REC_$$LJSF($TR(PHONE,"() -"),10)_$$BLANK(4)
 S REC=REC_$S(PHONE]"":"Y",1:" ")
 S REC=REC_$$BLANK(450-$L(REC))
 S ^XTMP("RCTCSPD",$J,BILL,ACTION,"2C")=REC
 S $P(^XTMP("RCTCSPD",$J,"BILL",ACTION,BILL),U,1)=$$TAXID(DEBTOR)
 D CLR19(BILL,4)
 Q
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
NAME(DFN) ;returns name for document and name in file
 N FN,LN,MN,NM,DOCNM,VA,VADM
 S NM=""
 D DEM^VADPT
 I $D(VADM) S NM=VADM(1)
 S LN=$TR($P(NM,",")," .'-"),MN=$P($P(NM,",",2)," ",2)
 I ($E(MN,1,2)="SR")!($E(MN,1,2)="JR")!(MN?2.3"I")!(MN?0.1"I"1"V"1.3"I") S MN=""
 S FN=$P($P(NM,",",2)," ")
 S DOCNM=$$LJ^XLFSTR($E(LN,1,35),35)_$$LJ^XLFSTR($E(FN,1,35),35)_$$LJ^XLFSTR($E(MN,1,35),35)
 Q DOCNM
 ;
NAMEFF(DFN) ;returns name for document and name in file
 N FN,LN,MN,NM,DOCNM,VA,VADM
 S NM=""
 D DEM^VADPT
 I $D(VADM) S NM=VADM(1)
 S LN=$TR($P(NM,",")," .'-"),MN=$P($P(NM,",",2)," ",2)
 I ($E(MN,1,2)="SR")!($E(MN,1,2)="JR")!(MN?2.3"I")!(MN?0.1"I"1"V"1.3"I") S MN=""
 S FN=$P($P(NM,",",2)," ")
 S DOCNM=LN_" "_FN_" "_MN
 Q DOCNM
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
TAXID(DEBTOR) ;computes TAXID to place on documents
 N TAXID,DIC,DA,DR,DIQ
 S TAXID=$$SSN^RCFN01(DEBTOR)
 S TAXID=$$LJSF(TAXID,9)
 Q TAXID
 ;
LJSF(X,Y) ;x left justified, y space filled
 S X=$E(X,1,Y)
 S X=X_$$BLANK(Y-$L(X))
 Q X
 ;
LJZF(X,Y) ;x left justified, y zero filled
 S X=X_"0000000000"
 S X=$E(X,X,Y)
 Q X
 ;
RECALL(BILL) ; set the recall flag
 S $P(^PRCA(430,BILL,15),U,2)=1
 Q
 ;
CLR19(BILL,X) ; clear the send flag
 S $P(^PRCA(430,BILL,19),U,X)=""
 ;
