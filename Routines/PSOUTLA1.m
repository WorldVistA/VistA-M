PSOUTLA1 ;BHAM ISC/RTR-Pharmacy utility program cont. ;5/22/07 10:01am
 ;;7.0;OUTPATIENT PHARMACY;**35,186,218,259,206**;DEC 1997;Build 39
 ;External reference to File ^PS(55 supported by DBIA 2228
 ;External reference to File ^PSDRUG supported by DBIA 221
 ;External reference to File ^PS(59.7 supported by DBIA 694
 ;External reference to File ^PS(51 supported by DBIA 2224
 ;
 ;*186 - add DEACHK function
 ;*218 - add REFIP function
 ;*259 - reverse *218 delete restriction only warn of deleting
 ;       also add del of last refill only
 ;
EN1 ;Formats condensed, back door sig in BSIG array
 ;pass in  1) Internal Rx from 52
 ;         2) max length of BSIG array
 ;Returned, still condensed, in BSIG array, when looping through, check for array=null, if so, juist don't print it
EN2(PSOBINTR,PSOBLGTH) ;
 K BSIG
 N BBSIG,BVAR,BVAR1,III,CNT,NNN,BLIM
 S BBSIG=$P($G(^PSRX(PSOBINTR,"SIG")),"^") Q:BBSIG=""!($P($G(^("SIG")),"^",2))
 S (BVAR,BVAR1)="",III=1
 S CNT=0 F NNN=1:1:$L(BBSIG) I $E(BBSIG,NNN)=" "!($L(BBSIG)=NNN) S CNT=CNT+1 D  I $L(BVAR)>PSOBLGTH S BSIG(III)=BLIM_" ",III=III+1,BVAR=BVAR1
 .S BVAR1=$P(BBSIG," ",(CNT))
 .S BLIM=BVAR
 .S BVAR=$S(BVAR="":BVAR1,1:BVAR_" "_BVAR1)
 I $G(BVAR)'="" S BSIG(III)=BVAR
 I $G(BSIG(1))=""!($G(BSIG(1))=" ") S BSIG(1)=$G(BSIG(2)) K BSIG(2)
 Q
 ;
EN3(PSOBINTR,PSOBLGTH) ;
 ;Pass in to EN3 the internal Rx number from 52, and the length of
 ;the array you want. Returns expanded Sig, or warning from PSOHELP
 ;concantenated with the condensed Sig in the BSIG array
 ;BACK DOOR ONLY
 K BSIG,X N BBSIG,BVAR,BVAR1,III,CNT,NNN,BLIM,Y,SIG,Z0,Z1,BBWARN
 S BBSIG=$P($G(^PSRX(PSOBINTR,"SIG")),"^") Q:BBSIG=""!($P($G(^("SIG")),"^",2))
 S (SIG,X)=BBSIG
 I $E(BBSIG)=" " S BBWARN="Leading spaces are not allowed in the SIG!" G START
 S SIG="" Q:$L(X)<1  F Z0=1:1:$L(X," ") G:Z0="" START S Z1=$P(X," ",Z0) D  G:'$D(X) START
 .I $L(Z1)>32 S BBWARN="MAX OF 32 CHARACTERS ALLOWED BETWEEN SPACES!" K X Q
 .D:$D(X)&($G(Z1)]"")  S SIG=SIG_" "_Z1
 ..S Y=$O(^PS(51,"B",Z1,0)) Q:'Y!($P($G(^PS(51,+Y,0)),"^",4)>1)  S Z1=$P(^PS(51,Y,0),"^",2) Q:'$D(^(9))  S Y=$P(X," ",Z0-1),Y=$E(Y,$L(Y)) S:Y>1 Z1=^(9)
