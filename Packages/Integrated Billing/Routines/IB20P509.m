IB20P509 ;ALB/RRA - Patch Install Routine ; 10/10/12 5:45pm
 ;;2.0;INTEGRATED BILLING;**509**;21-MAR-94;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
POST ; Update the TCP/IP address for HL7 Logical Link
 N IBIEN1,IBIEN2,IBPAD,IBTAD,IBNAD,IB870,IBERR,IBQUIT
 D MES^XPDUTL("Update TCP/IP address of HL7 Logical Link 'EPHARM OUT' & 'BPS NCPDP'")
 ; DBIA #1496
 S IBQUIT=0
 S IBPAD="127.0.0.1",IBTAD="127.0.0.1"
 S IBIEN1=$O(^HLCS(870,"B","EPHARM OUT",0))
 I 'IBIEN1 D
 . D MES^XPDUTL("IEN of HL7 Logical Link 'EPHARM OUT' not found - install aborted")
 . S IBQUIT=1
 S IBIEN2=$O(^HLCS(870,"B","BPS NCPDP",0))
 I 'IBIEN2 D
 . D MES^XPDUTL("IEN of HL7 Logical Link 'BPS NCPDP' not found - install aborted")
 . S IBQUIT=1
 ;
 I IBQUIT D POSTQ  Q
 ; check the account (test or  production) and then update the IP address
 S IBNAD=$S($$PROD^XUPROD:IBPAD,1:IBTAD)
 S IB870(870,IBIEN1_",",400.01)=IBNAD,IB870(870,IBIEN2_",",400.01)=IBNAD
 D FILE^DIE("","IB870","IBERR")
 I $D(IBERR) D
 . D MES^XPDUTL("Update failed")
 I '$D(IBERR) D
 . D MES^XPDUTL("The TCP/IP address updates were successful")
 D POSTQ  Q
 ;
POSTQ D MES^XPDUTL(" Done.")
 Q
 ;
