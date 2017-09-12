HDI1014A ;SLC/AJB - PATCH 14 POST INSTALL;04/28/2015
 ;;1.0;HEALTH DATA & INFORMATICS;**14**;Feb 22, 2005;Build 22
 ;
POST ;
 N DOMAIN,HDIDOM,HDIERROR,HDIMSG
 ;
 S HDIMSG(1)="Post-Installation (POST^HDI1014A) will now be run."
 S HDIMSG(2)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 ;
 S DOMAIN="IMMUNIZATIONS" ; domain to be added to HDIS DOMAIN File #7115.1
 ;
 ; add domain
 I '+$$UPDTDOM^HDISVCUT(DOMAIN) D  Q
 . D MES^XPDUTL("***** Error adding the "_DOMAIN_" domain to the HDIS DOMAIN FILE #7115.1."),PSTHALT("")
 ;
 ; get domain IEN
 I '+$$GETIEN^HDISVF09(DOMAIN,.HDIDOM) D  Q
 . D MES^XPDUTL("***** Error retrieving the IEN for the "_DOMAIN_" domain."),PSTHALT("")
 ;
 ; verify domain IEN
 I '+HDIDOM D  Q
 . D MES^XPDUTL("***** Error verifying the IEN for the "_DOMAIN_" domain."),PSTHALT("")
 ;
 ; get files & fields to be added to File #7115.6
 N DATA,LINE F LINE=1:1 S DATA=$P($T(DATA+LINE),";;",2) Q:DATA=""  D
 . N FILE,FIELD,HDIDATA,HDIERMSG
 . S FILE=$P(DATA,U),FIELD=$P(DATA,U,2)
 . I +$$GETIEN^HDISVF05(FILE,FIELD) Q  ; quit if entry already exists
 . S HDIDATA(FILE)=FIELD
 . ; add entry to HDIS FILE/FIELD File #7115.6
 . I '+$$ADDDFFS^HDISVF09(HDIDOM,.HDIDATA,.HDIERMSG) D
 . . I '$D(HDIERROR) D MES^XPDUTL("***** "_"Error updating File #7115.6")
 . . S HDIERROR=1
 . . D MES^XPDUTL("***** "_HDIERMSG)
 ;
 I +$D(HDIERROR) D PSTHALT("") Q
 ;
 ; Initiate VUIDs for set of code fields
 I '$$VUID^HDISVCUT("IMM","HDI1014B") D  Q
 . D MES^XPDUTL("***** VUIDs for set of code fields update failed."),PSTHALT("")
 ;
 S HDIMSG(1)="Post-Installation complete."
 S HDIMSG(2)=""
 D MES^XPDUTL(.HDIMSG)
 Q
PSTHALT(MSG) ; display error message
 S HDIMSG(1)=""
 S HDIMSG(2)=MSG
 S HDIMSG(3)="***** Post-installation has been halted."
 S HDIMSG(4)="***** Please contact Enterprise VistA Support."
 S HDIMSG(5)=""
 D MES^XPDUTL(.HDIMSG)
 Q
DATA ;
 ;;920^.01
 ;;920.1^.01
 ;;920.2^.01
 ;;920.3^.01
 ;;920.4^.01
 ;;920.5^.01
 ;;9999999.04^.01
 ;;9999999.14^.01
 ;;9999999.28^.01
 ;;
 Q
