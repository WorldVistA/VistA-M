GMRCYP68 ;SLC/NG - POST INSTALL FOR GMRC*3*68 ;7/09/2010
 ;;3.0;CONSULT/REQUEST TRACKING;**68**;DEC 27, 1997;Build 21
 Q
 ;
POST ; Start of Post-init for patch GMRC*3*68
 N GMRCTTL
 K ^TMP("GMRCYP68",$J)
 D BMES^XPDUTL("Starting Post-init...")
 D BMES^XPDUTL(" Searching for Consult Request which should be Inter-Facility")
 D MES^XPDUTL(" Consults, but are displaying as local Consults.")
 D MES^XPDUTL(" ")
 D SEARCH
 I GMRCTTL D MSG
 I 'GMRCTTL D BMES^XPDUTL(" No invalid entries found.")
 D BMES^XPDUTL("Post-init complete.")
 Q
 ;
SEARCH ; Search RELATED SERVICES (#2) field of the GMRC PROCEDURE (#123) file
 ;for invalid IFC services.
 N GMRCCPRS,GMRCSVC,GMRCSIEN,GMRCDT,X,GMRCSTS,GMRCDATE,GMRCINDT,GMRCPIFC
 N GMRCIFC1,GMRCIFC2,GMRCPRC,GMRCPRC1,GMRCPRC2,GMRCRFAC,GMRCSIEN0,I
 N GMRCIFC
 S (GMRCTTL,X)=0
 S (I,GMRCINDT,GMRCDATE,GMRCDT)=""
 S GMRCSTS=U
 F I="ACTIVE","PARTIAL RESULTS","PENDING","SCHEDULED"  D
 . S GMRCSTS=GMRCSTS_$O(^ORD(100.01,"B",I,""))_U
 S X=$$INSTALDT^XPDUTL("GMRC*3.0*22",.GMRCINDT)
 I +X>0 F  S GMRCDATE=$O(GMRCINDT(GMRCDATE)) Q:GMRCDATE=""  D  Q:GMRCDT'=""
 . I GMRCDATE<3020408 Q  ;Don't set date if not greater than release date
 . S GMRCDT=GMRCDATE
 I 'GMRCDT S GMRCDT="3020407.9999999999" ;Set date to release date if no install date
 F  S GMRCDT=$O(^GMR(123,"B",GMRCDT)) Q:GMRCDT=""  D
 . S GMRCSIEN=0
 . F  S GMRCSIEN=$O(^GMR(123,"B",GMRCDT,GMRCSIEN)) Q:GMRCSIEN=""  D
 .. S (GMRCIFC,GMRCIFC1,GMRCIFC2,GMRCPIFC,GMRCPRC,GMRCPRC1,GMRCPRC2)=""
 .. S GMRCSIEN0=$G(^GMR(123,GMRCSIEN,0))
 .. S GMRCCPRS=$P($G(GMRCSIEN0),U,12)
 .. I GMRCSTS'[GMRCCPRS Q  ;CPRS STATUS NOT ACTIVE, PENDING, SCHEDULED, OR PARTIAL RESULTS
 .. S GMRCCPRS=$P(^ORD(100.01,GMRCCPRS,0),U,1)
 .. S GMRCSVC=$P($G(GMRCSIEN0),U,5)
 .. S GMRCPRC=$P($G(GMRCSIEN0),U,8)
 .. I GMRCPRC'="" D
 ... S GMRCPRC1=$P($G(GMRCPRC),";",1),GMRCPRC2=$P($G(GMRCPRC),";",2)
 ... I $G(GMRCPRC2)="GMR(123.3,",+$G(GMRCPRC1)>0 D
 .... S GMRCPIFC=$G(^GMR(123.3,GMRCPRC1,"IFC"))
 .... S GMRCIFC1=+$P($G(GMRCPIFC),U,1),GMRCIFC2=$P($G(GMRCPIFC),U,2)
 .. I $G(GMRCIFC1)="",$G(GMRCIFC2)="",(($G(GMRCPRC)="")!($G(GMRCPRC2)'="GMR(123.3,")) D
 ... S GMRCIFC=$G(^GMR(123.5,+GMRCSVC,"IFC"))
 ... S GMRCIFC1=$P(GMRCIFC,U,1),GMRCIFC2=$P(GMRCIFC,U,2)
 .. I ('+GMRCIFC1)!(GMRCIFC2="") Q  ;IFC ROUTING SITE^IFC REMOTE NAME (NOT AN IFC)
 .. S GMRCRFAC=$P($G(GMRCSIEN0),U,23)
 .. I +GMRCRFAC Q  ;IF ROUTING FACILITY, NOT A PROBLEM ENTRY
 .. S GMRCSITE=$P($G(^DIC(4,GMRCIFC1,0)),U,1)
 .. S GMRCPIEN=$P($G(GMRCSIEN0),U,2)
 .. I +GMRCPIEN S GMRCNAME=$P($G(^DPT(GMRCPIEN,0)),U,1)_" ("_$E($P($G(^DPT(GMRCPIEN,0)),U,9),6,9)_")"
 .. E  S GMRCPIEN=0,GMRCNAME="UNKNOWN"
 .. ;I $P(GMRCPRC,";",2)="GMR(123.3," S GMRCPRC=$P(^GMR(123.3,$P(GMRCPRC,";",1),0),U,1)
 .. S ^TMP("GMRCYP68",$J,GMRCNAME,GMRCPIEN,GMRCDT,GMRCSIEN)=$S((($G(GMRCPRC2)="GMR(123.3,")&(+$G(GMRCPRC1)>0)):$P($G(^GMR(123.3,+GMRCPRC1,0)),U,1)_" (PROCEDURE)",1:$P($G(^GMR(123.5,+GMRCSVC,0)),U,1)_" (SERVICE)")_U_GMRCSITE_U_GMRCIFC2_U_GMRCCPRS
 .. S GMRCTTL=GMRCTTL+1
 ;D MES^XPDUTL(" ")
 D BMES^XPDUTL(" "_GMRCTTL_" Total Invalid IFC Consult Request Records Found.")
 Q
MSG ; Send Mailman message to installer
 N GMRCC,GMRCPARM,GMRCPRC,GMRCSVC,GMRCTXT,GMRCSIEN,GMRCNAME,GMRCSITE,GMRCIFC
 N GMRCPIEN,GMRCDT,GMRCDATE,GMRCSPS,GMRCIEN,GMRCMSG,GMRCSTS,GMRC0,GMRCCNT
 N XMDUZ,XMERR,XMSUB,XMTEXT,XMY,XMZ,Y
 I DUZ="" N DUZ S DUZ=.5 ; if user not defined set to postmaster
 S XMDUZ=DUZ,XMTEXT="GMRCTXT"
 S GMRCPARM("FROM")="PATCH GMRC*3.0*68 POST-INIT"
 S XMY(DUZ)="" ; send message to user
 S XMSUB="GMRC*3*68 - IFC CONSULTS NOT SENT"
 K GMRCTXT
 S GMRCC=0
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="This message has been sent by patch GMRC*3.0*68 at the completion of"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="the post-init routine."
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)=" "
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="This message was sent because Inter-Facility Consult records were found"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="which were not sent as Inter-Facility Consults and appear as local"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="Consults. These IFC Consults are listed in this Mailman message so the"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="proper action may be taken to correct the erroneous IFC Consult Request"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="Records. We have identified two different ways in which sites may correct"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="these incorrect IFC entries:"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)=" "
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  Option 1: After identifying and verifying the problem entry, forward the"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="            problem entry to a different consult service/procedure and then"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="            forward the entry back to the original service/procedure. This"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="            action will correct the problem and allow the consult to transmit"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="            properly to the consulting facility. If this option is used,"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="            it is suggested the forwarding to service be made aware of"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="            these pending actions and a standard message be devised to"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="            be included as a comment for the effected consult entries."
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)=" "
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  Option 2: After identifying and verifying the problem entry, contact"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="            the ordering provider to determine if the order is still"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="            needed. Have the provider Discontinue the order. If the"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="            order was no longer needed, then this is all that is needed."
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="            If the order is needed, then the provider should re-order"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="            it. Sites may want to create a standardized message for the"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="            discontinued orders and new orders if appropriate."
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)=" "
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="  Submit a Remedy ticket if you need additional instructions or help."
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)=" "
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="The following information is provided to assist you in your cleanup efforts."
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)=" "
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="PATIENT NAME (L4 SSN)"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="   DATE                    IEN NUMBER       STATUS"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="      CONSULT REQUEST (SERVICE/PROCEDURE)"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="         IFC ROUTING SITE"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="         IFC REMOTE NAME"
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="=============================================================================="
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)=" "
 S GMRCCNT=0
 S GMRCSPS=" "
 S GMRCNAME=""
 F  S GMRCNAME=$O(^TMP("GMRCYP68",$J,GMRCNAME)) Q:GMRCNAME=""  D
 . S GMRCPIEN=""
 . F  S GMRCPIEN=$O(^TMP("GMRCYP68",$J,GMRCNAME,GMRCPIEN)) Q:GMRCPIEN=""  D
 .. S GMRCC=GMRCC+1,GMRCTXT(GMRCC)=GMRCNAME
 .. S GMRCDT=""
 .. F  S GMRCDT=$O(^TMP("GMRCYP68",$J,GMRCNAME,GMRCPIEN,GMRCDT)) Q:GMRCDT=""  D
 ... S GMRCSIEN=""
 ... F  S GMRCSIEN=$O(^TMP("GMRCYP68",$J,GMRCNAME,GMRCPIEN,GMRCDT,GMRCSIEN)) Q:GMRCSIEN=""  D
 .... S GMRC0=$G(^TMP("GMRCYP68",$J,GMRCNAME,GMRCPIEN,GMRCDT,GMRCSIEN))
 .... S Y=GMRCDT D DD^%DT
 .... S GMRCDATE=$E(Y_"                        ",1,24)
 .... S GMRCSVC=$P(GMRC0,U,1)
 .... S GMRCSITE=$P(GMRC0,U,2)
 .... S GMRCIFC=$P(GMRC0,U,3)
 .... S GMRCIEN=$E(GMRCSIEN_"               ",1,17)
 .... S GMRCSTS=$P(GMRC0,U,4)
 .... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="   "_GMRCDATE_GMRCIEN_GMRCSTS
 .... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="      "_GMRCSVC
 .... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="         "_GMRCSITE
 .... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="         "_GMRCIFC
 .... S GMRCC=GMRCC+1,GMRCTXT(GMRCC)=" "
 .... S GMRCCNT=GMRCCNT+1
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)=" "
 S GMRCC=GMRCC+1,GMRCTXT(GMRCC)="Total Invalid IFC Consult Request Records Found: "_GMRCCNT
 D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY,.GMRCPARM,.XMZ,"")
 I '$D(XMERR) D BMES^XPDUTL("Message #"_XMZ_" has been sent")
 I $D(XMERR) D 
 . S GMRCMSG(1)=" "
 . S GMRCMSG(2)="******************************************************************************"
 . S GMRCMSG(3)="** Message containing IFC Consult records which were not **"
 . S GMRCMSG(4)="** sent due "_$S($D(XMERR):"to an error in the message set up. **",1:"sent to the "_$S(DUZ=.5:"postmaster. Please forward this **",1:"user. Please forward this **"))
 . I $D(XMERR) S GMRCMSG(5)="** Dumping message to screen. **"
 . I '$D(XMERR) S GMRCMSG(5)="** message to the appropriate staff, which includes the clinical **"
 . I '$D(XMERR) S GMRCMSG(6)="** coordinator, for further action. **"
 . S GMRCMSG($S($D(XMERR):6,1:7))="******************************************************************************"
 . D BMES^XPDUTL(GMRCMSG)
 I $D(XMERR) D BMES^XPDUTL(" "),BMES^XPDUTL(.GMRCTXT)
 K ^TMP("GMRCYP68",$J)
 Q
