IBAUTL ;ALB/AAS - INTEGRATED BILLING APPLICATION UTILITIES ; 14-FEB-91
 ;;2.0;INTEGRATED BILLING;**93,156,347,429,563**;21-MAR-94;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
COST ;  - find charges for transaction type, when only one
 N IBD,IBN,IB K X1
 S IBD=-($G(IBEFDT,DT)+.9)
 F  S IBD=$O(^IBE(350.2,"AIVDT",DA,IBD)) Q:'IBD  S IBN=0 F  S IBN=$O(^IBE(350.2,"AIVDT",DA,IBD,IBN)) Q:'IBN  S IB=$G(^IBE(350.2,IBN,0)) I IB]"",$$TIEROK^IBAUTL(IB),'$P(IB,"^",5)!($P(IB,"^",5)>$G(IBEFDT,DT)) S X1=$P(IB,"^",4) G COSTQ
COSTQ S X1=+$G(X1)
 I 'X1,$G(IBTIER),$D(^IBE(350.2,"AC",DA,2)) S IBTIER=2 G COST  ;default foced tier
 I 'IBN S Y="-1^IB029" Q
 I $L($G(^IBE(350.2,IBN,20))) X ^(20) I  S X1=X1+$P($G(^IBE(350.2,IBN,0)),"^",6)
 Q
TIEROK(IB) ; - if there is a tier present, make sure it matches
 ; if not present it's OK
 ; IB = zero node of 350.2 from COST above
 I '$D(IBTIER) Q 1
 I $P(IB,"^",7)=IBTIER Q 1
 Q 0
 ;
FY I $D(X) S IBAFY=$$FY^IBOUTL(X)
 Q
 ;
PTL ;  - parent trace logic
 ;  - input in x resulting from field from file 350
 ;  - output in y=1 if found, -1^error message if not found
 ;  -           y(0) = zeroth node of top level
 ;  -           y(1) = zeroth node of second level
 ;  -           y(n) = zeroth node of nth level
 ;
 K Y
 S Y=1 I '+X!'($D(^DIC(+X,0,"GL"))) S Y="-1^IB004" G PTLQ
 I +X=52 G PHAPI
 S IBAGL=^DIC(+X,0,"GL")
 I '$D(@(IBAGL_$P($P(X,";",1),":",2)_",0)")) S Y="-1^IB005" G PTLQ
 ;
 ; This naked reference should be set to the original data source that
 ; is causing this charge to be created.  The data source will be one of
 ; many different data sources that will generate patient charges.
 S Y(0)=^(0)
 ;
 F IBJJ=2:1 S IBII=$P(X,";",IBJJ) Q:IBII=""  D PTL1
PTLQ K IBAGL,IBII,IBJJ,IBMIN
 Q
 ;
PTL1 ;  - find y(n) of sublevels
 ; Call in here with a FOR loop to go each level deeper.  This will
 ; setup the subsripts in Y for all the data elements that go into
 ; causing this charge to be created.  It looks in the original data
 ; source file as approprite to obtain the information.  The naked
 ; reference should be the last data level in the data source appropriate
 ; data source file last looked up.
 ;
 S IBMIN=$P(IBII,":") I IBMIN="" S Y="-1^IB006" Q
 I '$D(^(IBMIN,$P(IBII,":",2),0)) S Y="-1^IB006" Q
 ;I '$D(^(+IBII,$P(IBII,":",2),0)) S Y="-1^IB006" Q
 S Y(IBJJ-1)=^(0)
 Q
 ;
CHKX ;  - check input x
 ;  -  piece 1 = service and exists
 ;  -  peice 2 = patient and exists
 ;  -  piece 3 = action type
 ;  -  piece 4 = user duz
 S DFN=$P(X,"^",2),IBSERV=+IBSAVX
 I $S('DFN:1,'$D(^DPT(DFN,0)):1,1:0) S Y="-1^IB002" G CHKXQ ;patient pointer bad
 I $S('IBSERV:1,'$D(^DIC(49,IBSERV,0)):1,1:0) S Y="-1^IB003" G CHKXQ ;service pointer bad
 I IBTAG=1 G CHKXQ
 S IBDUZ=$P(IBSAVX,"^",4) I $S('IBDUZ:1,'$D(^VA(200,IBDUZ,0)):1,1:0) S Y="-1^IB007" G CHKXQ
 I IBTAG=3 G CHKXQ
 S IBATYP=$P(IBSAVX,"^",3) I $S('IBATYP:1,'$D(^IBE(350.1,IBATYP,0)):1,1:0) S Y="-1^IB008"
CHKXQ Q
 ;
