MDCLIO1 ;HINES OIFO/DP - CliO backend driver (Continuation);02 Sep 2005
 ;;1.0;CLINICAL PROCEDURES;**16**;Apr 01, 2004;Build 280
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ;  # 3027       - NOTICE^DGSEC4                Registration                   (supported)
 ;  # 5407       - GETDCOS^ORWTPN               OE/RR                          (controlled subscription)
 ;  # 3568       - LNGCP^TIUCP                  TIU                            (controlled subscription)
 ;  # 3535       - TIUSRVP calls                TIU                            (controlled subscription)
 ;  # 1800       - REQCOS^TIUSRVA               TIU                            (controlled subscription)
 ;  # 2876       - LONGLIST^TIUSRVD             TIU                            (controlled subscription)
 ;  # 2263       - XPAR calls                   Toolkit                        (supported)
 ;  #10045       - HASH^XUSHSHP                 Kernel                         (supported)
 ;  # 2240       - ENCRYP^XUSRB1                Kernel                         (supported)
 ;  # 2241       - DECRYP^XUSRB1                Kernel                         (supported)
 ;  # 4866       - access ^GMRD(120.51,"AVUID"  Vitals                         (private)
 ;  # 4114       - access ^PXRMINDX(120.5       Clinical Reminders             (controlled subscription)
 ;  #10040       - access ^SC(                  Scheduling                     (supported)
 ;
GETPT ; Does an old style lookup on file 2 so that we don't have to use a PK
 D FIND^DIC(2,,.01,"KMP",P2(0),"*")
 F X=0:0 S X=$O(^TMP("DILIST",$J,X)) Q:'X  S @MDROOT@(+^(X,0))=""
 Q
GETESIG ; Returns record with boolean of proper E-Sig entered
 D NEWDOC^MDCLIO("RESULTS","ESIG-VALIDATION")
 D XMLHDR^MDCLIO("RECORD")
 D XMLDATA^MDCLIO("EXTERNAL",P2(0))
 S X=$G(P2(0)) D HASH^XUSHSHP S MDX=X
 D XMLDATA^MDCLIO("INTERNAL",MDX)
 D XMLDATA^MDCLIO("VALID",MDX=$$GET1^DIQ(200,DUZ_",",20.4,"I"))
 D XMLFTR^MDCLIO("RECORD")
 D ENDDOC^MDCLIO("RESULTS")
 Q
GETKRDXA(MDPT,MDSTRT,MDSTOP) ; Returns all actions for patient MDPT active between MDSTRT & MDSTOP
 Q
GETKRDXE(MDTASK,MDSTRT,MDSTOP) ; Returns all events for Kardex Action MDTASK active between MDSTRT & MDSTOP
 Q
GETGUID(X) ; Returns a string formatted as a GUID (NO GUARANTEE OF UNIQUENESS)
 S X=""
 F  S X=X_$$BASE^XLFUTL($R(16),10,16) Q:$L(X)>31
 S X="{"_$E(X,1,8)_"-"_$E(X,9,12)_"-"_$E(X,13,16)_"-"_$E(X,17,20)_"-"_$E(X,21,32)_"}"
 Q
ISGUID(MDX) ; Returns true if X is in the format of a GUID
 N X,Y
 Q:$L(MDX)'=38 0
 Q:MDX'?1"{"8UN1"-"4UN1"-"4UN1"-"4UN1"-"12UN1"}" 0
 ; Scan for Uppercase character above F
 X "S X=1 F Y=71:1:90 I MDX[$C(Y) S X=0 Q"
 Q X
 ;
PXRMALL ; Full rebuild of the Clinical Reminders Index - Only Verified sent for rebuild
 F MD=0:0 S MD=$O(^MDC(704.117,MD)) Q:'MD  D:$P(^(MD,0),U,9)=1 PXRMONE(MD)
 Q
