LR7OPOS ;slc/dcm - POST-Initialization routine ;12/18/97  08:34
 ;;5.2;LAB SERVICE;**166**;Sep 27, 1994
 ;
EN ;Enter here for post initialization patch LR*5.2*166
 I $$VER^LR7OU1<3 Q  ;OE/RR 2.5 Check
 N LRCHK
 S X=$O(^ORD(101,"B","OR RECEIVE",0)) I 'X D MES^XPDUTL("Unable to continue. OE/RR 3.0 not installed. Conversion aborted!") Q  ;OE/RR not installed
 S Y=$O(^ORD(101,"B","LR7O CH EVSEND OR",0)) I 'Y D MES^XPDUTL("Unable to continue. Lab protocols for OE/RR have not been installed"),MES^XPDUTL("Conversion aborted!") Q  ;Lab protocol not found
 I '$D(^ORD(101,Y,10,"B",X)) D MES^XPDUTL("Unable to continue. OE/RR protocol 'OR RECEIVE' has not been placed on the"),MES^XPDUTL("Lab protocols. Conversion aborted!") Q  ;OE/RR not on Lab protocol
 S LRCHK=$$NEWCP^XPDUTL("POST3","L69^LR7OPOS")
 Q
L69 ;Send Lab order parameters to OE/RR
 Q:'$L($T(XPAR^XPAR))
 N X
 D BMES^XPDUTL("Now sending Lab order parameters to OE/RR...")
 D EN^LR7OV1
 Q
