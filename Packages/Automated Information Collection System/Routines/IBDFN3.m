IBDFN3 ;ALB/CJM - ENCOUNTER FORM - (entry points for reports); 5/21/93
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**20,25,45**;APR 24, 1997
RXPROF ;Outpatient Pharmacy Action Profile and Information Profile
 ;INPUTS:
 ;PSDAYS = number of days to print the medication profile for
 ;PSTYPE=1 for the Action Profile, =0 for the Information Profile
 ;PSONOPG=2 variable needed to indicate to Profiles to not close device
 ;     and not to form feed
 ;PSOSITE= Division -- ien from file 40.8, not always same as in file 59
 ;DFN
 ;
 N IBDFN,ADDR,ADDRFL,CLASS,CNDT,DRUG,HDFL,I,II,J,L,LINE,P,PAGE,PSDOB,PSIIX,PSNAME,PSOI,PSSN,PSIX,PGM,PRF,PSDATE,VAL,VAR,RX,RX0,RX2,ST,ST0,PSDAY,RF,RFS
 N PSOPRINT,X1,X2,ZTSK,X,Y,PSII,PSDT,LMI,PSCNT,PSDIS,RXCNTLN,ELN,FN,CNT,VAERR,LN,PCLASS,PSOIFSUP,PSOINST,PSOSITE,PSONOPG,DUOUT,DTOUT,DIRUT
 Q:(+$G(DFN)=0)
 S IBDFN=DFN
 S X1=DT,X2=-PSDAYS D C^%DTC S (PSDATE,PSDAY)=X
 S LINE=$TR($J(" ",IOM)," ","-")
 ;
 ; -- get site name, turn on barcoding, set to not close device
 S PSOINST=$P($$SITE^VASITE,"^",3)
 S PSOPAR=1,PSONOPG=2
 I $G(IBCLINIC)]"" S PSOSITE=$P($G(^SC(IBCLINIC,0)),"^",15)
 I $G(PSTYPE)=0 S PAGE=1 D DFN^PSOSD1 ; -- Informational Profile
 I $G(PSTYPE)=1 S PAGE=1 D DFN^PSOSD1 ; -- Action Profile
 W:$Y @IOF
 ;
 S DFN=IBDFN
 K VA,VAEL,VAPA
 Q
 ;
DRUGS ;prints the medication profile of Outpatient Pharmacy
 ;doesn't seem to be needed, integration agreement not obtained to use this
 ;INPUTS:
 ;PLS=0 for long, 1 for short
 ;PSRT="D" to sort by date, "M" to sort by medication, "C" to sort by class
 ;DFN
 ;
 ;N IBDFN,DRUG,ZII,PHYS,CT,AL,I1,REF,LMI,PI,FN,Y,I,J,RX,DRX,ST,RX0,RX2,DA,D0,DIC,DIPGM,II,K,ST0,TEMP,Z,LMI,RXD,RXF,PI,AL,D0,DIPGM,II,PSCNT,PSDIV,PSLC,PSDIS
 ;
 ;S (FN,IBDFN,D0,DA)=DFN
 ;I '$D(^PS(55,IBDFN,"P")),'$D(^("ARC")) D ^PSODEM W !?20,"NO PHARMACY INFORMATION" G RXQ
 ;I '$O(^PS(55,IBDFN,"P",0)),$D(^PS(55,IBDFN,"ARC")) D ^PSODEM W !!,"PATIENT HAS ARCHIVED PRESCRIPTIONS",! G RXQ
 ;D P^PSOP
RXQ ;W @IOF
 ;S DFN=IBDFN
 ;K ^UTILITY($J)
 Q
ROUTING ;entry point for printing a routing sheet for a single patient
 ;Sets IBPRINT=1 so that it will be known that this entry point was used
 ;inputs - 
 ;    DFN
 ;    IBAPPT - the appointment
 ;    IBCLINIC - pointer to the clinic
 ;protect variables that may be changed
 N %,%DT,%I,ADDR,ALL,APDATE,IBDFN,DGMT,DIC,DIV,G,GDATE,H,I,J,K,L,LL,M,NAME,NDATE,ORD,ORDER,P,POP,PRDATE
 N SC,SDA,SDATE,SDCNT,SDI,SDI1,SDIQ,SDM,SDREP,SDSP,SDSTART,SDVA,SDX,SDX1,SSN,SZ,TDO,X,X1,Y,ZIP,ZX,VAR,C,V,SDEF,A,SD,SCN,SDTD,SDSCCOND,SDPARMS
 ;
 ;protect DFN
 Q:(+$G(DFN)=0)
 S IBDFN=DFN N DFN S DFN=IBDFN
 ;
 ;set the start date to the date of the appt
 S SDPARMS("START")=IBAPPT\1
 ;keep the device open
 S SDPARMS("DO NOT CLOSE")=1
 ;set DIV to the division of IBCLINIC
 S DIV=$P($G(^SC(IBCLINIC,0)),"^",15)
 D EN1^SDROUT1
 Q
