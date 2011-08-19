AFJXTRF ;FO-OAKLAND/GMB-AFJXALRT (cont'd) ;2/13/01  14:59
 ;;5.1;Network Health Exchange;**17,18,23,26,31**;Jan 23, 1996
 ; Totally rewritten 11/2001.  (Previously AAA.)
SPL2TMP ; Transfer the lines from the spool document to the temp global
 ; Incoming: AXPID,AXTI,AXSPDOC,AXSPDATA,AXRQFROM
 D CHKDATA(AXSPDATA,.AXPID) Q:AXABORT
 N AXSPI,AXDREC
 S AXSPI=0
 S AXTI=AXTI+1,^TMP("AFJX",$J,AXTI,0)="-Patient ID verified on all data segments-"
 S AXTI=AXTI+1,^TMP("AFJX",$J,AXTI,0)=""
 F  D  Q:'AXSPI  ; Transfer one segment at a time
 . F  S AXSPI=$O(^XMBS(3.519,AXSPDATA,2,AXSPI)) Q:'AXSPI  S AXDREC=^(AXSPI,0) Q:$E(AXDREC,1,3)="---"!(AXDREC["*** DECEASED ***")
 . Q:'AXSPI
 . S AXTI=AXTI+1,^TMP("AFJX",$J,AXTI,0)=AXPID("INFO")
 . I AXDREC["(max 365 days) " S AXDREC=$P(AXDREC,"(max 365 days) ")_"(12 months) ---"_$P(AXDREC,"(max 365 days) ",2)
 . S AXTI=AXTI+1,^TMP("AFJX",$J,AXTI,0)=AXDREC
 . F  S AXSPI=$O(^XMBS(3.519,AXSPDATA,2,AXSPI)) Q:'AXSPI  S AXDREC=^(AXSPI,0) Q:$E(AXDREC,1,7)="*** END"  D
 . . S AXDREC=$G(^XMBS(3.519,AXSPDATA,2,AXSPI,0))
 . . Q:AXDREC["|TOP|"!(AXDREC["(continued)")
 . . S AXTI=AXTI+1,^TMP("AFJX",$J,AXTI,0)=AXDREC
 Q:'$P($G(^XMB(3.51,AXSPDOC,0)),U,11)
 S AXTI=AXTI+1,^TMP("AFJX",$J,AXTI,0)="*** Data is incomplete ***"
 Q
CHKDATA(AXSPDATA,AXPID) ; Patient ID Filter
 N AXSPI,AXBAD,AXDREC,I
 S AXSPI=0
 F  S AXSPI=$O(^XMBS(3.519,AXSPDATA,2,AXSPI)) Q:'AXSPI  S AXDREC=^(AXSPI,0) D
 . Q:AXDREC'["NHE EXTRACT SUMMARY"!(AXDREC["END ")
 . F I=1:1:5,0 Q:$L($G(^XMBS(3.519,AXSPDATA,2,AXSPI+I,0)))
 . Q:'I
 . S AXDREC=$G(^XMBS(3.519,AXSPDATA,2,AXSPI+I,0))
 . I '$$VALID(AXDREC,.AXPID) S AXBAD(AXDREC)="" ; Wrong Patient Data
 Q:'$D(AXBAD)
 D FAIL^AFJXALRT("Health Summary returned data for the wrong patient.  Please try again.")
 D BADMSG(.AXPID,.AXBAD)
 Q
VALID(AXDREC,AXPID) ; Make sure we've got the right patient.
 ; AXDREC         - Patient ID line from health summary.
 ; AXPID("NAME")  - Patient Name
 ; AXPID("S-S-N") - Patient SSN
 ; AXPID("DOB")   - Patient Date of Birth
 ; If AXDREC contains all three Patient ID's then AXFLD will equal zero.
 N AXFLD
 F AXFLD="NAME","S-S-N","DOB",0 Q:AXFLD=0  I $L($G(AXPID(AXFLD))),$L(AXDREC),AXDREC'[AXPID(AXFLD) Q
 Q AXFLD=0
BADMSG(AXPID,AXBAD) ; Send message if PatID Filter Blocked a Data Request.
 ; Make sure AFJX PATID FILTER BLOCK mail group exists and has members
 Q:'$$GOTLOCAL^XMXAPIG("AFJX PATID FILTER BLOCK")
 N I,AXTEXT,XMSUB,XMTEXT,XMY,XMZ,AXDREC
 S XMSUB="NHE PatID Filter Warning ("_AXPID("NAME")_")"
 S XMY("G.AFJX PATID FILTER BLOCK")=""
 S XMTEXT="AXTEXT("
 S AXTEXT(1)=$$REPEAT^XLFSTR("*",69)
 S AXTEXT(2)="NHE Data Request blocked by possible invalid Health Summary data."
 S AXTEXT(3)="Requested by: "_$G(AXRQFROM,"Unknown user")
 S AXTEXT(4)=$$REPEAT^XLFSTR("*",69)
 S AXTEXT(5)=""
 S AXTEXT(6)="Data Requested on Patient:"
 S AXTEXT(7)=AXPID("INFO")
 S AXTEXT(8)=""
 S AXTEXT(9)="Patients Returned by Health Summary:"
 S AXTEXT(10)=""
 S I=10
 S AXDREC=""
 F  S AXDREC=$O(AXBAD(AXDREC)) Q:AXDREC=""  S I=I+1,AXTEXT(I)=AXDREC
 D ^XMD
 Q
