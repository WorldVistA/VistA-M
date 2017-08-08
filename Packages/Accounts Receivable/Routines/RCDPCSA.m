RCDPCSA ;UNY/RGB-CROSS-SERVICING STATUS FIX ;03/15/14 3:34 PM
 ;;4.5;Accounts Receivable;**325**;Mar 20, 1995;Build 15
 ;OPTION: RCDP TCSP FLAG CONTROL
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
 W "  <DONE>"
 Q
2 ;option 2
 I '$D(^PRCA(430,"TCSP",RCBILLDA)) W !,"*** BILL NOT CROSS SERVICED ***" Q
 S DIR(0)="YA",DIR("A")="File CS Bill Flag Removal (Y/N): ",DIR("B")="N",DIR("?")="Enter (Y)es to file or (N)o to skip filing"
 D ^DIR K DIR I Y=0!$G(DIRUT) W "   <Bill Not Updated" Q
 S DA=RCBILLDA,DIE="^PRCA(430,",DR="151////@" D ^DIE K DIE W "  <DONE>"
 Q
3 ;option 3
 S DIR(0)="YA",DIR("A")="File CS Debtor/Bills Flag Removal (Y/N): ",DIR("B")="N",DIR("?")="Enter (Y)es to file or (N)o to skip filing"
 D ^DIR I Y=0!$G(DIRUT) W "   <Bill Not Updated" Q
 S DA=RCDEBTOR,DIE="^RCD(340,",DR="7.05////@" D ^DIE W "  <DONE>"
 S PRCAIEN=0
 F  S PRCAIEN=$O(^PRCA(430,"C",RCDEBTOR,PRCAIEN)) Q:'PRCAIEN  D
 . I '$D(^PRCA(430,"TCSP",PRCAIEN)) Q
 . S DA=PRCAIEN,DIE="^PRCA(430,",DR="151////@" D ^DIE
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
 S DIR(0)="D",DIR("A")="Enter Debtor Cross-Sevice Date" D ^DIR K DIR
 I $G(DIRUT) Q
 S RCDATE=Y
 S DIR(0)="YA",DIR("A")="File CS Debtor/Bill Change (Y/N): ",DIR("B")="N",DIR("?")="Enter (Y)es to file or (N)o to skip filing"
 D ^DIR K DIR I Y=0!$G(DIRUT) W "   < Debtor Not Updated >" Q
 S RCDAS=RCDEBTOR_",",RCDR(340,RCDAS,7.05)=RCDATE D FILE^DIE("EK","RCDR","RCDERR") I $D(RCDERR) W "   <",$G(RCDERR("DIERR",1,"TEXT",1)),">" K RCDERR G 5
 W "  <DONE>",!,">>> Bill Updating for CS info... "
 S RCDEBTR0=$G(^RCD(340,RCDEBTOR,0)),RCDEBTR1=$G(^RCD(340,RCDEBTOR,1)),RCDFN=+RCDEBTR0
 S ^PRCA(430,RCBILLDA,15)="",^PRCA(430,RCBILLDA,16)="",RCB6=$G(^PRCA(430,RCBILLDA,6)),RCB7=$G(^(7)),RCBILLDT=$P(RCB6,U,21)
 S TAXID=$$TAXID^RCTCSPD(RCDEBTOR),RCNAME=$$NAME^RCTCSPD(+RCDEBTR0),RCNAME=$P(RCNAME,U)
 S $P(^PRCA(430,RCBILLDA,15),U,1)=RCDATE,$P(^(16),U,1)=TAXID,$P(^(16),U,2)=RCNAME,$P(^(16),U,3)=RCBILLDT,^PRCA(430,"TCSP",RCBILLDA)=""
 S ADDRCS=$$ADDR(RCDFN),$P(^PRCA(430,RCBILLDA,16),U,4,8)=$P(ADDRCS,U,1,5),$P(^(16),U,11)=$P(ADDRCS,U,6),$P(^(16),U,12)=$P(ADDRCS,U,7)
 S RCDEMCS=$$DEM^RCTCSP1(RCDFN),RCDOB=$P(RCDEMCS,U,2),RCGNDR=$P(RCDEMCS,U,1) S:"MF"'[RCGNDR RCGNDR="U"
 S $P(^PRCA(430,RCBILLDA,16),U,13)=RCDOB,$P(^PRCA(430,RCBILLDA,16),U,14)=RCGNDR,RCAMTPBL=$P(RCB7,U,1),RCAMTIBL=$P(RCB7,U,2),RCAMTABL=$P(RCB7,U,3),RCAMTFBL=$P(RCB7,U,4),RCAMTCBL=$P(RCB7,U,5)
 S RCAMTRFD=RCAMTPBL+RCAMTIBL+RCAMTABL+RCAMTFBL+RCAMTCBL,$P(^PRCA(430,RCBILLDA,16),U,9)=RCAMTRFD,$P(^(16),U,10)=RCAMTRFD
 W "fully re-established as Cross-Serviced >"
 Q
 ;
ADDR(RCDFN) ; returns patient file address
 N DFN,ADDRCS,STATEIEN,STATEAB,VAPA
 S DFN=RCDFN
 D ADD^VADPT
 S STATEIEN=+VAPA(5),STATEAB=$$GET1^DIQ(5,STATEIEN,1)
 S ADDRCS=VAPA(1)_U_VAPA(2)_U_VAPA(4)_U_STATEAB_U_VAPA(6)_U_VAPA(8)_U_+VAPA(25)
 I $L(RCDEBTR1)>0 I $P(RCDEBTR1,U,1,5)'?1"^"."^" D
 .N ADDR340
 .S ADDR340=$P($$DADD^RCAMADD(RCDEBTOR),U,1,7)_"^"_1
 .S ADDR340=$P(ADDR340,U,1,2)_"^"_$P(ADDR340,U,4,99)
 .I $P(ADDR340,U,6)="" S $P(ADDR340,U,6)=$P(ADDRCS,U,6)
 .S ADDRCS=ADDR340
 Q ADDRCS
EXIT D KILL^XUSCLEAN Q
