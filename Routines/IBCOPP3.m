IBCOPP3 ;ALB/NLR - LIST INS. PLANS BY CO. (PRINT) ; 04-OCT-94
 ;;Version 2.0 ; INTEGRATED BILLING ;**28**; 21-MAR-94
 ;
 ; Print the report.
 ;  Required Input:  Global print array ^TMP($J,"PR"
 ;                   local variable IBAPA
 ; 
 S (IBI,IBQUIT,IBPAG)=0
 D NOW^%DTC S IBHDT=$$DAT2^IBOUTL($E(%,1,12))
 F  S IBI=$O(^TMP($J,"PR",IBI)) Q:'IBI  S IBC=$G(^(IBI)) D COMP D  Q:IBQUIT
 .S IBP=0 F  S IBP=$O(^TMP($J,"PR",IBI,IBP)) Q:'IBP  S IBPD=$G(^(IBP)) D  Q:IBQUIT
 ..I $Y>(IOSL-$S(IBAPA:9,1:5)) D PAUSE Q:IBQUIT  D COMP
 ..D PLAN
 ..I IBAPA S IBS="" F  S IBS=$O(^TMP($J,"PR",IBI,IBP,IBS)) Q:IBS=""  S IBSD=$G(^(IBS)) D SUBS Q:IBQUIT
 .Q:IBQUIT
 .;
 .; - print company totals
 .I $Y>(IOSL-4) D PAUSE Q:IBQUIT  D COMP,PLAN
 .W !!?90,"Number of Plans Selected = ",$P(IBC,"^",9),!?76,"Total Subscribers Under Selected Plans = ",$P(IBC,"^",10)
 .D PAUSE
 ;
 K IBJJ,IBI,IBQUIT,IBPAG,IBHDT,IBC,IBP,IBPD,IBS,IBSD
 Q
 ;
 ;
COMP ; Print Company header
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"LIST OF PLANS BY INSURANCE COMPANY"
 W:IBAPA " WITH SUBSCRIBER INFORMATION"
 W ?IOM-34,IBHDT,?IOM-10,"Page: ",IBPAG
 W !,$TR($J(" ",IOM)," ","-")
 ;
 ; - sub-header
 W !?1,$P(IBC,"^"),?45,$P(IBC,"^",4),?105,$P(IBC,"^",6)
 W !?11,$P(IBC,"^",2),?45,$P(IBC,"^",5),?105,"PLAN TOTAL= ",$P(IBC,"^",7)
 W !?11,$P(IBC,"^",3),?99,"SUBSCRIBER TOTAL= ",$P(IBC,"^",8)
 W:IBAPA !!?95,"WHOSE",?127,"BEN.",!?3,"SUBSCRIBER NAME/ID",?40,"DOB",?54,"EMPLOYER",?76,"SUBSCR ID",?95,"INS",?105,"EFF DATE",?117,"EXP DATE",?127,"USED?"
 W:'IBAPA !!?5,"GROUP NUMBER",?32,"GROUP NAME",?62,"GROUP OR IND",?77,"ACTIVE/INACTIVE",?96,"SUBSCRIBERS",?110,"ANN. BEN?  BEN. USED?"
 Q
 ;
PLAN ; Print plan information.
 I IBAPA D
 .W !!?3,"GROUP #: ",$P(IBPD,U),?40,"ANNUAL BENEFITS ON FILE: ",$P(IBPD,U,5)
 .W !?5,"GROUP NAME: ",$P(IBPD,U,2),?42,"BENEFITS USED ON FILE: ",$P(IBPD,U,6)
 .W !?7,"GROUP OR IND: ",$P(IBPD,U,3),!?9,"ACTIVE?: ",$P(IBPD,U,4),!?11,"NO. SUBSCRIBERS: ",$P(IBPD,U,7)
 I 'IBAPA W !!?5,$P(IBPD,U),?32,$P(IBPD,U,2),?62,$P(IBPD,U,3),?77,$P(IBPD,U,4),?100,$P(IBPD,U,7),?113,$P(IBPD,U,5),?124,$P(IBPD,U,6)
 Q
 ;
SUBS ; Print subscriber information.
 I $Y>(IOSL-4) D PAUSE Q:IBQUIT  D COMP,PLAN
 W !?3,$P(IBSD,"^"),?40,$P(IBSD,"^",2),?54,$P(IBSD,"^",3),?76,$P(IBSD,"^",4),?95,$P(IBSD,"^",5)
 W ?105,$P(IBSD,"^",6),?117,$P(IBSD,"^",7),?128,$S($P(IBSD,"^",8):"YES",1:"NO")
 Q
 ;
PAUSE ; Pause for screen output.
 Q:$E(IOST,1,2)'["C-"
 F IBJJ=$Y:1:(IOSL-7) W !
 S DIR(0)="E" D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) S IBQUIT=1 K DIRUT,DTOUT,DUOUT
 Q
