DG53672E ;ALB/BRM,ERC - DG*5.3*672 Post-install Updates ; 8/19/05 1:48pm
 ;;5.3;Registration;**672**;Aug 13, 1993
 ;
PRE ; Rename/Inactivate eligibility codes and enrollment statuses
 ;
 N ELCODE,ENSTAT,NEWSTAT,NEWCODE
 K XPDABORT
 S ENSTAT="PENDING; NO ELIGIBILITY CODE IN VIVA"
 S NEWSTAT="PENDING; NO ELIGIBILITY CODE"
 D RENAM(ENSTAT,NEWSTAT,1)
 D CHKIEN("PENDING; NO ELIGIBILITY CODE",15) Q:$G(XPDABORT)
 D CHKIEN("PENDING; ELIGIBILITY STATUS IS UNVERIFIED",17) Q:$G(XPDABORT)
 S ELCODE="TRICARE/CHAMPUS",NEWCODE="TRICARE"
 D RENAM(ELCODE,NEWCODE,0)
 S ELCODE="MEXICAN BORDER WAR" D INACT(ELCODE)
 S ELCODE="REIMBURSABLE INSURANCE" D INACT(ELCODE)
 D MAP1010
 Q
 ;
RENAM(OLD,NEW,FLG) ; Rename Eligibility Code or Enrollment Status Code
 ;
 ;  OLD - Old Name for Enrollment Status or Eligibility Code
 ;  NEW - New Name for Enrollment Status or Eligibility Code
 ;  FLG - Positive value if renaming Enrollment Status (optional)
 ;
 N NAMEX,NAMEX1
 I $G(FLG) D  Q  ;rename enrollment status
 .S NAMEX=$E(OLD,1,30),NAMEX1=$E(NEW,1,30),DGIEN=""
 .I '$O(^DGEN(27.15,"B",NAMEX,"")),'$O(^DGEN(27.15,"B",NAMEX1,"")) D BMES^XPDUTL(OLD_" does not exist in file #27.15 - Please contact EVS for assistance.") Q
 .I '$O(^DIC(27.15,"B",NAMEX,"")),$O(^DIC(27.15,"B",NAMEX1,"")) D BMES^XPDUTL(OLD_" has already been renamed in file #27.15") Q
 .F  S DGIEN=$O(^DGEN(27.15,"B",NAMEX,DGIEN)) Q:'DGIEN  D
 ..I $P($G(^DGEN(27.15,DGIEN,0)),"^")=NEW D BMES^XPDUTL(OLD_" has already been renamed in file #27.15.") Q
 ..S DGFDA(27.15,DGIEN_",",.01)=NEW
 ..D FILE^DIE("K","DGFDA","DGERR")
 ..I $D(DGERR) D ERRDISP(.DGERR,"Failed to Rename "_OLD_" in ENROLLMENT STATUS file (#27.15).") Q
 ..D BMES^XPDUTL(OLD_" renamed to "_NEW_" in file #27.15")
 ;
 ; rename eligibility code in file #8
 S NAMEX=$E(OLD,1,30),NAMEX1=$E(NEW,1,30),DGIEN=""
 D  ; attempt rename in file #8.1 even if file #8 fails
 .I '$O(^DIC(8,"B",NAMEX,"")),'$O(^DIC(8,"B",NAMEX1,"")) D BMES^XPDUTL(OLD_" does not exist in file #8 - Please contact EVS for assistance.") Q
 .I '$O(^DIC(8,"B",NAMEX,"")),$O(^DIC(8,"B",NAMEX1,"")) D BMES^XPDUTL(OLD_" has already been renamed in file #8") Q
 .F  S DGIEN=$O(^DIC(8,"B",NAMEX,DGIEN)) Q:'DGIEN  D
 ..I $P($G(^DIC(8,DGIEN,0)),"^")=NEW D BMES^XPDUTL(OLD_" has already been renamed in file #8") Q
 ..S DGFDA(8,DGIEN_",",.01)=NEW
 ..D FILE^DIE("K","DGFDA","DGERR")
 ..I $D(DGERR) D ERRDISP(.DGERR,"Failed to Rename "_OLD_" in ELIGIBILITY CODE file (#8).") Q
 ..D BMES^XPDUTL(OLD_" renamed to "_NEW_" in file #8")
 ;
 ; rename eligibility code in file #8.1
 K DGFDA,DGERR
 I '$O(^DIC(8.1,"B",NAMEX,"")),'$O(^DIC(8.1,"B",NAMEX1,"")) D BMES^XPDUTL(OLD_" does not exist in file #8.1 - Please contact EVS for assistance.") Q
 I '$O(^DIC(8.1,"B",NAMEX,"")),$O(^DIC(8.1,"B",NAMEX1,"")) D BMES^XPDUTL(OLD_" has already been renamed in file #8.1") Q
 S DGIEN="" F  S DGIEN=$O(^DIC(8.1,"B",NAMEX,DGIEN)) Q:'DGIEN  D
 .I $P($G(^DIC(8.1,DGIEN,0)),"^")=NEW D BMES^XPDUTL(OLD_" has already been renamed in file #8.1") Q
 .S DGFDA(8.1,DGIEN_",",.01)=NEW
 .D FILE^DIE("K","DGFDA","DGERR")
 .I $D(DGERR) D ERRDISP(.DGERR,"Failed to Rename "_OLD_" in MAS ELIGIBILITY CODE file (#8.1).") Q
 .D BMES^XPDUTL(OLD_" renamed to "_NEW_" in file #8.1")
 Q
