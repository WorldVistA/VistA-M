GMVVDEFK ;BPOIFO/JG,HIOFO/FT - KIDS POST INSTALL FOR VDEF PATCH ; 04 Oct 2004  3:16 PM
 ;;5.0;GEN. MED. REC. - VITALS;**5**;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ;    #4447 - POSTKID^VDEF   (controlled)
 ;   #10141 - XPDUTL calls   (controlled)
 ;
 ; This program is used as the KIDS Post-Install routine
 ; for the second VDEF patch that installs GMV application
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
 ;    SUBDESC - Subtype description (Required only if new subtype)
 ;
 ; If needed, POSTKID^VDEFVU will generate error message (BMES^XPDUTL)
 ; and set KIDABORT=1
 ;
 K XPDABORT
 I $G(XPDNM)="" D BMES^XPDUTL("Must be run as a KIDS Post-Install process.") S XPDABORT=1 Q
 N MSGTYP,EVNTYP,SUBTYP,PROTO,CUSTPKG,EXTROUT,EVDESC,SUBDESC,ERRMSG,KIDABORT
 ;
 ; Create Vitals Event
 S MSGTYP="ORU"
 S EVNTYP="R01"
 S SUBTYP="VTLS"
 S EXTROUT="GMVVDEF1"
 S PROTO="GMRV ORU R01 VITALS VS"
 S CUSTPKG="GEN. MED. REC. - VITALS"
 S EVDESC="PATIENT VITALS"
 S SUBDESC="VITALS MEASUREMENTS"
 D POSTKID^VDEFVU(MSGTYP,EVNTYP,SUBTYP,PROTO,CUSTPKG,EXTROUT,EVDESC,SUBDESC,.KIDABORT)
 Q:$G(KIDABORT)
 ;
 ; Success!!
 D BMES^XPDUTL("VDEF Event(s) successfully installed in VDEF globals.")
 Q
