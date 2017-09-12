EC2P6PST ;ALB/GTS - PATCH EC*2.0*6 Post-Init Rtn ; 9/2/97
 ;;2.0; EVENT CAPTURE ;**6**;8 May 96
 ;
TEXT ; Install desc.
 ;; This part of the install walks through Event Capture Screens to check
 ;; for the existence of pointers to inactivated National Procedures.
 ;; A mail message is then sent indicating those screens which point
 ;; to inactivated National Procedures.  This message should be forwarded
 ;; to Event Capture users responsible for management of Event Code
 ;; Screens.
 ;;QUIT
 ;
MSGTXT ; Message intro
 ;; This message indicates the Event Code Screens which now point to
 ;; inactive National Procedures.  The user should use the Inactivate
 ;; Event Code Screens [ECDSINAC] option to inactivate the screens
 ;; indicated and, when appropriate, create new screens which include a
 ;; respective substitute for the National Procedure which has been
 ;; inactivated.
 ;;QUIT
 ;
POST ; Entry point
 ;* If 725 converted, write message
 I $$GET1^DID(725,"","","PACKAGE REVISION DATA")["EC*2*6" DO
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL("National Procedure file (#725) previously updated.")
 .D MES^XPDUTL(" ")
 ;* Convert DSS Unit, DSS ID
 I $$GET1^DID(725,"","","PACKAGE REVISION DATA")'["EC*2*6" D ENTCNV
 Q
 ;
ENTCNV ; Convert DSS Unit, Associated DSS ID
 N I,TXTVAR,ECGOODDA,ECBADDA,ECDARES,ECPTRCHK,ECGOODPT,ECVRRV
 D BMES^XPDUTL("Updating the National Procedures file (#725)...")
 D MES^XPDUTL(" ")
 ;
 D EN^EC725UPD ;*Update National Procedures
 ;
 ;*Get duplicate entry and inactivate both
 S ECDARES=$$GETDA("AURAL REHAB STATUS EXAM, 15 MIN","") ;*Get #725 IENs
 S ECGOODDA=$P(ECDARES,"^",2)
 S ECBADDA=$P(ECDARES,"^",3)
 S ECPTRCHK=ECBADDA_";EC(725," ;** Bad variable pointer value
 S ECGOODPT=ECGOODDA_";EC(725," ;** Good variable pointer value
 ;
 D SETTMP^EC725CHG ;** Set ^TMP global of procedures inactivated
 ;
 ;** Inactivate the duplicate entry in the National Procedure file (725)
 I +ECBADDA>0 DO
 .S DIE="^EC(725,",DA=ECBADDA,DR="2////^S X=2970831"
 .D ^DIE
 .K DIE,DA,DR
 ;
 ;** Inactivate the original entry in the National Procedure file (725)
 I +ECGOODDA>0 DO
 .S DIE="^EC(725,",DA=ECGOODDA,DR="2////^S X=2970831"
 .D ^DIE
 .K DIE,DA,DR
 ;
 D MES^XPDUTL(" "),MES^XPDUTL(" ")
 F I=1:1 S TXTVAR=$P($T(TEXT+I),";;",2) Q:TXTVAR="QUIT"  DO
 .S:TXTVAR="" TXTVAR=" "
 .D MES^XPDUTL(TXTVAR)
 D F7203INS ;*Report EC Screens pointing to inactive National Procedures
 ;
 S ECVRRV=$$GET1^DID(725,"","","PACKAGE REVISION DATA")
 S ECVRRV=ECVRRV_"^EC*2*6"
 D PRD^DILFD(725,ECVRRV) ;*Set VRRV node (file #725)
 ;
 D KVARS
 Q
 ;
F7203INS ;* Inspect/Report 720.3
 D BMES^XPDUTL("Inspecting EC Event Code Screens file (#720.3)...")
 ;
 ;** Inspect Variable Pointers
 N ECPTR,ECPROCT,EC01,COUNT
 N I,TXTVAR,ECLOC,ECUNIT,ECCAT,ECCATNM,ECPROC,ECSCDA
 S COUNT=0
 D LINE(" "),LINE(" ")
 F I=1:1 S TXTVAR=$P($T(MSGTXT+I),";;",2) Q:TXTVAR="QUIT"  DO
 .S:TXTVAR="" TXTVAR=" "
 .D LINE(TXTVAR)
 S (EC01,ECPROCT)=0
 F  S EC01=$O(^ECJ("B",EC01)) Q:+EC01=0  DO
 .S ECPTR=$P(EC01,"-",4)
 .S ECSCDA=$O(^ECJ("B",EC01,0))
 .I $D(^TMP($J,"EC*2*6 INACTIVE PROC",ECPTR)) DO
 ..I $P(^ECJ(ECSCDA,0),"^",2)>DT!($P(^ECJ(ECSCDA,0),"^",2)="") DO
 ...D LINE(" ")
 ...S ECLOC=$P(EC01,"-",1)
 ...S ECUNIT=$P(EC01,"-",2)
 ...S ECCAT=$P(EC01,"-",3)
 ...S ECLOC=$P($G(^DIC(4,ECLOC,0)),"^",1)
 ...S ECUNIT=$P($G(^ECD(ECUNIT,0)),"^",1)
 ...S:+ECCAT'=0 ECCATNM=$P($G(^EC(726,ECCAT,0)),"^",1)
 ...S:+ECCAT=0 ECCATNM="None"
 ...S ECPROC=$P($G(^EC(725,$P(ECPTR,";",1),0)),"^",1)
 ...D LINE(" ")
 ...D LINE(" The procedure for the following Event Code Screen has been inactivated.")
 ...D LINE("  Location:  "_ECLOC)
 ...D LINE("  Category:  "_ECCATNM)
 ...D LINE("  DSS Unit:  "_ECUNIT)
 ...D LINE("  Procedure: "_ECPROC)
 ...S ECPROCT=ECPROCT+1
 I ECPROCT=0 DO
 .D LINE(" ")
 .D LINE("No Event Code Screens were identified as associated with newly inactivated")
 .D LINE("National Procedures.")
 D MAIL
 D MES^XPDUTL(" ")
 D MES^XPDUTL(ECPROCT_" Event Code Screens pointing to inactive procedures identified and ")
 D MES^XPDUTL("message sent.")
 Q
 ;
KVARS K ^TMP($J,"EC*2*6 INACTIVE PROC")
 Q
 ;
GETDA(ECNAME,ECNUM) ; Get IENs for duplicate entries in 725
 ; Input:
 ;  ECNAME - The name of the National Procedure to search for a duplicate
 ;  ECNUM  - The National Number of the procedure to search
 ;
 ; Output:
 ;  ECDAS  - Indicates if a duplicate entry was found and the IENs of
 ;            the original and duplicate entry
 ;           Values
 ;            -1        : Entry was not found in National Procedure file
 ;            0^ien     : A single active entry was found (ien returned)
 ;            1^ien^ien : Duplicate active entries found (iens returned)
 ;
 ; Note: If both Name and number are received the Name is searched and
 ;        number ignored
 ;
 N ECDAS,ECNPIEN,ECLPQT
 S ECDAS=-1
 S (ECLPQT,ECNPIEN)=0
 I ECNAME'="" DO
 .F  S ECNPIEN=$O(^EC(725,"B",ECNAME,ECNPIEN)) Q:+ECNPIEN=0  Q:ECLPQT  DO
 ..I $P(^EC(725,ECNPIEN,0),"^",3)>DT!($P(^EC(725,ECNPIEN,0),"^",3)="") DO
 ...I +ECDAS=0 S ECDAS="1^"_$P(ECDAS,"^",2)_"^"_ECNPIEN S ECLPQT=1
 ...S:ECDAS=-1 ECDAS="0^"_ECNPIEN
 I ECNUM'="",ECNAME="" DO
 .F  S ECNPIEN=$O(^EC(725,"D",ECNUM,ECNPIEN)) Q:+ECNPIEN=0  Q:ECLPQT  DO
 ..I $P(^EC(725,ECNPIEN,0),"^",3)>DT!($P(^EC(725,ECNPIEN,0),"^",3)="") DO
 ...I +ECDAS=0 S ECDAS="1^"_$P(ECDAS,"^",2)_"^"_ECNPIEN S ECLPQT=1
 ...S:ECDAS=-1 ECDAS="0^"_ECNPIEN
 Q ECDAS
 ;
MAIL ; Send message
 N DIFROM
 S XMY(DUZ)="",XMDUZ=.5
 S XMSUB="Event Code Screens to review"
 S XMTEXT="^TMP(""EC V2.0 P6 INSTALL MSG"","_$J_","
 D ^XMD
 K XMDUZ,XMY,XMTEXT,XMSUB
 K ^TMP("EC V2.0 P6 INSTALL MSG",$J)
 Q
 ;
LINE(TEXT) ; Add line to message global
 S COUNT=COUNT+1,^TMP("EC V2.0 P6 INSTALL MSG",$J,COUNT)=TEXT
 Q
