IBTRED ;ALB/AAS - EXPAND/EDIT CLAIMS TRACKING ENTRY ;01-JUL-1993
 ;;2.0;INTEGRATED BILLING;**71,91,160,247,309,276,339,363**;21-MAR-94;Build 35
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
% ;
EN ; -- main entry point for IBT EXPAND/EDIT TRACKING
 I '$D(DT) D DT^DICRW
 K XQORS,VALMEVL,DFN,IBTRN,IBTRV,IBTRC,IBTRD
 I '$G(IBTRN) G EN^IBTRE Q  ; entry from programmer mode
 D EN^VALM("IBT EXPAND/EDIT TRACKING")
 K IBFASTXT
 Q
 ;
HDR ; -- header code
 D PID^VADPT
 S VALMHDR(1)="Expanded Claims Tracking Info for: "_$E($P($G(^DPT(DFN,0)),"^"),1,20)_" "_$E($G(^(0)),1)_VA("BID")_"   ROI: "_$$EXPAND^IBTRE(356,.31,$P(^IBT(356,IBTRN,0),"^",31))
 S VALMHDR(2)="                              For: "_$$ETYP(IBTRN)
 Q
 ;
INIT ; -- init variables and list array
 K VALMQUIT
 S VALMCNT=0,VALMBG=1
 D BLD,HDR
 Q
 ;
BLD ; -- list builder
 N IBTRND,IBTRND1,IBTRND2,IBETYP
 K ^TMP("IBTRED",$J)
 F I=1:1:30 D BLANK(.I)
 I '$G(IBTRPRF) S IBTRPRF=123
 I IBTRPRF<10 S X=$S(IBTRPRF=1:"IBTRED  HR MENU",IBTRPRF=2:"IBTRED  IR MENU",IBTRPRF=3:"IBTRED  BI MENU",1:"IBTRED  MENU") D PROT^IBTRPR(X)
 D KILL^VALM10()
 S IBTRND=$G(^IBT(356,IBTRN,0)),IBTRND1=$G(^(1))
 S IBETYP=$G(^IBE(356.6,+$P(IBTRND,"^",18),0))
 S VALMCNT=30
 D VISIT D ^IBTRED0,^IBTRED01
 Q
 ;
VISIT ; -- Visit info Region
 N OFFSET,START,IBOE,IBOE0
 S START=1,OFFSET=2
 D SET^IBCNSP(START,OFFSET," Visit Information ",IORVON,IORVOFF)
 D SET^IBCNSP(START+1,OFFSET,"    Visit Type: "_$P(IBETYP,"^"))
 I '$D(IBETYP) N IBETYP S IBETYP=$G(^IBE(356.6,+$P(IBTRND,"^",18),0))
 S X=$P(IBETYP,"^",3) D @X
 Q
1 ; -- visit region for admission or scheduled admission
 I $P($G(^DGPM(+$P(IBTRND,"^",5),0)),"^",17) S VAINDT=+$G(^DGPM(+$P(IBTRND,"^",5),0))
 I '$D(VAIN) S VA200="" D INP^VADPT
 I VAIN(7)="" S Y=$P(IBTRND,"^",6) D D^DIQ S $P(VAIN(7),"^",2)=Y
 D SET^IBCNSP(START+2,OFFSET,"Admission Date: "_$P(VAIN(7),"^",2))
 D SET^IBCNSP(START+3,OFFSET,"          Ward: "_$P(VAIN(4),"^",2))
 D SET^IBCNSP(START+4,OFFSET,"     Specialty: "_$P(VAIN(3),"^",2))
 Q
2 ; -- visit region for  outpatient care
 S IBOE=$P(IBTRND,"^",4),IBOE0=$$SCE^IBSDU(+IBOE)
 D SET^IBCNSP(START+2,OFFSET,"    Visit Date: "_$$DAT1^IBOUTL($P(IBTRND,"^",6),"2P"))
 I +IBOE<1 D  Q
 .D SET^IBCNSP(START+3,OFFSET,"  No Outpatient Encounter Found") Q
 D SET^IBCNSP(START+3,OFFSET,"        Clinic: "_$P($G(^SC(+$P(IBOE0,"^",4),0)),"^"))
 D SET^IBCNSP(START+4,OFFSET,"  Appt. Status: "_$$EXPAND^IBTRE(409.68,.12,$P(IBOE0,"^",12)))
 D SET^IBCNSP(START+5,OFFSET,"    Appt. Type: "_$$EXPAND^IBTRE(409.68,.1,$P(IBOE0,"^",10)))
 D SET^IBCNSP(START+6,OFFSET,"  Special Cond: "_$$ENCL(IBOE))
 Q
 ;
