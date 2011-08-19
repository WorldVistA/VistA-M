FBAAPDM ;AISC/GRR-CREATE PATIENT MRA DELETE TRANSACTION ;27AUG87
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
RD W !! S DIC="^FBAAA(",DIC(0)="AEQM" D ^DIC G END:X="^"!(X=""),RD:Y<0 S (DA,DFN)=+Y
 I '$D(^DPT(DFN,0)) W !!,"Patient has been deleted from the Patient file, cannot create transaction!" G RD
 S FBTTYPE="D",D1="" D MORE^FBAAAUT W !!,"Delete MRA has been created!" G RD
END K DA,DFN,DIC,Y,D1 Q
