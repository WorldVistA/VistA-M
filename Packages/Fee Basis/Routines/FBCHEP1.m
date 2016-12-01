FBCHEP1 ;AISC/DMK - EDIT PAYMENT FOR CONTRACT HOSPITAL ;10/01/14
 ;;3.5;FEE BASIS;**38,61,122,133,108,124,132,139,123,154**;JAN 30, 1995;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
EDIT ;ENTRY POINT TO EDIT PAYMENT
 N LASTDX,LASTPROC
 S IOP=$S($D(ION):ION,1:"HOME") D ^%ZIS K IOP
BT W ! S DIC="^FBAA(161.7,",DIC(0)="AEQMZ",DIC("S")="I $P(^(0),U,3)=""B9""&($P(^(0),U,15)=""Y"")",DIC("S")=$S($D(^XUSEC("FBAA LEVEL 2",DUZ)):DIC("S"),1:DIC("S")_"&($P(^(0),U,5)=DUZ)") D ^DIC
 G END:X=""!(X="^"),BT:Y<0 S FBN=+Y,FBN(0)=Y(0)
 S FBEXMPT=$P(FBN(0),"^",18)
 S FBSTAT=^FBAA(161.7,FBN,"ST"),FBBAMT=$S($P(FBN(0),"^",9)="":0,1:$P(FBN(0),"^",9))
 I FBSTAT="C"&('$D(^XUSEC("FBAA LEVEL 2",DUZ))) W !!,*7,?3,"You must Reopen the batch prior to editing the invoice.",! G END
 I FBSTAT="S"!(FBSTAT="P")!(FBSTAT="R")&('$D(^XUSEC("FBAA LEVEL 2",DUZ))) W !!,*7,?3,"You must be a holder of the FBAA LEVEL 2 security key",!,?3,"to edit this invoice.",! G END
 I FBSTAT="T"!(FBSTAT="F")!(FBSTAT="V") W !!,?3,"Batch has already been sent to Austin for payment.",! G END
INV W ! S DIC="^FBAAI(",DIC(0)="AEQZ",DIC("S")="I $P(^(0),U,17)=FBN" D ^DIC K DIC("S") G BT:X=""!(X="^"),INV:Y<0 S FBI=+Y
 ;
 ; enforce separation of duties
 S FBDFN=$P($G(^FBAAI(FBI,0)),U,4)
 S FB7078I=$P($G(^FBAAI(FBI,0)),U,5)
 S FTP=$S(FB7078I]"":$O(^FBAAA("AG",FB7078I,FBDFN,0)),1:"")
 I '$$UOKPAY^FBUTL9(FBDFN,FTP) D  Q
 . W !!,"You cannot process a payment associated with authorization ",FBDFN,"-",FTP
 . W !,"due to separation of duties."
 ;
 ;
 ; FB*3.5*123 - edit inpatient invoice - check for IPAC data for Federal Vendors
 I '$$IPACEDIT^FBAAPET1(162.5,FBI,.FBIA,.FBDODINV) G INV
 ;
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
 ; load Item level Rendering provider data
 D LOADRP^FBUTL8(FBI_",",.FBPROV) ;FB*3.5*122
 ; save remittance remarks prior to edit session in sorted list
 S FBRRMKL(0)=$$RRL^FBUTL4(.FBRRMK)
 S LASTDX=$$LAST(FBI,"DX"),LASTPROC=$$LAST(FBI,"PROC")
 S (DIE,DIC)="^FBAAI(",DIC(0)="AEQM",DA=FBI,DR="[FBCH EDIT PAYMENT]" W !
 D
 . N ICDVDT,DFN,FB583,FBAAMM1,FBAAPTC,FBCNTRA,FBCNTRP,FBV,FBVEN,FTP
 . S ICDVDT=$$FRDTINV^FBCSV1(DA) ;date for files 80 and 80.1 identifier
 . ;get variables for call to PPT^FBAACO1
 . S FBAAMM1=$P($G(^FBAAI(DA,2)),U,3)
 . S FBCNTRP=$P($G(^FBAAI(DA,5)),U,8)
 . S FBV=$P($G(^FBAAI(DA,0)),U,3)
 . S DFN=$P($G(^FBAAI(DA,0)),U,4)
 . S FBAAPTC=$P($G(^FBAAI(DA,0)),U,13)
 . S X=$P($G(^FBAAI(DA,0)),U,5)
 . S:X[";FB583(" FB583=+X
 . S FTP=$S(X]"":+$O(^FBAAA("AG",X,DFN,0)),1:"")
 . S FBVEN=$S(FTP:$P($G(^FBAAA(DFN,1,FTP,0)),U,4),1:"")
 . S FBCNTRA=$S(FTP:$P($G(^FBAAA(DFN,1,FTP,0)),U,22),1:"")
 . D ^DIE
 ; if adjustment data changed then file
 I $$ADJL^FBUTL2(.FBADJ)'=FBADJL(0) D FILEADJ^FBCHFA(FBI_",",.FBADJ)
 ; if remit remark data changed then file
 I $$RRL^FBUTL4(.FBRRMK)'=FBRRMKL(0) D FILERR^FBCHFR(FBI_",",.FBRRMK)
 ; remove any gaps in codes
 D RMVGAP(FBI,1)
 ; if line item rendering providers exist then file FB*3.5*133
 I $D(FBPROV) D FILERP^FBUTL8(FBI_",",.FBPROV)
 K FBAAMM,FBAAMM1
 S FBNK=$P(^FBAAI(FBI,0),"^",9)
 I FBNK-FBK S $P(^FBAA(161.7,FBN,0),"^",9)=FBBAMT+(FBNK-FBK)
END K DA,DFN,DIC,DIE,DR,FBAAOUT,FBDX,FBI,FBIN,FBLISTC,FBN,FBPROC,FBSTAT,FBVEN,FBVID,J,K,L,POP,Q,VA,VADM,X,FBIFN,Y,FBPRICE,FBK,FBNK,FB583,FBAAPN,FBASSOC,FBDEL,FBLOC,DAT
 K CNT,D0,FB7078,FBAABDT,FBAAEDT,FBASSOC,FBAUT,FBLOC,FBPROG,FBPSA,FBPT,FBRR,FBTT,FBTYPE,FBXX,FTP,PI,PTYPE,T,Z,ZZ,F,FBPOV,I,TA,VAL,DUOUT,FBVET,FBBAMT,FBAAI,FBEXMPT,FB1725,FBPAMT
 K FBFPPSC,FBFPPSL,FBADJ,FBADJD,FBRRMK,FBRRMKD,FBIA,FBDODINV
 K FB7078I,FBDFN
 D END^FBCHDI
 Q
 ;
BADDATE(INVRCVDT,TEMPDA) ;Compare edited Invoice Received Date to Treatment Date, reject if before. Called from [FBCH EDIT PAYMENT] template. 
 I INVRCVDT="" Q 0 ;Inv Date not changed, no check necessary
 N TDAT,SHODAT S TDAT=$$GET1^DIQ(162.5,TEMPDA_",",6,"I") I TDAT]"" S SHODAT="TO"
 I TDAT="" S TDAT=$$GET1^DIQ(162.5,TEMPDA_",",5,"I"),SHODAT="FROM"
 I INVRCVDT<TDAT D  Q 1 ;Reject entered date
 .N SHOTDAT S SHOTDAT=$E(TDAT,4,5)_"/"_$E(TDAT,6,7)_"/"_$E(TDAT,2,3) ;Convert TDAT into display format for error message.
 .N MSG1,MSG2 S MSG1="*** Invoice Received Date cannot be before",MSG2=" Treatment "_SHODAT_" Date ("_SHOTDAT_") !!!"
 .W !!?5,*7,MSG1,!?8,MSG2
 Q 0 ;Date entered is OK
 ;
