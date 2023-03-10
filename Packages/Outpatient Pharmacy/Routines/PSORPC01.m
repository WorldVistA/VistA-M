PSORPC01 ;INN/AA - PAPI INTERFACE ROUTINES ;Dec 06, 2021@15:55:23
 ;;7.0;OUTPATIENT PHARMACY;**441**;DEC 1997;Build 208
 ;
 ;Ref. ^PSDRUG( supp. DBIA 221
 ;Ref. GET^XPAR supp. DBIA 2263
 ;Ref. EDITPAR^XPAREDIT supp. DBIA 2336
 ;
RPC(RESULTS,OPTION,P1,P2,P3,P4,P5,P6) ; [Procedure] Main RPC call
 ; based on MD* routines
 N ERR
 S RESULTS=$NA(^TMP("PSORPC01",$J)) K @RESULTS
 I '($T(@OPTION)]"") S @RESULTS@(0)="-1^Option '"_OPTION_"' not found in routine '"_$T(+0)_"'." Q
 D @OPTION
 D CLEAN^DILF
 Q
 ;
ECHO ;
 ;
 S @RESULTS@(0)=OPTION
 S @RESULTS@(1)="P1:"_P1
 S @RESULTS@(2)="P2:"_P2
 S @RESULTS@(3)="P3:"_P3
 S @RESULTS@(4)="P4:"_P4
 S @RESULTS@(5)="P5:"_P5
 S @RESULTS@(6)="P6:"_P6
 Q
 ;
GETPARK(PSOPRK) ; Check if parking is available for the site
 N PSOPARST S PSOPARST="SYS^PKG"
 I +$G(PSOPINST) S PSOPARST=PSOPINST_";DIC(4,^"_PSOPARST ; if outpatient site related institution is defined use it in parameter check
 I PSOPARST="SYS^PKG" S PSOPARST="DIV^SYS^PKG"
 S @RESULTS@(0)=$S($$GET^XPAR(PSOPARST,"PSO PARK ON",,"E")="YES":"YES",1:"NO")
 Q
 ;
SETPARK ;TURN PARK A PRESCRIPTION ON OR OFF
 D EDITPAR^XPAREDIT("PSO PARK ON")
 Q
 ;
PARK ;
 ;
 S PSODA=$O(^PSRX("APL",+P1,""))
 I PSODA D PARK^PSOPRKA(PSODA)
 K PSODA
 Q
 ;
UNPARK ;
 ;
 S PSODA=$O(^PSRX("APL",+P1,"")) I PSODA="" Q
 D UNPARK^PSOPRKA(PSODA,+P3,.ERRMSG)
 I $G(ERRMSG(1))'="" S @RESULTS@(0)=ERRMSG(1)
 K ERRMSG,PSODA
 Q
 ;
PARKDRG ; Check if drug is marked as not parkable (new CPRS order)
 S @RESULTS@(0)=1
 I '$G(P1) Q
 I ($P($G(^PSDRUG(P1,0)),"^",3)["D")!($P($G(^PSDRUG(P1,0)),"^",1)["CLOZAPINE") S @RESULTS@(0)="0^Drug is defined as not parkable"
 ;I $P($G(^PSDRUG(P1,0)),"^",1)["CLOZAPINE" S @RESULTS@(0)="0^"_$P($G(^PSDRUG(P1,0)),"^",1)_" is not a parkable medication"
 ;B  Q
 Q
 ;
PARKORD ; Check if drug belonging to order# is marked as not parkable (CPRS renewal)
 S @RESULTS@(0)=1
 I '$G(P1) Q
 N DRUG
 S PSODA=$O(^PSRX("APL",+P1,"")) I PSODA="" Q
 S DRUG=$P($G(^PSRX(PSODA,0)),"^",6) I 'DRUG Q
 I ($P($G(^PSDRUG(DRUG,0)),"^",3)["D")!($P($G(^PSDRUG(DRUG,0)),"^",1)["CLOZAPINE") S @RESULTS@(0)="0^Drug is defined as not parkable"
 Q
 ;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;
 ;NAME: PSORPC                           TAG: RPC
 ; ROUTINE: PSORPC01                     RETURN VALUE TYPE: GLOBAL ARRAY
 ; AVAILABILITY: PUBLIC                  INACTIVE: ACTIVE
 ; VERSION: 1
 ;INPUT PARAMETER: OPTION                PARAMETER TYPE: LITERAL
 ; MAXIMUM DATA LENGTH: 8                REQUIRED: YES
 ; SEQUENCE NUMBER: 1
 ;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
