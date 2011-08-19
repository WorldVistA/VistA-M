IBTRVD0 ;ALB/AAS - CLAIMS TRACKING - EXPANDED REVIEW SCREEN ; 02-JUL-1993
 ;;Version 2.0 ; INTEGRATED BILLING ;**58**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% I '$G(IBTRV) G ^IBTRV
 D VISIT,REVIEW,STATUS,CRITER
 Q
 ;
VISIT ; -- Visit information
 N OFFSET,START,VAIN,VAINDT,IBETYP
 S VAINDT=$$VNDT^IBTRV(IBTRV)
 S VA200="" D INP^VADPT
 S IBETYP=$G(^IBE(356.6,+$P(IBTRND,"^",18),0))
 S START=1,OFFSET=2
 D VISIT^IBTRED
 Q
 ;
REVIEW ; -- Review Information
 N OFFSET,START,IBI,IBTRC,IBTRCD
 S START=1,OFFSET=45
 ; -- get related review information
 S (IBTRC,IBI)=0 F  S IBI=$O(^IBT(356.2,"AD",IBTRV,IBI)) Q:'IBI  S IBTRC=IBI
 S IBTRCD=$G(^IBT(356.2,+IBTRC,0))
 D SET^IBCNSP(START,OFFSET," Review Information ",IORVON,IORVOFF)
 D SET^IBCNSP(START+1,OFFSET,"    Review Type: "_$P($G(^IBE(356.11,+$P(IBTRVD,"^",22),0)),"^",1))
 D SET^IBCNSP(START+2,OFFSET,"    Review Date: "_$$DAT1^IBOUTL(+IBTRVD,"2P"))
 D SET^IBCNSP(START+3,OFFSET,"      Specialty: "_$P($G(^DIC(45.7,+$P(IBTRVD,"^",7),0)),"^"))
 D SET^IBCNSP(START+4,OFFSET,"    Methodology: "_$$EXPAND^IBTRE(356.1,.23,$P(IBTRVD,"^",23)))
 D SET^IBCNSP(START+5,OFFSET,"    Ins. Action: "_$P($G(^IBE(356.7,+$P(IBTRCD,"^",11),0)),"^"))
 Q
 ;
UNIT ; -- Special unit information
 ;  for patch 58 and the 1995 interqual criteria, this entry to display
 ;  the special unit information is no longer used
 N OFFSET,START
 S START=8,OFFSET=45
 D SET^IBCNSP(START,OFFSET," Special Unit Information ",IORVON,IORVOFF)
 I IBTRTP=40 D SET^IBCNSP(START+1,OFFSET," D/C Screen Met: "_$$SI($P(IBTRVD,"^",13))) Q
 D SET^IBCNSP(START+1,OFFSET,"Special Unit SI: "_$$SI($P(IBTRVD,"^",8)))
 D SET^IBCNSP(START+2,OFFSET,"Special Unit IS: "_$$SI($P(IBTRVD,"^",9)))
 Q
 ;
STATUS ; -- Status/user information
 N OFFSET,START
 S START=17,OFFSET=2
 D SET^IBCNSP(START,OFFSET," Status Information ",IORVON,IORVOFF)
 D SET^IBCNSP(START+1,OFFSET,"   Review Status: "_$$EXPAND^IBTRE(356.1,.21,$P(IBTRVD,"^",21)))
 D SET^IBCNSP(START+2,OFFSET,"      Entered by: "_$P($G(^VA(200,+$P(IBTRVD1,"^",2),0)),"^"))
 D SET^IBCNSP(START+3,OFFSET,"      Entered on: "_$$DAT1^IBOUTL($P(IBTRVD1,"^",1),"2P"))
 D SET^IBCNSP(START+4,OFFSET,"    Completed by: "_$P($G(^VA(200,+$P(IBTRVD1,"^",4),0)),"^"))
 D SET^IBCNSP(START+5,OFFSET,"    Completed on: "_$$DAT1^IBOUTL($P(IBTRVD1,"^",3),"2P"))
 I $P(IBTRVD,"^",21)<3 D SET^IBCNSP(START+6,OFFSET,"Next Review Date: "_$$DAT1^IBOUTL($P(IBTRVD,"^",20),"2P")) G STATQ
