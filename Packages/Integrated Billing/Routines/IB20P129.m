IB20P129 ; ALB/CXW - IB*2*129 POST-INSTALL ; 24-JAN-00
 ;;2.0;INTEGRATED BILLING;**129**;21-MAR-94
 ;
UPFLD ;change NUMBER OF DAYS PT CHARGES HELD field (#7.04) in file #350.9
 D BMES^XPDUTL("Updating Number of Days Patient Charges Held field in file (350.9)")
 S $P(^IBE(350.9,1,7),"^",4)=150
 D BMES^XPDUTL("Step Complete.")
 Q
