PRCHQ1C ;(WASH IRMFO)/LKG-RFQ INPUT TRANSFORMS ETC (CONT) ;9/5/96  13:25
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
STUFFITM(PRCX,D0,D1) ;Stuff Item Master file info
 N PRCDT,PRCI,PRCV,PRCW,PRCY,PRCZ,%,%H,%I,X D NOW^%DTC S PRCDT=X
 I PRCX]"" D
 . S PRCZ=$G(^PRC(441,PRCX,0)) Q:PRCZ=""
 . S $P(^PRC(444,D0,2,D1,5),U)=$P(PRCZ,U,2)
 . K ^PRC(444,D0,2,D1,2)
 . I $P($G(^PRC(441,PRCX,1,0)),U,4)>0 D
 . . S PRCY=0,PRCI=0
 . . F  S PRCY=$O(^PRC(441,PRCX,1,PRCY)) Q:+PRCY'=PRCY  D
 . . . Q:'$D(^PRC(441,PRCX,1,PRCY,0))  S PRCW=^(0)
 . . . S PRCI=PRCI+1,^PRC(444,D0,2,D1,2,PRCI,0)=PRCW
 . . S ^PRC(444,D0,2,D1,2,0)="^^"_PRCI_"^"_PRCI_"^"_PRCDT
 . S $P(^PRC(444,D0,2,D1,0),U,5)=$P(PRCZ,U,3)
 . S $P(^PRC(444,D0,2,D1,0),U,11)=$P(PRCZ,U,14)
 . S $P(^PRC(444,D0,2,D1,0),U,7)=$P($G(^PRC(441,PRCX,3)),U,10)
 . S $P(^PRC(444,D0,2,D1,0),U,6)=$P(PRCZ,U,5)
 . S $P(^PRC(444,D0,2,D1,0),U,9)=$P($G(^PRC(441,PRCX,3)),U,5)
 . S PRCY=$P(PRCZ,U,4)
 . I PRCY="" S $P(^PRC(444,D0,2,D1,1),U,3,7)="^^^^" Q
 . S PRCZ=$G(^PRC(441,PRCX,2,PRCY,0)) Q:PRCZ=""
 . S $P(^PRC(444,D0,2,D1,1),U,3,7)=PRCY_U_$P(PRCZ,U,4)_U_$P(PRCZ,U,2)_U_$P(PRCZ,U,7)_U_$P(PRCZ,U,6)
 . S $P(^PRC(444,D0,2,D1,0),U,8)=$P(PRCZ,U,5)
 . S PRCW=$P(PRCZ,U,8),PRCV=$P(PRCZ,U,7) S:PRCW]"" PRCW="PACKAGING MULTIPLE: "_PRCW
 . S:PRCV]"" PRCW=PRCW_"/"_$P($G(^PRCD(420.5,PRCV,0)),U)
 . S:PRCV]"" $P(^PRC(444,D0,2,D1,0),U,3)=PRCV
 . I PRCW]"" D
 . . S PRCI=$P($G(^PRC(444,D0,2,D1,2,0)),U,3)
 . . S PRCI=PRCI+1,^PRC(444,D0,2,D1,2,PRCI,0)=PRCW
 . . S ^PRC(444,D0,2,D1,2,0)="^^"_PRCI_"^"_PRCI_"^"_PRCDT
 I PRCX="" D
 . S $P(^PRC(444,D0,2,D1,5),U)="" K ^PRC(444,D0,2,D1,2)
 . S $P(^PRC(444,D0,2,D1,0),U,3,9)="^^^^^^",$P(^(0),U,11)=""
 . S $P(^PRC(444,D0,2,D1,1),U,3,7)="^^^^"
 Q
ADMCERT(D0) ;Lookup and add Administrative Certification
 N DIR,DIC,X,Y,DIRUT,DIROUT,DTOUT,DUOUT,%,%H,%I,PRCDT,PRCI,PRCJ,PRCX,PRCY,PRCZ
 D NOW^%DTC S PRCDT=X
 S PRCJ=+$P($G(^PRC(444,D0,4,0)),U,4)
 W !,"There are currently ",PRCJ," lines of Administrative Certification."
 S DIR(0)="YA",DIR("A")="Do you wish to add a standard Administrative Certification phrase? "
 S DIR("B")="YES" D ^DIR K DIR
 I $D(DIRUT)!$D(DIROUT) S X="^" Q X
 I Y'=1 S X="" Q X
ADMLOOP S DIC=442.7,DIC(0)="AEMZ" D ^DIC K DIC
 I $D(DUOUT)!$D(DTOUT) S X="^" Q X
 I Y<1 S X="" Q X
 S PRCX=+Y,PRCY=0,PRCJ=$P($G(^PRC(444,D0,4,0)),U,3,4),PRCI=$P(PRCJ,U),PRCJ=$P(PRCJ,U,2)
 ;Adding a blank line between each Administrative Cert.
 I PRCI>0 D
 . S PRCI=PRCI+1
 . S PRCJ=PRCJ+1
 . S ^PRC(444,D0,4,PRCI,0)=" "
 F  S PRCY=$O(^PRC(442.7,PRCX,1,PRCY)) Q:+PRCY'=PRCY  D
 . Q:'$D(^PRC(442.7,PRCX,1,PRCY,0))  S PRCZ=^(0)
 . S PRCI=PRCI+1,PRCJ=PRCJ+1,^PRC(444,D0,4,PRCI,0)=PRCZ
 ;I PRCI>0 S PRCI=PRCI+1,PRCJ=PRCJ+1,^PRC(444,D0,4,PRCI,0)=PRCTILDA
 S:PRCJ>0 ^PRC(444,D0,4,0)="^^"_PRCI_"^"_PRCJ_"^"_PRCDT
 W !,"Administrative Certification phrase #",PRCX," has been added."
 G ADMLOOP
 ;
