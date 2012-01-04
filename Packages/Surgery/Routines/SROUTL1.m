SROUTL1 ;BIR/ADM - UTILITY ROUTINE ;1/13/2011
 ;;3.0;Surgery;**134,175**;24 Jun 93;Build 6
ATT ; check for attend surg when completing case
 I $P($G(^SRF(DA,.1)),"^",13) Q
 D ASK I '$P($G(^SRF(DA,.1)),"^",13) K X
 Q
ASK N SREQ,X,Y
 D EN^DDIOL("The Attending Surgeon field has not been entered. You must first enter the",,"!!")
 D EN^DDIOL("Attending Surgeon before the computer will accept entry of the Time Patient",,"!")
 D EN^DDIOL("Out of O.R.",,"!")
 K DIR S DIR("A",1)="",DIR("A")="Attending Surgeon",DIR(0)="130,.164" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) Q
 I +Y S SREQ(130,DA_",",.164)=+Y D FILE^DIE("","SREQ","^TMP(""SR"",$J)")
 Q
ATTP ; check for attend provider when completing non-OR procedure
 I $P($G(^SRF(DA,"NON")),"^",7) Q
 D ASKP I '$P($G(^SRF(DA,"NON")),"^",7) K X
 Q
ASKP N SREQ,X,Y
 D EN^DDIOL("The Attending Provider field has not been entered. You must first enter",,"!!")
 D EN^DDIOL("the Attending Provider before the computer will accept entry of the Time",,"!")
 D EN^DDIOL("Procedure Ended.",,"!")
 K DIR S DIR("A",1)="",DIR("A")="Attending Provider",DIR(0)="130,124" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) Q
 I +Y S SREQ(130,DA_",",124)=+Y D FILE^DIE("","SREQ","^TMP(""SR"",$J)")
 Q
ZERO ; add leading zero to Dose amounts between 0 and 1 for clarity purposes, e.g. Dose entered as .5, will display as 0.5; called from input transform on the following Dose flds:
 ; .375 Medications mult 130.33, subfld 1 Time Adm mult 130.34, subfld 1 Dose
 ; .37 Anesthesia Technique mult 130.06, subfld 24 Anesthesia Agents mult 130.47, subfld 1 Dose (mg)
 ; .37 Anesthesia Technique mult 130.06, subfld 32 Test Does mult 130.48, subfld 1 Dose (mg)
 S:(X>0)&(X<1) X="0"_+X
 Q
