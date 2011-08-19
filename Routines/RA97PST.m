RA97PST ;;HINES/RVD Post-init for BI-RADS and File 79.4 ; 10/10/08
 ;;5.0;Radiology/Nuclear Medicine;**97**;Mar 16, 1998;Build 6
 ; This is the post-install routine for patch RA*5.0*97
 ;
 ; Supported IA's
 ;    BMES^XPDUTL  =   10141
 ;    KSP^XUPARAM  =   2541
 ;    UPDATE^DIE   =   2053
 ;    GET1^DIQ     =   2056
 ;    ^XMD         =   10070
 ;
 ; Private IA's
 ;    Set Identifier "WRITE" node          =  5418
 ;    Insert "I" in ^RA(78.3,0), piece 2   =  5419
 ;
 ;1. Add records to file 78.3
 ; If there are no IENs 1100 thru 1106 and 1200 thru 1202
 ; then this routine will add records to file #78.3 using
 ; these IENs and set the 3rd piece of ^RA(78.3,0) to the
 ; highest IEN under IEN 999.
 ;
 ;2. Set the Identifier "WRITE" node for file 78.3's field 6
 ;
 ;3. Insert "I" into ^RA(78.3,0), piece 2, after file number
 Q
CRE ;create BI-RADS entry in file 78.3
 I '$D(DUZ)#2 D BMES^XPDUTL("*** Missing DUZ.  Post-init not done. ***") Q
 N RAIEN,RALEX,RAERR,RA,RAI,RAFLG,RAFDA,RAFAC,RANXT,RAD,RAPA,RAPAPG
 N RA1,RA2,RA3,RAAA,RACT,RATXT,RAX
 D BMES^XPDUTL("*** ADDING BI-RADS to file #78.3.")
 D BIR^RA97PST1("MAMMOGRAM",.RA,"","BIR","MQSA","MAMMOGRAPHY ASSESSMENT CATEGORIES")
 ;check to see if the facility has records within the 
 ;1100 thru 1106 and 1200 thru 1202 IEN range within file #78.3,
 ;the DIAGNOSTIC CODES file. 
 ;If there are, proceed with the install any way
 ;but:
 ;1) DO NOT alter the data (change pointers) in the file at the facility
 ;2) Send an email to an Outlook mail group identifying the facility 
 ;   where the conflict occurs.
 ;If there is no conflict, then add the IEN records to file 78.3
 ;RAFLG=1 means a record already exist in file 78.3 for the 
 ;range 1100 thru 1106 and 1200 thru 1202.
 S RAFLG=0,RANXT=0
 S RACT=0 ;counts number of successfully added records
 ;
 ;example:
 ; check range 1100 thru 1106 and build RAD array
 ;    ra(3)="84^Benign ^Category 2"  <-- in
 ;rad(1102)="84^Benign ^CATEGORY 2"  <-- out
 ;
 F RAI=1100:1:1106 D  Q:RAFLG=1
 .S RANXT=$O(RA(RANXT))
 .I $D(^RA(78.3,RAI,0)) S RAFLG=1 Q
 .S RAD(RAI)=RA(RANXT)
 .S $P(RAD(RAI),U,3)=$$UP^XLFSTR($P(RAD(RAI),U,3))
 .;remove trailing blank from piece 2
 .S RAX=$P(RAD(RAI),U,2),RA2=$L(RAX)
 .S:$E(RAX,RA2)=" " $P(RAD(RAI),U,2)=$E(RAX,1,RA2-1)
 .Q
 ; check range 1200 thru 1202
 I 'RAFLG F RAI=1200:1:1202 D  Q:RAFLG=1
 .I $D(^RA(78.3,RAI,0)) S RAFLG=1 Q
 .Q
 ;
 ;if RAFLG=1 email Outlook mail group, skip to ID section
 I RAFLG=1 D  G ID
 .S RAFAC=$$GET1^DIQ(4,+$$KSP^XUPARAM("INST"),.01)
 .N XMDUZ,XMSUB,XMTEXT,XMY,XMZ S XMDUZ=.5
 .S RATXT(1)=RAFAC_" has a conflict with one or more IENS in file 78.3,"
 .S RATXT(2)="DIAGNOSTIC CODES, in the range 1100-1106 and 1200-1202."
 .S XMSUB="DIAGNOSTIC CODES file IEN issue @ "_RAFAC,XMTEXT="RATXT("
 .S XMY(DUZ)=""  ;send Vista email of problem to the patch installer
 .; Define Outlook mail group to receive email of problem
 .S XMY("VAOITVHITRadiologyFacilityLevelApplicationIssues@va.gov")=""
 .NEW DIFROM
 .D ^XMD,BMES^XPDUTL(.RATXT)
 .Q
 ;
 ; Set up RAAA() for the Abdominal Aortic Aneurysm codes
 ;raaa(IEN file 78.3)=field .01^field 2^fields 3 and 4
 F RAI=1:1 S RAX=$T(AAACODE+RAI) Q:RAX=""  D
 .S RAX=$P(RAX,";;",2) ;redefine RAX
 .S RA1=$P(RAX,U,1),RA2=$P(RAX,U,2),RA3=$P(RAX,U,3)
 .S:RA2=1 $P(RAAA(RA1),U,1)=RA3
 .S:RA2=2 $P(RAAA(RA1),U,2)=RA3
 .S:RA2=3 $P(RAAA(RA1),U,3)=RA3
 .Q
 ;
 ;Add the BI-RADS codes to file 78.3
 D
 .S RAI=0 F  S RAI=$O(RAD(RAI)) Q:RAI=""  D
 ..S RAPA=$P($P(RAD(RAI),U,3),"CATEGORY ",2)
 ..;categories 0,3,4,5,6 have alerts
 ..S RAPAPG="n" S:"^0^3^4^5^6^"[("^"_RAPA_"^") RAPAPG="y"
 ..S RAFDA(78.3,"+1,",.01)="BI-RADS "_$P(RAD(RAI),U,3)
 ..S RAFDA(78.3,"+1,",2)=$E($P(RAD(RAI),U,2),1,80)
 ..S RAFDA(78.3,"+1,",3)=$$UP^XLFSTR(RAPAPG)
 ..S RAFDA(78.3,"+1,",4)=RAPAPG
 ..S RAFDA(78.3,"+1,",6)=$P(RAD(RAI),U,1)
 ..S RAIEN(1)=RAI
 ..D UPDATE^DIE("","RAFDA","RAIEN","RAERR")
 ..I $D(RAERR)#2 D
 ...S RATXT(1)="",RATXT(2)="Error adding "_$P(RAD(RAI),U,3)_" to the"
 ...S RATXT(3)="local DIAGNOSTIC CODES file #78.3." D BMES^XPDUTL(.RATXT)
 ..E  S RACT=RACT+1
 ..K RAFDA,RAIEN,RAERR
 ..Q
 .Q
 ;
 ; Add the AAA codes to file 78.3
 D
 .S RA1=0 F  S RA1=$O(RAAA(RA1)) Q:RA1=""  D
 ..S RAPAPG=$P(RAAA(RA1),U,3)
 ..S RAFDA(78.3,"+1,",.01)=$P(RAAA(RA1),U,1)
 ..S RAFDA(78.3,"+1,",2)=$P(RAAA(RA1),U,2)
 ..S RAFDA(78.3,"+1,",3)=$$UP^XLFSTR(RAPAPG)
 ..S RAFDA(78.3,"+1,",4)=RAPAPG
 ..S RAIEN(1)=RA1
 ..D UPDATE^DIE("","RAFDA","RAIEN","RAERR")
 ..I $D(RAERR)#2 D
 ...S RATXT(1)=""
 ...S RATXT(2)="Error adding "_$P(RAAA(RA1),U,1)_" to the"
 ...S RATXT(3)="local DIAGNOSTIC CODES file #78.3." D BMES^XPDUTL(.RATXT)
 ..E  S RACT=RACT+1
 ..K RAFDA,RAIEN,RAERR
 K RATXT
 S RATXT(1)=""
 S RATXT(2)="*** "_RACT_" of 10 BI-RADS and Abdominal Aortic Aneurysm codes"
 S RATXT(3)="have been successfully added to the DIAGNOSTIC CODES file #78.3. ***"
 D BMES^XPDUTL(.RATXT)
 ;put 3rd piece of ^RA(78.3,0) to highest value but under 999
 S RA1=$O(^RA(78.3,999),-1)
 S $P(^RA(78.3,0),U,3)=RA1
ID ;set Identifier "WRITE" node and insert "I"
 I '$D(^DD(78.3,0,"ID","WRITE")) D
 .S ^DD(78.3,0,"ID","WRITE")="D EN^DDIOL($$EN1^RABIRAD,"""",""?33"")"
 .D BMES^XPDUTL("*** Identifier ""WRITE"" has been added to file #78.3.")
 ; set "I" after file number in ^RA(78.3,0)
 S RA1=$P(^RA(78.3,0),U,2) I RA1=78.3 D
 .S $P(^RA(78.3,0),U,2)=RA1_"I"
 .D BMES^XPDUTL("*** ""I"" has been inserted to ^RA(78.3,0).")
 Q
AAACODE ; Abdominal Aortic Aneurysm codes
 ;;1200^1^ABDOMINAL AORTIC ANEURYSM NOT PRESENT
 ;;1200^2^The maximum width of the infrarenal aorta is less than three centimeters.
 ;;1200^3^n
 ;;1201^1^ABDOMINAL AORTIC ANEURYSM PRESENT
 ;;1201^2^The maximum width of the infrarenal aorta is at least three centimeters.
 ;;1201^3^y
 ;;1202^1^DOES NOT SATISFY SCREEN FOR AAA
 ;;1202^2^Exam is not technically adequate for AAA screening.
 ;;1202^3^n
