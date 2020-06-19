IBOA32 ;ALB/CPM - PRINT ALL BILLS FOR A PATIENT (CON'T) ;28-JAN-92
 ;;2.0;INTEGRATED BILLING;**7,95,347,433,451,645,669**;21-MAR-94;Build 20
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;MAP TO DGCRA32
 ;
 ; Print out IB Actions onto the list.
 D:($Y>(IOSL-5)) HDR^IBOA31 Q:IBQUIT
 N IBND,IBND1,X,IBX,IENS,IBRXN,IBRX,IBRF,IBRDT,IBPFLAG,IBIEN,IBTYPE
 S IBND=$G(^IB($E(IBIFN,1,$L(IBIFN)-1),0)),IBND1=$G(^(1))
 S (IBRXN,IBRX,IBRF,IBRDT,IBX)=0
 I $P(IBND,"^",4)["52:" S IBRXN=$P($P(IBND,"^",4),":",2),IBRX=$P($P(IBND,"^",8),"-"),IBRF=$P($P(IBND,"^",4),":",3)
 I IBRF>0 S IBRDT=$$SUBFILE^IBRXUTL(+IBRXN,IBRF,52,.01)
 E  S IBRDT=$$FILE^IBRXUTL(+IBRXN,22),IBX=$$APPT^IBCU3(IBRDT,DFN)
 ; IB*2.0*451 - Check for EEOB on associated 3rd party bills and attach EOB indicator '%' if applicable
 S IBPFLAG="" I $P(IBND,"^",11)'="" S IBPFLAG=$$IBEEOBCK^IBJDF41($P(IBND,"^",11),DFN)  ; Pass AR BILL#, Pat ID
 W !,IBPFLAG,$S($P(IBND,"^",11)]"":$P($P(IBND,"^",11),"-",2),$P(IBND,"^",5)=99:"",$P(IBND,"^",5)=10:"",1:"Pending")
 ; IB*2.0*451 - make space for EEOB indicator '%' next to the bill #
 W:'IBEXCEL ?9,$$DAT1^IBOUTL($S($P(IBND,"^",11)="":"",$P(IBND,"^",5)>2&($P(IBND,"^",5)'=99):$P(IBND1,"^",4)\1,1:""))
 W:IBEXCEL U,$$DAT1^IBOUTL($S($P(IBND,"^",11)="":"",$P(IBND,"^",5)>2&($P(IBND,"^",5)'=99):$P(IBND1,"^",4)\1,1:""))
 ; Patch IB*2.0*645 - adding community care - action types
 S IBIEN=$G(^IBE(350.1,+$P(IBND,"^",3),0))
 S IBIEN=+$P(IBND,"^",3)
 S IBTYPE=$$GETATYPE(IBIEN)
 I 'IBEXCEL D  Q
 . W ?19,IBTYPE
 . W ?38,$E($S($P(IBND,"^",4)["350:":$E($P(IBND,"^",8),1,14),$P(IBND,"^",3)<7:"Rx:"_IBRX_$S(IBRF>0:"("_IBRF_")",1:""),$P(IBND1,"^",5):"CHAMPVA SUBSIST",1:"AUT MEANS TEST"),1,14)
 . W:IBX=1 ?54,"*"
 . W ?55,$$DAT1^IBOUTL(-IBDT)
 . W ?65,$$DAT1^IBOUTL($S(IBRXN>0:IBRDT,$P(IBND,"^",14):$P(IBND,"^",14),1:$P(IBND1,"^",2)\1))
 . W ?75,$$DAT1^IBOUTL($S($P(IBND,"^",15):$P(IBND,"^",15),1:$P(IBND1,"^",2)\1))
 . W ?90,"N/A",?95,$E($P($G(^IBE(350.21,+$P(IBND,"^",5),0)),"^",2),1,17)
 ;Otherwise, EXCEL output
 W U,IBTYPE
 W U,$E($S($P(IBND,"^",4)["350:":$E($P(IBND,"^",8),1,14),$P(IBND,"^",3)<7:"Rx:"_IBRX_$S(IBRF>0:"("_IBRF_")",1:""),$P(IBND1,"^",5):"CHAMPVA SUBSIST",1:"AUT MEANS TEST"),1,14),U
 W:IBX=1 "*"
 W $$DAT1^IBOUTL(-IBDT)
 W U,$$DAT1^IBOUTL($S(IBRXN>0:IBRDT,$P(IBND,"^",14):$P(IBND,"^",14),1:$P(IBND1,"^",2)\1))
 W U,$$DAT1^IBOUTL($S($P(IBND,"^",15):$P(IBND,"^",15),1:$P(IBND1,"^",2)\1))
 W U,"N/A",U,$E($P($G(^IBE(350.21,+$P(IBND,"^",5),0)),"^",2),1,17)
 Q
 ;
UTIL ; Gather all IB Actions for a patient.
 N DATE,IBN,X,A,B,C,D,E,IBNX,IBNIEN
 S IBN=0 F  S IBN=$O(^IB("C",DFN,IBN)) Q:'IBN  S X=$G(^IB(IBN,0)) D:X
 . I 'IBIBRX,$E($G(^IBE(350.1,+$P(X,"^",3),0)),1,3)="PSO" Q
 . Q:$P(X,"^",8)["ADMISSION"
 . Q:'$D(^IB("APDT",IBN))
 . S (C,D)="",C=$O(^IB("APDT",IBN,C)),D=$O(^IB("APDT",IBN,C,D))
 . S E=$P($G(^IB(D,0)),U,3)
 . S A=$P($G(^IBE(350.1,E,0)),U,5)
 . S IBNX=$S(A=2:$P($Q(^IB("APDT",IBN,C,D)),")",1),A=3:$P($Q(^IB("APDT",IBN,C,D)),")",1),1:IBN)
 . ; Quit if the reference returned by the $Q is not for the same Patient. (IB*2.0*669
 . I A=2!(A=3) S IBNIEN=$P(IBNX,",",4)
 . I A'=2&(A'=3) S IBNIEN=IBNX
 . Q:$P($G(^IB(IBNIEN,0)),U,2)'=DFN
 . ; End of IB*2.0*669 changes
 . I (A=2)!(A=3) D
 .. I IBNX["[""" S IBNX="^"_$P(IBNX,"]",2)
 . I $P(IBNX,",",4)>0 S IBNX=$P(IBNX,",",4)
 . S DATE=$P($G(^IB(+$P(X,"^",16),0)),"^",17)
 . S:'DATE DATE=$P($G(^IB(IBNX,1)),"^",5)
 . S:'DATE DATE=$P($G(^IB(IBNX,1)),"^",2)\1
 . S:DATE ^UTILITY($J,-DATE,IBNX_"X")=""
 Q
 ;
GETATYPE(IBIEN) ; Patch IB*2.0*645 - added community care - action types
 S IBTYPE=$P(^IBE(350.1,IBIEN,0),"^") I $E(IBTYPE,1,2)="DG" Q $E($P(IBTYPE," ",2,99),1,17)
 I $E(IBTYPE,1,3)="PSO" Q $E($P(IBTYPE," ",2,99),1,17)
 Q $E(IBTYPE,1,17)
