RORP022 ;ALB/TK - CCR PRE/POST-INSTALL PATCH 22 ;29 Jul 2014  4:02 PM
 ;;1.5;CLINICAL CASE REGISTRIES;**22**;Feb 17, 2006;Build 17
 ;
 ; This routine uses the following IAs:
 ; #3277         OWNSKEY^XUSRB (supported)
 ; #10006        ^DIC (supported)
 ; #2051         FIND1^DIC (supported)
 ; #2053         UPDATE^DIE (supported)
 ; #10009        FILE^DICN (supported)
 ; #10018        ^DIE (supported)
 ; #5747         CODEABA^ICDEX (controlled)
 ; #2054         LOCK^DILF (supported)
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*22   FEB  2012   T KOPP       Support for ICD-10 Coding System
 ;******************************************************************************
 ;******************************************************************************
 ;
 Q
 ;Pre-Install routine for Patch 22
PRE ;
 ; CHECK FOR ROR VA IRM KEY, ABORT IF USER DOES NOT POSSESS
 N RORKEYOK
 D BMES^XPDUTL("Verifying installing user has the ROR VA IRM security key")
 D OWNSKEY^XUSRB(.RORKEYOK,"ROR VA IRM",DUZ)
 I '$G(RORKEYOK(0)) D  Q
 . S XPDABORT=1
 . D BMES^XPDUTL("****** INSTALL ABORTED!!! ******")
 . D BMES^XPDUTL("This patch can only be installed by a user who is assigned the ROR VA IRM key")
 . D BMES^XPDUTL("Restart the installation again once the appropriate key has been assigned")
 D BMES^XPDUTL("  User has the ROR VA IRM key - OK to install")
 Q
 ;
 ;Post-Install routine for Patch 22
