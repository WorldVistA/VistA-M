IVMUFNC3 ;ALB/CPM - BILLING TRANSMISSION UTILITIES ; 13-JUN-94
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
REV(IVMREF,DFN,IVMCL,IVMTYP,IVMBF,IVMBT,IVMAB,IVMHLD) ; Interface w/ Rev fct.
 ;  Input:   IVMREF  --  Bill reference number
 ;              DFN  --  Pointer to the patient in file #2
 ;            IVMCL  --  Bill Classification [ 1-Inpt, 2-Opt ]
 ;           IVMTYP  --  Bill Type [ 2-Copayment, 3-Per Diem ]
 ;            IVMBF  --  Bill From Date in FM format
 ;            IVMBT  --  Bill To Date in FM format
 ;            IVMAB  --  Amount Billed
 ;           IVMHLD  --  Charge placed on hold? [ 1-Yes, 0-No ]
 ;
 ; Output:   New entry created in file #301.61
 ;
 N IVMTDA,DA,DIK
 I $G(IVMREF)=""!'$G(DFN) G REVQ
 S IVMTDA=$O(^IVM(301.61,"B",IVMREF,0))
 I 'IVMTDA S IVMTDA=$$ADD(IVMREF) I 'IVMTDA G REVQ
 ;
 D NOW^%DTC
 S $P(^IVM(301.61,IVMTDA,0),"^",2,12)=DFN_"^"_IVMCL_"^"_IVMTYP_"^"_IVMBF_"^"_IVMBT_"^"_$S($G(IVMHLD):"",1:DT)_"^"_IVMAB_"^^^^"_$S($G(IVMHLD):0,1:1),$P(^(1),"^",3,4)=%_"^"_DUZ
 S DA=IVMTDA,DIK="^IVM(301.61," D IX1^DIK
REVQ Q
 ;
ADD(X) ; Add a new entry to file #301.61
 ;  Input:     X  --  Reference number to be used as the .01 field
 ;  Output:  IVM  --  Internal entry number to new entry, or 0.
 ;
 N DA,DD,DO,DIE,DIC,DLAYGO,IVM,Y
 I $G(X)="" S IVM=0 G ADDQ
 S DIC="^IVM(301.61,",DIC(0)="L",DLAYGO=301.61 D FILE^DICN
 S (DA,IVM)=+Y I DA<0 S IVM=0 G ADDQ
 ;
 D NOW^%DTC
 S DIE=DIC,DR="1.01////"_%_";1.02////"_DUZ D ^DIE
ADDQ Q IVM
 ;
 ;
CHK(DFN) ; Is the insurance patient recorded in file #301.61?
 ;  Input:   DFN  --  Pointer to the patient in file #2
 ; Output:     1  --  Patient recorded in #301.61; otherwise, 0
 ;
 Q $O(^IVM(301.61,"C",+$G(DFN),0))>0
 ;
 ;
FT1(IVMTDA) ; Entry point to build FT1 segment from file #301.61
 ;  Input:  IVMTDA  --  Pointer to the transmission record in #301.61
 ;          The HL7 variables HLFS, HLQ and HLECH must also be defined
 ; Output:  String in the form of the HL7 FT1 segment
 ;
 N IVMN,IVMY,IVMSEP
 I '$G(IVMTDA) G FT1Q
 S IVMN=$G(^IVM(301.61,IVMTDA,0)) I IVMN="" G FT1Q
 S IVMSEP=$E(HLECH)
 ;
 S $P(IVMY,HLFS,1)=1 ; set id
 S $P(IVMY,HLFS,4)=$S($P(IVMN,"^",7):$$HLDATE^HLFNC($P(IVMN,"^",7)),1:HLQ) ; date generated
 S $P(IVMY,HLFS,6)=$S($P(IVMN,"^",11):2,$P(IVMN,"^",10)&$P(IVMN,"^",13):4,$P(IVMN,"^",9)&$P(IVMN,"^",13):3,1:1) ; transaction type
 S $P(IVMY,HLFS,7)=$P(IVMN,"^") ; transaction code
 ;
 ; - build extended transaction description
 S $P(IVMY,HLFS,9)=$P(IVMN,"^",3)_IVMSEP_$P(IVMN,"^",4)_IVMSEP_$S($P(IVMN,"^",5):$$HLDATE^HLFNC($P(IVMN,"^",5)),1:HLQ)_IVMSEP_$S($P(IVMN,"^",6):$$HLDATE^HLFNC($P(IVMN,"^",6)),1:HLQ)
 ;
 ; - build extended transaction amount
 S $P(IVMY,HLFS,11)=$S($P(IVMN,"^",10)&$P(IVMN,"^",13):+$P(IVMN,"^",9),$P(IVMN,"^",9)&$P(IVMN,"^",13):$P(IVMN,"^",9),1:$P(IVMN,"^",8))
 ;
FT1Q Q "FT1"_HLFS_$G(IVMY)
