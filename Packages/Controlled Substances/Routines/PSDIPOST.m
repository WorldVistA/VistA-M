PSDIPOST ;BIR/JPW,LTL-Post-Init ; 7 Feb 95
 ;;3.0; CONTROLLED SUBSTANCES ;**2**;13 Feb 97
 S XQABT4=$H
CHECK ;check for Controlled Subs V2.0
 I $$VERSION^XPDUTL("PSD")'<2 S PSD(1)="CONTROLLED SUBSTANCES VERSION 2.0 has been previously installed,",PSD(2)="no post-init conversion required." D MES^XPDUTL(.PSD) K DIFQ,PSD G QUIT^PSDIPOS1
DEA ;marks ACTIVE drugs for CS use based on DEA special handling
 S PSD(1)="Using the DEA SPECIAL HANDLING data in your drug file I will now mark selected",PSD(2)="drugs for Controlled Substances use.",PSD(3)="Marking now..." D MES^XPDUTL(.PSD) K PSD
 S PSIUX="N",COUNT=0
 F PSD=0:0 S PSD=$O(^PSDRUG(PSD)) Q:'PSD  D
 .Q:'$D(^PSDRUG(PSD,0))  S OK=$S('$D(^PSDRUG(PSD,"I")):1,'+^("I"):1,+^("I")>DT:1,1:0) I 'OK Q
 .S PSDN=$P($G(^PSDRUG(PSD,0)),"^",3),OK=$S(PSDN[1:1,PSDN[2:1,PSDN[3:1,PSDN[4:1,PSDN[5:1,PSDN["A":1,PSDN["C":1,1:0) Q:'OK
 .Q:'$D(^PSDRUG(PSD,2))  S PSDN=$P($G(^PSDRUG(PSD,2)),"^",3),OK=$S(PSDN="":1,PSDN["O":1,PSDN["U":1,PSDN["I":1,1:0) Q:'OK
 .S PSIUDA=+PSD,COUNT=COUNT+1
 .S X="PSSGIU",PSDPSG=0 X ^%ZOSF("TEST") I $T D ENS^PSSGIU S PSDPSG=1
 .I 'PSDPSG D ENS^PSGIU
 .K PSDPSG
 S PSD="A total of "_COUNT_" drugs have been marked for CS package use."
 D MES^XPDUTL(PSD) K PSD
IND ;re-index 'ac' & 'ad' in 58.86
 D MES^XPDUTL("...Cleaning up 'AIU' cross reference in the DRUG file (#50)...") S X="AIU" F  S X=$O(^PSDRUG(X)) Q:X=""!($E(X,1,3)'="AIU")  K ^PSDRUG(X)
 K X
 D MES^XPDUTL("Re-indexing 'AIU' cross reference...") S DIK="^PSDRUG(",DIK(1)="63^AIU" D ENALL^DIK K DIK
 D MES^XPDUTL("Re-indexing the CS DESTRUCTION file...")
 K DA,DIK S DIK="^PSD(58.86,",DIK(1)=10 D ENALL^DIK K DIK,DA
 S PSD(1)="Re-indexing the DATE/TIME TURN IN DESTROY field in",PSD(2)="the DRUG ACCOUNTABILITY TRANSACTION file..." D MES^XPDUTL(.PSD) K PSD
 K DA,DIK S DIK="^PSD(58.81,",DIK(1)="37" D ENALL^DIK K DA,DIK
 D MES^XPDUTL("...the RECEIPT DATE/TIME...")
 K DA,DIK S DIK="^PSD(58.81,",DIK(1)="21" D ENALL^DIK K DA,DIK
 D MES^XPDUTL("ok.")
 K COUNT,DIC,DIK,DLAYGO,NODE,OK,PSD,PSD1,PSD2,PSDN,PSIUA,PSIUDA,PSIUX,X
 G ^PSDIPOS1
