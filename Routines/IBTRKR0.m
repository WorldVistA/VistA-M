IBTRKR0 ;ALB/AAS - CLAIMS TRACKING - RANDOM SELECTION BULLETIN ; 13-AUG-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**23**; 21-MAR-94
 ;
BULL ; -- send bulletin
 ;
 S XMSUB="UR Random Sample Patient Selection"
 S IBT(1)="The following Patient has been selected as a UR Random Sample case on "
 S IBT(1.1)=$$DAT2^IBOUTL($$NOW^XLFDT())_"."
 S IBT(1.2)=""
 S IBT(2)="        Patient: "_$P(^DPT(DFN,0),"^")
 D PID^VADPT
 S IBT(3)="         Pt. ID: "_VA("PID")
 S IBT(4)=" Admission Date: "_$P(VAIN(7),"^",2)_"   ("_VAIN(1)_")"
 S IBT(4.1)="    CT Entry ID: "_$P($G(^IBT(356,+IBTRN,0)),"^")
 ;
 S IBT(4.5)=""
 S IBT(5)="      Specialty: "_$P(VAIN(3),"^",2)
 S SVC=$P($G(^DIC(42.4,+$P($G(^DIC(45.7,+VAIN(3),0)),"^",2),0)),"^",3)
 S IBT(6)="        Service: "_$$EXPAND^IBTRE(42.4,3,SVC)
 ;
 S IBT(7)=""
 S IBT(9)="  Ward Location: "_$S($D(^DIC(42,+$P(DGPMA,"^",6),0)):$P(^(0),"^",1),1:"UNKNOWN")
 S IBT(10)="       Room-Bed: "_$S($D(^DG(405.4,+$P(DGPMA,"^",7),0)):$P(^(0),"^",1),1:"UNKNOWN")
 ;
 S IBT(11)="   Admitting DX: "_$P(DGPMA,"^",10)
 S IBT(12)="  Type of Admit: "_$S($D(^DG(405.1,+$P(DGPMA,"^",4),0)):$P(^(0),"^",1),1:"")
 S IBT(13)=""
 S IBT(14)="        Insured: "_$S($$INSURED^IBCNS1(DFN):"YES",1:"NO")
 D SEND
BULLQ Q
 ;
SEND S XMDUZ="INTEGRATED BILLING PACKAGE",XMTEXT="IBT("
 K XMY S XMN=0
 S DGPMX=$O(^XMB(3.8,"B","DGPM UR ADMISSION",0)) I '$O(^XMB(3.8,+DGPMX,1,0)) G SENDQ ; if no mailgroup members, quit
 S XMY("G.DGPM UR ADMISSION")="" ; pass mailgroup
 D ^XMD
SENDQ K X,Y,IBI,IBT,IBGRP,XMDUZ,XMTEXT,XMY,XMSUB,DGPMX
 Q
