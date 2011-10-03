IBJTU3 ;ALB/ARH - TPI UTILITIES - INS ADDRESS ; 2/14/95
 ;;2.0;INTEGRATED BILLING;**39,80**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
BADD(IBIFN) ; returns mailing address for bill
 ; returns: COMPANY NAME ^ PHONE NUMBER ^ STR 1 ^ STR 2 ^ STR 3 ^ CITY ^ STATE ^ ZIP ^ ^ FAX #
 N DFN,IBX,IBCNS,IBCDFN,IBTYP
 ;
 S IBX="",DFN=$G(^DGCR(399,+$G(IBIFN),0))
 S IBTYP=$P(DFN,U,5),DFN=+$P(DFN,U,2) I 'DFN G BADDQ
 S IBCNS=$G(^DGCR(399,+IBIFN,"MP")) I 'IBCNS G BADDQ
 S IBCDFN=$P(IBCNS,U,2) I +IBCDFN S IBCNS=+$G(^DPT(DFN,.312,+IBCDFN,0))
 ;
 ; -- if send to employer and state defined, return employer address
 I +IBCDFN S IBCDFN=$G(^DPT(DFN,.312,+IBCDFN,2)) I +IBCDFN,+$P(IBCDFN,U,6) D  G BADDQ
 . S IBX=$P(IBCDFN,U,9)_U_$P(IBCDFN,U,8)_U_$P(IBCDFN,U,2,7)
 ;
 S IBTYP=$S(IBTYP<3:"INP",1:"OPT")
 S IBX=$$INSADD(+IBCNS,IBTYP)
 ;
BADDQ Q IBX
 ;
 ;
INSADD(IBCNS,IBATYP) ; returns specific type of address/phone # for an insurance company, follows ptrs to company responsible
 ; returns: COMPANY NAME ^ PHONE NUMBER ^ STR 1 ^ STR 2 ^ STR 3 ^ CITY ^ STATE ^ ZIP ^ ^ FAX #
 ; if type does not have an address or phone number then main mailing addr/ph # is returned
 ;
 N IBD0,IBD13,IBADD,IBNM,IBPH,IBDN,IBCNT,IBAGAIN
 S (IBADD,IBNM,IBPH)=""
 ;
MAIN ; -- determine address for company for type bill
 ;
 S IBD0=$G(^DIC(36,+$G(IBCNS),0)) I IBD0="" G MAINQ
 S IBD13=$G(^DIC(36,IBCNS,.13))
 ;
 ; -- get name, main address, phone number
 S IBNM=$P(IBD0,U,1),IBPH=$P(IBD13,U,1),IBADD=$G(^DIC(36,+IBCNS,.11))
 ;
 ; -- if process the same co. more than once you are in an infinate loop
 I $D(IBCNT(IBCNS)) G MAINQ ;already processed this company  use main add
 S IBCNT(IBCNS)=""
 ;
 ; -- type of bill
 I $G(IBATYP)'="",$T(@IBATYP)'="" D @IBATYP I $D(IBAGAIN) K IBAGAIN G MAIN
 ;
 ; -- return address
MAINQ S IBNM=IBNM_U_IBPH_U_IBADD
 Q IBNM
 ;
VER ; -- verification phone number
 I $P(IBD13,U,4)'="" S IBPH=$P(IBD13,U,4)
 Q
 ;
BILL ; -- billing phone number
 I $P(IBD13,U,2)'="" S IBPH=$P(IBD13,U,2)
 Q
 ;
PCERT ; -- precertification phone number
 I $P(IBD13,U,3)'="" S IBPH=$P(IBD13,U,3)
 ;
 ; -- if other company processes precerts start again
 I $P(IBD13,"^",9) S IBCNS=$P(IBD13,"^",9) S IBAGAIN=1
 Q
 ;
INP ; -- inpatient phone number
 I $P(IBD13,U,5)'="" S IBPH=$P(IBD13,U,5)
 ;
 ; -- see if there is an inpatient address, use if state is there
 S IBDN=$G(^DIC(36,+IBCNS,.12)) I $P(IBDN,"^",5) S IBADD=IBDN
 ;
 ; -- if other company processes claims start again
 I $P(IBDN,"^",7) S IBCNS=$P(IBDN,"^",7) S IBAGAIN=1
 Q
 ;
OPT ; -- outpatient phone number
 I $P(IBD13,U,6)'="" S IBPH=$P(IBD13,U,6)
 ;
 ; -- see if there is an outpatient address, use if state is there
 S IBDN=$G(^DIC(36,+IBCNS,.16)) I $P(IBDN,"^",5) S IBADD=IBDN
 ;
 ; -- if other company processes claims start again
 I $P(IBDN,"^",7) S IBCNS=$P(IBDN,"^",7) S IBAGAIN=1
 Q
 ;
RX ; -- prescription phone number
 I $P(IBD13,U,11)'="" S IBPH=$P(IBD13,U,11)
 ;
 ; -- see if there is an prescription address, use if state is there
 S IBDN=$G(^DIC(36,+IBCNS,.18)) I $P(IBDN,"^",5) S IBADD=IBDN
 ;
 ; -- if other company processes claims start again
 I $P(IBDN,"^",7) S IBCNS=$P(IBDN,"^",7) S IBAGAIN=1
 Q
 ;
APL ; -- appeals phone number
 I $P(IBD13,U,7)'="" S IBPH=$P(IBD13,U,7)
 ;
 ; -- see if there is an appeals address, use if state is there
 S IBDN=$G(^DIC(36,+IBCNS,.14)) I $P(IBDN,"^",5) S IBADD=IBDN
 ;
 ; -- if other company processes claims start again
 I $P(IBDN,"^",7) S IBCNS=$P(IBDN,"^",7) S IBAGAIN=1
 Q
 ;
INQ ; -- inquiry phone number
 I $P(IBD13,U,8)'="" S IBPH=$P(IBD13,U,8)
 ;
 ; -- see if there is an outpatient address, use if state is there
 S IBDN=$G(^DIC(36,+IBCNS,.15)) I $P(IBDN,"^",5) S IBADD=IBDN
 ;
 ; -- if other company processes claims start again
 I $P(IBDN,"^",7) S IBCNS=$P(IBDN,"^",7) S IBAGAIN=1
 Q
