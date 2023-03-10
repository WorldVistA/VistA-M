IB2P710 ;ALB/FSB - DSS CLINIC STOP CODES FOR FY 2022 ; July 20,2021@13:20
 ;;2.0;INTEGRATED BILLING;**710**;21-MAR-94;Build 4
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
POST ; Update IB Stop Code Billable Types for FY 2022 in #352.5
 N U,IBEFDT
 S U="^",IBEFDT=3211001
 D START,UPDATE,FINISH
 Q
 ;
START D BMES^XPDUTL("DSS Clinic Stop Codes for FY 2022, Post-Install Starting")
 Q
 ;
FINISH D BMES^XPDUTL("DSS Clinic Stop Codes for FY 2022, Post-Install Complete")
 Q
 ;
UPDATE ; add new entry for an old code with an effective date of 10/01/2021
 N IBCODE,IBCNT,IBDES,IBLSTDT,IBOVER,IBRES,IBT,IBTYPE,IBX
 S IBCNT=0
 D BMES^XPDUTL(" Updating Stop Code entries in file 352.5")
 F IBX=1:1 S IBT=$P($T(OCODE+IBX),";;",2) Q:IBT="Q"  D
 . S IBCODE=+$P(IBT,U)
 . I $D(^IBE(352.5,"AEFFDT",IBCODE,-IBEFDT)) D  Q 
 . . D BMES^XPDUTL("   Duplication of stop code "_IBCODE)
 . S IBLSTDT=$O(^IBE(352.5,"AEFFDT",IBCODE,-9999999))
 . I +IBLSTDT=0 D  Q
 . . D BMES^XPDUTL("   Code "_IBCODE_" not found in file 352.5")
 . ; only use fy22 data
 . S IBTYPE=$P(IBT,U,2)
 . S IBDES=$P(IBT,U,3)
 . S IBOVER=$P(IBT,U,4)
 . S IBRES=+$$ADD3525(IBCODE,IBEFDT,IBTYPE,IBDES,IBOVER)
 . S:IBRES>0 IBCNT=IBCNT+1
 D BMES^XPDUTL(" "_IBCNT_$S(IBCNT<2:" update",1:" updates")_" added to file 352.5")
 Q
 ;
ADD3525(IBCODE,IBEFDT,IBTYPE,IBDES,IBOVER) ;
 ; input - stop code, effective date, billable type, description, override flag
 ; output - > 0 if add a new entry, otherwise
 N IBER,IBFDA,IBIENS,IBRET
 D BMES^XPDUTL("   "_IBCODE_"  "_IBDES)
 S IBIENS="+1,"
 S IBFDA(352.5,IBIENS,.01)=IBCODE
 S IBFDA(352.5,IBIENS,.02)=IBEFDT
 S IBFDA(352.5,IBIENS,.03)=IBTYPE
 S IBFDA(352.5,IBIENS,.04)=IBDES
 S:IBOVER IBFDA(352.5,IBIENS,.05)=1
 D UPDATE^DIE("","IBFDA","IBRET","IBER")
 I $D(IBER) D MES^XPDUTL("    Error Text: "_$G(IBER("DIERR",1,"TEXT",1)))
 Q +$G(IBRET(1))
 ;
 ; 2 existing stop codes
OCODE ;;code^billable type^description^override flag
 ;;189^0^ST & FOR TELE-HOM/COM/VA SITE^1
 ;;698^0^REM PT MON-PROV SIT RPM-HT PRG^1
 ;;Q
 ;
