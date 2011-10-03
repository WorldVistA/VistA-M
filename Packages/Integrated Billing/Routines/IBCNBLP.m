IBCNBLP ;ALB/ARH-Ins Buffer: LM buffer process screen ;1 Jun 97
 ;;2.0;INTEGRATED BILLING;**82**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; - main entry point for screen
 D EN^VALM("IBCNB INSURANCE BUFFER PROCESS")
 Q
 ;
HDR ;  header code for list manager display
 N IBX,IB0,IBY,VADM,VA,VAERR S IBX=""
 I +DFN D DEM^VADPT S IBX=$E(VADM(1),1,28),IBX=IBX_$J("",35-$L(IBX))_$P(VADM(2),U,2)_"    DOB: "_$P(VADM(3),U,2)_"    AGE: "_VADM(4)
 S VALMHDR(1)=IBX
 S VALMHDR(2)=" "
 S IB0=$G(^IBA(355.33,IBBUFDA,21))
 S IBY=$E($P(IB0,U,4),1,13),IBX=$P($G(^DIC(5,+$P(IB0,U,5),0)),U,2),IBY=IBY_$S(IBY'=""&(IBX'=""):", ",1:"")_IBX
 S IBY=$E($P(IB0,U,1),1,20)_$S(IBY'="":", ",1:"")_IBY,IBY=$S(IBY'="":"   ("_IBY_")",1:"")
 S IBX=$E($P($G(^IBA(355.33,IBBUFDA,20)),U,1),1,18)_IBY,IBX=$J("",40-($L(IBX)\2))_IBX
 S VALMHDR(3)=IBX
 I +$G(IBCNSCRN) D GRPHDR(IBBUFDA) Q
 D PATHDR(IBBUFDA)
 Q
 ;
INIT ;  initialization for list manager list, ifn of record to display required IBBUFDA
 K ^TMP("IBCNBLP",$J),^TMP("IBCNBLPX",$J) N IBINSDA
 I '$G(IBBUFDA) S VALMQUIT="" Q
 S IBINSDA=+$G(IBCNSCRN)
 S DFN=+$G(^IBA(355.33,IBBUFDA,60))
 D BLD
 Q
 ;
HELP ;  list manager help
 D FULL^VALM1
 W !!,"This screen displays a summary of the chosen Buffer entry in the header."
 W !!,"The list portion of the screen may display either:"
 W !,?5,"1) a list of all of the patient's current and past insurance policies,"
 W !,?8,"followed by a list of any Group/Plan that has a Group Name or ",!,?8,"Group Number that may match the Buffer entry's."
 W !,?5,"2) a list of all of the Group/Plans for a user specified insurance company."
 W !!,"Use the 'Insurance Co/Patient' action to toggle between these two screens."
 W !!,"Flags:  '~'  company/group is inactive     '-'  individual patient policy"
 W !!,"Bold Data:  If one of the following Buffer File entry data elements matches all",!,"or the first part of the "
 W "corresponding data element of the policy or group/plan",!,"being displayed then the matching part of the data element will be displayed in",!,"bold characters:"
 W !," Subscriber Id, Insurance Company Name, Group Number, Group Name, Type of Plan"
 W !!,"Bold Number:  On the Group/Plan lists, the number preceding the group/plan being",!,"displayed will be in bold if the patient is already a member of that plan."
 W !!,"The IB INSURANCE SUPERVISOR key is required to either Accept or Reject an entry."
 D PAUSE^VALM1 S VALMBCK="R"
 Q
 ;
EXIT ;  exit list manager option and clean up
 K ^TMP("IBCNBLP",$J),^TMP("IBCNBLPX",$J),DFN,IBCNSCRN
 D CLEAR^VALM1
 Q
 ;
