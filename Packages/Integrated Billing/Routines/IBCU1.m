IBCU1 ;ALB/MRL - BILLING UTILITY ROUTINE (CONTINUED) ;01 JUN 88 12:00
 ;;2.0;INTEGRATED BILLING;**27,52,106,138,51,182,210,266,309,320,347,405**;21-MAR-94;Build 4
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;MAP TO DGCRU1
 ;
 ;procedure doesn't appear to be used (6/4/93), if it is used, what for??
 ;where would multiple provider numbers comde from?  ARH
 ;BCH    ;Blue Cross/Shield Help
 W ! S IB01=$P($G(^IBE(350.9,1,1)),"^",6)
 I IB01]"" W "CHOOSE FROM",!!?4,"1 - ",$P(IB01,"^",6) F IB00=2,3 I $P(IB01,"^",$S(IB00=2:14,1:15))]"" W !?4,IB00," - ",$P(IB01,"^",$S(IB00=2:14,1:15))
 W:IB01']"" "NO BLUE CROSS/SHIELD PROVIDER NUMBERS IDENTIFIED TO SELECT FROM!" W ! W:IB01]"" !,"OR " W "ENTER BLUE CROSS/SHIELD PROVIDER # (BETWEEN 3-13 CHARACTERS)",! K IB00,IB01 Q
 ;
RCD ;Revenue Code Display
 Q:'$D(^DGCR(399,IBIFN,"RC"))
 W @IOF,!,"Revenue Code Listing",?34,"Units",?45,"Charge" W:$$FT^IBCEF(IBIFN)=3 ?56,"Non-Cov"
 S DGIFN=0 F IBI=0:0 S DGIFN=$O(^DGCR(399,IBIFN,"RC",DGIFN)) Q:'DGIFN  I $D(^DGCR(399,IBIFN,"RC",DGIFN,0)) S Z=^(0) D DISRC
 W !
 I $D(DIC(0)) S DIC(0)=DIC(0)_"N"
 Q
DISRC N Z0 W !?1,DGIFN,?4,$P(^DGCR(399.2,+Z,0),"^"),"-",$E($P(^DGCR(399.2,+Z,0),"^",2),1,19)
 I +$P(Z,U,6) W ?28,$P($$CPT^ICPTCOD(+$P(Z,U,6)),U,2)
 W ?36,$P(Z,"^",3),?40 S X=$P(Z,"^",2),X2="2$" D COMMA^%DTC W X
 I $$FT^IBCEF(IBIFN)=3,$P(Z,U,9)'="" S X=$P(Z,U,9),X2="2$" D COMMA^%DTC W ?51,X
 I $D(^DGCR(399.1,+$P(Z,"^",5),0)) W ?64,$E($P(^(0),"^"),1,15)
 I $S($P(Z,U,15):1,1:$P(Z,U,10)=3) D
 . W !,?5,"(Rx: ",$S($P(Z,U,11):$P($G(^IBA(362.4,$P(Z,U,11),0)),U),1:"Link Missing"),"  Procedure "_$S($P(Z,U,15):"#"_$P(Z,U,15)_" "_$$CPTNM^IBCRBH1(IBIFN,4,$P(Z,U,15)),1:"Link Missing"),")"
 Q
 ;
RVCPRC(IBIFN,IBD0) ; returns 1 if CHAMPVA rate type + 2 if CMS-1500, 0 otherwise
 ; IBD0 - zero node of bill if available, not required
 N X S X=0
 I $G(IBD0)="" S IBD0=$G(^DGCR(399,+$G(IBIFN),0))
 I $P($G(^DGCR(399.3,+$P(IBD0,U,7),0)),U,1)="CHAMPVA" S X=X+1
 I $P(IBD0,U,19)=2 S X=X+2
 Q X
 ;
