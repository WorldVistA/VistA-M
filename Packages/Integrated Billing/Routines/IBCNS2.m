IBCNS2 ;ALB/AAS - INSURANCE POLICY CALLS FROM FILE 399 DD ;22-JULY-91
 ;;2.0;INTEGRATED BILLING;**28,43,80,51,137,155,488,516**;21-MAR-94;Build 123
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
DD(IBX,IBDA,LEVEL) ;  - called from input transform for field 111,112,113
 ; -- input   ibx = x from input transform
 ;           ibda = internal entry in 399
 ;          level = 1=primary, 2=secondary, 3=tertiary
 ; -- output  returns x=internal entry in 2.3121 (ins. Mult.) if valid
 ;   
 N DFN,ACTIVE,INSDT
 D VAR
 S X=$$SEL(IBX,DFN,INSDT,ACTIVE)
 I +X<1 K X
DDQ Q
 ;
VAR S DFN=$P(^DGCR(399,IBDA,0),"^",2),ACTIVE=1,INSDT=$S(+$G(^DGCR(399,IBDA,"U")):+$G(^("U")),1:DT)
 Q
 ;
SEL(IBX,DFN,INSDT,ACTIVE) ; -- Select insurance policy
 ; -- Input    IBX  = x from input transform
 ;             DFN  = patient
 ;           INSDT  = (optional) Active date of ins. (default = dt)
 ;          ACTIVE  = (optional) 1 if want active (default)
 ;                  = 2 if want all ins returned
 ;
 ; -- Output      =  pointer to 36 ^ pointer to 2.3121 ^ pointer to 355.3
 ;
 N I,J,Y,DA,DE,DQ,DR,DIC,DIE,DIR,DIV,IBSEL,IBDD,IBD
 S IBSEL=1,Y=""
 I '$G(ACTIVE) S ACTIVE=1
 S:'$G(INSDT) INSDT=DT
 I '$G(DFN) G SELQ
 D BLD
 ;
 ; -- call DIC to choose from list
 ;WCJ*IB*2.0*488;Display COB on picklist when partial match on more than one entry
 ;everything else should continue to work as before
 N IBOUT,IBSEL2
 S IBX=$$UP^XLFSTR(IBX)
 I IBX?1A.E D  S IBX=$S($G(IBOUT):"^",$G(IBSEL2):IBSEL2,1:IBX)
 . N X,Y,ERROR,TARGET,I,G
 . ;IB*2.0*516/TAZ - Use HIPAA compliant fields
 . ;D LIST^DIC(2.312,","_DFN_",",".01;.2;3;8;1;16;.18;21",,9999,,IBX,,"I $D(IBDD(+Y))",,"TARGET","ERROR")
 . D LIST^DIC(2.312,","_DFN_",",".01;.2;3;8;7.02;16;.18;21",,9999,,IBX,,"I $D(IBDD(+Y))",,"TARGET","ERROR") ;516 - baa : add 7.02
 . I $D(ERROR) S IBOUT=1 Q   ; should not hit this.  used more during test 
 . I '$D(TARGET) S IBOUT=1 Q  ; no partial matches
 . I +$G(TARGET("DILIST",0))<2 Q  ; only one match so work as before
 . D DSPTHM   ; display them
 . S DIR(0)="N^1:"_+$G(TARGET("DILIST",0))   ;allow select of 1 to as many matches
 . D ^DIR
 . I $G(DIRUT) S IBOUT=1 Q   ; user ^, timed out, or entered null
 . S IBX="`"_$G(TARGET("DILIST",2,+Y))
 . W !
 . Q
 ;WCJ*IB*2.0*488
 ;
 S X=IBX
 S DIC="^DPT("_DFN_",.312,",DIC(0)="EQMN"
 S DIC("S")="I $D(IBDD(+Y))" ; add not other selection
 S DIC("W")="W $P(^DIC(36,+^(0),0),U)_""  Group: ""_$$GRP^IBCNS($P(^DPT(DFN,.312,+Y,0),U,18))"
 D ^DIC
SELQ Q +Y
 ;
 ;WCJ*IB*2.0*488;
DSPTHM ; display the insurance companies and useful information
 W !,?4,"Insurance",?18,"COB",?23,"Subscriber ID",?37,"Group #",?49,"Eff Date",?62,"Exp Date"
 N I
 F I=1:1 Q:'$D(TARGET("DILIST","ID",I))  D
 . W !,I,?4,$E($G(TARGET("DILIST","ID",I,.01)),1,12)
 . W ?18,"(",$$LOW^XLFSTR($E($G(TARGET("DILIST","ID",I,.2)),1)),")"
 . ;IB*2.0*516/TAZ - Use HIPAA compliant fields
 . ;W ?23,$E($G(TARGET("DILIST","ID",I,1)),1,12)
 . W ?23,$E($G(TARGET("DILIST","ID",I,7.02)),1,12)
 . W ?37,$E($G(TARGET("DILIST","ID",I,21)),1,10)
 . W ?49,$G(TARGET("DILIST","ID",I,8))
 . W ?62,$G(TARGET("DILIST","ID",I,3))
 Q
 ;WCJ*IB*2.0*488;
 ;
