PSOVDFK ;BPOIFO/JG-KIDS POST INSTALL FOR VDEF PATCH ;10/05/04
 ;;7.0;OUTPATIENT PHARMACY;**190**;DEC 1997
 ;
 ; This routine uses the following IAs:
 ;    #4447 - POSTKID^VDEF   (controlled)
 ;   #10141 - XPDUTL calls   (controlled)
 ;
 ; This program is used as the KIDS Post-Install routine
 ; for the second VDEF patch that installs PSO application
 ; specific components that are required by VDEF to construct
 ; a message.
 ;
POSTKID ; Entry point
 ; Inputs that are required by POSTKID^VDEFVU:
 ;    MSGTYP - HL7 message type (RDE, RDS, etc)
 ;    EVNTYP - HL7 event type (O11, O13, etc)
 ;    SUBTYP - VDEF Event Subtype (PRES, PPAR, PREF etc)
 ;    PROTO - VistA HL7 Event Driver Protocol Name
 ;    CUSTPKG - Custodial Package Name
 ;    EXTROUT - VDEF Message Extraction Program
 ;    EVDESC - Event description
 ;    SUBDESC - Subtype description (Required only if new subtype)
 ;
 ; If needed, POSTKID^VDEFVU will generate error message (BMES^XPDUTL)
 ; and set KIDABORT=1
 ;
 K XPDABORT
 I $G(XPDNM)="" D BMES^XPDUTL("Must be run as a KIDS Post-Install process.") S XPDABORT=1 Q
 N MSGTYP,EVNTYP,SUBTYP,PROTO,CUSTPKG,EXTROUT,EVDESC,SUBDESC,ERRMSG,KIDABORT
 ;
 ; Create OP Pharm Prescription Event
 S MSGTYP="RDE"
 S EVNTYP="O11"
 S SUBTYP="PRES"
 S PROTO="PSO VDEF RDE O11 OP PHARM PRES VS"
 S CUSTPKG="OUTPATIENT PHARMACY"
 S EXTROUT="PSOVDF1"
 S EVDESC="OP PHARM PRESCRIPTION"
 S SUBDESC="OP PHARMACY PRESCRIPTION"
 D POSTKID^VDEFVU(MSGTYP,EVNTYP,SUBTYP,PROTO,CUSTPKG,EXTROUT,EVDESC,SUBDESC,.KIDABORT)
 Q:$G(KIDABORT)
 ;
 ; Create OP Pharm Prescription Partial Event
 S MSGTYP="RDS"
 S EVNTYP="O13"
 S SUBTYP="PPAR"
 S PROTO="PSO VDEF RDS O13 OP PHARM PPAR VS"
 S EVDESC="OP PHARM PRESCRIPTION PARTIAL"
 S SUBDESC="OP PHARMACY PRESCRIPTION PARTIAL"
 D POSTKID^VDEFVU(MSGTYP,EVNTYP,SUBTYP,PROTO,CUSTPKG,EXTROUT,EVDESC,SUBDESC,.KIDABORT)
 Q:$G(KIDABORT)
 ;
 ; Create OP Pharm Prescription Refill Event
 S SUBTYP="PREF"
 S PROTO="PSO VDEF RDS O13 OP PHARM PREF VS"
 S EVDESC="OP PHARM PRESCRIPTION REFILL"
 S SUBDESC="OP PHARMACY PRESCRIPTION REFILL"
 D POSTKID^VDEFVU(MSGTYP,EVNTYP,SUBTYP,PROTO,CUSTPKG,EXTROUT,EVDESC,SUBDESC,.KIDABORT)
 Q:$G(KIDABORT)
 ;
 ; Success!!
 D BMES^XPDUTL("VDEF Event(s) successfully installed in VDEF globals.")
 Q
