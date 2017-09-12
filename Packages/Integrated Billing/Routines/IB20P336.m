IB20P336 ;OAK/ELZ - IB*2*336 POST INIT TO REPORT CLAIMS TRACKING PROBLEMS ;15-DEC-2005
 ;;2.0;INTEGRATED BILLING;**336**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; With the release of CIDC (IB*2*260), PSO added a new node for storage of SC/EI determinations.  However it turns
 ; out this new node is not always there.  If the node is there the data contained in that node is correct for SC/EI
 ; determination.  But if the node was not there IB needed to revert back to its original process for marking CT
 ; entries.  That reversion was not included in IB*2*260, but is included in this IB*2*336 patch.  This post init
 ; routine will look through CT entries for Pharmacy that were created after IB*2*260 was installed and evaluate
 ; those CT entries.  Since some sites spend time manually reviewing these entries the entries cannot be auto-
 ; matically marked and bills cannot be automatically cancelled.  So this post init routine will provide an e-mail
 ; report of CT entries that should be reviewed by the site.  Also as a note the PSO IBQ node is not a reliable
 ; node to look at for patients >49% SC, in fact should not ever be populated for these patients.  So if anyone
 ; does a comparison they are likely to find invalid data.  PSO stopped populating IBQ for >49% SC with the
 ; release of PSO*7*219.
 ; 
 ; 
POST ; post init entry point
 ;
 N IBIDT,IBX,IBSTOP,IBDATA,IBDPT,IBL,IBPNM,IBZ,XMDUZ,XMSUB,XMY,XMZ
 ;
 D BMES^XPDUTL("Starting Post Install to evaluate CT entries...")
 ;
 K ^TMP("IB20P336",$J)
 ;
 ; dbia #2197
 S IBIDT=$P($G(^XPD(9.7,+$O(^XPD(9.7,"B","IB*2.0*260",0)),1)),"^")
 I 'IBIDT D BMES^XPDUTL("Cannot find first install of IB*2*260!!!  LOG A REMEDY TICKET") Q
 ;
 ; start at end of CT file and work backwards to beginning
 S IBSTOP=0,IBX=":" F  S IBX=$O(^IBT(356,IBX),-1) Q:'IBX!(IBSTOP)  D
 . S IBZ=$G(^IBT(356,IBX,0))
 . Q:'$P(IBZ,"^",8)
 . ;
 . ; can i end?
 . S IBDT=+$G(^IBT(356,IBX,1)) I IBDT,IBDT<IBIDT S IBSTOP=1 Q
 . ;
 . ; entry has a RNB no need to check out
 . Q:$P(IBZ,"^",19)
 . ;
 . ; PSO has an ICD node so it was done right
 . Q:$D(^PSRX($P(IBZ,"^",8),"ICD"))
 . ;
 . ;determine RNB would have been had CIDC not been installed, if none quit
 . S IBRMARK=$$RNB($P(IBZ,"^",2),$P(IBZ,"^",6),$P(IBZ,"^",8),$G(^PSRX($P(IBZ,"^",8),0)))
 . I IBRMARK="" Q
 . ;
 . S IBDPT=$G(^DPT(+$P(IBZ,"^",2),0)) Q:'$L(IBDPT)
 . S IBDATA=$$TXT($P(IBDPT,"^"),15)_$$TXT($E($P(IBDPT,"^",9),6,9),4)
 . S IBDATA=IBDATA_$$TXT($$FMTE^XLFDT($P(IBZ,"^",6),"2DZ"),8)_$$TXT($P($G(^PSRX($P(IBZ,"^",8),0)),"^"),10)
 . S IBDATA=IBDATA_$$TXT($P($G(^DGCR(399,+$P(IBZ,"^",11),0)),"^"),10)_$$TXT(IBRMARK,14)
 . ;
 . ; get AR status
 . S:$P(IBZ,"^",11) IBDATA=IBDATA_$E($P($$STA^PRCAFN(+$P(IBZ,"^",11)),"^",2),1,4)
 . ; 
 . S ^TMP("IB20P336",$J,$P(IBDPT,"^"),IBX)=IBDATA
 ;
 D BMES^XPDUTL("Sending report message...")
 ;
 ; get message and send
