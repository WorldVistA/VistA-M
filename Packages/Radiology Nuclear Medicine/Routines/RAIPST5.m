RAIPST5 ;HIRMFO/GJC - Post-init number five ;11/23/97  13:23
VERSION ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;
PRO101 ; Add the following protocols to file 101 iff they are new
 ; to the Protocol (101) file: RA EXAMINED, RA RECEIVE, RA REG & RA RPT.
 ; RA SEND ORM, RA SEND ORU, RA CANCEL & RA EVSEND OR handled in RAIPST6
 ; Updates in accordance with DBIA: 872
 ; Note: The third subscript of RAFDA is the field number in file 101.
 ;       Consult a data dictionary for further information.
 D EN1^RAIPST6 ; code for 'RA SEND ORM' & 'RA SEND ORU'.  These need to
 ; be added first because the following protocols have the above
 ; designated as Items: RA CANCEL, RA EXAMINED, RA REG & RA RPT.
 ; After 'RA SEND ORM' & 'RA SEND ORU' are added in RAIPST6, we also
 ; add 'RA CANCEL' & 'RA EVSEND OR' in RAIPST6.
EXAMINE ; RA EXAMINED protocol
 I '$D(^ORD(101,"B","RA EXAMINED")) D
 . N RA101,RAFDA
 . S RAFDA(101,"+1,",.01)="RA EXAMINED"
 . S RAFDA(101,"+1,",1)="Rad/Nuc Med examined case"
 . S RAFDA(101,"+1,",12)=$$PKG()
 . S RAFDA(101,"+1,",4)="event driver"
 . S RAFDA(101.01,"+2,+1,",.01)="RA SEND ORM"
 . S RAFDA(101,"+1,",20)="Q"
 . S RAFDA(101,"+1,",770.3)="ORM"
 . S RAFDA(101,"+1,",770.6)=$$PROID()
 . S RAFDA(101,"+1,",772)="Q"
 . S RAFDA(101,"+1,",99)=$$TSTMP()
 . S RAFDA(101,"+1,",770.4)="O01"
 . D MSG("RA EXAMINED")
 . D UPDATE^DIE("E","RAFDA")
 . I $D(^ORD(101,"B","RA EXAMINED")) D  Q
 .. S RA101=$O(^ORD(101,"B","RA EXAMINED",0))
 .. K RAFDA S RAFDA(101,RA101_",",770.95)=2.1 D FILE^DIE("E","RAFDA")
 .. S ^ORD(101,RA101,1,1,0)="This protocol is triggered whenever a Radiology/Nuclear Medicine exam"
 .. S ^ORD(101,RA101,1,2,0)="has reached a status where GENERATE EXAMINED HL7 MSG  is Y"
 .. S ^ORD(101,RA101,1,3,0)="at that (or at a lower) status."
 .. S ^ORD(101,RA101,1,4,0)="This message contains all relevant information about the exam,"
 .. S ^ORD(101,RA101,1,5,0)="including procedure, time of registration, procedure modifiers,"
 .. S ^ORD(101,RA101,1,6,0)="patient allergies, and clinical history."
 .. S ^ORD(101,RA101,1,0)="^^6^6^"_$$DT^XLFDT()_"^^^"
 .. Q
 . D ERR("RA EXAMINED")
 . Q
RECEIVE ; RA RECEIVE protocol
 I '$D(^ORD(101,"B","RA RECEIVE")) D
 . N RA101,RAFDA
 . ; no description for this protocol
 . S RAFDA(101,"+1,",.01)="RA RECEIVE"
 . S RAFDA(101,"+1,",1)="Rad/NM receives order msg from OE/RR"
 . S RAFDA(101,"+1,",12)=$$PKG()
 . S RAFDA(101,"+1,",4)="action"
 . S RAFDA(101,"+1,",20)="D EN1^RAO7RO(.XQORMSG)"
 . S RAFDA(101,"+1,",99)=$$TSTMP()
 . D MSG("RA RECEIVE")
 . D UPDATE^DIE("E","RAFDA")
 . Q
