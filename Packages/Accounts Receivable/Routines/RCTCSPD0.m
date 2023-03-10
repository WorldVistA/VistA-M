RCTCSPD0 ;ALBANY/RGB - CROSS-SERVICING TRANSMISSION START ;06/15/17 3:34 PM
 ;;4.5;Accounts Receivable;**327,337,350,343**;Mar 20, 1995;Build 59
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRCA*4.5*327 new setup/finish extraction from RCTCSPD and
 ;             modify XTMP file kill to work correctly for
 ;             5 days after Tuesday run.
 ;             Also, send mail message to 'TCSP' mailgroup
 ;             to report any missing/corrupted debtor entries.
 ;
 ;PRCA*4.5*337 Modify the top node of ^XTMP work files
 ;             to have ONLY ^XTMP(namespace,0) to insure
 ;             correct purging outcome.
 ;PRCA*4.5*350 Added RS1 tag to have non-global variables setup
 ;
SETUP ;Entry point from nightly process PRCABJ
 ;
 ;initialize temporary global, variables
 ;
 K ^TMP("RCTCSPD",$J)
 K ^XTMP("RCTCSPD")
 K ^XTMP("RCTCSPDN")
 S ^XTMP("RCTCSPD",0)=$$FMADD^XLFDT(DT,5)_"^"_DT
 S ^XTMP("RCTCSPDN",0)=$$FMADD^XLFDT(DT,5)_"^"_DT
RESTART D NOW^%DTC S ^XTMP("RCTCSPD",$J,"ZZASTART")=%
RS1 S SITE=$E($$SITE^RCMSITE(),1,3),SITECD=$P(^RC(342,1,3),U,5)
 S ACTDT=3150801 ;activation date for all sites except beckley, little rock, upstate ny 
 S:SITE=598 ACTDT=3150201 ;activation date for little rock
 S:SITE=517 ACTDT=3150201 ;activation date for beckley
 S:SITE=528 ACTDT=3150201 ;activation date for upstate ny
 S SITE40=$O(^RC(342,1,40,"A"),-1) I SITE40?1.N S SITE40=$P($G(^RC(342,1,40,SITE40,0)),U)
 S X1=DT,X2=-151 D C^%DTC S RC151DT=X ; PRCA*4.5*343 - change from 150 to 151 days ago, namespace variable
 S X1=DT,X2=+60 D C^%DTC S F60DT=X
 S (CNTR(1),CNTR(2),CNTR("2A"),CNTR("2C"),CNTR(3),CNTR("5A"),CNTR("5B"))=0
 Q
FINISH ;sends mailman message to TCSP mail group to show batch fully completed
 I $D(^XTMP("RCTCSPD",$J,"ZZUNDEF")) D UNDEF
 N XMY,XMDUZ,XMSUB,XMTEXT,BMSG
 S XMDUZ="AR PACKAGE"
 S XMY("G.TCSP")=""
 S XMSUB="*** Batch Completion Notice ***"
 S BMSG(1)="The batch run and transmission completed on "_(17000000+^XTMP("RCTCSPD",$J,"ZZHCOMPLETE"))
 S XMTEXT="BMSG("
 Q:$G(ONEBILL)
 D ^XMD
 K ^TMP("RCTCSPD",$J)
 Q
UNDEF ;send message to mail group for any undefined debtor entries found
 N XMY,XMDUZ,XMSUB,XMTEXT,BMSG,IEN,CTR
 S XMDUZ="AR PACKAGE"
 S XMY("G.TCSP")=""
 S XMSUB="**** FAILED DEBTOR ACTION NOTICE ***"
 S BMSG(1)="The following corrupted debtor records were found during the batch run."
 S BMSG(2)="They can be found in xref ^PRCA(430,_""C""_) and have no file 340 entry or a"
 S BMSG(3)="corrupted entry (missing node 0 or 1)."
 s BMSG(4)=" "
 S BMSG(97)=" "
 S BMSG(98)="*** These corrupt debtor file records must be reported to ***"
 S BMSG(99)="*** region IT staff to be corrected immediately !!        ***"
 S IEN=0,CTR=4 F  S IEN=$O(^XTMP("RCTCSPD",$J,"ZZUNDEF",IEN)) Q:'IEN  D
 . S CTR=CTR+1,BMSG(CTR)="CORRUPT DEBTOR INTERNAL: "_IEN
 S XMTEXT="BMSG("
 Q:$G(ONEBILL)
 D ^XMD
 Q
