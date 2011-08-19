IBTOUR1 ;ALB/AAS - CLAIMS TRACKING UR/ACTIVITY REPORT ; 27-OCT-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**56**; 21-MAR-94
 ;
% ;
 ; ibcnt(1) = total count of admissions
 ; ibcnt(1,1) = total count of admissions to nhcu
 ; ibcnt(1,2) = total count of admissions to domiciliary
 ; ibcnt(2) = total count of insured admissions
 ; ibcnt(3,0) = total count of billable admissions
 ; ibcnt(3,n) = count of non-billable admissions by reason (n)
 ; ibcnt(4) = count of admissions requiring reviews
 ; ibcnt(5) = admissions with pre-cert and follow-up
 ; ibcnt(6) = no pre-cert but active monitoring required
 ; ibcnt(7) = new closed cases = discharged, or no next rev. date, or ur not required
 ; ibcnt(7,0) = new cases closed, billable
 ; ibcnt(7,1) = new cases closed, not billable
 ; ibcnt(8) = new cases open (not closed)
 ;
 ; ibcnt(9) = previous case (find in REV), adm prior to begin date
 ; ibcnt(9,0) = cases closed billable
 ; ibcnt(9,1) = cases closed non-billable
 ; ibcnt(9,2) = previous cases still open
 ;
 ; ^tmp($j,"ibtour", $s(pt. name/specialty/review date) ,pt. name,sort3,ibtrc)=^ibt(ibtrc,0)
 ; ^tmp($j,"ibtour1",specialty)=days approved, days denied, $approved, $denied)
 ;
BLD ; -- build data
 ;initialize summary array
 F I=1:1:11 S IBCNT(I)=0 I I=7!(I=9) F J=0:1:2 S IBCNT(I,J)=0
 F I=40:1:52 S IBCNT(I)=0 I I=45 F J=1:1:3 S IBCNT(I,J)=0
 ;
 D ADM
 D:IBSORT'="H" IREV^IBTOUR2,ISUB
 D:IBSORT'="I" HREV^IBTOUR2,HSUB^IBTOUR5
 Q
 ;
ADM ; -- count admission
 D CHK^IBTOSUM2 I $G(ZTSTOP) Q
 S IBDT=IBBDT-.000000001
 F  S IBDT=$O(^DGPM("AMV1",IBDT)) Q:'IBDT!(IBDT>(IBEDT+.24))  D
 .S DFN=0 F  S DFN=$O(^DGPM("AMV1",IBDT,DFN)) Q:'DFN  D
 ..S DGPM=0 F  S DGPM=$O(^DGPM("AMV1",IBDT,DFN,DGPM)) Q:'DGPM  D
 ...S IBCNT(1)=IBCNT(1)+1 ; count of admissions
 ...I $P($G(^DIC(42,+$P(^DGPM(DGPM,0),"^",6),0)),"^",3)="NH" S IBCNT(1,1)=$G(IBCNT(1,1))+1 ; count nhcu admissions
 ...I $P($G(^DIC(42,+$P(^DGPM(DGPM,0),"^",6),0)),"^",3)="D" S IBCNT(1,2)=$G(IBCNT(1,2))+1 ; count domiciliary admissions
 ...S IBTRN=$O(^IBT(356,"AD",DGPM,0))
 ...Q:'IBTRN
 ...S IBTRND=$G(^IBT(356,+IBTRN,0))
 ...Q:'$P(IBTRND,"^",20)
 ...S X=$P($G(^IBT(356,+IBTRN,1)),"^",7) I X>3 S IBCNT(4)=IBCNT(4)+1,^TMP($J,"IBTOUR0",IBTRN)=IBTRN ;reviews required
 ...I X="",$P(IBTRND,"^",24),'$P(IBTRND,"^",19) S IBCNT(4)=IBCNT(4)+1,^TMP($J,"IBTOUR0",IBTRN)=IBTRN
 ...;
 ...S IBINS=$$INSURED^IBCNS1(DFN,IBDT) I IBINS S IBCNT(2)=IBCNT(2)+1 ; count of insured admissions
 ...I IBINS S IBCNT(3,+$P(IBTRND,"^",19))=$G(IBCNT(3,+$P(IBTRND,"^",19)))+1 ;count of NOT Billable by reason billable
 Q
 ;
