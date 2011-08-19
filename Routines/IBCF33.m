IBCF33 ;ALB/ARH - UB-04 CMS-1450 (GATHER CODES) ;25-AUG-1993
 ;;2.0;INTEGRATED BILLING;**52,80,109,51,230,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;IBIFN required
 ;
 ; Not all free text prints in these blocks as of MRA/EDI - only print
 ;   REVENUE CODES and associated data, Rx's and prosthetics
 ;   and last line to indicate multiple pages
 N IBI,IBJ,IBCU2,IBCOL,IBSTATE,IBCBILL,IBINPAT,IBX,IBY,Z,IBZ,IBLPG
 S IBLINES=22,IBCU2=$G(^DGCR(399,IBIFN,"U2")),IBCOL=1,IBNOCOM=0
 K IBXSAVE("RX-UB-04"),IBXSAVE("PROS-UB-04")
 D HOS^IBCEF22(IBIFN)
 ;
 I $$TXMT^IBCEF4(IBIFN) S IBNOCOM=1
 S Z="",IBNOCHG=0
 ; Add total line as last entry, if not already there
 ;S IBLCT=$O(IBXDATA(""),-1)
 ;I IBLCT,$P(IBXDATA(IBLCT),U)'="001" S IBXDATA(IBLCT+1)="001"
 ;S IBLCT=0
 S IBLPG=($O(IBXDATA(""),-1)+$O(IBXSAVE("RX-UB-04",""),-1)+$O(IBXSAVE("PROS-UB-04",""),-1))/22,IBLPG=IBLPG\1+$S($P(IBLPG,".",2):1,1:0)
 F  S Z=$O(IBXDATA(Z)) Q:'Z  D
 . N IBZ1
 . ;I $P(IBXDATA(Z),U)="001",'$O(IBXDATA(Z)) S IBZ="001",$P(IBZ,U,4)=$P(IBCBCOMM,U,1),IBDA=0 S:IBNOCHG $P(IBZ,U,9)=$G(IBNOCHG) S IBXDATA(Z)=IBZ D SET1 Q
 . ;Get modifiers
 . S IBZ1=$G(^DGCR(399,IBIFN,"RC",+$P(IBXDATA(Z),U,8),0)),IBMOD=""
 . I $P(IBZ1,U,6),$S($P(IBZ1,U,10)=4:$P(IBZ1,U,11),1:'$P(IBZ1,U,10)) S $P(IBXDATA(Z),U,9)=$$MOD(IBZ1,IBIFN)
 . S IBZ=$P(IBXDATA(Z),U)_U_$P(IBXDATA(Z),U,3,5)_"^^"_$P(IBXDATA(Z),U,2),$P(IBZ,U,9)=$P(IBXDATA(Z),U,6),$P(IBZ,U,13)=$P(IBXDATA(Z),U,7),$P(IBZ,U,10)=$P(IBXDATA(Z),U,9),$P(IBZ,U,14)=$P(IBXDATA(Z),U,10)
 . I IBZ S IBNOCHG=IBNOCHG+$P(IBXDATA(Z),U,6),IBDA=$P(IBXDATA(Z),U,8) D SET1
 . ;S IBLCT=IBLCT+1
 I $D(IBXSAVE("RX-UB-04"))!$D(IBXSAVE("PROS-UB-04")) D
 . N Z
 . S Z=0 F  S Z=$O(IBXSAVE("RX-UB-04",Z)) Q:'Z  S IBZ=IBXSAVE("RX-UB-04",Z) D SET2
 . S Z=0 F  S Z=$O(IBXSAVE("PROS-UB-04",Z)) Q:'Z  S IBZ=IBXSAVE("PROS-UB-04",Z) D SET2
 D END
 Q
 ;
RV ;rev codes sorted by bedsection - no longer used as of patch IB*2*51
 S (IBBSN,IBBS,IBNOCHG)=0 F  S IBBS=$O(^DGCR(399,IBIFN,"RC","ABS",IBBS)) Q:'IBBS  D
 . S IBRV=0 F  S IBRV=$O(^DGCR(399,IBIFN,"RC","ABS",IBBS,IBRV)) Q:'IBRV  D
 .. S IBDA=0 F  S IBDA=$O(^DGCR(399,IBIFN,"RC","ABS",IBBS,IBRV,IBDA)) Q:'IBDA  D
 ... S IBX=$G(^DGCR(399,IBIFN,"RC",IBDA,0))
 ... S IBZ=$P($G(^DGCR(399.1,+$P(IBX,U,5),0)),U,1) S IBBSN=IBZ,IBZ=IBX,IBNOCHG=IBNOCHG+$P(IBZ,U,9) D SET1
 ;
 ;loop through all rev codes, print those with no bedsection
 S IBDA=0 F  S IBDA=$O(^DGCR(399,IBIFN,"RC",IBDA)) Q:'IBDA  S IBZ=$G(^(IBDA,0)) I +IBZ,$P(IBZ,U,5)="" S IBNOCHG=IBNOCHG+$P(IBZ,U,9) D SET1
 ;
TOTAL ;add total
 ;I +$P(IBCBCOMM,U,2) S IBZ="",$P(IBZ,U,2)="SUBTOTAL",$P(IBZ,U,4)=+$P(IBCBCOMM,U,1) D SET1
 ;
 ;S IBX=$S(+$P(IBCBCOMM,U,2):4,1:2) D SPACE
 S IBX=2 D SPACE
 ;S IBZ="" D SET2
 ;S IBJ=0 F IBI=4,5,6 S IBJ=IBJ+$P(IBCU2,U,IBI)
 ;I +$P(IBCBCOMM,U,2),+$P(IBCBCOMM,U,2)'=IBJ S (IBI,IBZ)="",$P(IBZ,U,2)="LESS "_$P(IBCBCOMM,U,3),$P(IBZ,U,4)=+$P(IBCBCOMM,U,2) D SET1 S IBZ="" D SET2
 ;
 ;S IBZ="001",$P(IBZ,U,2)="TOTAL",$P(IBZ,U,4)=IBCBCOMM-$S(IBI="":$P(IBCBCOMM,U,2),1:0) S:IBNOCHG $P(IBZ,U,9)=$G(IBNOCHG) D SET1
 ;
 ;
CPT ;add additional procedures
 ;G:$G(IBFL(80))'>6 OPV S IBX=+IBFL(80)-4 D SPACE
 ;S IBZ="" D SET2
 ;S IBZ="ADDITIONAL PROCEDURE CODES:" D SET2
 ;S IBI=6 F  S IBI=$O(IBFL(80,IBI)) Q:'IBI  D
 ;. S IBX=$P(IBFL(80,IBI),U,2),IBZ=$E(IBX,1,2)_"/"_$E(IBX,3,4)_"/"_$E(IBX,5,6)_$J(" ",5)_$P(IBFL(80,IBI),U,1) D SET2
 ;
OPV ;add outpatient visit dates
 ;G:'$O(^DGCR(399,IBIFN,"OP",0)) CONT S (IBX,IBY)=0 F  S IBX=$O(^DGCR(399,IBIFN,"OP",IBX)) Q:'IBX  S IBY=IBY+1
 ;S IBX=IBY/3,IBX=IBX\1+$S(+$P(IBX,".",2):1,1:0)+1 D SPACE
 ;S IBZ="" D SET2 S IBZ="OP VISIT DATE(S) BILLED:"_$J(" ",34-24)
 ;S (IBI,IBJ)=0 F  S IBI=$O(^DGCR(399,IBIFN,"OP",IBI)) Q:'IBI  D
 ;. S Y=$G(^DGCR(399,IBIFN,"OP",IBI,0)),IBZ=IBZ_$$FMTE^XLFDT(Y,2)_$S($O(^DGCR(399,IBIFN,"OP",IBI)):", ",1:"")
 ;. S IBJ=IBJ+1 I IBJ>2 D SET2 S IBZ=$J(" ",34),IBJ=0
 ;I $L(IBZ)>34 D SET2
 ;
CONT ;D ^IBCF331 ;More free text - can no longer print on UB-04
 ;
 ; fill in rest of page
END D:'$G(IBNOCOM) FILLPG S $P(^TMP($J,"IBC-RC"),U,2)=0 S IBPG=+$G(^TMP($J,"IBC-RC")),IBX=IBPG/22,IBPG=IBX\1+$S(+$P(IBX,".",2):1,1:0)
 K IBZ,IBBSN,IBBS,IBRV,IBDA,IBLN,IBCOL,IBLINES,IBARRAY,IBNOCHG,IBNOCOM,IBXSAVE("RX-UB-04"),IBXSAVE("PROS-UB-04")
 Q
 ;
SPACE ;checks to see if IBX can fit on page, if not starts new page
 Q:'IBX  N IBLN,IBY S IBLN=+$G(^TMP($J,"IBC-RC")),IBY=IBLN#22 S:IBY=0&(IBLN'=0) IBY=22 I IBX>(IBLINES-IBY) D FILLPG
 Q
 ;