SITE ;  - calculate site from site parameters
 ;  -  output ibsite = station number
 ;  =         ibfac  = pointer to institution file
 I '$D(^IBE(350.9,1,0)) S Y="-1^IB016" Q
 S IBFAC=$P(^IBE(350.9,1,0),"^",2),IBSITE=$S('$D(^DIC(4,IBFAC,99)):"",1:+^(99)) I IBSITE<1 S Y="-1^IB009"
 Q
 ;
ADD ;  - add new entry to ^ib
 ;
 N %DT,IBYCHK
 L +^IB(0):10 I '$T S Y="-1^IB014" G ADDQ
 S X=$P($S($D(^IB(0)):^(0),1:"^^-1"),"^",3)+1 L -^IB(0) I 'X S Y="-1^IB015" G ADDQ
 K DD,DO,DIC,DR S DIC="^IB(",DIC(0)="L",DLAYGO=350
 F X=X:1 L:$D(IBN1) -^IB(IBN1) I X>0,'$D(^IB(X)) S IBN1=X L +^IB(IBN1):1 I $T,'$D(^IB(X)) S DINUM=X,X=+IBSITE_X D FILE^DICN I +Y>0 Q
 S IBN=+Y,DIE="^IB(",DA=IBN,DR=".02////"_$S($D(DFN):DFN,1:"")_";.03////"_$S($D(IBATYP):IBATYP,1:"")_";.05////1;12///NOW" D
 . N Y D ^DIE K DA,DR,DIE I $D(Y) S IBYCHK=Y
 L -^IB(IBN1)
 S Y=$S('$D(IBYCHK):1,1:"-1^IB028")
 ;
ADDQ K DO,DD,DINUM,DIC,IBN1 Q
 ;
ARPARM N X S X=DT
 D SITE,FY,NOW^%DTC S IBNOW=%
 Q
BILLNO ;  -get open bill number
 I '$G(IBTOTL) S (IBIL,IBTRAN)="" G BILLQ
 S IBARTYP=$S($D(^IBE(350.1,+IBATYP,0)):$P(^(0),"^",3),1:"")
 S X=IBSITE_"^"_IBSERV_"^"_IBARTYP_"^"_DFN_";DPT("_"^"_IBAFY_"^"_$S($D(IBTOTL):IBTOTL,1:0)_"^"_$S($D(IBDUZ):IBDUZ,$D(DUZ):DUZ,1:0)_"^"_$P(IBNOW,".",1) D ^PRCASER I +Y<1 G BILLQ
 S IBIL=$P(Y,"^",2),IBTRAN=$P(Y,"^",3) I IBIL="" S Y="-1^IB011" G BILLQ
 S IBTRAN=$S(IBTRAN>0:IBTRAN,1:"")
BILLQ Q
 ;
PHAPI ;
 ;This is alternate code for Parent Trace Logic
 ; to deal with the Pharmacy Encapsulation of Prescription File (#52)
 ;
 N IBRFL,IBXX,IBPT,IBRX,IBY
 S IBXX=X,IBY=1
 S IBRX=$P($P(IBXX,";"),":",2)
 S IBPT=$$FILE^IBRXUTL(IBRX,2),IBY(0)=$$RXZERO^IBRXUTL(IBPT,IBRX) I IBY(0)="" S IBY="-1^IB005" G PHAPIQ
 I $P(IBXX,";",2)="" G PHAPIQ ; original fill being billed
 S IBRFL=$P($P(IBXX,";",2),":",2),IBY(1)=$$ZEROSUB^IBRXUTL(IBPT,IBRX,IBRFL)
 I IBY(1)="" S IBY="-1^IB006" G PHAPIQ
 ;
PHAPIQ ;
 S:$G(IBY)]"" Y=IBY
 S:$G(IBY(0))]"" Y(0)=IBY(0)
 S:$G(IBY(1))]"" Y(1)=IBY(1)
 Q
 ;
RXTIER(DFN,IBRX,IBEFDT) ; - look up the tier of the prescription
 ; returns the tier level of the specified prescription
 ; the existence of the IBTIER variable means it is already determined elsewhere and we'll just use that value
 ; default tier is always 2
 ;
 N IBR
 I $D(IBTIER) Q IBTIER
 I '$G(IBRX) Q 2
 I $T(CPTIER^PSNAPIS)="" Q 2
 S IBR=$$RXZERO^IBRXUTL(DFN,IBRX)
 S IBR=$S($P(IBR,"^",6):$$DRUGF^IBRXUTL1($P(IBR,"^",6),22),1:0)
 S IBR=$S(IBR:$$CPTIER^PSNAPIS(+IBR,IBEFDT),1:2)
 I IBR="" S IBR=2
 Q +IBR
 ;
ARCOST(DFN,DA,IBX) ; api for AR to look up the charge of a med
 ; input:  DFN = patient pointer
 ;         DA = 350.1 pointer
 ;         IBX = Rx IEN
 ; output: returns the single 30 day supply charge amount
 ;   assumption, since AR is all about today, DT is used for the date
 ;
 N IBEFDT,X1,IBTIER
 S IBTIER=$$RXTIER(DFN,IBX,DT)
 S IBX=":"_IBX
 D COST
 Q X1
 ;
