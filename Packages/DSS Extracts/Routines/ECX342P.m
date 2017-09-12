ECX342P ;ALB/ESD - Patch ECX*3.0*40 Post-Install Utility Routine ; 01/24/02
 ;;3.0;DSS EXTRACTS;**42**;Dec 22, 1997
 ;
 ;
ENV ;- Main entry point for environment check
 ;
 S XPDABORT=""
 ;
 ;- Checks programmer variables
 D PROGCHK(.XPDABORT)
 I XPDABORT="" K XPDABORT
 Q
 ;
 ;
PRE ;- Main entry point for pre-init items
 Q
 ;
 ;
POST ;- Main entry point for post-init items
 ;
 ;- Add new entries to DSS PRODUCTION UNIT (#729) file
 D POST1
 Q
 ;
 ;
PROGCHK(XPDABORT) ;Checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D
 .D BMES^XPDUTL("******** ERROR ********")
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("************************")
 .S XPDABORT=2
 Q
 ;
 ;
POST1 ;
 ;
 ;- This procedure will add new entries to the DSS PRODUCTION UNIT
 ;  (#729) file.
 ;
 N ECXFDA,ECXERR,ECXCODE,ECXREC,I
 ;
 D BMES^XPDUTL(">>> Updating DSS PRODUCTION UNIT (#729) file...")
 S $P(^DD(729,.01,0),U,5)=""
 ;
 ;- Get DSS Production Unit text
 F I=1:1 S ECXREC=$P($T(PROUNIT+I),";;",2) Q:ECXREC="QUIT"  D
 .;
 .;- Production Unit code
 .S ECXCODE=$P(ECXREC,"^")
 .;
 .;- Quit w/error message if entry already exists in file #729
 .I $$FIND1^DIC(729,"","X",ECXCODE) D  Q
 ..D BMES^XPDUTL(">>>...."_ECXCODE_"  "_$P(ECXREC,U,2)_" not added, entry already exists.")
 ..D MES^XPDUTL(">>>        Delete entry and reinstall patch if this entry was not created by a")
 ..D MES^XPDUTL(">>>        previous installation of this patch.")
 .;
 .;- Setup field values of new entry
 .S ECXFDA(729,"+1,",.01)=ECXCODE
 .S ECXFDA(729,"+1,",1)=$P(ECXREC,"^",2)
 .S ECXFDA(729,"+1,",2)=$P(ECXREC,"^",3)
 .;
 .;- Add new entry to file #729
 .D UPDATE^DIE("E","ECXFDA","","ECXERR")
 .;
 .I '$D(ECXERR) D BMES^XPDUTL(">>>...."_ECXCODE_"  "_$P(ECXREC,U,2)_" added to file.")
 .I $D(ECXERR) D BMES^XPDUTL(">>>....Unable to add "_ECXCODE_"  "_$P(ECXREC,U,2)_" to file.")
 ;
 D BMES^XPDUTL(">>> Update completed.")
 S $P(^DD(729,.01,0),U,5)="K X"
 ;
 Q
 ;
 ;
PROUNIT ;- Contains the DSS Production Units to be added
 ;;24^Geropsych Ward 2^GERPSYWRD2
 ;;25^Geropsych Ward 3^GERPSYWRD3
 ;;26^Geropsych Ward 4^GERPSYWRD4
 ;;27^Geropsych Ward 5^GERPSYWRD5
 ;;QUIT