POST ;
 N DIC,DA,X,Y,RORRULEDESC,RORRULEFILE,RORRULEEXPR,RORRULENAME,RORRULEIEN
 N RORREGNAME,RORREGIEN,ROREXISTIEN,RORDATA,RORDXS,RORICDIEN,ROREXISTICDIEN
 N DA,DIE,DR,ROR,ROR1,ROR10,RORCT,ROREG,RORX,RORY,RORZ
 ;
 ;Updating existing Selection Rule records with Coding System
 D BMES^XPDUTL("Updating ICD-9 selection rules with ICD-9 coding system")
 S ROR=0 F  S ROR=$O(^ROR(798.2,ROR)) Q:'ROR  D
 . S RORRULENAME=$P($G(^ROR(798.2,ROR,0)),U),RORRULEFILE=$P($G(^(0)),U,2)
 . Q:$S(RORRULENAME["VA HIV":1,RORRULENAME["VA HEPC":1,1:RORRULENAME["(ICD10)")
 . K DIE S DIE="^ROR(798.2,",DA=ROR,DR="7////1"
 . I +$G(^ROR(798.2,ROR,5))'=1 D LOCK^DILF("^ROR(798.2,"_ROR_")") I $T D ^DIE L -^ROR(798.2,ROR)
 ;
 ; Pull ICD-10 codes for each registry from text
 D BMES^XPDUTL("Adding appropriate ICD-10 codes to each registry")
 K ^TMP("ROR-ICD10",$J)
 S ROREG=""
 F RORX=1:1 S RORY=$P($T(ICD10+RORX^RORP022A),";;",2) Q:RORY=""  D
 . I $P(RORY,U)'="" D
 . . N DIC,X,Y
 . . S DIC="^ROR(798.1,",X=$P(RORY,U),DIC(0)="" D ^DIC I Y>0 S ROREG=+Y
 . I ROREG>0 F RORZ=1:1 S ROR10=$P($P(RORY,U,2),",",RORZ) Q:ROR10=""  S ^TMP("ROR-ICD10",$J,ROREG,ROR10)=""
 ;
 ;Adding ICD-10 codes to ICD Search records (#798.5)
 D BMES^XPDUTL("Adding ICD-10 codes to ICD SEARCH records")
 S ROR=0 F  S ROR=$O(^ROR(798.1,ROR)) Q:'ROR  D  S ^TMP("ROR-ICD10",$J,ROR)=RORCT
 . S RORCT=0
 . S RORREGNAME=$P($G(^ROR(798.1,ROR,0)),U)
 . S X=RORREGNAME,DIC="^ROR(798.5,",DIC(0)="" D ^DIC S RORREGIEN=+Y
 . Q:$S(RORREGIEN<0:1,RORREGNAME="VA HIV":1,RORREGNAME="VA HEPC":1,1:0)
 . S RORDXS="" F  S RORDXS=$O(^TMP("ROR-ICD10",$J,ROR,RORDXS)) Q:RORDXS=""  D
 . . S RORICDIEN=+$$CODEABA^ICDEX(RORDXS,"",30)
 . . Q:RORICDIEN<0
 . . S RORCT=RORCT+1
 . . S ROREXISTICDIEN=$$FIND1^DIC(798.51,","_RORREGIEN_",","Q",RORICDIEN,"B")
 . . Q:ROREXISTICDIEN'=0  ;quit if code is already assigned to rule 
 . . K RORDATA
 . . S RORDATA(1,798.51,"+2,"_RORREGIEN_",",.01)=RORICDIEN
 . . D UPDATE^DIE("","RORDATA(1)")
 ;
 ;Creating new Selection Rule records (#798.2)
 D BMES^XPDUTL("Creating new selection rules using ICD-10 codes")
 S ROR=0 F  S ROR=$O(^ROR(798.2,ROR)) Q:'ROR  D
 . S RORRULENAME=$P($G(^ROR(798.2,ROR,0)),U),RORRULEFILE=$P($G(^(0)),U,2)
 . Q:$S(RORRULENAME="":1,RORRULENAME["VA HIV":1,RORRULENAME["VA HEPC":1,1:RORRULENAME["(ICD10)")
 . S RORRULENAME=RORRULENAME_" (ICD10)",RORRULEDESC=""
 . ;
 . I RORRULEFILE=9000011 D
 .. S RORRULEDESC="ICD-10 code in problem list"
 .. S RORRULEEXPR="+$D(^ROR(798.5,REGIEN,1,""B"",+{I:DIAGNOSIS}))"
 . ;
 . I RORRULEFILE=9000010.07 D
 .. S RORRULEDESC="ICD-10 code in outpatient file"
 .. S RORRULEEXPR="+$D(^ROR(798.5,REGIEN,1,""B"",+{I:POV}))"
 . ;
 . I RORRULEFILE=45 D
 .. S RORRULEDESC="ICD-10 code in inpatient file"
 .. S RORRULEEXPR="$$PTFRULE^RORUPD09(REGIEN)"
 . ;
 . I RORRULEDESC'="" D NEWRULE(RORRULENAME,RORRULEEXPR,RORRULEFILE,RORRULEDESC)
 . ;
 . ;Updating existing Registry records with new Selection Rules
 D BMES^XPDUTL("Updating registries with new ICD-10 selection rules")
 S ROR=0 F  S ROR=$O(^ROR(798.1,ROR)) Q:'ROR  D
 . S RORREGNAME=$P($G(^ROR(798.1,ROR,0)),U),RORREGIEN=ROR
 . Q:$S(RORREGNAME["VA HIV":1,RORREGNAME["VA HEPC":1,1:RORREGNAME["(ICD10)")
 . F ROR1=" PROBLEM"," VPOV"," PTF" D
 . . ; Only add if the rule without the ICD10 already exists
 . . Q:'$$FIND1^DIC(798.13,","_RORREGIEN_",","X",RORREGNAME_ROR1,"B")
 . . S RORRULENAME=RORREGNAME_ROR1_" (ICD10)"
 . . S RORRULEIEN=$$SRLIEN^RORUTL02(RORRULENAME)
 . . Q:RORRULEIEN<0  ;quit if rule doesn't exist in 798.2
 . . S ROREXISTIEN=$$FIND1^DIC(798.13,","_RORREGIEN_",","X",RORRULENAME,"B")
 . . Q:ROREXISTIEN'=0  ;quit if rule is already assigned to registry
 . . K RORDATA
 . . S RORDATA(1,798.13,"+2,"_RORREGIEN_",",.01)=RORRULENAME
 . . D UPDATE^DIE("","RORDATA(1)")
 ;
 K ^TMP("ROR-ICD10",$J)
 K DIE,DA,DR
 D BMES^XPDUTL("Post-install complete")
 Q
 ;
 ;Creating a new Selection Rule record in File #798.2
NEWRULE(NAME,EXPR,FILE,DESC) ;
 N DIC,RORIEN,X,Y
 S RORIEN=$$SRLIEN^RORUTL02(NAME)  ;check if rule already exists
 I RORIEN<0 S DIC(0)="",DIC="^ROR(798.2,",X=NAME D FILE^DICN S RORIEN=$P(Y,U,1)
 K DIC,X,Y
 Q:RORIEN<0
 D LOCK^DILF("^ROR(798.2,"_RORIEN_")") Q:'$T
 K DIE S DIE="^ROR(798.2,",DA=RORIEN,DR=".09////1;1////"_EXPR_";2////"_FILE_";4////"_DESC_";7////30"
 D ^DIE
 L -^ROR(798.2,RORIEN)
 K DIE,DA,DR
 Q
 ;
