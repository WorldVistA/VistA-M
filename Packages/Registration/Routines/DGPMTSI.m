DGPMTSI ;ALB/LM - TREATING SPECIALTY INPATIENT INFO ; 6/15/93
 ;;5.3;Registration;**76**;Aug 13, 1993
 ;
START I $D(IO("Q")) S DGTSDT=ZTSAVE("DGTSDT"),PTLWD=ZTSAVE("PTLWD"),PTLTS=ZTSAVE("PTLTS"),PTCTS=ZTSAVE("PTCTS")
 S (DGT,Y)=DGTSDT
 X ^DD("DD") S DGTSDT=Y
 F DFN=0:0 S DFN=$O(^DPT(DFN)) Q:'DFN  S DGTS=0,DGXFR0="" D EN ; I DG1 D TREAT,START^DGPMTSI1,START^DGPMTSI2
 D START^DGPMTSO
 Q
EN ; -- call to return coresp adm and mvt data of pt as of a date
 ;    input:  DFN     => patient file ifn
 ;            DGT     => date to check if pt was inpatient
 ;   output:  DGA1    => coresp adm mvt ifn of ^DGPM
 ;            DG1     => ward ^ room-bed ^ mvt type(for xfrs only)
 ;            DGXFR0  => Oth of last xfr mvt for admission
 ; -- init
 K MT,IAD,IMD,DGCA,DGDC ; Inverse Adm Date & Inverse Mvt Date
 S DG1=""
 ;
 ; -- scan adms for pt
 ; -- if still inpt or d/c > DGT date then continue to CA
F F IAD=9999999.9999998-DGT:0 S IAD=$O(^DGPM("ATID1",DFN,IAD)) Q:'IAD  S DGA1=$O(^DGPM("ATID1",DFN,IAD,0)) I DGA1]"" S DGCA=$G(^DGPM(DGA1,0)),DGDC=$G(^DGPM(+$P(DGCA,U,17),0)),DGTS=+$P(DGCA,U,9) D  ; Q:DG1!($P(DGCA,U,18)'=40)
 .I 'DGDC!(DGDC>DGT) D CA ; I $P(%,"^",18)=43!($P(%,"^",18)=45) S DG1="" Q  ; -- set DG1="" if XFR is 43=to asih (other fac) or XFR is 45=change asih location (other fac)
 K DGNO Q
 ;
CA ; -- scan mvts for cor. adm that happened on or before DGT date 
 ; -- if mvt is adm or xfr then set DG1
 ; -- if mvt is xfr then continue to XFR
 ;F IMD=9999999.9999998-DGT:0 S IMD=$O(^DGPM("APMV",DFN,DGA1,IMD)) Q:'IMD  I $D(^DGPM(+$O(^(IMD,0)),0)) S %=^(0),MT=$P(%,"^",2) Q:$P(%,"^",18)=43  I MT=1!(MT=2) S DG1=$P(%,"^",6,7) D XFR:MT=2 Q:DG1
 F IMD=9999999.9999998-DGT:0 S IMD=$O(^DGPM("APMV",DFN,DGA1,IMD)) Q:'IMD  I $D(^DGPM(+$O(^(IMD,0)),0)) S %=^(0),MT=$P(%,"^",2) S:$P(%,"^",9)]"" DGS=$P(%,"^",9),DGTS=DGS S DGW=$P(%,"^",6) I MT=1!(MT=2) S DG1=$P(%,"^",6,7) D XFR:MT=2 Q:DG1
 I DG1 D TREAT,START^DGPMTSI1,START^DGPMTSI2
 I $P(DG1,"^",3)=13!($P(DG1,"^",3)=44) S DG1=""
CAQ Q
 ;
XFR ; -- set DG1="" if XFR to asih(oth fac)  --ELSE--  add MVT type to DG1
 ;S DGXFR0=%,DG1=$S($P(%,"^",18)=13:"",1:DG1_"^"_$P(%,"^",18))
 S DGXFR0=%,DG1=DG1_"^"_$P(%,"^",18)
 ;I $P(%,"^",18)=13 S %=$O(^DGPM("APMV",DFN,DGA1,IMD)) I $D(^DGPM(+$O(^(%,0)),0)) S DGW=$P(^(0),"^",6)
 I $P(%,"^",18)=13!($P(%,"^",18)=44) D
 . N DGPMNI,DGPMTN,DGPMAB
 . S DGPMNI=DGA1,DGPMTN=%
 . D FINDLAST^DGPMV32 ; gets date/time which initiated ASIH (either to asih or to asih (other))
 . S %=$O(^DGPM("APMV",DFN,DGA1,9999999.9999999-DGPMAB)) I $D(^DGPM(+$O(^(%,0)),0)) S DGW=$P(^(0),"^",6)
 Q
 ;
TREAT Q:'DG1
 S DG2=9999999 D TREAT1
 I +DG2=9999999 S DG2=0 Q
 S DG2=$S($D(^DIC(45.7,+DG2,0)):+$P(^(0),U,2),1:0)
 Q
TREAT1 S TSXDT="" F DGID=0:0 S DGID=$O(^DGPM("ATS",DFN,DGA1,DGID)) Q:'DGID  F DGS=0:0 S DGS=$O(^DGPM("ATS",DFN,DGA1,DGID,DGS)) Q:'DGS  F DGDA=0:0 S DGDA=$O(^DGPM("ATS",DFN,DGA1,DGID,DGS,DGDA)) Q:'DGDA  I $D(^DGPM(+DGDA,0)) S DGX=^(0) D TR2
 Q
TR2 I +DGX<(DGT+.1)&(+DGX<+DG2) S DG2=DGS,DGTS=DGS I +$P(DGX,"^")>+$P(DGCA,"^") S Y=$P(DGX,"^") X ^DD("DD") S TSXDT=Y
 I $P(DGX,"^",6)]"" S DGW=$P(DGX,"^",6)
 Q
