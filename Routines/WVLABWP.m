WVLABWP ;HCIOFO/FT-Display Report Data from Lab Package  ;4/6/99  14:02
 ;;1.0;WOMEN'S HEALTH;**6**;Sep 30, 1998
 ;
EN7901 ; Determine which report to show (i.e., Cytology or Surgical Pathology)
 ; Called from WVPROC
 D EX^WVRADWP ;kill any previous report text that might be leftover
 Q:'$G(DA)
 N LRDFN,LRSS,WVDATE,WVLABACC,WVNODE,WVNODE2
 S WVNODE=$G(^WV(790.1,+DA,0))
 Q:WVNODE=""
 S WVNODE2=$G(^WV(790.1,+DA,2))
 Q:WVNODE2=""
 S WVLABACC=$P(WVNODE2,U,17) ;lab accession number (e.g., CY 99 1)
 Q:WVLABACC=""
 S WVDATE=$P(WVNODE2,U,19) ;lab accession date (reverse date/time)
 Q:'WVDATE
 S LRDFN=$P(WVNODE2,U,18) ;lab patient ien
 Q:'LRDFN
 S LRSS=$P(WVNODE2,U,20) ;lab patient subscript
 Q:LRSS=""
 D HS
 Q
HS ; Health Summary variable setup
 N GMTS1,GMTS2,MAX
 S GMTS1=WVDATE-1,GMTS2=WVDATE+1,MAX=100
 I LRSS="CY" D CY ;cytology
 I LRSS="SP" D SP ;surgical pathology
 K ^TMP("LRA",$J),^TMP("LRCY",$J)
 Q
CY ; Call Health Summary extract routine GMTSLRPE to get cytology data.
 ; Input: LRDFN - FILE 63 ien
 ;        GMTS1 - reverse start date/time (most recent date)
 ;        GMTS2 - reverse end date/time   (least recent date)
 ;          MAX - maximum # of occurences to return
 ; Returns ^TMP("LRCY",$J)
 K ^TMP("LRCY",$J)
 I $T(XTRCT^GMTSLRPE)']"" Q  ;HS routine doesn't exist
 D XTRCT^GMTSLRPE
 Q:'$D(^TMP("LRCY",$J))
 D WEEDCY
 Q:'$D(^TMP("LRCY",$J))
 D ^WVLABWPC ;move data from HS array to WH array
 Q
WEEDCY ; Weed out reports, save only report for lab accession number
 ; associated with this WH entry.
 N WVLOOP
 S WVLOOP=0
 F  S WVLOOP=$O(^TMP("LRCY",$J,WVLOOP)) Q:'WVLOOP  D
 .I $P($G(^TMP("LRCY",$J,WVLOOP,0)),U,2)'=WVLABACC D
 ..K ^TMP("LRCY",$J,WVLOOP)
 ..Q
 .Q
 Q
SP ; Call Health Summary extract routine GMTSLRAE to get surgical
 ; pathology data.
 ; Input: LRDFN - FILE 63 ien
 ;        GMTS1 - reverse start date/time (most recent date)
 ;        GMTS2 - reverse end date/time   (least recent date)
 ;          MAX - maximum # of occurences to return
 ; Returns ^TMP("LRA",$J)
 K ^TMP("LRA",$J)
 I $T(XTRCT^GMTSLRAE)']"" Q  ;HS routine doesn't exist
 D XTRCT^GMTSLRAE
 Q:'$D(^TMP("LRA",$J))
 D WEEDSP
 Q:'$D(^TMP("LRA",$J))
 D ^WVLABWPS ;move data from HS array to WH array
 Q
WEEDSP ; Weed out reports, save only report for lab accession number
 ; associated with this WH entry.
 N WVLOOP
 S WVLOOP=0
 F  S WVLOOP=$O(^TMP("LRA",$J,WVLOOP)) Q:'WVLOOP  D
 .I $P($G(^TMP("LRA",$J,WVLOOP,0)),U,2)'=WVLABACC D
 ..K ^TMP("LRA",$J,WVLOOP)
 ..Q
 .Q
 Q
