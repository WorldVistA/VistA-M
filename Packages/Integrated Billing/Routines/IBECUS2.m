IBECUS2 ;DVAMC/RLM - TRICARE PHARMACY BILL TRANSACTION ;14-AUG-96
 ;;2.0;INTEGRATED BILLING;**52,89,143,162,240,274,347**;21-MAR-94;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ; Attempt to bill a prescription directly to the FI.
 ;  Input:    IBKEY  --  1 ; 2, where
 ;                         1 = Pointer to the prescription in file #52
 ;                         2 = Pointer to the refill in file #52.1, or
 ;                             0 for the original fill
 ;           IBKEYD  --  1 ^ 2 ^ 3 ^ 4 ^ 5, where
 ;                         1 = Rx label printing device
 ;                         2 = Pointer to the Pharmacy in file #59
 ;                         3 = Pointer to the Pharmacy user in file #200
 ;                         4 = Pointer to the billing transaction
 ;                             in file #351.5 (cancellations only)
 ;                         5 = Product Selection Reason 
 ;                                  (Resubmissions only)
 ;          IBCHSET  --  Pointer to the Charge Set in file #363.1
 ;         IBPRESCR  --  Facility Prescriber ID number
 ;
 ; - get rx data; make sure there is an NDC
 K IBDRX,IBERR,IBAWPV,IBRESP
 N DFN,IBRX,IBITEM,IBAWP
 N DIQUIET S DIQUIET=1 D DT^DICRW
 S IBRX=+IBKEY,IBREF=+$P(IBKEY,";",2)
 I $$TRANS^PSOCPTRI(IBRX,IBREF,.IBDRX)<0 S IBERR=1 G ENQ
 ;
 ; - make sure the AWP is available
 S IBDRX("NDC")=$$NDC(IBDRX("NDC"))
 S IBITEM=+$$FNDBI^IBCRU2("NDC",IBDRX("NDC"))
 I 'IBITEM S IBERR=9 G ENQ ;                     NDC is not in CM
 D ITMCHG^IBCRCC(IBCHSET,IBITEM,DT,"",.IBAWPV)
 I +IBAWPV'=1 S IBERR=10 G ENQ ;                  Not 1 rate for NDC
 S IBAWP=$P(IBAWPV(+$O(IBAWPV(0))),"^",3)
 I 'IBAWP S IBERR=11 G ENQ ;                     NDC has a zero charge
 ;
 ; - is patient data intact?
 S DFN=+$$FILE^IBRXUTL(+IBRX,2)
 S IBDPT(0)=$G(^DPT(DFN,0)),IBDPT(.11)=$G(^(.11)),IBDPT(.13)=$G(^(.13))
 I IBDPT(0)="" S IBERR=4 G ENQ
 ;
 ; - is patient covered by TRICARE?
 S IBCDFN=$$CUS^IBACUS(DFN,DT)
 I 'IBCDFN S IBERR=2 G ENQ
 ;
 ; - get the BIN Number for the insurance company
 S IBCDFND=$G(^DPT(DFN,.312,IBCDFN,0))
 S IBBIN=$P($G(^DIC(36,+IBCDFND,3)),"^",3)
 I $L(IBBIN)'=6 S IBERR=5 G ENQ
 ;
 ; - build line1:
 ;      o pharmacy division
 ;      o FI identifier (bin number)
 ;      o commercial software package version (32)
 ;      o billing transaction code  (01)
 ;      o control #_pharmacy #_group (37 spaces)
 ;      o insured person's ssn
 ;      o person code (3 spaces)
 ;
 S IBFS=$C(28),IBGS=$C(29)
 S IBLINE(1)=$$FILL(IBDRX("DIV"),2)_IBBIN_3201_$J("",37)
 S IBLINE(1)=IBLINE(1)_$$LJUST($P(IBCDFND,"^",2),18)_$J("",3)
 ;
 ; - build line2:
 ;      o patient dob
 ;      o patient sex
 ;      o patient rel. to insured
 ;      o other coverage indicator (0)
 ;      o rx fill date
 ;
 S IBLINE(2)=$$DATE($P(IBDPT(0),"^",3))_$P(IBDPT(0),"^",2)
 S IBLINE(2)=IBLINE(2)_$S($P(IBCDFND,"^",16)>3:4,1:+$P(IBCDFND,"^",16))
 S IBLINE(2)=IBLINE(2)_"0"_$$DATE(IBDRX("FDT"))
 ;
 ; - build line3:
 ;      o patient first name
 ;      o patient last name
 ;      o insured's first name
 ;      o insured's last name
 ;      o address line 1, city, state, zip, phone
 ;      
 S IBLINE(3)=IBFS_"C700"_IBFS_"C90"
 S IBLINE(3)=IBLINE(3)_IBFS_"CA"_$$LJUST($P($P(IBDPT(0),"^"),",",2),12)
 S IBLINE(3)=IBLINE(3)_IBFS_"CB"_$$LJUST($P($P(IBDPT(0),"^"),","),15)
 S IBLINE(3)=IBLINE(3)_IBFS_"CC"_$$LJUST($P($P(IBCDFND,"^",17),",",2),12)
 S IBLINE(3)=IBLINE(3)_IBFS_"CD"_$$LJUST($P($P(IBCDFND,"^",17),","),15)
 S IBLINE(3)=IBLINE(3)_IBFS_"CM"_$$LJUST($P(IBDPT(.11),"^"),30)
 S IBLINE(3)=IBLINE(3)_IBFS_"CN"_$$LJUST($P(IBDPT(.11),"^",4),20)
 S IBLINE(3)=IBLINE(3)_IBFS_"CO"_$$LJUST($P($G(^DIC(5,+$P(IBDPT(.11),"^",5),0)),"^",2),2)
 S IBLINE(3)=IBLINE(3)_IBFS_"CP"_$$LJUST($P(IBDPT(.11),"^",6),9)
 S IBLINE(3)=IBLINE(3)_IBFS_"CQ"_$$FILL($TR($P(IBDPT(.13),"^"),"-",""),10)
 ;
 ; - build line4:
 ;      o prescription number
 ;      o new/refill code
 ;      o quantity
 ;      o days supply
 ;      o compound code (0) or if site param IBDRX("COMP")
 ;      o drug NDC #
 ;      o dispense as written? (0) or if resubmit look at IBKEYD
 ;      o ingredient cost
 ;      o Prescriber ID
 ;      o date prescription written
 ;      o # refills authorized
 ;      o rx origin code (1)
 ;      o rx denial clarification (00)
 ;      o usual and customary charge (currently ingr cost * 5)
 ;
 ; - but first, strip trailing alpha characters from the rx number
 S:$E(IBDRX("RX#"),$L(IBDRX("RX#")))]9 IBDRX("RX#")=$E(IBDRX("RX#"),1,$L(IBDRX("RX#"))-1)
 S IBLINE(4)=IBGS_$$FILL(IBDRX("RX#"),7)
 S IBLINE(4)=IBLINE(4)_$$FILL(IBREF,2)
 S IBLINE(4)=IBLINE(4)_$$FILL($P(IBDRX("QTY"),"."),5)
 S IBLINE(4)=IBLINE(4)_$$FILL(IBDRX("SUP"),3)
 S IBLINE(4)=IBLINE(4)_$S(+$P($G(^IBE(350.9,1,9)),"^",15):IBDRX("COMP"),1:0)
 S IBLINE(4)=IBLINE(4)_$$FILL($TR(IBDRX("NDC"),"-",""),11)
 S IBLINE(4)=IBLINE(4)_$S($P($G(^IBA(351.53,+$P(IBKEYD,"^",5),0)),"^"):$P(^(0),"^"),1:0)
 ;
 S IBUAC=$$FILL(+($E($TR($J(IBAWP,0,2),".",""),1,5))*IBDRX("QTY"),6)
 S IBLINE(4)=IBLINE(4)_IBUAC_$$LJUST($S(+$P($G(^IBE(350.9,1,9)),"^",14)&($L(IBDRX("DEA"))):IBDRX("DEA"),1:IBPRESCR),10)
 S IBLINE(4)=IBLINE(4)_$$DATE(IBDRX("ISS"))
 S IBLINE(4)=IBLINE(4)_$$FILL(IBDRX("#REF"),2)
 S IBLINE(4)=IBLINE(4)_"100"_$$FILL(IBUAC*5,6)
 ;
 ; - build line5:  (not currently used, though must be submitted)
 S IBLINE(5)=IBFS_"DA000000"_IBFS_"DC000200"_IBFS_"DG000000000000"_IBFS_"DI00"_IBFS_"DL"_$J("",10)
 S IBLINE(5)=IBLINE(5)_IBFS_"DM00000"_IBFS_"DN01"_IBFS_"DO"_$J("",6)_IBFS_"DU000000"_IBFS_"DX000000"
 S IBLINE(5)=IBLINE(5)_IBFS_"E4  "_IBFS_"E5  "_IBFS_"E6  "_IBFS_"E700000000"
 ;