BLD ;  build screen display
 ;
 N PATCMP,GRPCMP,CNT S VALMCNT=0,CNT=0
 ;
 S PATCMP=$$PATDATA(IBBUFDA),GRPCMP=$$GRPDATA(IBBUFDA)
 ;
 I +$G(IBCNSCRN) D GRPLST^IBCNBLP1(.CNT,IBINSDA,DFN,GRPCMP) Q
 ;
 D PATLST^IBCNBLP1(.CNT,DFN,PATCMP)
 D SRCHLST^IBCNBLP1(.CNT,DFN,$P(PATCMP,U,1),$P(GRPCMP,U,1),$P(GRPCMP,U,2))
 Q
 ;
DATE(X) ;
 N Y S Y="" I X?7N.E S Y=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 Q Y
 ;
 ;
PATHDR(IBBUFDA) ; additional header lines:  display buffer entry for display of existing patient's insurance screen
 Q:'IBBUFDA  N IBX,IBY,IB20,IB40,IB60 S IBX=""
 S IB20=$G(^IBA(355.33,IBBUFDA,20)),IB40=$G(^IBA(355.33,IBBUFDA,40)),IB60=$G(^IBA(355.33,IBBUFDA,60))
 ;
 S IBX="" I 'IB40 S IBY="-" S IBX=$$SETSTR^VALM1(IBY,IBX,4,1)
 S IBY=$P(IB20,U,1) S IBX=$$SETSTR^VALM1(IBY,IBX,5,18)
 S IBY=$P(IB40,U,3) S IBX=$$SETSTR^VALM1(IBY,IBX,25,13)
 S IBY=$P(IB60,U,4) S IBX=$$SETSTR^VALM1(IBY,IBX,40,13)
 S IBY=$P(IB60,U,6),IBY=$$EXPAND^IBTRE(355.33,60.06,IBY) S IBX=$$SETSTR^VALM1(IBY,IBX,55,6)
 S IBY=$$DATE($P(IB60,U,2)) S IBX=$$SETSTR^VALM1(IBY,IBX,63,8)
 S IBY=$$DATE($P(IB60,U,3)) S IBX=$$SETSTR^VALM1(IBY,IBX,73,8)
 S VALMHDR(4)=IBX
 Q
 ;
GRPHDR(IBBUFDA) ; additional header lines:  display buffer entry for display of other insurance group plans screen
 Q:'IBBUFDA  N IBX,IBY,IB40 S IBX=""
 S IB40=$G(^IBA(355.33,IBBUFDA,40))
 ;
 S IBX="" I 'IB40 S IBY="-" S IBX=$$SETSTR^VALM1(IBY,IBX,5,1)
 S IBY=$P(IB40,U,2) S IBX=$$SETSTR^VALM1(IBY,IBX,6,20)
 S IBY=$P(IB40,U,3) S IBX=$$SETSTR^VALM1(IBY,IBX,30,17)
 S IBY=$P(IB40,U,9) I +IBY S IBY=$P($G(^IBE(355.1,+IBY,0)),U,1) S IBX=$$SETSTR^VALM1(IBY,IBX,50,30)
 S VALMHDR(4)=IBX
 Q
 ;
PATDATA(IBBUFDA) ; create string of data from buffer entry to compare with data in existing insurance entries
 ; for the patient insurance list compare:  INS COMPANY NAME ^ GROUP NUMBER ^ SUBSCRIBER ID
 N IBX S IBX=$P($G(^IBA(355.33,IBBUFDA,20)),U,1)_U_$P($G(^IBA(355.33,IBBUFDA,40)),U,3)_U_$P($G(^IBA(355.33,IBBUFDA,60)),U,4)
 Q IBX
 ;
GRPDATA(IBBUFDA) ; create string of data from buffer entry to compare with data in existing insurance entries
 ; for the group plan list compare:  GROUP NAME ^ GROUP NUMBER ^ TYPE OF PLAN
 N IBX,IBY S IBY=$G(^IBA(355.33,IBBUFDA,40)) S IBX=$P(IBY,U,2)_U_$P(IBY,U,3)_U_$P($G(^IBE(355.1,+$P(IBY,U,9),0)),U,1)
 Q IBX