START ;
 S BBSIG=$S($G(BBWARN)="":SIG,1:BBWARN_"  "_BBSIG)
 S (BVAR,BVAR1)="",III=1
 S CNT=0 F NNN=1:1:$L(BBSIG) I $E(BBSIG,NNN)=" "!($L(BBSIG)=NNN) S CNT=CNT+1 D  I $L(BVAR)>PSOBLGTH S BSIG(III)=BLIM_" ",III=III+1,BVAR=BVAR1
 .S BVAR1=$P(BBSIG," ",(CNT))
 .S BLIM=BVAR
 .S BVAR=$S(BVAR="":BVAR1,1:BVAR_" "_BVAR1)
 I $G(BVAR)'="" S BSIG(III)=BVAR
 I $G(BSIG(1))=""!($G(BSIG(1))=" ") S BSIG(1)=$G(BSIG(2)) K BSIG(2)
 Q
PATCH ;Allow sites to backfill more than what was done at install
 N PSOBACKL,PSOBACKI,PSOBACKS,PSOBACKB,PSOBACKD,PSOBACKA
 S PSOBACKL=$O(^PS(59.7,0)),PSOBACKI=$E($P($G(^PS(59.7,+$G(PSOBACKL),49.99)),"^",7),1,7)
 I '$G(PSOBACKI) S PSOBACKI=$P($G(^PS(59.7,+$G(PSOBACKL),49.99)),"^",4)
 I $G(PSOBACKI) S Y=PSOBACKI D DD^%DT S PSOBACKS=Y S X1=PSOBACKI,X2=-120 D C^%DTC S (Y,PSOBACKB)=X D DD^%DT S PSOBACKD=Y
 I $G(PSOBACKD)'="" W !!,"Your CPRS/Outpatient installation date is "_$G(PSOBACKS)_","_" which",!,"means we have already backfilled all active prescriptions and all",!,"prescriptions canceled or expired after "_$G(PSOBACKD)_"."
 I  W !!,"If you want to backfill orders that were canceled or expired prior to this",!,"date of "_$G(PSOBACKD)_", enter an earlier date and those orders",!,"will be backfilled to CPRS.",!
 I $G(PSOBACKD)="" W !!,"We cannot determine the date of the CPRS/Outpatient installation.",!
 W !,"If you choose to backfill more orders to CPRS by utilizing this option,",!,"we remind you that disk storage can be significantly affected, depending on",!,"how many orders are backfilled.",!
 K DIR S DIR(0)="Y",DIR("B")="N",DIR("A")="Do you want to backfill more prescriptions",DIR("?")="Enter Yes to backfill prescriptions canceled or expired before "_$G(PSOBACKD) D ^DIR K DIR I Y'=1 W ! G PATCHQ
 W ! S %DT="AEPX",%DT("A")="Enter Date to begin backfill: " S:$G(PSOBACKB) %DT(0)=-PSOBACKB D ^%DT G:Y<0!($D(DTOUT)) PATCHQ S PSOBACKA=$E(Y,1,7)
 W ! K ZTDTH S ZTSAVE("PSOBACKB")="",ZTSAVE("PSOBACKA")="",ZTRTN="PATCHR^PSOUTLA1",ZTDESC="BACKFILL PRSCRIPTIONS TO CPRS",ZTIO="" D ^%ZTLOAD W ! G PATCHQ