REG ; RA REG protocol
 I '$D(^ORD(101,"B","RA REG")) D
 . N RA101,RAFDA
 . S RAFDA(101,"+1,",.01)="RA REG"
 . S RAFDA(101,"+1,",1)="Rad/Nuc Med exam registered"
 . S RAFDA(101,"+1,",12)=$$PKG()
 . S RAFDA(101,"+1,",4)="event driver"
 . S RAFDA(101.01,"+2,+1,",.01)="RA SEND ORM"
 . S RAFDA(101,"+1,",20)="Q"
 . S RAFDA(101,"+1,",770.3)="ORM"
 . S RAFDA(101,"+1,",770.6)=$$PROID()
 . S RAFDA(101,"+1,",772)="Q"
 . S RAFDA(101,"+1,",99)=$$TSTMP()
 . S RAFDA(101,"+1,",770.4)="O01"
 . D MSG("RA REG")
 . D UPDATE^DIE("E","RAFDA")
 . I $D(^ORD(101,"B","RA REG")) D  Q
 .. S RA101=$O(^ORD(101,"B","RA REG",0))
 .. K RAFDA S RAFDA(101,RA101_",",770.95)=2.1 D FILE^DIE("E","RAFDA")
 .. S ^ORD(101,RA101,1,1,0)="This protocol is triggered whenever a Radiology/Nuclear Medicine exam is"
 .. S ^ORD(101,RA101,1,2,0)="registered.  It executes code that creates an HL7 ORM message consisting"
 .. S ^ORD(101,RA101,1,3,0)="of PID, ORC, OBR and OBX segments.  The message contains all relevant"
 .. S ^ORD(101,RA101,1,4,0)="information about the exam, including procedure, time of registration,"
 .. S ^ORD(101,RA101,1,5,0)="procedure modifiers, patient allergies, and clinical history."
 .. S ^ORD(101,RA101,1,0)="^^5^5^"_$$DT^XLFDT()_"^^^^"
 .. Q
 . D ERR("RA REG")
 . Q
RPT ; RA RPT protocol
 I '$D(^ORD(101,"B","RA RPT")) D
 . N RA101,RAFDA
 . S RAFDA(101,"+1,",.01)="RA RPT"
 . S RAFDA(101,"+1,",1)="Rad/Nuc Med report released/verified"
 . S RAFDA(101,"+1,",12)=$$PKG()
 . S RAFDA(101,"+1,",4)="event driver"
 . S RAFDA(101.01,"+2,+1,",.01)="RA SEND ORU"
 . S RAFDA(101,"+1,",20)="Q"
 . S RAFDA(101,"+1,",770.3)="ORU"
 . S RAFDA(101,"+1,",770.6)=$$PROID()
 . S RAFDA(101,"+1,",772)="Q"
 . S RAFDA(101,"+1,",99)=$$TSTMP()
 . S RAFDA(101,"+1,",770.4)="R01"
 . D MSG("RA RPT")
 . D UPDATE^DIE("E","RAFDA")
 . I $D(^ORD(101,"B","RA RPT")) D  Q
 .. S RA101=$O(^ORD(101,"B","RA RPT",0))
 .. K RAFDA S RAFDA(101,RA101_",",770.95)=2.1 D FILE^DIE("E","RAFDA")
 .. S ^ORD(101,RA101,1,1,0)="This protocol is triggered whenever a Radiology/Nuclear Medicine report"
 .. S ^ORD(101,RA101,1,2,0)="enters into a status of Verified or Released/Not Verified.  It executes"
 .. S ^ORD(101,RA101,1,3,0)="code that creates an HL7 ORU message consisting of PID, OBR and OBX"
 .. S ^ORD(101,RA101,1,4,0)="segments.  The message contains relevant information about the report,"
 .. S ^ORD(101,RA101,1,5,0)="including procedure, procedure modifiers, diagnostic code, interpreting"
 .. S ^ORD(101,RA101,1,6,0)="physician, impression text and report text."
 .. S ^ORD(101,RA101,1,0)="^^6^6^"_$$DT^XLFDT()_"^^"
 .. Q
 . D ERR("RA RPT")
 . Q
 Q
ERR(X) ; Display an error message if the protocol does not get filed into 101.
 N TXT S TXT(1)="",TXT(2)="Protocol: '"_X_"' was not filed."
 S TXT(3)="IRM should investigate." D MES^XPDUTL(.TXT)
 Q
MSG(X) ; Display to the user the protocol being added to file 101
 N RATXT S RATXT(1)=" ",RATXT(2)="Adding '"_X_"' to the protocol file."
 D MES^XPDUTL(.RATXT)
 Q
PKG() ; Return the name of the package
 Q "RADIOLOGY/NUCLEAR MEDICINE"
PROID() ; Return the Processing ID data
 Q "PRODUCTION"
TSTMP() ; Timestamp the protocol entry with current date/time (in $H format)
 Q $$FMTH^XLFDT($$NOW^XLFDT())