OUT ; - send transaction to the commercial pos package
 W $C(2)
 F I=1:1:5 W IBLINE(I)
 W $C(3)
 W !
 ;
 ; - receive response
 R IBRESP(1)#220:120 I '$T S IBERR=6 G ENQ
 R IBRESP(2)#220:60,IBRESP(3):60 I '$L(IBRESP(3)) S IBERR=7 G ENQ
 ;
 S IBRESP(1)=$E(IBRESP(1),2,999)
 ;
 S XMCHAN=""
 I $E(IBRESP(1),1,3)="   " D ERROR^IBECUS22 G ENQ
 I $E(IBRESP(1),17)="D" D DUP^IBECUS22 G ENQ
 ;
 ; - file the billing transaction in file #351.51
 D ^IBECUS21
 ;
 ; - quit if a reject
 I $E(IBRESP(1),17)="R" G ENQ
 ;
 ; - if there was an error, file it and quit
 I $E(IBRESP(1),1,3) D ERROR^IBECUS22 G ENQ
 ;
 ; - Queue tasks to print the label and create charges
 F IBI="RXLAB;Rx Label print","RXBIL;Rx Billing" D TASK(IBI)
 ;
 ; - delete rx from billing queue
 K ^IBA(351.5,"APOST",IBKEY)
 ;
