IBTRKRBR ;WAS/RFJ - claims tracking - relinker bulletin ; 1 Mar 96
 ;;Version 2.0 ; INTEGRATED BILLING ;**56**; 21-MAR-94
 Q
 ;
 ;
RELBULL(DFN,IBTRN,DGPMA,IBSPEC) ; -- send admission bulletin for rs
 ;  dfn    = patient ien file 2
 ;  ibtrn  = claims tracking ien file 356
 ;  dgpma  = 0th node from movement file 405
 ;  ibspec = specialty ien file 45.7
 N %,IBT,SERVICE,SPECALTY,VA,VAERR,Y
 ;
 S IBT(1)="The following claims tracking entry has been relinked to an admission and is"
 S IBT(2)="no longer inactive as of "_$$DAT2^IBOUTL($$NOW^XLFDT())_"."
 S IBT(3)=""
 ;
 D PID^VADPT
 S IBT(4)="        Patient: "_$P(^DPT(DFN,0),"^")_" ("_VA("PID")_")"
 ;
 S Y=$P(DGPMA,"^") D DD^%DT
 S IBT(5)=" Admission Date: "_Y_"   ("_$P(DGPMA,"^",14)_")"
 S IBT(6)="    CT Entry ID: "_$P($G(^IBT(356,+IBTRN,0)),"^")
 S IBT(7)=""
 ;
 S SPECALTY=$P($G(^DIC(45.7,+IBSPEC,0)),"^",2)
 S IBT(8)="      Specialty: "_$P($G(^DIC(45.7,+IBSPEC,0)),"^")
 ;
 S SERVICE=$P($G(^DIC(42.4,+$P($G(^DIC(45.7,+IBSPEC,0)),"^",2),0)),"^",3)
 S IBT(9)="        Service: "_$$EXPAND^IBTRE(42.4,3,SERVICE)
 ;
 S IBT(10)="  Ward Location: "_$S($D(^DIC(42,+$P(DGPMA,"^",6),0)):$P(^(0),"^",1),1:"UNKNOWN")
 S IBT(11)="       Room-Bed: "_$S($D(^DG(405.4,+$P(DGPMA,"^",7),0)):$P(^(0),"^",1),1:"UNKNOWN")
 ;
 S IBT(12)="   Admitting DX: "_$P(DGPMA,"^",10)
 S IBT(13)="  Type of Admit: "_$S($D(^DG(405.1,+$P(DGPMA,"^",4),0)):$P(^(0),"^",1),1:"")
 S IBT(14)="        Insured: "_$S($$INSURED^IBCNS1(DFN):"YES",1:"NO")
 D SEND^IBTRKRBA("Claims Tracking Patient Relinked/Reactivated")
 Q
