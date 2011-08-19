IBCNES2 ;ALB/ESG - eIV elig/Benefit action protocols ;25-Sept-2009
 ;;2.0;INTEGRATED BILLING;**416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
EBSV ; Action protocol for eIV EB data screen called from view/edit Patient Insurance
 ; Called from the EB-Expand Benefits action on the main list of pt. insurances
 ; User may select multiple insurances from this list.
 ;
 N VALMY,IBXX,IBPPOL,DFN,IBCDFN
 D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)))
 I '$D(VALMY) G EBSVX
 S IBXX=0
 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 . S IBPPOL=$G(^TMP("IBNSMDX",$J,+$O(^TMP("IBNSM",$J,"IDX",IBXX,0))))
 . I IBPPOL="" W !!,"Structure error (EBSV)" D PAUSE^VALM1 Q
 . S DFN=+$P(IBPPOL,U,3)
 . I 'DFN W !!,"System Error: Patient DFN undefined." D PAUSE^VALM1 Q
 . S IBCDFN=+$P(IBPPOL,U,4)
 . I 'IBCDFN W !!,"System Error: pt ins policy ien undefined." D PAUSE^VALM1 Q
 . ;
 . D EB^IBCNES(2.322,IBCDFN_","_DFN_",","A",1,"PT. INS EB DATA")
 . ;
 . Q
EBSVX ;
 S VALMBCK="R"
 Q
 ;
EBAB ; Action protocol for eIV EB data screen called from view/edit Annual Benefits screens
 ; Called from the EB-Expand Benefits action on either the view or edit of Annual
 ; Benefits.
 NEW DFN,IBCDFN
 ;
 D FULL^VALM1
 I $G(IBPPOL)="" W !!,"Expand Benefits is not available here. Use Patient Insurance options." D PAUSE^VALM1 G EBABX
 S DFN=+$P(IBPPOL,U,3)
 I 'DFN W !!,"System Error: Patient DFN undefined." D PAUSE^VALM1 G EBABX
 S IBCDFN=+$P(IBPPOL,U,4)
 I 'IBCDFN W !!,"System Error: pt ins policy ien undefined." D PAUSE^VALM1 G EBABX
 ;
 D EB^IBCNES(2.322,IBCDFN_","_DFN_",","A",1,"PT. INS ANN BEN EB DATA")
 ;
EBABX ;
 S VALMBCK="R"
 Q
 ;
EBVP ; Action protocol for eIV EB data screen called from VP screen in pt. insurance - 
 ; Expanded policy information
 NEW DFN,IBCDFN
 D FULL^VALM1
 I $G(IBPPOL)="" W !!,"Structure error (EBVP)" D PAUSE^VALM1 G EBVPX
 S DFN=+$P(IBPPOL,U,3)
 I 'DFN W !!,"System Error: Patient DFN undefined." D PAUSE^VALM1 G EBVPX
 S IBCDFN=+$P(IBPPOL,U,4)
 I 'IBCDFN W !!,"System Error: pt ins policy ien undefined." D PAUSE^VALM1 G EBVPX
 ;
 D EB^IBCNES(2.322,IBCDFN_","_DFN_",","A",1,"PT. INS VIEW POLICY EB DATA")
 ;
EBVPX ;
 S VALMBCK="R"
 Q
 ;
EBJT ; Action protocol for eIV EB data screen called from Third Party Joint Inquiry,
 ; TPJI, main Claim Information screen
 NEW IBX,IBJPOL,X,Y,DIRUT,DTOUT,DUOUT,DIROUT
 D FULL^VALM1
 I '$G(IBIFN)!'$G(DFN) W !!,"Claim or Patient not defined." D PAUSE^VALM1 G EBJTX
 S IBX=$$PST^IBJTU31(IBIFN)
 I 'IBX,$D(DIRUT) G EBJTX
 I 'IBX W !!,"Insurance data incomplete, cannot find policy." D PAUSE^VALM1 G EBJTX
 S IBJPOL=+IBX
 D EB^IBCNES(2.322,IBJPOL_","_DFN_",","A",1,"TPJI CLAIM INFO EB DATA")
EBJTX ;
 S VALMBCK="R"
 Q
 ;
