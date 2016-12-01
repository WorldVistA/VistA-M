DGBT1P28 ;ALB/DBE - BENEFICIARY TRAVEL PATCH 28 POST-INIT ;6/5/15 11:47am
 ;;1.0;Beneficiary Travel;**28**;September 25, 2001;Build 12
 ;
 ;this routine is a post-init to update the zip code
 ;fields in the Beneficiary Travel Claim (#392) file
 ;and the 30 Day Application Requirement template in
 ;the Beneficiary Travel Denial Reasons (392.8) file
 ;
EN ;entry point
 ;
 D BMES^XPDUTL("Post-init starting...")
 D UPDZIP
 D DGBTDLT
 D BMES^XPDUTL("...Post-init complete")
 ;
 Q
 ;
UPDZIP ;remove hyphen from internal zip code entry
 ;
 N DGBTDT
 D BMES^XPDUTL("     Updating zip codes...")
 S DGBTDT=0 F  S DGBTDT=$O(^DGBT(392,DGBTDT)) Q:'DGBTDT  D
 .I $D(^DGBT(392,DGBTDT,"D")) D
 ..I $P(^DGBT(392,DGBTDT,"D"),U,6)["-" D
 ...S $P(^DGBT(392,DGBTDT,"D"),U,6)=$TR($P(^DGBT(392,DGBTDT,"D"),U,6),"-","")
 .I $D(^DGBT(392,DGBTDT,"T")) D
 ..I $P(^DGBT(392,DGBTDT,"T"),U,6)["-" D
 ...S $P(^DGBT(392,DGBTDT,"T"),U,6)=$TR($P(^DGBT(392,DGBTDT,"T"),U,6),"-","")
 D BMES^XPDUTL("     ...zip code update complete")
 Q
 ;
DGBTDLT ;update the 30 Day Application Requirement denial letter template
 ;
 N DGBTIEN,DGBTARAY,DGBTLP
 D BMES^XPDUTL("     Updating denial letter...")
 S DGBTIEN=$O(^DGBT(392.8,"B","30 DAY APPLICATION REQUIREMENT",""))
 I 'DGBTIEN D BMES^XPDUTL("***Error encountered: 30 DAY APPLICATION REQUIREMENT letter not found***") Q
 F DGBTLP=1:1:5 S DGBTARAY(DGBTLP)=$P($T(TEXT+DGBTLP),";;",2)
 D WP^DIE(392.8,DGBTIEN_",",1,"K","DGBTARAY","DGBTERR")
 I $D(DGBTERR) D BMES^XPDUTL("***Error encountered while attempting to update the denial letter***")
 E  D BMES^XPDUTL("     ...denial letter update complete")
 Q
 ;
TEXT ;new text for 30 Day Application Requirement template
 ;;
 ;; Your request for payment consideration was received greater than 30
 ;; calendar days from the date you completed travel associated with your
 ;; appointment or the date you became administratively eligible for
 ;; payment of Beneficiary Travel benefits.