PXRMONE(MDIEN) ; Maintain the Clinical Reminders Index
 N MDVUID,MDVITAL,MDGBL,MDDFN,MDDT,MDSTAT
 S MDVUID=$$GET1^DIQ(704.117,MDIEN_",",".07:99.99","I") Q:MDVUID=""
 S MDVITAL=$O(^GMRD(120.51,"AVUID",MDVUID,0)) Q:'MDVITAL
 S MDGUID=$P(^MDC(704.117,MDIEN,0),U),MDDFN=$P(^(0),U,8),MDDT=$P(^(0),U,5),MDSTAT=$P(^(0),U,9)
 Q:MDGUID=""!('MDDFN)!('MDDT)  ; Just in case :)
 S MDGBL=$NA(^PXRMINDX(120.5))
 I MDSTAT=1 D
 .S @MDGBL@("PI",MDDFN,MDVITAL,MDDT,MDGUID)=""
 .S @MDGBL@("IP",MDVITAL,MDDFN,MDDT,MDGUID)=""
 E  D
 .K @MDGBL@("PI",MDDFN,MDVITAL,MDDT,MDGUID)
 .K @MDGBL@("IP",MDVITAL,MDDFN,MDDT,MDGUID)
 Q
LOGSEC ; Logs a security hit in PIMS
 D NOTICE^DGSEC4(.MDRET,P2(0))
 S @RESULTS@(0)=$S(MDRET:"1^Logged",1:"-1^Unable to log")
 Q
GETTIUCP ; Gets a list of CP Class TIU notes - bypass regular lookup stuff and call directly
 N MDRET K @RESULTS
 S MDDATA=$$UP^XLFSTR(P2(0))
 D NEWDOC^MDCLIO("RESULTS","VERSION INFORMATION")
 D LNGCP^TIUCP(.MDRET,MDDATA)
 I $D(MDRET(44)),$P($P(MDRET(44),U,2),$$UP^XLFSTR(P2(0)))="" D XMLFTR^MDCLIO("RESULTS") Q
 F Y=0:0 S Y=$O(MDRET(Y)) Q:'Y  D:$P(MDRET(Y),U,2)?@("1"""_MDDATA_""".E")
 .D XMLHDR^MDCLIO("RECORD")
 .D XMLDATA^MDCLIO("ID",$P(MDRET(Y),U,1))
 .D XMLDATA^MDCLIO("NAME",$P(MDRET(Y),U,2))
 .D XMLFTR^MDCLIO("RECORD")
 K MDDATA
 D ENDDOC^MDCLIO("RESULTS")
 Q
GETTIUPN ; Gets list of all Progress Note Titles
 N MDRET K @RESULTS
 S MDDATA=$$UP^XLFSTR(P2(0))
 D NEWDOC^MDCLIO("RESULTS","VERSION INFORMATION")
 D LONGLIST^TIUSRVD(.MDRET,3,MDDATA)
 I $D(MDRET(44)),$P($P(MDRET(44),U,2),$$UP^XLFSTR(P2(0)))="" D XMLFTR^MDCLIO("RESULTS") Q
 F Y=0:0 S Y=$O(MDRET(Y)) Q:'Y  D:$P(MDRET(Y),U,2)?@("1"""_MDDATA_""".E")
 .D XMLHDR^MDCLIO("RECORD")
 .D XMLDATA^MDCLIO("ID",$P(MDRET(Y),U,1))
 .D XMLDATA^MDCLIO("NAME",$P(MDRET(Y),U,2))
 .D XMLFTR^MDCLIO("RECORD")
 K MDDATA
 D ENDDOC^MDCLIO("RESULTS")
 Q
GETUSER ; Gets the current users record in ^VA(200,
 S MDROOT="MDROOT"
 S MDROOT(DUZ)=""
 Q
GETLST ; Get a list of observations sent down in P2(0..n)=ID
 S MDROOT=$NA(^TMP("MDCLIO",$J)) K @MDROOT
 S MDID=""
 F  S MDID=$O(P2(MDID)) Q:MDID=""  D:P2(MDID)]""
 .S X=$O(^MDC(704.117,"PK",P2(MDID),0)) S:X @MDROOT@(0,X)=""
 Q
GETONE(ID) ; Get single Observation + Children if any
 S X=$$FIND1^DIC(704.117,,"KXP",ID(0))
 Q:'X  S @MDROOT@(0,X)=""
 F Y=0:0 S Y=$O(^MDC(704.117,"AP",X,Y)) Q:'Y  S @MDROOT@(Y,$O(^MDC(704.117,"AP",X,Y,0)))=""
 Q
