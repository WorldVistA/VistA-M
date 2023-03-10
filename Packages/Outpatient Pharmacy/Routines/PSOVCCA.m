PSOVCCA ;BIR/JLC,KML - VCC PRESCRIPTION REFILL APIS ; April 11, 2022
 ;;7.0;OUTPATIENT PHARMACY;**642,679**;DEC 1997;Build 16
 ;
 Q
AP1(PSORET,PSODFN,PSORX,PSOUSER,PSORFSRC,PSORTFLG) ;ACCEPT REQUEST
 ; Input:  PSODFN     (required) - Patient IEN Number
 ;         PSORX      (required) - Prescription Number
 ;         PSOUSER    (optional) - User requesting refill
 ;         PSORFSRC   (optional) - the source system from which the REFILL
 ;                                 request Originated (e.g., VCC, CPRS, VSE)
 ;         PSORTFLG   (optional) - 1 or empty (null) - the return flag; if = 1 then the RPC will 
 ;                                 return the numeric code with the error text; if = null
 ;                                 then the RPC will only return the numeric code (-5, -4, -3, 0, or 1 )
 ; Output: PSORET - Return Value
 ;         See IA# 7313 for description and values
 ;
 ; route processing to appropriate tag
 I $G(PSORTFLG)="" D SIMPLE($G(PSODFN),$G(PSORX),$G(PSOUSER),$G(PSORFSRC)) Q
 D EXPANDED($G(PSODFN),$G(PSORX),$G(PSOUSER),$G(PSORFSRC))
 Q
 ;
SIMPLE(PSODFN,PSORX,PSOUSER,PSORFSRC) ;
 ;NOTE: if no refill source is passed, the assumption will be that
 ;the source is the VAHC-CRM platform (fka VCC). This is to ensure
 ;backwards compatibility until the changes are made to the CRM
 ;system to pass in the source and request the expanded error messages
 N PSRX,PSRXD,IEN,PSORR,PSOICN,SITE,PSOSITE,ERR
 I $G(PSORFSRC)="" S PSORFSRC="CRM"
 I $G(PSODFN)="" S PSORET(0)=-4 G QUITAP1
 S PSOICN=+$$GETICN^MPIF001(PSODFN)
 I +$G(PSOICN)=-1 S PSORET(0)=-4 G QUITAP1
 I $G(PSORX)="" S PSORET(0)=-3 G QUITAP1
 I $O(^PSRX("B",PSORX,""))="" S PSORET(0)=-3 G QUITAP1
 I '$D(^PSRX("B",PSORX)) S PSORET(0)=-3 G QUITAP1
 S PSRX=$O(^PSRX("B",PSORX,"")),PSRXD=$G(^PSRX(PSRX,0))
 I PSRXD="" S PSORET(0)=-3 G QUITAP1
 I $P(PSRXD,"^",2)'=PSODFN S PSORET(0)=-5 G QUITAP1
 D REF^PSOATRFV(PSRX,PSOUSER,PSORFSRC,.ERR)
 I $D(ERR) S PSORET(0)=0 Q
 S PSORET(0)=1
QUITAP1  Q
 ;
EXPANDED(PSODFN,PSORX,PSOUSER,PSORFSRC) ;
 N PSRX,PSRXD,IEN,PSORR,PSOICN,SITE,PSOSITE,ERR,X1
 I $G(PSODFN)="" S PSORET(0)="-4 - Missing or Invalid Patient ID" Q
 S PSOICN=+$$GETICN^MPIF001(PSODFN)
 I +$G(PSOICN)=-1 S PSORET(0)="-6 - Patient is not assigned an ICN" Q
 I $G(PSORX)="" S PSORET(0)="-3 - Missing or Invalid Prescription Number" Q
 I $O(^PSRX("B",PSORX,""))="" S PSORET(0)="-3 - Missing or Invalid Prescription Number" Q
 I '$D(^PSRX("B",PSORX)) S PSORET(0)="-3 - Missing or Invalid Prescription Number" Q
 S PSRX=$O(^PSRX("B",PSORX,"")),PSRXD=$G(^PSRX(PSRX,0))
 I PSRXD="" S PSORET(0)="-3 - Missing or Invalid Prescription Number" Q
 I $P(PSRXD,"^",2)'=PSODFN S PSORET(0)="-5 - Prescription Number does not match to the Patient" Q
 D REF^PSOATRFV(PSRX,PSOUSER,PSORFSRC,.ERR)
 I $D(ERR) S PSORET(0)=0 M PSORET=ERR Q
 S PSORET(0)="1 - Prescription successfully refilled"
 Q
