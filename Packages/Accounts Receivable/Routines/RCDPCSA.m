RCDPCSA ;UNY/RGB-CROSS-SERVICING STATUS FIX ;03/15/14 3:34 PM
 ;;4.5;Accounts Receivable;**325,336,343**;Mar 20, 1995;Build 59
 ;;Per VA Directive 6402, this routine should not be modified.
 ;OPTION: RCDP TCSP FLAG CONTROL
 ;
 ;PRCA*4.5*336 When setting bills to cross service date
 ;             ensure the TCSP address node ^PRCA(430,ien,16)
 ;             is established
 ;PRCA*4.5*343 Moved Name/taxid lookup into routine since they
 ;             were moved from previous calls into RCTCSPD.
 ;
A S U="^" S SITE=+$$SITE^VASITE
B K DIR S DIR(0)="SO^1:Set cross-service flag on BILL;2:Clear cross-service flag on BILL;3:Clear cross-service flag on DEBTOR (AND ALL BILLS);4:Set cross-service flag on DEBTOR;5:Fully re-establish debtor/bill as cross-serviced"
 S DIR("?")="Enter an option number 1 to 5."
 S DIR("A")="Select Number"
 D ^DIR
 G EXIT:$D(DIRUT)
 S PRCAOPT=+Y
 ;
C ;select bill
 ;  returns -1 for timeout or ^, 0 for no selection, or ien of bill
 K %,%Y,C,DIC,DIR,DIE,DTOUT,DUOUT,X,Y
 K RCY,DIR,DIRUT
 W ! S DIC="^PRCA(430,",DIC(0)="QEAM",DIC("A")="Select BILL: "
 ;  special lookup on input
 S RCBEFLUP=1
 D ^DIC
 I $G(DUOUT)!$G(DTOUT) G B
 I Y<0 G B
 S RCBILLDA=+Y
 ;Disp last 4 soc#
