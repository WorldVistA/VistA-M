FBCHRR ;AISC/DMK - RE-INITIATE REJECTS FROM PRICER ;1/22/15  12:43
 ;;3.5;FEE BASIS;**61,108,123,154**;JAN 30, 1995;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
DIC S FBTYPE="B9"
 W ! S DIC="^FBAA(161.7,",DIC(0)="AEQMZ",DIC("S")="I $P(^(0),U,15)=""Y""&($P(^(0),U,17)]"""")"_$S($D(^XUSEC("FBAA LEVEL 2",DUZ)):"",1:"&($P(^(0),U,5)=DUZ)"),DIC("A")="Select Batch with Pricer Rejects: " D ^DIC
 G END:X="^"!(X=""),DIC:Y<0 S FBN=+Y,FBN(0)=Y(0)
 I '$D(^FBAAI("AH",FBN)) W !!,*7,"No items rejected for this batch!",! G DIC
DIC1 W !! S DIC="^FBAA(161.7,",DIC(0)="AEQMZ",DIC("A")="Select New Batch Number: ",DIC("S")="I $P(^(0),U,3)=FBTYPE&($P(^(0),U,5)=DUZ)&($P(^(0),U,15)=""Y"")&($G(^(""ST""))=""O"")&($P(^(0),U,18)'[""Y"")"
 D ^DIC K DIC G DIC:$E(X)="^"!(X=""),DIC1:Y<0 S FBNB=+Y,FBNB(0)=Y(0)
DIC2 W ! S DIC="^FBAAI(",DIC(0)="AEQMZ",DIC("A")="Select Patient: ",D="D",DIC("S")="I $D(^(""FBREJ"")),$P(^(""FBREJ""),U,3)=FBN" D IX^DIC G DIC:$E(X)="^"!(X=""),DIC2:Y<0 S FBI=+Y,FBI(0)=Y(0) G END:'$D(^FBAAI(FBI,0))
 S FBLISTC="" D HOME^%ZIS,START^FBCHDI2
 ;
 ; enforce separation of duties
 S FBDFN=$P(FBI(0),U,4)
 S FB7078I=$P(FBI(0),U,5)
 S FTP=$S(FB7078I]"":$O(^FBAAA("AG",FB7078I,FBDFN,0)),1:"")
 I '$$UOKPAY^FBUTL9(FBDFN,FTP) D  G DIC2
 . W !!,"You cannot process a payment associated with authorization ",FBDFN,"-",FTP
 . W !,"due to separation of duties."
 ;
ASK S DIR(0)="Y",DIR("A")="Want to re-initiate this payment",DIR("B")="NO" D ^DIR K DIR G END:$D(DIRUT),DIC:'Y
 S (DIC,DIE)="^FBAAI(",DIC(0)="AEQM",DA=FBI,DR="20////^S X=FBNB" D ^DIE
 K ^FBAAI(FBI,"FBREJ"),^FBAAI("AH",FBN,FBI) S $P(FBNB(0),"^",10)=$P(FBNB(0),"^",10)+1,$P(FBNB(0),"^",11)=$P(FBNB(0),"^",11)+1,$P(FBNB(0),"^",18)="N",^FBAA(161.7,FBNB,0)=FBNB(0)
 I '$D(^FBAAI("AH",FBN)) S $P(FBN(0),"^",17)="",^FBAA(161.7,FBN,0)=FBN(0)
 I $D(^FBAAI("AH",FBN)) G DIC2
EDIT S DIR(0)="Y",DIR("A")="Want to edit payment now",DIR("B")="YES" D ^DIR K DIR G END:$D(DIRUT)!'Y
 S FBPRICE=""
 ;
 ; FB*3.5*123 - edit inpatient invoice - check for IPAC data for Federal Vendors
 I '$$IPACEDIT^FBAAPET1(162.5,FBI,.FBIA,.FBDODINV) G DIC2
 ;
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
 S LASTDX=$$LAST^FBCHEP1(FBI,"DX"),LASTPROC=$$LAST^FBCHEP1(FBI,"PROC")
 S (DIC,DIE)="^FBAAI(",DA=FBI,DR="[FBCH EDIT PAYMENT]"
 D  G END:$D(DTOUT)
 . N ICDVDT,DFN,FB583,FBAAMM1,FBAAPTC,FBCNTRA,FBCNTRP,FBV,FBVEN,FTP
 . S ICDVDT=$$FRDTINV^FBCSV1(DA) ; date for files 80 and 80.1 identifier
 . ; get variables for call to PPT^FBAACO1
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
 D RMVGAP^FBCHEP1(FBI,1)
END K DIC,D,DA,DIRUT,DR,DTOUT,DUOUT,FBPRICE,VAL,DIE,FBI,FBN,FBNB,FBTYPE,I,POP,X,Y,FBLISTC
 K FBFPPSC,FBFPPSL,FBADJ,FBADJL,FBRRMK,FBRRMKL
 K LASTDX,LASTPROC,FBIA,FBDODINV
 D END^FBCHDI
 Q
