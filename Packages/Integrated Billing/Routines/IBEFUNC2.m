IBEFUNC2 ;ALB/ARH - CPT BILLING EXTRINSIC FUNCTIONS II ;11/27/91
 ;;2.0;INTEGRATED BILLING;**51,266**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
MODLST(MODS,DESC,IBMOD,IBDATE) ; Function returns string of actual modifiers translated
 ; from the comma delimited string of modifier iens in MODS
 ; DESC = 1 if description of modifier should be returned in IBMOD(1)
 ;        Must pass IBMOD by reference for this to work
 ; IBMOD = the ',' delimited list of modifiers,
 ;         IBMOD(1) = the ',' delimited modifier descriptions, if
 ;         DESC = 1 and IBMOD is passed by reference
 ; IBDATE = Date of Service (opt) for the versioned text description
 ; 
 N Z,Z0,IBP
 S IBMOD="",IBMOD(1)=""
 F Z=1:1:$L(MODS,",") S IBP=$P(MODS,",",Z) I IBP D
 . S Z0=$$MOD^ICPTMOD(IBP,"I",$G(IBDATE)) Q:Z0<0
 . I $G(DESC) S IBMOD(1)=IBMOD(1)_$S(IBMOD="":"",1:",")_$P(Z0,U,3)
 . S IBMOD=IBMOD_$S(IBMOD="":"",1:",")_$P(Z0,U,2)
 Q IBMOD
 ;
CPTSTAT(CPT,DATE) ;determine the overall status for a CPT for given date,  assumes today if no date given
 ;if DATE is not today, assumes that if active in either 409.71 or 350.4 then also active in 81 for that DATE
 ;(ICPT is not a date sensitive file, so will only check (81) if want todays status), returns:
 ; 1  - if DATE=DT and CPT currently only active in ICPT file (81) (not active in 409.71 or 350.4)
 ; 2A - if CPT is Nationally Active only in SD(409.71) and not BASC for DATE
 ; 2B - if CPT is Locally Active only in SD(409.71) and not BASC for DATE
 ; 2C - if CPT is Nationally and Locally Active in SD(409.71) and not BASC for DATE
 ; 3  - if CPT is Billing Active (BASC) in IBE(350.4) and not active in (409.71) for DATE
 ; 4A - if CPT is Nationally Active in SD(409.71) and Billing Active in IBE(350.4) for DATE
 ; 4B - if CPT is Locally Active only in SD(409.71) and Billing Active in IBE(350.4) for DATE
 ; 4C - if CPT is Nationally and Locally Active in SD(409.71) and Billing Active in IBE(350.4) for DATE
 ; 0  - otherwise
 N X,X1,Y,POST
 S:'$D(CPT) CPT=0 S:'$D(DATE) DATE=DT S:'DATE DATE=DT
 S Y=0,POST="" G:$$CPT^ICPTCOD(+CPT)<1 CEND
 I $E(DATE,1,7)=DT G:'$P($$CPT^ICPTCOD(+CPT),"^",7) CEND S Y=1
 S X=CPT,X1=DATE D STATUS^SDAMBAE4 I X'["INACTIVE"&(X'="") D
 . S Y=2,POST="A" I X["LOCAL" S POST="B" I X["NATIONAL" S POST="C"
 I $$CPTBSTAT^IBEFUNC1(CPT,DATE) S Y=3 I POST'="" S Y=Y+1
CEND Q Y_POST
 ;
TDG(SSN) ;reformat SSN into terminal digit order
 ; returns either 0 or ssn in terminal digit order
 N X,Y,I S Y="" F I=1:1 S X=$E(SSN,I) Q:X=""  I X?1N S Y=Y_X
 S Y=$S(Y'?9N:0,1:$E(Y,8,9)_$E(Y,6,7)_$E(Y,4,5)_$E(Y,1,3))
ENDP Q Y
 ;
FFMT ;
 S IBLNGX=$$FORMAT($S('$D(IBGRPX):"",1:IBGRPX),$S('$D(IBCPX):"",1:IBCPX)) Q
 ;
FORMAT(GRP,CP) ;calculate spacing format for clinic CPT list
 ;input GRP - the ifn of the GROUP to be calculated or ""
 ; or   CP  - the ifn of the entry in 350.71 to return format or ""
 ;returns - "" if GRP not defined in ^IBE(350.7, or GRP of CP not found
 ;        - margin width & intercolumn width ^ header width (same for both groups and catigories)
 ;          ^ procedure name width 
 ;if # of columns not defined for group, assumes 2
 ;if display charge not defined for group, assumes negative
 ;assumes that charge and code widths are not variable
 N X,DCHG,CD,IC,PN,H,COL,M,CHK
 S:'$D(GRP) GRP="" S:'$D(CP) CP="" I 'GRP&'CP S X="" G ENDFMT
 S DCHG=10,CD=7,CHK=7,IC=3,M=132
 S:'+GRP GRP=$G(^IBE(350.71,+CP,0)),GRP=$S($P(GRP,"^",4):$P(GRP,"^",4),1:$P($G(^IBE(350.71,+$P(GRP,"^",5),0)),"^",4))
 S X=$G(^IBE(350.7,+GRP,0)),COL=$P(X,"^",3) S:COL="" COL=2
 I X'="" S DCHG=$S($P(X,"^",2):DCHG,1:0),DCHG=DCHG*COL,CD=CD*COL,CHK=CHK*COL
 I X'="" S H=(M-(2*COL*IC)),PN=(H-DCHG-CD-CHK)\COL,H=H\COL
ENDFMT Q $S(X="":X,1:IC_"^"_H_"^"_PN)
 ;
FPO ;
 S X=$$PO(DA,X) Q
 ;
PO(DA,X) ;check that the print order entered has not already been used for the group/sub-header
 ;used to ensure unique print orders within groups and sub-headers
 ; input:  DA - the IFN of the entry being added/edited may be a subheader or procedure
 ;         X  - the print order to check
 ;returns: "" - if bad input or print order already defined
 ;         X  - input value of X if not previously defined for group/sub-header
 I '$D(DA)!('$D(^IBE(350.71,+DA,0)))!('$D(X))!('X) S X="" G ENDPO
 N Y S Y=^IBE(350.71,+DA,0)
 I $P(Y,"^",3)="S",$D(^IBE(350.71,"AG",+$P(Y,"^",4),X)) S X=""
 I $P(Y,"^",3)="P",$D(^IBE(350.71,"AS",+$P(Y,"^",5),X)) S X=""
ENDPO Q X
