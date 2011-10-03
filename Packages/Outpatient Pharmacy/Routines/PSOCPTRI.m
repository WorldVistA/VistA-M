PSOCPTRI ;BHAM ISC/CPM,RTR - SUPPORT FOR CHAMPUS RX BILLING ;14-AUG-96
 ;;7.0;OUTPATIENT PHARMACY;**10,55,184**;DEC 1997
 ;External reference to ^PSDRUG supported by DBIA 221
 ;
 ;
TRANS(ORIG,REF,PSOV) ; Extract Rx information for transmission to FI
 ;  Input:   ORIG  --  Pointer to the rx in file #52
 ;            REF  --  Pointer to the refill in file #52.1
 ;                     (This is 0 if we are billing the original fill)
 ;           PSOV  --  Passed by reference.  This array will be used
 ;                     to return the output (described below).
 ; Output:   PSOE  --  This is normally 1, or -1 if the NDC cannot
 ;                     be determined.
 ;
 ;
 ;     Description of output variables to be passed to billing:
 ;
 ;            PSOV("NDC")       NDC # from the DRUG (#50) file
 ;            PSOV("DIV")       Pharmacy (in file #59) dispensing the rx
 ;            PSOV("FDT")       Rx Fill Date
 ;                                 Last fill, field #101, or
 ;                                 Dispensed, field #25
 ;            PSOV("RX#")       Prescription number, field #.01
 ;            PSOV("QTY")       Quantity, field #7
 ;            PSOV("SUP")       Days Supply, field #8
 ;            PSOV("ISS")       Issue Date, field #1
 ;            PSOV("#REF")      # Refills, field #9
 ;            PSOV("COMP")      2 if manufactured in Pharmacy, else 1
 ;            PSOV("DEA")       DEA number from "PS" node in File 200
 ;
 N PSOE,PSORX S PSOE=1
 ;
 S PSORX(0)=$G(^PSRX(ORIG,0)),PSORX(2)=$G(^(2)),PSORX(3)=$G(^(3))
 S:$G(REF) PSORX("REF")=$G(^PSRX(ORIG,1,REF,0))
 I PSORX(0)="" S PSOE=-1 G TRANSQ
 ;
 S PSOV("RX#")=$P(PSORX(0),"^") ; prescription number
 ; - first check for a valid NDC #
 S PSOV("NDC")=$P($G(^PSDRUG(+$P(PSORX(0),"^",6),2)),"^",4)
 I +PSOV("NDC")=0 S PSOE=-1 G TRANSQ
 ;
 ; - extract everything else
 S PSOV("DIV")=$S($P($G(PSORX("REF")),"^",9):$P(PSORX("REF"),"^",9),1:$P(PSORX(2),"^",9)) ;                  pharmacy division
 S PSOV("FDT")=$S($G(REF):$E($P(PSORX("REF"),"^"),1,7),1:$E($P(PSORX(2),"^",2),1,7))
 I PSOV("FDT")="" S PSOV("FDT")=$S($P(PSORX(3),"^"):$P(PSORX(3),"^"),1:$P(PSORX(2),"^",5))
 ;
 S PSOV("QTY")=$S($P($G(PSORX("REF")),"^",4)'="":$P(PSORX("REF"),"^",4),1:$P(PSORX(0),"^",7)) ;                  quantity
 S PSOV("SUP")=$S($P($G(PSORX("REF")),"^",10)'="":$P(PSORX("REF"),"^",10),1:$P(PSORX(0),"^",8)) ;                  days supply
 S PSOV("ISS")=$P(PSORX(0),"^",13) ;                 date rx written
 S PSOV("#REF")=$P(PSORX(0),"^",9) ;                 # refills authorized
 ;
 N PSOX S PSOX=+$P(PSORX(0),"^",6) S PSOV("COMP")=$P($G(^PSDRUG(PSOX,0)),"^",3) S PSOV("COMP")=$S(PSOV("COMP")[0:2,1:1) ; Compound drug
 ;
 S PSOV("DEA")=$S($P(PSORX(0),"^",4):$P($G(^VA(200,$P(PSORX(0),"^",4),"PS")),"^",2),1:"") ; DEA #
 ;
 ;
TRANSQ Q PSOE
 ;
 ;
LABEL(RX,PSOLAP,PSOSITE,DUZ,PSOTRAMT) ; Print the label.
 ;  Input:        RX  --  Pointer to the prescription in file #52
 ;            PSOLAP  --  Label printer
 ;           PSOSITE  --  Pointer to the Pharmacy in file #59
 ;               DUZ  --  Pointer to the use in file #200
 ;          PSOTRAMT  --  Amount to be paid
 ;
 ;
 Q:PSOLAP["LAT-TERM"
 Q:'$D(^PSRX(RX,0))
 Q:'$D(^PS(59,PSOSITE,0))
 N CT,II,III,NOW,RXFF,X,Y,PSOSYS,PSOPAR,PSOBARS,PDUZ,PSOBAR0,PSOBAR1,REPRINT,PSOCHAMP,PSHRX,DIQUIET
 S DIQUIET=1 D DT^DICRW
 I '$G(DT) S DT=$$DT^XLFDT
 S:$P($G(^PSRX(RX,"STA")),"^")'=3 REPRINT=""
 D:$P($G(^PSRX(RX,"STA")),"^")=3
 .S RXFF=0 F II=0:0 S II=$O(^PSRX(RX,1,II)) Q:'II  S RXFF=II
 .K DIE S DIE="^PSRX(",DA=RX,DR=$S('RXFF:"22///"_DT_";",1:"")_"100///"_0_";101///"_$S('RXFF:DT,1:+$P($G(^PSRX(RX,1,+$G(RXFF),0)),"^")) D ^DIE K DIE
 .S PSHRX=RX D EN^PSOHLSN1(RX,"OE","","Rx removed from CHAMPUS billing hold","A") S RX=PSHRX
 .K ^PSRX("AH",+$P($G(^PSRX(RX,"H")),"^"),RX) S ^PSRX(DA,"H")=""
 .D NOW^%DTC S NOW=%
 .S III=0 F CT=0:0 S CT=$O(^PSRX(RX,"A",CT)) Q:'CT  S III=CT
 .S III=III+1,^PSRX(RX,"A",0)="^52.3DA^"_III_"^"_III
 .S ^PSRX(RX,"A",III,0)=NOW_"^"_"U"_"^"_+$G(DUZ)_"^"_$S(RXFF<6:RXFF,1:(RXFF+1))_"^"_"Rx removed from CHAMPUS billing hold"
 ;
IO S %ZIS="",IOP=PSOLAP D ^%ZIS I POP H 5 G IO
 N PSOIOS S PSOIOS=IOS D DEVBAR^PSOBMST
 S PSOSYS=$G(^PS(59,PSOSITE,1))
 S PSOPAR=$G(^PS(59,PSOSITE,1)),PDUZ=DUZ
 S PPL=RX
 S PSOCHAMP=1
 S PSOBARS=PSOBAR1]""&(PSOBAR0]"")&($P(PSOPAR,"^",19))
 D DQ^PSOLBL
 D ^%ZISC
 ;
 Q
 ;
 ;
CHK(ORIG,REF) ; Should this rx be billed to the CHAMPUS Fiscal Intermediary?
 ;  Input:   ORIG  --  Pointer to the rx in file #52
 ;            REF  --  Pointer to the refill in file #52.1, or
 ;                     0 for the original fill
 ; Output:   PSOB  --  0 => The rx should not be billed
 ;                     1 => The rx may be billed.
 ;
 N PSOB
 ;
 ; - ignore CHAMPUS billing for certain RX Patient Statuses
 I $P($G(^PS(53,+$P($G(^PSRX(+$G(ORIG),0)),"^",3),0)),"^",8) G CHKQ
 ;
 S PSOB=1
 ;
CHKQ Q +$G(PSOB)
 ;
DEV ;Get devices
 N PSOTRION
 S PSOTRION=ION
 I $G(PSOLAP)]"",$G(PSOLAP)'=ION Q
DEVA W ! S %ZIS("B")="",%ZIS="MNQ",%ZIS("A")="Select LABEL DEVICE: " D ^%ZIS I POP!($E(IOST)'["P") W !,"Label Printer device must be selected!",! G DEVA
 S PSOLAP=ION
 N PSOIOS S PSOIOS=IOS D DEVBAR^PSOBMST
 S PSOBARS=PSOBAR1]""&(PSOBAR0]"")&($P($G(PSOPAR),"^",10))
 D ^%ZISC S ION=PSOTRION Q
 ;
EXM ;Edit Champus Billing Exemption field
 I '$D(PSOPAR) D ^PSOLSET G EXM
 W ! K DIC S DIC="^PS(53,",DIC(0)="AEQMZ" D ^DIC K DIC I Y<0!($D(DTOUT))!($D(DUOUT)) G EXMQ
 W ! K DIE S DA=+Y,DIE="^PS(53,",DR=16 D ^DIE
EXMQ K DIE,DIC,Y
 Q
RESDIR ;Reset DIR just in case
 S DIR("A")="LABEL: QUEUE"_$S($P(PSOPAR,"^",23):"/HOLD",1:"")_$S($P(PSOPAR,"^",24):"/SUSPEND",1:"")_$S($P(PSOPAR,"^",26):"/LABEL",1:"")_" or '^' to bypass "
 S DIR("?",1)="Enter 'Q' to queue labels to print",DIR("?")="Enter '^' to bypass label functions",DIR("?",4)="Enter 'S' to suspend labels to print later"
 S DIR("?",2)="Enter 'H' to hold label until Rx can be filled",DIR("?",3)="Enter 'P' for Rx profile"
 S:$P(PSOPAR,"^",26) DIR("?",5)="Enter 'L' to print labels without queuing"
 Q
