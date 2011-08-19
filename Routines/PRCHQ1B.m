PRCHQ1B ;(WASH ISC)/LKG - Request for Quotation ;8/6/96  20:48
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
BOCINP ;Input transform for BOC
 N PRC2237,Z0,DIC
 S PRC2237=$P($G(^PRC(444,D0,0)),U,9) I PRC2237'?1.N K X Q
 S Z0=$S($D(^PRCS(410,PRC2237,3)):+$P(^(3),U,3),1:0)
 I 'Z0!'$D(^PRCD(420.1,Z0,1,0)) K X Q
 S DIC="^PRCD(420.1,Z0,1,",DIC(0)="EMQZ" D ^DIC
 I +Y'>0 K X Q
 S X=+$P(Y(0),U) I '$D(^PRCD(420.2,X,0)) K X Q
 Q
BOCHLP ;Executable help for BOC
 N PRCTXT,PRC2237,D,Z0,DIC,PRCDA S PRCDA=D0
 S PRCTXT(1)="Major budget object code classifications are:"
 S PRCTXT(2)="10 thru 13 - Personal Services and Benefits"
 S PRCTXT(3)="        21 - Travel and Transportation of Persons"
 S PRCTXT(4)="        22 - Transportation of Things"
 S PRCTXT(5)="        23 - Rent, Communications, and Utilities"
 S PRCTXT(6)="        24 - Printing and Reproduction"
 S PRCTXT(7)="        25 - Other Services"
 S PRCTXT(8)="        26 - Supplies and Materials"
 S PRCTXT(9)="31 thru 33 - Acquisition of Capital Assets"
 D EN^DDIOL(.PRCTXT)
 S PRC2237=$P($G(^PRC(444,PRCDA,0)),U,9)
 I PRC2237'?1.N D EN^DDIOL("2237 pointer is missing so can't determine available BOCs.") Q
 S X="?",Z0=$S($D(^PRCS(410,PRC2237,3)):+$P(^(3),U,3),1:0)
 I 'Z0!'$D(^PRCD(420.1,Z0,1,0)) D EN^DDIOL("2237's Cost Center is missing so can't determine available BOCs.") Q
 S DIC="^PRCD(420.1,Z0,1,",DIC(0)="QEM" D ^DIC
 Q
LINENET() ;Calculates the net line amount for item in quote
 ;;Net = Unit_Price * Quantity - Volume_Discount
 N PRCX,PRCY
 S PRCX=$$GET^DDSVAL(444.026,.DA,13)*$$GET^DDSVAL(444.026,.DA,2)
 S PRCY=+$$GET^DDSVAL(444.026,.DA,14)
 S PRCY=$S(PRCY>0:PRCX*PRCY/100,1:$$GET^DDSVAL(444.026,.DA,15))
 S:PRCY>0 PRCX=PRCX-PRCY
 Q $FN(PRCX,"",2)
STATUSDT ;Sets/Clears Date assigned critical statuses
 N PRCI S PRCI=$S(X=0:16,X=2:15,X=3:12,X=4:13,X=5:14,1:"")
 I PRCI]"" D
 . N %,%H,%I,X D NOW^%DTC
 . S $P(^PRC(444,DA,1),U,PRCI)=%
 I X=1!(X=2) D
 . S $P(^PRC(444,DA,1),U,12,13)="^"
 Q
