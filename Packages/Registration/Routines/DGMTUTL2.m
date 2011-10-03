DGMTUTL2 ;ALB/RMM - Means Test Consistency Checker ; 04/28/2005
 ;;5.3;Registration;**463,655**;Aug 13, 1993
 ;
 ; This routine sets the data strings used in the Income Test
 ; Inconsistency Checks.
 Q
 ;
ZIC(VAFIEN,DEPIEN) ; Build ZIC the data string for the veteran
 ;
 N NODE0,NODE1,NODE2,ZIC
 S NODE0=$G(^DGMT(408.21,VAFIEN,0))
 S NODE1=$G(^DGMT(408.21,VAFIEN,1))
 S NODE2=$G(^DGMT(408.21,VAFIEN,2))
 S ZIC="ZIC"
 S $P(ZIC,U,2)=$P(NODE0,U,1)         ;Income Year
 S $P(ZIC,U,3)=$P(NODE0,U,8)         ;Social Security
 S $P(ZIC,U,4)=$P(NODE0,U,9)         ;U.S. Civil Service
 S $P(ZIC,U,5)=$P(NODE0,U,10)        ;U.S. Railroad Retirement
 S $P(ZIC,U,6)=$P(NODE0,U,11)        ;Military Retirement
 S $P(ZIC,U,7)=$P(NODE0,U,12)        ;Unemployment Compensation
 S $P(ZIC,U,9)=$P(NODE0,U,14)        ;Total Income from Employment
 S $P(ZIC,U,10)=$P(NODE0,U,15)       ;Interest,Dividend,Annuity
 S $P(ZIC,U,11)=$P(NODE0,U,16)       ;Workers Comp. or Black Lung
 S $P(ZIC,U,12)=$P(NODE0,U,17)       ;All Other Income
 S $P(ZIC,U,13)=$P(NODE1,U,1)        ;Medical Expenses
 S $P(ZIC,U,14)=$P(NODE1,U,2)        ;Funeral And Burial Expenses
 S $P(ZIC,U,15)=$P(NODE1,U,3)        ;Educational Expenses
 S $P(ZIC,U,16)=$P(NODE2,U,1)        ;Cash, Amount In Bank Accounts
 S $P(ZIC,U,17)=$P(NODE2,U,2)        ;Stocks And Bonds
 S $P(ZIC,U,18)=$P(NODE2,U,3)        ;Real Property
 S $P(ZIC,U,19)=$P(NODE2,U,4)        ;Other Property or Assets
 S $P(ZIC,U,20)=$P(NODE2,U,5)        ;Debts
 ;
 ; Adjust date field to correct format
 S $P(ZIC,U,2)=$E($P(ZIC,U,2),1,3)+1700_$E($P(ZIC,U,2),4,7)
 ;
 Q ZIC
 ;
ZIR(VAFIEN,DEPIEN) ; Build ZIR the data string for the veteran
 N NODE0,ZIR
 S NODE0=$G(^DGMT(408.22,VAFIEN,0)),ZIR="ZIR"
 S $P(ZIR,U,3)=$P(NODE0,U,6)         ;Lived With Patient
 S $P(ZIR,U,4)=$P(NODE0,U,7)         ;Amount Contributed to Spouse
 S $P(ZIR,U,8)=$P(NODE0,U,11)        ;Child Had Income
 S $P(ZIR,U,9)=$P(NODE0,U,12)        ;Income Available to You
 Q ZIR
 ;
