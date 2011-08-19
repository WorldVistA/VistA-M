DGPMV301 ;ALB/MIR - ENTER TRANSACTION INFORMATION; 8 MAY 89 ;5/8/91  08:08
 ;;5.3;Registration;**34,271**;Aug 13, 1993
 ;
 ; This is the continuation of DGPMV3
 ;
NEW ;Entry point to add a new entry to ^DGPM
 ;INPUT:    DGPM0ND=0 node of new entry.
 ;OUTPUT:         Y=IFN of new entry created
 ;
 ;X is set to the date/time from +DGPM0ND
 N DGMVTYPE
 K DINUM I '$D(DGNOW) D NOW^%DTC S DGNOW=% K %
 S DGMVTYPE=$P(DGPM0ND,"^",2)
 I "^3^5^"[("^"_DGMVTYPE_"^") S ^UTILITY("DGPM",$J,$S(DGMVTYPE=3:1,1:4),+$P(DGPM0ND,"^",14),"P")=$G(^DGPM(+$P(DGPM0ND,"^",14),0)) ; have to catch change in 17th piece for ev driver
 S X=+DGPM0ND,(DIK,DIC)="^DGPM(",DIC(0)="L" K DD,DO D FILE^DICN S DGX=Y I "^1^4^"[("^"_$P(DGPM0ND,"^",2)_"^") S $P(DGPM0ND,"^",14)=+Y
 S DA=+Y L +^DGPM(+Y) S ^DGPM(+Y,0)=DGPM0ND,^("USR")=DUZ_"^"_DGNOW
 D
 .N DGX     ;Preserve DGX Variable for L - Statement
 .D IX1^DIK
 L -^DGPM(+DGX)
 S Y=DGX K DGX
 I "^3^5^"[("^"_DGMVTYPE_"^") S ^UTILITY("DGPM",$J,$S(DGMVTYPE=3:1,1:4),+$P(DGPM0ND,"^",14),"A")=$G(^DGPM(+$P(DGPM0ND,"^",14),0)) ; have to catch change in 17th piece for ev driver
 Q
