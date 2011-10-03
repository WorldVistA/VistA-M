IBCORC1 ;ALB/CPM - RANK INSURANCE CARRIERS (COMPILE/PRINT) ; 30-JUN-93
 ;;2.0;INTEGRATED BILLING;**29,47,68,80**;21-MAR-94
 ;
DQ ; Tasked entry point to generate and print the rankings.
 ;
 ; - look at all insurance bills within date range and accumulate $$
 K ^TMP("IBORIC",$J,"IC"),^("IC1"),^("AMT"),^("NUM")
 S IBDT=$$START(IBABEG,-1)
 F  S IBDT=$O(^DGCR(399,"AP",IBDT)) Q:'IBDT!(IBDT>IBAEND)  D
 .S IBN=0 F  S IBN=$O(^DGCR(399,"AP",IBDT,IBN)) Q:'IBN  D EVAL
 ;
 ; - if executed by IRM, generate the formatted bulletin and quit
 I $G(IBIRM) D BULL^IBCORC3 G ENQ
 ;
 ; - invert the list by carrier to rank by amount billed
 S IBINS=0 F  S IBINS=$O(^TMP("IBORIC",$J,"IC",IBINS)) Q:'IBINS  S ^TMP("IBORIC",$J,"AMT",-$G(^(IBINS)),IBINS)=""
 ;
 ; - print out the ranking list
 S IBAMT="",(IBQ,IBCNT,IBPAG,IBTAMT)=0 D HDR
 F  S IBAMT=$O(^TMP("IBORIC",$J,"AMT",IBAMT)) Q:IBAMT=""!(IBQ)!(IBCNT>IBNR)  D
 .S IBINS=0 F  S IBINS=$O(^TMP("IBORIC",$J,"AMT",IBAMT,IBINS)) Q:'IBINS!(IBQ)!(IBCNT>IBNR)  D
 ..S IBCNT=IBCNT+1 Q:IBCNT>IBNR
 ..S IBAMTP=-IBAMT,IBTAMT=IBTAMT+IBAMTP
 ..S IBINS0=$G(^DIC(36,IBINS,0)),IBINSA=$G(^(.11))
 ..I $Y>(IOSL-8) D PAUSE Q:IBQ  D HDR
 ..W !!,$J(IBCNT,4),"." W:$P(IBINS0,"^",5) ?16,"**"
 ..W ?20,$S($P(IBINS0,"^")]"":$P(IBINS0,"^"),1:"CARRIER UNKNOWN")
 ..S X=IBAMTP,X2="2$",X3=15 D COMMA^%DTC W ?55,X
 ..D INSDIS(IBINSA)
 G:IBQ ENQ
 ;
 ; - print a total
 I $Y>(IOSL-4) D PAUSE G:IBQ ENQ D HDR
 W !!,"Total Amount Billed to all Ranked Carriers:" S X=IBTAMT,X2="2$",X3=15 D COMMA^%DTC W ?55,X
 D PAUSE
 ;I IBFLG W !!,"Sending the report in a bulletin to the MCCR Program Office... " D BULL^IBCORC2 W "done."
 ;
ENQ K ^TMP("IBORIC",$J,"IC"),^("IC1"),^("AMT"),^("NUM")
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K DIR,DIRUT,DUOUT,DTOUT,DIROUT,IBAMT,IBAMTP,IBI,IBINS0,IBINSA
 K IBQ,IBPAG,IBNR,IBCNT,IBDT,IBND,IBINS,IBN,IBTAMT,X,X1,X2,X3,Y
ENQ1 Q
 ;
EVAL ; Accumulate amount billed for the carrier if the bill type is correct.
 F IBI=0,"M","S","MP" S IBND(IBI)=$G(^DGCR(399,IBN,IBI))
 I IBND(0)="" G EVALQ ; no zeroth node
 I $P(IBND(0),"^",11)'="i" G EVALQ ; insurer not responsible
 S IBINS=+IBND("MP") I 'IBINS G EVALQ ; no carrier associated with bill
 I $P(IBND("S"),"^",16) G EVALQ ; bill has been cancelled
 S IBAMT=+$$ORI^PRCAFN(IBN) I IBAMT'>0 G EVALQ ; no bill amount
 S IBINS=$$INACT(IBINS) ; see if company has been repointed
 S ^(IBINS)=$G(^TMP("IBORIC",$J,"IC",IBINS))+IBAMT
 I $G(IBIRM) S ^(IBINS)=$G(^TMP("IBORIC",$J,"IC1",IBINS))+1
