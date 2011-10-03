PSOSTART ;BHAM ISC/SAB - pre init for v7 ;2/28/95 [ 07/29/96  9:15 AM ]
 ;;7.0;OUTPATIENT PHARMACY;**10**;DEC 1997
 ;this routine should only called by the KIDS installer
 ;Q:'$G(PSOINST)
 S (XQABT1,XQABT2,XQABT3)=$H,PSOIT=$P(XQABT1,",",2)
 ;master file update
 ;D EN1^PSSHL1 I $G(XPDABORT) K XQABT1,XQABT2,XQABT3 Q
 D:$P(^PS(59.7,1,49.99),"^")'="7.0"
 .S $P(^PS(59.7,1,49.99),"^",7)="",ZTDTH=$H,ZTRTN="POST^PSOPOST",ZTIO="",ZTDESC="Outpatient Pharmacy version 7.0 background conversion" D ^%ZTLOAD
 .S DIU(0)="DT" F DIU=52.41 D EN^DIU2 K DIU W "." ;deletes *REFILL WITH NON VERIFIED NEWS (#52.41) file
 K DIK,DA S DIK="^DD(52,",DA(1)=52 F DA=6,17,39.4,39.5 D ^DIK
 K DIK,DA S DIK="^DD(59,",DA(1)=59 F DA=.19,.093 D ^DIK
 K DIK,DA S DIK="^DD(52.11,",DA(1)=52.11 F DA=.01,1,4,6,7,8 D ^DIK
 K DIK,DA S DIK="^DD(59.3,",DA(1)=59.3,DA=2 D ^DIK
 K DA,DIK F DA=3,4,5,6,7 S DIK="^DD(50.9006,",DA(1)=50.9006 D ^DIK ;deletes duplicate fields in 50.9
 K DIK,DA
 I $P($G(^PS(54,0)),"^")'="RX CONSULT" D  W "."
 .K ^PS(54)
 .S %X="^DIC(54,",%Y="^PS(54," D %XY^%RCR K ^PS(54,0,"GL"),^PS(54,"%"),^PS(54,"%D") K ^DIC(54,"B") F I=0:0 S I=$O(^DIC(54,I)) Q:'I  K ^DIC(54,I)
 .S DIU="^DIC(54,",DIU(0)="" D EN^DIU2
 S DIU(0)="DT" F DIU=59.9 D EN^DIU2 K DIU W "." ;deletes pharmacy functions file
 K ^PSRX("AP"),DA,DIK S DIK="^DD(52,",DA(1)=52 F DA=10,100 D  ;removes old sig and status fields
 .I DA=10,$P($G(^DD(52,10,0)),"^",4)'="SIG;1" D ^DIK W "."
 .I DA=100,$P($G(^DD(52,100,0)),"^",4)'="STA;1" D ^DIK W "."
 ;delete Pharmacy Archive data
 K DA,DIK S DIK="^PSOARC(" F DA=0:0 S DA=$O(^PSOARC(DA)) Q:'DA  D
 .I $P($G(^PSOARC(DA,0)),"^"),$P($G(^(0)),"^",2),$D(^PSRX(DA,0)),$P($G(^(0)),"^",2) D ^DIK Q
 .K ^PSOARC(DA,0)
 K ^PSOARC("B"),^PSOARC("C")
 K DA,DIK
 Q
