ORY519 ;ISP/LMT - OR*3*519 Post-Install ;Oct 15, 2020@08:13:25
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**519**;Dec 17, 1997;Build 36
 ;
 ; This routine uses the following ICRs:
 ;  #7129 - File #18.12 (private)
 ;   4478 - File 8925.1, Field .04        (private)
 ;
 Q
 ;
POST ;
 ;
 ; ZEXCEPT: XPDQUES
 N ORPDMPPORT,ORPDMPSERVER,ORPDMPUN,ORPDMPPW,ORSSLCONFIG
 ;
 ; Set Parameter Values
 D SETPARAM
 ;
 ; Setup web services
 S ORPDMPSERVER=$$TRIM^XLFSTR($G(XPDQUES("POST1SERVER")))
 S ORPDMPPORT=$$TRIM^XLFSTR($G(XPDQUES("POST2PORT")))
 S ORPDMPUN=$$TRIM^XLFSTR($G(XPDQUES("POST3UN")))
 S ORPDMPPW=$G(XPDQUES("POST4PW"))
 S ORSSLCONFIG=$$TRIM^XLFSTR($G(XPDQUES("POST5SSLCONFIG")))
 D WSSETUP(ORPDMPSERVER,ORPDMPPORT,ORPDMPUN,ORPDMPPW,ORSSLCONFIG)
 ;
 D DLGBULL
 ;
 Q
 ;
 ;
