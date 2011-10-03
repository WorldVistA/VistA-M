PSJIPRE ;BIR/CML3-PREINIT FOR INPATIENT ;20 MAR 97 / 9:41 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
 ;
ENSO ;Place all Inpatient options out of service.
 D MES^XPDUTL(" ")
 S PSJMESSG=" In order to prevent the corruption of existing data while running version 5.0" D MES^XPDUTL(PSJMESSG)
 S PSJMESSG=" install, all of the Inpatient Medications options will be placed" D MES^XPDUTL(PSJMESSG)
 S PSJMESSG=" OUT OF ORDER.  They will be made available again once the version 5.0" D MES^XPDUTL(PSJMESSG)
 S PSJMESSG=" install is finished.            ....working...." D MES^XPDUTL(PSJMESSG)
 ;
 S Q1="PSJ" F  S Q1=$O(^DIC(19,"B",Q1)) Q:$E(Q1,1,3)'="PSJ"  I $E(Q1,1,4)'="PSJ4" F Q2=0:0 S Q2=$O(^DIC(19,"B",Q1,Q2)) Q:'Q2  S DIE="^DIC(19,",DA=Q2,DR="2////UNAVAILABLE UNTIL INPATIENT CONVERSIONS COMPLETE..." D ^DIE
 S Q1="PSJ" F  S Q1=$O(^ORD(101,"B",Q1)) Q:$E(Q1,1,3)'="PSJ"  I Q1'="PSJ OR PAT ADT" F Q2=0:0 S Q2=$O(^ORD(101,"B",Q1,Q2)) Q:'Q2  S DIE="^ORD(101,",DA=Q2,DR="2////UNAVAILABLE UNTIL CONVERSIONS COMPLETE" D ^DIE
 K DA,DIE,DR,PSJMESSG,Q1,Q2,X,Y
 Q
