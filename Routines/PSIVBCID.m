PSIVBCID ;BIR/JLC - BAR CODE ID SUBROUTINES ;16 FEB 01
 ;;5.0; INPATIENT MEDICATIONS ;**58,80,146**;16 DEC 97
 ;
 ; Reference to ^PS(55 supported by DBIA 2191.
 ;
BCMA(PSJDFN,PSJON,PSIVCTD,PSIV1,PSIV2,PSIVNOL) ;determine unique ID# for bar code labels and update initial data for bar code ID
 ;Input:  PSJDFN - patient's DFN
 ;        PSJON - patient's ON - order number
 ;        PSJBCID - bar code ID to be filed
 ;        PSIVCTD - the $D(PSIVCT) from the calling routine, if PSIVCT was defined, then the labels won't be counted
 ;        PSIV1   - current label number
 ;        PSIV2   -
 ;        PSIVNOL - total number of labels
 ;
 ;Output:  PSJBCID - unique ID# for this label
 ;                   format:  DFN_"A"_ON"_seq#
 ;                   If unable to calculate ID #, return "ERROR"
 ;
 S PSIV1=$G(PSIV1),PSIV2=$G(PSIV2),PSIVNOL=$G(PSIVNOL)
 L +^PS(55,PSJDFN,"IVBCMA"):10
 E  W "Waiting for lock..." F  L +^PS(55,PSJDFN,"IVBCMA"):5 Q:$T  W "."
 S SEQ=$O(^PS(55,PSJDFN,"IVBCMA"," "),-1)
 S PSJBCID=PSJDFN_"V"_(SEQ+1)
 D UP1^PSIVBCID(DFN,ON,PSJBCID,PSIVCTD,PSIV1,PSIV2,PSIVNOL)
 L -^PS(55,PSJDFN,"IVBCMA")
 Q PSJBCID
 ;
UP1(DFN,ON,PSJBCID,PSIVCTD,PSIV1,PSIV2,PSIVNOL) ;update initial data for bar code ID
 ;Input:  DFN     - patient's IEN
 ;        ON      - Order number for this bar code ID
 ;        PSJBCID - bar code ID to be filed
 ;        PSIVCTD - the $D(PSIVCT) from the calling routine, if PSIVCT was defined, then the labels won't be counted
 ;        PSIV1   - current label number
 ;        PSIV2   -
 ;        PSIVNOL - total number of labels
 ;
 ;Output:  PSJBLN - label sequence number
 ;
 S PSIV1=$G(PSIV1),PSIV2=$G(PSIV2),PSIVNOL=$G(PSIVNOL)
 K DIC,DIE,DO S DIC(0)="L",DA(1)=DFN,X=PSJBCID,DIC="^PS(55,"_DA(1)_",""IVBCMA""," D FILE^DICN
 K DA,DR,DIE S DIE=DIC,DA=+Y,DA(1)=DFN,PSJBLN=DA D NOW^%DTC
 S DR=".02////"_+ON_";3////"_$S(PSIVCTD:0,1:1)_";4////"_$E(%,1,12)_";6////"_PSIV1_"["_$S(PSIV1:PSIVNOL,1:PSIV2)_"]" D ^DIE
 K DIC,DIE,D0,DA,DR
 Q
UP2(DFN,PSJBLN,PSIV,YY) ;update additive data for bar code ID
 ;
 ;Input:  DFN    - Patient's IEN
 ;        PSJBLN - The IEN for the bar code ID
 ;        PSIV   - the sequence number for this additive
 ;        YY     - ADDITIVE ^ STRENGTH ^ BOTTLE
 ;
 K DA,DR,DIC,DO S DIC(0)="L",DA(1)=DFN,DA(2)=PSJBLN,X=PSIV,DIC="^PS(55,"_DA(1)_",""IVBCMA"","_DA(2)_",""AD""," D FILE^DICN
 K DA,DR,DIE S DIE=DIC,DA=+Y,DA(1)=PSJBLN,DA(2)=DFN S DR=".01////"_$P(YY,U)_";1////"_$P(YY,U,2)_";2////"_$P(YY,U,3) D ^DIE
 K DA,DR,DIC,D0,DIE
 Q
 ;
UP3(DFN,PSJBLN,PSIV,YY) ;update solution data for bar code ID
 ;
 ;Input:  DFN    - Patient's IEN
 ;        PSJBLN - The IEN for the bar code ID
 ;        PSIV   - the sequence number for this solution
 ;        YY     - SOLUTION ^ VOLUME
 ;
 K DA,DR,DIC,DO S DIC(0)="L",DA(1)=DFN,DA(2)=PSJBLN,X=$P(PSIV,U),DIC="^PS(55,"_DA(1)_",""IVBCMA"","_DA(2)_",""SOL""," D FILE^DICN
 K DA,DR,DIE S DIE=DIC,DA=+Y,DA(1)=PSJBLN,DA(2)=DFN S DR=".01////"_$P(YY,U)_";1////"_$P(YY,U,2) D ^DIE
 K DA,DR,DIC,D0,DIE
 Q