PATCHR ;Begin task
 N PSOPAL,PSOLPD,PSOLPRX
 S PSOBACKA=PSOBACKA-.01
 I '$G(PSOBACKB) S PSOBACKB=DT
 F PSOPAL=0:0 S PSOPAL=$O(^PS(55,PSOPAL)) Q:'PSOPAL  F PSOLPD=PSOBACKA:0 S PSOLPD=$O(^PS(55,PSOPAL,"P","A",PSOLPD)) Q:'PSOLPD!(PSOLPD>PSOBACKB)  F PSOLPRX=0:0 S PSOLPRX=$O(^PS(55,PSOPAL,"P","A",PSOLPD,PSOLPRX)) Q:'PSOLPRX  D
 .I $P($G(^PSRX(PSOLPRX,0)),"^")=""!('$P($G(^(0)),"^",2))!('$P($G(^(0)),"^",6)) Q
 .I $P($G(^PSRX(PSOLPRX,"OR1")),"^",2) Q
 .I '$P($G(^PSRX(PSOLPRX,0)),"^",19) D
 ..I $P($G(^PSRX(PSOLPRX,"OR1")),"^")="",+$G(^PSDRUG(+$P($G(^PSRX(PSOLPRX,0)),"^",6),2)) S $P(^PSRX(PSOLPRX,"OR1"),"^")=+$G(^PSDRUG(+$P($G(^PSRX(PSOLPRX,0)),"^",6),2))
 ..I $P($G(^PSRX(PSOLPRX,0)),"^",10)'="",$G(^PSRX(PSOLPRX,"SIG"))']"",'$O(^PSRX(PSOLPRX,"SIG1",0)) S ^PSRX(PSOLPRX,"SIG")=$P($G(^PSRX(PSOLPRX,0)),"^",10)_"^"_0 S $P(^PSRX(PSOLPRX,0),"^",10)=""
 ..I $P($G(^PSRX(PSOLPRX,"STA")),"^")="",$P($G(^PSRX(PSOLPRX,0)),"^",15)'="" S $P(^PSRX(PSOLPRX,"STA"),"^")=$P($G(^PSRX(PSOLPRX,0)),"^",15) S $P(^PSRX(PSOLPRX,0),"^",15)=""
 ..S $P(^PSRX(PSOLPRX,0),"^",19)=1
 .S PSOLPSTA=$P($G(^PSRX(PSOLPRX,"STA")),"^") Q:PSOLPSTA=""!(PSOLPSTA=13)!(PSOLPSTA=10)
 .D EN^PSOHLSN1(PSOLPRX,"ZC","")
 .I PSOLPSTA'="",PSOLPSTA<10 D
 ..I +$P($G(^PSRX(PSOLPRX,2)),"^",6),+$P($G(^(2)),"^",6)<DT S $P(^PSRX(PSOLPRX,"STA"),"^")=11,PSOLPSTA=11
 .S PSOLPSTX=$S(PSOLPSTA=3:"OH",PSOLPSTA=16:"OH",PSOLPSTA=12:"OD",PSOLPSTA=15:"OD",PSOLPSTA=14:"OD",1:"SC"),PSOLPSTZ=$S(PSOLPSTA=0:"CM",PSOLPSTA=1:"IP",PSOLPSTA=4:"IP",PSOLPSTA=5:"ZS",PSOLPSTA=11:"ZE",1:"")
 .D EN^PSOHLSN1(PSOLPRX,PSOLPSTX,PSOLPSTZ,"")
 S:$D(ZTQUEUED) ZTREQ="@"
PATCHQ Q
 ;
 ;PSO*186
DEACHK(PSIRXN,PSDEA,PSDAYS,PCLOZ,PSOCS,PSMAXRF) ;Apply DEA restrictions
 ;
 ; If no refills allowed indicate that and set Max refills to number
 ; of fills thus far, or if new order, then num of refills will not be
 ; found and Max refills will be 0.
 ;
 ;  Function returns: 1 = no refills allowed
 ;                    0 = ok to refill
 ;  Input Variables: PSIRXN = internal RX number or "*"=(new order)
 ;                   PSDEA  = DEA special handling for drug ordered
 ;                   PSDAYS = Days supply ordered
 ;                   PCLOZ  = Clozapine patient? (Optional)
 ; Output Variables: PSOCS  = Controlled sub flag  (Optional)
 ;                   PSMAXRF= Max Refill allowed by DEA restriction
 ;                                                 (Optional)
 ;
 S PSIRXN=+$G(PSIRXN),PSDEA=$G(PSDEA),PSDAYS=+$G(PSDAYS)
 S PSOCS=+$G(PSOCS),PSMAXRF=+$G(PSMAXRF),PCLOZ=$G(PCLOZ)
 ;
 ;if clozapine patient (passed in 0 or 1),  set max refills and quit
 I PCLOZ=0 S PSMAXRF=0 Q 1
 I PCLOZ=1 S PSMAXRF=1 Q 0
 ;
 ;no refills if PSDEA = 'A' & not 'B' or 'F',
 I (PSDEA["A")&(PSDEA'["B")!(PSDEA["F")!(PSDEA[1)!(PSDEA[2) D  Q 1
 . S PSMAXRF=$$NUMFILLS(PSIRXN)
 ;
 N QQ
 F QQ=1:1 Q:$E(PSDEA,QQ)=""  I $E(+PSDEA,QQ)>1,$E(+PSDEA,QQ)<6 D
 . S PSOCS=1
 . S:$E(+PSDEA,QQ)=2 $P(PSOCS,"^",2)=1
 ;
 ;no refills allowed on sched 2
 I $P(PSOCS,"^",2)=1 S PSMAXRF=$$NUMFILLS(PSIRXN) Q 1
 ;
 ;set max refill for controlled substance & other based on days supply
 S PSDAYS=+$G(PSDAYS)
 I PSOCS D
 . S PSMAXRF=$S(PSDAYS<60:5,PSDAYS'<60&(PSDAYS'>89):2,PSDAYS=90:1,1:0)
 E  D
 . S PSMAXRF=$S(PSDAYS<60:11,PSDAYS'<60&(PSDAYS'>89):5,PSDAYS=90:3,1:0)
 ;
 ;get number of fills if applies & compare to Max refills
 N PNFILLS S PNFILLS=$$NUMFILLS(PSIRXN)
 I PNFILLS'<PSMAXRF S PSMAXRF=PNFILLS Q 1
 ;
 Q 0
 ;
