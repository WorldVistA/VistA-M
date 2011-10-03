PSXNEW ;BIR/HTW/PWC-Rx Order Entry Screen for CMOP ;11 Mar 2002  4:38 PM
 ;;2.0;CMOP;**41**;11 Apr 97
 ; reference to ^PS(52.5 supported by DBIA #1978
 ; reference to ^PSRX    supported by DBIA #1977
 ; reference to EN^PSOHLSN1 supported by DBIA #2385
 ; reference to ^XTMP("ORLK-" supported by DBIA #4001
RESET(PSXRX,PSXFILL,PSXREAS) ;
OERR    ;clear ^XTMP("ORLK" if it is CPRS/CMOP
 N ORD S ORD=+$P($G(^PSRX(+$G(PSXRX),"OR1")),"^",2)
 I ORD,$D(^XTMP("ORLK-"_ORD,0)),^XTMP("ORLK-"_ORD,0)["CPRS/CMOP" K ^XTMP("ORLK-"_ORD)
 ;   Remove and test individual RX's
 N PSXRFD,PSXEDREL,PSOSITE,PSXSD,PSXLFD,PSXDFN,PSX525,PSXD,PSXZ,PSXRXF,PSXFDA
 ;       Q:If tradename
 Q:$G(^PSRX(PSXRX,"TN"))]""
 ;       Q: If Cancelled, Expired, Deleted, Drug Interactions, Hold
 Q:$P(^PSRX(PSXRX,"STA"),"^")>9!($P(^("STA"),"^")=4)!($P(^("STA"),"^")=3)
 ;       Find last fill
 S PSXRFD=+$O(^PSRX(PSXRX,1,"A"),-1)
 S PSXEDREL=$S(PSXRFD=0:$P($G(^PSRX(PSXRX,2)),"^",13),1:$P($G(^PSRX(PSXRX,1,PSXRFD,0)),"^",18))
 I PSXEDREL K DA,DIE,DR D
 . I PSXRFD=0 S DA=PSXRX L +^PSRX(DA):600 S DIE="^PSRX(",DR="31///@" D ^DIE L -^PSRX(DA)
 . I PSXRFD>0 S DA=PSXRFD,DA(1)=PSXRX L +^PSRX(DA(1),1,DA):600 S DIE="^PSRX(DA(1),1,",DR="17///@" D ^DIE L -^PSRX(DA(1),1,DA)
SUS ;       Auto-Suspend CMOPS
 N DA,Y
 S DA=PSXRX
 ;D NOW^%DTC ; need to reset back to original suspended date
 I PSXRFD=0 S %=$P(^PSRX(PSXRX,2),"^",2)
 I PSXRFD>0 S %=$P(^PSRX(PSXRX,1,PSXRFD,0),"^",1)
 S PSXSD=$P(%,".",1),PSXLFD=$E(%,4,5)_"-"_$E(%,6,7)_"-"_$E(%,2,3)
 S PSXRXS=$O(^PS(52.5,"B",PSXRX,0))
 I PSXRXS S DA=PSXRXS,DIK="^PS(52.5," D ^DIK S DA=PSXRX
 I $G(PSXRFD)>0 S PSOSITE=$P(^PSRX(PSXRX,1,PSXRFD,0),"^",9)
 I $G(PSXRFD)=0 S PSOSITE=$P(^PSRX(PSXRX,2),"^",9)
 S DIC="^PS(52.5,",DIC(0)="Z"
 K DD,DO S X=PSXRX,PSXDFN=$P(^PSRX(PSXRX,0),"^",2)
 S DIC("DR")=".02////"_PSXSD_";.03////"_PSXDFN_";.04////M;.05////0;.06////"_PSOSITE_";2////0;3////Q;9////"_PSXRFD
 D FILE^DICN K DIC,DIK,DD,DO
 I +Y>0 S PSX525=+Y
 E  D EXIT Q
LOCK525 ;        
 L +^PS(52.5,PSX525):600 G:'$T LOCK525
 K ^PS(52.5,"AC",PSXDFN,PSXSD,PSX525),PSXDFN
 L -^PS(52.5,PSX525)
 D SETRX
 D ACT
 S COMM="Rx# "_$P(^PSRX(PSXRX,0),"^")_" Has Been Suspended for CMOP Until "_PSXLFD_"."
 D EN^PSOHLSN1(PSXRX,"SC","ZS",COMM) K COMM
EXIT K PSXRXS,PSXLFD,PSXRXF,PSXFDA,PSXIR,PSXRX,PSXSD,PSXRXDA,PSXRFD,PSX
 K PSXEDREL,PSOSITE,PSX525,PSXDFN,PSXFIEN,PSXD,DIC,DIE,Y,X,%,%H,%I,%T,I
 Q
SETRX ; Check if last fill has been transmitted (0) or retransmitted (2) - 
 ; edit node and set to not dispensed (3).
 ; If already dispensed (1) or not dispensed (3), create new entry
 ; and set to not dispensed (3) with cancelled reason.
 S $P(^PSRX(PSXRX,"STA"),"^")=5
 K PSX S PSXZ=0
 F  S PSXZ=$O(^PSRX(PSXRX,4,PSXZ)) Q:'PSXZ  D
 . S PSXD=$G(^PSRX(PSXRX,4,PSXZ,0))
 . S FILL=$P(PSXD,U,3)
 . S:FILL'="" PSX($P(PSXD,U,3))=$P(PSXD,U,4)_"^"_PSXZ   ; PSX(FILL)=STATUS^IEN
 Q:'$D(PSX(PSXRFD))    ;last fill does not have entry in multiple
 S PSXST=$P(PSX(PSXRFD),U,1),PSXFIEN=$P(PSX(PSXRFD),U,2)
 I PSXST=0!(PSXST=2) D  Q
 . K DA,DIE,DIC,DR S DIE="^PSRX(DA(1),4,",DA(1)=PSXRX,DA=PSXFIEN
 . S DR="3////3;5////"_PSXSD_";8////"_$G(PSXREAS)
 . L +^PSRX(DA(1),4,DA):600
 . D ^DIE L -^PSRX(DA(1),4,DA) K DIC,DIK,DD,DO
 I PSXST=1!(PSXST=3) D
 . K DD,DO S X="",DIC="^PSRX("_PSXRX_",4,",DIC(0)="Z"
 . S DIC("DR")=".01////"_$P(PSXD,U,1)_";1////"_$P(PSXD,U,2)_";2////"_$P(PSXD,U,3)_";3////3;5////"_PSXSD_";8////"_$G(PSXREAS)
 . D FILE^DICN K DIC,DIK,DD,DO
 Q
ACT ;             adds activity info for CMOP Rx placed on suspense
 I '$D(PSXRXF) S PSXRXF=0 F I=0:0 S I=$O(^PSRX(PSXRX,1,I)) Q:'I  S PSXRXF=I
 S PSXIR=0 F PSXFDA=0:0 S PSXFDA=$O(^PSRX(PSXRX,"A",PSXFDA)) Q:'PSXFDA  S PSXIR=PSXFDA
 S PSXIR=PSXIR+1,^PSRX(PSXRX,"A",0)="^52.3DA^"_PSXIR_"^"_PSXIR
 D NOW^%DTC
 I $G(PSXRXF)>5 S PSXRXF=PSXRXF+1
 ;S ^PSRX(PSXRX,"A",PSXIR,0)=%_"^S^"_DUZ_"^"_PSXRXF_"^"_" RX Resuspended for CMOP Disaster Recovery until "_PSXLFD
 S ^PSRX(PSXRX,"A",PSXIR,0)=%_"^S^"_DUZ_"^"_PSXRXF_"^"_" RX Resuspended for CMOP "_$G(PSXREAS)_" until "_PSXLFD
 Q
