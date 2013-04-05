RAIPST2 ;HIRMFO/GJC - Post-init number two ;6/16/97  07:59
VERSION ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
EN2 ; Delete incomplete reports from the Rad/Nuc Med Reports file.
 ; These reports are deleted because they are incomplete, i.e,
 ; missing Report Text, missing Impression Text, and a Report
 ; Status of 'Draft'.  These reports must not have a pointer
 ; to the Image (2005) file and must not be purged.
 ; ('PURGE' node must not exist.)
 ;N RA74,RATXT,RAX,RAY
 ;S RA74=+$$PARCP^XPDUTL("POST6"),RATXT(1)=" "
 ;S RATXT(2)="Checking for invalid skeleton reports in the Rad/Nuc Med Reports file."
 ;S RATXT(3)="If any are found they will be deleted along with all pointers to them."
 ;S RATXT(4)=" " D MES^XPDUTL(.RATXT)
 ;F  S RA74=$O(^RARPT(RA74)) Q:RA74'>0  D
 ;. Q:$D(^RARPT(RA74,"PURGE"))  ; quit if involved in prior purge
 ;. S RAX=$$EN3^RAUTL15(RA74)
 ;. S RAY=+$$UPCP^XPDUTL("POST61",RA74)
 ;. Q
 Q
EN3 ; Update the value of the REPORT RIGHT MARGIN of the IMAGING LOCATIONS
 ; file.
 Q:$$CNVFLG^RAIPST2()  ; code has been hit in the past.
 N RA791,RAFDA,RAIEN,RALEFT,RANRIT,RARIT,RATXT S RAIEN=0
 S RATXT(1)=" "
 S RATXT(2)="Correcting values in the REPORT RIGHT MARGIN field of all entries in the"
 S RATXT(3)="IMAGING LOCATIONS file."
 S RATXT(4)=" " D MES^XPDUTL(.RATXT) K RATXT
 F  S RAIEN=$O(^RA(79.1,RAIEN)) Q:RAIEN'>0  D
 . S RA791=$G(^RA(79.1,RAIEN,0))
 . S RALEFT=+$P(RA791,"^",14),RARIT=+$P(RA791,"^",15)
 . Q:RALEFT=0!(RARIT=0)  ; cannot perform computations without values
 . S RANRIT=(RALEFT+RARIT)
 . S RAFDA(79.1,RAIEN_",",15)=RANRIT
 . D FILE^DIE("E","RAFDA") K RAFDA,RAERR
 . Q
 Q
EN4 ; Set the 'ASK RADIOPHARMS & DOSAGES?' field (.61) to 'Yes'
 ; for for the Examinations Status 'EXAMINED' whose Imaging
 ; Type has the 'RADIOPHARMACEUTICALS USED?' field set to 'Yes'.
 N I,RAFDA S I=0
 F  S I=$O(^RA(72,"B","EXAMINED",I)) Q:I'>0  D
 . N RAITY S RAITY=+$P($G(^RA(72,I,0)),"^",7)
 . I $$UP^XLFSTR($$GET1^DIQ(79.2,RAITY,5,"I"))="Y" S RAFDA(72,I_",",.61)="Y"
 . Q
 D:$D(RAFDA) FILE^DIE("","RAFDA","")
 Q
EN5 ; Add 'Mammography' as a new Imaging Type in file 79.2
 ; Populate the following fields: Operating Conditions
 ; Abbreviation, Report Cut-Off, Clinical History Cut-Off
 ; Tracking Time Cut-Off & Order Data Cut-Off
 Q:$D(^RA(79.2,"B","MAMMOGRAPHY"))\10  ; done in the past
 N RAFDA K RAERR,RATXT S RATXT(1)=" "
 S RATXT(2)="Adding 'MAMMOGRAPHY' as a new entry in the Imaging Type file."
 D MES^XPDUTL(.RATXT) K RATXT
 S RAFDA(79.2,"+1,",.01)="MAMMOGRAPHY",RAFDA(79.2,"+1,",3)="MAM"
 S RAFDA(79.2,"+1,",4)="N",RAFDA(79.2,"+1,",.11)=90
 S RAFDA(79.2,"+1,",.12)=90,RAFDA(79.2,"+1,",.13)=90
 S RAFDA(79.2,"+1,",.14)=90,RAFDA(79.2,"+1,",.16)=90
 D UPDATE^DIE("","RAFDA","","RAERR")
 I $D(RAERR("DIERR")) D
 . S RATXT(1)=" "
 . S RATXT(2)="Error filing 'MAMMOGRAPHY' in the Imaging Type (79.2) file."
 . S RATXT(3)="IRM and the Radiology/Nuclear Medicine ADPAC should investigate."
 . D MES^XPDUTL(.RATXT)
 . Q
 K RAERR,RATXT
 Q
CLEANUP ; This entry point is called to queue off the RADIOLOGY/NUCLEAR
 ; MEDICINE CLEANUP 5.0 build.  This build removes obsolete data and
 ; fields from the database.
 N %,DIC,RAPKG,RASTAT,XPDA,X,Y
 S (RAPKG,X)="RADIOLOGY/NUCLEAR MEDICINE CLEANUP "_$P($T(+2),";",3)
 S DIC="^XPD(9.7,",DIC(0)="O" D ^DIC Q:+Y'>0  ;cleanup missing
 S XPDA=+Y
 S RASTAT=$$GET1^DIQ(9.7,XPDA,.02,"I") ; get status of distribution
 Q:RASTAT'=0  ; status must be 'loaded from distribution'
 Q:'$D(^XTMP("XPDI",XPDA,"BLD"))  ; missing from transport global
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE S ZTIO=""
 S ZTRTN="EN^XPDIJ",ZTDESC="Rad/Nuc Med Cleanup 5.0 task"
 S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT(),0,0,2,0),ZTSAVE("XPDA")=""
 D ^%ZTLOAD N RATXT S RATXT(1)=" "
 S RATXT(2)=RAPKG_" is running in background."
 S:$G(ZTSK)>0 RATXT(3)="Task: "_ZTSK_"." D MES^XPDUTL(.RATXT)
 Q
CNVFLG() ; This code checks to see if the Right Margin field for the
 ; Imaging Locations file has had its data converted by a prior install
 ; of Rad/Nuc Med v5.  We check to see if the 'ASK RADIOPHARMS &
 ; DOSAGES?' field (.61) is set to 'Yes'.  If so, the post-init must
 ; have run in the past.
 ;
 ; Returns: '0' if initial post-init run, '1' if the post-init has run
 ;          in the past.
 ;
 N I,RAFLG S (I,RAFLG)=0
 F  S I=$O(^RA(72,"B","EXAMINED",I)) Q:I'>0  D  Q:RAFLG
 . S:$$UP^XLFSTR($P($G(^RA(72,I,.6)),"^"))="Y" RAFLG=1
 . Q
 Q RAFLG
