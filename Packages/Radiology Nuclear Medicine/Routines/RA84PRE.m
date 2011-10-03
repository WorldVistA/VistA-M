RA84PRE ;Hines OI/GJC - Pre-init Driver, patch 84 ;01/05/06  06:32
 ;;5.0;Radiology/Nuclear Medicine;**84**;Mar 16, 1998;Build 13
 ;
EN ; entry point for the pre-install logic
 ;
 ;Integration Agreements
 ;----------------------
 ;CREIXN^DDMOD(2916); DELIX^DDMOD(2916); $$FIND1^DIC(2051); UPDATE^DIE(2053); ^DIK(10013)
 ;$$GET1^DIQ(2056); GETS^DIQ(2056); $$FMADD^XLFDT(10103); XMD(10070); BMES^XPDUTL(10141)
 ;$$KSP^XUPARAM(2541); $$CREATE^XUSAP(4677)
 ;
 ;check to see if the following condition: RA*5.0*56 is not installed & BEFORE DELETION REPORT
 ;STATUS (DD:74.01; Fld: 4) exists is true. If so, delete the BEFORE DELETION REPORT STATUS
 ;field from the ACTIVITY LOG sub-file (exported accidentally; no data to be concerned with)
 I '($$PATCH^XPDUTL("RA*5.0*56")),($D(^DD(74.01,4,0)))#2 D
 .N %,DA,DIC,DIK,X,Y
 .S DIK="^DD(74.01,",DA(1)=74.01,DA=4
 .D ^DIK Q
 ;
 N DIERR,RAAPU,RAERR,RAFAC,RAFDA,RAFLD,RAFLG,RAFMC,RAIEN,RAOPT,RARY,RATXT,RAX,RAY,RAZ
 S RAAPU="RADIOLOGY,OUTSIDE SERVICE",RAFMC="",RAOPT="RA OVERALL"
 ;
 ;I RAY>0 then the APU record was created; RAY will be the IEN of the new record.
 ;I RAY=0 then the proxy user record existed prior to calling $$CREATE^XUSAP.
 ;I RAY=-1 then the function failed to create the proxy user record.
 S RAY=+$$CREATE^XUSAP(RAAPU,RAFMC,RAOPT)
 ;
 I RAY>0 S RAIEN=RAY,RATXT(1)="'"_RAAPU_"' has been created as an Application Proxy User."
 ;
 ;RAY=-1: The function failed to create the proxy user record; abort the install.
 I RAY=-1 S XPDABORT=1 D
 .S RATXT(1)="Error: '"_RAAPU_"' has not been created as an Application"
 .S RATXT(2)="Proxy User. '"_RAAPU_"' must be unique"
 .S RATXT(3)="and used within the scope of the VistA Radiology teleradiology"
 .S RATXT(4)="initiative. Installation of RA*5.0*84 has been aborted until this"
 .S RATXT(5)="Application Proxy User record can be created."
 .Q
 ;
 ;RAY=0: The proxy user record existed prior to the function call. Is the proxy record
 ;secure? If the proxy record is not secure abort the install.
 I RAY=0 D
 .;determine the IEN of 'RADIOLOGY,OUTSIDE SERVICE' in file 200...
 .S RAIEN=$$FIND1^DIC(200,"","X","RADIOLOGY,OUTSIDE SERVICE","B") Q:RAIEN=0
 .D GETS^DIQ(200,RAIEN_",","2;3;11;201","I","RARY") S RAFLD=""
 .;Are there any NEW PERSON fields defined that jeopardize the security of this record?
 .F  S RAFLD=$O(RARY(200,RAIEN,RAFLD)) Q:RAFLD=""  I $L($G(RARY(200,RAIEN,RAFLD,"I"))) S XPDABORT=1 Q
 .I $G(XPDABORT)=1 D
 ..S RATXT(1)="Error: '"_RAAPU_"' is not a secure application proxy user"
 ..S RATXT(2)="record. Please revisit the definition of this type of user record."
 ..S RATXT(3)=""
 ..S RATXT(4)="Installation of RA*5.0*84 has been aborted until this Application Proxy"
 ..S RATXT(5)="User record can be created."
 ..Q
 .Q
 D BMES^XPDUTL(.RATXT)
 Q:$G(XPDABORT)=1  K RATXT
 ;
 ;Add 'S' as a RAD/NUC MED CLASSIFICATION to the 'RADIOLOGY,OUTSIDE SERVICE' NEW PERSON file
 ;record. Assign 'RADIOLOGY,OUTSIDE SERVICE' a PERSON CLASS.
 ;permitted by IA 5077
 I RAY'<0,(RAIEN>0) D
 .K RARY S RAZ=RAIEN
 .D GETS^DIQ(200,RAIEN_",","72*","I","RARY")
 .I ($D(RARY)\10)=0 D  ;'S' not added in the past; add now (missing "B" xref makes this tricky)
 ..K DIERR,RAERR,RAFDA,RARY
 ..S RAIEN="?+1,"_RAIEN_","
 ..S RAFDA(200.072,RAIEN,.01)="S"
 ..D UPDATE^DIE("","RAFDA","","RAERR")
 ..;
 ..;if error inform the user, proceed with filing PERSON CLASS
 ..I ($D(RAERR("DIERR"))#2) S RAX="RAD/NUC MED CLASSIFICATION" D ERR
 ..Q
 .;
 .;find the DIAGNOSTIC RADIOLOGY record in the PERSON CLASS (#8932.1) file.
 .K DIERR,RAERR,RAFDA
 .S RAPCLASS=$$PCLKUP() ;note workload encounter errors if the lookup fails
 .I +RAPCLASS'>0 D  Q
 ..;cannot find desired record; inform the user & do not execute the PERSON CLASS update
 ..S:+RAPCLASS=0 RATXT(1)="PERSON CLASS value DIAGNOSTIC RADIOLOGY' not found."
 ..S:+RAPCLASS=-1 RATXT(1)="PERSON CLASS lookup error: "_$P(RAPCLASS,U,2)
 ..S RATXT(2)="Encounter based workload calculations will fail until a PERSON CLASS is assigned."
 ..D BMES^XPDUTL(.RATXT) K RATXT
 ..Q
 .;
 .;file the PERSON CLASS value into PERSON CLASS sub-file: 200.05 IA 5077
 .K DIERR,RAERR,RAFDA,RAY S RAIEN=RAZ
 .S RAIEN="?+1,"_RAIEN_","
 .S RAFDA(200.05,RAIEN,.01)=RAPCLASS
 .S RAFDA(200.05,RAIEN,2)=$$FMADD^XLFDT(DT,-1,0,0,0) ;T-1 to make sure we work today!
 .D UPDATE^DIE("","RAFDA","","RAERR")
 .;
 .;if error inform the user, proceed with install
 .I ($D(RAERR("DIERR"))#2) S RAX="PERSON CLASS" D ERR
 .Q
 K DIERR,RAERR,RAFDA,RAY
 ;
 ;check to see if the facility has records within the 999-1003 IEN range within the
 ;DIAGNOSTIC CODES (#78.3) file. If there are records with these IENs proceed with
 ;the install but:
 ;1) DO NOT alter (change pointers) the data in the DIAGNOSTIC CODES file at the facility
 ;2) Send an email to an Outlook mail group identifying the facility where the
 ;   conflict occur.
 ;If the IENs in this range are record free add them to the facilities' local DIAGNOSTIC CODES
 ;file. RAFLG=1 when there is an existing record in the the IEN range of 999-1003
 S RAFLG=0 F RAIEN=999:1:1003 I ($D(^RA(78.3,RAIEN,0))#2) S RAFLG=1 Q
 ;
 ;if RAFLG=1 send the email to the Outlook mail group
 I RAFLG=1 D
 .S RAFAC=$$GET1^DIQ(4,+$$KSP^XUPARAM("INST"),.01)
 .N XMDUN,XMDUZ,XMSUB,XMTEXT,XMY,XMZ S XMDUZ=.5
 .S RATXT(1)=RAFAC_" has a conflict with national teleradiology codes"
 .S RATXT(2)="diagnostic codes occupying IENS: 999-1003 in file 78.3."
 .S XMSUB="DIAGNOSTIC CODES file IEN issue @ "_RAFAC,XMTEXT="RATXT("
 .S XMY("VAOITVHITRadiologyFacilityLevelApplicationIssues@va.gov")=""
 .NEW DIFROM
 .D ^XMD,BMES^XPDUTL(.RATXT)
 .Q
 ;If no IEN conflict, add the nationally defined teleradiology diagnostic codes...
 E  D  ;do-if RAFLG=0
 .K RARY S RARY(999)="TELERADIOLOGY, NOT YET DICTATED^^N^n"
 .S RARY(1000)="NO ALERT REQUIRED^^N^n"
 .S RARY(1001)="SIGNIFICANT ABNORMALITY, ATTN NEEDED^^Y^y"
 .S RARY(1002)="CRITICAL ABNORMALITY^^Y^y"
 .S RARY(1003)="POSSIBLE MALIGNANCY^^Y^y",RAIEN=""
 .F  S RAIEN=$O(RARY(RAIEN)) Q:RAIEN=""  D
 ..S RAFDA(78.3,"+1,",.01)=$P(RARY(RAIEN),U,1)
 ..S RAFDA(78.3,"+1,",3)=$P(RARY(RAIEN),U,3)
 ..S RAFDA(78.3,"+1,",4)=$P(RARY(RAIEN),U,4)
 ..S RAIEN(1)=RAIEN D UPDATE^DIE("","RAFDA","RAIEN","RAERR")
 ..I $D(RAERR)#2 D
 ...S RATXT(1)="",RATXT(2)="Error adding "_$P(RARY(RAIEN),U,1)_" to the"
 ...S RATXT(3)="local DIAGNOSTIC CODES file #78.3." D BMES^XPDUTL(.RATXT)
 ...Q
 ..Q
 .Q
 ;
 D XREF
 Q
 ;
XREF ;REGARDLESS OF WHETHER FILE 78.3 HAS BEEN UPDATED, delete the traditional cross-reference
 ;definition on the PRIMARY DIAGNOSTIC CODE (70.03,13) field. Params: sub-DD, field #,
 ;cross-reference number, flag ('K' kills "AD"), array containing information about recompiled
 ;templates &/or xrefs, error array dialog (if any)
 ;
 ;First check if the 'New Style' cross-reference is in place. If it is, quit this function now!
 ;If in error, make sure the error is documented and proceed with the install of RA*5.0*84.
 ;
 N RAERR,RAVALUE,RAY S RAVALUE(1)=70,RAVALUE(2)="AD"
 ;Note: "BB" (5th subscript) is the FILE & NAME cross-reference index in the INDEX (#.11) file.
 S RAY=$$FIND1^DIC(.11,"","O",.RAVALUE,"BB","","RAERR")
 I ($D(RAERR("DIERR")))#2 K RATXT D  Q
 .S RATXT(1)=$G(RAERR("DIERR",1,"TEXT",1),"Error finding the 'New Style' ""AD"" cross-reference.")
 .D BMES^XPDUTL(.RATXT) K RATXT Q
 ;
 I RAY K RATXT D  Q
 .S RATXT(1)="The 'New Style' PRIMARY DIAGNOSTIC CODE (70.03, #13) ""AD"" cross-reference"
 .S RATXT(2)="is currently in existence." D BMES^XPDUTL(.RATXT) K RATXT Q
 ;
 K DIERR,RAERR,RAFDA,RAIEN,RATXT
 N I,RAI,RAMOWIC,RAX S RAY=0
 ;find the old cross-reference to delete; set RAY to the record number of the cross-reference
 F  S RAY=$O(^DD(70.03,13,1,RAY)) Q:'RAY  Q:$G(^DD(70.03,13,1,RAY,0))="70^AD^MUMPS"
 ;RAY="" if there is no traditional "AD" cross-reference to delete, BUT make sure the
 ;new style "AD" cross-reference is created ('D NS').
 I RAY="" D NS Q
 D DELIX^DDMOD(70.03,13,RAY,"K","RAMOWIC","RAERR")
 S I=0 F RAX="DDAUD","DIEZ","DIKZ" D
 .I ($D(RAMOWIC(RAX)))#2 D
 ..S I=I+1,RATXT(I)=""
 ..S:RAX="DDAUD" RATXT(I)="DD AUDIT (#.6) updated"
 ..S:RAX="DIKZ" RATXT(I)="Cross-references re-compiled in namespace: "_$G(RAMOWIC(RAX)) QUIT
 ..I RAX="DIEZ" S RAI=0 F  S RAI=$O(RAMOWIC(RAX,RAI)) Q:'RAI  D
 ...S I=I+1,RATXT(I)="Input Template re-compiled: "_$G(RAMOWIC(RAX,RAI))
 ...Q
 ..Q
 .Q
 ;
 ;Note: RAERR("DIERR") will only be defined if an error occurred...
 I ($D(RAERR("DIERR")))#2 D  S XPDABORT=1
 .S I=I+1,RATXT(I)="",I=I+1
 .S RATXT(I)="Error deleting the PRIMARY DIAGNOSTIC CODE (70.03,13) cross-reference."
 .S I=I+1,RATXT(I)="Contact the national VistA Radiology development team."
 .Q
 D:$O(RATXT(0)) BMES^XPDUTL(.RATXT)
 ;
 ;if there is an error in deleting the old cross-reference stop the install of the patch.
 Q:$G(XPDABORT)=1
 ;
NS ;Create the new-style cross-reference on the PRIMARY DIAGNOSTIC CODE (70.03,13) field.
 ;This cross-reference will be named the same as the prior cross-reference, "AD", but
 ;the SET & KILL logic will change. This new style cross-reference will be stored in the
 ;INDEX (#.11) file.
 N I,J,RAMOWIC,RARSLT,RAXREF K DIERR,RAERR,RATXT
 S RAXREF("FILE")=70,RAXREF("TYPE")="MU",RAXREF("NAME")="AD"
 S RAXREF("EXECUTION")="F",RAXREF("ROOT FILE")=70.03,RAXREF("USE")="S"
 S RAXREF("ACTIVITY")="IR"
 S RAXREF("SHORT DESCR")="The 'AD' is used to mark cases eligible for the Abnormal Report option."
 S RAXREF("DESCR",1)="If the diagnostic code record in the radiology DIAGNOSTIC CODES (#78.3)"
 S RAXREF("DESCR",2)="has the data attribute for field: PRINT ON ABNORMAL REPORT (#3) set to"
 S RAXREF("DESCR",3)="'Y' (yes) then the ""AD"" cross-reference will be set for this exam record"
 S RAXREF("DESCR",4)="to indicate that this case should be identified on the Abnormal Report."
 S RAXREF("DESCR",5)=""
 S RAXREF("DESCR",6)="NOTE: When this field is edited the DIAGNOSTIC PRINT DATE (#20) field is"
 S RAXREF("DESCR",7)="deleted!",RAXREF("VAL",1)=13
 S RAXREF("KILL CONDITION")="S:X1(1)'="""" X=1"
 S RAXREF("KILL")="D:($D(X1(1))#2) PRIDXIXK^RADD2(.DA,X1(1))"
 S RAXREF("SET CONDITION")="S:X2(1)'="""" X=1"
 S RAXREF("SET")="S:$P($G(^RA(78.3,X2(1),0)),U,3)=""Y"" ^RADPT(""AD"",X2(1),DA(2),DA(1),DA)="""""
 S RAXREF("WHOLE KILL")="K ^RADPT(""AD"")"
 ;
 D CREIXN^DDMOD(.RAXREF,"",.RARSLT,"RAMOWIC","RAERR") S I=1,RATXT(I)="",I=I+1
 ;
 S RATXT(I)="The '"_$P(RARSLT,U,2)_"' cross-reference was"_$S(RARSLT="":" not",1:"")_" successfully created."
 ;
 F J="DIEZ","DIKZ" D
 .I J="DIEZ",($O(RAMOWIC("DIEZ",0))) D
 ..N J1 S J1=0
 ..F  S J1=$O(RAMOWIC("DIEZ",J1)) Q:'J1  D
 ...S I=I+1,RATXT(I)="Input template: "_$P($G(RAMOWIC("DIEZ",J1)),U)_" was re-compiled."
 ...Q
 ..Q
 .;
 .I J="DIKZ",$G(RAMOWIC("DIKZ"))'="" D
 ..S I=I+1,RATXT(I)="Cross-reference re-compiled in namespace: "_$G(RAMOWIC("DIKZ"))
 ..Q
 .Q
 ;
 I ($D(RAERR("DIERR")))#2 D  S XPDABORT=1
 .S I=I+1,RATXT(I)="",I=I+1
 .S RATXT(I)="Error deleting the PRIMARY DIAGNOSTIC CODE (70.03,13) cross-reference."
 .S I=I+1,RATXT(I)="Contact the national VistA Radiology development team."
 .Q
 D:$O(RATXT(0)) BMES^XPDUTL(.RATXT)
 Q
 ;
PCLKUP() ;PERSON CLASS lookup screened by INACTIVATED field on file 8932.1
 ;If successful return the IEN.
 ;If the lookup fails (without error) the function returns 0
 ;If the lookup fails (with error) the function returns null w/error dialog
 ; Ex: RAERR("DIERR","1","TEXT",1)="The input value contains control characters."
 ; If error I'll return: -1^error dialog
 N RAXEC S RAXEC="N RADT S RADT=$P(^(0),U,5) I $S('RADT:1,RADT>DT:1,1:0)"
 S RASULT=$$FIND1^DIC(8932.1,"","X","V183002","F","X RAXEC","RAERR") ;"V183002"
 Q $S(($D(RAERR("DIERR"))#2):"-1^"_$G(RAERR("DIERR","1","TEXT",1)),1:RASULT)
 ;
ERR ;display the error text associated with our failed event
 ;input: RAX exists globally the attribute that was not filed Ex: RAD/NUC MED CLASSIFICATION
 ;       RAERR("DIERR") exists globally
 K RATXT N RACNT,RAI,RAJ S RATXT(1)="APU record error when filing "_RAX_" data"
 S RAI=0,RACNT=1
 F  S RAI=$O(RAERR("DIERR",RAI)) Q:RAI'>0  S RACNT=RACNT+1,RATXT(RACNT)="" D
 .S RAJ=0 F  S RAJ=$O(RAERR("DIERR",RAI,"TEXT",RAJ)) Q:RAJ'>0  D
 ..Q:$G(RAERR("DIERR",RAI,"TEXT",RAJ))=""
 ..S RACNT=RACNT+1,RATXT(RACNT)=$G(RAERR("DIERR",RAI,"TEXT",RAJ))
 ..Q
 .Q
 D BMES^XPDUTL(.RATXT) K RATXT
 Q
 ;
