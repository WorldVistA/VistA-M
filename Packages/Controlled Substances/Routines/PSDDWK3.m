PSDDWK3 ;BIR/JPW-Pharm Dispensing Worksheet (cont'd) ; 24 Aug 93
 ;;3.0; CONTROLLED SUBSTANCES ;**16,66**;13 Feb 97;Build 3
 ;
 ;References to ^PSD(58.8, supported by DBIA2711
 ;References to ^PSD(58.81 are supported by DBIA2808
 ;
UPDATE ;set zero node in 58.81 - ien^type^disp^disp date^drug^qty^^^^bal.fwd^stat^^mfg^lot#^exp.date^^disp#^naou^^req#
 I $D(XRTL) D T0^%ZOSV
 S STAT=$S(ACT="V":3,1:2) I DUZ'=PSDBY,$D(^XUSEC("PSJ RPHARM",DUZ)),ACT="V" S TECH=PSDBY,PSDBY=DUZ
 ;
 ;DAVE B (PSD*3*16) Locking more nodes
 F  L +^PSD(58.81,PSDREC,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 F  L +^PSD(58.8,ORDS,1,PSDR):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 S ^PSD(58.81,PSDREC,0)=PSDREC_"^2^"_ORDS_"^"_$S(ACT="V":PSDT,1:"")_"^"_PSDR_"^"_QTY_"^^^^"_BAL_"^"_STAT_"^^"_MFG_"^"_LOT_"^"_EXP_"^^"_PSDPN_"^"_NAOU_"^^"_REQ
 ;set the 1, 2 and CS nodes in 58.81 and update xrefs - (1) proc.by^disp.date^^^tech^req.date^ordered by, (1.5) ordered by pharm, (2) comments, (CS) cs.trans
 S ^PSD(58.81,PSDREC,1)=PSDBY_"^^^^"_TECH_"^"_REQDT_"^"_ORD
 S $P(^PSD(58.81,PSDREC,"CS"),"^",1)=1
 S:$P($G(^PSD(58.85,PSDN,2)),U,2) $P(^PSD(58.81,PSDREC,"CS"),U,6)=1
 S:ACT="P" $P(^PSD(58.81,PSDREC,1),"^",2)=PSDT
 S:PSDUZA ^PSD(58.81,PSDREC,1.5)=PSDUZA
 S $P(^PSD(58.81,PSDREC,9),U)=$P($G(^PSD(58.85,PSDN,2)),U,3)
 I $D(^PSD(58.85,PSDN,1,0)) S ^PSD(58.81,PSDREC,2,0)=^PSD(58.85,PSDN,1,0) D
 .F WORD=0:0 S WORD=$O(^PSD(58.85,PSDN,1,WORD)) Q:'WORD  S ^PSD(58.81,PSDREC,2,WORD,0)=^PSD(58.85,PSDN,1,WORD,0)
 K DA,DIK S DA=PSDREC,DIK="^PSD(58.81," D IX^DIK K DA,DIK
 ;update vault
 W "vault activity..."
 I '$D(^PSD(58.8,ORDS,1,PSDR,4,0)) S ^(0)="^58.800119PA^^"
 I '$D(^PSD(58.8,ORDS,1,PSDR,4,PSDREC,0)) K DA,DIC,DD,DO S DIC(0)="L",DLAYGO=58.8,DIC="^PSD(58.8,"_ORDS_",1,"_PSDR_",4,",DA(2)=ORDS,DA(1)=PSDR,(X,DINUM)=PSDREC D FILE^DICN K DA,DIC,DINUM,DD,DO
MON ;monthly summary data
 I '$D(^PSD(58.8,ORDS,1,PSDR,5,0)) S ^(0)="^58.801A^^"
 I '$D(^PSD(58.8,ORDS,1,PSDR,5,$E(DT,1,5)*100,0)) K DIC S DIC="^PSD(58.8,"_ORDS_",1,"_PSDR_",5,",DIC(0)="LM",DLAYGO=58.8,(X,DINUM)=$E(DT,1,5)*100,DA(2)=ORDS,DA(1)=PSDR D ^DIC K DIC,DA,DINUM,DLAYGO
 K DA,DIE,DR S DIE="^PSD(58.8,"_ORDS_",1,"_PSDR_",5,",DA(2)=ORDS,DA(1)=PSDR,DA=$E(DT,1,5)*100,DR="9////^S X=$P($G(^(0)),""^"",6)+QTY" D ^DIE K DA,DIE,DR
 ;update the entry in 58.85
 W "worksheet..."
 K DA,DIE,DR S DA=PSDN,DIE=58.85,DR="18////"_QTY_";16////"_PSDPN_";6////"_STAT_";Q;I X'=3 S Y=7;15////"_PSDT_";7////"_PSDREC_";17////"_TECH D ^DIE K DA,DIE,DR
 ;update the order in 58.8
 W "order..."
 K DA,DIE,DR S DA=REQ,DA(1)=PSDR,DA(2)=NAOU,DIE="^PSD(58.8,"_DA(2)_",1,"_DA(1)_",3,"
 S DR="2////"_ORDS_";4////"_PSDBY_";10////"_STAT_";Q;I X'=3 S Y=7;14////"_PSDT_";7////"_MFG_";8////"_LOT_";9////"_EXP_";16////"_PSDPN_";17////"_PSDREC_";19////"_QTY D ^DIE K DA,DIE,DR
 W "done.",!!,"This order is now "_$P($G(^PSD(58.82,+STAT,0)),"^")_".",!
 I $D(XRT0) S XRTN=$T(+0) D T1^%ZOSV
 ;
 ;DAVE B (PSD*3*16) unlock locked nodes
 L -^PSD(58.81,PSDREC,0)
 L -^PSD(58.8,ORDS,1,PSDR)
 Q
