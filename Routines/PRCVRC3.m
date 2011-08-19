PRCVRC3 ;WOIFO/BMM - silently build RIL for DynaMed ; 12/16/04
V ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;error codes and text for PRCVRC1
 ;
 Q
 ;
 ;below- each error message is listed with code, description, and
 ;severity level.  this is another method we may use for handling
 ;errors
 ;
ET ;
 ;;1^Malformed XTMP global^E
 ;;2^No message data for passed-in message id^E
 ;;3^FCP/CC combination invalid^E
 ;;4^Invalid date/time mesg created^E
 ;;5^Invalid fy for date/time mesg created^E
 ;;6^Invalid qtr for date/time mesg created^E
 ;;7^Error generating transaction number^E
 ;;8^Invalid or missing DUZ^E
 ;;9^Item invalid or inactivated^E
 ;;10^Quantity not numeric^E
 ;;11^Item unit cost not numeric^E
 ;;12^Date Needed not in future^E
 ;;13^Vendor not in Vendor file^E
 ;;14^Invalid vendor/item relationship^E
 ;;15^Invalid vendor name found^E
 ;;16^Unable to add detail record to RIL^E
 ;;17^Invalid NIF number for item^W
 ;;18^Invalid BOC for item^W
 ;;19^Invalid site/FCP/CC/BOC combination^W
 ;;20^Duplicate message control ID^E
 ;;21^Missing message control ID^E
 ;;22^Duplicate DM Doc ID^E
 ;;23^Error creating Audit file entry^E
 ;;24^Missing DynaMed Document ID^E
 ;;25^FCP invalid^E
 ;