LOCATION ; Get list of wards, clinics and non-stops
 N MDNOW D NOW^%DTC S MDNOW=%
 S MDROOT=$NA(^TMP("MDCLIO",$J)) K @MDROOT
 F X=0:0 S X=$O(^SC(X)) Q:'X  D:"CWN"[$P(^(X,0),U,3)
 .I '+$G(^SC(X,"I")) S @MDROOT@(X)="" Q  ; No deactivation date on file
 .I +^SC(X,"I")<MDNOW&('$P(^("I"),U,2)) Q  ; No reactivation date
 .I +^SC(X,"I")<MDNOW&($P(^("I"),U,2)>MDNOW) Q  ; future reactivation date
 .S @MDROOT@(X)=""
 Q
 ;
GETSUPPG ; Get list of supplemental/optional pages for a date range
 ; P2(0)=Patient DFN
 ; P2(1)=Start Date
 ; P2(2)=Stop Date
 S MDDFN=P2(0),MDDT=P2(2)+.0000001,MDROOT=$NA(^TMP("MDCLIO",$J)) K @MDROOT
 S MDFR=$$FMDT^MDCLIO(P2(1))
 S MDDT=$$FMDT^MDCLIO(P2(2))+.0000001
 F  S MDDT=$O(^MDC(704.1122,"ADT",MDDFN,MDDT),-1) Q:'MDDT  D
 .S MDIEN="" F  S MDIEN=$O(^MDC(704.1122,"ADT",MDDFN,MDDT,MDIEN),-1) Q:'MDIEN  D
 ..I $G(^MDC(704.1122,MDIEN,.2)) Q:$G(^(.2))<MDFR  ; Deactivated before start date
 ..I +$G(^MDC(704.1122,MDIEN,.2))&($P($G(^MDC(704.1122,MDIEN,.1)),U,4)=1) Q  ; Deactivated Optional Page
 ..S @MDROOT@(MDIEN)=""
 Q
GETHL7(ID) ; Get text of HL7 Message from 704.002 entry
 S IEN=+$$FIND1^DIC(704.002,,"KX",ID)
 D XMLHDR^MDCLIO("HL7_TEXT")
 D:IEN>0
 .D GETMSG^MDCPHL7B(.MDRET,IEN)
 .S X=MDRET F  S X=$Q(@X) Q:$E(X,1,$L(MDRET)-1)'=$E(MDRET,1,$L(MDRET)-1)  D
 ..D XMLADD^MDCLIO($$XMLSAFE^MDCLIO(@X))
 D XMLFTR^MDCLIO("HL7_TEXT")
 Q
SETACL ; Sets the ACL for an Item
 D SETACL^MDCLIO
 Q
 ;
DELACL ; Removes and item from ACL
 D DELACL^MDCLIO
 Q
 ;
SUBMIT ; Submits an HL7 message back to the queue
 N MDMSG,MDSTAT
 S MDMSG=$$FIND1^DIC(704.002,,"KX",P2(0))
 I MDMSG<1 S @RESULTS@(0)="-1^NO SUCH MESSAGE" Q
 S MDSTAT=$G(P2(1),3) ; Default to error if you didn't get a status
 D UPDATERP^MDCPHL7B(.MDRET,MDMSG,MDSTAT)
 S @RESULTS@(0)="1^Submitted"
 Q
QRYDATE(MDRET,MDSTRT,MDSTOP) ; Get list of all observations by DATE/TIME
 K @MDRET
 F X=MDSTRT-.0000001:0 S X=$O(^MDC(704.117,"ADT",X)) Q:'X!(X>MDSTOP)  D
 .F Y=0:0 S Y=$O(^MDC(704.117,"ADT",X,Y)) Q:'Y  D
 ..Q:$P(^MDC(704.117,Y,0),U,9)'=1
 ..S @MDRET@($O(@MDRET@(""),-1)+1)=$P(^MDC(704.117,Y,0),U)
 S @MDRET@(0)=+$O(@MDRET@(""),-1)
 Q
QRYLST(MDRET,MDDFN,MDITEM,MDSTRT,MDSTOP) ; Get list of observations by VUID or TERM NAME
 N MDTERM
 K @MDRET
 S MDSTRT=$G(MDSTRT,DT\1) ; Default today @00:00
 S MDSTOP=$G(MDSTOP,DT\1+.24) ; Default today @24:00
 S MDTERM=$$FIND1^DIC(704.101,"","PKMX",MDITEM,"C^VUID","I $P(^(0),U,5)=1")
 I MDTERM<1 S @MDRET@(0)="-1^Cannot find term '"_MDITEM_"'" Q
 F X=MDSTRT-.0000001:0 S X=$O(^MDC(704.117,"PT",MDDFN,X)) Q:'X!(X>MDSTOP)  D
 .F Y=0:0 S Y=$O(^MDC(704.117,"PT",MDDFN,X,Y)) Q:'Y  D
 ..Q:$P(^MDC(704.117,Y,0),U,9)'=1
 ..Q:$P(^MDC(704.117,Y,0),U,7)'=MDTERM
 ..S @MDRET@($O(@MDRET@(""),-1)+1)=$P(^MDC(704.117,Y,0),U)
 S @MDRET@(0)=+$O(@MDRET@(""),-1)
 Q
 ;
QRYOBS(MDRET,MDID) ; Return a single observation
 N MDTMP
 K @MDRET
 S MDIEN=$$FIND1^DIC(704.117,"","PKX",MDID,"PK")
 I MDIEN<1 S @MDRET@(0)="-1^No such observation '"_MDID_"'" Q
 D GETS^DIQ(704.117,MDIEN_",","*","EIR","MDTMP")
 M @MDRET=MDTMP(704.117,MDIEN_",") K MDTMP
 S @MDRET@("TERM_ID","I")=$$GET1^DIQ(704.117,MDIEN_",",".07:99.99")
 S @MDRET@("TERM_ID","E")=$$GET1^DIQ(704.117,MDIEN_",",".07:.02")
 D:$$GET1^DIQ(704.117,MDIEN_",",".07:.06","I")=3  ; Coded data values
 .S MDTMP=$$FIND1^DIC(704.101,"","PKX",@MDRET@("SVALUE","I"),"PK")
 .S @MDRET@("SVALUE","E")=$$GET1^DIQ(704.101,MDTMP_",",.02)
 D QRYQUAL(MDRET,MDIEN)
 D QRYCTX($NA(@MDRET@("CONTEXT")),MDID)
 Q
 ;
QRYQUAL(MDRET,MDIEN) ; Returns the qualifiers for obs in MDIEN
 N MDQUAL
 F Y=0:0 S Y=$O(^MDC(704.118,"PK",MDIEN,Y)) Q:'Y  D
 .S MDQUAL=$$GET1^DIQ(704.101,Y_",",".05:.02")
 .S @MDRET@(MDQUAL,"I")=$$GET1^DIQ(704.101,Y_",","99.99")
 .S @MDRET@(MDQUAL,"E")=$$GET1^DIQ(704.101,Y_",",".02")
 Q
 ;
QRYCTX(MDRET,MDID) ; We need a terminology based context observation relationship here
 N MDIEN,MDCTX,MDDT,MDFROM,MDTO,MDDFN,MDTERM,MDCNT,MDXID
 S MDIEN=+$$FIND1^DIC(704.117,"","PKX",MDID,"PK") Q:MDIEN<1
 S MDCTX=$$GET1^DIQ(704.117,MDIEN_",",.07) ; GET THE PRIMARY TERM (GUID)
 ; FILTER OUT EVERYTHING BUT SpO2 for now
 Q:MDCTX'="{5F84DD55-3CCF-094C-2536-B51EB7FAD999}"
 S MDDFN=+$$GET1^DIQ(704.117,MDIEN_",",.08,"I") ; GET THE PATIENT
 S MDDT=+$$GET1^DIQ(704.117,MDIEN_",",.05,"I") ; GET THE OBS DATE
 S MDFROM=$$FMADD^XLFDT(MDDT,0,0,0,-30) ; PREVIOUS 30 SECONDS
 S MDTO=$$FMADD^XLFDT(MDDT,0,0,0,30) ; NEXT 30 SECONDS
 ; Now we find the context observations
 F MDDT=MDFROM:0 S MDDT=$O(^MDC(704.117,"PT",MDDFN,MDDT)) Q:'MDDT!(MDDT>MDTO)  D
 .F MDOBS=0:0 S MDOBS=$O(^MDC(704.117,"PT",MDDFN,MDDT,MDOBS)) Q:'MDOBS  D
 ..Q:$$GET1^DIQ(704.117,MDOBS_",",.09,"I")'=1  ; Verfied Only
 ..S MDXID=$$GET1^DIQ(704.117,MDOBS_",",.01)
 ..Q:MDXID=MDID  ; You should ignore yourself in this loop
 ..S MDTERM=$$GET1^DIQ(704.117,MDOBS_",",".07")
 ..; INSERT FILTER CODE FOR O2 Flowrate and Concentration here - In the future we will find all context terms for an observation in terminology
 ..Q:(MDTERM'="{56F82CAC-3564-46CE-A520-1025020DADE9}")&(MDTERM'="{3BB314E8-9BBB-480E-B34E-B56EDE43BAC4}")
 ..S MDCNT=$O(@MDRET@(""),-1)+1,@MDRET@(0)=MDCNT
 ..S @MDRET@(MDCNT,"OBS_ID","I")=MDXID
 ..S @MDRET@(MDCNT,"OBS_ID","E")=MDXID
 ..S @MDRET@(MDCNT,"TERM_ID","I")=$$GET1^DIQ(704.117,MDOBS_",",".07:99.99")
 ..S @MDRET@(MDCNT,"TERM_ID","E")=$$GET1^DIQ(704.117,MDOBS_",",".07:.02")
 ..S @MDRET@(MDCNT,"SVALUE","I")=$$GET1^DIQ(704.117,MDOBS_",",".1","I")
 ..S @MDRET@(MDCNT,"SVALUE","E")=$$GET1^DIQ(704.117,MDOBS_",",".1","E")
 ..D QRYQUAL($NA(@MDRET@(MDCNT)),MDOBS)
 Q
GETOBS(MDPAR) ; Get list of observations by date
 S MDPT=MDPAR(0)
 S MDROOT=$NA(^TMP("MDCLIO",$J)) K @MDROOT
 S MDFR=$$FMDT^MDCLIO(MDPAR(1))-.0000001
 S MDTO=$$FMDT^MDCLIO(MDPAR(2))\1+.235959
 F  S MDFR=$O(^MDC(704.117,"PT",MDPT,MDFR)) Q:'MDFR!(MDFR>MDTO)  D
 .F Y=0:0 S Y=$O(^MDC(704.117,"PT",MDPT,MDFR,Y)) Q:'Y  S @MDROOT@(Y)=""
 Q
GETBYDT ; Get list of observations by date
 S MDPT=P2(0)
 S MDROOT=$NA(^TMP("MDCLIO",$J)) K @MDROOT
 S MDFR=$$FMDT^MDCLIO(P2(1))-.0000001
 S MDTO=$$FMDT^MDCLIO(P2(2))
 F  S MDFR=$O(^MDC(704.117,"PT",MDPT,MDFR)) Q:'MDFR!(MDFR>MDTO)  D
 .F Y=0:0 S Y=$O(^MDC(704.117,"PT",MDPT,MDFR,Y)) Q:'Y  S @MDROOT@(Y)=""
 Q
GETLOG ; Get list of date/time pairs with data
 S MDPT=P2(0),MDROOT=$NA(^TMP("MDCLIO",$J)) K @MDROOT
 S MDFR=$$FMDT^MDCLIO(P2(1))-.0000001
 S MDTO=$$FMDT^MDCLIO(P2(2))
 S MDSTAT=""
 F  S MDSTAT=$O(^MDC(704.117,"AS",MDSTAT))  Q:MDSTAT=""  D
 .S MDDT=MDFR
 .F  S MDDT=$O(^MDC(704.117,"AS",MDSTAT,MDPT,MDDT)) Q:'MDDT!(MDDT>MDTO)  D
 ..S @MDROOT@(MDSTAT,MDDT,$O(^MDC(704.117,"AS",MDSTAT,MDPT,MDDT,0)))=""
 Q
GETBYST ; Get list of observations by patient, status, and date range
 S MDPT=P2(0),MDSTAT=P2(3),MDROOT=$NA(^TMP("MDCLIO",$J)) K @MDROOT
 S MDFR=$$FMDT^MDCLIO(P2(1))-.0000001
 S MDTO=$$FMDT^MDCLIO(P2(2))
 F  S MDFR=$O(^MDC(704.117,"AS",MDSTAT,MDPT,MDFR)) Q:'MDFR!(MDFR>MDTO)  D
 .F Y=0:0 S Y=$O(^MDC(704.117,"AS",MDSTAT,MDPT,MDFR,Y)) Q:'Y  S @MDROOT@(Y)=""
 Q
AUDIT(Y) ; Looks up the audit records for an observation in external format
 S MDROOT=$NA(^MDC(704.119,"ALOG",+$O(^MDC(704.117,"PK",Y,0))))
 Q
QUAL ; Retrieves all qualifiers for an observation - MDIENS = iens of observation from MDCLIO
 N MDQUAL
 F MDQUAL=0:0 S MDQUAL=$O(^MDC(704.118,"PK",+MDIENS,MDQUAL)) Q:'MDQUAL  D
 .D XMLDATA^MDCLIO($$GET1^DIQ(704.101,MDQUAL_",",".05:.02","I"),$$GET1^DIQ(704.101,MDQUAL_",",".01","I"))
 Q
SETS ; Retrieve the sets this observation belongs to
 D XMLHDR^MDCLIO("SETS")
 N MDSET F MDSET=0:0 S MDSET=$O(^MDC(704.1161,"AS",+MDIENS,MDSET)) Q:'MDSET  D
 .F MDX=0:0 S MDX=$O(^MDC(704.1161,"AS",+MDIENS,MDSET,MDX)) Q:'MDX  D
 ..D XMLHDR^MDCLIO("SET")
 ..D XMLDATA^MDCLIO("VALUE",$$GET1^DIQ(704.1161,MDX_",",.01))
 ..D XMLFTR^MDCLIO("SET")
 D XMLFTR^MDCLIO("SETS")
 Q
GETQUAL ; Returns qualifiers of type P2(1) for term P2(0)
 ; Set Y to the IEN of the Term
 S X=$$FIND1^DIC(704.101,"","KX",P2(0))
 S MDROOT=$NA(^TMP("MDCLIO",$J)) K @MDROOT
 S MDGBL=$NA(^MDC(704.103,"PK",X))
 F  S MDGBL=$Q(@MDGBL) Q:MDGBL=""  Q:$QS(MDGBL,3)'=X  D
 .I $P(^MDC(704.101,$QS(MDGBL,5),0),U,5)=P2(1) D
 ..S @MDROOT@($QS(MDGBL,4),$QS(MDGBL,6))=""
 Q
PROCIEN(Y) ; Converts CP DEFINITION (procedure) name to IEN
 Q $$FIND1^DIC(702.01,,"KXP",Y)
INSTIEN(Y) ; Converts CP INSTRUMENT name to IEN
 Q $$FIND1^DIC(702.09,,"KXP",Y)
GETINST ; Gathers instruments for a procedure
 S X=$$PROCIEN(P2(0))
 F Y=0:0 S Y=$O(^MDS(702.01,+X,.1,"B",Y)) Q:'Y  S @MDROOT@(Y)=""
 Q
ADDINST ; Adds an instrument definition to a procedure
 ; This is a legacy multiple in file 702.01 so it has to be done in an odd way
 N MDPROC,MDINST
 S MDPROC=$$PROCIEN(P2(0))
 S MDINST=$$INSTIEN(P2(1))
 I '+MDPROC S @RESULTS@(0)="-1^Unable to find procedure "_P2(0)
 I '+MDINST S @RESULTS@(0)="-1^Unable to find instrument "_P2(1)
 S MDFDA(702.011,"+1,"_MDPROC_",",.01)=MDINST
 D UPDATE^DIE("","MDFDA")
 S @RESULTS@(0)="1^Instrument added."
 Q
DELINST ; Deletes all instruments from a procedure definition
 ; This is a legacy multiple in file 702.01 so it has to be done in an odd way
 N MDPROC
 S MDPROC=$$PROCIEN(P2(0))
 F X=0:0 S X=$O(^MDS(702.01,MDPROC,.1,X)) Q:'X  S MDFDA(702.011,X_","_MDPROC_",",.01)="@"
 D FILE^DIE("","MDFDA")
 S @RESULTS@(0)="1^Instrument list cleared."
 Q
GETVER ; Get Version Information
 D NEWDOC^MDCLIO("RESULTS","VERSION INFORMATION")
 I $G(P2(0))="" D GETLST^XPAR(.MDRET,"SYS","MD VERSION INFORMATION","Q")
 I $G(P2(0))]"" S MDRET(1)=P2(0)_"^"_$$GET^XPAR("SYS","MD VERSION INFORMATION",P2(0),"Q")
 ; Switch the lines below once we are really checking versions
 ;F MDRET=0:0 S MDRET=$O(MDRET(MDRET)) Q:'MDRET  D:$P(MDRET(MDRET),"^",2)]""
 F MDRET=0:0 S MDRET=$O(MDRET(MDRET)) Q:'MDRET  D
 .D XMLHDR^MDCLIO("RECORD")
 .S MDVER=$P(MDRET(MDRET),"^",1)
 .D XMLDATA^MDCLIO("VERSION",MDVER)
 .S MDVER=$P(MDRET(MDRET),"^",2)
 .; Switch the lines below once we are really checking versions
 .;D XMLDATA^MDCLIO("COMPATIBLE",+MDVER)
 .D XMLDATA^MDCLIO("COMPATIBLE",1)
 .D XMLDATA^MDCLIO("CRC32",$P(MDVER,";",2))
 .D XMLDATA^MDCLIO("PRODUCTION_RELEASE",+$P(MDVER,";",3))
 .D XMLDATA^MDCLIO("COMMENT",$P(MDVER,";",4))
 .D XMLFTR^MDCLIO("RECORD")
 D ENDDOC^MDCLIO("RESULTS")
 Q