STATQ Q
 ;
CRITER ; -- Criteria information
 N OFFSET,START,IBD,IBNAR,IBNARD
 S START=8,OFFSET=2
 D SET^IBCNSP(START,OFFSET," Criteria Information ",IORVON,IORVOFF)
 I IBTRTP D @IBTRTP
 Q
10 ; -- precert review
15 ; -- admission review
20 ; -- urgent adm. review
50 ;
60 ;
65 ;
70 ;
80 ;
85 ;
90 ;
100 ;
 ;
 D SET^IBCNSP(START+1,OFFSET," Severity of Ill: "_$E($$SI($P(IBTRVD,"^",4)),1,22))
 D SET^IBCNSP(START+2,OFFSET,"Intensity of Svc: "_$E($$SI($P(IBTRVD,"^",5)),1,22))
 D SET^IBCNSP(START+3,OFFSET,"    Criteria Met: "_$$EXPAND^IBTRE(356.1,.06,$P(IBTRVD,"^",6)))
 D SET^IBCNSP(START+4,OFFSET," Prov. Intervwed: "_$$EXPAND^IBTRE(356.1,.1,$P(IBTRVD,"^",10)))
 D SET^IBCNSP(START+5,OFFSET," Dec. Influenced: "_$$EXPAND^IBTRE(356.1,.11,$P(IBTRVD,"^",11)))
 D SET^IBCNSP(START+6,OFFSET,"Non-Acute Reason: ")
 S IBD=5
 ;
 S IBNAR=0 F  S IBNAR=$O(^IBT(356.1,+IBTRV,12,IBNAR)) Q:'IBNAR  D
 .S IBNARD=$G(^IBT(356.1,+IBTRV,12,IBNAR,0))
 .S IBD=IBD+1 Q:IBD>8
 .D SET^IBCNSP(START+IBD,OFFSET,"Non-Acute Reason: "_$P($G(^IBE(356.4,+IBNARD,0)),"^",2)_" - "_$P($G(^(0)),"^"))
 Q
 ;
30 ; -- concurrent review
 D SET^IBCNSP(START+1,OFFSET,"    Day of Review: "_$J($P(IBTRVD,"^",3),2))
 D SET^IBCNSP(START+2,OFFSET,"  Severity of Ill: "_$E($$SI($P(IBTRVD,"^",4)),1,22))
 D SET^IBCNSP(START+3,OFFSET," Intensity of Svc: "_$E($$SI($P(IBTRVD,"^",5)),1,22))
 D SET^IBCNSP(START+4,OFFSET," Dschg Screen Met: "_$E($$SI($P(IBTRVD,"^",12)),1,22))
 D SET^IBCNSP(START+5,OFFSET," Acute Care Dschg: "_$$EXPAND^IBTRE(356.1,1.17,$P(IBTRVD1,"^",17)))
 D SET^IBCNSP(START+6,OFFSET," Non-Acute Reason: ")
 S IBD=5
 ;
 S IBNAR=0 F  S IBNAR=$O(^IBT(356.1,+IBTRV,13,IBNAR)) Q:'IBNAR  D
 .S IBNARD=$G(^IBT(356.1,+IBTRV,13,IBNAR,0))
 .S IBD=IBD+1 Q:IBD>8
 .D SET^IBCNSP(START+IBD,OFFSET," Non-Acute Reason: "_$P($G(^IBE(356.4,+IBNARD,0)),"^",2)_" - "_$P($G(^(0)),"^"))
 Q
40 ; -- discharge review
 D SET^IBCNSP(START+1,OFFSET,"Discharge Screen: "_$$SI($P(IBTRVD,"^",12)))
 Q
 ;
SI(X) ; -- output the name value of a si/is
 ;    input the pointer to 356.3
 N Y S Y=$G(^IBE(356.3,+$G(X),0))
 ;  Q $P($G(^IBE(356.3,+$G(X),0)),"^")
 Q $P(Y,"^",3)_$S(Y'="":" - ",1:"")_$P(Y,"^")
