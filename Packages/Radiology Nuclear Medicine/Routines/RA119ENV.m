RA119ENV ;HISC/GJC Radiation dosage report utility one ;26 Apr 2017 2:18 PM
 ;;5.0;Radiology/Nuclear Medicine;**119**;Mar 16, 1998;Build 7
 ;
EN ;entry point
 ;--- IAs ---
 ;Call/File            Number     Type
 ;------------------------------------------------
 ;$$PROD^XUPROD        4440       S
 ;$$KSP^XUPARAM        2541       S
 ;File #2005.632       6732       P
 ;File #2005.633       6733       P
 ;
 ;where 'S'=Supported; 'C'=Controlled Subscription; 'P'=Private
 ;
 ;If the site manager has designated this as the production
 ;account our API (#4440) will return a 1, otherwise it
 ;returns 0. The default check is against the PRODUCTION
 ;field (#501) in the KERNEL SYSTEM PARAMETERS (#8989.3) file.
 ; 
 ;note: If this is a test account can exit now.
 Q:$$PROD^XUPROD()=0
 ;
 N RAI,RAS,RAX,RAY
 S RAS=$$KSP^XUPARAM("WHERE"),RAY=0
 ;
 ;FNC>W !,$$KSP^XUPARAM("WHERE") 
 ; FAYETTVL-NC.DOMAIN.EXT
 ;FNC>
 ;
 ;LEX>W !,$$KSP^XUPARAM("WHERE") 
 ; LEXINGTON.DOMAIN.EXT
 ;LEX>
 ;
 ;STL>w !,$$KSP^XUPARAM("WHERE")
 ; ST-LOUIS.DOMAIN.EXT
 ;STL>
 ;
 F RAI=1:1 S RAX=$P($T(SITE+RAI),";;",2,99) Q:RAX=""  D  Q:RAY
 .S:RAS=RAX RAY=1
 .Q
 ;
 ;RAY = 1: matched one of the trusted test sites
 ; if one of the sites quit w/o aborting install
 Q:RAY
 ;
 ; if not one of the test sites there cannot be rad dose
 ; data in files:
 ; - 70.3. 
 ; - CT DOSE #2005.632
 ; - PROJECTION X-RAY DOSE #2005.633
 ;
 ;RAY is still set to zero if we've gone this far.
 ;
 I $O(^RAD(0))>0 D
 .D MES^XPDUTL("Dose data was found in the RADIATION ABSORBED DOSE file.")
 .S XPDQUIT=2
 .Q
 I $O(^MAGV(2005.632,0))>0 D
 .D MES^XPDUTL("Dose data was found in the CT DOSE file.")
 .S XPDQUIT=2
 .Q
 ;
 I $O(^MAGV(2005.633,0))>0 D
 .D MES^XPDUTL("Dose data was found in the PROJECTION X-RAY DOSE file.")
 .S XPDQUIT=2
 .Q
 ;
 D:$G(XPDQUIT)=2 BMES^XPDUTL(XPDNM_" cannot be installed.")
 ;
 Q
 ;
SITE ;test sites I trust & have ready access into their production accounts
 ;;FAYETTVL-NC.DOMAIN.EXT
 ;;LEXINGTON.DOMAIN.EXT
 ;;ST-LOUIS.DOMAIN.EXT
 ;;
