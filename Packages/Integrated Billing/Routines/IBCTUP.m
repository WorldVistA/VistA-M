IBCTUP ;ALB/RTW - CT ENTRY INACTIVATION IN FILE #356;09/26/2022
 ;;2.0;INTEGRATED BILLING;**740**;21-MAR-94;Build 9
 ;inactivate CT entries from the first episode date to 12/31/1999   
 ;CT entries will be dropped from auto biller list in IB MT NIGHT COMP
 ;ITSM Incident ticket ,INC24030981 
 ;
 Q
EN ;begin process of finding and inactivating CT entry by episode date
 ; 
 N IBCNT,IBCM,IBTOL,IBTYP,IBEABS,IBEABN,IBTRN,IBTRND,IBZ,U,DA,DR,DIE,X,Y
 S U="^",(IBCNT,IBTOL)=0
 S IBEABS=$O(^IBT(356,"D","")),IBEABS=$$FMTE^XLFDT($P(IBEABS,".",1))
 S IBCM="Inactivated to correct errors in the IB MT Night Comp job."
 D MSG("    Inactivating CT entry with episode date, "_IBEABS_" through Dec 31,1999...")
 D MSG("")
 S IBTYP=$O(^IBE(356.6,"B","OUTPATIENT VISIT",0))
 I 'IBTYP D MSG(" >>>>> No outpatient visit type defined, no inactivation!") G END
 S IBEABS="",IBEABN=2991231.999999
 F  S IBEABS=$O(^IBT(356,"D",IBEABS)) Q:(IBEABS="")!(IBEABS>IBEABN)  D
 . S IBTRN=0 F  S IBTRN=$O(^IBT(356,"D",IBEABS,IBTRN)) Q:'IBTRN  D
 .. S IBTRND=$G(^IBT(356,IBTRN,0)) Q:IBTRND=""
 .. S IBTOL=IBTOL+1
 .. ;outpatient visit only
 .. I $P(IBTRND,U,18)'=IBTYP Q
 .. ;early auto bill date only
 .. I $P(IBTRND,U,17)="" Q
 .. ;inactive status, delete eabd date, add comment
 .. S DIE="^IBT(356,",DA=IBTRN,DR=".2///0"_";.17///@"_";1.08///"_IBCM D ^DIE
 .. S IBCNT=IBCNT+1
END D MSG(" Total "_IBCNT_" out of "_IBTOL_" CT entries inactivated in the CLAIMS TRACKING file (#356)")
 D MSG("")
 D MSG("    Inactivating CT entry is complete.")
 Q
MSG(IBZ) ;
 D MES^XPDUTL(IBZ)
 Q