GETVF ; Get View Filters
 N MDVIEW,MDTERM,MDIEN,MDXROOT
 S MDXROOT=$NA(^TMP("MDXQUERY",$J)) K @MDXROOT
 S MDVIEW=+$O(^MDC(704.111,"PK",P2(0),0))
 F MDTERM=0:0 S MDTERM=$O(^MDC(704.1112,"PK",MDVIEW,P2(1),MDTERM)) Q:'MDTERM  D
 .F MDIEN=0:0 S MDIEN=$O(^MDC(704.1112,"PK",MDVIEW,P2(1),MDTERM,MDIEN)) Q:'MDIEN  S @MDXROOT@(MDIEN)=MDIEN
 D XQUERY^MDCLIO
 Q
NEWNOTE ; Returns a new note ID
 D GETGUID(.MD)
 K ^TMP("MDNOTE",$J,MD)
 D QUICKDOC^MDCLIO("ID",MD)
 Q
CLRNOTE ; Clears any text in a temporary note P2(0)=Temporary ID
 K ^TMP("MDNOTE",$J,P2(0))
 S @RESULTS@(0)="1^Note Cleared"
 Q
ADDTEXT ; Adds P2(1..n) to the note in P2(0)
 F X=0:0 S X=$O(P2(X)) Q:'X  D
 .S Y=$O(^TMP("MDNOTE",$J,P2(0),""),-1)+1
 .S ^TMP("MDNOTE",$J,P2(0),Y,0)=P2(X)
 S @RESULTS@(0)=$O(P2(""),-1)_"^Lines added"
 Q
 ;