ORDNXT(IFN) ;CALLED BY TRIGGER ON (362.3,.02) THAT SETS DX PRINT ORDER (362.3,.03),
 ;returns the highest print order used on the bill plus 3, returns 3 if no existing print order
 ;used for the default print order so that dx's can be printed in order of entry without any input by the user,
 ;3 is added to allow spaces for additions, changes, moves
 N X,Y S X="" I $D(^DGCR(399,+$G(IFN),0)) S X=3,Y=0 F  S Y=$O(^IBA(362.3,"AO",+IFN,Y)) Q:'Y  S X=Y+3
 Q X
 ;
ORDDUP(ORD,DIFN) ;returns true if print order ORD is already defined for a bill (not same entry)
 N IBX,IBY S IBY=0
 I +$G(ORD) S IBX=$G(^IBA(362.3,+$G(DIFN),0)) I +IBX,+$P(IBX,U,3)'=ORD,$D(^IBA(362.3,"AO",+$P(IBX,U,2),+ORD)) S IBY=1
 Q IBY
 ;
DXDUP(DX,DIFN,IFN) ;returns true if DX is already defined for a bill (not same entry)
 ;either DIFN or IFN can be passed, both are not needed, DIFN is needed during edit so can reenter the same dx
 N IBX,IBY S IBY=0 I +$G(DX),'$G(IFN) S IBX=$G(^IBA(362.3,+$G(DIFN),0)),IFN=+$P(IBX,U,2)
 I +$G(DX),$D(^IBA(362.3,"AIFN"_+IFN,+DX)),$O(^IBA(362.3,"AIFN"_+IFN,+DX,0))'=+$G(DIFN) S IBY=1
 Q IBY
 ;
DXBSTAT(DIFN,IFN) ;returns a diagnosis' bill status (either DIFN or IFN can be passed, both are not needed)
 N IBX,IBY I '$G(IFN) S IBX=$G(^IBA(362.3,+$G(DIFN),0)),IFN=+$P(IBX,U,2)
 S IBY=+$P($G(^DGCR(399,+IFN,0)),U,13)
 Q IBY
 ;
