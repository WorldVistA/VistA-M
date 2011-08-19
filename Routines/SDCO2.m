SDCO2 ;ALB/RMO - Classification - Check Out;30 DEC 1992 1:10 pm
 ;;5.3;Scheduling;**27,132**;08/13/93
 ;
EN ;Entry point for SDCO CLASSIFICATION protocol
 ; Input  -- SDOE
 N I,SDCLI,SDCLOEY,SDCOMF,SDCOQUIT,SDCTI,SDI,SDLINE,SDSEL,SDSELY
 S VALMBCK=""
 ;
 IF '$$EDITOK^SDCO3(SDOE,1) G Q
 ;
 N SDVISIT
 S SDVISIT=$P($G(^SCE(+SDOE,0)),U,5)
 S X=$$INTV^PXAPI("SCC","SD","PIMS",SDVISIT)
 D BLD^SDCO S VALMBCK="R"
Q Q
 ;
ASK(SDOE,SDCLOEY,SDCLHDL,SDCOQUIT) ;Ask Outpatient Classifications
 ; Input  -- SDOE     Outpatient Encounter file IEN
 ;           SDCLOEY  Classification Array for Outpatient Encounter
 ;           SDCLHDL  Classification Event Handle  [Optional]
 ; Output -- SDCOQUIT User entered '^' or timeout
 N I,IOINHI,IOINORM,SDCTI,SDCTIS,SDCTS,SDEVTF,X
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 I '$D(SDCLOEY) G ASKQ
 W !!,"--- ",IOINHI,"Classification",IOINORM," --- [",IOINHI,"Required",IOINORM,"]"
 I '$G(SDCLHDL) N SDATA,SDCLHDL S SDEVTF=1 D EVT^SDCOU1(SDOE,"BEFORE",.SDCLHDL,.SDATA)
 W ! S SDCTIS=$$SEQ^SDCO21
 F SDCTS=1:1 S SDCTI=+$P(SDCTIS,",",SDCTS) Q:'SDCTI!($D(SDCOQUIT))  D
 .I $D(SDCLOEY(SDCTI)) D
 ..D ONE^SDCO20(SDCTI,SDCLOEY(SDCTI),SDOE,.SDCOQUIT)
 ..I SDCTI=3 F I=1,2,4 D SC^SDCO21(I,SDOE,"",.SDCLOEY)
 I $G(SDEVTF) D EVT^SDCOU1(SDOE,"AFTER",SDCLHDL,.SDATA)
ASKQ Q
 ;
CLASK(SDOE,SDCLOEY) ;Ask Classifications on Check Out
 ; Input  -- SDOE     Outpatient Encounter file IEN
 ; Output -- SDCLOEY  Classification Array for Outpatient Encounter
 ;                    Subscripted by Class Type file IEN
 ;                    Null or 409.42 IEN^Internal Value^1=n/a
 N SDOE0,SDORG
 S SDOE0=$G(^SCE(+SDOE,0)),SDORG=+$P(SDOE0,"^",8)
 I $$REQ^SDM1A(+SDOE0)'="CO" G CLASKQ
 I SDORG=1,'$$CLINIC^SDAMU(+$P(SDOE0,"^",4)) G CLASKQ
 I "^1^2^"[("^"_SDORG_"^"),$$INP^SDAM2(+$P(SDOE0,"^",2),+SDOE0)="I" G CLASKQ
 I $$EXOE^SDCOU2(SDOE) G CLASKQ
 D CLOE^SDCO21(SDOE,.SDCLOEY)
CLASKQ Q
