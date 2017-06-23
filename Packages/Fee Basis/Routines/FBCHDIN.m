FBCHDIN ;AISC/DMK - DELETE INPATIENT INVOICE ;12/12/14  14:37
 ;;3.5;FEE BASIS;**132,154**;JAN 30, 1995;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
BAT ;ask batch Number
 ;cannot delete an invoice from a batch that has a status of
 ;supervisor closed, reviewed after pricer, transmitted or vouchered.
 ;A clerk may delete an invoice in a batch
 ;they own if the status is open, closed, forwarded to pricer or
 ;assigned price.
 ;
 D HOME^%ZIS
 W ! S DIC="^FBAA(161.7,",DIC(0)="AEQMZ"
 S DIC("S")=$S($D(^XUSEC("FBAA LEVEL 2",DUZ)):"I ""TFV""'[$G(^(""ST""))",1:"I $P(^(0),U,5)=DUZ&(""TFVRS""'[($G(^(""ST""))))")_"&($P(^(0),U,3)=""B9"")"
 D ^DIC K DIC G:Y<1 END
 L +^FBAA(161.7,+Y):$G(DILOCKTM,3)
 I '$T W !,"Another user is editing this batch.  Try again later." G BAT
 S FBBAT=+Y,FBBAT(0)=Y(0)
 ;
INV ;get invoice user wants to delete in batch selected
 W ! S DIC="^FBAAI(",DIC(0)="AEQZ",DIC("S")="I $D(^FBAAI(""AC"",FBBAT,X))"
 S DIC("A")="Select Invoice to delete: " D ^DIC K DIC I X=""!(X="^") L -^FBAA(161.7,FBBAT) G BAT
 S FBDINV=Y,FBDINV(0)=Y(0),FBI=+Y,FBLISTC=0 D START^FBCHDI
 ;
 ; enforce separation of duties
 S FBDFN=$P(FBDINV(0),U,4)
 S FB7078I=$P(FBDINV(0),U,5)
 S FTP=$S(FB7078I]"":$O(^FBAAA("AG",FB7078I,FBDFN,0)),1:"")
 I FBDFN,FTP,'$$UOKPAY^FBUTL9(FBDFN,FTP) D  L -^FBAA(161.7,FBBAT) G BAT
 . W !,"You cannot process a payment associated with authorization ",FBDFN,"-",FTP
 . W !,"due to separation of duties."
 ;
 W ! S DIR(0)="Y",DIR("B")="No",DIR("A")="Sure you want to delete this invoice" D ^DIR K DIR G END:$D(DIRUT) I 'Y L -^FBAA(161.7,FBBAT) G BAT
 ;
 S DA=+FBDINV,DIK="^FBAAI(" W !?5,".... deleting!",!
 D ^DIK K DIK
 ;
 ;reset batch dollar amount, total payment items and invoice count
 D CNTTOT^FBAARB(FBBAT)
 S $P(FBBAT(0),"^",9)=+FBTOTAL
 S $P(FBBAT(0),"^",10)=+FBLCNT
 S $P(FBBAT(0),"^",11)=+FBLCNT
 S:$P(FBBAT(0),"^",10)'>0 $P(FBBAT(0),"^",18)=""
 S $P(^FBAA(161.7,FBBAT,0),"^",9,11)=$P(FBBAT(0),"^",9,11),$P(^FBAA(161.7,FBBAT,0),"^",18)=$P(FBBAT(0),"^",18)
END I $G(FBBAT) L -^FBAA(161.7,FBBAT)
 K DA,FBBAT,FBLISTC,FBDINV,FBAAOUT,FBDX,FBDX1,FBPAT,FBPROC,FBVEN,X,Y,Q
 K FB7078I,FBDFN,FTP,DTOUT,DUOUT,DIRUT,DIROUT,FBI,FBLCNT,FBTOTAL
 D END^FBCHDI Q