RETRY ;
 S XMSUB="CLAIMS TRACKING PHARMACY IB*2*336"
 S XMDUZ="INTEGRATED BILLING PACKAGE"
 D XMZ^XMA2
 I XMZ<1 G RETRY
 ;
 ;set priority on message
 S DIE=3.9,DA=XMZ,DR="1.7////P" D ^DIE
 ;
 S ^XMB(3.9,XMZ,2,1,0)="With the install of the CIDC software (IB*2*260) some pharmacy related"
 S ^XMB(3.9,XMZ,2,2,0)="Claims Tracking (CT) entries may not have been assigned a Reason Not"
 S ^XMB(3.9,XMZ,2,3,0)="Billable (RNB).  Below is a list of CT entries that do not have a RNB"
 S ^XMB(3.9,XMZ,2,4,0)="with a RNB that should have been originally assigned to them.  Please"
 S ^XMB(3.9,XMZ,2,5,0)="review the list below and assign a RNB if appropriate."
 S ^XMB(3.9,XMZ,2,6,0)=" "
 S ^XMB(3.9,XMZ,2,7,0)="Name             SSN   Date      Rx#         Bill#       RNB             AR"
 S ^XMB(3.9,XMZ,2,8,0)="---------------  ----  --------  ----------  ----------  --------------  ----"
 S IBL=8
 S IBPNM="" F  S IBPNM=$O(^TMP("IB20P336",$J,IBPNM)) Q:IBPNM=""  S IBX=0 F  S IBX=$O(^TMP("IB20P336",$J,IBPNM,IBX)) Q:'IBX  D
 . S IBL=IBL+1
 . S ^XMB(3.9,XMZ,2,IBL,0)=^TMP("IB20P336",$J,IBPNM,IBX)
 I '$D(^TMP("IB20P336",$J)) S ^XMB(3.9,XMZ,2,IBL+1,0)="    <None Found>"
 S ^XMB(3.9,XMZ,2,0)="^3.92^"_IBL_"^"_IBL_"^"_DT
 ;
 S XMDUZ="INTEGRATED BILLING PACKAGE"
 S XMY(DUZ)="" ; Individual as a recipient
 F IBX="IB SUPERVISOR","IB CLAIMS SUPERVISOR" S IBZ=0 F  S IBZ=$O(^XUSEC(IBX,IBZ)) Q:'IBZ  S XMY(IBZ)=""
 ;
 D ENT1^XMD
 ;
 D BMES^XPDUTL("Message number "_XMZ_" sent...")
 ;
 K ^TMP("IB20P336",$J)
 ;
 D BMES^XPDUTL("Post Install Complete...")
 ;
 Q
 ;
 ;
RNB(DFN,IBDT,IBRXN,IBRXDATA) ; determines what the RNB would have been had the new ICD node not been checked
 ;
 N VAEL,IBRMARK,VA,IBPOWUNV,IBAUTRET
 ;
 D ELIG^VADPT
 ;if the patient is covered by insurance for pharmacy ($G(IBRMARK)="")
 ;AND if no copay in #350
 ;then we need to determine the non billable reason and set IBRMARK
 ;
 ;IF VAEL(3) -- if this is a veteran with SC(service connection) status
 I VAEL(3),'$G(^PSRX(IBRXN,"IB")) D
 . I $P(VAEL(3),"^",2)>49 S IBRMARK="NEEDS SC DETERMINATION"
 . ;in case of POW and Unempl. vet we cannot decide if the 3rd party should be exempt
 . S IBAUTRET=$$AUTOINFO^DGMTCOU1(DFN),IBPOWUNV=$S($P(IBAUTRET,U,8):1,$P(IBAUTRET,U,9):1,1:0)
 . I $P(VAEL(3),"^",2)<50 S IBRMARK=$S(IBPOWUNV:"NEEDS SC DETERMINATION",1:"SC TREATMENT")
 . I $$RXST^IBARXEU(DFN,$P(IBRXDATA,U,13))>0 S IBRMARK="NEEDS SC DETERMINATION"
 ;
 ;IF +VAEL(3)=0 if the veteran doesn't have SC status, but
 ;the veteran still may have CV status active
 I $G(IBRMARK)="",+VAEL(3)=0,'$G(^PSRX(IBRXN,"IB")) D
 . I $$CVEDT^IBACV(DFN,IBDT) S IBRMARK="NEEDS SC DETERMINATION" ;SC-because IB staff usually is using this reason to search for cases that need to be reviewed. COMBAT VETERAN reason will be used after review if this was the case
 ;
 ;
 Q $G(IBRMARK)
 ;
 ;
TXT(X,Y) ; make text Y characters long adding 2 spaces
 Q $$LJ^XLFSTR($E(X,1,Y),Y+2)
 ;
