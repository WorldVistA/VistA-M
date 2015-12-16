ORY406 ;SLC/WAT - POST INSTALL ;01/27/15  12:57
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**406**;Dec 17, 1997;Build 13
 ;ICR - B/MES^XPDUTL - 10141,  EN^XPAR - 2263
 ;;GMTS*2.7*111 modifies health summary components for ICD-10 to expand the maximum ICD code/occurrence from 10 to 25.
 ;;This patch sets ORWRP TIME/OCC LIMITS INDV at the PACKAGE level so that OE/RR reports that use the same components
 ;;will also display 25 ICD-10 codes.
 ;
POST ; post-init
 N ORMSG,ORERRFLG
 S ORMSG(1)="This patch will establish a default value at the PACKAGE level"
 S ORMSG(2)="for the ORWRP TIME/OCC LIMITS INDV parameter."
 S ORMSG(2.5)="The value shall be: T-7;T;25"
 S ORMSG(3)="These reports in OE/RR REPORT (#101.24) are affected:"
 S ORMSG(4)="ORRPW ADT ADM DC"
 S ORMSG(5)="ORRPW ADT DC DIAG"
 S ORMSG(6)="ORRPW ADT EXP"
 S ORMSG(7)="ORRPW ADT ICD PROC"
 S ORMSG(8)="ORRPW ADT ICD SURG"
 S ORMSG(9)="ORRPW DOD ADT EXP"
 D BMES^XPDUTL(.ORMSG)
 D SETPARAM
 D:$G(ORERRFLG)=1 HELP
 Q
 ;
SETPARAM ;set param value
 N ORRPT,ORERR,ORVAL,ORI,ORRPID
 S ORVAL="T-7;T;25"
 F ORI=1:1 S ORRPT=$T(REPORT+ORI) Q:ORRPT["EOF"  D
 .S ORRPT=$P(ORRPT,";;",2)
 .S ORRPID=$O(^ORD(101.24,"B",ORRPT,"")) I +$G(ORRPID)'>0 D BMES^XPDUTL("   "_ORRPT_" NOT FOUND!!!") S ORERRFLG=1 Q
 .D EN^XPAR("PKG","ORWRP TIME/OCC LIMITS INDV",ORRPID,ORVAL,.ORERR)
 .I $G(ORERR)>0 D BMES^XPDUTL("Error setting parameter: "_$P(ORERR,"^",2)) S ORERRFLG=1 Q
 .D BMES^XPDUTL(ORRPT_" complete.")
 Q
 ;
REPORT ; list of OR reports to set parameter
 ;;ORRPW ADT ADM DC
 ;;ORRPW ADT DC DIAG
 ;;ORRPW ADT EXP
 ;;ORRPW ADT ICD PROC
 ;;ORRPW ADT ICD SURG
 ;;ORRPW DOD ADT EXP
 ;;EOF
 Q
 ;
HELP ; help message
 N ORHLPMSG
 S ORHLPMSG(1)=""
 S ORHLPMSG(2)="For any errors associated with missing parameters or missing reports,"
 S ORHLPMSG(3)="please submit a Remedy ticket for assistance."
 D BMES^XPDUTL(.ORHLPMSG)
 Q
