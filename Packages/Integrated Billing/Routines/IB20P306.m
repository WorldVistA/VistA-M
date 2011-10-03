IB20P306 ;ALB/CXW-FY05 DSS CLINIC STOP CODES IB*2.0*306 POST INIT ;10-MAY-05
 ;;2.0;INTEGRATED BILLING;**306**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
POST ;
 D MES^XPDUTL("Now adding entries of NON-BILLABLE type codes to file 352.5")
 I $$PATCH^XPDUTL("IB*2.0*306") D BMES^XPDUTL("  Skipping since the patch was previously installed.") Q
 N IBEFFDT,U
 S U="^",IBEFFDT=3050502 ;effective date MAY 2, 2005 
 D START,FNONB(IBEFFDT),FINISH
 Q
 ;
START D MES^XPDUTL("")
 D MES^XPDUTL("FY05 DSS Clinic Stop Codes, Post-Install Starting")
 Q
 ;
FINISH ;
 D MES^XPDUTL("")
 D MES^XPDUTL("FY05 DSS Clinic Stop Codes, Post-Install Complete")
 Q
 ;
FNONB(IBEFFDT) ;
 ;update billable type (add a new entry with new type if code exists)
 ;
 N Y,IBC,IB1,IBT,IBX,IBCODE,IBDES,IBOVER,IBLSTDT
 S IBC=0
 F IBX=1:1 S IBT=$P($T(BTYPE+IBX),";",3) Q:'$L(IBT)  D
 . S IBCODE=+$P(IBT,"^",1)
 . I $D(^IBE(352.5,"AEFFDT",IBCODE,-IBEFFDT)) D  Q
 . . D BMES^XPDUTL(" Duplication of non-billable type code "_IBCODE)
 . S IBLSTDT=$O(^IBE(352.5,"AEFFDT",IBCODE,-9999999))
 . I +IBLSTDT=0 D  Q
 . . D BMES^XPDUTL(" Code "_IBCODE_" not found for non-billable update")
 . S IB1=$O(^IBE(352.5,"AEFFDT",IBCODE,IBLSTDT,0))
 . S IBDES=$P($G(^IBE(352.5,IB1,0)),U,4)
 . S IBOVER=+$P($G(^IBE(352.5,IB1,0)),U,5)
 . S Y=+$$ADD3525(IBCODE,IBEFFDT,$P(IBT,U,2),IBDES,IBOVER) S:Y>0 IBC=IBC+1
 D MES^XPDUTL("")
 D MES^XPDUTL(IBC_$S('IBC:" entry has ",1:" entries have ")_"been added to file 352.5.")
 Q
 ;
 ;add a new entry
ADD3525(IBCODE,IBEFFDT,IBTYPE,IBDES,IBOVER) ;
 D BMES^XPDUTL(" Non-billable type code "_IBCODE)
 N IBIENS,IBFDA,IBER,IBRET
 S IBRET=""
 S IBIENS="+1,"
 S IBFDA(352.5,IBIENS,.01)=IBCODE
 S IBFDA(352.5,IBIENS,.02)=IBEFFDT
 S IBFDA(352.5,IBIENS,.03)=IBTYPE
 S IBFDA(352.5,IBIENS,.04)=IBDES
 S:IBOVER IBFDA(352.5,IBIENS,.05)=1
 D UPDATE^DIE("","IBFDA","IBRET","IBER")
 I $D(IBER) D BMES^XPDUTL(IBER("DIERR",1,"TEXT",1))
 Q $G(IBRET(1))
 ;
 ;;billable type data
BTYPE ;;code^non-billable type
 ;;533707^0
 ;;566707^0
 ;;707^0
 ;;
 ;
