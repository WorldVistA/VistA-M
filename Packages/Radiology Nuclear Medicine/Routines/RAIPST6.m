RAIPST6 ;HIRMFO/GJC - Post-init number six ;11/23/97  13:25
VERSION ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;
EN1 ; Add the following protocols to file 101 iff they are new
 ; to the Protocol (101) file: RA SEND ORM, RA SEND ORU, RA CANCEL
 ; & RA EVSEND OR.  DBIA: 872
 ; Note: The third subscript of RAFDA is the field number in file 101.
 ;       Consult a data dictionary for further information.
SNDORM ; RA SEND ORM protocol
 I '$D(^ORD(101,"B","RA SEND ORM")) D
 . N RA101,RAFDA
 . S RAFDA(101,"+1,",.01)="RA SEND ORM"
 . S RAFDA(101,"+1,",1)="Client for Imaging (ORM)"
 . S RAFDA(101,"+1,",12)=$$PKG^RAIPST5()
 . S RAFDA(101,"+1,",4)="subscriber"
 . S RAFDA(101,"+1,",15)="Q"
 . S RAFDA(101,"+1,",99)=$$TSTMP^RAIPST5()
 . S RAFDA(101,"+1,",770.4)="O01"
 . S RAFDA(101,"+1,",773.1)="NO"
 . S RAFDA(101,"+1,",773.3)="NO"
 . S RAFDA(101,"+1,",20)="Q"
 . S RAFDA(101,"+1,",770.2)="RA-CLIENT-IMG"
 . S RAFDA(101,"+1,",770.6)=$$PROID^RAIPST5()
 . S RAFDA(101,"+1,",771)="Q"
 . S RAFDA(101,"+1,",773.2)="NO"
 . S RAFDA(101,"+1,",773.4)="YES"
 . D MSG^RAIPST5("RA SEND ORM")
 . D UPDATE^DIE("E","RAFDA")
 . I $D(^ORD(101,"B","RA SEND ORM")) D  Q
 .. S RA101=$O(^ORD(101,"B","RA SEND ORM",0))
 .. K RAFDA S RAFDA(101,RA101_",",770.95)=2.1 D FILE^DIE("E","RAFDA")
 .. S ^ORD(101,RA101,1,1,0)="This protocol receives the HL7 message."
 .. S ^ORD(101,RA101,1,0)="^^1^1^"_$$DT^XLFDT()_"^^"
 .. Q
 . D ERR^RAIPST5("RA SEND ORM")
 . Q
SNDORU ; RA SEND ORU protocol
 I '$D(^ORD(101,"B","RA SEND ORU")) D
 . N RA101,RAFDA
 . S RAFDA(101,"+1,",.01)="RA SEND ORU"
 . S RAFDA(101,"+1,",1)="Client for Imaging (ORU)"
 . S RAFDA(101,"+1,",12)=$$PKG^RAIPST5()
 . S RAFDA(101,"+1,",4)="subscriber"
 . S RAFDA(101,"+1,",15)="Q"
 . S RAFDA(101,"+1,",99)=$$TSTMP^RAIPST5()
 . S RAFDA(101,"+1,",770.4)="R01"
 . S RAFDA(101,"+1,",773.1)="NO"
 . S RAFDA(101,"+1,",773.3)="NO"
 . S RAFDA(101,"+1,",20)="Q"
 . S RAFDA(101,"+1,",770.2)="RA-CLIENT-IMG"
 . S RAFDA(101,"+1,",770.6)=$$PROID^RAIPST5()
 . S RAFDA(101,"+1,",771)="Q"
 . S RAFDA(101,"+1,",773.2)="NO"
 . S RAFDA(101,"+1,",773.4)="YES"
 . D MSG^RAIPST5("RA SEND ORU")
 . D UPDATE^DIE("E","RAFDA")
 . I $D(^ORD(101,"B","RA SEND ORU")) D  Q
 .. S RA101=$O(^ORD(101,"B","RA SEND ORU",0))
 .. K RAFDA S RAFDA(101,RA101_",",770.95)=2.1 D FILE^DIE("E","RAFDA")
 .. S ^ORD(101,RA101,1,1,0)="This protocol receives the HL7 message."
 .. S ^ORD(101,RA101,1,0)="^^1^1^"_$$DT^XLFDT()_"^^"
 .. Q
 . D ERR^RAIPST5("RA SEND ORU")
 . Q
