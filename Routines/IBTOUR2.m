IBTOUR2 ;ALB/AAS - CLAIMS TRACKING UR/ACTIVITY REPORT ; 27-OCT-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**45**; 21-MAR-94
 ;
% ;
 ; -- insurance: ^tmp($j,"ibtour", $s(pt. name/specialty/review date) ,pt. name,sort3,ibtrc)=^ibt(ibtrc,0)
 ;               ^tmp($j,"ibtour0,ibtrn)=ibtrn (case list)
 ;               ^tmp($j,"ibtour1",specialty)=days approved ^ days denied ^ $approved ^ $denied
 ;
 ; -- hospital: ^tmp($j,"ibtour3",$s...
 ;              ^tmp($j,"ibtour2",specialty)= adm. met ^ adm not met ^ days met ^ days not met
 ;              ^tmp($j,"ibtour4",ibtrn)=ibtrn (case list)
 ;
 ;
IREV ; -- count and sort reviews
 N IBDT,J
 S IBDT=IBBDT-.00001
 F  S IBDT=$O(^IBT(356.2,"B",IBDT)) Q:'IBDT!(IBDT>(IBEDT+.9))!(IBQUIT)  D
 .S IBTRC=0 F  S IBTRC=$O(^IBT(356.2,"B",IBDT,IBTRC)) Q:'IBTRC!(IBQUIT)  D
 ..S IBTRCD=$G(^IBT(356.2,+IBTRC,0)) Q:IBTRCD=""
 ..S IBTRN=$P(IBTRCD,"^",2)
 ..Q:$P(IBTRCD,"^",19)<10
 ..D SET
 Q
 ;
SET ; -- set utility array
 Q:'$G(IBTRN)
 N DFN,SORT1,SORT2,SORT3,IBSPEC,IBBBS,RATE,IBAC,IBDAY,IBDA,IBDD,IBCDT
 S DFN=+$P(IBTRCD,"^",5) Q:'DFN
 ;
 S IBSPEC=$$SPEC^IBTOSUM1(IBTRC)
 S IBBBS=$$BBS^IBTOSUM1(+IBSPEC)
 S RATE=$$RATE^IBTOSUM1(IBBBS,+IBTRCD)
 S IBAC=$$ACTION^IBTOSUM1(IBTRC)
 S IBSPEC=$P(IBSPEC,"^",2) S:IBSPEC="" IBSPEC="Unknown"
 ;
 I $P(^IBT(356,+$P(IBTRCD,"^",2),0),"^",4) S IBSPEC="OUTPATIENT VISIT",RATE=178
 ;
 I $P(^IBT(356,+$P(IBTRCD,"^",2),0),"^",8) S IBSPEC="PRESCRIPTION",RATE=20
 I $P(^IBT(356,+$P(IBTRCD,"^",2),0),"^",9) S IBSPEC="PROSTHETICS",RATE=0
 ;
 S SORT3=$P($G(^DPT(DFN,0)),"^")
 I IBHOW="P" S (SORT1,SORT2)=SORT3
 I IBHOW="S" S SORT1=IBSPEC,SORT2=SORT3
 I IBHOW="R" S SORT1=$P($G(^VA(200,+$P($G(^IBT(356.2,+IBTRC,1)),"^",4),0)),"^"),SORT2=$P($G(^IBE(356.11,+$P(IBTRCD,"^",4),0)),"^")
 S:SORT1="" SORT1="Unknown"
 S:SORT2="" SORT2="Unknown"
 S:SORT3="" SORT2="Unknown"
 S ^TMP($J,"IBTOUR",SORT1,SORT2,SORT3,IBTRC)=IBTRCD
 ;
 S IBDAY=""
 ;I $P(^IBT(356,IBTRN,0),"^",5),$P(^IBT(356.2,+IBTRC,1),"^",7) S IBCDT=$$CDT^IBTODD1(IBTRN),IBDAY=$$DAY^IBTUTL3(+IBCDT,$S(+$P(IBCDT,"^",2):$P(IBCDT,"^",2),1:DT),IBTRN)
 ; -- replace the above line with the following line to add in admissions
 ;    approved for the entire stay to report
 I $P(^IBT(356,IBTRN,0),"^",5),($P(^IBT(356.2,+IBTRC,1),"^",7)!($P(^(1),"^",8))) S IBCDT=$$CDT^IBTODD1(IBTRN),IBDAY=$$DAY^IBTUTL3(+IBCDT,$S(+$P(IBCDT,"^",2):$P(IBCDT,"^",2),1:DT),IBTRN)
 ;
 I IBAC=10,'IBDAY S IBDAY=$$DAY^IBTUTL3(+$P(IBTRCD,"^",12),+$P(IBTRCD,"^",13),IBTRN)
 I IBAC=20,'IBDAY S IBDAY=$$DAY^IBTUTL3(+$P(IBTRCD,"^",15),+$P(IBTRCD,"^",16),IBTRN)
 I 'IBDAY,$P(^IBT(356,IBTRN,0),"^",4) S IBDAY=1 ;opt encounter =1 day
 S IBDA=$S(IBAC=10:IBDAY,1:0)
 S IBDD=$S(IBAC=20:IBDAY,1:0)
 S ^TMP($J,"IBTOUR0",+IBTRN)=IBTRN
 ;
 I $P(^IBT(356,+IBTRN,0),"^",5),IBSPEC'="Unknown" D
 .I '$D(^TMP($J,"IBTOUR1",IBSPEC)) S ^TMP($J,"IBTOUR1",IBSPEC)="0^0^0^0^"
 .S X=$G(^TMP($J,"IBTOUR1",IBSPEC))
 .S ^TMP($J,"IBTOUR1",IBSPEC)=($P(X,"^")+IBDA)_"^"_($P(X,"^",2)+IBDD)_"^"_($P(X,"^",3)+(IBDA*RATE))_"^"_($P(X,"^",4)+(IBDD*RATE))
 Q
 ;
HREV ; -- count and sort reviews
 N IBDT,J
 S IBDT=IBBDT-.00001
 F  S IBDT=$O(^IBT(356.1,"B",IBDT)) Q:'IBDT!(IBDT>(IBEDT+.9))!(IBQUIT)  D
 .S IBTRV=0 F  S IBTRV=$O(^IBT(356.1,"B",IBDT,IBTRV)) Q:'IBTRV!(IBQUIT)  D
 ..S IBTRVD=$G(^IBT(356.1,+IBTRV,0)) Q:IBTRVD=""
 ..S IBTRN=$P(IBTRVD,"^",2)
 ..I $P(IBTRVD,"^",21)=10 D HSET
 Q
 ;
HSET ; -- set up review cases
 S ^TMP($J,"IBTOUR4",IBTRN)=IBTRN
 Q
 ;
HSET1 ; -- build by specialy report for hosp. reviews.
 I $G(IBSPEC)="" D
 .N VAIN,DFN
 .S DFN=$P(^IBT(356,IBTRN,0),"^",2)
 .S VAINDT=$P(^IBT(356,IBTRN,0),"^",6)\1+.2359 D INP^VADPT S IBSPEC=$P(VAIN(3),"^",2)
 .I $G(IBSPEC)="" S IBSPEC="Unknown"
 I '$D(^TMP($J,"IBTOUR2",IBSPEC)) S ^TMP($J,"IBTOUR2",IBSPEC)="0^0^0^0^"
 S X=$G(^TMP($J,"IBTOUR2",IBSPEC))
 S ^TMP($J,"IBTOUR2",IBSPEC)=($P(X,"^")+IBP1)_"^"_($P(X,"^",2)+IBP2)_"^"_($P(X,"^",3)+IBP3)_"^"_($P(X,"^",4)+IBP4)
 Q
 ;
HSET2 ; -- set utility array
 N DFN,SORT1,SORT2,SORT3
 S DFN=+$P(IBTRND,"^",2) Q:'DFN
 ;
 S SORT3=$P($G(^DPT(DFN,0)),"^")
 I IBHOW="P" S (SORT1,SORT2)=SORT3
 I IBHOW="S" S SORT1=IBSPEC,SORT2=SORT3
 I IBHOW="R" S SORT1=$P($G(^VA(200,+$P($G(^IBT(356,+IBTRN,1)),"^",5),0)),"^"),SORT2=$P($G(^IBE(356.11,+$P(IBTRVD,"^",22),0)),"^")
 S:SORT1="" SORT1="Unknown"
 S:SORT2="" SORT2="Unknown"
 S:SORT3="" SORT2="Unknown"
 ;
 S ^TMP($J,"IBTOUR3",SORT1,SORT2,SORT3,IBTRN)=IBADM_"^"_IBDAYS_"^"_IBDAYN
 Q
