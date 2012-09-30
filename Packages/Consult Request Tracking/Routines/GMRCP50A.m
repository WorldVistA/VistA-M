GMRCP50A ;ISP/TDP - PRE INSTALL ROUTINE FOR GMRC*3*50 ; 11/15/2006
 ;;3.0;CONSULT/REQUEST TRACKING;**50**;DEC 27, 1997;Build 8
 Q
MSG ;Send Mailman message to installer
 N GMRC0,GMRCACT,GMRCADT,GMRCC,GMRCCIEN,GMRCCNT,GMRCCPRS,GMRCDFN,GMRCDT
 N GMRCFDT,GMRCID,GMRCIEN,GMRCIFC,GMRCMSG,GMRCPARM,GMRCPG,GMRCPRV,GMRCSPC
 N GMRCSVC,GMRCTPG,GMRCTXT,GMRCWHO,XMDUZ,XMERR,XMSUB,XMTEXT,XMY,Y
 S GMRCTTL=GMRCTTL-GMRCITL
 I DUZ="" N DUZ S DUZ=.5
 S XMDUZ=DUZ,XMTEXT="GMRCTXT"
 S GMRCPARM("FROM")="PATCH GMRC*3.0*50 PRE-INIT"
 S XMY(DUZ)=""
 S GMRCDFN=""
 F GMRCIFC="GMRCP50","GMRCP50 IFC" D
 . S GMRCPG=0
 . I GMRCIFC="GMRCP50" S GMRCTPG=GMRCTTL/500 I GMRCTPG#1 S GMRCTPG=$P(GMRCTPG,".")+1
 . I GMRCIFC="GMRCP50 IFC" S GMRCTPG=GMRCITL/500 I GMRCTPG#1 S GMRCTPG=$P(GMRCTPG,".")+1
 . F GMRCPG=1:1:GMRCTPG D
 .. K GMRCTXT
 .. S GMRCC=0
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="This message ("_GMRCPG_" of "_GMRCTPG_") has been sent by patch GMRC*3.0*50 at the"
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="completion of the pre-init routine."
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  "
 .. I GMRCIFC="GMRCP50" D
 ... S XMSUB="SIGNIFICANT FINDINGS VALUES ARE INVALID (MSG "_GMRCPG_" of "_GMRCTPG_")"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="This message was sent because Consult records were found which contained an"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="Ampersand as the Significant Finding.  Since these can not be corrected"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="automatically, this message was created to assist in a manual correction of"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="this data.  We are hopeful that the following data will contain enough"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="information to allow your site to make the corrections, or at least give you"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="the information needed to research the specific consult and determine what"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="the Significant Finding should have been.  It is important to understand the"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="comments from the Significant Finding are fine and the only problem"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="needing correction is the Significant Finding value itself (Yes/No/Unknown)."
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="Per guidance from HIMSS, it is preferable that an audit trail exist for this"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="fix.  A disclaimer should be added, if possible.  To correct the"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="Significant Finding, you can use the Action, Consult Tracking menu on the"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="Consults tab of CPRS GUI.  The person making this change will need the"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="appropriate update authority for the Consult Services involved.  It should"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="also be noted the significant finding will display as ""Unknown"" despite"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="the ampersand (""&"") stored in the data file."
 .. I GMRCIFC="GMRCP50 IFC" D
 ... S XMSUB="IFC SIGNIFICANT FINDINGS VALUES ARE INVALID (MSG "_GMRCPG_" of "_GMRCTPG_")"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="This message was sent because Inter-Facility Consult records were found"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="which contained an Ampersand as the Significant Finding.  Since these can"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="not be corrected by the requesting (sending) site, this message was created"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="to alert you of these entries.  The Consulting (receiving) site(s) will need"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="to correct these entries and should receive a similar message when they"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="install this patch.  You can use this list as a record of Inter-Facility"
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="Consults needing to be corrected by the Consulting (receiving) site(s)."
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  "
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="PATIENT IDENTIFIER"
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  CONSULT DATE(IEN)"
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  TO SERVICE                                                   STATUS"
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="    ACTIVITY            ACTIVITY DATE          RESPONSIBLE PERSON"
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="    ACTIVITY COMMENTS"
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="==============================================================================="
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  "
 .. S GMRCSPC="                                                            "
 .. S GMRCCNT=0
 .. F  S GMRCDFN=$O(^TMP(GMRCIFC,$J,GMRCDFN)) Q:GMRCDFN=""  D  Q:GMRCCNT>499
 ... S GMRCID=$S(NMFLG:GMRCDFN,1:$G(^TMP(GMRCIFC,$J,GMRCDFN,0)))
 ... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)=GMRCID
 ... S GMRCDT=0
 ... F  S GMRCDT=$O(^TMP(GMRCIFC,$J,GMRCDFN,GMRCDT)) Q:GMRCDT=""  D
 .... S GMRCIEN=0
 .... F  S GMRCIEN=$O(^TMP(GMRCIFC,$J,GMRCDFN,GMRCDT,GMRCIEN)) Q:GMRCIEN=""  D
 ..... S GMRCCIEN=0
 ..... S GMRC0=$G(^TMP(GMRCIFC,$J,GMRCDFN,GMRCDT,GMRCIEN,0))
 ..... ;S GMRCIEN=$P(GMRC0,U,1)
 ..... S Y=GMRCDT
 ..... D DD^%DT
 ..... I Y=-1 S Y="DATE ERROR"
 ..... S GMRCFDT=Y
 ..... S GMRCFDT=$E(GMRCFDT_" ("_GMRCIEN_")"_GMRCSPC,1,33)
 ..... S GMRCSVC=$E($P(GMRC0,U,2)_GMRCSPC,1,60)_" "
 ..... S GMRCCPRS=$E($P(GMRC0,U,3)_GMRCSPC,1,15)
 ..... S GMRCACT=$E($P(GMRC0,U,4)_GMRCSPC,1,20)
 ..... S GMRCADT=$P(GMRC0,U,5)
 ..... S Y=0
 ..... I GMRCADT S Y=GMRCADT D DD^%DT I Y=-1 S Y="DATE ERROR"
 ..... I 'GMRCADT S Y="ACTIVITY DATE UNK"
 ..... S GMRCADT=$E(Y_GMRCSPC,1,23)
 ..... S GMRCWHO=$E($P(GMRC0,U,6)_GMRCSPC,1,32)
 ..... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  "_GMRCFDT
 ..... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  "_GMRCSVC_GMRCCPRS
 ..... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="    "_GMRCACT_GMRCADT_GMRCWHO
 ..... F  S GMRCCIEN=$O(^TMP(GMRCIFC,$J,GMRCDFN,GMRCDT,GMRCIEN,GMRCCIEN)) Q:GMRCCIEN=""  D
 ...... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="    "_$G(^TMP(GMRCIFC,$J,GMRCDFN,GMRCDT,GMRCIEN,GMRCCIEN))
 ..... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  "
 ..... S GMRCCNT=GMRCCNT+1
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  "
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  "
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="Total records in this message: "_GMRCCNT
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="Total records containing a Significant Finding of an ampersand: "_$S(GMRCIFC="GMRCP50":GMRCTTL,1:GMRCITL)
 .. D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY,.GMRCPARM,"","")
 .. S GMRCMSG(1)=" "
 .. S GMRCMSG(2)="******************************************************************************"
 .. I GMRCIFC="GMRCP50" D
 ... S GMRCMSG(3)="** Message ("_$S($L(GMRCPG)=1:$J("0"_GMRCPG,2),1:GMRCPG)_" of "_$S($L(GMRCTPG)=1:$J("0"_GMRCTPG,2),1:GMRCTPG)_") containing Consult records which have an ampersand as **"
 ... S GMRCMSG(4)="** the Significant Finding was "_$S($D(XMERR):"not sent due to an error in the message      **",1:"sent to the "_$S(DUZ=.5:"postmaster.  Please forward this **",1:"user.  Please forward this       **"))
 ... I $D(XMERR) S GMRCMSG(5)="** setup.                                                                   **"
 ... I $D(XMERR) S GMRCMSG(6)="** Dumping message to screen.                                               **"
 ... I '$D(XMERR) S GMRCMSG(5)="** message to the appropriate staff, which includes the clinical            **"
 ... I '$D(XMERR) S GMRCMSG(6)="** coordinator, for further action.                                         **"
 .. I GMRCIFC="GMRCP50 IFC" D
 ... S GMRCMSG(3)="** Message ("_$S($L(GMRCPG)=1:$J("0"_GMRCPG,2),1:GMRCPG)_" of "_$S($L(GMRCTPG)=1:$J("0"_GMRCTPG,2),1:GMRCTPG)_") containing Inter-Facility Consult records which have  **"
 ... S GMRCMSG(4)="** an ampersand as the Significant Finding was "_$S($D(XMERR):"not sent due to an error in  **",1:"sent to the "_$S(DUZ=.5:"postmaster.      **",1:"user.            **"))
 ... I $D(XMERR) S GMRCMSG(5)="** the message setup.                                                       **"
 ... I $D(XMERR) S GMRCMSG(6)="** Dumping message to screen.                                               **"
 ... I '$D(XMERR) S GMRCMSG(5)="** Please forward this message to the appropriate staff, which includes the **"
 ... I '$D(XMERR) S GMRCMSG(6)="** clinical coordinator, for further action.                                **"
 .. S GMRCMSG(7)="******************************************************************************"
 .. D BMES^XPDUTL(.GMRCMSG)
 .. I $D(XMERR) D BMES^XPDUTL("  "),BMES^XPDUTL(.GMRCTXT)
 . K ^TMP(GMRCIFC,$J)
 Q
