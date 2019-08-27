IB20P644 ;ALB/CXW - POST INIT ROUTINE FOR IB*2.0*644 ;04/01/2019
 ;;2.0;INTEGRATED BILLING;**644**;21-MAR-94;Build 4
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POST ; post init to update Format Code for Billing Provider Name (FL-1/1) in the #364.7 file
 N IBZ,U S U="^"
 D MSG("    IB*2.0*644 Post-Install starts .....")
 D MSG(""),UPDATE,MSG("")
 D MSG("    IB*2.0*644 Post-Install is complete.")
 Q
 ;
UPDATE ; Format Code updates based on output formatter files
 N IBCODE,IBX,IB353,IB353EN,IB3645,IB3645EN,IB3646,IB3646EN,IB3647EN,DA,DIE,DR,X,Y
 S (IB353EN,IB3645EN,IB3646EN,IB3647EN)=0
 S IB353="UB-04"
 S IBX=0 F  S IBX=$O(^IBE(353,"B",IB353,IBX)) Q:'IBX  I $P($G(^IBE(353,IBX,2)),U,4) S IB353EN=IBX Q
 I 'IB353EN D MSG(" >> ERROR: cannot find National "_IB353_" bill form in the #353 file") Q
 S IB3646="BILLING PROVIDER NAME (FL-1/1)"
 S IBX=0 F  S IBX=$O(^IBA(364.6,"C",IB3646,IBX)) Q:'IBX  I $P($G(^IBA(364.6,IBX,0)),U,1,2)=(IB353EN_"^N") S IB3646EN=IBX Q
 I 'IB3646EN D MSG(" >> ERROR: cannot find National "_IB3646_" field in the #364.6 file") Q 
 S IB3645="N-BILLING PROVIDER"
 S IBX=0 F  S IBX=$O(^IBA(364.5,"B",IB3645,IBX)) Q:'IBX  I $P($G(^IBA(364.5,IBX,0)),U,2)="N" S IB3645EN=IBX Q
 I 'IB3645EN D MSG(" >> ERROR: cannot find National "_IB3645_" field in the #364.5 file") Q
 S IBX=0 F  S IBX=$O(^IBA(364.7,"B",IB3646EN,IBX)) Q:'IBX  I $P($G(^IBA(364.7,IBX,0)),U,2,3)="N^"_IB3645EN S IB3647EN=IBX Q
 I 'IB3647EN D MSG(" >> ERROR: cannot find National "_IB3646_" field in the #364.7 file") Q
 S IBCODE=$P($T(CODE+1),";",3)
 I $G(^IBA(364.7,IB3647EN,1))=IBCODE D MSG("  Format code has already been updated for National "_IB3646_" in the #364.7 file!") Q
 ;
 ; set in format code 
 S DA=IB3647EN,DIE="^IBA(364.7,",DR="1///"_IBCODE D ^DIE
 ;
 D MSG("  Format code updated for National "_IB3646_" in the #364.7 file!")
 Q
 ;
MSG(IBZ) ;
 D MES^XPDUTL(IBZ) Q
 ;
CODE ; format code - IA#2171 $$BNIEN^XUAF4 
 ;;S IBXSAVE("BPDATA")=IBXDATA,IBXDATA=$$BNIEN^XUAF4(+IBXSAVE("BPDATA")) S:IBXDATA="" IBXDATA=$$GETFAC^IBCEP8(+IBXSAVE("BPDATA"),0,0)
 ;;
