FBCHEP1 ;AISC/DMK-EDIT PAYMENT FOR CONTRACT HOSPITAL ;7/8/2003
 ;;3.5;FEE BASIS;**38,61**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EDIT ;ENTRY POINT TO EDIT PAYMENT
 S IOP=$S($D(ION):ION,1:"HOME") D ^%ZIS K IOP
BT W ! S DIC="^FBAA(161.7,",DIC(0)="AEQMZ",DIC("S")="I $P(^(0),U,3)=""B9""&($P(^(0),U,15)=""Y"")",DIC("S")=$S($D(^XUSEC("FBAASUPERVISOR",DUZ)):DIC("S"),1:DIC("S")_"&($P(^(0),U,5)=DUZ)") D ^DIC
 G END:X=""!(X="^"),BT:Y<0 S FBN=+Y,FBN(0)=Y(0)
 S FBEXMPT=$P(FBN(0),"^",18)
 S FBSTAT=^FBAA(161.7,FBN,"ST"),FBBAMT=$S($P(FBN(0),"^",9)="":0,1:$P(FBN(0),"^",9))
 I FBSTAT="C"&('$D(^XUSEC("FBAASUPERVISOR",DUZ))) W !!,*7,?3,"You must Reopen the batch prior to editting the invoice.",! G END
 I FBSTAT="S"!(FBSTAT="P")!(FBSTAT="R")&('$D(^XUSEC("FBAASUPERVISOR",DUZ))) W !!,*7,?3,"You must be a holder of the 'FBAASUPERVISOR' security key",!,?3,"to edit this invoice.",! G END
 I FBSTAT="T"!(FBSTAT="V") W !!,?3,"Batch has already been sent to Austin for payment.",! G END
INV W ! S DIC="^FBAAI(",DIC(0)="AEQZ",DIC("S")="I $P(^(0),U,17)=FBN" D ^DIC K DIC("S") G BT:X=""!(X="^"),INV:Y<0 S FBI=+Y
 S FBK=$S($P(^FBAAI(FBI,0),"^",9)="":0,1:$P(^(0),"^",9))
 S FBLISTC="",FBAAI=FBI W @IOF D START^FBCHDI2 S FBI=FBAAI I $P(^FBAAI(FBI,0),"^",9)="" S FBPRICE=""
 ; set FB1725 flag = true if payment for a 38 U.S.C. 1725 claim
 D
 . N FBY
 . S FBY=$G(^FBAAI(FBI,0))
 . S FB1725=$S($P(FBY,U,5)["FB583":+$P($G(^FB583(+$P(FBY,U,5),0)),U,28),1:0)
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
 S (DIE,DIC)="^FBAAI(",DIC(0)="AEQM",DA=FBI,DR="[FBCH EDIT PAYMENT]" W ! D ^DIE
 ; if adjustment data changed then file
 I $$ADJL^FBUTL2(.FBADJ)'=FBADJL(0) D FILEADJ^FBCHFA(FBI_",",.FBADJ)
 ; if remit remark data changed then file
 I $$RRL^FBUTL4(.FBRRMK)'=FBRRMKL(0) D FILERR^FBCHFR(FBI_",",.FBRRMK)
 K FBAAMM,FBAAMM1
 S FBNK=$P(^FBAAI(FBI,0),"^",9)
 I FBNK-FBK S $P(^FBAA(161.7,FBN,0),"^",9)=FBBAMT+(FBNK-FBK)
END K DA,DFN,DIC,DIE,DR,FBAAOUT,FBDX,FBI,FBIN,FBLISTC,FBN,FBPROC,FBSTAT,FBVEN,FBVID,J,K,L,POP,Q,VA,VADM,X,FBIFN,Y,FBPRICE,FBK,FBNK,FB583,FBAAPN,FBASSOC,FBDEL,FBLOC,DAT
 K CNT,D0,FB7078,FBAABDT,FBAAEDT,FBASSOC,FBAUT,FBLOC,FBPROG,FBPSA,FBPT,FBRR,FBTT,FBTYPE,FBXX,FTP,PI,PTYPE,T,Z,ZZ,F,FBPOV,I,TA,VAL,DUOUT,FBVET,FBBAMT,FBAAI,FBEXMPT,FB1725,FBPAMT
 K FBFPPSC,FBFPPSL,FBADJ,FBADJD,FBRRMK,FBRRMKD
 D END^FBCHDI
 Q