FILLPG ;fill rest of page with blank lines
 N IBI,IBLN,IBZ S IBFILL=1 F IBI=1:1:22 S IBLN=+$G(^TMP($J,"IBC-RC")) Q:'(IBLN#22)  S IBZ="" D FILLUP Q:IBFILL=2
 K IBFILL Q
 ;
SET1 ; add rev codes to array: rev cd ^ rev cd st abbrev. ^ CPT CODE ^ unit charge ^ units ^ total ^ non-cov charge ^ form locator 49 ^ rev code mult ien ^ cpt modifiers attached to revenue code/procedure (unlinked)^ outpt serv date
 ;formats for output into specific column blocks 42-48
 N IBX,IBY,IBLN,IBN,IBMOD
 D NEXTLN S IBY=""
 ;set up rev cd item with appropriate output values, non-rev cd entries for old bills should already be in external form
 S IBN=$P(IBZ,U,9) ;non-covered charges
 S IBMOD=$P(IBZ,U,10) I IBMOD'="" S IBMOD=$E($TR(IBMOD,",;"),1,4) ; cpt modifiers
 I +IBZ S IBX=$G(^DGCR(399.2,+IBZ,0)) Q:IBX=""  D
 . S IBY=$P(IBX,U,1)_U_$P(IBX,U,2)_U_$$PRCD^IBCEF1($P(IBZ,U,6)_";ICPT(")_IBMOD
 . S IBY=IBY_U_$P(IBZ,U,2)_U_$P(IBZ,U,3)_U_$P(IBZ,U,4)_U_IBN_U_$P(IBZ,U,13)_U_$G(IBDA)_U_U_$$DATE^IBCF2($P(IBZ,U,14),"",1)
 I IBY="" S IBY=$P(IBZ,U,1)_U_$P(IBZ,U,2)_U_U_U_$P(IBZ,U,3)_U_$P(IBZ,U,4)_U_IBN_U_$P(IBZ,U,13)_U_$G(IBDA)_U_U_$$DATE^IBCF2($P(IBZ,U,14),"",1)
 S IBLN=+$G(^TMP($J,"IBC-RC"))+1,^TMP($J,"IBC-RC",IBLN)=1_U_IBY,^TMP($J,"IBC-RC")=IBLN I '(IBLN#22) S IBLINES=22
 Q
 ;
