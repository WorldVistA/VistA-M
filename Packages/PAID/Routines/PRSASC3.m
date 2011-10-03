PRSASC3 ; HISC/REL,WOIFO/JAH - Supervisor Approve Prior PP Actions ;2/16/05
 ;;4.0;PAID;**6,93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
DIS ; Display PP Action
 N IFN
 S Z=$G(^PRST(458,PPI,"E",DFN,"X",AUN,0)),TYP=$P(Z,"^",4) D DT:TYP="T",DV:TYP="V",DH:TYP="H"
 I $D(^PRST(458,PPI,"E",DFN,"X",AUN,7)) W !!,"Change Remarks: ",^(7)
 Q
DT ; Display Time
 S DAY=$P($G(^PRST(458,PPI,"E",DFN,"X",AUN,1)),"^",1) Q:'DAY
 W !!,?28,"Prior Pay Period Change"
 W !,?7,"Date",?21,"Scheduled Tour",?46,"Tour Exceptions"
 W !?3,"------------------------------------------------------------------------"
 S DTE=$P($G(^PRST(458,PPI,2)),"^",DAY) S IFN=AUN+1 D GET^PRSAPPP D F0^PRSAPPQ Q
DV ; Display VCS/Fee changes
 S PAYP=$P($G(^PRSPC(DFN,0)),"^",21)
 S DTE=$P($G(^PRST(458,PPI,2)),"^",1)
 W !!,$S(PAYP="F":"Fee Basis",1:"VCS Sales")," Adjustment for Pay Period beginning ",DTE
 S IFN=AUN+1 D GET^PRSAPPP S Z=AUR(1) D VCS^PRSAPPQ Q
DH ; Display ED changes
 S DTE=$P($G(^PRST(458,PPI,2)),"^",1)
 W !!,"Envir. Differential Adjustment for Pay Period beginning ",DTE
 S IFN=AUN+1 D GET^PRSAPPP S Z=AUR(1) D ED^PRSAPPQ Q
APP ; Approve PP Action
 S DFN=$P(AP(5,NX),"^",1),ACT=$P(AP(5,NX),"^",2),PPI=$P(NX,"~",2),AUN=$P(NX,"~",3)
 S Z=$G(^PRST(458,PPI,"E",DFN,"X",AUN,0)),$P(^(0),"^",5)=ACT
 K ^PRST(458,NOD,DFN,PPI,AUN) S:"AS"[ACT ^PRST(458,"AX"_ACT,DFN,PPI,AUN)=""
 ; if second level approver then recalculate PTP's Hours bank
 I NOD="AXS" D
 .  S $P(^PRST(458,PPI,"E",DFN,"X",AUN,0),"^",8,9)=DUZ_"^"_NOW
 .  D PTP^PRSASR1(DFN,PPI)
 I NOD="AXR" S $P(^PRST(458,PPI,"E",DFN,"X",AUN,0),"^",10,11)=DUZ_"^"_NOW
 S TYP=$P(Z,"^",4) G AT:TYP="T",AV:TYP="V",AH:TYP="H"
 Q
AT ; Approve time
 Q:"DX"'[ACT
 ; If disapproved, un-do
 S DAY=$P($G(^PRST(458,PPI,"E",DFN,"X",AUN,1)),"^",1) Q:'DAY
 S IFN=AUN+1 D GET^PRSAPPP
 I AUC N L2 S L2=0 F L1=0,1,2,10,3,4 S L2=L2+1 S Z=$G(^PRST(458,PPI,"E",DFN,"X",AUN,L2)) K ^PRST(458,PPI,"E",DFN,"D",DAY,L1) I Z'="" S ^(L1)=Z
 ;if PTP corrected timecard is disapproved then call hrs bank API
 ;since the unapproved work node for the corrected tc may have been
 ;used in a call to the hours bank.  Call will quit if not PTP w/memo
 D PTP^PRSASR1(DFN,PPI)
 Q
AV ; Approve VCS/Fee Changes
 I "DX"'[ACT S:ACT="S" $P(^PRST(458,PPI,"E",DFN,2),"^",17,18)=DUZ_"^"_NOW Q
 ; If disapproved, un-do
 S IFN=AUN+1 D GET^PRSAPPP
 I AUC S Z=$G(^PRST(458,PPI,"E",DFN,"X",AUN,1)) K ^PRST(458,PPI,"E",DFN,2) S:Z'="" ^(2)=Z
 Q
AH ; Approve ED Changes
 Q:"DX"'[ACT
 ; if disapproved, un-do
 S IFN=AUN+1 D GET^PRSAPPP
 I AUC S Z=$G(^PRST(458,PPI,"E",DFN,"X",AUN,1)) K ^PRST(458,PPI,"E",DFN,4) S:Z'="" ^(4)=Z
 Q
