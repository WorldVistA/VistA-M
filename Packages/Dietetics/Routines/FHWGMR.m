FHWGMR ; HISC/NCA - Signed Reaction Event Filer ;2/16/96  11:37
 ;;5.5;DIETETICS;**8**;Jan 28, 2005;Build 28
EN1 ; File Entered Signed Reaction
 Q:+$$VERSION^XPDUTL("GMRA")'=4
 S FLG=1 D CHK G:'FLG KIL
 S EVT="M^O^^"_"Allergy - "_ALG D FIL
 I FHGMRN'="" D UPDFP
 G KIL
CAN ; File Cancelled/Entered in Error Allergy
 S FLG=1 D CHK G:'FLG KIL
 S EVT="M^O^^"_"Allergy - "_ALG_" Cancelled" D FIL
 I FHGMRN'="" D CANFP
 G KIL
FIL ; File Event
 D ^FHORX
 Q
KIL K %,%H,%I,ADM,ALG,COM,DFN,FHSTR,FHTYP,FHWRD,FLG,FHALGN,FHGMRN,FHFPN,FHFPIEN,X Q
CHK ; Check Validity of Data Passed
 I 'GMRAPA!($G(GMRAPA(0))="") G ERR
 S FHSTR=$G(GMRAPA(0)),DFN=+FHSTR G:'DFN ERR
 S FHALGN=$P(FHSTR,U,3)
 S FHGMRN="" I $P(FHALGN,";",2)="GMRD(120.82," S FHGMRN=$P(FHALGN,";",1)
 S FHZ115="P"_DFN D CHECK^FHOMDPA I FHDFN="" G ERR
 S ALG=$P(FHSTR,"^",2) G:ALG="" ERR
 G:'$D(^FHPT(FHDFN)) ERR S FHWRD=$G(^DPT(DFN,.1)) ;G:FHWRD="" ERR
 S ADM="" I FHWRD'="" S ADM=$G(^DPT("CN",FHWRD,DFN)) ;G:ADM<1 ERR
 G:'$P(FHSTR,"^",12) ERR
 S FHTYP=$P(FHSTR,"^",20) G:FHTYP'["F" ERR
 Q
UPDFP ;Automatically add FP's corresponding to the Allergy
 D ^FHSELA2
UPDFP1 I $O(^FH(115.2,"C",FHGMRN,""))="" D MISSFP Q  ;No Corr FP for FHGMRN
 F FHFPN=0:0 S FHFPN=$O(^FH(115.2,"C",FHGMRN,FHFPN)) Q:FHFPN'>0  D ADD
 Q
ADD ;Add the FP(s) to the patient record
 I $O(^FHPT(FHDFN,"P","B",FHFPN,"")) Q  ;pt already has the FP
 I $G(^FH(115.2,FHFPN,"I"))="Y" Q  ;don't assign INACTIVE FP's
 S Y=FHFPN K DIC,DO S DA(1)=FHDFN,DIC="^FHPT("_DA(1)_",""P"","
 S DIC(0)="L",DIC("P")=$P(^DD(115,10,0),U,2),X=+Y
 D FILE^DICN I Y=-1 Q
 K DIE S DA=+Y,DA(1)=FHDFN,DIE="^FHPT("_DA(1)_",""P"","
 S DR="1////^S X=""BNE""" D ^DIE
 S COM="Add "_$P($G(^FH(115.2,FHFPN,0)),U,1)_" (BNE) (D)"
 S EVT="P^O^^"_COM D ^FHORX
 Q
MISSFP ;
 I '$D(^GMRD(120.82,FHGMRN,0)) Q  ;bad pointer/entry
 S FHANAME=$P($G(^GMRD(120.82,FHGMRN,0)),U,1)
 S FHPTNM=$P($G(^DPT(DFN,0)),U,1)
 S FHRR="" F  S FHRR=$O(^TMP($J,"FHALG",FHRR)) Q:FHRR=""  S FHRRNM=$P(^TMP($J,"FHALG",FHRR),";",2,99) D
 .S FHZ=0 F  S FHZ=FHZ+1,FHANMZZ=$P(FHRRNM,";",FHZ) Q:FHANMZZ=""  D
 ..I FHANMZZ=FHANAME S ^TMP($J,"FHMISS",FHRR,FHPTNM)=FHANAME
 Q
CANFP ;Automatically cancel FP's corresponding to Allergy Entered in Error
 I $O(^FH(115.2,"C",FHGMRN,""))="" Q  ;No Corr FP for this GMRA Allergy
 F FHFPN=0:0 S FHFPN=$O(^FH(115.2,"C",FHGMRN,FHFPN)) Q:FHFPN'>0  D REM
 Q
REM ;Remove the FP(s) from the patient record
 I '$O(^FHPT(FHDFN,"P","B",FHFPN,"")) Q  ;pt does not have the FP
 S FHFPIEN=$O(^FHPT(FHDFN,"P","B",FHFPN,""))
 S DA(1)=FHDFN,DA=FHFPIEN,DIK="^FHPT("_DA(1)_",""P""," D ^DIK
 S COM="Del "_$P($G(^FH(115.2,FHFPN,0)),U,1)_" (BNE) (D)"
 S EVT="P^O^^"_COM D ^FHORX
 Q
ERR S FLG=0 Q
