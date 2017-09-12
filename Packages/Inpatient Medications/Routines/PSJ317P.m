PSJ317P ;BIR/MHA - PADE POST INSTALL ROUTINE; 07/07/15
 ;;5.0;INPATIENT MEDICATIONS;**317**;16 DEC 97;Build 130
 ;Reference to ^ORD(101 supported by DBIA #872
 ;
 Q
POST ; Add client to event driver as a subscriber
 N SNAM,EX,I,J,LN,SEQ,IN,RETURN S SNAM="PSJ ADT-A01 ROUTER",EX=0
 S I=$O(^ORD(101,"B",SNAM,0))
 I 'I D MES^XPDUTL(SNAM_" Router Protocol Does Not Exist - Quitting!") Q
 F SEQ=1:1 S LN=$T(TAG+SEQ) Q:$P(LN,";",3)="END"  D  Q:EX
 . S J=$P(LN,";",3)_" SERVER",IN=$O(^ORD(101,"B",J,0))
 . I 'IN D MES^XPDUTL(J_" Protocol Does Not Exist") S EX=1 Q
 . I $D(^ORD(101,IN,775,"B",I)) D  Q  ;Skip if already present
 . . D MES^XPDUTL(SNAM_" is already a Subscribing Protocol to "_J)
 . ;Add subscriber to event driver
 . S PEN(1)=IN,DATA(.01)=I
 . S RETURN=$$ADD(101.0775,.PEN,.DATA,.ERROR)
 . D MES^XPDUTL("Added "_SNAM_" as a subscriber to "_J)
 ;S SNAM="PSJ ADT-A08-SDAM ROUTER"
 S SNAM="PSJ SIU-SDAM ROUTER"
 S I=$O(^ORD(101,"B",SNAM,0))
 I 'I D MES^XPDUTL(SNAM_" Router Protocol Does Not Exist - Quitting!") Q
 S J="VAFC ADT-A08-SDAM SERVER",IN=$O(^ORD(101,"B",J,0))
 I 'IN D MES^XPDUTL(J_" Protocol Does Not Exist") Q
 I $D(^ORD(101,IN,775,"B",I)) D  G LL  ;Skip if already present
 . D MES^XPDUTL(SNAM_" is already a Subscribing Protocol to "_J)
 ;Add subscriber to event driver
 S PEN(1)=IN,DATA(.01)=I
 S RETURN=$$ADD(101.0775,.PEN,.DATA,.ERROR)
 D MES^XPDUTL("Added "_SNAM_" as a subscriber to "_J)
 ;as per the VIE/HL7 team, hard set AUTOSTART field(4.5) to 1 (Enabled) & DO NOT PING field (#24) to "Yes" for PSJ PADE Logical Link 
LL K DIC,DIE S (DIC,DIE)=870,DIC(0)="",X="PSJ PADE" D ^DIC Q:Y<0
 S DR="4.5////1;24////1",DA=+Y D ^DIE K DIC,DIE,DR,DA
 Q
 ;
ADD(FILE,PEN,DATA,ERROR,IEN) ;  Add 
 N FDA,FIELD,IENA,IENS,ERRORS,DIERR
 S PEN="+1"
 S IENS=$$IENS^DILF(.PEN)
 S FIELD=0
 F  S FIELD=$O(DATA(FIELD)) Q:'FIELD  S FDA(FILE,IENS,FIELD)=$G(DATA(FIELD))
 I $G(IEN) S IENA(1)=IEN
 D UPDATE^DIE("","FDA","IENA","ERRORS(1)")
 I +$G(DIERR) D
 . D MES^XPDUTL($G(ERRORS(1,"DIERR",1,"TEXT",1)))
 . S IEN=""
 E  D
 . S IEN=IENA(1)
 D CLEAN^DILF
 Q IEN
TAG ;
 ;;VAFC ADT-A01
 ;;VAFC ADT-A02
 ;;VAFC ADT-A03
 ;;VAFC ADT-A08
 ;;VAFC ADT-A08-TSP
 ;;VAFC ADT-A11
 ;;VAFC ADT-A12
 ;;VAFC ADT-A13
 ;;END
 ;