QUOTEDUE(PRCX,PRCY,PRCZ) ;Input transform for Date Quote Due in Input Template
 N X1,X2,%Y,X
 S X1=PRCX,X2=PRCY D ^%DTC I X<3 W !,"Quote Due Date must be at least 3 days after RFQ Reference Date." Q 1
 I PRCX'<PRCZ W !,"Quote Due Date must be before Required Delivery Date." Q 13
 S X=""
 Q X
DELTOTAL(D0,D1) ;Check Delivery Total
 N PRCX,PRCY S PRCX=""
 Q:$P($G(^PRC(444,D0,2,D1,4,0)),U,4)'>0 PRCX
 S PRCX=0,PRCY=0
 F  S PRCX=$O(^PRC(444,D0,2,D1,4,PRCX)) Q:+PRCX'=PRCX  D
 . S PRCY=PRCY+$P($G(^PRC(444,D0,2,D1,4,PRCX,0)),U,3)
 S PRCX=+$P($G(^PRC(444,D0,2,D1,0)),U,2)
 I PRCX'=PRCY W !,"Total Quantity of Delivery Schedule does NOT equal Item Quantity.",!,"    ",PRCY," versus ",PRCX S PRCX=20 Q PRCX
 S PRCX=""
 Q PRCX
NSN(PRCY) ;Validation of National Stock #
 N PRCX
 Q:PRCY="" PRCY
 I '$D(^PRC(441.2,+PRCY,0)) W !,"Invalid NSN - First 4 characters must be a FSC Code." Q 5
 S PRCX=$O(^PRC(441,"BB",PRCY,0))
 S:PRCX=PRCITMO PRCX=$O(^PRC(441,"BB",PRCY,PRCX))
 I PRCX'="" W !,"This NSN has already been assigned to Item #",PRCX Q 5
 S PRCY=""
 Q PRCY
PREF ;User enter editing preference into file #444.4
 K DIC,DA
 I '$D(^PRC(444.4,DUZ)) D  I Y<1!(+Y'=DUZ) W !,"Entry not properly added!" Q
 . K DD,DO S DIC="^PRC(444.4,",DIC(0)="LX",X=DUZ,DLAYGO=444.4,DINUM=X
 . D FILE^DICN K DIC,DLAYGO
 K DA S DA=DUZ,DIE="^PRC(444.4,",DR=1 D ^DIE K DIE,DR,DA,DTOUT,DUOUT
 Q
EDITOR() ;Returns the chosen editor
 N X,Y,DIR,DIRUT,DIROUT,DTOUT,DUOUT S X="" Q:$D(DUZ)#10'=1 X
 S X=$P($G(^PRC(444.4,DUZ,0)),U,2) I X="i"!(X="s") Q X
 S DIR(0)="SMA^i:Input Template;s:ScreenMan Form",DIR("A")="Enter Desired Input Mode: "
 S DIR("?",1)="Here you can indicate if you wish to edit in scroll mode with FileMan"
 S DIR("?")="  Input Templates or screen mode with ScreenMan"
 D ^DIR I $D(DIROUT)!$D(DIRUT)!$D(DTOUT) S X="" Q X
 Q Y
LINENETS(D0,D1) ;Stuffs net line amounts for items in quote
 ;;Net = Unit_Price * Quantity - Volume_Discount
 N PRCX,PRCY,PRCV,PRCW,PRCDA3
 S PRCDA3=0
 F  S PRCDA3=$O(^PRC(444,D0,8,D1,3,PRCDA3)) Q:+PRCDA3'=PRCDA3  D
 . S PRCV=$G(^PRC(444,D0,8,D1,3,PRCDA3,0)),PRCW=$G(^(1))
 . S PRCX=$P(PRCW,U,3)*$P(PRCV,U,2),PRCY=+$P(PRCW,U,4)
 . S PRCY=$S(PRCY>0:PRCX*PRCY/100,1:$P(PRCW,U,5))
 . S:PRCY>0 PRCX=PRCX-PRCY
 . S $P(^PRC(444,D0,8,D1,3,PRCDA3,1),U,7)=$FN(PRCX,"",2)
 Q
METHOD(PRCX,PRCVEN) ;Additional Validation for Method of Solicitation
 N PRCERR,PRCY S PRCY=""
 Q:PRCX="m" PRCY
 I PRCVEN'["PRC(440" S PRCERR=1 G METHMSG
 S:$P($G(^PRC(440,+PRCVEN,3)),U,2)'="Y" PRCERR=1
 S:$P($G(^PRC(440,+PRCVEN,7)),U,12)="" PRCERR=1
METHMSG I $G(PRCERR) D EN^DDIOL("Only MANUAL method is available for Non-EDI Vendor or vendor without Dun#.") Q 1
 Q PRCY