SENDMAIL ; Sends an EMail Message
 D SENDMAIL^MDCLIO
 ;
GETTIU ; Gets Privs for note title in P2(0)
 N MDRET
 D NEWDOC^MDCLIO("RESULTS","TIU PRIVS")
 D XMLHDR^MDCLIO("RECORD")
 D REQCOS^TIUSRVA(.MDRET,P2(0))
 D XMLDATA^MDCLIO("REQUIRE_COSIGN",MDRET)
 D GETDCOS^ORWTPN(.MDRET,DUZ)
 D:+MDRET
 .D XMLDATA^MDCLIO("DEF_COSIGN_ID",$P(MDRET,U,1))
 .D XMLDATA^MDCLIO("DEF_COSIGN_NAME",$P(MDRET,U,2))
 D XMLFTR^MDCLIO("RECORD")
 D ENDDOC^MDCLIO()
 Q
 ;
SIGNTIU ; Signs the note
 N MDNOW,MDESIG,MDNOTE,MDTEXT,MDVAU,MDRET
 D NOW^%DTC S MDNOW=%
 S MDESIG=$$DECRYP^XUSRB1(P2(4)),MDESIG=$$ENCRYP^XUSRB1(MDESIG)
 D MAKE^TIUSRVP(.MDNOTE,P2(1),P2(2),MDNOW,P2(3))
 I MDNOTE<1 S @RESULTS@(0)="-1^Unable to create note." Q
 S MDTEXT(2)=$NA(^TMP("MDNOTE",$J,P2(0)))
 ; Check for a co-signer
 I +$G(P2(5)) S MDTEXT(1506)=1,MDTEXT(1208)=+$G(P2(5))
 D UPDATE^TIUSRVP(.MDRET,+MDNOTE,.MDTEXT,1)
 I MDRET<1 S @RESULTS@(0)="-1^Unable to file note text." Q
 D SIGN^TIUSRVP(.MDRET,MDNOTE,MDESIG)
 K MDESIG
 I MDRET<0 S @RESULTS@(0)="-1^Unable to sign the note." Q
 S @RESULTS@(0)="1^Note signed and filed."
 Q
 ;
