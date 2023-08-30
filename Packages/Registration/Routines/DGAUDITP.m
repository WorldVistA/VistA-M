DGAUDITP ;ATG/JPN,ISL/DKA - VAS DG*5.3*964 POST-INSTALL ; 28 Jul 2021  8:30 AM
 ;;5.3;Registration;**964**;Aug 13, 1993;Build 323
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Reference to ^XOB(18.12 in ICR #7317
 ; Reference to RESCH^XUTMOPT in ICR #1472
 ; Reference to UPDATE^DIE in ICR #2053
 ; Reference to $$GET1^DIQ in ICR #2056
 ; Reference to NOW^%DTC in ICR #10000
 ; Reference to ^DIC in ICR #10006
 ; Reference to FILE^DICN in ICR #10009
 ; Reference to ^DIE in ICR #10018
 ; Reference to $$DT^XLFDT in ICR #10103
 ; Reference to $$FMDIFF^XLFDT in ICR #10103
 ; Reference to BMES^XPDUTL in ICR #10141
 ; Reference to MES^XPDUTL in ICR #10141
 ;
 Q  ; No entry from top
 ;
POST ; Execute post install logic
 N DA,DIC,DIE,DO,DR,FDA,X,DGVIEN,DGVMSG,DGVNOW,DGVSTART,Y,DGY,DGSRVC,DGCNTXTRT,DGDTC,DGSTA3N
 N DGOA,DGWA,DGEHT,DGOHT,DGOT,DGKY,DGES,DGEX,DGDEBUGON,DGMAXQUE,DGAUDSRV,DGMAILGRP,DGEXDAYS,DGBTSIZE,DGSD
 N SVCIEN,SRVRIEN,LOCSVCIEN,DGVASINST,DGMSG,DGVASRV,MGRPOK,DGERR
 ;
 D BMES^XPDUTL(">Updating WEB SERVICE (#18.02) file...")
 S DGSRVC="DG VAS WEB SERVICE"
 S DGCNTXTRT="/vsr/"
 D REGREST^XOBWLIB(DGSRVC,DGCNTXTRT) ; REGREST^XOBWLIB handles all messaging.
 ;
 S DGDTC=""
 S DGSTA3N=+$$STA^XUAF4($$KSP^XUPARAM("INST"))
 I $L(DGSTA3N) S DGDTC=$P($T(@DGSTA3N),";",2)
 S DGSD=$$GET1^DIQ(18.12,$$FIND1^DIC(18.12,"","X","DG VAS WEB SERVER")_",",.04)  ; Existing server default value from file 18.12
 I $$PROD^XUPROD D
 . S DGVASRV=$S(",AAC,DVR,SCR,"[(","_DGDTC_","):"rest.aitc.vas.domain.ext",",PHC,BYN,"[(","_DGDTC_","):"rest.pitc.vas.domain.ext",DGDTC="C11":"rest.aws.vas.domain.ext",1:"unknown.vas.server")
 . Q:DGVASRV'="unknown.vas.server"
 . N DGSTARS S $P(DGSTARS,"*",78)="*"
 . D BMES^XPDUTL(DGSTARS),MES^XPDUTL("******** WARNING! ********** WARNING! ********* WARNING! ********")
 . D BMES^XPDUTL("****    The DG VAS WEB SERVER could not be determined !   *******")
 . D MES^XPDUTL("****    Please enter a Help Desk ticket for assistance.   *******"),MES^XPDUTL(DGSTARS)
 . D BMES^XPDUTL(DGSTARS),BMES^XPDUTL("")
 I '$$PROD^XUPROD S DGVASRV=$S($L(DGSD):DGSD,1:"sandbox.vas.server")
 ;
 D BMES^XPDUTL(">Updating WEB SERVER (#18.12) file...")
 S FDA(18.12,"?+1,",.01)="DG VAS WEB SERVER"              ; NAME
 S FDA(18.12,"?+1,",.04)=DGVASRV                          ; SERVER
 S FDA(18.12,"?+1,",.06)="ENABLED"                        ; STATUS 1-ENABLED / 0-DISABLED
 S FDA(18.12,"?+1,",.07)=10                               ; DEFAULT HTTP TIMEOUT
 S FDA(18.12,"?+1,",3.01)="TRUE"                          ; SSL ENABLED
 S FDA(18.12,"?+1,",3.02)="encrypt_only_tlsv12"           ; SSL CONFIGURATION
 S FDA(18.12,"?+1,",3.03)=443                             ; SSL PORT
 D UPDATE^DIE("E","FDA",,"MSGROOT")
 I $D(MSGROOT("DIERR")) D BMES^XPDUTL($G(MSGROOT("DIERR",1,"TEXT",1)))
 I '$D(MSGROOT("DIERR")) D BMES^XPDUTL("DG VAS WEB SERVER successfully filed for station "_DGSTA3N) D
 . D MES^XPDUTL("and pointed to Data Center "_DGDTC_" server "_DGVASRV)
 ;
 ; File mail group if not already file
 S MGRPOK=$$MGRPOK
 ;
 ; If Server and Service successfully filed, attach service to server
 K FDA,MSGROOT
 S SRVRIEN=$$FIND1^DIC(18.12,"","X","DG VAS WEB SERVER")
 I $G(SRVRIEN) D
 .S SVCIEN=0 F  S SVCIEN=$O(^XOB(18.12,SRVRIEN,100,"B",SVCIEN)) Q:'SVCIEN  I $$GET1^DIQ(18.02,SVCIEN,.01)="DG VAS WEB SERVICE" S LOCSVCIEN=SVCIEN Q
 .S LOCSVCIEN=$S($G(LOCSVCIEN):LOCSVCIEN,1:"+1")
 .S FDA(18.121,LOCSVCIEN_","_SRVRIEN_",",.01)="DG VAS WEB SERVICE"      ; WEB SERVICE
 .S FDA(18.121,LOCSVCIEN_","_SRVRIEN_",",.06)="ENABLED"                 ; STATUS 1-ENABLED / 0-DISABLED
 .D UPDATE^DIE("E","FDA",,"MSGROOT")
 ; Set up scheduled task
 N DIFROM ; This allows the Task ID to be generated
 S DGVNOW=$E($$NOW^XLFDT,1,12)
 S DGVSTART=$$FMADD^XLFDT(DGVNOW,,,3)
 D RESCH^XUTMOPT("DG VAS EXPORT",DGVSTART,,"900S","L",.DGERR)
 ;
 ; Create the one and only entry in the DG VAS CONFIG File (#46.5) if it doesn't already exist.
 S DGVASINST=$$FIND1^DIC(46.5,,"Q",1) I 'DGVASINST N FDA S FDA(46.5,"?+1,",.01)=1,FDA(46.5,"?+1,",.02)=0 D UPDATE^DIE("","FDA",,"DGMSG")
 ;
 S DGMAXQUE=+$$GET^XPAR("ALL","DG VAS MAX QUEUE ENTRIES") I 'DGMAXQUE S DGMAXQUE=60000 D EN^XPAR("SYS","DG VAS MAX QUEUE ENTRIES",1,DGMAXQUE)
 S DGWA=$$GET^XPAR("ALL","DG VAS MAX WRITE ATTEMPTS") I 'DGWA S DGWA=100 D EN^XPAR("SYS","DG VAS MAX WRITE ATTEMPTS",1,DGWA)
 S DGDEBUGON=$$GET^XPAR("ALL","DG VAS DEBUGGING FLAG") I DGDEBUGON="" S DGDEBUGON=0 D EN^XPAR("SYS","DG VAS DEBUGGING FLAG",1,DGDEBUGON)
 S DGMAILGRP=$$GET^XPAR("ALL","DG VAS MONITOR GROUP") I DGMAILGRP="" S DGMAILGRP="DG VAS MONITOR" D EN^XPAR("SYS","DG VAS MONITOR GROUP",1,DGMAILGRP)
 S DGEXDAYS=$$GET^XPAR("ALL","DG VAS DAYS TO KEEP EXCEPTIONS") I 'DGEXDAYS S DGEXDAYS=3 D EN^XPAR("SYS","DG VAS DAYS TO KEEP EXCEPTIONS",1,DGEXDAYS)
 S DGBTSIZE=$$GET^XPAR("ALL","DG VAS BATCH SIZE") I 'DGBTSIZE S DGBTSIZE=1000 D EN^XPAR("SYS","DG VAS BATCH SIZE",1,DGBTSIZE)
 ; JPN ADD EMAIL XPAR  3/31/21
 I $$GET^XPAR("ALL","DG VAS MONITOR GROUP")="" D
 . W !!?5,*7,"The DG VAS MONITOR GROUP was not created or set up correctly"
 . W !?5,"You will need to either create this mail group in the DG VAS MODIFY  "
 . W !?5,"parameters, or contact Customer Service for assistance."
 ; 
 ; ADD PEOPLE TO EMAIL GROUP
 D EMAIL("DG*5.3*964")
 Q
 ;
EMAIL(PATCH) ; send email when patch is installed
 N DGVOFFN,DGVDUZ,DGSUBJ,DGMSG,DGXMTO,DGGLO,DGGLB,DGXMINSTR,DGVINST,DGSITE,DGAUDSTANUM,DGNOW,Y,%,DGEMAILI,DGEMAILE
 S DGNOW=$$FMTE^XLFDT($$NOW^XLFDT)
 S DGVDUZ=$G(DUZ)
 S:DGVDUZ'="" DGVINST=$O(^VA(200,DGVDUZ,2,"AX1",1,"")) ; Get User's Default Division
 S:$G(DGVINST)="" DGVINST=$$GET1^DIQ(8989.3,1,217,"I") ; Default Institution
 S DGVOFFN=$$GET1^DIQ(4,DGVINST,100) ; Official VA Name
 S DGSITE=$S(DGVOFFN'="":DGVOFFN,1:$$GET1^DIQ(8989.3,1,217))
 S DGAUDSTANUM=$$GET1^DIQ(4,DGVINST,99)
 I DGAUDSTANUM="" S DGAUDSTANUM=$$GET1^DIQ(4,$$GET1^DIQ(8989.3,1,217,"I"),99)
 S DGSUBJ=PATCH_" installed at Station# "_$G(DGSITE)_" - "_$G(DGAUDSTANUM)
 S DGSUBJ=$E(DGSUBJ,1,65)
 S DGMSG(2)=""
 S DGMSG(3)=" Name: "_$G(DGSITE)
 S DGMSG(4)=" Station#: "_$$GET1^DIQ(4,DGVINST,99)
 S DGMSG(5)=" Domain: "_$G(^XMB("NETNAME"))
 S DGMSG(6)=" Date/Time: "_DGNOW
 S DGMSG(7)=" By: "_$P($G(^VA(200,DUZ,0)),U,1)
 S DGMSG(8)=""
 S DGMSG(9)=""
 S DGMSG(10)="Patch Version: "_$S($G(PATCH)'="":PATCH,1:"Unknown Install File ien")
 ;
 ;Copy mesage to OIT team?
 I $$GOTLOCAL^XMXAPIG("DG VAS MONITOR") D
 . S DGXMTO(DUZ)=""
 . S DGEMAILI=$$GET^XPAR("ALL","DG VAS MONITOR GROUP")
 . S DGEMAILE=$$GET1^DIQ(3.8,+$G(DGEMAILI),.01)
 . S DGXMTO("G."_DGEMAILE)=""
 . S DGXMINSTR("FROM")="noreply.domain.ext"
 . D SENDMSG^XMXAPI(DUZ,DGSUBJ,"DGMSG",.DGXMTO,.DGXMINSTR)
 . Q:'$D(^TMP("XMERR",$J))  ; no email problems
 . ;
 . D MES^XPDUTL("MailMan reported a problem trying to send the notification message.")
 . D MES^XPDUTL(" ")
 . S (DGGLO,DGGLB)="^TMP(""XMERR"","_$J
 . S DGGLO=DGGLO_")"
 . F  S DGGLO=$Q(@DGGLO) Q:DGGLO'[DGGLB  D MES^XPDUTL(" "_DGGLO_" = "_$G(@DGGLO))
 . D MES^XPDUTL(" ")
 Q
 ;
MGRPOK() ; Check for valid mail group
 N DTOUT,DUOUT,Y,DGMGIEN,DGMGCOO,DGABORT,DGMGPAR,DGMGNAME,DGMGIEN
 ;If mail group doesn't exist, set it up
 S DGMGIEN=$$GET^XPAR("ALL","DG VAS MONITOR GROUP")
 I $G(DGMGIEN) S DGMGNAME=$$GET1^DIQ(3.8,+$G(DGEMAILI),.01)
 S:'$L($G(DGMGNAME)) DGMGNAME="DG VAS MONITOR"
 I $$GOTLOCAL^XMXAPIG(DGMGNAME) D  Q 1  ; Mail group exists and has active members, we're done here
 . D EN^XPAR("SYS","DG VAS MONITOR GROUP",1,DGMGNAME)
 S DGMGIEN=$$FIND1^DIC(3.8,"","B",DGMGNAME)
 ; Mail group doesn't exist, add it
 I 'DGMGIEN D MAILUSR(DGMGNAME,.DGABORT) Q:$G(DGABORT) 0
 ; Store mail group in parameter if not already there
 I '$$GET^XPAR("ALL",DGMGNAME) D EN^XPAR("SYS","DG VAS MONITOR GROUP",1,DGMGNAME)
 K DGMGPAR
 Q 1
 ;
MAILUSR(DGMGNAME,DGABORT) ; Prompt for mail organizer and/or member
 N DGMGCOMEM,DGMGPAR,DGDONE,DGMGCMY,DGMGPRS,DGMGPQT,DGMGPTP,DGMGPDS,DGMGPMY,DGMGPSL
 S DGMGCOMEM=+$G(DUZ)
 I $G(DUZ)>1 S DGMGPMY(+$G(DGMGCOMEM))=""
 S DGMGPTP=0,DGMGPSL=0,DGMGPQT=0
 S DGMGPDS(1)="Members of this mail group will receive various notifications that impact"
 S DGMGPDS(2)="the VistA Audit Solution (VAS) Registration application."
 S DGMGPRS=$$MG^XMBGRP(DGMGNAME,DGMGPTP,DGMGCOMEM,DGMGPSL,.DGMGPMY,.DGMGPDS,DGMGPQT)
 I DGMGPRS D  Q
 . D BMES^XPDUTL(">>> "_DGMGNAME_" mail group added successfully!")
 . D BMES^XPDUTL(">>> You have been added as a member of this mail group.")
 . D MES^XPDUTL("    Please add members or remove yourself as appropriate.")
 I 'DGMGPRS D BMES^XPDUTL("Unable to create "_DGMGNAME_" Mail Group.") S DGABORT=1
 Q
 ;
 ; Station to Regional Data Center crosswalk. Used to determine the correct REST API DNS
 ; for the current VistA facility/station.
358 ;AAC;Manila Outpatient Clinic (Philippines)
402 ;AAC;VA Maine Healthcare Systems (Togus)
405 ;AAC;White River Junction VA Medical Center 
436 ;AAC;VA Montana Health Care System (Ft. Harrison, Miles City)
437 ;AAC;Fargo VA Medical Center
438 ;AAC;Royal C. Johnson Veterans Memorial Medical Center (Sioux Falls)
442 ;AAC;Cheyenne VA Medical Center
459 ;AAC;VA Pacific Islands Health Care System (Honolulu)
460 ;AAC;Wilmington VA Medical Center
463 ;AAC;Alaska VA Healthcare System (Anchorage)
501 ;DVR;New Mexico VA Health Care System (Albuquerque)
502 ;AAC;Alexandria VA Health Care System (Pineville)
503 ;PHC;Altoona - James E. Van Zandt VA Medical Center
504 ;AAC;Amarillo VA Health Care System
506 ;PHC;VA Ann Arbor Healthcare System
508 ;PHC;Atlanta VA Health Care System
509 ;PHC;Charlie Norwood VA Medical Center (Augusta)
512 ;PHC;VA Maryland Health Care System (Baltimore, Loch Raven, Perry Point)
515 ;PHC;Battle Creek VA Medical Center
516 ;PHC;C.W. Bill Young VA Medical Center (Bay Pines)
517 ;PHC;Beckley VA Medical Center
518 ;PHC;Edith Nourse Rogers Memorial Veterans Hospital (Bedford VA)
519 ;AAC;West Texas VA Health Care System (Big Spring)
520 ;AAC;Gulf Coast Veterans Health Care System (Biloxi)
521 ;PHC;Birmingham VA Medical Center
523 ;PHC;VA Boston Health Care System (Jamaica Plain, Brockton, West Roxbury)
526 ;PHC;James J. Peters VA Medical Center (Bronx, NY)
528 ;PHC;Albany VA Medical Center (Samuel S. Stratton)
529 ;PHC;VA Butler Healthcare
531 ;C10;Boise VA Medical Center
534 ;PHC;Ralph H. Johnson VA Medical Center (Charleston)
537 ;AAC;Jesse Brown VA Medical Center (Chicago Westside, Chicago Lakeside)
538 ;PHC;Chillicothe VA Medical Center
539 ;PHC;Cincinnati VA Medical Center
540 ;PHC;Louis A. Johnson VA Medical Center (Clarksburg)
541 ;PHC;Louis Stokes Cleveland VA Medical Center
542 ;PHC;Coatesville VA Medical Center
544 ;PHC;Wm. Jennings Bryan Dorn VA Medical Center (Columbia)
546 ;PHC;Miami VA Healthcare System
548 ;PHC;West Palm Beach VA Medical Center
549 ;AAC;VA North Texas Health Care System (Dallas, Bonham)
550 ;PHC;VA Illiana Health Care System  (Danville)
552 ;PHC;Dayton VA Medical Center
553 ;PHC;John D. Dingell VA Medical Center (Detroit)
554 ;DVR;VA Eastern Colorado Health Care System (ECHCS) (Denver, Fort Lyon)
556 ;AAC;Captain James A. Lovell Federal Health Care Center (North Chicago)
557 ;PHC;Carl Vinson VA Medical Center  (Dublin)
558 ;PHC;Durham VA Medical Center
561 ;PHC;VA New Jersey Health Care System (East Orange, Lyons)
562 ;PHC;Erie VA Medical Center
564 ;AAC;Veterans Health Care System of the Ozarks (Fayetteville)
565 ;PHC;Fayetteville VA Medical Center
568 ;AAC;VA Black Hills Health Care System (Fort Meade, Hot Springs)
570 ;C10;Central California VA Health Care System (Fresno)
573 ;PHC;VA North Florida / South Georgia VA Health Care System  (Gainesville, Lake City)
575 ;DVR;Grand Junction VA Medical Center
578 ;AAC;Edward Hines Jr. VA Hospital (Hines)
580 ;AAC;Michael E. DeBakey VA Medical Center (Houston)
581 ;PHC;Huntington VA Medical Center
583 ;PHC;Richard L. Roudebush VA Medical Center (Indianapolis)
585 ;AAC;Oscar G. Johnson VA Medical Center (Iron Mountain)
586 ;AAC;G.V. (Sonny) Montgomery VA Medical Center (Jackson)
589 ;AAC;Wichita Medical Center
590 ;PHC;Hampton VA Medical Center
593 ;DVR;VA Southern Nevada Healthcare System (Las Vegas)
595 ;PHC;Lebanon VA Medical Center
596 ;PHC;Lexington VA Medical Center (Leestown, Cooper)
598 ;AAC;Central Arkansas Veterans Healthcare System (North Little Rock, Little Rock)
600 ;DVR;VA Long Beach Heathcare System
603 ;PHC;Robley Rex VA Medical Center (Louisville)
605 ;DVR;Jerry L. Pettis Memorial VA Medical Center (Loma Linda)
607 ;AAC;William S. Middleton Memorial Veterans Hospital (Madison)
608 ;PHC;Manchester VA Medical Center
610 ;PHC;VA Northern Indiana Health Care System (Marion, Fort Wayne)
612 ;C10;VA Northern California Health Care System (Mather)
613 ;PHC;Martinsburg VA Medical Center
614 ;PHC;Memphis VA Medical Center
618 ;AAC;Minneapolis VA Medical Center
619 ;AAC;Central Alabama Veterans Health Care System (Tuskegee, Montgomery)
620 ;PHC;VA Hudson Valley Health Care System (Montrose, Castle Point)
621 ;PHC;James H. Quillen VA Medical Center (Mountain Home)
623 ;PHC;Jack C. Montgomery VA Medical Center (Muskogee)
626 ;PHC;VA Tennessee Valley Health Care System (Nashville, Murfreesboro)
629 ;AAC;Southeast Louisiana Veterans Health Care System (New Orleans)
630 ;PHC;VA New York Harbor Health Care System (Brooklyn, Manhattan)
631 ;PHC;VA Central Western Massachusetts Healthcare System (Formerly Northampton VA Medical Center)
632 ;PHC;Northport VA Medical Center
635 ;AAC;Oklahoma City VA Medical Center
636 ;C11;Iowa City VA Health Care System
637 ;PHC;Asheville VA Medical Center
640 ;C10;VA Palo Alto Health Care System (Menlo Park, Palo Alto, Livermore) 
642 ;PHC;Philadelphia VA Medical Center
644 ;PHC;Phoenix VA Health Care System
646 ;PHC;VA Pittsburgh Health Care System (Pittsburgh University Dr., H. J. Heinz Campus)
648 ;C10;VA Portland Health Care System (Portland, Vancouver) 
649 ;DVR;Northern Arizona VA Health Care System (Prescott)
650 ;PHC;Providence VA Medical Center
652 ;PHC;Hunter Holmes McGuire VA Medical Center (Richmond)
653 ;C10;VA Roseburg Healthcare System
654 ;C10;VA Sierra Nevada Health Care System (Reno)
655 ;PHC;Aleda E. Lutz VA Medical Center (Saginaw)
656 ;AAC;St. Cloud VA Health Care System
657 ;PHC;Marion Medical Center
658 ;PHC;Salem VA Medical Center
659 ;PHC;W.G. (Bill) Hefner VA Medical Center (Salisbury)
660 ;DVR;VA Salt Lake City Health Care System
662 ;DVR;San Francisco VA Medical Center
663 ;C10;VA Puget Sound Health Care System (Seattle, American Lake)
664 ;DVR;VA San Diego Healthcare System
666 ;DVR;Sheridan VA Medical Center
667 ;AAC;Overton Brooks VA Medical Center (Shreveport)
668 ;C10;Mann-Grandstaff VA Medical Center (Spokane)
671 ;AAC;South Texas Veterans Health Care System (San Antonio, Kerrville)
672 ;PHC;VA Caribbean Healthcare System (San Juan)
673 ;PHC;James A. Haley Veterans' Hospital (Tampa)
674 ;AAC;Central Texas Veterans Health Care System (Temple, Waco)
675 ;PHC;Orlando VA Medical Center
676 ;AAC;Tomah VA Medical Center
678 ;DVR;Southern Arizona VA Health Care System (Tucson)
679 ;PHC;Tuscaloosa VA Medical Center 
687 ;AAC;Jonathan M. Wainwright Memorial VA Medical Center (Walla Walla)
688 ;PHC;Washington DC VA Medical Center
689 ;PHC;VA Connecticut Health Care System (West Haven, Newington)
691 ;C10;VA Greater Los Angeles Healthcare System (Los Angeles, West Los Angeles)
692 ;C10;VA Southern Oregon Rehabilitation Center & Clinics (White City)
693 ;PHC;Wilkes-Barre VA Medical Center
695 ;AAC;Clement J. Zablocki Veterans Affairs Medical Center (Milwaukee)
740 ;C11;VA Texas Valley Coastal Bend Health Care System
756 ;DVR;El Paso VA Health Care System 
757 ;PHC;Chalmers P. Wylie VA Ambulatory Care Center (Columbus)
