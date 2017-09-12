BPS10P9 ;ALB/CNF - TRICARE ENHANCEMENT POST INSTALL UPDATES BPS*1*9 ;9/9/10
 ;;1.0;E CLAIMS MGMT ENGINE;**9**;JUN 2004;Build 18
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q                ;No entry from top
 ;
EN ;Entry
 ;
 D BMES^XPDUTL("Begin Post Installation Processing for patch BPS*1*9")
 ;
 ;Add TRICARE Reject Code eT to BPS NCPDP REJECT CODE dictionary, #9002313.93
 D ET
 ;
 D BMES^XPDUTL("End Post Installation Processing for patch BPS*1*9")
 ;
 Q
 ;
ET ;Add TRICARE Reject Code eT to BPS NCPDP REJECT CODE dictionary, #9002313.93
 ;
 N X,Y,DIC,DIE,DR,DA,D0
 ;
 D BMES^XPDUTL("Add TRICARE Reject Code eT to BPS NCPDP REJECT CODE dictionary")
 ;
 ;Quit if the code eT already exist
 S X=$O(^BPSF(9002313.93,"B","eT",0))
 I X D BMES^XPDUTL("Entry already exists") Q
 ;
 ;Add the entry
 S DIC="^BPSF(9002313.93,",X="eT"
 S DIC("DR")=".02///TRICARE-DRUG NON BILLABLE",DIC(0)="F"
 D FILE^DICN
 ;
 I Y D BMES^XPDUTL("Entry eT successfully added") Q
 ;
 D BMES^XPDUTL("Error when adding TRICARE Reject Code. Please log a Remedy ticket!")
 ;
 Q
