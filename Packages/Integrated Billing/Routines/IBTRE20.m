IBTRE20 ;ALB/AAS - CLAIMS TRACKING EXECUTABLE HELP ;13-OCT-93
 ;;2.0;INTEGRATED BILLING;**40,91,249**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
LISTA ; -- list inpatient admissions for patient
 N C,I,J,N,X,Y,IBX
 K ^TMP("IBM",$J)
 Q:'$D(DFN)
 S C=0 F I=0:0 S I=$O(^DGPM("ATID1",DFN,I)) Q:'I  S N=$O(^(I,0)) I $D(^DGPM(+N,0)) S D=^(0),C=C+1,^TMP("IBM",$J,C)=N_"^"_D
 ;
 I C=0 W !!,"No Admissions to Choose From." Q
 ;
 W !!,"CHOOSE FROM:" F IBI=1:1:10 Q:'$D(^TMP("IBM",$J,IBI))  D WRA
 K ^TMP("IBM",$J)
 Q
 ;
WRA S IBX=$P(^TMP("IBM",$J,IBI),"^",2,20),Y=+IBX X ^DD("DD")
 W !,"     ",Y
 W ?27,$S('$D(^DG(405.1,+$P(IBX,"^",4),0)):"",$P(^(0),"^",7)]"":$P(^(0),"^",7),1:$E($P(^(0),"^",1),1,20))
 ;
 W ?50,"TO:  ",$E($P($G(^DIC(42,+$P(IBX,"^",6),0)),"^"),1,17)
 I $D(^DG(405.4,+$P(IBX,"^",7),0)) W " [",$E($P(^(0),"^",1),1,10),"]"
 I $P(IBX,"^",18)=9 W !?23,"FROM:  ",$P($G(^DIC(4,+$P(IBX,"^",5),0)),"^")
 Q
 ;
LISTO ; -- list outpatient appointments
 N C,I,J,N,X,Y,IBX,IBI,IBDT
 ; assumes ^TMP($J,"SDAMA301",DFN,IBTDT) defined and IBSD(result from SD)
 Q:'$D(DFN)
 ;
 I IBSD<0 W !!,"Unable to look-up Outpatient Visits to Choose From." D  Q
 . N IBX F  S IBX=$O(^TMP($J,"SDAMA301",IBX)) Q:'IBX  W !?5,IBX,?10,$G(^(IBX))
 ;
 I IBSD=0 W !!,"No Outpatient Visits to Choose From." Q
 ;
 W !!,"CHOOSE FROM:" S IBI=0,IBDT=$G(IBTBDT) F  S IBDT=$O(^TMP($J,"SDAMA301",DFN,IBDT)),IBI=IBI+1 Q:'IBDT!(IBI>12)  D WRO
 Q
 ;
WRO N IBSDD,Y
 S Y=IBDT X ^DD("DD") W !,"     ",Y
 S IBSDD=$G(^TMP($J,"SDAMA301",DFN,IBDT))
 W ?27,"Clinic: ",$P($P(IBSDD,"^",2),";",2),?60," Type: ",$E($P($P(IBSDD,"^",10),";",2),1,12)
 ;
 S IBSDD=$P(IBSDD,"^",3) I $L(IBSDD),$P(IBSDD,";")'="R" W !,?10," [Status: ",$P(IBSDD,";",2),"]"
 Q
 ;
LISTS ; -- list scheduled admissions
 N C,I,J,N,X,Y,IBX,IBI
 K ^TMP("IBM",$J)
 Q:'$D(DFN)
 S C=0 F I=0:0 S I=$O(^DGS(41.1,"B",DFN,I)) Q:'I  I $D(^DGS(41.1,+I,0)) S D=$G(^DGS(41.1,+I,0)) I $P(D,"^",2)'<IBTBDT,$P(D,"^",2)'>IBTEDT S C=C+1,^TMP("IBM",$J,C)=I_"^"_D
 ;
 I C=0 W !!,"No Scheduled Admissions to Choose From." Q
 ;
 W !!,"CHOOSE FROM:" F IBI=1:1:12 Q:'$D(^TMP("IBM",$J,IBI))  D WRS
 K ^TMP("IBM",$J)
 Q
 ;
WRS S IBX=$P($G(^TMP("IBM",$J,IBI)),"^",2,20),Y=$P(IBX,"^",2) X ^DD("DD")
 W !,"     ",Y
 W ?27," Spec: ",$E($P($G(^DIC(45.7,+$P(IBX,"^",9),0)),"^"),1,25)
 ;
 W ?58," To: ",$E($P($G(^DIC(42,+$P(IBX,"^",8),0)),"^"),1,16)
 Q
 ;
FINDS ; -- match a scheduled admission
 Q:'$D(DFN)
 Q:'$D(IBTDT)
 N I,J
 S I=0 F  S I=$O(^DGS(41.1,"B",DFN,I)) Q:'I  S J=$P($G(^DGS(41.1,I,0)),"^",2) Q:IBTDT=J  I $P(IBTDT,".")=$P(J,".") S IBTDT=J Q
 Q
 ;
ID ; -- write out identifier for entry, called by ^dd(356,0,"id","write")
 N IBOE,IBOE0
 S IBOE=$P(^(0),"^",4),IBOE0=$$SCE^IBSDU(+IBOE) I IBOE,$P(IBOE0,U,4) W ?58,"["_$E($P($G(^SC(+$P(IBOE0,U,4),0)),U),1,20),"]"
 Q
 ;
PRINT ; patch 40, custom look up.  Input:  IBX  --  0th node in file #356.
 Q:$D(IBX)[0
 N NAM,EPIS,EVENT,DISPL,CLIN
 S NAM=$E($P($G(^DPT(+$P(IBX,U,2),0)),U),1,22)
 S EPIS=$P($P(IBX,U,6),".")
 I EPIS S EPIS=$E(EPIS,4,5)_"-"_$E(EPIS,6,7)_"-"_$E(EPIS,2,3)
 S EVENT=$E($P($G(^IBE(356.6,+$P(IBX,U,18),0)),U),1,5)
 S DISPL=$$EXPAND^IBTRE(356,.07,$P(IBX,U,7))
 S CLIN=+$$SCE^IBSDU(+$P(IBX,"^",4),4)
 I CLIN S DISPL="["_$E($P($G(^SC(CLIN,0)),U),1,22)_"]"
 W ?13,NAM,?37,EPIS,?47,EVENT,?54,DISPL
 Q