DUN(Z) ;Returns Dun number for Solicited Vendor (Z=5) or Quote Vendor (Z=8)
 N X,Y S Y=""
 I $D(D0),$D(D1) D
 . S X=$P($G(^PRC(444,D0,Z,D1,0)),U) Q:X=""
 . S Y=$S($P(X,";",2)[440:$P($G(^PRC(440,$P(X,";"),7)),U,12),1:$P($G(^PRC(444.1,$P(X,";"),0)),U,2))
 Q Y
QUOTETOT(PRCD0,PRCD1) ;Sets Total for Quote in field #8 of subfile #444.024
 N PRCX,PRCI,DA,DIC,DIE,DR S PRCX=0,PRCI=0
 F  S PRCI=$O(^PRC(444,PRCD0,8,PRCD1,3,PRCI)) Q:PRCI'?1.N  D
 . S PRCX=PRCX+$P($G(^PRC(444,PRCD0,8,PRCD1,3,PRCI,1)),U,7)
 S PRCX=PRCX+$P($G(^PRC(444,PRCD0,8,PRCD1,1)),U,2)
 S DA=PRCD1,DA(1)=PRCD0,DIE="^PRC(444,DA(1),8,",DR="8///^S X=PRCX"
 D ^DIE
 Q
PUBLIC ;Sets Required status of Transmit to Public field
 N PRCX,PRCIENS
 S PRCX=$$GET^DDSVAL(444,DA,6,"","I"),PRCX=$S(PRCX="m":0,1:1)
 S PRCIENS=DA_","
 D REQ^DDSUTL(2,"PRCHQ7",6,PRCX,PRCIENS)
 Q
PUBLIC2 ;Sets Require status of Transmit to Public when Method
 ;of Processing Changes.
 N PRCX,PRCIENS
 S PRCIENS=DA_",",PRCX=$S(X="m":0,1:1)
 D REQ^DDSUTL(2,"PRCHQ7",6,PRCX,PRCIENS)
 Q
FCP ;Input Transform for Fund Control Point
 N Z0,DIC
 S Z0=$E($P(^PRC(444,DA,0),U),1,3) K:'Z0 X Q:'Z0
 Q:'$D(^PRC(420,Z0,1,0))
 S DIC="^PRC(420,Z0,1,",DIC(0)="QEMNZ" D ^DIC S X=$P(Y(0),U)
 K:Y'>0 X
 Q
FCPHLP ;Executable Help for Fund Control Point
 N ZD,Z0,DIC
 S:$D(D)#10=1 ZD=D,X="?",Z0=$E($P(^PRC(444,DA,0),U),1,3) Q:'Z0
 Q:'$D(^PRC(420,Z0,1,0))
 S DIC="^PRC(420,Z0,1,",DIC(0)="QEM" D ^DIC S:$D(ZD)#10=1 D=ZD
 Q
REQDFLD1 ;Checks required fields in Item edit page
 N PRCIT,PRCJ,PRCAR,PRCWP
 S PRCJ=1
 S PRCIT=$$GET^DDSVAL(444.019,.DA,.01)
 I PRCIT="" S PRCJ=PRCJ+1,PRCAR(PRCJ)="Line Item # is missing"
 S PRCWP=$$GET^DDSVAL(444.019,.DA,1.5)
 I $P($G(@PRCWP@(0)),U,4)'>0 S PRCJ=PRCJ+1,PRCAR(PRCJ)="Description is missing for Item #"_PRCIT
 I $$GET^DDSVAL(444.019,.DA,1.6)="" S PRCJ=PRCJ+1,PRCAR(PRCJ)="Short Description is missing for Item #"_PRCIT
 I $$GET^DDSVAL(444.019,.DA,3)="" S PRCJ=PRCJ+1,PRCAR(PRCJ)="Unit of Purchase is missing for Item #"_PRCIT
 I $$GET^DDSVAL(444.019,.DA,2)="" S PRCJ=PRCJ+1,PRCAR(PRCJ)="Quantity is missing for Item #"_PRCIT
 I $$GET^DDSVAL(444.019,.DA,6)="" S PRCJ=PRCJ+1,PRCAR(PRCJ)="SIC Code is missing for Item #"_PRCIT
 I $$GET^DDSVAL(444.019,.DA,4)="" S PRCJ=PRCJ+1,PRCAR(PRCJ)="Federal Supply Class is missing for Item #"_PRCIT
 I $$GET^DDSVAL(444.019,.DA,12.5)="" S PRCJ=PRCJ+1,PRCAR(PRCJ)="BOC is missing for Item #"_PRCIT
 I PRCJ>1 D
 . S PRCAR(1)="** Warning: The following Required Fields were not completed: "
 . D HLP^DDSUTL(.PRCAR) D HLP^DDSUTL("$$EOP")
 Q
REQDFLD2 ;Checks required fields in Delivery Schedule
 N PRCDS,PRCJ,PRCAR S PRCJ=1
 Q:$G(DA)'>0
 S PRCDS=$$GET^DDSVAL(444.039,.DA,.01) Q:PRCDS=""
 I $$GET^DDSVAL(444.039,.DA,1)="" S PRCJ=PRCJ+1,PRCAR(PRCJ)="Delivery Date is missing for Delivery Schedule #"_PRCDS
 I $$GET^DDSVAL(444.039,.DA,2)="" S PRCJ=PRCJ+1,PRCAR(PRCJ)="Quantity is missing for Delivery Schedule #"_PRCDS
 I PRCJ>1 D
 . S PRCAR(1)="** Warning: The following Required Fields were not completed: "
 . D HLP^DDSUTL(.PRCAR) D HLP^DDSUTL("$$EOP")
 Q
METHOD(PRCX) ;Additional Data Validation for Method of Solicitation
 Q:PRCX="m"  N PRCVEN
 S PRCVEN=$$GET^DDSVAL(444.01,.DA,.01,"","I")
 I PRCVEN'["PRC(440" S DDSERROR=1
 I PRCVEN["PRC(440",$P($G(^PRC(440,+PRCVEN,3)),U,2)'="Y" S DDSERROR=1
 I PRCVEN["PRC(440",$P($G(^PRC(440,+PRCVEN,7)),U,12)="" S DDSERROR=1
 D:$G(DDSERROR)=1 HLP^DDSUTL("Only MANUAL method is available for Non-EDI Vendor or vendor without Dun#.")
 Q
DBCHK(PRCX) ;Validates Dun & Bradstreet # by Mod 10 and Mod 10 plus 5
 N I,T,V,W,Y,Z S Y=$E(PRCX,$L(PRCX))
 S W="" F I=1:1:$L(PRCX)-1 S Z=$E(PRCX,I),W=W_(1+(I#2=0)*Z)
 S T=0 F I=1:1:$L(W) S T=T+$E(W,I)
 S V=T\10+1*10-T,V=$E(V,$L(V))
 I V=Y Q 1 ;Mod 10 checksum
 S V=V+5,V=$E(V,$L(V)) I V=Y Q 1 ;Mod 10 plus 5 checksum
 Q 0