SETPARAM ;
 ;
 N ORERR,ORPAR,ORVAL,ORINST,ORX
 ;
 S ORPAR="OR PDMP REVIEW FORM"
 ;
 S ORVAL="Delegate Review Form"
 S ORVAL(1,0)="LBL^Last prior PDMP query was completed on |LASTDATE|.^black;1^^Center"
 S ORVAL(2,0)=" "
 S ORVAL(3,0)="RB^No prescription(s) for controlled substances outside the VA were found "
 S ORVAL(4,0)="in the last |DAYS| days.^0"
 S ORVAL(5,0)=" "
 S ORVAL(6,0)="RB^Prescription(s) which have been filled outside the VA in the last "
 S ORVAL(7,0)="|DAYS| days are noted.^0^Please be sure to record any active/chronic"
 S ORVAL(8,0)="medications discovered from PDMP query in the ""Non-VA Medications"" "
 S ORVAL(9,0)="section of the ""Meds"" Tab in CPRS."
 D SETPARVAL(ORPAR,"D","PKG",.ORVAL)
 ;
 S ORVAL="Provider Review Form"
 S ORVAL(1,0)="LBL^Last prior PDMP query was completed on |LASTDATE|.^black;1^^Center"
 S ORVAL(2,0)=" "
 S ORVAL(3,0)="RB^No prescription(s) for controlled substances outside the VA were found "
 S ORVAL(4,0)="in the last |DAYS| days.^0"
 S ORVAL(5,0)=" "
 S ORVAL(6,0)="RB^Prescription(s) filled outside the VA in the last |DAYS| days are "
 S ORVAL(7,0)="noted. However, they do not raise significant safety concerns and do not "
 S ORVAL(8,0)="influence the treatment plan at this time.^0^Please be sure to record any "
 S ORVAL(9,0)="active/chronic medications discovered from PDMP query in the ""Non-VA"
 S ORVAL(10,0)="Medications"" section of the ""Meds"" Tab in CPRS."
 S ORVAL(11,0)=" "
 S ORVAL(12,0)="RB^Prescription(s) filled outside the VA in the last |DAYS| days are "
 S ORVAL(13,0)="noted. Safety concerns will be discussed with the patient and documented "
 S ORVAL(14,0)="as part of ongoing treatment planning.^0^Please be sure to record any"
 S ORVAL(15,0)="active/chronic medications discovered from PDMP query in the ""Non-VA"
 S ORVAL(16,0)="Medications"" section of the ""Meds"" Tab in CPRS."
 S ORVAL(17,0)=" "
 S ORVAL(18,0)="RB^Prescription(s) filled outside the VA are noted and will be addressed "
 S ORVAL(19,0)="as follows:^1^Please be sure to record any active/chronic medications"
 S ORVAL(20,0)="discovered from PDMP query in the ""Non-VA Medications"" section of the"
 S ORVAL(21,0)="""Meds"" Tab in CPRS."
 D SETPARVAL(ORPAR,"P","PKG",.ORVAL)
 ;
 S ORPAR="OR PDMP NOTE TEXT"
 ;
 S ORVAL="Reason Text"
 S ORVAL(1,0)="The clinical justification for this PDMP query is to review controlled "
 S ORVAL(2,0)="substances prescribed outside of the VA, and any additional information "
 S ORVAL(3,0)="that may become available, as an important component of standard clinical "
 S ORVAL(4,0)="care, and in accordance with VHA policy."
 D SETPARVAL(ORPAR,"R","PKG",.ORVAL)
 ;
 S ORVAL="Canned Delegate Statement"
 S ORVAL(1,0)="The VA prescriber, for which I am a delegate, will be alerted of these"
 S ORVAL(2,0)="PDMP findings through co-signature of this progress note."
 D SETPARVAL(ORPAR,"CD","PKG",.ORVAL)
 ;
 S ORVAL="Disclosure Text"
 S ORVAL(1,0)="Patient information was shared with the PDMP Appriss Gateway."
 D SETPARVAL(ORPAR,"D","PKG",.ORVAL)
 ;
 S ORVAL="Error Text"
 S ORVAL(1,0)="An error occurred attempting to communicate with the Prescription Drug"
 S ORVAL(2,0)="Monitoring Program Clearinghouse. "
 S ORVAL(3,0)="Error information:"
 D SETPARVAL(ORPAR,"E","PKG",.ORVAL)
 ;
 S ORVAL="No Data Text"
 S ORVAL(1,0)="No patient data was returned from the PDMP Clearinghouse."
 D SETPARVAL(ORPAR,"N","PKG",.ORVAL)
 ;
 S ORPAR="OR PDMP DISCLOSED TO"
 S ORVAL="PDMP Appriss Gateway"
 D SETPARVAL(ORPAR,"A","PKG",ORVAL)
 S ORVAL="State PDMP"
 D SETPARVAL(ORPAR,"M","PKG",ORVAL)
 ;
 S ORPAR="OR PDMP BACKGROUND RETRIEVAL"
 S ORVAL="YES"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="OR PDMP COMMENT LIMIT"
 S ORVAL=250
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="OR PDMP COPY/PASTE ENABLED"
 S ORVAL="NO"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="OR PDMP DAYS BETWEEN REVIEWS"
 S ORVAL=90
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="OR PDMP DELEGATION ENABLED"
 S ORVAL="YES"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="OR PDMP NOTE TITLE"
 S ORVAL=$$FIND1^DIC(8925.1,"","X","STATE PRESCRIPTION DRUG MONITORING PROGRAM","","I $P(^(0),U,4)=""DOC""","ORERR")  ;ICR 4478
 I ORVAL<1 D BMES("Error. Could not find 'STATE PRESCRIPTION DRUG MONITORING PROGRAM' doc.")
 I ORVAL>0 D
 . S ORVAL="`"_ORVAL
 . D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="OR PDMP OPEN TIMEOUT"
 S ORVAL=10
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="OR PDMP POLLING INTERVAL"
 S ORVAL=2
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="OR PDMP SHOW BUTTON"
 S ORVAL="ALWAYS"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="OR PDMP TIME TO CACHE URL"
 S ORVAL=12
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="OR PDMP TIMEOUT QUERY"
 S ORVAL=300
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="OR PDMP TURN ON"
 S ORVAL="YES"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="OR PDMP USE DEFAULT BROWSER"
 S ORVAL="NO"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="OR PDMP PERSON CLASS"
 S ORINST=0
 F ORX="V090100","V090110","V090107","V090102","V090103","V090106","V090111","V090104","V090105","V090109","V090108","V090301","V090302","V090303" D
 . S ORINST=ORINST+1
 . S ORVAL=ORX
 . D SETPARVAL(ORPAR,ORINST,"PKG",.ORVAL)
 ;
 S ORPAR="ORQQCN DST/CTB FEATURE SWITCH",ORVAL="OFF"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="ORQQCN DST/CTB FEATURE SWITCH",ORVAL="OFF"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="ORQQCN CTB ORDER CNSLT",ORVAL="NO"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="ORQQCN CTB RECEIVE",ORVAL="NO"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="ORQQCN CTB SCHEDULE",ORVAL="NO"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="ORQQCN CTB CANCEL",ORVAL="NO"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="ORQQCN CTB EDITRES",ORVAL="NO"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="ORQQCN CTB DC",ORVAL="NO"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="ORQQCN CTB FORWARD",ORVAL="NO"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="ORQQCN CTB COMMENT",ORVAL="NO"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="ORQQCN CTB SIGFIND",ORVAL="NO"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="ORQQCN CTB ADMIN COMP",ORVAL="NO"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="ORQQCN DST TEST URL",ORVAL="https://dst-beta.domain.ext"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="ORQQCN DST PROD URL",ORVAL="https://dst.domain.ext"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="ORQQCN DST CONS DECISION",ORVAL="/cprs-api/v2/dst-decision/"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="ORQQCN DST CONS SAVE",ORVAL="/cprs-api/v2/consult/save"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="ORQQCN CTB PATH",ORVAL="/ctb/"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 S ORPAR="ORQQCN DST PATH",ORVAL="/v2/"
 D SETPARVAL(ORPAR,1,"PKG",.ORVAL)
 ;
 Q
 ;
 ;