3 ; -- visit region for rx refill
 N PSONTALK,PSOTMP,PSOQTY
 S PSONTALK=1 ;PSORXN=+$P(IBTRND,"^",8),PSOFILL=+$P(IBTRND,"^",10)
 S X=+$P(IBTRND,"^",8)_"^"_+$P(IBTRND,"^",10) D EN^PSOCPVW
 ;if refill was deleted and EN^PSOCPVW doesn't return any data use IB API
 I '$D(PSOTMP) D PSOCPVW^IBNCPDPC(+$P(IBTRND,"^",2),+$P(IBTRND,"^",8),.PSOTMP)
 S PSOQTY=$$NCPDPQTY^PSSBPSUT(+$$RXAPI1^IBNCPUT1(+$P(IBTRND,"^",8),6,"I"),PSOTMP(52,+$P(IBTRND,"^",8),7,"E"))
 D SET^IBCNSP(START+2,OFFSET,"Prescription #: "_$G(PSOTMP(52,+$P(IBTRND,"^",8),.01,"E")))
 ;I $P(IBTRND,"^",10)=0 D SET^IBCNSP(START+3,OFFSET,"     Fill Date: "_$G(PSOTMP(52,+$P(IBTRND,"^",8),22,"E")))
 ;I +$P(IBTRND,"^",10) D SET^IBCNSP(START+3,OFFSET,"   Refill Date: "_$G(PSOTMP(52.1,+$P(IBTRND,"^",10),.01,"E")))
 I $P(IBTRND,"^",10)=0 D SET^IBCNSP(START+3,OFFSET,"     Fill Date: "_$$FMTE^XLFDT(+$P(IBTRND,"^",6)))
 I +$P(IBTRND,"^",10) D SET^IBCNSP(START+3,OFFSET,"   Refill Date: "_$$FMTE^XLFDT(+$P(IBTRND,"^",6)))
 D SET^IBCNSP(START+4,OFFSET,"          Drug: "_$G(PSOTMP(52,+$P(IBTRND,"^",8),6,"E")))
 D SET^IBCNSP(START+5,OFFSET,"   Rx Quantity: "_$J($G(PSOTMP(52,+$P(IBTRND,"^",8),7,"E")),8))
 D SET^IBCNSP(START+6,OFFSET," Bill Quantity:  "_$J($P(PSOQTY,"^"),11)_" "_$P(PSOQTY,"^",2))
 D SET^IBCNSP(START+7,OFFSET,"   Days Supply: "_$J($G(PSOTMP(52,+$P(IBTRND,"^",8),8,"E")),8))
 D SET^IBCNSP(START+8,OFFSET,"          NDC#: "_$$GETNDC^PSONDCUT(+$P(IBTRND,"^",8),$P(IBTRND,"^",10)))
 D SET^IBCNSP(START+9,OFFSET,"     Physician: "_$G(PSOTMP(52,+$P(IBTRND,"^",8),4,"E")))
 Q
 ;
4 ; -- Visit region for prosthetics
 D 4^IBTRED01
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K VALMQUIT,IBTRN
 D CLEAN^VALM10,FULL^VALM1
 Q
 ;
BLANK(LINE) ; -- Build blank line
 D SET^VALM10(.LINE,$J("",80))
 Q
 ;
ETYP(IBTRN) ; -- Expand type of epidose and date
 N IBY S IBY=""
 S IBTRND=$G(^IBT(356,+IBTRN,0)) I IBTRND="" G ETYPQ
 S IBETYPD=$G(^IBE(356.6,+$P(IBTRND,"^",18),0))
 I IBETYPD="" G ETYPQ
 S IBY=$P(IBETYPD,"^")_" on "_$$DAT1^IBOUTL($P(IBTRND,"^",6),"2P")
ETYPQ Q IBY
 ;
ENCL(IBOE) ; -- output format of classifications
 N I,X,IBCL,IBCL1 S IBCL=""
 I '$G(IBOE) G ENCLQ
 S IBCL1=$$ENCL^IBAMTS2(+IBOE)
 F I=1:1:8 S X=$P(IBCL1,"^",I) S:X IBCL=IBCL_$S(I=1:"AO",I=2:"IR",I=3:"SC",I=4:"SWA",I=5:"MST",I=6:"HNC",I=7:"CV",I=8:"SHAD",1:"")_"  "
ENCLQ Q IBCL
 ;