ZMT(DGMTI) ; Build ZMT the data string for the veteran
 ;
 N NODE0,NODE2,ZMT
 S NODE0=$G(^DGMT(408.31,DGMTI,0))
 S NODE2=$G(^DGMT(408.31,DGMTI,2)),ZMT="ZMT"
 S $P(ZMT,U,2)=$P(NODE0,U,1)         ;Means Test Date
 S $P(ZMT,U,3)=$P(NODE0,U,3)         ;Means Test Status
 S $P(ZMT,U,4)=$P(NODE0,U,4)         ;Income
 S $P(ZMT,U,5)=$P(NODE0,U,5)         ;Net Worth
 S $P(ZMT,U,6)=$P(NODE0,U,10)        ;Date/Time of Adjudication
 S $P(ZMT,U,7)=$P(NODE0,U,11)        ;Agreed to Pay Deductible
 S $P(ZMT,U,8)=$P(NODE0,U,12)        ;Threshold A
 S $P(ZMT,U,9)=$P(NODE0,U,15)        ;Deductible Expenses
 S $P(ZMT,U,10)=$P(NODE0,U,7)        ;Date/Time MT Completed
 S $P(ZMT,U,11)=$P(NODE0,U,16)       ;Previous Yr MT Threshold Flag
 S $P(ZMT,U,12)=$P(NODE0,U,18)       ;Total Dependents
 S $P(ZMT,U,13)=$P(NODE0,U,20)       ;Hardship
 S $P(ZMT,U,14)=$P(NODE0,U,21)       ;Hardship Review Date
 S $P(ZMT,U,15)=$P(NODE0,U,24)       ;Date Veteran Signed Test
 S $P(ZMT,U,16)=$P(NODE0,U,14)       ;Declines to Give Income Info
 S $P(ZMT,U,17)=$P(NODE0,U,19)       ;Type of Test
 S $P(ZMT,U,18)=$P(NODE0,U,23)       ;Source of Income Test
 S $P(ZMT,U,19)=$P($G(^DGMT(408.31,DGMTI,"PRIM")),U,1)  ;Primary Test?
 S $P(ZMT,U,20)=$P(NODE0,U,25)       ;Date IVM Verif. MT Completed
 S $P(ZMT,U,21)=$P(NODE0,U,26)       ;Refused To Sign
 S $P(ZMT,U,22)=$P(NODE2,U,5)        ;Site Conducting Test
 S $P(ZMT,U,23)=$P(NODE2,U,4)        ;Hardship Review Site
 S $P(ZMT,U,24)=$P(NODE2,U,1)        ;Hardship Effective Date
 S $P(ZMT,U,25)=$P(NODE2,U,2)        ;Date/Time Test Last Edited
 S $P(ZMT,U,26)=$P(NODE2,U,3)        ;Test Determined Status
 S $P(ZMT,U,28)=$P(NODE0,U,27)       ;GMT Threshold
 ;
 ; Adjust date fields to correct format
 S $P(ZMT,U,2)=$E($P(ZMT,U,2),1,3)+1700_$E($P(ZMT,U,2),4,7)
 S $P(ZMT,U,10)=$E($P(ZMT,U,10),1,3)+1700_$E($P(ZMT,U,10),4,7)
 S $P(ZMT,U,25)=$E($P(ZMT,U,25),1,3)+1700_$E($P(ZMT,U,25),4,7)_$P($P(ZMT,U,25),".",2)_"-400"
 ;
 ; Change Status IENs to Codes
 S:$P(ZMT,U,26)="" $P(ZMT,U,26)=$P(ZMT,U,3)
 S $P(ZMT,U,3)=$P(^DG(408.32,$P(ZMT,U,3),0),U,2)
 S $P(ZMT,U,26)=$P(^DG(408.32,$P(ZMT,U,26),0),U,2)
 ;
 Q ZMT
 ;
ZDP(VAFIEN,DEPIEN) ; Build ZDP the data string for the veteran
 ;
 N NODE0,NODER,DGPR,ZDP,LIEN
 S NODE0=$G(^DGPR(408.12,+VAFIEN,0)),ZDP="ZDP"
 S DGPR=+$P(NODE0,U,3),NODER=^DGPR(408.13,DGPR,0)
 S $P(ZDP,U,2)=$P(NODER,U,1)         ;Name
 S $P(ZDP,U,3)=$P(NODER,U,2)         ;Sex
 S $P(ZDP,U,4)=$P(NODER,U,3)         ;Date of Birth
 S $P(ZDP,U,5)=$P(NODER,U,9)         ;Social Security Number
 S $P(ZDP,U,6)=$P(NODE0,U,2)         ;Relationship To Patient
 S $P(ZDP,U,7)=+VAFIEN               ;Internal Entry Number
 S LIEN=$O(^DGPR(408.12,+VAFIEN,"E","AID"),-1)
 S $P(ZDP,U,9)=+^DGPR(408.12,+VAFIEN,"E",LIEN,0)
 ;
 ; Change format to match CC format
 S $P(ZDP,U,2)=$TR($P(ZDP,U,2),",","~")
 S $P(ZDP,U,4)=$E($P(ZDP,U,4),1,3)+1700_$E($P(ZDP,U,4),4,7)
 S $P(ZDP,U,9)=$E($P(ZDP,U,9),1,3)+1700_$E($P(ZDP,U,9),4,7)
 ;
 Q ZDP
                                                                                
