IB20P388 ;OAK/ELZ - POST INIT ROUTINE FOR IB*2*388 ;12/19/2007
 ;;2.0;INTEGRATED BILLING;**388**;21-MAR-94;Build 5
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
POST ; Post init to edit 364.7 and update the Format Code
 ;
 N IBL,IBM,IBX,IB353,IB3646,IB3645,IB3647
 ;
 S IBL=0 D M(""),M("  IB*2*388 Post-Install Starting ....."),M(""),MES^XPDUTL(.IBM) K IBM S IBL=0
 ;
 ; ^IBE(353,"B","CMS-1500",0)
 ;        BILL FORM: CMS-1500
 ;        NATIONAL FORM: YES
 S IBX=0 F  S IBX=$O(^IBE(353,"B","CMS-1500",IBX)) Q:'IBX  I $P($G(^IBE(353,IBX,2)),"^",4) S IB353=IBX Q
 I '$G(IB353) D M(""),M("          ***** Post-Install ERROR *****"),M("  -Cannot find National CMS-1500 form in file 353!!!"),M(""),MES^XPDUTL(.IBM) Q
 ;
 ;
 ; ^IBA(364.6,"C","SERVICE FAC NPI (BX-32A)",0)
 ;        BILL FORM: CMS-1500
 ;        SECURITY LEVEL: NATIONAL,NO EDIT
 S IBX=0 F  S IBX=$O(^IBA(364.6,"C","SERVICE FAC NPI (BX-32A)",IBX)) Q:'IBX  I $P($G(^IBA(364.6,IBX,0)),"^",1,2)=(IB353_"^N") S IB3646=IBX Q
 I '$G(IB3646) D M(""),M("          ***** Post-Install ERROR *****"),M("  -Cannot find National SERVICE FAC NPI (BX-32A) in file 364.6!!!"),M(""),MES^XPDUTL(.IBM) Q
 ;
 ;
 ; ^IBA(364.5,"B","N-RENDERING INSTITUTION",0)
 ;        SECURITY LEVEL: NATIONAL,NO EDIT
 S IBX=0 F  S IBX=$O(^IBA(364.5,"B","N-RENDERING INSTITUTION",IBX)) Q:'IBX  I $P($G(^IBA(364.5,IBX,0)),"^",2)="N" S IB3645=IBX Q
 I '$G(IB3645) D M(""),M("          ***** Post-Install ERROR *****"),M("  -Cannot find National N-RENDERING INSTITUTION in file 364.5!!!"),M(""),MES^XPDUTL(.IBM) Q
 ;
 ;
 ; ^IBA(364.7,"B",364.6 entry
 ;        SECURITY LEVEL: NATIONAL,NO EDIT
 ;        DATA ELEMENT: N-RENDERING INSTITUTION
 S IBX=0 F  S IBX=$O(^IBA(364.7,"B",IB3646,IBX)) Q:'IBX  I $P($G(^IBA(364.7,IBX,0)),"^",2,3)=("N^"_IB3645) S IB3647=IBX Q
 I '$G(IB3647) D M(""),M("          ***** Post-Install ERROR *****"),M("  -Cannot find National SERVICE FAC NPI (BX-32A) in file 364.7!!!"),M(""),MES^XPDUTL(.IBM) Q
 ;
 ; set in format code
 S ^IBA(364.7,IB3647,1)=$P($T(CODE+1),";",3,99)
 ;
 ;
 D M("  Format code updated in 364.7 for National SERVICE FAC NPI (BX-32A)"),M(" ")
 D MES^XPDUTL(.IBM) K IBM S IBL=0
 ;
 D M("  IB*2*388 Post-Install Done .....")
 D MES^XPDUTL(.IBM)
 ;
 Q
 ;
M(Y) ; sets up messages
 ; Y = text to set up
 S IBL=IBL+1,IBM(IBL)=Y
 Q
 ;
CODE ; new format code for 364.7 entry
 ;;N IBZ,IBZ1 S IBZ=$P(IBXDATA,U,2),IBZ1="" D F^IBCEF("N-ORGANIZATION NPI CODES","IBZ1",,IBXIEN) S IBXDATA=$S($$ISRX^IBCEF1(IBXIEN):$P(IBZ1,U,3),IBZ=1:$P(IBZ1,U,2),IBZ=0:$P(IBZ1,U),1:$P(IBZ1,U,3)),IBXSAVE("NPISVC")=IBXDATA
 ;;
