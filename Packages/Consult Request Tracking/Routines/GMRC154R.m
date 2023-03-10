GMRC154R ;Cerner/MKN - Pre-install GMRC*3.0*154; 12/16/19 09:23
 ;;3.0;CONSULT/REQUEST TRACKING;**154**;DEC 16, 2019;Build 135
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q  ;don't start at the top
 ;
EN ;
 N ERR,IEN,MGN,MGNA,X
 ;
 ;Create new CRNR Mail Groups
 F MGN=1:1 S X=$T(CRNRMGS+MGN) Q:X=" ;;"  K MGWP S MGNA=$P(X,";",2),MGWP(1,0)=$P(X,";",3) D:$O(^XMB(3.8,"B",MGNA,""))=""
 . D BMES^XPDUTL("Adding new CRNR Mail Group: "_MGNA)
 . K ERR,FDA,IEN S FDA(3.8,"+1,",.01)=MGNA,FDA(3.8,"+1,",4)="PR" D UPDATE^DIE("","FDA","IEN","ERR")
 . I $D(ERR) D BMES^XPDUTL("Error while adding Mail Group: "_MGNA_" "_$G(ERR)) Q
 . S IEN=IEN(1)
 . K ERR D WP^DIE(3.8,IEN_",",3,,"MGWP","ERR")
 . I $D(ERR) D BMES^XPDUTL("Error while adding Mail Group description for: "_MGNA_" "_$G(ERR)) Q
 . D BMES^XPDUTL("Mail Group "_MGNA_" added")
 ;Add OEHRMTIERIISupport to MEMBERS REMOTE in GMRC TIER II CRNR IFC ERRORS mail group
 S IEN=$O(^XMB(3.8,"B","GMRC TIER II CRNR IFC ERRORS","")) D:IEN
 . Q:$O(^XMB(3.8,IEN,6,"B","OEHRMTIERIISupport@domain.ext",""))  ;Already there
 . K ERR,FDA S FDA(3.812,"+1,"_IEN_",",.01)="OEHRMTIERIISupport@domain.ext" D UPDATE^DIE("","FDA","","ERR")
 ;Add GMRC TIER II CRNR IFC ERRORS as a MEMBER GROUP in IFC PATIENT ERROR MESSAGES mail group
 S IEN=$O(^XMB(3.8,"B","IFC PATIENT ERROR MESSAGES","")) D:IEN
 . Q:$O(^XMB(3.8,IEN,5,"B","GMRC TIER II CRNR IFC ERRORS",""))  ;Already there
 . K ERR,FDA S FDA(3.811,"+1,"_IEN_",",.01)="GMRC TIER II CRNR IFC ERRORS" D UPDATE^DIE("","FDA","","ERR")
 ;
CRNRMGS ;New Cerner Mail Groups
 ;GMRC CRNR IFC CLIN ERRORS;This Mail Group informs members of any clinical errors arising from IFC messages from Cerner.
 ;GMRC CRNR IFC ERRORS;This Mail Group informs members of any non-clinical and non-technical errors arising from IFC messages from Cerner. 
 ;GMRC CRNR IFC TECH ERRORS;This Mail Group informs members of any technical errors arising from IFC messages from Cerner. 
 ;GMRC TIER II CRNR IFC ERRORS;Tier II Errors Mail Group;This Mail Group informs Tier II members of any clinical errors arising from IFC messages from Cerner.
 ;;
 Q
 ;
