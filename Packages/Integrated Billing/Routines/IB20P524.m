IB20P524 ;ALB/CXW - IB V2.0 POST INIT, IB Action Type Update; 21-APR-2014
 ;;2.0;INTEGRATED BILLING;**524**;21-MAR-94;Build 24
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POST ; 
 N IBX
 D MSG("    IB*2*524 Post-Install .....")
 D IBAFSV,IBUFSV,IBCHGE
 D MSG("    IB*2*524 Post-Install Complete")
 Q
 ;
IBAFSV ; addition for fee service inpt per diem and fee service nsc rx copay
 N IBI,IBY,IBY1,IBCR,IBAR,IBSR,IBPTL,IBSL,IBFPL,IBEL,DIC,DIE,DA,DR,U,X,Y
 S U="^",IBSR=""
 D MSG(""),MSG(">>> Adding new action type to IB Action Type file #350.1...")
 F IBI=1:1 S IBCR=$P($T(IBAT+IBI),";;",2) Q:IBCR="QUIT"  D
 . S IBY=$P(IBCR,U)
 . S IBY1=$O(^IBE(350.1,"B",IBY,0))
 . I IBY1 D MSG(" >> "_IBY_" already exists in the file") Q
 . S IBAR=$P(IBCR,U,3)
 . S IBAR=$O(^PRCA(430.2,"B",IBAR,0))
 . I 'IBAR D MSG(" >> "_IBAR_" not defined in AR Category file (#430.2)") Q
 . I $P(IBCR,U,4)="P" S IBSR=$O(^IBE(350.1,"B","DG INPT PER DIEM NEW",0)),IBSR=$P($G(^IBE(350.1,+IBSR,0)),"^",4)
 . I $P(IBCR,U,4)="N" S IBSR=$O(^IBE(350.1,"B","PSO NSC RX COPAY NEW",0)),IBSR=$P($G(^IBE(350.1,+IBSR,0)),"^",4)
 . S X=IBY,DIC="^IBE(350.1,",DIC(0)="" D FILE^DICN
 . I Y<1 D MSG(" >> ERROR when adding "_IBY_" to the file, Log a Remedy ticket!") Q
 . ; input transform bypass in service field
 . S DA=+Y,DIE=DIC,DR=".02///"_$P(IBCR,U,2)_";.03///"_IBAR_";.04////"_IBSR_";.05///"_$P(IBCR,U,5)_";.08///"_$P(IBCR,U,6)
 . ; mirror logic of dg inpt per diem and pso nsc rx copay
 . S (IBPTL,IBSL,IBFPL,IBEL)=""
 . I $P(IBCR,U,9) S IBPTL=$P($T(NPTL+1),";;",2)
 . I $P(IBCR,U,10) S IBSL=$S($P(IBCR,U,2)="FSINT PD":$P($T(PSL+1),";;",2),1:$P($T(NSL+1),";;",2))
 . I $P(IBCR,U,11) S IBFPL=$P($T(NFPL+1),";;",2)
 . I $P(IBCR,U,12) S IBEL=$P($T(NEL+1),";;",2)
 . S DR=DR_";.1///"_$P(IBCR,U,7)_";.11///"_$P(IBCR,U,8)_";10///"_IBPTL_";20///"_IBSL_";30///"_IBFPL_";40///"_IBEL
 . D ^DIE K X,Y,DA,DIC,DIE,DR
 . D MSG(" >> "_IBY_" added")
 Q
