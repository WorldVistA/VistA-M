IBCSC2 ;ALB/MJB/AAS - MCCR SCREEN 2 (EMPLOYMENT) ;27 MAY 88 10:15
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;MAP TO DGCRSC2
 ;
EN D ^IBCSCU S IBSR=2,IBSR1="" F I=0,.311,.25 S IB(I)=$S($D(^DPT(DFN,I)):^(I),1:"")
 D H^IBCSCU
 S IBV1="00" I $S('$D(^DIC(11,+$P(^DPT(DFN,0),U,5),0)):1,$P(^(0),U,1)="MARRIED":0,$P(^(0),U,1)="SEPARATED":0,1:1) S IBV1="01"
 S:IBV IBV1="11"
 ;
 S IBAD=.311,IBA1=3,IBA2=1 D:$P(IB(.311),"^",1)]"" A^IBCSCU S IBAD=.25,(IBA1,IBA2)=2 D:$P(IB(.25),"^",1)]"" A^IBCSCU
 S Z=1,IBW=1 X IBWW W " Employer: " W $S($P(IB(.311),"^",1)]"":$E($P(IB(.311),"^",1),1,23),1:IBU),?40 S IBW=0,Z=2 X IBWW W " Spouse's: ",$S($P(IB(.25),"^",1)]"":$P(IB(.25),"^",1),1:IBU)
 S I=0 F J=0:0 S I=$O(IBA(I)) Q:'I  S Z=IBA(I) S:(I#2) Z="              "_Z W:(I#2)!($X>50) ! W:(I#2) Z I '(I#2) W ?54,Z
 W:$P(IB(.311),"^",1)]"" !?7,"Phone: ",$S($P(IB(.311),"^",9)]"":$P(IB(.311),"^",9),1:IBU)
 W:$P(IB(.311),"^",1)']"" ! W:$P(IB(.25),"^",1)]"" ?47,"Phone: ",$S($P(IB(.25),"^",8)]"":$P(IB(.25),"^",8),1:IBU) W:$P(IB(.311),"^",1)]"" !?2,"Occupation: ",$S($P(IB(0),"^",7)]"":$P(IB(0),"^",7),1:IBU)
 S X=$P(IB(.311),"^",15),X=$S(X']"":IBU,X=1:"EMPLOYED FULL TIME",X=2:"EMPLOYED PART TIME",X=3:"NOT EMPLOYED",X=4:"SELF EMPLOYED",X=5:"RETIRED",X=6:"ACTIVE MILITARY DUTY",1:IBU) W !?6,"Status: ",X
 ;
REV G ^IBCSCP
 ;IBCSC2