MAIL(DFN,WVLABAN,WVPROV,LRSS) ; Send mail message to case manager when
 ; lab test is added to WV LAB TESTS file (#790.08).
 ; Called from WVLRLINK
 ;      DFN -> Patient ien
 ;  WVLABAN -> Lab Accession# (e.g., CY 99 1)
 ;   WVPROV -> File 200   IEN (provider/requestor)
 ;     LRSS -> File 63 subscript (e.g., CY or SP)
 Q:'$G(DFN)!($G(WVLABAN)="")!($G(LRSS)="")
 N WVCMGR,WVLOOP,WVMSG,XMDUZ,XMSUB,XMTEXT
 S WVCMGR=+$$GET1^DIQ(790,DFN,.1,"I") ;get case manager
 S:WVCMGR XMY(WVCMGR)=""
 ; if no case manager, then get default case manager(s)
 I 'WVCMGR S WVLOOP=0 F  S WVLOOP=$O(^WV(790.02,WVLOOP)) Q:'WVLOOP  D
 .S WVCMGR=$$GET1^DIQ(790.02,WVLOOP,.02,"I")
 .S:WVCMGR XMY(WVCMGR)=""
 .Q
 Q:$O(XMY(0))'>0  ;no case manager(s)
 S XMDUZ=.5 ;message sender
 S XMSUB="Lab test released for a WH patient"
 S WVMSG(1)="A "_$S(LRSS="CY":"Cytology ",LRSS="SP":"Surgical Pathology ",1:"")_"lab test was verified for:"
 S WVMSG(2)=" "
 S WVMSG(3)="                Patient: "_$P($G(^DPT(DFN,0)),U,1)_" (SSN: "_$$SSN^WVUTL1(DFN)_")"
 S WVMSG(4)="        LAB Accession #: "_WVLABAN
 S WVMSG(5)="Test Requestor/Provider: "_$S(+WVPROV:$$GET1^DIQ(200,+WVPROV,.01,"E"),1:"UNKNOWN")
 S WVMSG(6)=" "
 S WVMSG(7)="Please use the 'Save Lab Test as Procedure' option in the WOMEN'S"
 S WVMSG(8)="HEALTH package to save this lab test data as a WH procedure or"
 S WVMSG(9)="remove it from the list of lab tests to address."
 S XMTEXT="WVMSG("
 D ^XMD
 Q
MOVE(WVDFN,WVNODE,WVNIEN) ; Send mail message when a lab accession is
 ; moved from one patient to another.
 ;  WVDFN -> DFN
 ; WVNODE -> zero node of File 790.1
 ; WVNIEN -> ien of File 790.4 entry (i.e., notification entry exists)
 N WVCMGR,WVLOOP,WVPN,WVMSG
 N XMDUZ,XMSUB,XMTEXT,XMY
 S WVCMGR=+$$GET1^DIQ(790,WVDFN,.1,"I") ;get case manager
 S:WVCMGR XMY(WVCMGR)=""
 ; if no case manager, then get default case manager(s)
 I 'WVCMGR S WVLOOP=0 F  S WVLOOP=$O(^WV(790.02,WVLOOP)) Q:'WVLOOP  D
 .S WVCMGR=$$GET1^DIQ(790.02,WVLOOP,.02,"I")
 .S:WVCMGR XMY(WVCMGR)=""
 .Q
 Q:$O(XMY(0))'>0  ;no case manager(s)
 S WVPN=$E($P(WVNODE,U,1),1,2),WVPN=$$PN^WVLRLINK(WVPN) ;procedure name
 S XMDUZ=.5 ;message sender
 S XMSUB="Lab Accession Patient Switch"
 ;
 S WVMSG(1)="The wrong patient was originally associated with a lab test. That lab test"
 S WVMSG(2)="was saved as a Women's Health procedure entry. Lab personnel have corrected"
 S WVMSG(3)="the lab test entry by associating the correct patient to that test."
 S WVMSG(4)="This message is to inform you that the following Women's Health procedure"
 S WVMSG(5)="is no longer associated with a lab test."
 S WVMSG(6)=" "
 S WVMSG(7)="        Patient: "_$P($G(^DPT(WVDFN,0)),U,1)_" (SSN: "_$$SSN^WVUTL1(WVDFN)_")"
 S WVMSG(8)=" WH Accession #: "_$P(WVNODE,U,1)_"  Procedure Type: "_$S(WVPN]"":WVPN,1:"Unknown")
 S WVMSG(9)=" "
 S WVMSG(10)="The RESULT/DIAGNOSIS value for this entry was changed to 'Error/disregard'."
 S WVMSG(11)="Please use the 'Edit a Procedure' option in the WOMEN'S HEALTH package to"
 S WVMSG(12)="review this procedure entry and make any necessary changes/notes."
 I WVNIEN D
 .S WVMSG(13)=" "
 .S WVMSG(14)="Also, a notification entry was created for this procedure. Please use the"
 .S WVMSG(15)="'Edit a Notification' option in the WOMEN'S HEALTH package to edit this"
 .S WVMSG(16)="notification entry."
 .Q
 S XMTEXT="WVMSG("
 D ^XMD
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
