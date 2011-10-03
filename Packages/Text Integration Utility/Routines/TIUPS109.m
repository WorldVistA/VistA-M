TIUPS109 ;SLC/RMO - Post-Install for TIU*1*109 ;11/7/00@10:04:20
 ;;1.0;Text Integration Utilities;**109**;Jun 20, 1997
 ;
 ;Register TIU RPCs that support Clinical Procedures
 D ENREG
 ;
 ;Create or Update Clinical Procedures Class
 D ENCP
 Q
 ;
ENREG ;Entry point to Register TIU RPCs that support Clinical Procedures
 N MENU,RPC
 S MENU="OR CPRS GUI CHART"
 F RPC="TIU IS THIS A CLINPROC?","TIU IDENTIFY CLINPROC CLASS","TIU LONG LIST CLINPROC TITLES" D INSERT(MENU,RPC)
 Q
 ;
INSERT(OPTION,RPC) ; Call FM Updater with each RPC
 ; Input  -- OPTION   Option file (#19) Name field (#.01)
 ;           RPC      RPC sub-file (#19.05) RPC field (#.01)
 ; Output -- None
 N FDA,FDAIEN,ERR,DIERR
 S FDA(19,"?1,",.01)=OPTION
 S FDA(19.05,"?+2,?1,",.01)=RPC
 D UPDATE^DIE("E","FDA","FDAIEN","ERR")
 Q
 ;
ENCP ;Entry point to Create Clinical Procedures Class
 ; Input  -- None
 ; Output -- None
 N TIUDA,TIUFPRIV,TIUNEW
 S TIUFPRIV=1,TIUNEW=0,TIUDA=$$CHKCP
 I +TIUDA>0,$P(TIUDA,U,2)="CL" D
 . D BMES^XPDUTL("You already have a CLASS called CLINICAL PROCEDURES...")
 . D BMES^XPDUTL("The new methods and properties to support the TIU/CP interface")
 . D BMES^XPDUTL("will be MERGED with the existing data. UPLOAD HEADERS")
 . D BMES^XPDUTL("which you have defined will NOT be overwritten.")
 . S TIUDA=+TIUDA
 ELSE  D  G ENCPQ:+TIUDA'>0
 . D BMES^XPDUTL("I'm going to create a new Document Definition for CLINICAL PROCEDURES now.")
 . S TIUDA=$$CREATE(TIUFPRIV) S:+TIUDA TIUNEW=1
 . I +TIUDA'>0 D BMES^XPDUTL("Couldn't create Document Definition entry for CLINICAL PROCEDURES...")
 D SET(TIUDA,TIUFPRIV)
 D INDEX(TIUDA,TIUFPRIV)
 I +TIUNEW D ATTACH(TIUDA,TIUFPRIV)
 D DONE
ENCPQ Q
 ;
CHKCP() ;Check for CLINICAL PROCEDURES entry in Document Definition file
 ; Input  -- None
 ; Output -- Document Definition Data from the TIU Document Definition file (#8925.1)
 ;           1st Piece=IEN
 ;           2nd Piece=Type field (#.04)
 N TIUY
 S TIUY=+$O(^TIU(8925.1,"B","CLINICAL PROCEDURES",0))
 I +TIUY S $P(TIUY,U,2)=$P($G(^TIU(8925.1,+TIUY,0)),U,4)
 Q TIUY
 ;
CREATE(TIUFPRIV) ;Create a record for the CLINICAL PROCEDURES Document Definition
 ; Input  -- TIUFPRIV DD Privilege Flag
 ; Output -- TIU Document Defintion file (#8925.1) IEN
 N DIC,DLAYGO,X,Y
 S (DIC,DLAYGO)="^TIU(8925.1,",DIC(0)="MXL",X="CLINICAL PROCEDURES"
 D ^DIC
 Q +$G(Y)
 ;
SET(TIUDA,TIUFPRIV) ;Set the data in the new Document Definition record
 ; Input  -- TIUDA    TIU Document Definition file (#8925.1) IEN
 ;           TIUFPRIV DD Privilege Flag
 ; Output -- None
 N TIUCLP
 S TIUCLP=$$CLPAC
 S ^TIU(8925.1,TIUDA,0)="CLINICAL PROCEDURES^CP^Clinical Procedures^CL^^"_TIUCLP_"^11^^^^^^1"
 S ^TIU(8925.1,TIUDA,1)="8925^1^2;TEXT"
 S ^TIU(8925.1,TIUDA,3)="^1^0"
 S ^TIU(8925.1,TIUDA,4)="D LOOKUP^TIUPUTCP" ;Upload
 S ^TIU(8925.1,TIUDA,4.1)="D POST^TIUCPCL(DA,""INCOMPLETE"")"
 S ^TIU(8925.1,TIUDA,4.4)="D ROLLBACK^TIUCPCL(TIUDA)"
 S ^TIU(8925.1,TIUDA,4.45)="D CHANGE^TIUCPCL(TIUDA)"
 S ^TIU(8925.1,TIUDA,4.5)="D FOLLOWUP^TIUPUTCP(TIUREC(""#""))" ;Upload
 S ^TIU(8925.1,TIUDA,4.8)="D GETCP^TIUPUTCP" ;Upload
 S ^TIU(8925.1,TIUDA,4.9)="D POST^TIUCPCL(DA,""COMPLETED"")"
 S ^TIU(8925.1,TIUDA,5)="[TIU ENTER/EDIT CLINPROC RESULT]" ;Upload/Edit
 S ^TIU(8925.1,TIUDA,6)="D ENTRY^TIUPRCN"
 S ^TIU(8925.1,TIUDA,6.1)="Progress Notes^Vice SF 509^^0"
 S ^TIU(8925.1,TIUDA,7)="D ENPN^TIUVSIT(.TIU,.DFN,1)"
 S ^TIU(8925.1,TIUDA,8)="S TIUASK=$$CHEKPN^TIULD(.TIU,.TIUBY)"
 ; -- Don't modify upload header, if already defined --
 I '$D(^TIU(8925.1,TIUDA,"HEAD")) D  ;Upload
 . S ^TIU(8925.1,TIUDA,"HEAD",0)="^8925.12A^11^11"
 . S ^TIU(8925.1,TIUDA,"HEAD",1,0)="TITLE^TITLE OF CLINICAL PROCEDURE^.01^TIUTITLE^GENERAL PROCEDURE^1^1"
 . S ^TIU(8925.1,TIUDA,"HEAD",2,0)="SSN^PATIENT SSN^.02^TIUSSN^555-12-1234^1^1"
 . S ^TIU(8925.1,TIUDA,"HEAD",2,1)="S X=$TR(X,""-/"","""")"
 . S ^TIU(8925.1,TIUDA,"HEAD",3,0)="VISIT/EVENT DATE^VISIT/EVENT DATE^.07^TIUVDT^5/15/2001@08:15^1^1"
 . S ^TIU(8925.1,TIUDA,"HEAD",4,0)="AUTHOR^DICTATING PROVIDER^1202^^HOWSER,DOOGEY^1^1"
 . S ^TIU(8925.1,TIUDA,"HEAD",5,0)="DATE/TIME OF DICTATION^DICTATION DATE/TIME^1307^TIUDDT^5/16/2001@09:25^0^1"
 . S ^TIU(8925.1,TIUDA,"HEAD",6,0)="LOCATION^PATIENT LOCATION^1205^TIULOC^MEDICAL-CONSULT 6200^1^1"
 . S ^TIU(8925.1,TIUDA,"HEAD",7,0)="EXPECTED COSIGNER^EXPECTED COSIGNER^1208^^WELBY,MARCUS^1^0"
 . S ^TIU(8925.1,TIUDA,"HEAD",8,0)="CONSULT REQUEST NUMBER^CONSULT REQUEST #^1405^TIUCNNBR^1455^1^1"
 . S ^TIU(8925.1,TIUDA,"HEAD",8,1)="S X=""C.""_X"
 . S ^TIU(8925.1,TIUDA,"HEAD",9,0)="TIU DOCUMENT NUMBER^TIU DOCUMENT #^.001^TIUPLDA^543^1^0"
 . S ^TIU(8925.1,TIUDA,"HEAD",10,0)="PROCEDURE SUMMARY CODE^PROCEDURE SUMMARY CODE^70201^TIUPSC^Normal^1^0"
 . S ^TIU(8925.1,TIUDA,"HEAD",11,0)="DATE/TIME PERFORMED^DATE/TIME PERFORMED^70202^TIUDTP^5/15/2001@08:00^1^0"
 ELSE  D
 . I $P($G(^TIU(8925.1,TIUDA,"HEAD",5,0)),U,1)="DATE/TIME OF DICTATION",$P(^(0),U,3)=1301 S $P(^(0),U,3)=1307
 Q
 ;
CLPAC() ;Get pointer to CLINICAL COORDINATOR User Class
 ; Input  -- None
 ; Output -- USR Class file (#8930) IEN
 N TIUY
 S TIUY=$O(^USR(8930,"B","CLINICAL COORDINATOR",0))
 Q TIUY
 ;
INDEX(DA,TIUFPRIV) ;Call IX^DIK to re-index the CLINICAL PROCEDURES entry
 ; Input  -- DA       TIU Document Defintion file (#8925.1) IEN
 ;           TIUFPRIV DD Privilege Flag
 ; Output -- None
 N DIK
 S DIK="^TIU(8925.1," D IX^DIK
 Q
 ;
ATTACH(TIUDA,TIUFPRIV) ;Attach CLINICAL PROCEDURES to appropriate parent
 ; Input  -- TIUDA    TIU Document Defintion file (#8925.1) IEN
 ;           TIUFPRIV DD Privilege Flag
 ; Output -- None
 N DIC,DLAYGO,DIE,DR,X,Y
 D BMES^XPDUTL("The new CLINICAL PROCEDURES Class will now be added under")
 S DA(1)=38 ;CLINICAL DOCUMENTS Class
 D BMES^XPDUTL("the "_$P(^TIU(8925.1,DA(1),0),U)_" Class...")
 S DIC="^TIU(8925.1,"_DA(1)_",10,",DIC(0)="NXL"
 S DIC("P")=$P(^DD(8925.1,10,0),U,2),X="`"_TIUDA
 D ^DIC ; Create the sub-entry for CLINICAL PROCEDURES
 I +Y'>0 D  G ATTACHQ
 . D BMES^XPDUTL("Unable to add CLINICAL PROCEDURES under "_$P($G(^TIU(8925.1,DA(1),0)),U))
 . D BMES^XPDUTL("You'll have to attach it manually.")
 S DA=+Y,DIK=DIC K DIC
 S ^TIU(8925.1,DA(1),10,DA,0)=$G(^TIU(8925.1,DA(1),10,DA,0))_"^^^Clinical Procedures"
 D IX^DIK ; Cross-reference new subfile entry
ATTACHQ Q
 ;
DONE ;Let the user know
 ; Input  -- None
 ; Output -- None
 D BMES^XPDUTL("Okay, I'm done.")
 D BMES^XPDUTL("Please finish your implementation of CLINICAL PROCEDURES by adding")
 D BMES^XPDUTL("any Document Classes and Titles as appropriate using the Create")
 D BMES^XPDUTL("Document Definitions Option under the TIUF DOCUMENT DEFINITION MGR Menu")
 D BMES^XPDUTL("as described in the Post-Installation Instructions.")
 Q