SETPARVAL(ORPAR,ORINST,ORENT,ORVAL) ;
 ;
 N ORERR
 ;
 D BMES("Setting "_$G(ORENT)_" value for parameter "_ORPAR_" ("_ORINST_")...")
 ;
 D EN^XPAR(ORENT,ORPAR,ORINST,.ORVAL,.ORERR)
 K ORVAL
 I +$G(ORERR)>0 D MES("  ERROR #"_$P(ORERR,U)_": "_$P(ORERR,U,2)) Q
 D MES("  DONE")
 ;
 Q
 ;
 ;
WSSETUP(ORPDMPSERVER,ORPDMPPORT,ORPDMPUN,ORPDMPPW,ORSSLCONFIG) ;
 ;
 N ORERRMSG,ORFDA,ORIENS,ORNAME
 ;
 D BMES("Setting up Web Service Entries...")
 ;
 I $G(ORPDMPSERVER)="" D  Q
 . D MES("Skipping... Web Server Name not defined")
 I $G(ORPDMPPORT)="" D  Q
 . D MES("Skipping... Port Number not defined")
 I $G(ORPDMPUN)="" D  Q
 . D MES("Skipping... Username not defined")
 I $G(ORPDMPPW)="" D  Q
 . D MES("Skipping... Password not defined")
 I $G(ORSSLCONFIG)="" D  Q
 . D MES("Skipping... SSL Config not defined")
 ;
 ; Create Web service Entry
 D REGREST^XOBWLIB("PDMP WEB SERVICE","csp/resthsb/pdmp/PDMP.API.REST")
 ;
 ; Create Web Server
 S ORNAME="PDMP SERVER"
 I '$$PROD^XUPROD S ORNAME="PDMP TEST SERVER"
 S ORIENS="?+1,"
 S ORFDA(18.12,ORIENS,.01)=ORNAME                                    ; NAME
 S ORFDA(18.12,ORIENS,.04)=ORPDMPSERVER                              ; SERVER
 S ORFDA(18.12,ORIENS,.06)="ENABLED"                                 ; STATUS 1-ENABLED / 0-DISABLED
 S ORFDA(18.12,ORIENS,.07)=180                                       ; DEFAULT HTTP TIMEOUT
 S ORFDA(18.12,ORIENS,1.01)="YES"                                    ; LOGIN REQUIRED
 S ORFDA(18.12,ORIENS,3.01)="TRUE"                                   ; SSL ENABLED
 S ORFDA(18.12,ORIENS,3.02)=ORSSLCONFIG                              ; SSL CONFIGURATION
 S ORFDA(18.12,ORIENS,3.03)=ORPDMPPORT                               ; SSL PORT
 S ORFDA(18.12,ORIENS,200)=ORPDMPUN                                  ; USERNAME
 S ORFDA(18.12,ORIENS,300)=ORPDMPPW                                  ; PASSWORD
 ;
 S ORIENS="?+2,"_ORIENS
 S ORFDA(18.121,ORIENS,.01)="PDMP WEB SERVICE"
 S ORFDA(18.121,ORIENS,.06)="ENABLED"
 ;
 D UPDATE^DIE("EU","ORFDA","ORIENROOT")  ; ICR 7129
 ;
 I $D(^TMP("DIERR",$J)) D
 . D MES("The following errors occurred:")
 . D MSG^DIALOG("AE",.ORERRMSG)
 . D MES^XPDUTL(.ORERRMSG)
 ;
 Q
 ;
 ;
BMES(STR) ;
 ; Write string
 D BMES^XPDUTL($$TRIM^XLFSTR($$CJ^XLFSTR(STR,$G(IOM,80)),"R"," "))
 Q
MES(STR) ;
 ; Write string
 D MES^XPDUTL($$TRIM^XLFSTR($$CJ^XLFSTR(STR,$G(IOM,80)),"R"," "))
 Q
SENDDLG(ANAME) ;Return true if the current order dialog should be sent
 I ANAME="GMRCOR CONSULT" Q 1
 I ANAME="OR GTX DST ID" Q 1
 I ANAME="OR GTX DST STATUS MSG" Q 1
 Q 0
 ;
DLGBULL ;Send bulletin about modified dialogs (on first install)
 N ORD
 S ORD("GMRCOR CONSULT")=""
 D EN^ORYDLG(519,.ORD)
