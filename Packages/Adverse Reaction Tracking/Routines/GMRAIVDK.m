GMRAIVDK ;BPOIFO/JG - KIDS POST INSTALL FOR VDEF PATCH ;10/5/04  08:57
 ;;4.0;ADVERSE REACTION TRACKING;**22,23**;Mar 29, 1996
 ;
 ; This routine uses the following IAs:
 ;    #4447 - POSTKID^VDEF   (controlled)
 ;   #10141 - XPDUTL calls   (controlled)
 ;
 ; This program is used as the KIDS Post-Install routine
 ; for the second VDEF patch that installs GMRA application
 ; specific components that are required by VDEF to construct
 ; a message.
 ;
POSTKID ; Entry point
 ; Inputs that are required by POSTKID^VDEFVU:
 ;    MSGTYP - HL7 message type (ADT, ORU, etc)
 ;    EVNTYP - HL7 event type (A60, R01, etc)
 ;    SUBTYP - VDEF Event Subtype (ALGY, PPAR, etc)
 ;    PROTO - VistA HL7 Event Driver Protocol Name
 ;    CUSTPKG - Custodial Package Name
 ;    EXTROUT - VDEF Message Extraction Program
 ;    EVDESC - Event description
 ;    SUBDESC - Subtype description
 ;
 ; If needed, POSTKID^VDEFVU will generate error message (BMES^XPDUTL)
 ; and set GMRABORT=1
 ;
 K XPDABORT
 I $G(XPDNM)="" D BMES^XPDUTL("Must be run as a KIDS Post-Install process.") S XPDABORT=1 Q
 N MSGTYP,EVNTYP,SUBTYP,PROTO,CUSTPKG,EXTROUT,EVDESC,SUBDESC,ERRMSG,GMRABORT
 ;
 ; Create Allergy Update/Insert Event
 S MSGTYP="ORU"
 S EVNTYP="R01"
 S SUBTYP="ALGY"
 S PROTO="GMRA VDEF ORU R01 ALLERGY VS"
 S CUSTPKG="ADVERSE REACTION TRACKING"
 S EXTROUT="GMRAIAL1"
 S EVDESC="ALLERGY UPDATE/INSERT"
 S SUBDESC="ALLERGY UPDATE/INSERT"
 D POSTKID^VDEFVU(MSGTYP,EVNTYP,SUBTYP,PROTO,CUSTPKG,EXTROUT,EVDESC,SUBDESC,.GMRABORT)
 Q:$G(GMRABORT)
 ;
 ; Create Allergy Assessment Event
 S SUBTYP="ADAS"
 S PROTO="GMRA VDEF ORU R01 ADV ASSESS VS"
 S EVDESC="ALLERGY ASSESSMENT"
 S SUBDESC="ALLERGY ASSESSMENT"
 D POSTKID^VDEFVU(MSGTYP,EVNTYP,SUBTYP,PROTO,CUSTPKG,EXTROUT,EVDESC,SUBDESC,.GMRABORT)
 Q:$G(GMRABORT)
 ;
 ; Create Adverse Reaction Report Event
 S SUBTYP="ADRA"
 S PROTO="GMRA VDEF ORU R01 ADV REACT VS"
 S EXTROUT="GMRAIAD1"
 S EVDESC="ADVERSE REACTION REPORT"
 S SUBDESC="ADVERSE REACTION"
 D POSTKID^VDEFVU(MSGTYP,EVNTYP,SUBTYP,PROTO,CUSTPKG,EXTROUT,EVDESC,SUBDESC,.GMRABORT)
 Q:$G(GMRABORT)
 ;
 ; Success!!
 D BMES^XPDUTL("VDEF Event(s) successfully installed in VDEF globals.")
 Q
