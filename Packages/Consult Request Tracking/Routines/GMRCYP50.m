GMRCYP50 ;ISP/TDP - POST INSTALL FOR GMRC*3*50 ; 5/2/2006
 ;;3.0;CONSULT/REQUEST TRACKING;**50**;DEC 27, 1997;Build 8
 Q
 ;
POST ; Start of Pre-init for patch GMRC*3*50
 N GMRCTTL
 K ^TMP("GMRCYP50",$J)
 D BMES^XPDUTL("Starting Post-init...")
 D BMES^XPDUTL("   Searching for Procedure Consults which have an Inter-Facility")
 D MES^XPDUTL("   Consult as a Related Service.")
 D MES^XPDUTL(" ")
 D SEARCH
 I GMRCTTL D MSG
 I 'GMRCTTL D BMES^XPDUTL("      No invalid entries found.")
 D BMES^XPDUTL("Post-init complete.")
 Q
 ;
SEARCH ; Search RELATED SERVICES (#2) field of the GMRC PROCEDURE (#123.3) file
 ; for invalid IFC services.
 N GMRCMSG,GMRCMSG1,GMRCPIEN,GMRCPRC,GMRCSIEN,GMRCSVC,X,XX,Y
 S (GMRCPRC,GMRCTTL)=0
 F  S GMRCPRC=$O(^GMR(123.3,"B",GMRCPRC)) Q:GMRCPRC=""  D
 . S GMRCPIEN=""
 . F  S GMRCPIEN=$O(^GMR(123.3,"B",GMRCPRC,GMRCPIEN)) Q:GMRCPIEN=""  D
 .. S GMRCSIEN=0
 .. F  S GMRCSIEN=$O(^GMR(123.3,GMRCPIEN,2,"B",GMRCSIEN)) Q:GMRCSIEN=""  D
 ... I '+$G(^GMR(123.5,+GMRCSIEN,"IFC")),'+$O(^GMR(123.5,+GMRCSIEN,"IFCS",0)) Q
 ... S GMRCSVC=$P($G(^GMR(123.5,GMRCSIEN,0)),U,1)
 ... I GMRCSVC="" S GMRCSVC="SERVICE UNKNOWN"
 ... S ^TMP("GMRCYP50",$J,GMRCPRC_" (#"_GMRCPIEN_")",GMRCSVC_" (#"_GMRCSIEN_")")=""
 ... K GMRCMSG
 ... S GMRCMSG="Related Service, "_GMRCSVC_" (IEN #"_GMRCSIEN_"), associated with Consult Procedure, "_GMRCPRC_" (IEN #"_GMRCPIEN_"), is an Inter-Facility Consult Service and must be removed or replaced with a service which is not an IFC!"
 ... S Y=0
 ... F X=1:1 S GMRCMSG1=$E(GMRCMSG,Y,Y+61) D  Q:Y'<$L(GMRCMSG)
 .... I $L(GMRCMSG1)<61 S Y=Y+61,GMRCMSG(X)=GMRCMSG1 Q
 .... F XX=61:-1:1 D  Q:$D(GMRCMSG(X))
 ..... I $E(GMRCMSG1,XX)'=" " Q
 ..... S Y=Y+1+XX I X>1 S Y=Y-1
 ..... S GMRCMSG(X)=$E(GMRCMSG1,1,XX)
 ... S X=""
 ... F  S X=$O(GMRCMSG(X)) Q:X=""  W !,"      "_$G(GMRCMSG(X))
 ... W !
 ... S GMRCTTL=GMRCTTL+1
 ;D MES^XPDUTL(" ")
 D BMES^XPDUTL("   "_GMRCTTL_" total invalid Related Services.")
 Q
 ;
MSG ; Send Mailman message to installer
 N GMRCC,GMRCCNT,GMRCPARM,GMRCPRC,GMRCSVC,GMRCTXT,GMRCWHO
 N XMDUZ,XMERR,XMSUB,XMTEXT,XMY,Y
 S XMSUB="RELATED SERVICES ARE INVALID"
 I DUZ="" N DUZ S DUZ=.5 ; if user not defined set to postmaster
 S XMDUZ=DUZ,XMTEXT="GMRCTXT"
 S GMRCPARM("FROM")="PATCH GMRC*3.0*50 POST-INIT"
 S XMY(DUZ)="" ; send message to user
 S GMRCC=0
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="This message has been sent by patch GMRC*3.0*50 at the completion of"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="the post-init routine."
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  "
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="This message was sent because Consult Procedure records were found which"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="contained one or more Related Services which are setup as Inter-Facility"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="Consults.  These related services should be removed and replaced with"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="non-IFC services to prevent possible problems in the Consult/Request"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="Tracking package.  The following information is provided to assist you"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="in your cleanup efforts."
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  "
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="PROCEDURE"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="     RELATED SERVICE"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="==========================================================================="
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  "
 S GMRCCNT=0,GMRCPRC=""
 F  S GMRCPRC=$O(^TMP("GMRCYP50",$J,GMRCPRC)) Q:GMRCPRC=""  D
 . S GMRCC=GMRCC+1,GMRCTXT(GMRCC)=GMRCPRC
 . S GMRCSVC=""
 . F  S GMRCSVC=$O(^TMP("GMRCYP50",$J,GMRCPRC,GMRCSVC)) Q:GMRCSVC=""  D
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="    "_GMRCSVC
 .. S GMRCCNT=GMRCCNT+1
 . S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  "
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  "
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  "
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="Total invalid Related Services: "_GMRCCNT
 D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY,.GMRCPARM,"","")
 S GMRCMSG(1)=" "
 S GMRCMSG(2)="******************************************************************************"
 S GMRCMSG(3)="** Message containing Procedure Consult records which have invalid          **"
 S GMRCMSG(4)="** Related Services was "_$S($D(XMERR):"not sent due to an error in the message set up.       **",1:"sent to the "_$S(DUZ=.5:"postmaster.  Please forward this         **",1:"user.  Please forward this              **"))
 I $D(XMERR) S GMRCMSG(5)="** Dumping message to screen.                                               **"
 I '$D(XMERR) S GMRCMSG(5)="** message to the appropriate staff, which includes the clinical            **"
 I '$D(XMERR) S GMRCMSG(6)="** coordinator, for further action.                                         **"
 S GMRCMSG($S($D(XMERR):6,1:7))="******************************************************************************"
 D BMES^XPDUTL(.GMRCMSG)
 I $D(XMERR) D BMES^XPDUTL("  "),BMES^XPDUTL(.GMRCTXT)
 K ^TMP("GMRCYP50",$J)
 Q