GETENT(X) ; Returns the entity path upward
 Q X_$P("USR^DIV^SYS",X,2)
 ;
OPENPAR ; Opens and verifies a parameter Entity
 D NOW^%DTC S %=%+.00000001
 S Y=($E(%,1,3)+1700)_"-"_$E(%,4,5)_"-"_$E(%,6,7)_" "_$E(%,9,10)_":"_$E(%,11,12)_":"_$E(%,13,14)
 D EN^XPAR("USR",P2(0),"Date/Time Last Accessed",Y,.MDERR)
 I 'MDERR S @RESULTS@(0)="1" E  S @RESULTS@(0)=MDERR
 Q
LSTPAR ; Returns all parameter Values as a Query
 ; GETLST^XPAR(.List,Entity,Parameter,Format,.Error)
 N MDLST,MDENT,MDNAME
 D NEWDOC^MDCLIO("RESULTS")
 D GETLST^XPAR(.MDRET,P2(0),P2(1),"Q",.MDERR)
 F Y=0:0 S Y=$O(MDRET(Y)) Q:'Y  S MDLST($P(MDRET(Y),U,1))=$P(MDRET(Y),U,2,250)
 K MDRET
 D:'MDERR
 .S MDNAME="" F  S MDNAME=$O(MDLST(MDNAME)) Q:MDNAME=""  D
 ..D XMLHDR^MDCLIO("RECORD")
 ..D XMLDATA^MDCLIO("NAME",MDNAME)
 ..D XMLDATA^MDCLIO("VALUE",MDLST(MDNAME))
 ..D XMLFTR^MDCLIO("RECORD")
 D ENDDOC^MDCLIO("RESULTS")
 Q
CLRPAR ; Clears all settings for an entity
 D NDEL^XPAR(P2(0),P2(1),.MDERR)
 I 'MDERR S @RESULTS@(0)=1 E  S @RESULTS@(0)=MDERR
 Q
SETPAR ; Sets a single parameter value
 N MDVALUE
 S MDVALUE=$G(P2(3),"@") S:MDVALUE="" MDVALUE="@"
 D STRIP^MDCLIO(MDVALUE)
 I MDVALUE="@" D  Q
 .D DEL^XPAR(P2(0),P2(1),P2(2),.MDERR)
 .S @RESULTS@(0)=1
 D EN^XPAR(P2(0),P2(1),P2(2),MDVALUE,.MDERR)
 S @RESULTS@(0)='MDERR
 Q
GETPAR ; Gets a single parameter value
 N MDVALUE
 D NEWDOC^MDCLIO("RESULTS")
 D XMLHDR^MDCLIO("RECORD")
 S MDVALUE=$$GET^XPAR(P2(0),P2(1),P2(2),"Q")
 D:MDVALUE]"" XMLDATA^MDCLIO("VALUE",MDVALUE)
 D XMLFTR^MDCLIO("RECORD")
 D ENDDOC^MDCLIO("RESULTS")
 Q