C1 I '$D(^PRCA(430,"TCSP",RCBILLDA)),PRCAOPT=2 W !,"*** BILL NOT CROSS SERVICED ***" G C
 I $P($G(^PRCA(430,RCBILLDA,0)),U,8)'=16 W !,"*** BILL NOT ACTIVE ***" G C
 S RCDEBTOR=$P($G(^PRCA(430,RCBILLDA,0)),U,9) I 'RCDEBTOR W !," < *** debtor not found on bill *** >" G C
 S RCDEBTV=$P($G(^RCD(340,RCDEBTOR,0)),U) I 'RCDEBTV W !," < *** debtor on bill not found *** >" G C
 I RCDEBTV'["DPT(" W !," < *** debtor must be a veteran *** >" G C
 I '$D(^RCD(340,"TCSP",RCDEBTOR)),"245"'[PRCAOPT W !," <debtor not flagged as CS *** >" G C
 S RCDPT=+RCDEBTV,RC0=$G(^DPT(RCDPT,0)) I RC0="" W !," < *** debtor info not found *** >" G C
 W ?60,$E($P(RC0,U,9),6,9)
 D @PRCAOPT
 G C
1 ;option 1
 I $D(^PRCA(430,"TCSP",RCBILLDA)) W !,"*** BILL ALREADY CROSS-SERVICED ***" Q
 S DIR(0)="D",DIR("A")="Enter Cross-Sevice Date" D ^DIR K DIR
 I $D(DIRUT)!($D(DUOUT)) Q
 S RCDATE=Y
 S DIR(0)="YA",DIR("A")="File CS Bill Change (Y/N): ",DIR("B")="N",DIR("?")="Enter (Y)es to file or (N)o to skip filing"
 D ^DIR K DIR I Y=0!$G(DIRUT) W "   < Bill Not Updated >" Q
 S RCDAS=RCBILLDA_",",PRCAR(430,RCDAS,151)=RCDATE D FILE^DIE("EK","PRCAR","PRCAERR") I $D(PRCAERR) W "   <",$G(PRCAERR("DIERR",1,"TEXT",1)),">" K PRCAERR G 1
 D SET16             ;PRCA*4.5*336
 W "  <DONE>"
 Q
2 ;option 2
 I '$D(^PRCA(430,"TCSP",RCBILLDA)) W !,"*** BILL NOT CROSS SERVICED ***" Q
 S DIR(0)="YA",DIR("A")="File CS Bill Flag Removal (Y/N): ",DIR("B")="N",DIR("?")="Enter (Y)es to file or (N)o to skip filing"
 D ^DIR K DIR I Y=0!$G(DIRUT) W "   <Bill Not Updated" Q
 K ^PRCA(430,RCBILLDA,16)
 S DA=RCBILLDA,DIE="^PRCA(430,",DR="151////@" D ^DIE W "  <DONE>"         ;PRCA*4.5*336
 Q
3 ;option 3
 S DIR(0)="YA",DIR("A")="File CS Debtor/Bills Flag Removal (Y/N): ",DIR("B")="N",DIR("?")="Enter (Y)es to file or (N)o to skip filing"
 D ^DIR I Y=0!$G(DIRUT) W "   <Bill Not Updated" Q
 S DA=RCDEBTOR,DIE="^RCD(340,",DR="7.05////@" D ^DIE W "  <DONE>"
 S PRCAIEN=0
 F  S PRCAIEN=$O(^PRCA(430,"C",RCDEBTOR,PRCAIEN)) Q:'PRCAIEN  D
 . I '$D(^PRCA(430,"TCSP",PRCAIEN)) Q
 . S DA=PRCAIEN,DIE="^PRCA(430,",DR="151////@" D ^DIE         ;PRCA*4.5*336
 . K ^PRCA(430,RCBILLDA,16)
 . W !,?4,$P(^PRCA(430,PRCAIEN,0),U),"  Cleared"
 Q
4 ;option 4
 I $D(^RCD(340,"TCSP",RCDEBTOR)) W !,"*** DEBTOR ALREADY CROSS-SERVICED ***" Q
 S DIR(0)="D",DIR("A")="Enter Debtor Cross-Sevice Date" D ^DIR K DIR
 I $D(DIRUT)!($D(DUOUT)) Q
 S RCDATE=Y
 S DIR(0)="YA",DIR("A")="File CS Debtor Change (Y/N): ",DIR("B")="N",DIR("?")="Enter (Y)es to file or (N)o to skip filing"
 D ^DIR K DIR I Y=0!$G(DIRUT) W "   < Debtor Not Updated >" Q
 S RCDAS=RCDEBTOR_",",RCDR(340,RCDAS,7.05)=RCDATE D FILE^DIE("EK","RCDR","RCDERR") I $D(RCDERR) W "   <",$G(RCDERR("DIERR",1,"TEXT",1)),">" K RCDERR G 4
 W "  <DONE>"
 Q
5 ;option 5
 I $D(^PRCA(430,"TCSP",RCBILLDA)) W !,"*** BILL ALREADY CROSS-SERVICED, DEBTOR MUST BE ALSO ***" Q
 I $D(^RCD(340,"TCSP",RCDEBTOR)) W !,"*** DEBTOR ALREADY CROSS-SERVICED, USE OPTION 1 TO SET BILL ***" Q
 I $D(^PRCA(430,RCBILLDA,30)) W !,"*** BILL RETURNED BY RECONCILIATION ***" Q
 S DIR(0)="D",DIR("A")="Enter Debtor Cross-Sevice Date" D ^DIR K DIR Q:$G(DIRUT)
 S RCDATE=Y
 S DIR(0)="YA",DIR("A")="File CS Debtor/Bill Change (Y/N): ",DIR("B")="N",DIR("?")="Enter (Y)es to file or (N)o to skip filing"
 D ^DIR K DIR I Y=0!$G(DIRUT) W "   < Debtor Not Updated >" Q
 S RCDAS=RCDEBTOR_",",RCDR(340,RCDAS,7.05)=RCDATE D FILE^DIE("EK","RCDR","RCDERR") I $D(RCDERR) W "   <",$G(RCDERR("DIERR",1,"TEXT",1)),">" K RCDERR G 5
 S ^PRCA(430,RCBILLDA,15)="",DA=RCBILLDA,DIE="^PRCA(430,",DR="151////^S X=RCDATE" D ^DIE
 D SET16              ;PRCA*4.5*336
 W "  <DONE>",!,">>> Bill Updating for CS info... "
 W "fully re-established as Cross-Serviced >"
 Q
 ;
SET16 ;SET NODE 16 FOR TCSP BILL     ;PRCA*4.5*336
 N RCXX,RCYY
 S (RCDEBTR0,DEBTOR0)=$G(^RCD(340,RCDEBTOR,0)),DEBTOR1=$G(^RCD(340,RCDEBTOR,1)),RCDFN=+RCDEBTR0
 S RCDPN16="",RCB6=$G(^PRCA(430,RCBILLDA,6)),RCB7=$G(^(7)),RCBILLDT=$P($P(RCB6,U,21),".")
 S TAXID=$$TAXID(RCDEBTOR),RCNAME=$$NAME(+RCDEBTR0),RCNAME=$P(RCNAME,U)
 S $P(RCDPN16,U)=TAXID,$P(RCDPN16,U,2)=RCNAME,$P(RCDPN16,U,3)=+RCBILLDT
 S DEBTOR=RCDEBTOR,ADDRCS=$$ADDR^RCTCSP1(RCDFN,1),$P(RCDPN16,U,4,8)=$P(ADDRCS,U,1,5)
 S $P(RCDPN16,U,12)=$S($P(ADDRCS,U,7)>2:$P(ADDRCS,U,7),+^PRCA(430,RCBILLDA,0)=436:2,1:1),$P(RCDPN16,U,13)=$P(^DPT(RCDFN,0),U,3)
 S RCAMTRFD=0 F I=1:1:5 S RCAMTRFD=RCAMTRFD+$P(RCB7,U,I)
 F I=9,10 S $P(RCDPN16,U,I)=RCAMTRFD
 S (RCXX,RCYY)=$P(ADDRCS,U,6)
 I RCXX'?10N D
 . S RCYY="" F I=1:1:$L(RCXX) I $E(RCXX,I)?1N S RCYY=RCYY_$E(RCXX,I)
 S $P(RCDPN16,U,11)=$E("000000000000",1,10-$L(RCYY))_RCYY
 S ^PRCA(430,RCBILLDA,16)=RCDPN16
 Q
 ;
TAXID(DEBTOR) ;computes TAXID to place on documents   ;PRCA*4.5*343
 N TAXID,DIC,DA,DR,DIQ
 S TAXID=$$SSN^RCFN01(DEBTOR)
 S TAXID=$$LJSF(TAXID,9)
 Q TAXID
 ;
NAME(DFN) ;returns name for document and name in file   ;PRCA*4.5*343
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
LJSF(X,Y) ;left justified space filled
 S X=$E(X,1,Y)
 S X=X_$$BLANK(Y-$L(X))
 Q X
 ;
BLANK(X) ;returns 'x' blank spaces
 N BLANK
 S BLANK="",$P(BLANK," ",X+1)=""
 Q BLANK
 ;
EXIT D KILL^XUSCLEAN Q
