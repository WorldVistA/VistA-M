IBOLK1 ;ALB/CPM - DISPLAY BY BILL NUMBER, ADDRESS INQUIRY ; 28-JAN-92
 ;;2.0;INTEGRATED BILLING;**80**;21-MAR-94
 ;
 ; Input:     DFN  --  pointer to patient in File #2
 ;        IBIFN  --  pointer to a bill in File #399
 ;
 D @("HDR1^"_$S(IBIFN:"IBCNQ",1:"IBOLK"))
 W !!?25,"*** ADDRESS INFORMATION ***"
 ;
 ; - display patient address
 D ADD^VADPT
 W !!,"Patient Address:  ",VAPA(1)
 W:VAPA(2)]"" !?18,VAPA(2) W:VAPA(3)]"" !?18,VAPA(3)
 W:VAPA(4)]""!(VAPA(5)]"")!(VAPA(6)]"") !?18
 W VAPA(4) W:VAPA(4)]""&(VAPA(5)]"") ", " W $P(VAPA(5),"^",2)
 W:VAPA(6)]""&(VAPA(4)]""!(VAPA(5)]"")) "   " W VAPA(6)
 W:VAPA(8)]"" !?18,VAPA(8)
 ;
 ; - display mailing address for a UB-82
 I IBIFN S IBM=$P($G(^DGCR(399,IBIFN,"M")),"^",4,9),IBM1=$G(^("M1")) D
 . Q:IBM=""&(IBM1="")  W !!,"Mailing Address:  " D ADDR
 ;
 ; - display Insurance Company or Institution addresses for UB-82's
 I IBIFN S X=$P($G(^DGCR(399.3,+$P($G(^DGCR(399,IBIFN,0)),"^",7),0)),"^",7) D:X["i"!(X["o")
 . I X["i" S Y=+$G(^DGCR(399,IBIFN,"MP")) Q:'$D(^DIC(36,Y,0))  D
 ..  S IBM=$P(^DIC(36,Y,0),"^")_"^"_$G(^(.11)),IBPHONE=$P($G(^(.13)),"^")
 ..  S IBM1=$P(IBM,"^",4),$P(IBM,"^",4,6)=$P(IBM,"^",5,7)
 . I X["o" S Y=+$P($G(^DGCR(399,IBIFN,"M")),"^",11) Q:'$D(^DIC(4,Y,0))  D
 ..  S IBM=$P(^DIC(4,Y,0),"^",1,2)_"^"_$G(^(1)),IBPHONE="",IBM1=""
 ..  S Z=$P(IBM,"^",2),$P(IBM,"^",2,4)=$P(IBM,"^",3,5),$P(IBM,"^",5)=Z
 . W !!,$S(X["i":"Ins Co.",1:"Instit.")," Address:  " D ADDR
 . W:IBPHONE]"" !?18,$P(IBPHONE,"^")
 ;
 D PAUSE^IBOLK
 K IBM,IBM1,IBPHONE,VA,VAERR,VAPA,X,Y,Z Q
 ;
ADDR ; Print mailing addresses for Insurance Companies and Institutions.
 W $P(IBM,"^") W:$P(IBM,"^",2)]"" !?18,$P(IBM,"^",2)
 W:$P(IBM,"^",3)]"" !?18,$P(IBM,"^",3) W:$P(IBM1,"^")]"" !?18,$P(IBM1,"^")
 W:$P(IBM,"^",4)]""!($P(IBM,"^",5)]"")!($P(IBM,"^",6)]"") !?18
 W $P(IBM,"^",4) W:$P(IBM,"^",4)]""&($P(IBM,"^",5)]"") ", "
 W $P($G(^DIC(5,+$P(IBM,"^",5),0)),"^")
 W:$P(IBM,"^",6)]""&($P(IBM,"^",4)]""!($P(IBM,"^",5)]"")) "   "
 W $P(IBM,"^",6)
 Q
