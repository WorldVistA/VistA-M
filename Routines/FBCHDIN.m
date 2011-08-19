FBCHDIN ;AISC/DMK-DELETE INPATIENT INVOICE ;1/12/93  08:10
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
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
 S DIC("S")=$S($D(^XUSEC("FBAASUPERVISOR",DUZ)):"I ""TV""'[$G(^(""ST""))",1:"I $P(^(0),U,5)=DUZ&(""TVRS""'[($G(^(""ST""))))")_"&($P(^(0),U,3)=""B9"")"
 D ^DIC K DIC G END:X=""!(X="^")
 L +^FBAA(161.7,+Y)
 S FBBAT=+Y,FBBAT(0)=Y(0)
 ;
INV ;get invoice user wants to delete in batch selected
 W ! S DIC="^FBAAI(",DIC(0)="AEQZ",DIC("S")="I $D(^FBAAI(""AC"",FBBAT,X))"
 S DIC("A")="Select Invoice to delete: " D ^DIC K DIC I X=""!(X="^") L -^FBAA(161.7,FBBAT) G BAT
 S FBDINV=Y,FBDINV(0)=Y(0),FBI=+Y,FBLISTC=0 D START^FBCHDI
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
 D END^FBCHDI Q
