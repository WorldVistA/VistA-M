IBY811PO ;YMG/EDE - IB*2.0*811 POST INSTALL;12/04/24 12:35pm
 ;;2.0;Integrated Billing;**811**;Mar 20, 1995;Build 5
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ;Post Install for IB*2.0*811
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for IB*2.0*811")
 D INATYPE
 D NEWCANC
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for IB*2.0*811")
 Q
 ;
INATYPE ; Inactivate Action Types in file 350.1
 N FDA,IBDATA,IBIEN,IBNM,IENS,Z
 D MES^XPDUTL("     -> Inactivating Action Types in file 350.1...")
 F Z=1:1 S IBDATA=$T(INADAT+Z),IBNM=$P(IBDATA,";",3) Q:IBNM="END"  D
 .S IBIEN=$O(^IBE(350.1,"B",IBNM,"")) I 'IBIEN D BMES^XPDUTL("       >>  Unable to update Action Type "_IBNM_".") Q
 .S IENS=IBIEN_","
 .S FDA(350.1,IENS,.12)=1
 .D FILE^DIE("","FDA") K FDA
 .Q
 D MES^XPDUTL("        Done.")
 Q
 ;
INADAT ; Action types
 ;;CCN (INPT) NEW
 ;;CCN (INPT) UPDATE
 ;;CCN (INPT) CANCEL
 ;;CCN (PER DIEM) NEW
 ;;CCN (PER DIEM) UPDATE
 ;;CCN (PER DIEM) CANCEL
 ;;CCN (OPT) NEW
 ;;CCN (OPT) UPDATE
 ;;CCN (OPT) CANCEL
 ;;CCN (RX) NEW
 ;;CCN (RX) UPDATE
 ;;CCN (RX) CANCEL
 ;;LTC CCN INPT CNH CANCEL
 ;;LTC CCN INPT CNH NEW
 ;;LTC CCN INPT CNH UPDATE
 ;;LTC CCN INPT RESPITE CANCEL
 ;;LTC CCN INPT RESPITE NEW
 ;;LTC CCN INPT RESPITE UPDATE
 ;;LTC CCN OPT ADHC CANCEL
 ;;LTC CCN OPT ADHC NEW
 ;;LTC CCN OPT ADHC UPDATE
 ;;LTC CCN OPT RESPITE CANCEL
 ;;LTC CCN OPT RESPITE NEW
 ;;LTC CCN OPT RESPITE UPDATE
 ;;END
 Q
 ;
NEWCANC ; add new cancellation reason to file 350.3
 N FDA,IBCNNM
 D MES^XPDUTL("     -> Adding new Cancellation Reason to file 350.3...")
 S IBCNNM="SECVA PIT PAUSE NOV 2025"
 I $$FIND1^DIC(350.3,,"X",IBCNNM,"B")>0 D MES^XPDUTL("        Already exists.") Q  ; already exists
 S FDA(350.3,"+1,",.01)=IBCNNM   ; name
 S FDA(350.3,"+1,",.02)="PIT"    ; abbreviation
 S FDA(350.3,"+1,",.03)=3        ; limit
 S FDA(350.3,"+1,",.04)=1        ; Can Cancel UC visit
 S FDA(350.3,"+1,",.05)=2        ; UC Visit processing - Visit Only
 S FDA(350.3,"+1,",.07)=2        ; MH visit processing - Visit Only
 S FDA(350.3,"+1,",.08)=1        ; Can cancel MH Visit
 S FDA(350.3,"+1,",.1)=3251111   ; End Date
 D UPDATE^DIE("","FDA")
 D MES^XPDUTL("        Done.")
 Q
