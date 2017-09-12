IB20P475 ;ALB/CXW - Patch Install Routine ; 10/10/12 5:45pm
 ;;2.0;INTEGRATED BILLING;**475**;21-MAR-94;Build 31
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
POST ; Update the TCP/IP address for HL7 Logical Link 'IIV EC' which will
 ; connect to the new server located at FSC in Austin, Texas.
 ; production account-127.0.0.1, test account-127.0.0.18
 N FILE,IBIIV,IBIEN,IBPAD,IBTAD,IBOAD,IBNAD,IB870,IBERR
 D MES^XPDUTL("Update the TCP/IP address of HL7 Logical Link 'IIV EC'")
 ; DBIA #1496
 S FILE=870
 S IBIIV="IIV EC"
 S IBPAD="127.0.0.1",IBTAD="127.0.0.1"
 S IBIEN=$O(^HLCS(870,"B",IBIIV,0))
 I 'IBIEN D  G POSTQ
 . D MES^XPDUTL("IEN of HL7 Logical Link 'IIV EC' not found")
 ;
 ; check the account and then update the IP address
 S IBOAD=$$GET1^DIQ(870,IBIEN_",",400.01)
 I IBOAD="" D MES^XPDUTL("Please note that the TCP/IP address is blank")
 S IBNAD=$S($$PROD^XUPROD:IBPAD,1:IBTAD)
 S IB870(870,IBIEN_",",400.01)=IBNAD
 D FILE^DIE("","IB870","IBERR")
 I $D(IBERR) D  G POSTQ
 . D MES^XPDUTL("Update failed")
 D MES^XPDUTL("The TCP/IP address "_IBOAD_" was replaced with "_IBNAD)
 ;
POSTQ D MES^XPDUTL(" Done.")
 Q
 ;