ISUB ; -- count subtotals for cases reviewed
 N IBTRN,IBCLOS,DGPM,IBTPREV
 S IBTRN="" F  S IBTRN=$O(^TMP($J,"IBTOUR0",IBTRN)) Q:'IBTRN  D
 .S IBTRND=$G(^IBT(356,+IBTRN,0))
 .Q:'$P(IBTRND,"^",20)  ;inactive case
 .Q:$P(IBTRND,"^",8)  ;rx fill, don't count
 .S DGPM=$P($G(^IBT(356,+IBTRN,0)),"^",5)
 .S IBCLOS=$$CLOSED(DGPM,IBTRN)
 .S IBTPREV=0 I $P($G(^IBT(356,+IBTRN,0)),"^",6)<IBBDT S IBTPREV=1
 .I $P(IBTRND,"^",4) S IBCNT(10)=IBCNT(10)+1
 .D CASE
 .Q
 Q
 ;
CASE ; -- figure out case summary
 N I,J,IBPRE,IBFOL
 I IBTPREV D PREV
 S (IBFOL,IBPRE)=0
 I $O(^IBT(356.2,"APRE",IBTRN))'="" S IBPRE=1 ; is precert number
 S IBPCODE=$O(^IBE(356.11,"ACODE",10,0)) ; precert tracking type
 S IBCCODE=$O(^IBE(356.11,"ACODE",30,0)) ; cont. stay tracking type
 ;
 I 'IBPRE S IBTRC=$O(^IBT(356.2,"ATRTP",IBTRN,IBPCODE,0)) I IBTRC,$P($G(^IBT(356.2,+IBTRC,0)),"^",19)=10 S IBPRE=1
 ;
 S IBX=$P($G(^IBT(356,+IBTRN,1)),"^",7) I 'IBX D
 .I $O(^IBT(356.2,"ATRTP",IBTRN,IBCCODE,0)) S IBFOL=1
 .I IBPRE,IBFOL S IBCNT(5)=IBCNT(5)+1 ; adm with precert and follow up
 .I 'IBPRE,IBFOL S IBCNT(6)=IBCNT(6)+1 ; adm w/o precert but cont. monitor
 I IBX>4 S IBCNT(5)=IBCNT(5)+1
 I IBX=4 S IBCNT(6)=IBCNT(6)=1
 ;
 I IBCLOS S IBCNT(7,$S($P(IBTRND,"^",19):1,1:0))=IBCNT(7,$S($P(IBTRND,"^",19):1,1:0))+1,IBCNT(7)=IBCNT(7)+1
 ;
 I 'IBTPREV S IBX=$P($G(^IBT(356,+IBTRN,1)),"^",7) I IBX,IBX<4 S IBCNT(4)=IBCNT(4)+1 ; new case rev not required, but done.
 ;
 I 'IBCLOS,'IBTPREV S IBCNT(8)=IBCNT(8)+1 ;new cases still open
 I '$P(IBTRND,"^",5),$P(^IBE(356.6,+$P(IBTRND,"^",18),0),"^",8)=5 S IBCNT(11)=IBCNT(11)+1
CASEQ Q
 ;
CLOSED(DGPM,IBTRN) ; -- is case closed
 N IBI,IBJ,IBCLOSE
 S IBCLOSE=0
 I $P($G(^DGPM(+DGPM,0)),"^",17) S IBCLOSE=1 G CLOSEDQ ; - discharged
 I '$P($G(^IBT(356,+IBTRN,0)),"^",24) S IBCLOSE=1 G CLOSEDQ ; ur no longer required
 ;
 ; -- see if any reviews are still pending
 S IBCLOSE=1,IBI=0 F  S IBI=$O(^IBT(356.2,"C",+IBTRN,IBI)) Q:'IBI  I $P(^IBT(356.2,IBI,0),"^",24)>IBEDT S IBCLOSE=0 Q
 ;
CLOSEDQ Q IBCLOSE
 ;
PREV ; -- previous case
 Q:'$G(IBTPREV)
 I $P(IBTRND,"^",4)!($P(IBTRND,"^",8))!($P(IBTRND,"^",9)) Q  ; only count previous admissions
 S IBCNT(9)=IBCNT(9)+1 ; number of previous cases
 I 'IBCLOS S IBCNT(9,2)=IBCNT(9,2)+1 ; still open
 I IBCLOS S IBCNT(9,$S($P(IBTRND,"^",19):1,1:0))=IBCNT(9,$S($P(IBTRND,"^",19):1,1:0))+1 ;closed and billable or not
 Q