ENQ I $G(IBERR) D ERROR^IBECUS22
 Q
 ;
 ;
TASK(IBDESC) ; Queue off label print, charge creation and cancellation jobs
 ;  Input:  IBDESC  --  1 ; 2 , where
 ;                        1 = routine label to execute
 ;                        2 = task description
 K ZTSAVE,ZTCPU,ZTSK
 S ZTRTN=$P(IBDESC,";")_"^IBACUS",ZTDTH=$H,ZTIO=""
 S ZTDESC="IB - "_$P(IBDESC,";",2)
 F I="IBKEYD","IBCHTRN" S ZTSAVE(I)=""
 D ^%ZTLOAD
 Q
 ;
 ;
DATE(X) ; Set date in the format yyyymmdd, or 8 spaces.
 N Y
 S Y=($E($G(X))+17)_$E($G(X),2,7)
 Q $S($L(Y)=8:Y,1:$J("",8))
 ;
FILL(X,LEN) ; Zero-fill, right justified.
 N Y
 S:'$G(LEN) LEN=1
 S Y=$E($G(X),1,LEN)
 F  Q:$L(Y)>(LEN-1)  S Y="0"_Y
 Q Y
 ;
LJUST(X,LEN) ; Space-fill, left justified.
 N Y
 S:'$G(LEN) LEN=1
 S Y=$E($G(X),1,LEN)
 F  Q:$L(Y)>(LEN-1)  S Y=Y_" "
 Q Y
 ;
STRIPL(X) ; Strip leading spaces.
 N Y S Y=$G(X)
 F  Q:$E(Y)'=" "  S Y=$E(Y,2,999)
 Q Y
 ;
NDC(X) ; Massage the NDC as it is stored in Pharmacy
 ;  Input:  X  --  The NDC as it is stored in Pharmacy
 ; Output:  X  --  The NDC in the format 5N 1"-" 4N 1"-" 2N
 ;
 I $G(X)="" S X="" G NDCQ
 ;
 N LEN,PCE,Y,Z
 ;
 S Z(1)=5,Z(2)=4,Z(3)=2
 S PCE=0 F  S PCE=$O(Z(PCE)) Q:'PCE  S LEN=Z(PCE) D
 .S Y=$P(X,"-",PCE)
 .I $L(Y)>LEN S Y=$E(Y,2,LEN+1)
 .I $L(+Y)<LEN S Y=$$FILL(Y,LEN)
 .S $P(X,"-",PCE)=Y
 ;
NDCQ Q X
