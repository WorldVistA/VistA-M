IBTOUR5 ;ALB/AAS - CLAIMS TRACKING UR/ACTIVITY REPORT ; 14-FEB-94
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
% ;
HSUB ; -- compute subtotals for hospital reviews
 S IBTRN="" F  S IBTRN=$O(^TMP($J,"IBTOUR4",IBTRN)) Q:'IBTRN  D HSUB1
 Q
 ;
HSUB1 ; -- compute subtotals for 1 review
 S (IBDAYS,IBDAYN,IBPREV)=0,IBADM=""
 S IBCNT(40)=IBCNT(40)+1 ; cases reviewed
 S IBTRND=$G(^IBT(356,+IBTRN,0)),DGPM=$P(IBTRND,"^",5)
 I $P(IBTRND,"^",6)<IBBDT S IBPREV=1 S IBCNT(42)=IBCNT(42)+1 ;previous case
 S IBCLOSE=$$HCLOSE(DGPM,IBTRN)
 I 'IBPREV,'IBCLOSE S IBCNT(41)=IBCNT(41)+1 ; NEW case still open
 I IBPREV,'IBCLOSE S IBCNT(43)=IBCNT(43)+1 ;  Old case still open
 I $P(IBTRND,"^",25) S IBCNT(44)=IBCNT(44)+1
 I $P(IBTRND,"^",26) S IBCNT(45)=IBCNT(45)+1,IBCNT(45,$P(IBTRND,"^",26))=IBCNT(45,$P(IBTRND,"^",26))+1
 I $P(IBTRND,"^",27) S IBCNT(46)=IBCNT(46)+1 ; local cases
 S IBTRV="" F  S IBTRV=$O(^IBT(356.1,"C",IBTRN,IBTRV)) Q:'IBTRV  D
 .S IBTRVD=$G(^IBT(356.1,+IBTRV,0))
 .S (IBP1,IBP2,IBP3,IBP4)=0
 .I $P(IBTRVD,"^",21)'=10 Q  ; review must be complete
 .I +IBTRVD<IBBDT!(+IBTRVD>IBEDT) Q  ; review date out of range
 .S IBSPEC=$P($G(^DIC(45.7,+$P(IBTRVD,"^",7),0)),"^")
 .S IBCNT(48)=IBCNT(48)+1 ; count of days
 .I $P(IBTRVD,"^",3)<2 D
 ..S MET=$O(^IBT(356.1,+IBTRV,12,0)) ; >0 means not met
 ..I MET S IBCNT(50)=IBCNT(50)+1,IBCNT(51)=IBCNT(51)+1,(IBP2,IBP4)=1,IBADM=0,IBDAYN=IBDAYN+1
 ..I 'MET S IBCNT(49)=IBCNT(49)+1,IBCNT(47)=IBCNT(47)+1,(IBP1,IBP3)=1,IBADM=1,IBDAYS=IBDAYS+1
 .I $P(IBTRVD,"^",3)>1 D
 ..S MET=$O(^IBT(356.1,+IBTRV,13,0))
 ..I MET S IBCNT(50)=IBCNT(50)+1,IBP4=1,IBDAYN=IBDAYN+1
 ..I 'MET S IBCNT(49)=IBCNT(49)+1,IBP3=1,IBDAYS=IBDAYS+1
 .D HSET1^IBTOUR2
 D HSET2^IBTOUR2
 Q
 ;
HCLOSE(DGPM,IBTRN) ; -- is case closed
 N IBI,IBJ,IBCLOSE
 S IBCLOSE=0
 S IBTRND=$G(^IBT(356,+IBTRN,0))
 I $P($G(^DGPM(+DGPM,0)),"^",17) S IBCLOSE=1 G HCLOSEQ ; - discharged
 I '$P(IBTRND,"^",25),'$P(IBTRND,"^",26),'$P(IBTRND,"^",27) S IBCLOSE=1 G HCLOSEQ ; ur no longer required
 ;
 ; -- see if any reviews are still pending or if is a discharge date
 S IBCLOSE=1,IBI=0 F  S IBI=$O(^IBT(356.1,"C",IBTRN,IBI)) Q:'IBI  D  Q:'IBCLOSE
 .I $P(^IBT(356.1,IBI,0),"^",20)>IBEDT S IBCLOSE=0 Q
 ;
HCLOSEQ Q IBCLOSE
 ;
SUBHDR ; -- sub header for detailed listings from ibtour4
 Q:IBHOW="P"
 W !,?15,$S(IBHOW="S":"Specialty: ",1:"Reviewer: "),IBH
 Q
SSUBHDR ; -- sub sub header for detailed listings from ibtour4
 Q:IBHOW'="R"
 W !,?18,"Type Review: ",IBI
 Q