CHKIEN(ENSTAT,ENIEN) ; Verify IEN of records in the Enrollment Status file (#27.15)
 Q:$G(ENSTAT)=""  Q:$G(ENIEN)=""
 I $O(^DGEN(27.15,"B",$E(ENSTAT,1,30),""))=ENIEN Q
 ; The enrollment status is missing or has the wrong IEN, abort install
 S XPDABORT=2
 D BMES^XPDUTL(">>> ERROR IN ENROLLMENT STATUS FILE #27.15 <<<")
 D BMES^XPDUTL("Enrollment Status '"_ENSTAT_"' should be record #"_ENIEN)
 D BMES^XPDUTL("Please contact EVS for assistance")
 D BMES^XPDUTL(">>>>>> INSTALLATION ABORTED <<<<<<")
 Q
INACT(ELCODE) ; Inactivate Eligibility Codes
 N DGIEN,DGERR,DGFDA,NAMEX
 ; This code is in the ELIGIBILITY CODE file (#8).
 D  ;  allow file #8.1 checks to occur even if error msg for file #8
 .S NAMEX=$E(ELCODE,1,30),DGIEN=""
 .I '$O(^DIC(8,"B",NAMEX,"")) D BMES^XPDUTL(ELCODE_" does not exist in file #8 - Please contact EVS for assistance.")
 .F  S DGIEN=$O(^DIC(8,"B",NAMEX,DGIEN)) Q:'DGIEN  D
 ..I $P($G(^DIC(8,DGIEN,0)),"^",7) D BMES^XPDUTL(ELCODE_" has already been deactivated in file #8.") Q
 ..S DGFDA(8,DGIEN_",",6)=1
 ..D FILE^DIE("K","DGFDA","DGERR")
 ..I $D(DGERR) D ERRDISP(.DGERR,"Failed to Inactivate "_ELCODE_" in ELIGIBILITY CODE file (#8).") Q
 ..D BMES^XPDUTL(ELCODE_" successfully deactivated in file #8")
 ;
 ; This code is in the MAS ELIGIBILITY CODE file (#8.1).
 K DGFDA,DGERR
 I '$O(^DIC(8.1,"B",NAMEX,"")) D BMES^XPDUTL(ELCODE_" does not exist in #8.1 - Please contact EVS for assistance.") Q
 S DGIEN="" F  S DGIEN=$O(^DIC(8.1,"B",NAMEX,DGIEN)) Q:'DGIEN  D
 .D OTHR8(DGIEN)
 .I $P($G(^DIC(8.1,DGIEN,0)),"^",7) D BMES^XPDUTL(ELCODE_" has already been deactivated in file #8.1.") Q
 .S DGFDA(8.1,DGIEN_",",6)=1
 .D FILE^DIE("K","DGFDA","DGERR")
 .I $D(DGERR) D ERRDISP(.DGERR,"Failed to Inactivate "_ELCODE_" in MAS ELIGIBILITY CODE file (#8.1).") Q
 .D BMES^XPDUTL(ELCODE_" successfully deactivated in file #8.1")
 Q
 ;
OTHR8(IEN) ; find all site-specific eligibility codes pointing to ELCODE
 ;
 Q:'$G(IEN)
 N IEN2,NAME,DGFDA,DGERR
 S IEN2="" F  S IEN2=$O(^DIC(8,"D",IEN,IEN2)) Q:'IEN2  D
 .S NAME=$P($G(^DIC(8,IEN2,0)),"^")
 .Q:NAME=$P($G(^DIC(8.1,IEN,0)),"^")
 .I $P($G(^DIC(8,IEN2,0)),"^",7) D BMES^XPDUTL(NAME_" has already been deactivated in file #8.") Q
 .S DGFDA(8,IEN2_",",6)=1
 .D FILE^DIE("K","DGFDA","DGERR")
 .I $D(DGERR) D ERRDISP(.DGERR,"Failed to Inactivate "_NAME_" in ELIGIBILITY CODE file (#8).") Q
 .D BMES^XPDUTL(NAME_" successfully deactivated in file #8")
 Q
ERRDISP(DGERR,TXT) ; Display FM error message.
 N ERR,LINE
 S (ERR,LINE)=0
 D BMES^XPDUTL(TXT)
 F  S ERR=$O(DGERR("DIERR",ERR)) Q:'ERR  F  S LINE=$O(DGERR("DIERR",ERR,"TEXT",LINE)) Q:LINE']""  D BMES^XPDUTL("     "_DGERR("DIERR",ERR,"TEXT",LINE))
 D BMES^XPDUTL("Please contact EVS for assistance")
 Q
MAP1010 ;the 1010EZ Mapping file (#711) links a 1010EZ field with the Patient
 ;file field to which it maps.  DG*5.3*672 changes the mapping of the
 ;DISABILITY RETIREMENT FROM MILITARY field from .362 - DISABILITY RET. 
 ;FROM MILITARY? to .3602 - REC'ING MILITARY RETIREMENT? and from 
 ;1010.158 - DISABILITY DISCHARGE ON 1010EZ to .3603 - DISCH. DUE TO 
 ;DISABILITY?
 N DG1010,DG362,DGFDA,DGFLD,DGMES,DGPARAM,ERR
 S DG1010=$O(^EAS(711,"B","DISABILITY DISCHARGE CLAIMED",0))
 S DG362=$O(^EAS(711,"B","DISABILITY RETIREMENT FROM MIL",0))
 I $G(DG362)]"" S DGFDA(711,DG362_",",4)=.3602
 I $G(DG1010)]"" S DGFDA(711,DG1010_",",4)=.3603
 D FILE^DIE("S","DGFDA","DGERR")
 S ERR=""
 F  S ERR=$O(DGERR("DIERR",ERR)) Q:'ERR  D
 . F  S LINE=$O(DGERR("DIERR",ERR,"TEXT",LINE)) Q:LINE']""  D
 . . D BMES^XPDUTL("     "_DGERR("DIERR",ERR,"TEXT",LINE))
 . . D BMES^XPDUTL("Please contact EVS for assistance")
 . . S DGPARAM(ERR)=$G(DGERR("DIERR",ERR,"PARAM",1))
 I $G(DGPARAM(2)) Q  ;if there are 2 params, then both failed
 I '$D(DGPARAM) D FLD3602,FLD3603 ;if there are no params, then neither failed
 ;only one field failed, so determine which one and send success message
 ;for the other
 I $G(DGPARAM(1))=.3602 D FLD3603
 I $G(DGPARAM(1))=.3603 D FLD3602
 I $D(DGMES) D BMES^XPDUTL(.DGMES)
 Q
FLD3602 ;
 S DGFLD="DISABILITY RETIREMENT FROM MILITARY"
 S DGMES(1)="Changed mapping of "_DGFLD_" in file #711 from .362 to .3602"
 Q
FLD3603 ;
 S DGFLD="DISABILITY DISCHARGE CLAIMED"
 S DGMES(2)="Changed mapping of "_DGFLD_" in file #711 from 1010.158 to .3603"
 Q
