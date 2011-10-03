SDCO21 ;ALB/RMO - Classification Cont. - Check Out;30 MAR 1993 2:10 pm ; 3/12/04 4:33pm
 ;;5.3;Scheduling;**150,244,325,441**;Aug 13, 1993;Build 14
 ;
CL(DFN,SDDT,SDOE,SDCLY) ;Build Classification Array
 ; Input  -- DFN      Patient file IEN  
 ;           SDDT     Date/Time
 ;           SDOE     Outpatient Encounter file IEN  [Optional]
 ; Output -- SDCLY    Classification Array
 ;                    Subscripted by Class. Type file (#409.41) IEN
 N SDCTI
 S SDCTI=0 F  S SDCTI=$O(^SD(409.41,SDCTI)) Q:'SDCTI  I $$SCR(SDCTI,DFN,SDDT,$G(SDOE)) S SDCLY(SDCTI)=""
CLQ Q
 ;
SCR(SDCTI,DFN,SDDT,SDOE) ;Outpatient Classification Type Screen
 ; Input  -- SDCTI    Outpatient Classification Type IEN
 ;           DFN      Patient file IEN  
 ;           SDDT     Date/Time
 ;           SDOE     Outpatient Encounter file IEN  [Optional]
 ; Output -- 1=Yes and 0=No
 N Y
 I $$ACT^SDCODD(SDCTI,SDDT) D
 .I $D(^SD(409.41,SDCTI,1)) X ^(1) Q:'$T
 .S Y=1
SCRQ Q +$G(Y)
 ;
CLOE(SDOE,SDCLOEY) ;Set-up Classification Array for Outpatient Encounter
 ; Input  -- SDOE     Outpatient Encounter file IEN
 ; Output -- SDCLOEY  Classification Array Set for Outpatient Encounter
 ;                    Subscripted by Class Type file IEN
 ;                    Null or 409.42 IEN^Internal Value^1=n/a^1=unedt
 N SDCLY,SDCN0,SDCNI,SDCTI,SDCTIS,SDCTS,SDOE0
 S SDOE0=$G(^SCE(+SDOE,0))
 D CL($P(SDOE0,"^",2),+SDOE0,SDOE,.SDCLY)
 S SDCTI=0 F  S SDCTI=$O(^SDD(409.42,"AO",SDOE,SDCTI)) Q:'SDCTI  S SDCNI=+$O(^(SDCTI,0)) I $D(^SDD(409.42,SDCNI,0)) S SDCN0=^(0) D
 .S SDCLY(SDCTI)=SDCNI_"^"_$P(SDCN0,"^",3)_"^"_$S('$D(SDCLY(SDCTI)):1,1:"")_"^"_$S($P(SDOE0,"^",10)=2:1,1:"")
 S SDCTIS=$$SEQ
 F SDCTS=1:1 S SDCTI=+$P(SDCTIS,",",SDCTS) Q:'SDCTI  I $D(SDCLY(SDCTI)) S SDCLOEY(SDCTI)=SDCLY(SDCTI)
CLOEQ Q
 ;
SC(SDCTI,SDOE,SDSELY,SDCLOEY) ;Service Connected Classification Checks
 N SDCHGF,SDCLOE,SDSEL
 S SDSEL=$S(SDCTI=1:2,SDCTI=2:3,SDCTI=4:4,1:"") G SCQ:SDSEL=""
 D CHK(SDOE,SDCTI,.SDCLOE)
 I $D(SDCLOE) D  G SCQ
 .I SDCLOE,$P(SDCLOE,"^",3) S SDCHGF=1
 .I SDCLOE="" S SDCHGF=1
 .I $G(SDCHGF) S:$D(SDSELY) SDSELY(SDSEL)="" S SDCLOEY(SDCTI)=SDCLOE
 I '$D(SDCLOE) D
 .K SDCLOEY(SDCTI)
SCQ Q
 ;
CHK(SDOE,SDCTI,SDCLOE) ;Check One Classification for Outpatient Encounter
 ; Input  -- SDOE     Outpatient Encounter file IEN
 ;           SDCTI    Outpatient Classification Type IEN
 ; Output -- SDCLOE   Null or 409.42 IEN^Internal Value^1=n/a^1=unedt
 N DFN,SDCL,SDCNI,SDDT,SDOE0
 S SDOE0=$G(^SCE(+SDOE,0))
 S DFN=+$P(SDOE0,"^",2),SDDT=+SDOE0
 I $$SCR(SDCTI,DFN,SDDT,SDOE) S SDCL=""
 S SDCNI=+$O(^SDD(409.42,"AO",SDOE,SDCTI,0))
 I $D(^SDD(409.42,SDCNI,0)) S SDCL=SDCNI_"^"_$P(^(0),"^",3)_"^"_$S('$D(SDCL):1,1:"")_"^"_$S($P(SDOE0,"^",10)=2:1,1:"")
 I $D(SDCL) S SDCLOE=SDCL
CHKQ Q
 ;
SEQ() ;Classification Type Sequence by IEN
 ; Input  -- None
 ; Output -- Classification Type Sequence by IEN
 ;           Current Sequence is:  SC, CV, AO, IR, EC, SHAD, MST, HNC
 Q "3,7,1,2,4,8,5,6"