EVALQ Q
 ;
PAUSE ; Pause for screen output.
 Q:$E(IOST,1,2)'="C-"
 N IBI,DIR,DIRUT,DIROUT,DUOUT,DTOUT
 F IBI=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR I $D(DIRUT)!($D(DUOUT)) S IBQ=1
 Q
 ;
HDR ; Display report header.
 N X,Y
 S X="Ranking Of The Top "_IBNR_" Insurance Carriers By Total Amount Billed"
 S Y=$$SITE^VASITE
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF,*13
 S IBPAG=IBPAG+1
 W ?(80-$L(X)\2),X,!
 W !,"  Facility: ",$P(Y,"^",2)," (",$P(Y,"^",3),")",?58,"Run Date: ",$$DAT1^IBOUTL(DT)
 W !,"Date Range: ",$$DAT1^IBOUTL(IBABEG)," thru ",$$DAT1^IBOUTL(IBAEND),?62,"Page: ",IBPAG
 W !?45,"** - denotes an inactive company"
 W !,$$DASH,!?2,"Rank",?20,"Insurance Carrier",?55,"Total Amt Billed",!,$$DASH
 Q
 ;
DASH() ; Write dashed line.
 Q $TR($J("",79)," ","=")
 ;
INSDIS(X) ; Display Insurance Company name and address.
 ;  Input:  X   --   .11 node of ins company entry in file #36
 W:$P(X,"^")]"" !?20,$P(X,"^")
 W:$P(X,"^",2)]"" !?20,$P(X,"^",2)
 W:$P(X,"^",3)]"" !?20,$P(X,"^",3)
 W:$P(X,"^")]""!($P(X,"^",2)]"")!($P(X,"^",3)]"") !?20
 W $P(X,"^",4) W:$P(X,"^",4)]""&($P(X,"^",5)]"") ", "
 W $P($G(^DIC(5,+$P(X,"^",5),0)),"^")
 W:$P(X,"^",6)]""&($P(X,"^",4)]""!($P(X,"^",5)]"")) "   "
 W $P(X,"^",6)
 Q
 ;
START(X1,X2) ; Return the Start Date for the search, less one day.
 N X,%H D C^%DTC
 Q X
 ;
INACT(CN) ; Determine the repointed-to company for inactivated companies.
 ;  Input:  CN  --  Pointer to the ins company in file #36
 ; Output:  The repointed-to company, if inactivated (or the same)
 N X,Y,Z S X=+$G(CN)
 F  S Y=$G(^DIC(36,X,0)) Q:'$P(Y,"^",5)!('$P(Y,"^",16))!($P(Y,"^",16)=X)!($D(Z(+$P(Y,"^",16))))  S X=$P(Y,"^",16),Z(X)=""
 Q X
 ;
DEL ; Delete "REPOINT PATIENTS TO" field
 N C1,C2,DA,DIR
 W !,"The routine will delete the REPOINT PATIENTS TO field of the entry"
 W !,"in the INSURANCE COMPANY file (#36) if the field entry is pointing"
 W !,"back to itself (same IEN).",!
 S DIR(0)="YO",DIR("A")="Are you sure you want to do this",DIR("B")="NO" D ^DIR Q:+Y=0  W !!,"A dot (.) will appear for every 50 records processed.",!
 S (C1,C2,DA)=0 F  S DA=$O(^DIC(36,DA)) Q:+DA=0  I $P($G(^DIC(36,DA,0)),U,16)=DA S $P(^DIC(36,DA,0),U,16)="",C1=C1+1,C2=C2+1 I C1=50 W "." S C1=0
 W !,*7,"Done...",C2," records changed." Q
