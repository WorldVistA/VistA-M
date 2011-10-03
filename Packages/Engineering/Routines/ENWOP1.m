ENWOP1 ;(WASH ISC)/DH-Work Order Print (cont'd) ;4.8.97
 ;;7.0;ENGINEERING;**6,21,35**;Aug 17, 1993
WDAT K EN S $P(EN," ",50)=""
 S EN(0)=$E(ENWOR_EN,1,16)
 S EN(1)=EN I ENRDA]"" S EN(1)=$E(ENRDA,4,5)_"/"_$E(ENRDA,6,7)_"/"_$E(ENRDA,2,3)_EN
 S EN(0)=EN(0)_$E(EN(1),1,9)
 S EN(1)=ENLOC_EN,EN(0)=EN(0)_$E(EN(1),1,15)_" "
 S EN(1)=ENEQ_EN,EN(0)=EN(0)_$E(EN(1),1,11)
 S EN(1)=ENRQR_EN,EN(0)=EN(0)_$E(EN(1),1,16)
 S EN(0)=EN(0)_$E(ENPRI_EN,1,4)_" "_ENSTAT
 W EN(0),!
 S EN(0)=$E(" "_ENTEC_EN,1,21)_" "_ENDPR
 W EN(0),!
 I $D(ENY) S ENY=ENY+2
FACC ;FETCH + WRITE ACCOUNTS DATA FOR WORK ORDER
 S ENAC="" I $D(^ENG(6920,DA,4))>0 S ENAC=$P(^(4),U,2)
 I ENAC="" G NEXT
 I $D(^PRCS(410,ENAC,0))>0 W ?2,$P(^(0),U,1)
 E  G NEXT
 I $D(^PRCS(410,ENAC,1)),$P(^(1),U,5) S Z=$P(^(1),U,5) I $D(^PRCS(410.2,Z,0)) W ?21,$E($P(^(0),U,1),1)
 I $D(^PRCS(410,ENAC,2)),$P(^(2),U,1)'="" W ?23,$E($P(^(2),U,1),1,26)
 I $D(^PRCS(410,ENAC,4)),$P(^(4),U,5)'="" W ?51,$P(^(4),U,5)
 I $D(^PRCS(410,ENAC,9)),$P(^(9),U,2) S X=$P(^(9),U,2) W ?59,$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 I $D(^PRCS(410,ENAC,9)),$P(^(9),U,3) S X=$P(^(9),U,3) W ?69,$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 W ! S ENY=ENY+1 K X
NEXT W:$E(IOST,1,2)="C-" @ENLO
 Q
 ;ENWOP1