NUMFILLS(PSIRXN) ;Return number of fills thus far, or 0 if doesn't apply
 ; function returns: if   Active drug, then number of refills thus far
 ;                   else return 0 for does not apply
 ;  Input Variables: PSIRXN = internal RX number (Optional)
 Q:'$G(PSIRXN) 0
 N RFN,RFNC
 S (RFN,RFNC)=0
 F  S RFN=$O(^PSRX(PSIRXN,1,RFN)) Q:'RFN  S RFNC=RFNC+1
 Q RFNC
 ;
REFIP(RXI,RFIL,TYP) ;Check if refill is Not Released and In Process and
 ;           pending Auto Release by an external dispense machine.
 ; Input: RXI = internal Prescription no.
 ;        RFIL= refill number
 ;        TYP ="R"-refill or "P"-partial
 ; Returns 1 = In Process      (Not OK to delete)
 ;         0 = Not In Process  (OK to delete)
 ;
 ;assumes a refill is Not In Process by the external dispense machine
 ;unless it finds a record in this file and is marked to the contrary
 ;
 N PSIEN,IP,FOUND,EXDATA,EXDIV
 S (IP,FOUND)=0,PSIEN=""
 ;find first specified refill processing backwards, in case dupes
 F  S PSIEN=$O(^PS(52.51,"B",RXI,PSIEN),-1) Q:PSIEN=""  D  Q:FOUND
 . S EXDATA=^PS(52.51,PSIEN,0)
 . I $P(EXDATA,"^",9)=RFIL D
 . . S EXDIV=$P(EXDATA,"^",11)
 . . Q:'$P($G(^PS(59,EXDIV,"DISP")),"^",2)     ;quit, not auto release
 . . S FOUND=1
 . I FOUND,$P(^PS(52.51,PSIEN,0),"^",10)'=2 S IP=1
 Q IP
 ;
WARN1 ;partial del checks    *259
 N PSR,PSOL
 S PSR=0 F  S PSR=$O(^PSRX(DA(1),"P",PSR)) Q:'PSR  S PSOL=PSR
 I DA=PSOL,$P(^PSRX(DA(1),"P",DA,0),"^",19) D  Q
 .D EN^DDIOL("Partial Released! Use the 'Return to Stock' option!","","$C(7),!!"),EN^DDIOL(" ","","!")
 ;
 ;Warn of In Process, Only delete if answered Yes         ;*259
 I $$REFIP^PSOUTLA1(DA(1),DA,"P") D  I 'Y Q               ;reset $T
 . D EN^DDIOL("** Partial refill has previously been sent to the External Dispense Machine","","!!,?2")
 . D EN^DDIOL("** for filling and is still Pending Processing","","$C(7),!,?2")
 . D EN^DDIOL("","","!")
 . K DIR
 . S DIR("A")="Do you want to continue? "
 . S DIR("B")="Y"
 . S DIR(0)="YA^^"
 . S DIR("?")="Enter Y for Yes or N for No."
 . D ^DIR
 . K DIR
 Q