IBUFSV ; add the pointers created from IBAFSV to these fields in file (#350.1)
 N IBI,IBRC,IBNEW,IBCAN,IBUPD,IBJ,DA,DR,DIE
 F IBI=1:1 S IBRC=$P($T(IBUT+IBI),";;",2) Q:IBRC="QUIT"  D
 . S IBNEW=$O(^IBE(350.1,"B",$P(IBRC,"^"),0))
 . S IBCAN=$O(^IBE(350.1,"B",$P(IBRC,"^",2),0))
 . S IBUPD=$O(^IBE(350.1,"B",$P(IBRC,"^",3),0))
 . F IBJ=IBNEW,IBCAN,IBUPD D
 .. Q:'IBJ
 .. S DIE="^IBE(350.1,",DA=IBJ
 .. S DR=".06///"_IBCAN_";.07///"_IBUPD_";.09///"_IBNEW
 .. D ^DIE K DA,DR,DIE
 Q
IBCHGE ; add the billing rate for FS to the charge table in file (#350.2)
 N IBEDT,IBI,IBCR,IBN,IBNM,IBN20,IBK,DA,DIC,DIE,DR,X,Y
 S IBEDT=3140312
 D MSG(""),MSG(">>> Adding new billing rate to IB Action Charge file #350.2...")
 F IBI=1:1 S IBCR=$P($T(IBAC+IBI),";;",2) Q:IBCR="QUIT"  D
 . S IBNM=$P(IBCR,U),IBK=$P(IBCR,U,2)
 . S IBN=$O(^IBE(350.1,"B",IBNM,0)) Q:'IBN
 . I $D(^IBE(350.2,"AIVDT",IBN,-IBEDT)) D MSG(" >> The billing rate for "_IBNM_" already exists in the file") Q
 . ; additional amount logic
 . S IBN20="I $G(DFN)>0,$$PRIORITY^DGENA(DFN)>6"
 . S X=IBK,DIC="^IBE(350.2,",DIC(0)="" D FILE^DICN
 . I Y<1 D MSG(" >> ERROR when adding the billing rate for "_IBNM_" to the file, Log a Remedy ticket!") Q 
 . S DIE="^IBE(350.2,",DA=+Y,DR=".02///"_IBEDT_";.03///"_IBN_";.04///"_$P(IBCR,U,4)
 . I $P(IBCR,U,6) S DR=DR_";.06///"_$P(IBCR,U,6)_";20///"_IBN20
 . D ^DIE D MSG(" >> The billing rate for "_IBNM_" added")
 D MSG("")
 Q
 ;
MSG(IBX) ;
 D MES^XPDUTL(IBX)
 Q
 ;
NPTL ; Parent Trace Logic for FS nsc rx copay new/cancel/update
 ;;D PTL^IBAUTL
 ;
PSL ; Set Logic for FS inpt per diem new
 ;;S IBDESC="INPT PER DIEM"
 ;
NSL ; Set Logic for FS nsc rx copay new/cancel/update
 ;;S:'$D(^(10)) X="" I $D(^(10)) X ^(10) S X=$S($D(Y(0)):$P(Y(0),U),1:"UNK") I $D(Y(0)) S X=X_"-"_$S($$DRUG^IBRXUTL1(+$P(Y(0),U,6))'="":$$DRUG^IBRXUTL1(+$P(Y(0),U,6)),1:"UNK DRUG"),X=$E(X,1,18)_"-"_$S($D(IBUNIT):IBUNIT,$D(IBX):$P(IBX,U,2),1:"")
 ;
NFPL ; Full Profile Logic for FS nsc rx copay new/cancel/update
 ;;I $D(X) D EN^PSOCPVW
 ;
NEL ; Eligibility Logic for FS nsc rx copay new
 ;;S X=0,X1="",X2="" G:'$D(VAEL) 1^IBAERR I VAEL(4),'+VAEL(3),'IBDOM,'$$RXEXMT^IBARXEU0(DFN,DT) S X=1,X2=$P(^IBE(350.1,DA,0),"^",4) D COST^IBAUTL
 ;
IBAT ; Name^abbreviation^charge category^service^sequence #^user lookup name^place on hold^billing group^parent trace logic^set logic^full profile logic^eligibility logic
 ;;FEE SERV INPT PER DIEM NEW^FSINT PD^HOSPITAL CARE PER DIEM^P^1^FEE SERV INPT PER DIEM^1^3^^1
 ;;FEE SERV INPT PER DIEM CANCEL^CAN FSPD^HOSPITAL CARE PER DIEM^P^2
 ;;FEE SERV INPT PER DIEM UPDATE^UPD FSPD^HOSPITAL CARE PER DIEM^P^3^^1^3
 ;;FEE SERV NSC RX COPAY NEW^FSNSC CO^RX CO-PAYMENT/NSC VET^N^1^FEE SERV NSC RX CO^1^5^1^1^1^1
 ;;FEE SERV NSC RX COPAY CANCEL^CAN FNSC^RX CO-PAYMENT/NSC VET^N^2^^^^1^1^1
 ;;FEE SERV NSC RX COPAY UPDATE^UPD FNSC^RX CO-PAYMENT/NSC VET^N^3^^1^5^1^1^1
 ;;QUIT
 ;
IBUT ; new action^cancel action^update action
 ;;FEE SERV INPT PER DIEM NEW^FEE SERV INPT PER DIEM CANCEL^FEE SERV INPT PER DIEM UPDATE
 ;;FEE SERV NSC RX COPAY NEW^FEE SERV NSC RX COPAY CANCEL^FEE SERV NSC RX COPAY UPDATE
 ;;QUIT
 ;
IBAC ; transaction type^key^active dt^unit charge^inactive dt^additional amount
 ;;FEE SERV INPT PER DIEM NEW^FEE SERV INPT PER DIEM^^10
 ;;FEE SERV NSC RX COPAY NEW^FEE SERV RX1^^8^^1
 ;;FEE SERV NSC RX COPAY CANCEL^FEE SERV RX3^^8^^1
 ;;FEE SERV NSC RX COPAY UPDATE^FEE SERV RX4^^8^^1
 ;;QUIT
 ;