RXSTAT(DRUG,PIFN,FILLDT) ; returns status/definition of rx
 ; returns: ORIGINAL ^ RELEASED/RETURNED TO STOCK ^ DRUG DEA
 N IBX,IBY,IBZ,IBLN,IBNUM S IBLN="",DRUG=+$G(DRUG),PIFN=+$G(PIFN),FILLDT=+$G(FILLDT)
 ;
 S IBX=$$RXSEC^IBRXUTL($$FILE^IBRXUTL(PIFN,2),PIFN),IBZ="" I IBX'="",$P(IBX,U,2)=$G(FILLDT) D  I IBZ'="" S $P(IBLN,U,2)=IBZ
 . S IBLN="ORG"
 . ;I +$G(^PS(59.7,1,49.99))<6 Q
 . I '$P(IBX,U,13) S IBZ="NR"
 . I +$P(IBX,U,15) S:IBZ'="" IBZ=IBZ_"-" S IBZ=IBZ_"RTS"
 ;
 I IBLN="" S IBNUM=$$RFLNUM^IBRXUTL(PIFN,FILLDT,1),IBX=$$ZEROSUB^IBRXUTL($$FILE^IBRXUTL(PIFN,2),PIFN,IBNUM),IBZ="" I IBX'="" D  I IBZ'="" S $P(IBLN,U,2)=IBZ
 . ;I +$G(^PS(59.7,1,49.99))<6 Q
 . I '$P(IBX,U,18) S IBZ="NR"
 . I +$P(IBX,U,16) S:IBZ'="" IBZ=IBZ_"-" S IBZ=IBZ_"RTS"
 ;
 D ZERO^IBRXUTL(DRUG)
 S IBX=$G(^TMP($J,"IBDRUG",0)) I IBX'="" S IBY=$G(^TMP($J,"IBDRUG",DRUG,3)),IBZ="" D  I IBZ'="" S $P(IBLN,U,3)=IBZ
 . I IBY["9" S IBZ="OTC"
 . I IBY["I" S:IBZ'="" IBZ=IBZ_"-" S IBZ=IBZ_"INV"
 . I IBY["S" S:IBZ'="" IBZ=IBZ_"-" S IBZ=IBZ_"SUP"
 . I IBY["N" S:IBZ'="" IBZ=IBZ_"-" S IBZ=IBZ_"NUT"
 K ^TMP($J,"IBDRUG")
 Q IBLN
 ;
PRVLIC(NPIFN,IBDT,ARR,STIFN) ; returns the Provider License data from the New Person file active on a date
 ; Input:   NPIFN = pointer to file 200,              IBDT = date to check (if none passed then all returned)
 ;          ARR = array pass by reference (optional), STIFN = state to return as value of function (optional)
 ; Output:  ARR(X) = license state (ifn) ^ license ^ expiration date (200,541)
 ;          return value = license data of state requested or if no state passed in then count found
 N IBX,IBY,IBLN,IBCNT S IBX=0,IBCNT=0 K ARR
 I +$G(NPIFN) S IBY=0 F  S IBY=$O(^VA(200,NPIFN,"PS1",IBY)) Q:'IBY  D
 . S IBLN=$G(^VA(200,NPIFN,"PS1",IBY,0))
 . I +$G(IBDT),+$P(IBLN,U,3),$P(IBLN,U,3)<IBDT Q
 . I +$G(STIFN),+STIFN=+IBLN S IBX=IBLN
 . S IBCNT=IBCNT+1,ARR(IBCNT)=IBLN
 S ARR=IBCNT I '$G(STIFN) S IBX=IBCNT
 Q IBX
 ;
DELPR(IB,IBX) ; Deletes the corresponding RX proc when the RX pointer is
 ; deleted
 ; IB = the ien of the bill in file 399
 ; IBX = the ien of the entry in the procedure multiple to be deleted
 ;
 N DA,DIK,X,Y
 S DA(1)=IB,DA=IBX
 I $D(^DGCR(399,DA(1),"CP",DA,0)) S DIK="^DGCR(399,"_DA(1)_",""CP""," D ^DIK
 Q
 ;
MODHLP(DA) ; Executable modifier help 399.042  .14
 ; DA = iens of the current entry DA(1) = file 399 ien
 ;                                DA    = file 399.042 ien
 N Z,IBZ,DIC,IBDATE
 S IBDATE=$$BDATE^IBACSV(+$G(DA(1))) ; The date of service
 I $P($G(^DGCR(399,+$G(DA(1)),"RC",+$G(DA),0)),U,14)'="" S Z=$P(^(0),U,14) D
 . N Q
 . S Q=1
 . S IBZ(1)="Current modifier"_$S($P(Z,";",2)'="":"s are:",1:"is:")
 . I $P(Z,";")'="" S Q=Q+1,IBZ(Q)="  "_$P(Z,";")_"  "_$P($$MOD^ICPTMOD($P(Z,";"),"E",IBDATE),U,3)
 . I $P(Z,";",2)'="" S Q=Q+1,IBZ(Q)="  "_$P(Z,";",2)_"  "_$P($$MOD^ICPTMOD($P(Z,";",2),"E",IBDATE),U,3)
 . S Q=Q+1,IBZ(Q)=" "
 . D EN^DDIOL(.IBZ)
 ;
 S DIC="^DIC(81.3,",DIC(0)="E"
 S DIC("S")="I $$MODP^ICPTMOD($P($G(^DGCR(399,DA(1),""RC"",DA,0)),U,6),Y,""I"",IBDATE)>0"
 S DIC("W")="W ?14,$P($$MOD^ICPTMOD(Y,""I"",IBDATE),U,3)"
 D ^DIC
 Q
 ;
QMED(IBRTN,IBIFN) ; DSS QuadraMed Interface: DSS/QuadraMed Available
 ; return 1 if QuadraMed Interface is On and available for the type of bill
 ; - routine must exist on the system (interface is 'On')
 ; Input: IBRTN = tag^routine, if it exists then Interface is 'On'
 ;        IBIFN = Bill IFN, bill to check if appropriate for sending to QuadraMed
 ;
 N IBON S IBON=0
 I +$G(IBIFN),$G(IBRTN)'="",$T(@IBRTN)'="" S IBON=1
 Q IBON
 ;
ATTREND(IBIFN,IBIFN1,FIELD) ; This function is called from Mumps Cross References in the claim file 399 and 
 ; also the PROVIDER subfile 399.0222.
 ;
 ; IBIFN = IEN to claim file
 ; IBIFN1 = IEN to provider sub-file in claim file
 ; FIELD = Field in sub-file being modified (the triggering event).  If field has no value, all 6 fields are
 ; possibly updated
 ;  
 ; The following fields are the "triggering" events
 ; File 399
 ; #19 FORM TYPE - This triggers all 6 fields (122, 123, 124, 128, 129, 130).
 ; 
 ; Sub-File 399.0222
 ; #.05 PRIMARY INS CO ID NUMBER triggers 122
 ; #.06 SECONDARY INS CO ID NUMBER triggers 123
 ; #.07 TERTIARY INS CO ID NUMBER triggers 124
 ; #.12 PRIM INS PROVIDER ID TYPE triggers 128
 ; #.13 SEC INS PROVIDER ID TYPE triggers 129
 ; #.14 TERT INS PROVIDER ID TYPE triggers 130
 ; 
 ; The following fields are the ones being "triggered"
 ; #122 PRIMARY PROVIDER #
 ; #123 SECONDARY PROVIDER #
 ; #124 TERTIARY PROVIDER #
 ; #128 PRIMARY ID QUALIFER
 ; #129 SECONDARY ID QUALIFIER
 ; #130 TERTIARY ID QUALIFIER
 ;
 Q:$G(IBPRCOB)  ; this is set when creating an MRA scondary claim.  Don't want to be changing the data on
 ; a secondary claim
 ;
 N FT,DATA,I,PC,INS,IFUNC,ATTRENDD,IBDR
 S FT=$$FT^IBCEF(IBIFN)
 Q:'FT
 ;
 S IFUNC=$O(^DGCR(399,IBIFN,"PRV","B",$S(FT=3:4,1:3),""))
 I $G(IBIFN1),$G(IFUNC)'=IBIFN1 Q   ; if called from subfile, quits if att/rend provider was not the one being modified
 S ATTRENDD=$S('$G(IFUNC):"",1:$G(^DGCR(399,IBIFN,"PRV",IFUNC,0)))
 ;
 S PC=$S(FT=2:6,FT=3:8,1:"")  ; get the correct piece from the ins co dictionary
 Q:'+PC
 ;
 F I="I1","I2","I3" D
 . S INS=$P($G(^DGCR(399,IBIFN,I)),U)
 . Q:'+INS
 . Q:'$P($G(^DIC(36,INS,4)),U,PC)
 . D:I="I1"
 .. S:".05"[FIELD IBDR(399,IBIFN_",",122)=$S($P(ATTRENDD,U,5)]"":$P(ATTRENDD,U,5),1:"@")
 .. S:".12"[FIELD IBDR(399,IBIFN_",",128)=$S($P(ATTRENDD,U,12)]"":$P(ATTRENDD,U,12),1:"@")
 . D:I="I2"
 .. S:".06"[FIELD IBDR(399,IBIFN_",",123)=$S($P(ATTRENDD,U,6)]"":$P(ATTRENDD,U,6),1:"@")
 .. S:".13"[FIELD IBDR(399,IBIFN_",",129)=$S($P(ATTRENDD,U,13)]"":$P(ATTRENDD,U,13),1:"@")
 . D:I="I3"
 .. S:".07"[FIELD IBDR(399,IBIFN_",",124)=$S($P(ATTRENDD,U,7)]"":$P(ATTRENDD,U,7),1:"@")
 .. S:".14"[FIELD IBDR(399,IBIFN_",",130)=$S($P(ATTRENDD,U,14)]"":$P(ATTRENDD,U,14),1:"@")
 ;
 I $O(IBDR(0)) D FILE^DIE("","IBDR")
 Q
