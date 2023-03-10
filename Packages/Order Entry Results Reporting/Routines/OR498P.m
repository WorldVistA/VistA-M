OR498P ; SPOIFO/AJB - Post-Install ;Apr 20, 2021@12:23:32
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**498**;Dec 17, 1997;Build 38
 ;
 ; ICR# 2051,2053
 Q
PRE ;
 ; CLEAR OUT OLD 100.9 DD
 N DIU S DIU="^ORD(100.9,",DIU(0)="" D EN^DIU2
 ; KILL OFF THE 100.9 "E" CROSS REFERENCE
 K ^ORD(100.9,"E")
 ; CLEAR OUT OLD DATA IN REMOVED NODES OF 100.9
 N ORNI S ORNI=0 F  S ORNI=$O(^ORD(100.9,ORNI)) Q:'ORNI  D
 .I $D(^ORD(100.9,ORNI,6)) D
 ..S $P(^ORD(100.9,ORNI,6),U,5)=""
 ..S $P(^ORD(100.9,ORNI,6),U,6)=""
 .K ^ORD(100.9,ORNI,7)
 ;
 N ORRAORDDLG,ORSEQ10,ORIENS,ORFDA,ORERR
 ;
 S ORRAORDDLG=$O(^ORD(101.41,"B","RA OERR EXAM",0))
 I 'ORRAORDDLG D  Q
 . D BMES^XPDUTL("Error: Could not find RA OERR EXAM Order Dialog. Contact the implmentation team.")
 S ORSEQ10=$O(^ORD(101.41,ORRAORDDLG,10,"B",10,0))
 I 'ORSEQ10 D  Q
 . D BMES^XPDUTL("Error: Could not find sequence 10 (OR GTX URGENCY) in the RA OERR EXAM Order Dialog. Contact the implmentation team.")
 ;
 ; Update Input Transform and Screen for Seq #10 in the RA OERR EXAM Order Dialog entry
 S ORIENS=ORSEQ10_","_ORRAORDDLG_","
 S ORFDA(101.412,ORIENS,.1)="@"
 S ORFDA(101.412,ORIENS,14)="I $$RADURG^ORWDRA32(Y)"
 D FILE^DIE("E","ORFDA","ORERR")
 I $D(ORERR) D BMES^XPDUTL("Error updating RA OERR EXAM Order Dialog. Contact the implmentation team.")
 ;
 Q
 ;
 ;
POST ;
 N ERR,FDA,IEN
 S IEN=$$FIND1^DIC(101.24,"","X","ORCV ACTIVE MEDICATIONS","","","ERR"),IEN=IEN_","
 S FDA(101.24,IEN,.1)="" ; remove 'YES' from INVERT field
 D FILE^DIE("","FDA","ERR")
 D BMES^XPDUTL("Updating Cover Sheet Immunizations Report")
 N ORERR,ORFDA,ORIEN
 S ORIEN=$$FIND1^DIC(101.24,"","X","ORCV IMMUNIZATIONS","","","ORERR"),ORIEN=ORIEN_","
 S ORFDA(101.24,ORIEN,.21)="A"
 D FILE^DIE("","ORFDA","ORERR")
 I $D(ORERR) D BMES^XPDUTL("Error Updating Immunizations Report. Contact the implmentation team.")
 ; change file security for 100.3
 N SECURITY
 S SECURITY("DD")=""
 S SECURITY("RD")=""
 S SECURITY("WR")=""
 S SECURITY("DEL")="@"
 S SECURITY("LAYGO")="@"
 S SECURITY("AUDIT")=""
 D FILESEC^DDMOD(100.3,.SECURITY)
 D BMES^XPDUTL("Updating ORB URGENCY to Low at PKG level for notification SMART NON-CRITICAL IMAGING RES")
 N ORURGER
 D EN^XPAR("PKG.ORDER ENTRY/RESULTS REPORTING","ORB URGENCY",85,"Low",.ORURGER)
 Q
