NURXENV ;HIRMFO/FT-Environment Check for Nursing v4.0  ;1/21/97  14:26
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
EN1 ; Check environment to see if Nursing v4.0 should be installed.
 S NURPKG=+$$VERSION^XPDUTL("GMRG")
 I NURPKG<3 D BMES^XPDUTL("Text Generator v3.0 is required before you continue with this installation.") S NURSTOP=1
 S NURPKG=+$$VERSION^XPDUTL("REGISTRATION")
 I NURPKG<5.3 D BMES^XPDUTL("PIMS (MAS) v5.3 or greater is required before you continue with this installation.") S NURSTOP=1
 S NURPKG=+$$VERSION^XPDUTL("PRS")
 I NURPKG<3.5 D BMES^XPDUTL("PAID v3.5 or greater is required before you continue with this installation.") S NURSTOP=1
 S NURVER=+$$VERSION^XPDUTL("NUR")
 I NURVER>0,NURVER<3 D BMES^XPDUTL("You must have Nursing v3.0 loaded prior to the installation of v4.0") S NURSTOP=1
 I NURVER=3 D
 .D FIND^DIC(9.7,"","","X","NUR*3.0*1","","B","","","NURIEN","NURERROR")
 .I $O(NURIEN("DILIST",2,0))'>0 D BMES^XPDUTL("You must install NUR*3.0*1 prior to the installation of v4.0") S NURSTOP=1
 .D FIND^DIC(9.7,"","","X","NUR*3.0*3","","B","","","NURIEN","NURERROR")
 .I $O(NURIEN("DILIST",2,0))'>0 D BMES^XPDUTL("You must install NUR*3.0*3 prior to the installation of v4.0") S NURSTOP=1
 .Q
NMSP ; 
 Q:+$$VERSION^XPDUTL("NUR")>3  ;quit if install already ran.
 Q:'$D(^NURSF(210,0))  ;quit if virgin install
 K NURIEN,NURERROR
 D FIND^DIC(9.4,"","","X","NUR","","C","","","NURIEN","NURERROR")
 ; quit if FileMan lookup errors out
 I +$G(NURERROR("DIERR")) D  S NURSTOP=1 D KILL Q
 .K NURMSG
 .S NURMSG(1)="Error trying to lookup NURSING SERVICE in the PACKAGE (#9.4) file."
 .S NURMSG(2)="Halting."
 .D BMES^XPDUTL(.NURMSG)
 .Q
 ;
 S (NURCNT,NURSEQ)=0
 F  S NURSEQ=$O(NURIEN("DILIST",1,NURSEQ)) Q:NURSEQ'>0  D
 .S NURCNT=NURCNT+1
 .Q
 ; quit if more than one entry with 3 lettered namespace of NUR
 I NURCNT>1 D  S NURSTOP=1 D KILL Q
 .K NURMSG
 .S NURMSG(1)="There is more than one PACKAGE (#9.4) file entry with"
 .S NURMSG(2)="NUR as its PREFIX (field #1) value. The NUR namespace"
 .S NURMSG(3)="must be associated with the NURSING SERVICE entry in"
 .S NURMSG(4)="File #9.4. Delete the extra entries and re-point those"
 .S NURMSG(5)="entries to the NURSING SERVICE entry."
 .S NURMSG(6)="If the namespace for the NURSING SERVICE entry is not"
 .S NURMSG(7)="the three letter namespace of NUR, then you must edit"
 .S NURMSG(8)="it so that it is NUR."
 .D BMES^XPDUTL(.NURMSG)
 .Q
 I NURCNT=1 D
 .S NURDA=+(NURIEN("DILIST",2,1))
 .I NURIEN("DILIST",1,1)'="NURSING SERVICE" D  S NURSTOP=1 Q
 ..K NURMSG
 ..S NURMSG(1)="The name of the PACKAGE (#9.4) file entry for the NUR"
 ..S NURMSG(2)="namespace must be NURSING SERVICE. Please edit the"
 ..S NURMSG(3)="entry via FileMan to change the namespace of the NURSING"
 ..S NURMSG(4)="SERVICE entry to the 3 letter namespace of NUR before"
 ..S NURMSG(5)="continuing with this installation."
 ..S NURMSG(6)="Delete any other Package file entries that have a namespace"
 ..S NURMSG(7)="of NUR and re-point those entries to the NURSING SERVICE "
 ..S NURMSG(8)="entry."
 ..D BMES^XPDUTL(.NURMSG)
 ..Q
 .Q
KILL ;
 S:$G(NURSTOP) XPDABORT=2 ;don't install transport global/leave in ^XTMP
 K DA,DIC,NURCNT,NURDA,NURERROR,NURIEN,NURMSG,NURPKG,NURSEQ,NURSTOP,NURVER,X,Y
 Q
