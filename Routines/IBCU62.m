IBCU62 ;ALB/AAS - UTILITY ROUTINE TO SET BEDSECTION/REVENUE CODES FROM PTF DATA ; 29-OCT-90
 ;;2.0;INTEGRATED BILLING;**133**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;MAP TO DGCRU62
 ;
SETREV ;find current active revenue codes for bedsection
 S (DGREV,DGBR)=0,DGACTDT=-(IBIDS(151)+.01) K DGFND
 F  S DGACTDT=$O(^DGCR(399.5,"AIVDT",DGBSI,DGACTDT)) Q:'DGACTDT!($D(DGFND))  D
 . F  S DGREV=$O(^DGCR(399.5,"AIVDT",DGBSI,DGACTDT,DGREV)) Q:'DGREV  D
 .. F  S DGBR=$O(^DGCR(399.5,"AIVDT",DGBSI,DGACTDT,DGREV,DGBR)) Q:'DGBR  D CHKREV,STORREV:IBCHK
 Q
CHKREV ;check if billing rate (dgbr) is active, and use with payer.
 S IBCHK=0
 S DGBRN=^DGCR(399.5,DGBR,0) I '$P(DGBRN,"^",5) Q  ;quit if inactive
 I IBIDS(.11)="i",$P(DGINPAR,"^",2)="",+$P(DGBRN,"^",7) Q  ;quit if non-standard rate
 I IBIDS(.11)'="i",+$P(DGBRN,"^",7) Q  ;non-standard rates only for ins.
 S DGREV00="00"_DGREV I IBIDS(.11)="i",$P(DGINPAR,"^",2)]"",$P(DGINPAR,"^",2)'[$E(DGREV00,$L(DGREV00)-2,$L(DGREV00)) Q  ;quit if revenue code not in exception list 
 I $P(DGBRN,U,6)[IBIDS(.11) S:'$D(DGFND) DGFND="" S IBCHK=1 Q
 Q
STORREV ;store revenue code in revenue code file
 S X=$P(^DGCR(399.5,DGBR,0),"^",3),DGAMNT=$P(^(0),"^",4),DA(1)=IBIFN,DIC(0)="L",DIC="^DGCR(399,IBIFN,""RC"",",DGFUNC="Adding"
 I $D(^DGCR(399,IBIFN,"RC","ABS",X,DGBSI)) S DA=$O(^DGCR(399,IBIFN,"RC","ABS",X,DGBSI,0)),DGFUNC="Editing" G EDITREV
 D FILE,WRT
 Q
 ;
FILE ;manually file entry, index with ix1^dik to use compiled x-ref
 I '$D(DGREVHDR) D REVHDR
 I IBIDS(.11)="c",IBIDS(.05)<3 S DGBSLOS=1
 L ^DGCR(399,IBIFN):1
 S DA=$P(^DGCR(399,IBIFN,"RC",0),"^",3)
 F DGLL=0:0 S DA=DA+1 Q:'$D(^DGCR(399,IBIFN,"RC",DA,0))
 ;S ^DGCR(399,IBIFN,"RC",DA,0)=X_"^"_DGAMNT_"^"_DGBSLOS_"^^"_DGBSI_$S($D(DGPROC)&($D(DGDIV)):"^"_DGPROC_"^"_DGDIV,1:"")
 S ^DGCR(399,IBIFN,"RC",DA,0)=X_"^"_DGAMNT_"^"_DGBSLOS_"^^"_DGBSI_"^"_$G(DGPROC)_"^"_$G(DGDIV)_"^"_1
 S ^DGCR(399,IBIFN,"RC",0)=$P(^DGCR(399,IBIFN,"RC",0),"^",1,2)_"^"_DA_"^"_($P(^DGCR(399,IBIFN,"RC",0),"^",4)+1)
 S DIK="^DGCR(399,"_DA(1)_",""RC""," D IX1^DIK L ^DGCR(399,IBIFN):1
 Q
 ;
EDITREV ;edit revenue code data.
 I '$D(DGREVHDR) D REVHDR
 I IBIDS(.11)="c",IBIDS(.05)<3 S DGBSLOS=1
 S DIE=DIC,DA(1)=IBIFN,DR=".02///"_DGAMNT_";.03///"_DGBSLOS_";.05///"_DGBS D ^DIE
 ;
WRT ;S Z="00"_$P(^DGCR(399.5,DGBR,0),"^",3) W:'$G(IBAUTO) !,DGFUNC,?12,$E(Z,($L(Z)-2),$L(Z)),?24,DGBSLOS,?31,"$",$J(DGAMNT,8,2),?44,DGBS
 S Z="00"_$P(^DGCR(399.5,DGBR,0),"^",3)
 W:'$G(IBAUTO) !,DGFUNC,?12,$E(Z,($L(Z)-2),$L(Z)),?24,DGBSLOS,?31,"$",$J(DGAMNT,8,2),?44,DGBS I +$G(DGPROC) W ?65,$P($$CPT^ICPTCOD(+DGPROC),U,2)
 Q
REVHDR S DGREVHDR=1 W:'$G(IBAUTO) !,"Updating Revenue Codes",!?10,"REV. CODE",?22,"UNITS",?31,"CHARGE",?44,"BEDSECTION" I $D(DGPROC) W:'$G(IBAUTO) ?65,"PROCEDURE"
