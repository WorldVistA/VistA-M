FBNHEDPA ;AISC/GRR-EDIT PAYMENT FOR COMMUNITY NURSING HOME ;7/8/2003
 ;;3.5;FEE BASIS;**61**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EDIT ;ENTRY POINT TO EDIT PAYMENT
 S IOP=$S($D(ION):ION,1:"HOME") D ^%ZIS K IOP
BT S DIC="^FBAA(161.7,",DIC(0)="AEQMZ",DIC("S")="I $P(^(0),U,3)=""B9""",DIC("S")=$S($D(^XUSEC("FBAASUPERVISOR",DUZ)):DIC("S"),1:DIC("S")_"&($P(^(0),U,5)=DUZ)") D ^DIC
 G END:X=""!(X="^"),BT:Y<0 S FBN=+Y,FBN(0)=Y(0)
 S FBSTAT=^FBAA(161.7,FBN,"ST")
 I FBSTAT="C"&('$D(^XUSEC("FBAASUPERVISOR",DUZ))) W !!,*7,?3,"You must Reopen the batch prior to editting the invoice.",! G END
 I FBSTAT="S"!(FBSTAT="P")!(FBSTAT="R")&('$D(^XUSEC("FBAASUPERVISOR",DUZ))) W !!,*7,?3,"You must be a holder of the 'FBAASUPERVISOR' security key",!,?3,"to edit this invoice.",! G END
 I FBSTAT="T"!(FBSTAT="V") W !!,?3,"Batch has already been sent to Austin for payment.",! G END
INV W ! S DIC("A")="Select Invoice Number: ",DIC="^FBAAI(",DIC(0)="AEQMZ",DIC("S")="I $P(^(0),U,17)=FBN" D ^DIC K DIC G BT:X=""!(X="^"),INV:Y<0 S FBI=+Y,FBOLD(0)=Y(0)
 S FBLISTC="",FBHDI=FBI W @IOF D START^FBCHDI S FBI=FBHDI K FBHDI
 K FBHAP,FBAP
 S (DIE,DIC)="^FBAAI(",DIC(0)="AEQM",DA=FBI,DR="[FBNH EDIT PAYMENT]",DIE("NO^")=""
 W !
 N FBHAC
 ; get values of FPPS Claim ID and Line Item
 S FBFPPSC=$P($G(^FBAAI(FBI,3)),U)
 S FBFPPSL=$P($G(^FBAAI(FBI,3)),U,2)
 ; load current adjustment data
 D LOADADJ^FBCHFA(FBI_",",.FBADJ)
 ; save adjustment data prior to edit session in sorted list
 S FBADJL(0)=$$ADJL^FBUTL2(.FBADJ) ; sorted list of original adjustments
 ; load current remittance remark data
 D LOADRR^FBCHFR(FBI_",",.FBRRMK)
 ; save remittance remarks prior to edit session in sorted list
 S FBRRMKL(0)=$$RRL^FBUTL4(.FBRRMK)
 D ^DIE K DIE("NO^")
 I $D(DTOUT) S DR="5///^S X="_$P(FBOLD(0),U,6)_";6///^S X="_$P(FBOLD(0),U,7) D ^DIE
 ; if adjustment data changed then file
 I $$ADJL^FBUTL2(.FBADJ)'=FBADJL(0) D FILEADJ^FBCHFA(FBI_",",.FBADJ)
 ; if remit remark data changed then file
 I $$RRL^FBUTL4(.FBRRMK)'=FBRRMKL(0) D FILERR^FBCHFR(FBI_",",.FBRRMK)
 I $D(FBHAP),$D(FBAP),FBAP-FBHAP S FBDIF=FBAP-FBHAP,$P(^FBAA(161.7,FBN,0),"^",9)=$P(^FBAA(161.7,FBN,0),"^",9)+FBDIF
END K DA,DFN,DIC,DIE,DR,FBAAOUT,FBDX,FBI,FBIN,FBLISTC,FBN,FBPROC,FBSTAT,FBVEN,FBVID,J,K,L,POP,Q,VA,VADM,X,Y,FBAC,FBAP,FBBAL,FBHAP,FBDIF
 K FBADJ,FBADJL,FBRRMK,FBRRMKL,FBFPPSC,FBFPPSL
 D KILL^FBPAY K FBOLD,FBINODE,FBPAT,FBPRGNAM
 Q
