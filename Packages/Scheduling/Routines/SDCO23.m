SDCO23 ;ALB/RMO - Classification Cont. - Help - Check Out;31 MAR 1993 3:10 pm
 ;;5.3;Scheduling;;Aug 13, 1993
 ;
SC(DFN) ;Service Connected Help
 ; Input  -- DFN      Patient file IEN  
 ; Output -- Help
 N I,SDCNT,SDDC,SDRD0
 W !!,"Patient's Service Connection and Rated Disabilities:"
 W !!,$S($P($G(^DPT(DFN,.3)),"^")="Y":"        SC Percent: "_$P(^(.3),"^",2)_"%",1:" Service Connected: No")
 W !,"Rated Disabilities: "
 I $P($G(^DPT(DFN,"VET")),"^")'="Y",$S('$D(^DIC(391,+$G(^DPT(DFN,"TYPE")),0)):1,$P(^(0),"^",2):0,1:1) W "Not a Veteran" G SCQ
 S (SDCNT,I)=0
 F  S I=$O(^DPT(DFN,.372,I)) Q:'I  I $P($G(^(I,0)),"^",3) S SDRD0=^(0) D
 .S SDCNT=SDCNT+1
 .S SDDC=$S('$D(^DIC(31,+SDRD0,0)):"",$P(^(0),"^",4)]"":$P(^(0),"^",4),1:$P(^(0),"^"))
 .W:SDCNT>1 !
 .W ?20,SDDC,"  (",$P(SDRD0,"^",2),"%-",$S($P(SDRD0,"^",3):"SC",1:""),")"
 I 'SDCNT W $S('$O(^DPT(DFN,.372,0)):"None Stated",1:"No Service Connected Disabilities Listed")
SCQ W !!,"Enter either 'Y' or 'N'."
 Q