CANCEL ; RA CANCEL protocol
 I '$D(^ORD(101,"B","RA CANCEL")) D
 . N RA101,RAFDA
 . S RAFDA(101,"+1,",.01)="RA CANCEL"
 . S RAFDA(101,"+1,",1)="Rad/Nuc Med exam cancellation"
 . S RAFDA(101,"+1,",12)=$$PKG^RAIPST5()
 . S RAFDA(101,"+1,",4)="event driver"
 . S RAFDA(101.01,"+2,+1,",.01)="RA SEND ORM"
 . S RAFDA(101,"+1,",20)="Q"
 . S RAFDA(101,"+1,",770.3)="ORM"
 . S RAFDA(101,"+1,",770.6)=$$PROID^RAIPST5()
 . S RAFDA(101,"+1,",772)="Q"
 . S RAFDA(101,"+1,",99)=$$TSTMP^RAIPST5()
 . S RAFDA(101,"+1,",770.4)="O01"
 . D MSG^RAIPST5("RA CANCEL")
 . D UPDATE^DIE("E","RAFDA")
 . I $D(^ORD(101,"B","RA CANCEL")) D  Q
 .. S RA101=$O(^ORD(101,"B","RA CANCEL",0))
 .. K RAFDA S RAFDA(101,RA101_",",770.95)=2.1 D FILE^DIE("E","RAFDA")
 .. S ^ORD(101,RA101,1,1,0)="This protocol is triggered whenever a Radiology/Nuclear Medicine exam is"
 .. S ^ORD(101,RA101,1,2,0)="cancelled.  It executes code that creates an HL7 ORM message consisting of"
 .. S ^ORD(101,RA101,1,3,0)="PID, ORC, OBR and OBX segments.  The message contains all relevant"
 .. S ^ORD(101,RA101,1,4,0)="information about the exam, including procedure, time of cancellation,"
 .. S ^ORD(101,RA101,1,5,0)="procedure modifiers, patient allergies and clinical history."
 .. S ^ORD(101,RA101,1,0)="^^5^5^"_$$DT^XLFDT()_"^^"
 .. Q
 . D ERR^RAIPST5("RA CANCEL")
 . Q
EVSEND ; RA EVSEND OR protocol
 I '$D(^ORD(101,"B","RA EVSEND OR")) D
 . N RA101,RAFDA
 . S RAFDA(101,"+1,",.01)="RA EVSEND OR"
 . S RAFDA(101,"+1,",1)="Rad/Nuc Med event sent to OE/RR"
 . S RAFDA(101,"+1,",12)=$$PKG^RAIPST5()
 . S RAFDA(101,"+1,",4)="extended action"
 . S RAFDA(101,"+1,",44)="RA EVSEND"
 . S RAFDA(101,"+1,",15)="K:$L($G(RAVARBLE)) @RAVARBLE,RAVARBLE"
 . S RAFDA(101,"+1,",99)=$$TSTMP^RAIPST5()
 . D MSG^RAIPST5("RA EVSEND OR")
 . D UPDATE^DIE("E","RAFDA")
 . I $D(^ORD(101,"B","RA EVSEND OR")) D  Q
 .. S RA101=$O(^ORD(101,"B","RA EVSEND OR",0))
 .. S ^ORD(101,RA101,1,1,0)="Invoked when a request is created or changed by the Radiology/Nuclear"
 .. S ^ORD(101,RA101,1,2,0)="Medicine package (the ""backdoor"") and the data is passed to the Order"
 .. S ^ORD(101,RA101,1,3,0)="Entry package, Version 3.0 or greater."
 .. S ^ORD(101,RA101,1,0)="^^3^3^"_$$DT^XLFDT()_"^^"
 .. Q
 . D ERR^RAIPST5("RA EVSEND OR")
 . Q
 Q
