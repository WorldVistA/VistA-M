IBOA32 ;ALB/CPM - PRINT ALL BILLS FOR A PATIENT (CON'T) ;28-JAN-92
 ;;2.0; INTEGRATED BILLING ;**7,95,347,433**;21-MAR-94;Build 36
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;MAP TO DGCRA32
 ;
 ; Print out IB Actions onto the list.
 D:($Y>(IOSL-5)) HDR^IBOA31 Q:IBQUIT
 N IBND,IBND1,X,IBX,IENS,IBRXN,IBRX,IBRF,IBRDT
 S IBND=$G(^IB($E(IBIFN,1,$L(IBIFN)-1),0)),IBND1=$G(^(1))
 S (IBRXN,IBRX,IBRF,IBRDT,IBX)=0
 I $P(IBND,"^",4)["52:" S IBRXN=$P($P(IBND,"^",4),":",2),IBRX=$P($P(IBND,"^",8),"-"),IBRF=$P($P(IBND,"^",4),":",3)
 I IBRF>0 S IBRDT=$$SUBFILE^IBRXUTL(+IBRXN,IBRF,52,.01)
 E  S IBRDT=$$FILE^IBRXUTL(+IBRXN,22),IBX=$$APPT^IBCU3(IBRDT,DFN)
 W !,$S($P(IBND,"^",11)]"":$P($P(IBND,"^",11),"-",2),$P(IBND,"^",5)=99:"",$P(IBND,"^",5)=10:"",1:"Pending")
 W ?12,$$DAT1^IBOUTL($S($P(IBND,"^",11)="":"",$P(IBND,"^",5)>2&($P(IBND,"^",5)'=99):$P(IBND1,"^",4)\1,1:""))
 S X=$P($P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^")," ",2,99)
 W ?21,$E($P(X," ",1,$L(X," ")-1),1,17)
 W ?41,$S($P(IBND,"^",4)["350:":$E($P(IBND,"^",8),1,14),$P(IBND,"^",3)<7:"Rx:"_IBRX_$S(IBRF>0:"("_IBRF_")",1:""),$P(IBND1,"^",5):"CHAMPVA SUBSIST",1:"AUT MEANS TEST")
 W:IBX=1 ?55,"*"
 W ?56,$$DAT1^IBOUTL(-IBDT)
 W ?66,$$DAT1^IBOUTL($S(IBRXN>0:IBRDT,$P(IBND,"^",14):$P(IBND,"^",14),1:$P(IBND1,"^",2)\1))
 W ?75,$$DAT1^IBOUTL($S($P(IBND,"^",15):$P(IBND,"^",15),1:$P(IBND1,"^",2)\1))
 W ?91,"N/A",?95,$E($P($G(^IBE(350.21,+$P(IBND,"^",5),0)),"^",2),1,17)
 Q
 ;
UTIL ; Gather all IB Actions for a patient.
 N DATE,IBN,X,A,B,C,D,E,IBNX
 S IBN=0 F  S IBN=$O(^IB("C",DFN,IBN)) Q:'IBN  S X=$G(^IB(IBN,0)) D:X
 . I 'IBIBRX,$E($G(^IBE(350.1,+$P(X,"^",3),0)),1,3)="PSO" Q
 . Q:$P(X,"^",8)["ADMISSION"
 . Q:'$D(^IB("APDT",IBN))
 . S (C,D)="",C=$O(^IB("APDT",IBN,C)),D=$O(^IB("APDT",IBN,C,D))
 . S E=$P($G(^IB(D,0)),U,3)
 . S A=$P($G(^IBE(350.1,E,0)),U,5)
 . S IBNX=$S(A=2:$P($Q(^IB("APDT",IBN,C,D)),")",1),A=3:$P($Q(^IB("APDT",IBN,C,D)),")",1),1:IBN)
 . I (A=2)!(A=3) D
 .. I IBNX["[""" S IBNX="^"_$P(IBNX,"]",2)
 . I $P(IBNX,",",4)>0 S IBNX=$P(IBNX,",",4)
 . S DATE=$P($G(^IB(+$P(X,"^",16),0)),"^",17)
 . S:'DATE DATE=$P($G(^IB(IBNX,1)),"^",5)
 . S:'DATE DATE=$P($G(^IB(IBNX,1)),"^",2)\1
 . S:DATE ^UTILITY($J,-DATE,IBNX_"X")=""
 Q
