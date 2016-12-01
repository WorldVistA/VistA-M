FBNHEDPA ;AISC/GRR - EDIT PAYMENT FOR COMMUNITY NURSING HOME ;10/7/14  17:55
 ;;3.5;FEE BASIS;**61,124,132,154**;JAN 30, 1995;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
EDIT ;ENTRY POINT TO EDIT PAYMENT
 S IOP=$S($D(ION):ION,1:"HOME") D ^%ZIS K IOP
BT S DIC="^FBAA(161.7,",DIC(0)="AEQMZ",DIC("S")="I $P(^(0),U,3)=""B9""",DIC("S")=$S($D(^XUSEC("FBAA LEVEL 2",DUZ)):DIC("S"),1:DIC("S")_"&($P(^(0),U,5)=DUZ)") D ^DIC
 G END:X=""!(X="^"),BT:Y<0 S FBN=+Y,FBN(0)=Y(0)
 S FBSTAT=^FBAA(161.7,FBN,"ST")
 I FBSTAT="C"&('$D(^XUSEC("FBAA LEVEL 2",DUZ))) W !!,*7,?3,"You must Reopen the batch prior to editing the invoice.",! G END
 I FBSTAT="S"!(FBSTAT="P")!(FBSTAT="R")&('$D(^XUSEC("FBAA LEVEL 2",DUZ))) W !!,*7,?3,"You must be a holder of the 'FBAA LEVEL 2' security key",!,?3,"to edit this invoice.",! G END
 I FBSTAT="T"!(FBSTAT="F")!(FBSTAT="V") W !!,?3,"Batch has already been sent to Austin for payment.",! G END
INV W ! S DIC("A")="Select Invoice Number: ",DIC="^FBAAI(",DIC(0)="AEQMZ",DIC("S")="I $P(^(0),U,17)=FBN" D ^DIC K DIC G BT:X=""!(X="^"),INV:Y<0 S FBI=+Y,FBOLD(0)=Y(0)
 S FBLISTC="",FBHDI=FBI W @IOF D START^FBCHDI S FBI=FBHDI K FBHDI
 ;
 ; enforce separation of duties
 S DFN=$P(FBOLD(0),U,4)
 S FB7078I=$P(FBOLD(0),U,5)
 S FTP=$S(FB7078I]"":$O(^FBAAA("AG",FB7078I,DFN,0)),1:"")
 I '$$UOKPAY^FBUTL9(DFN,FTP) D  G INV
 . W !!,"You cannot process a payment associated with authorization ",DFN,"-",FTP
 . W !,"due to separation of duties."
 ;
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
 K FBADJ,FBADJL,FBRRMK,FBRRMKL,FBFPPSC,FBFPPSL,FB7078I,FTP
 D KILL^FBPAY K FBOLD,FBINODE,FBPAT,FBPRGNAM
 Q
 ;
BADDATE(INVRCVDT,TEMPDA) ;Compare edited Invoice Received Date to Treatment Date, reject if before 
 I INVRCVDT="" Q 0 ;Inv Date not changed, no check necessary
 N TDAT,SHODAT S TDAT=$$GET1^DIQ(162.5,TEMPDA_",",6,"I") I TDAT]"" S SHODAT="TO"
 I TDAT="" S TDAT=$$GET1^DIQ(162.5,TEMPDA_",",5,"I"),SHODAT="FROM"
 I INVRCVDT<TDAT D  Q 1 ;Reject entered date
 .N SHOTDAT S SHOTDAT=$E(TDAT,4,5)_"/"_$E(TDAT,6,7)_"/"_$E(TDAT,2,3) ;Convert TDAT into display format for error message
 .N MSG1,MSG2 S MSG1="*** Invoice Received Date cannot be before",MSG2=" Treatment "_SHODAT_" Date ("_SHOTDAT_") !!!"
 .W !!?5,*7,MSG1,!?8,MSG2
 Q 0 ;Date entered is OK
 ;
BADTDATE(TDAT,INVRCVDT,SHODAT) ;Compare edited Treatment TO or FROM Date to Invoice Received Date, reject if AFTER 
 I INVRCVDT<TDAT D  Q 1 ;Reject entered date
 .N SHOIRDAT S SHOIRDAT=$E(INVRCVDT,4,5)_"/"_$E(INVRCVDT,6,7)_"/"_$E(INVRCVDT,2,3) ;Convert INVRCVDT into display format for error message.
 .N MSG1,MSG2 S MSG1="*** Treatment "_SHODAT_" Date cannot be after",MSG2=" Invoice Received Date ("_SHOIRDAT_") !!!"
 .W !!?5,*7,MSG1,!?8,MSG2
 Q 0 ;Date entered is OK
 ;