RSBILCHK(BILL,NOCHK) ; PRCA*4.5*350
 ; Input: BILL - IEN for 430
 ;        NOCHK - Comma separated value 
 ; Output: 1 - bill passed
 ;         0^fail#^message - bill failed^fail number^fail message
 ; *************************************************************************
 ; This is a copy of bill sending logic from RSBILL, except that it only checks if the bill passes or not and doesn't send any messages.
 ; If you are updating RSBILL, please update this as well.   Alternatively, RSBILL can be rewritten.
 ; *************************************************************************
 N B0,B4,B6,B7,B9,B12,B121,B14,B15,B16,B19,B20,ACTION,TOTAL,CAT
 N ACTDT,RC181DT,F60DT,X1,X2,SITE,CNTR,DEBTOR,DEBTOR0,DEBTOR1,DEBTOR3,DEBTOR7,DEBTOR8,RCDFN,DEMCS
 S NOCHK=","_$G(NOCHK)_","
 S B0=$G(^PRCA(430,BILL,0)),B4=$G(^(4)),B6=$G(^(6)),B7=$G(^(7)),B9=$G(^(9)),B12=$G(^(12)),B121=$G(^(12.1)),B14=$G(^(14)),B15=$G(^(15)),B16=$G(^(16)),B19=$G(^(19)),B20=$G(^(20))
 S DEBTOR=$P($G(^PRCA(430,BILL,0)),U,9)
 I 'DEBTOR,NOCHK'[",0," Q "0^0^Bill has no debtor"
 I NOCHK'[",0,",'$D(^RCD(340,DEBTOR,0)) Q "0^0^Bill has bad debtor"
 S DEBTOR0=^RCD(340,DEBTOR,0),DEBTOR1=$G(^(1)),DEBTOR3=$G(^(3)),DEBTOR7=$G(^(7))
 S DEBTOR8=$O(^RCD(340,DEBTOR,8,"A"),-1) I DEBTOR8?1.N S DEBTOR8=$P($G(^RCD(340,DEBTOR,8,DEBTOR8,0)),U)
 D RS1^RCTCSPD0
 S RCDFN=+DEBTOR0
 S DEMCS=$$DEM^RCTCSP1(RCDFN)
 I ($P(B6,U,21)\1)<ACTDT,NOCHK'[",1," Q "0^1^Bill's DATE ACCOUNT ACTIVATED "_$$FMTE^XLFDT($P(B6,U,21),"5D")_" is before site CS activation date" ;cs activation date cutoff
 ;Not needed, we can't quit here.  RCLLCHK sends recalls for recall request bills and <$25 bills.
 ;It could also set 15 fields from 1 to 10
 ;I $D(^PRCA(430,"TCSP",BILL)),$$RCLLCHK^RCTCSP2(BILL) Q  ;bill previously sent to TCSP
 ;This looks to be updates to currently referred bill.  It sends potentially 2, 2A, 2C or 5B, none of which matters for debt.
 ;I $$UPDCHK(BILL) Q
 I +$P(B14,U,1),NOCHK'[",4," Q "0^4^Bill was referred to TOP on "_$$FMTE^XLFDT($P(B14,U),"5D")
 I +$P(B12,U,1),NOCHK'[",7," Q "0^7^DATE SENT TO DMC "_$$FMTE^XLFDT($P(B4,U),"5D")_" is set for the bill"
 I $P(B121,U,1)="N",NOCHK'[",8," Q "0^8^DMC DEBT is not valid"
 I $P(B121,U,1)="P",NOCHK'[",9," Q "0^9^DMC DEBT is pending"
 I $P(B6,U,4),($P(B6,U,5)="DOJ"),NOCHK'[",10," Q "0^10^Bill has been referred to DOJ on "_$$FMTE^XLFDT($P(B6,U,4),"5D")
 I +$P(DEMCS,U,4),NOCHK'[",11," Q "0^11^Debtor is deceased"
 ; Patch PRCA*4.5*338 (and maybe 351) will be replacing logic for errors 12, 13 and 14 with this:
 ;Q:'$$RFCHK^RCTOPD(CAT,"N",1.03,$P(B6,U,21)) ;PRCA*4.5*338 - Use RFCHK^RCTOPD to determine if the Category can be referred using the new date based algorithm.
 I '$P(B0,U,2),NOCHK'[",12," Q "0^12^Bill has no CATEGORY"
 S CAT=$P($G(^PRCA(430.2,$P(B0,U,2),0)),U,7)
 I 'CAT,NOCHK'[",13," Q "0^13^Bill CATEGORY has no CATEGORY NUMBER"
 I '$$RFCHK^RCTOPD(CAT,"N",1.03,$P(B6,U,21)),NOCHK'[",14," Q "0^14^Bill CATEGORY number "_CAT_" is not TCSP referable"
 I B4,NOCHK'[",2," Q "0^2^Bill is on repayment plan started "_$$FMTE^XLFDT($P(B4,U),"5D")
 I +$P(B15,U,7),NOCHK'[",3," Q "0^3^Bill has STOP FLAG set"
 I DEBTOR8="S",NOCHK'[",26," Q "0^26^Debtor has STOP FLAG set" ;quit if debtor is stopped PRCA*4.5*350
 I SITE40="S",NOCHK'[",27," Q "0^27^Site is stopped from sending referrals" ; quit if site is stopped PRCA*4.5*350
 ;dpn checks
 I $P(B20,U,3)=1,(10000+$G(^RC(342,1,"CS")))>DT,'$P(B20,U,4),NOCHK'[",15," Q "0^15^DPN request not made yet"
 I $P(B20,U,3)=1,(10000+$G(^RC(342,1,"CS")))>DT,$P(B20,U,4),'$P(B20,U,5),NOCHK'[",16," Q "0^16^DPN letter is not printed yet"
 I $P(B20,U,3)=1,(10000+$G(^RC(342,1,"CS")))>DT,$P(B20,U,4),$P(B20,U,5) D  I X<60,NOCHK'[",17," Q "0^17^Less than 60 days from DPN letter printed date "_$$FMTE^XLFDT($P(B20,U,5),"5D")
 .N X1,X2
 .S X1=DT,X2=$P(B20,U,5) D ^%DTC
 S BILLDT=$P(B6,U,1),PREPDT=$P(B0,U,10) ; PRCA*4.5*343 - change BILLDT from DATE ACCOUNT ACTIVATED (#60) to LETTER1(#61) field
 I BILLDT>RC151DT,NOCHK'[",18," Q "0^18^Must be 151 days or more after LETTER1 date "_$$FMTE^XLFDT($P(B6,U),"5D") ; PRCA*4.5*343 - change to 151 days
 I $P(DEBTOR1,"^",9)=1,NOCHK'[",5," Q "0^5^Debtor address marked unknown"
 I $E($P(DEMCS,U,3),1,5)="00000",NOCHK'[",6," Q "0^6^SSN "_$P(DEMCS,U,3)_" is not valid"
 I $P(B0,U,8)'=16,NOCHK'[",19," Q "0^19^Bill is not set to ACTIVE"
 ; For rerefer, error 20 is not a showstopper.
 I $P(B15,U,2),NOCHK'[",20," Q "0^20^Bill is marked as recalled"
 ; Note: that is not a showstopper for re-refer, I think, but it is for refer.
 I $D(^PRCA(430,"TCSP",BILL)),NOCHK'[",21," Q "0^21^Bill previously sent to TCSP"
 S TOTAL=$P(B7,U)+$P(B7,U,2)+$P(B7,U,3)+$P(B7,U,4)+$P(B7,U,5)
 I TOTAL<25,NOCHK'[",22," Q "0^22^Bills less than $25 can't be referred"
 I $D(^PRCA(430,"TCSP",BILL)),NOCHK'[",23," Q "0^23^Bill is already referred"
 I '$P(B6,U,3),NOCHK'[",24," Q "0^24^Third Letter has not been sent"
 Q 1
RRMARK ;
 N I
 F I=2,3,4,5,7,8,9,10 S $P(B15,U,I)="",$P(^PRCA(430,BILL,15),U,I)=""
 I $P($G(^PRCA(430,BILL,30)),U) K ^PRCA(430,"AN",$P(^PRCA(430,BILL,30),U),BILL) S $P(^PRCA(430,BILL,30),U)="" S $P(^PRCA(430,BILL,30),U,9)=1
 S I=$O(^PRCA(430,BILL,15.5,99999),-1)
 S $P(^PRCA(430,BILL,15.5,0),U,2)=430.03
 S $P(^PRCA(430,BILL,15.5,0),U,3)=I+1
 S $P(^PRCA(430,BILL,15.5,0),U,4)=$P(^PRCA(430,BILL,15.5,0),U,4)+1
 S ^PRCA(430,BILL,15.5,I+1,0)=1_U_DT_U_$P($G(^PRCA(430,BILL,15.5,I,0)),U,3)
 S ^PRCA(430,BILL,15.5,"B",1,I)=""
 D NEWADI
 Q
NEWADI ;Make new Agency Debt ID trailer PRCA*4.5*350
 N TRAIL,CHK
 S TRAIL=$P($G(^PRCA(430,BILL,21)),U,2)
 I TRAIL="" S TRAIL="AA"
 E  S CHK=($A(TRAIL)-65)*26+($A(TRAIL,2)-65)+1,TRAIL=$C(CHK\26+65)_$C(CHK#26+65)
 S $P(B15,U,15)=TRAIL,$P(^PRCA(430,BILL,21),U,2)=TRAIL
 Q