SET2 ;set free text into block 42 array
 Q:$G(IBNOCOM)  ;No comments wanted
 N IBLN D NEXTLN S IBCOL=$S('IBCOL:2,1:3)
 S IBLN=+$G(^TMP($J,"IBC-RC"))+1 I IBLN#22=1,$G(IBFILL) S IBFILL=2 Q
 S ^TMP($J,"IBC-RC",IBLN)=IBCOL_U_IBZ,^TMP($J,"IBC-RC")=IBLN I '(IBLN#22) S IBLINES=22
 Q
 ;
FILLUP ; Fill block 42 with blank lines
 N IBLN D NEXTLN S IBCOL=$S('IBCOL:2,1:3)
 S IBLN=+$G(^TMP($J,"IBC-RC"))+1 I IBLN#22=1,$G(IBFILL) S IBFILL=2 Q
 S ^TMP($J,"IBC-RC",IBLN)=IBCOL_U_IBZ,^TMP($J,"IBC-RC")=IBLN I '(IBLN#22) S IBLINES=22
 Q
 ;
NEXTLN ;checks counter for next line, resets if necessary,
 ;ie. if the line # indicated by the next line # var. has already been used then this increments the next line # var.
 S IBLN=+$G(^TMP($J,"IBC-RC"))+1 I $D(^TMP($J,"IBC-RC",IBLN)) S ^TMP($J,"IBC-RC")=IBLN S:'(IBLN#22) IBLINES=22 G NEXTLN
 Q
 ;
MOD(RCLN,IBIFN) ; return modifier(s) for a directly linked CPT charge or for an indirectly linked one
 N IBCPTN,IBMOD
 S IBMOD=""
 I $P($G(RCLN),U,10)=4 S IBCPTN=+$P(RCLN,U,11) I +IBCPTN S IBMOD=$$GETMOD^IBEFUNC(IBIFN,IBCPTN,1) ;Linked
 I IBMOD="",$P(RCLN,U,14)'="" S IBMOD=$TR($P(RCLN,U,14),";",",") ; Not linked or linked, but manually entered modifiers only
MODQ Q IBMOD
 ;
DATE45(IBIFN,IBXDATA,IBDATE) ; What prints in the service date box of UB-04
 ; INPUT:
 ;   IBIFN = ien of bill
 ;   IBDATE = the default outpt service date
 ; OUTPUT:
 ;   IBXDATA = the output formatter array with the service dates
 ;             (pass by reference)
 N Z,Z0,IBR,IBIN
 S IBIN=$$INPAT^IBCEF(IBXIEN,1)
 F Z=1:1 Q:'$D(^TMP($J,"IBC-RC",Z))  S IBR=^(Z) D
 . S Z0=$S(+IBR=1&'IBIN&(+$P(IBR,U,2)'=1):$S($P(IBR,U,12):$P(IBR,U,12),1:$G(IBDATE)),+IBR=2:$E($P(IBR,U,2),46,52),1:$E($P(IBR,U,2),41,47))
 . S:Z'>22 IBXDATA(Z)=Z0 D:Z>22 CKREV^IBCEF3(Z,Z0)
 Q
 ;
