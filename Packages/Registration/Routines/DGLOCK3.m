DGLOCK3 ;ALB/BOK,BAJ,JAM - PATIENT FILE MUMPS TRIGGER/DATA EDIT CHECKS ; 01/23/2006
 ;;5.3;Registration;**489,527,688,1014,1040**;Aug 13,1993;Build 15
 ; DG*5.3*688 BAJ 01/23/2006 Changed to support foreign confidential addresses
KILL S DGX=X I $D(^DPT(DFN,.32)) F DGKZ=0:0 S DGKZ=$O(DGBZ(DGKZ)) Q:'DGKZ  S X=$P(^DPT(DFN,.32),"^",DGKZ),$P(^(.32),"^",DGKZ)="" I X]"" S DGIZ=$S(DGKZ=20:.32945,1:(DGKZ/10000+.3281)) I $D(^DD(2,DGIZ,1)) D KILL1
 S X=DGX
 Q
KILL1 F DGJZ=0:0 S DGJZ=$O(^DD(2,DGIZ,1,DGJZ)) Q:'DGJZ  X ^(DGJZ,2)
 Q
S1 K DGBZ F DGKZ=9:1:13,20 S DGBZ(DGKZ)=""
 D KILL K DGBZ,DGIZ,DGJZ,DGKZ
 Q
S2 K DGBZ F DGKZ=14:1:18 S DGBZ(DGKZ)=""
 D KILL K DGBZ,DGIZ,DGJZ,DGKZ
 Q
CAD ;Confidential Address Edit
 I $S('$D(^DPT(DFN,.141)):1,$P(^(.141),U,9)'="Y":1,1:0) D
 .D EN^DDIOL("Requirement for Confidential Address data not indicated...NO EDITING!","","$C(7),!?4") K X
 Q
CADD ;Confidential Address Delete
 ;Called from input transform on Confidential Address fields
 Q:'$D(^DPT(DFN,.141))  I $P(^(.141),"^",9)="N"!($P(^(.141),"^",1,6)="^^^^^") D  Q
 .N DGFDA,DGERR
 .D CADM
 .I $D(DGFDA) D
 ..N DGX
 ..S DGX=X
 ..D FILE^DIE("","DGFDA","DGERR")
 ..S X=DGX
 ;
ASK W !,"Do you want to delete all confidential address data" S %=2 D YN^DICN I %Y["?" W !,"Answer 'Y'es to remove confidential address information, 'N'o to leave data in file" G ASK
ASK1 ;
 ; DG*5.3*1040 - Set DGTMOT on timeout. Calling routine checks for this variable to process timeout and cleanup this variable
 I $G(DTOUT) S DGTMOT=1
 Q:%'=1
 D EN^DGCLEAR(DFN,"CONF")
 D CADM
 N DGX
 S DGX=X
 D FILE^DIE("","DGFDA","DGERR")
 S X=DGX
 Q
CADM ;Delete data from Confidential Address Categories
 I $D(^DPT(DFN,.14)) D
 .N DGIEN
 .S DGIEN=0
 .F  S DGIEN=$O(^DPT(DFN,.14,DGIEN)) Q:'DGIEN  D
 ..S DGFDA(2.141,DGIEN_","_DFN_",",.01)=""
 Q
CADD1 ;Confidential Address Delete
 ;Called from Confidential Address "DEL" nodes
 I $D(^DPT(DFN,.141)),$P(^(.141),U,9)="Y" D
 .D EN^DDIOL("Answer NO to the 'CONFIDENTIAL ADDRESS ACTIVE' prompt to delete.","","$C(7),!?4") K X
 Q
 ; 
COV(DGELG) ; Rule for deleting COLLATERAL OF VET eligibility code  DG*5.3*1014;jam; 
 ; Cannot delete COV if there is an active CCP assigned to the Patient
 ; Invoked by:
 ; DELETE TEST - .361 (PRIMARY ELIGIBILITY) 
 ;             - .01  (ELIGIBILITY CODE) of the PATIENT ELIGIBILITIES subfile (.0361)
 ; Input: DGELG - Eligibility code being deleted (Optional - defaults to Primary Elig Code, field .361)
 ;
 I $G(DGELG)="" S DGELG=$$GET1^DIQ(2,DFN_",",.361,"I")
 ; OK if not deleting COLLATERAL OF VET
 I DGELG'=$$FIND1^DIC(8,"","B","COLLATERAL OF VET") Q
 N DGFLG,DGCCP
 S (DGFLG,DGCCP)=0
 F  S DGCCP=$O(^DPT(DFN,5,DGCCP)) Q:'DGCCP  I $G(^DPT(DFN,5,DGCCP,0))'="" D  Q:DGFLG
 . ; If CCP without an End Date - cannot delete COV
 . I '$P(^DPT(DFN,5,DGCCP,0),"^",4) S DGFLG=1
 I DGFLG D EN^DDIOL("This eligibility cannot be removed while there are active CCP(s) assigned to the Patient. Please advance to Data Group [2] on Screen <11.5> to remove the active CCP(s).") K X
 Q
