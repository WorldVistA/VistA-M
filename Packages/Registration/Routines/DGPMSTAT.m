DGPMSTAT ;ALB/JDS - DETERMINE INPATIENT STATUS - FORMERLY DGINPW ;01 JAN 1986
 ;;5.3;Registration;**36,246**;Aug 13, 1993
 ;
 ;  Note: This used to be named 'DGINPW'
 ;                               ------
 ;
EN ; -- call to return coresp adm and mvt data of pt as of a date
 ;    input:  DFN     => patient file ifn
 ;            DGT     => date to check if pt was inpatient
 ;   output:  DGA1    => coresp adm mvt ifn of ^DGPM
 ;            DG1     => ward ^ room-bed ^ mvt type(for xfrs only)
 ;            DGXFR0  => Oth of last xfr mvt for admission
 ; -- init
 N MT,IAD,IMD,DGCA,DGDC ; Inverse Adm Date & Inverse Mvt Date
 S DG1=""
 ;
 ; -- scan adms for pt
 ; -- if still inpt or d/c > DGT date then continue to CA
 ;F IAD=9999999.9999998-DGT:0 S IAD=$O(^DGPM("ATID1",DFN,IAD)) Q:'IAD  S DGA1=+$O(^(IAD,0)) I $D(^DGPM(DGA1,0)),$S('$D(^DGPM(+$P(^(0),"^",17),0)):1,1:^(0)>DGT) D CA Q:DG1
 F IAD=9999999.9999998-DGT:0 S IAD=$O(^DGPM("ATID1",DFN,IAD)) Q:'IAD  S DGA1=+$O(^(IAD,0)),DGCA=$G(^DGPM(DGA1,0)),DGDC=$G(^DGPM(+$P(DGCA,U,17),0)) D  Q:DG1!($P(DGCA,U,18)'=40)
 .I 'DGDC!(DGDC>DGT) D CA I $P(%,U,18)=43!($P(%,U,18)=45) S DG1="" Q
 K DGNO Q
 ;
CA ; -- scan mvts for cor. adm that happened on or before DGT date 
 ; -- if mvt is adm or xfr then set DG1
 ; -- if mvt is xfr then continue to XFR
 S %=""
 F IMD=9999999.9999998-DGT:0 S IMD=$O(^DGPM("APMV",DFN,DGA1,IMD)) Q:'IMD  I $D(^DGPM(+$O(^(IMD,0)),0)) S %=^(0),MT=$P(%,"^",2) I MT=1!(MT=2) S DG1=$P(%,"^",6,7) D XFR:MT=2 Q:DG1
CAQ Q
 ;
XFR ; -- set DG1="" if XFR to asih(oth fac)  --ELSE--  add MVT type to DG1
 S DGXFR0=%,DG1=$S($P(%,"^",18)=13:"",1:DG1_"^"_$P(%,"^",18))
 Q
 ;
TREAT S DG2=0 D EN:'$D(DG1) Q:'DG1  S DG2=9999999 D TREAT1
 I +DG2=9999999 S DG2=0 Q
 S DG2=$S($D(^DIC(45.7,+DG2,0)):+$P(^(0),U,2),1:0)
 Q
TREAT1 F DGID=0:0 S DGID=$O(^DGPM("ATS",DFN,DGA1,DGID)) Q:'DGID  F DGS=0:0 S DGS=$O(^DGPM("ATS",DFN,DGA1,DGID,DGS)) Q:'DGS  F DGDA=0:0 S DGDA=$O(^DGPM("ATS",DFN,DGA1,DGID,DGS,DGDA)) Q:'DGDA  I ^DGPM(+DGDA,0) S DGX=^(0) D TR2
 Q
TR2 I +DGX<(DGT+.1)&(+DGX<+DG2) S DG2=DGS
 Q
DGT(X) ; FIGURE OUT WHICH TYPE OF DATE TO USE FOR DGWARDWHEN
 ;  Input:  X=Date in either FM format or regular date
 ; Output:  Date in FM format
 N Y,%DT
 I '$D(X) S X=DT G DGTQ
 S %DT="T" D ^%DT S X=Y
DGTQ Q X
