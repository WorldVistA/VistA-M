ENEQRP ;(WASH ISC)/DH-Equipment Report Driver ;6-8-89
V ;;7.0;ENGINEERING;;Aug 17, 1993
 ;
 S %OPT="OPT"
SE D:'$D(DT) DT^DICRW S U="^",S=";",%O=$T(@(%OPT))
 I $D(^DOPT($P(%O,S,5),"VERSION")),($P($T(V),S,3)=^DOPT($P(%O,S,5),"VERSION")) G IN
 K ^DOPT($P(%O,S,5))
 F I=1:1 Q:$P($T(@(%OPT)+I),S,3)=""  S %OP=I,^DOPT($P(%O,S,5),I,0)=$P($T(@(%OPT)+I),S,3),^DOPT($P(%O,S,5),"B",$P($P($T(@(%OPT)+I),S,3),"^",1),I)=""
 S K=I-1,^DOPT($P(%O,S,5),0)=$P(%O,S,4)_U_1_U_K_U_K K I,K,X S ^DOPT($P(%O,S,5),"VERSION")=$P($T(V),S,3)
IN I $P(%O,S,6)'="" D @($P(%O,S,6))
PR Q:'$D(%OPT)  K %O(1) S %O=$T(@(%OPT)),S=";",IOP="HOME" S:$P(%O,S,9)'="" %O(1)="" D ^%ZIS K IOP W:IOST'["PK-" @IOF
 I $P(%O,S,7)'="" D @($P(%O,S,7))
 I $P(%O,S,7)="" W !!,$P(%O,S,3),":",!,$P($T(V),S,3),!! I '$D(%O(1)) W $P(%O,S,4),"S:",!
 F J=1:1 Q:$P($T(@(%OPT)+J),S,3)=""  S %OP=J,K=$S(J<10:15,1:14) I '$D(%O(1)) W !,?K,J,". ",$P($T(@(%OPT)+J),S,3)
RE W ! S DIC="^DOPT("_""""_$P($T(@(%OPT)),S,5)_""""_",",DIC(0)="AEQMN" D ^DIC G:X=""!(X=U) EXIT G:Y<0 RE K DIC,J,%O X $P($T(@(%OPT)+Y),S,4) G PR
HDR W @IOF,!!,"EQUIPMENT MANAGEMENT REPORTS",!,"Version ",^ENG("VERSION"),! Q
EXIT I $P($T(@(%OPT)+(%OP+1)),S,4)'="" X $P($T(@(%OPT)+(%OP+1)),S,4)
 K DIC,G,J,%OP I $P(%O,S,8)'="" S %OPT=$P(%O,S,8) G SE
OUT K K,S,%OPT,%O Q
 ;
OPT ;;ENINGEERING EQUIPMENT MANAGEMENT MODULE;EQUIPMENT REPORT;ENEQRP;
 ;;SPECIFIC ITEM HISTORY;D HS^ENEQRP1
 ;;EQUIPMENT TYPE HISTORY;D HD^ENEQRP2
 ;;INVENTORY LISTING;D ^ENEQRPI
 ;;WARRANTY LIST;D W^ENEQRP1
 ;;REPLACEMENT LISTING;D R^ENEQRP1
 ;;FAILURE RATE REPORT;D F^ENEQRP3
 ;;PM WORKLOAD ANALYSIS;D EN^ENEQRP5
