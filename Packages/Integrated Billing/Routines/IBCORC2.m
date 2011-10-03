IBCORC2 ;ALB/CPM - RANK INSURANCE CARRIERS (BULLETIN) ; 30-JUN-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
BULL ; Generate a bulletin containing the report.
 S XMSUB="RANKING INSURANCE CARRIERS"
 S XMDUZ="INTEGRATED BILLING PACKAGE"
 S XMTEXT="IBT("
 S XMY($P($G(^IBE(350.9,1,4)),"^",5))=""
 S XMY(DUZ)=""
 ;
 ; - set up report header
 S X="Ranking Of The Top "_IBNR_" Insurance Carriers By Total Amount Billed"
 S IBT(1)=$J("",80-$L(X)\2)_X
 S IBT(2)=" "
 S X=$$SITE^VASITE,X=$E($P(X,"^",2)_" ("_$P(X,"^",3)_")"_$J("",46),1,46)
 S IBT(3)="  Facility: "_X_"Run Date: "_$$DAT1^IBOUTL(DT)
 S IBT(4)="Date Range: "_$$DAT1^IBOUTL(IBABEG)_" thru "_$$DAT1^IBOUTL(IBAEND)_$J("",28)_"Page: 1  of  1"
 S IBT(5)=" "
 S IBT(6)=$$DASH^IBCORC1
 S IBT(7)="  Rank"_$J("",14)_"Insurance Carrier"_$J("",18)_"Total Amt Billed"
 S IBT(8)=$$DASH^IBCORC1
 S IBT(9)=" ",IBC=9
 ;
 ; - set up report body
 S (IBTAMT,IBCNT)=0,IBAMT=""
 F  S IBAMT=$O(^TMP("IBORIC",$J,"AMT",IBAMT)) Q:IBAMT=""!(IBCNT>IBNR)  D
 .S IBINS=0 F  S IBINS=$O(^TMP("IBORIC",$J,"AMT",IBAMT,IBINS)) Q:'IBINS!(IBCNT>IBNR)  D
 ..S IBCNT=IBCNT+1 Q:IBCNT>IBNR
 ..S IBAMTP=-IBAMT,IBTAMT=IBTAMT+IBAMTP
 ..S IBINS0=$G(^DIC(36,IBINS,0)),IBINSA=$G(^(.11))
 ..S IBC=IBC+1,IBT(IBC)=" "
 ..S X=IBAMTP,X2="2$",X3=15 D COMMA^%DTC
 ..S IBC=IBC+1,IBT(IBC)=$J(IBCNT,4)_"."_$J("",15)_$E($S($P(IBINS0,"^")]"":$P(IBINS0,"^"),1:"CARRIER UNKNOWN")_$J("",34),1,34)_X
 ..D INSBULL(IBINSA)
 ;
 ; - set up totals
 S IBC=IBC+1,IBT(IBC)=" "
 S X=IBTAMT,X2="2$",X3=15 D COMMA^%DTC
 S IBC=IBC+1,IBT(IBC)="Total Amount Billed to all Ranked Carriers:"_$J("",11)_X
 ;
 ; - deliver and quit
 D ^XMD
 K IBAMT,IBAMTP,IBCNT,IBINS0,IBINSA,IBC,IBT,IBTAMT,X,XMSUB,XMDUZ,XMY,XMTEXT,Y
 Q
 ;
INSBULL(X) ; Display Insurance Company name and address for bulletin.
 ;  Input:  X   --   .11 node of ins company entry in file #36
 S:$P(X,"^")]"" IBC=IBC+1,IBT(IBC)=$J("",20)_$P(X,"^")
 S:$P(X,"^",2)]"" IBC=IBC+1,IBT(IBC)=$J("",20)_$P(X,"^",2)
 S:$P(X,"^",3)]"" IBC=IBC+1,IBT(IBC)=$J("",20)_$P(X,"^",3)
 S IBC=IBC+1,IBT(IBC)=$J("",20)_$P(X,"^",4)
 S:$P(X,"^",4)]""&($P(X,"^",5)]"") IBT(IBC)=IBT(IBC)_", "
 S IBT(IBC)=IBT(IBC)_$P($G(^DIC(5,+$P(X,"^",5),0)),"^")
 S:$P(X,"^",6)]""&($P(X,"^",4)]""!($P(X,"^",5)]"")) IBT(IBC)=IBT(IBC)_"   "
 S IBT(IBC)=IBT(IBC)_$P(X,"^",6)
 Q