BLD K IBD,IBDD
 S (IBDD,IBCDFN)=0 F  S IBCDFN=$O(^DPT(DFN,.312,IBCDFN)) Q:'IBCDFN  I $D(^DPT(DFN,.312,IBCDFN,0)) D CHK(IBCDFN,ACTIVE,INSDT)
 Q
 ;
CHK(IBCDFN,ACTIVE,INSDT) ; -- see if active
 N X,X1
 S X=$G(^DPT(DFN,.312,IBCDFN,0))
 S IBDD(IBCDFN)=+X_"^"_IBCDFN_"^"_$P(X,"^",18)
 I ACTIVE=2 G CHKQ
 S X1=$G(^DIC(36,+X,0)) I X1="" G CQ ;ins co entry doesn't exist
 I $P(X,"^",8) G:INSDT<$P(X,"^",8) CQ ;effective date later than care
 I $P(X,"^",4) G:INSDT>$P(X,"^",4) CQ ;care after expiration date
 I $P($G(^IBA(355.3,+$P(X,"^",18),0)),"^",11) G CQ ;plan is inactive
 G:$P(X1,"^",5) CQ ;                  ;ins company inactive
 ;G:$P(X1,"^",2)="N" CQ ;              ;ins company will not reimburse
 G CHKQ
CQ K IBDD(IBCDFN)
CHKQ S:$D(IBDD(IBCDFN)) IBDD=IBDD+1,IBD(IBDD)=IBCDFN
 Q
 ;
 ;
DDHELP(IBDA,LEVEL) ; -- Executable help
 ; -- write out list to choose from
 N DFN,ACTIVE,INSDT,I,IBINS
 D VAR,BLD
 ;
 I $G(IBDD)=0 W !,"No Insurance Policies to Select From" G DDHQ
 ;
 I '$D(IOM) D HOME^%ZIS
 N IBDTIN
 S IBDTIN=$G(INSDT)
 W ! D HDR^IBCNS
 S I=0 F  S I=$O(IBD(I)) Q:'I  D
 .;IB*2.0*516/TAZ - Use HIPAA compliant fields
 .;S IBINS=$G(^DPT(DFN,.312,$G(IBD(I)),0))  ; 516 - baa
 .S IBINS=$$ZND^IBCNS1(DFN,$G(IBD(I)))  ; 516 - baa
 .D D1^IBCNS
DDHQ Q
 ;
TRANS(IBDA,Y) ; -- output transform
 N DFN,ACTIVE,INSDT
 D VAR
 S Y=$P($G(^DIC(36,+$P($G(^DPT(DFN,.312,+$G(Y),0)),U),0)),U)
 Q Y
 ;
INSCO(IBDA,IBCDFN) ; -- return pointer value of 36 from pt. file
 N DFN,ACTIVE,INSDT
 D VAR
 S Y=+$G(^DPT(DFN,.312,IBCDFN,0))
 Q Y_$S(Y>0:"^"_$P($G(^DIC(36,+Y,0)),"^"),1:"")
 ;
IX(DA,XREF) ; -- create i1, aic xrefs for fields 112, 113, 114
 ;
 ;IB*2.0*516/TAZ - Set up I17, I27 or I37 nodes
 N DFN
 S DFN=$P($G(^DGCR(399,DA,0)),"^",2)
 S ^DGCR(399,DA,XREF)=$$ZND^IBCNS1(DFN,X,399)
 I ",I1,I2,I3,"[(","_XREF_","),$G(^DPT(DFN,.312,+X,7))'="" S ^DGCR(399,DA,XREF_"7")=$G(^DPT(DFN,.312,+X,7))
 S ^DGCR(399,DA,"AIC",+$G(^DPT(DFN,.312,+X,0)))=""
 Q
 ;
KIX(DA,XREF) ; -- kill logic for above xref
 K ^DGCR(399,DA,XREF)
 I ",I1,I2,I3,"[(","_XREF_",") K ^DGCR(399,DA,XREF_"7")
 K ^DGCR(399,DA,"AIC",+$G(^DPT($P($G(^DGCR(399,DA,0)),"^",2),.312,+X,0)))
 Q
 ;
BPP(IBDA,IBMCR) ; Find Bill Payer Policy based on Payer Sequence and the P/S/T payers assigned to the bill,Ins Co must reimburse
 ; IBMCR = flag that says include MEDICARE WNR
 ; returns - Bill Payer Policy (ifn of policy entry in patient file)
 ;         - null if either no Payer Sequence or there is no policy defined for the payer sequence
 ;           or the policy defined by the payer sequence Will Not Reimburse and is not MEDICARE
 ;
 N IBI,IBX,IBY,IBP,IBC,IBM0 S IBX="",(IBP,IBC)=0
 S IBMCR=+$G(IBMCR)
 S IBY=$$COBN^IBCEF(+IBDA) I IBY S IBY=IBY+11
 I IBY S IBM0=$G(^DGCR(399,+IBDA,"M")),IBP=$P(IBM0,U,IBY)
 I IBP S IBY=IBY-11,(IBI,IBY)=$P(IBM0,U,IBY) I +IBY S IBC=$P($G(^DIC(36,+IBY,0)),U,2)
 I IBP,IBI,$S(IBC'="N":1,'IBMCR:0,1:$$MCRWNR^IBEFUNC(+IBY)) S IBX=IBP
 Q IBX
