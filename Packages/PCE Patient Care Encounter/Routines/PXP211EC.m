PXP211EC ;SLC/PKR - Environment check for PX*1.0*211 ;01/23/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 84
 ;======================
ENVCHK ;Environment check.
 D DUPNAME^PXP211EC
 I '$D(XPDABORT) D BMES^XPDUTL("The environment check passed, this build can be installed.")
 Q
 ;
 ;======================
DUPNAME ;Environment check for duplicate .01s, duplicates must be resolved
 ;before the install.
 N IEN,NAME,NFOUND,TEXT,UPNAME
 S TEXT(1)=""
 S TEXT(3)="this must be corrected before the patch can be installed."
 ;Education Topics
 S NAME=""
 F  S NAME=$O(^AUTTEDT("B",NAME)) Q:NAME=""  D
 . S UPNAME=$$UP^XLFSTR(NAME)
 . S IEN=""
 . F  S IEN=$O(^AUTTEDT("B",NAME,IEN)) Q:IEN=""  D
 .. S ^TMP($J,"UPNAME",UPNAME,IEN)=""
 D BMES^XPDUTL("Checking for duplicated Education Topics ... ")
 S UPNAME=""
 F  S UPNAME=$O(^TMP($J,"UPNAME",UPNAME)) Q:UPNAME=""  D
 . S IEN="",NFOUND=0
 . F  S IEN=$O(^TMP($J,"UPNAME",UPNAME,IEN)) Q:IEN=""  S NFOUND=NFOUND+1
 . I NFOUND>1 D
 .. S TEXT(2)="Education Topic "_UPNAME_" is duplicated "_NFOUND_" times,"
 .. D MES^XPDUTL(.TEXT)
 .. D MES^XPDUTL("The entries are:")
 .. S IEN=""
 .. F  S IEN=$O(^TMP($J,"UPNAME",UPNAME,IEN)) Q:IEN=""  D
 ... S NAME=$P(^AUTTEDT(IEN,0),U,1)
 ... D MES^XPDUTL(" "_NAME_" (IEN="_IEN_")")
 .. S XPDABORT=1
 K ^TMP($J,"UPNAME")
 ;
 ;Exams
 S NAME=""
 F  S NAME=$O(^AUTTEXAM("B",NAME)) Q:NAME=""  D
 . S UPNAME=$$UP^XLFSTR(NAME)
 . S IEN=""
 . F  S IEN=$O(^AUTTEDT("B",NAME,IEN)) Q:IEN=""  D
 .. S ^TMP($J,"UPNAME",UPNAME,IEN)=""
 D BMES^XPDUTL("Checking for duplicated Exams ... ")
 S UPNAME=""
 F  S UPNAME=$O(^TMP($J,"UPNAME",UPNAME)) Q:UPNAME=""  D
 . S IEN="",NFOUND=0
 . F  S IEN=$O(^TMP($J,"UPNAME",UPNAME,IEN)) Q:IEN=""  S NFOUND=NFOUND+1
 . I NFOUND>1 D
 .. S TEXT(2)="Exam "_UPNAME_" is duplicated "_NFOUND_" times,"
 .. D MES^XPDUTL(.TEXT)
 .. D MES^XPDUTL("The entries are:")
 .. S IEN=""
 .. F  S IEN=$O(^TMP($J,"UPNAME",UPNAME,IEN)) Q:IEN=""  D
 ... S NAME=$P(^AUTTEXAM(IEN,0),U,1)
 ... D MES^XPDUTL(" "_NAME_" (IEN="_IEN_")")
 .. S XPDABORT=1
 K ^TMP($J,"UPNAME")
 ;
 ;Health Factors
 S NAME=""
 F  S NAME=$O(^AUTTHF("B",NAME)) Q:NAME=""  D
 . S UPNAME=$$UP^XLFSTR(NAME)
 . S IEN=""
 . F  S IEN=$O(^AUTTHF("B",NAME,IEN)) Q:IEN=""  D
 .. S ^TMP($J,"UPNAME",UPNAME,IEN)=""
 D BMES^XPDUTL("Checking for duplicated Health Factors ... ")
 S UPNAME=""
 F  S UPNAME=$O(^TMP($J,"UPNAME",UPNAME)) Q:UPNAME=""  D
 . S IEN="",NFOUND=0
 . F  S IEN=$O(^TMP($J,"UPNAME",UPNAME,IEN)) Q:IEN=""  S NFOUND=NFOUND+1
 . I NFOUND>1 D
 .. S TEXT(2)="Health Factor "_UPNAME_" is duplicated "_NFOUND_" times,"
 .. D MES^XPDUTL(.TEXT)
 .. D MES^XPDUTL("The entries are:")
 .. S IEN=""
 .. F  S IEN=$O(^TMP($J,"UPNAME",UPNAME,IEN)) Q:IEN=""  D
 ... S NAME=$P(^AUTTHF(IEN,0),U,1)
 ... D MES^XPDUTL(" "_NAME_" (IEN="_IEN_")")
 .. S XPDABORT=1
 K ^TMP($J,"UPNAME")
 Q
 ;