LAST(FBDA,FBNODE) ; Returns number (0-25) of last code in node for invoice
 D RMVGAP(FBDA,0)  ;Insure that gaps were not created outside normal processes
 N FBI,FBRET,FBX
 S FBRET=0
 I FBDA,"^DX^PROC^"[(U_FBNODE_U) D
 . S FBX=$G(^FBAAI(FBDA,FBNODE))
 . F FBI=25:-1:1 I $P(FBX,"^",FBI)'="" S FBRET=FBI Q
 Q FBRET
 ;
RMVGAP(FBDA,FBWRT) ;  Remove gaps in ICD diagnosis and procedure codes
 ; input
 ;   FBDA  IEN of invoice
 ;   FBWRT (optional) =1 if messages can be written to the screen
 ; remove any gaps
 N DXFLD,FBDX,FBFDA,FBI,FBMOVED,FBN,FBPOA,FBPROC,POAFLD,PROCFLD
 D FLDLIST ; get list of field numbers
 ; check diagnosis and POA codes
 S FBDX=$G(^FBAAI(FBDA,"DX"))
 S FBPOA=$G(^FBAAI(FBDA,"POA"))
 S FBMOVED=0
 S FBN=0
 F FBI=1:1:25 D
 . ; JAS - 03/05/14 - Patch 139 (ICD-10 Project) - Modified next line to also quit if 0
 . Q:(($P(FBDX,U,FBI)="")!($P(FBDX,U,FBI)=0))
 . S FBN=FBN+1 ; increment number of diagnosis codes
 . Q:FBI=FBN  ; no gap
 . ; move diagnosis and POA from slot FBI to slot FBN
 . S FBMOVED=1 ; set flag for message
 . K FBFDA
 . S FBFDA(162.5,FBDA_",",$P(DXFLD,U,FBN))=$P(FBDX,U,FBI)
 . S FBFDA(162.5,FBDA_",",$P(POAFLD,U,FBN))=$P(FBPOA,U,FBI)
 . S FBFDA(162.5,FBDA_",",$P(DXFLD,U,FBI))="@"
 . S FBFDA(162.5,FBDA_",",$P(POAFLD,U,FBI))="@"
 . D FILE^DIE("","FBFDA") D:$G(FBWRT) MSG^DIALOG()
 . S $P(FBDX,U,FBN)=$P(FBDX,U,FBI)
 . S $P(FBPOA,U,FBN)=$P(FBPOA,U,FBI)
 . S $P(FBDX,U,FBI)=""
 . S $P(FBPOA,U,FBI)=""
 I $G(FBWRT),FBMOVED W !,"Diagnosis codes were moved to remove gaps"
 ;
 S FBPROC=$G(^FBAAI(FBDA,"PROC"))
 S FBMOVED=0
 S FBN=0
 F FBI=1:1:25 D
 . ; JAS - 03/05/14 - Patch 139 (ICD-10 Project) - Modified next line to also quit if 0
 . Q:(($P(FBPROC,U,FBI)="")!($P(FBPROC,U,FBI)=0))
 . S FBN=FBN+1 ; increment number of procedure codes
 . Q:FBI=FBN  ; no gap
 . ; move procedure from slot FBI to slot FBN
 . S FBMOVED=1
 . K FBFDA
 . S FBFDA(162.5,FBDA_",",$P(PROCFLD,U,FBN))=$P(FBPROC,U,FBI)
 . S FBFDA(162.5,FBDA_",",$P(PROCFLD,U,FBI))="@"
 . D FILE^DIE("","FBFDA") D:$G(FBWRT) MSG^DIALOG()
 . S $P(FBPROC,U,FBN)=$P(FBPROC,U,FBI)
 . S $P(FBPROC,U,FBI)=""
 I $G(FBWRT),FBMOVED W !,"Procedure codes were moved to remove gaps"
 Q
 ;
FLDLIST ; Provide list of fields for diagnosis, POA, and procedures
 S DXFLD="30^31^32^33^34^35^35.1^35.2^35.3^35.4^35.5^35.6^35.7^35.8^35.9^36^36.1^36.2^36.3^36.4^36.5^36.6^36.7^36.8^36.9"
 S POAFLD="30.02^31.02^32.02^33.02^34.02^35.02^35.12^35.22^35.32^35.42^35.52^35.62^35.72^35.82^35.92^36.02^36.12^36.22^36.32^36.42^36.52^36.62^36.72^26.82^36.92"
 S PROCFLD="40^41^42^43^44^44.06^44.07^44.08^44.09^44.1^44.11^44.12^44.13^44.14^44.15^44.16^44.17^44.18^44.19^44.2^44.21^44.22^44.23^44.24^44.25"
 Q
 ;
GETIPAC(FBDA,FBVEN,FBIA,FBDODINV) ; Get vendor/IPAC data for Inpatient (FB*3.5*123)
 ; All parameters required and assumed to exist
 ; Called by $$IPACEDIT^FBAAPET1
 N GX5
 S FBVEN=+$P($G(^FBAAI(FBDA,0)),U,3)    ; vendor ien
 S GX5=$G(^FBAAI(FBDA,5))
 S FBIA=+$P(GX5,U,10)                   ; ipac agreement ien
 S FBDODINV=$P(GX5,U,7)                 ; ipac DoD invoice#
 Q
 ;
DELIPAC(FBDA) ; Delete all IPAC data on file for Inpatient (FB*3.5*123)
 ; Called by $$IPACEDIT^FBAAPET1
 N DIE,DA,DR,DIC
 S DIE=162.5,DA=FBDA,DR="86///@;87///@" D ^DIE
 Q
 ;
