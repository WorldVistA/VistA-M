IB20P242 ;WOIFO/SS-FY04 OPC COPAY IB*2.0*242 POST INIT ;10-SEP-03
 ;;2.0;INTEGRATED BILLING;**242**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
POST ;
 I $$PATCH^XPDUTL("IB*2.0*242") D BMES^XPDUTL("  Skipping since the patch was previously installed.") Q
 N X,Y,IBEFFDT
 S IBEFFDT=3031001 ;effective date OCT 1, 2003 
 D START,FADD(IBEFFDT),FDESCR(IBEFFDT),FINISH
 ;
 ; FADD - add additional codes to file 352.5
 ; FDESCR - add description updates for codes to file 352.5
 Q
 ;
START ;
 D MESS("  FY04 OPC COPAY, Post-Install Starting")
 Q
 ;
FINISH ;
 D MESS("  FY04 OPC COPAY, Post-Install Complete")
 Q
 ;
 ;add new entries in file 352.5
FADD(IBEFFDT) ;
 N IBC,IBT,IBX,IBCODE,IBTYPE,IBOVER
 D MESS("  Adding new codes to file 352.5")
 S IBC=0
 F IBX=1:1 S IBT=$P($T(ADDREG+IBX),";",3) Q:'$L(IBT)  D
 . S IBCODE=+$P(IBT,"^",1)
 . S IBTYPE=$P(IBT,"^",3)
 . S IBOVER=+$P(IBT,"^",4)
 . S Y=+$$ADD3525(IBCODE,IBEFFDT,IBTYPE,$E($P(IBT,"^",2),1,30),IBOVER) S:Y>0 IBC=IBC+1
 D MESS("     "_IBC_" entries added to 352.5")
 Q
 ;
 ;update description (add a new entry with new description if old one exists)
FDESCR(IBEFFDT) ;
 N IBC,IBT,IBX,IBCODE,IBTYPE,IBOVER
 N IBLSTDT,IB1
 D MESS("  Updating descriptions in file 352.5")
 S IBC=0
 F IBX=1:1 S IBT=$P($T(DESCR+IBX),";",3) Q:'$L(IBT)  D
 . S IBCODE=+$P(IBT,"^",1)
 . S IBLSTDT=$O(^IBE(352.5,"AEFFDT",IBCODE,-9999999))
 . I +IBLSTDT=0 D  Q
 . . D BMES^XPDUTL("  Code "_IBCODE_" not found for description update.")
 . S IB1=$O(^IBE(352.5,"AEFFDT",IBCODE,IBLSTDT,0))
 . I +IB1=0 D  Q
 . . D BMES^XPDUTL("  Code "_IBCODE_" not found for description update.")
 . S IBTYPE=+$P($G(^IBE(352.5,IB1,0)),"^",3)
 . S IBOVER=+$P($G(^IBE(352.5,IB1,0)),"^",5)
 . S Y=+$$ADD3525(IBCODE,IBEFFDT,IBTYPE,$E($P(IBT,"^",2),1,30),IBOVER) S:Y>0 IBC=IBC+1
 D MESS("     "_IBC_" updates added to 352.5")
 Q
 ;
 ;add a new entry
ADD3525(IBCODE,IBEFFDT,IBTYPE,IBDECR,IBOVER) ;
 D BMES^XPDUTL("  "_IBCODE_"  "_IBDECR)
 N IBIENS,IBFDA,IBER,IBRET,IBSEEKDT,IBLSTDT,IBOFL,IB1
 S IBIENS="+1,"
 S IBFDA(352.5,IBIENS,.01)=IBCODE
 S IBFDA(352.5,IBIENS,.02)=IBEFFDT
 S IBFDA(352.5,IBIENS,.03)=IBTYPE
 S IBFDA(352.5,IBIENS,.04)=IBDECR
 I IBOVER=1 S IBFDA(352.5,IBIENS,.05)=1
 D UPDATE^DIE("","IBFDA","IBRET","IBER")
 I $D(IBER) D BMES^XPDUTL(IBER("DIERR",1,"TEXT",1))
 Q $G(IBRET(1))
 ;
 ;output the message
MESS(IBSTR) ;
 N IBA
 S IBA(2)=IBSTR
 S (IBA(1),IBA(3))=""
 D MES^XPDUTL(.IBA)
 Q
 ;
 ;data section
ADDREG ;; non-override (regular) codes 
 ;;221^PHONE/VISUAL IMPAIRMENT (VIST)^0^0
 ;;348^PRIMARY CARE GROUP^1^0
 ;;371^CCS EVALUATION^0^0
 ;;394^MED SPECIALTY GROUP^2^0
 ;;674^ADMIN PT ORIENT NON-CNT MAS^0^0
 ;;685^CARE OF CCS PROGRAM PATIENTS^0^1
 ;;686^CCS TELEPHONE (ETC.) CARE^0^0
 ;;690^TELEMEDICINE 2ND ONLY^0^1
 ;;717^PPD CLINIC (2ND ONLY)^0^1
 ;;179^REAL-TIME VIDEO CARE 2ND ONLY^0^1
 ;;684^HM THLTH NOVIDEO INTRVN 2 ONLY^0^1
 ;;
 ;
DESCR ;; description updates
 ;;317^ANTI-COAGULATION CLINIC^
 ;;512^MENTAL HEALTH CONSULTATION^
 ;;527^MENTAL HEALTH PHONE PRI ONLY^
 ;;
 ;
