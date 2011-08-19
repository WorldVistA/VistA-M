VDEFVU ;BPOIFO/JG - VDEF Application Package Support; ; 21 Dec 2004  11:28 AM
 ;;1.00;VDEF;;Dec 17, 2004
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q  ; No Bozos
 ;
 ; KIDS Environment Check API
ENVCHK I $G(XPDENV)="" S ERRMSG="Must be run as a KIDS Environment Check." G KIDSABRT
 Q:$T(QUEUE^VDEFQM)'=""
 S ERRMSG="VDEF must be installed before this patch." G KIDSABRT
 Q
 ;
 ; KIDS Post-Install Application API
 ; Creates application specific entries in files #577 and #579.6
POSTKID(MSGTYP,EVNTYP,SUBTYP,PROTO,CUSTPKG,EXTROUT,EVDESC,SUBDESC,KIDABORT) ;
 I $G(XPDNM)="" S ERRMSG="Must be run as a KIDS Post-Install process." G KIDSABRT
 ;
 ; Inputs: (All are required except SUBDESC which is only required
 ;         when a new SUBTYP is being passed in)
 ;    MSGTYP - HL7 message type
 ;    EVNTYP - HL7 event type
 ;    SUBTYP - VDEF Event subtype
 ;    PROTO - VistA HL7 Event Driver Protocol Name
 ;    CUSTPKG - Custodial Package Name
 ;    EXTROUT - VDEF Message Extraction Program
 ;    EVDESC - Event description
 ;    SUBDESC - Subtype description if new subtype (optional)
 ;
 ; Outputs: None
 ;
 N FDA,ERRMSG,ERR,DATA,VAL,MSGIEN,EVNIEN,CUSTIEN,CUSTIENV,SUBIEN,PROTIEN
 N IEN577,FDA,X,NEWSUB
 ;
 ; Validate all the inputs
 I $G(MSGTYP)="" S ERRMSG="HL7 Message Type missing" G KIDSABRT
 I $G(EVNTYP)="" S ERRMSG="HL7 Event Type missing" G KIDSABRT
 I $G(SUBTYP)="" S ERRMSG="VDEF event subtype missing" G KIDSABRT
 I $G(PROTO)="" S ERRMSG="VistA HL7 Event Driver Protocol missing" G KIDSABRT
 I $G(CUSTPKG)="" S ERRMSG="Application's custodial package missing" G KIDSABRT
 I $G(EXTROUT)="" S ERRMSG="VDEF message extraction program missing" G KIDSABRT
 S X=EXTROUT D RTNVAL^VDEFEL
 I $G(X)="" S ERRMSG="Not a valid VDEF message extraction program" G KIDSABRT
 I $G(EVDESC)="" S ERRMSG="Event description missing" G KIDSABRT
 S MSGIEN=$$FIND1^DIC(771.2,"","BX",MSGTYP)
 I 'MSGIEN S ERRMSG="Invalid HL7 Message Type" G KIDSABRT
 S EVNIEN=$$FIND1^DIC(779.001,"","BX",EVNTYP)
 I 'EVNIEN S ERRMSG="Invalid HL7 Event Type" G KIDSABRT
 S SUBIEN=$$FIND1^DIC(577.4,"","BX",SUBTYP),NEWSUB='SUBIEN
 I NEWSUB,$G(SUBDESC)="" S ERRMSG="New Subtype requires a description" G KIDSABRT
 S PROTIEN=$$FIND1^DIC(101,"","BX",PROTO)
 I 'PROTIEN S ERRMSG="Invalid VistA HL7 Protocol" G KIDSABRT
 S CUSTIEN=$$FIND1^DIC(9.4,"","BX",CUSTPKG)
 I 'CUSTIEN S ERRMSG="Invalid Custodial Package" G KIDSABRT
 ;
 ; Add custodial pkg. to VDEF Custodial Package file #579.6 if new
 S ERRMSG="",CUSTIENV=$$FIND1^DIC(579.6,"","BX",CUSTPKG)
 I CUSTIENV=0 D
 . K FDA,ERR
 . S FDA(579.6,"+1,",.01)=CUSTIEN,FDA(579.6,"+1,",.02)="I"
 . D UPDATE^DIE("","FDA","CUSTIENV","ERR")
 . I $G(ERR("DIERR",1))>0 S ERRMSG=ERR("DIERR",1,"TEXT",1)
 . S CUSTIENV=CUSTIENV(1) K CUSTIENV(1)
 G KIDSABRT:ERRMSG'=""
 ;
 ; Add/update VDEF Subtype in File #577.4
 S ERRMSG="" K FDA,ERR
 S FDA(577.4,"?+1,",.01)=SUBTYP,FDA(577.4,"?+1,",.02)=SUBDESC
 D UPDATE^DIE("","FDA","SUBIEN","ERR")
 I $G(ERR("DIERR",1))>0 S ERRMSG=ERR("DIERR",1,"TEXT",1)
 S SUBIEN=SUBIEN(1) K SUBIEN(1)
 G KIDSABRT:ERRMSG'=""
 ;
 ; Add the event to the VDEF Event file #577
 K FDA,ERR
 S FDA(577,"?+1,",.01)=MSGTYP_"-"_EVNTYP_"-"_SUBTYP
 S FDA(577,"?+1,",.02)=EVNIEN,FDA(577,"?+1,",.03)=SUBIEN
 S FDA(577,"?+1,",.06)=MSGIEN,FDA(577,"?+1,",.07)=PROTIEN
 S FDA(577,"?+1,",.09)=CUSTIENV,FDA(577,"?+1,",.2)="I"
 S FDA(577,"?+1,",.3)=EXTROUT,FDA(577,"?+1,",1)=EVDESC
 D UPDATE^DIE("","FDA","IEN577","ERR")
 I $G(ERR("DIERR",1))>0 S ERRMSG=ERR("DIERR",1,"TEXT",1) G KIDSABRT
 ;
 ; Successful completion
 Q
 ;
 ; Post-install abort
KIDSABRT D BMES^XPDUTL(ERRMSG) S (XPDABORT,KIDABORT)=1
 Q
