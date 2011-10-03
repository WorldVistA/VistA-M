IBTRKR41 ;ALB/AAS - CLAIMS TRACKING - ADD/TRACK OUTPATIENT ENCOUNTERS ;13-AUG-93
 ;;2.0;INTEGRATED BILLING;**43,55,91,132,174,247,260,315,292,312,339,399**;21-MAR-94;Build 8
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
OPCHK ; -- check and add rx
 N Y,Y0,IBSERV,IBAPPT
 N IBSWINFO S IBSWINFO=$$SWSTAT^IBBAPI()                   ;IB*2.0*312
 ; IBDT is set from IBTRKR4
 ; Do NOT PROCESS on VistA if IBDT>=Switch Eff Date        ;CCR-930
 I +IBSWINFO,(IBDT+1)>$P(IBSWINFO,"^",2) Q                 ;IB*2.0*312
 ;
 K IBRMARK
 I '$D(ZTQUEUED),($G(IBTALK)) W "."
 ;
 S IBOEDATA=$$SCE^IBSDU(IBOE),IBOESTAT=$P(IBOEDATA,"^",15)
 S IBSERV=$S(+$P($G(^DIC(40.7,+$P(IBOEDATA,"^",3),0)),"^",2)=180:"DENTAL",1:"OUTPATIENT")
 S IBAPPT=$P($G(^SD(409.1,+$P(IBOEDATA,"^",10),0)),"^",1)
 S DFN=$P(IBOEDATA,"^",2)
 I 'DFN G OPCHKQ
 I $P(IBOEDATA,"^",5) S IBVSIT=$P(IBOEDATA,"^",5) I '$$BDSRC^IBEFUNC3(IBVSIT) G OPCHKQ ;non-billable data sources
 ; -- do not allow date/time duplicate claims before Jan. 1, 2006
 I $O(^IBT(356,"APTY",DFN,IBOETYP,IBDT,0)),IBDT<3060101 G OPCHKQ
 ;
 ; -- see if tracking only insured and pt is insured/insured for outpt visits
 I $P(IBTRKR,"^",3)=1,'$$INSURED^IBCNS1(DFN,IBDT) G OPCHKQ ; patient not insured
 ;
 I '$$PTFTF^IBCNSU31(DFN,IBDT) S IBRMARK="FILING TIMEFRAME NOT MET"
 ;
 ; -- see if outpatient services are covered
 I '$$PTCOV^IBCNSU3(DFN,IBDT,IBSERV,.IBANY) S IBRMARK=$S($G(IBANY)&(IBSERV="DENTAL"):"NO DENTAL COVERAGE",$G(IBANY):"NO OUTPATIENT COVERAGE",1:"NOT INSURED")
 ;
 ; -- see if appointment type is billable
 I '$$RPT^IBEFUNC($P(IBOEDATA,"^",10),+IBOEDATA) S IBRMARK=$S(IBAPPT="RESEARCH":"RESEARCH VISIT",1:"NON-BILLABLE APPOINTMENT TYPE")
 ;
 ; -- check sc status, special conditions etc.
 I $G(IBRMARK)="" S IBRMARK=$$CL(IBOEDATA)
 ;
 ; -- check for non-billable stops or clinic
 S X=$P(IBOEDATA,"^",4) I X,$$NBCT^IBEFUNC(X,+IBOEDATA) S IBRMARK="NON-BILLABLE CLINIC"
 S X=$P(IBOEDATA,"^",3) I X,$$NBST^IBEFUNC(X,+IBOEDATA) S IBRMARK="NON-BILLABLE STOP CODE"
 ;
 ; -- ok to add to tracking module
 D OPT^IBTUTL1(DFN,IBOETYP,IBDT,IBOE,IBRMARK,$G(IBVSIT)) I '$D(ZTQUEUED),$G(IBTALK) W "+"
 I IBRMARK'="" S IBCNT2=IBCNT2+1
 I IBRMARK="" S IBCNT1=IBCNT1+1
OPCHKQ K IBANY,IBRMARK,VAEL,VA,IBOEDATA,IBVSIT,DFN,X,Y
 Q
 ;
BULL ; -- send bulletin
 ;
 S XMSUB="Outpatient Encounters added to Claims Tracking Complete"
 S IBT(1)="The process to automatically add Opt Encounters has successfully completed."
 S IBT(1.1)=""
 S IBT(2)="              Start Date: "_$$DAT1^IBOUTL(IBTSBDT)
 S IBT(3)="                End Date: "_$$DAT1^IBOUTL(IBTSEDT)
 I $D(IBMESS) S IBT(3.1)=IBMESS
 S IBT(4)=""
 S IBT(5)="            Total Encounters Checked: "_$G(IBCNT)
 S IBT(6)="              Total Encounters Added: "_$G(IBCNT1)
 S IBT(7)=" Total Non-billable Encounters Added: "_$G(IBCNT2)
 S IBT(8)=""
 S IBT(9)="*The SC, Agent Orange, Southwest Asia, Ionizing Radiation,"
 S IBT(10)="Military Sexual Trauma, Head Neck Cancer, Combat Veteran and Project 112/SHAD"
 S IBT(11)="status visits have been added for insured patients but automatically"
 S IBT(12)="indicated as not billable."
 D SEND^IBTRKR31
BULLQ Q
 ;
CL(IBOEDATA,IBR) ; check out classification questions for encounter
 ; this new check will look at the V POV level then to the Visit level
 ; as necessary to determine if it relates or not.  This will indicate
 ; if the WHOLE visit is not billable, otherwise it will say it is
 ; (even if just part is billable).
 ; call with the zero node of 409.68 in IBOEDATA
 ; assumes DFN and IBDT defined
 ; pass in IBR by ref to get values back
 ;
 N IBRMARK,IBPCEX,IBCPT,IBARR,IBP,IBDX,IBVRNB,IBENCL
 S IBRMARK="",IBPCEX=$P(IBOEDATA,"^",5)
 ;
 ; look up classification info needed (if any)
 D CL^SDCO21(DFN,IBDT,"",.IBARR) I '$D(IBARR) G CLQ
 ;
 ; if no PCE event use old approach
 I 'IBPCEX D:$G(IBOE)  G CLQ
 . S IBENCL=$$ENCL^IBAMTS2(IBOE) I IBENCL["1" D  ; return 1 in string if true "ao^ir^sc^swa^mst^hnc^cv^shad"
 . I $P(IBENCL,"^",3) S IBRMARK="SC TREATMENT" Q
 . I $P(IBENCL,"^",1) S IBRMARK="AGENT ORANGE" Q
 . I $P(IBENCL,"^",2) S IBRMARK="IONIZING RADIATION" Q
 . I $P(IBENCL,"^",4) S IBRMARK="SOUTHWEST ASIA" Q
 . I $P(IBENCL,"^",5) S IBRMARK="MILITARY SEXUAL TRAUMA" Q
 . I $P(IBENCL,"^",6) S IBRMARK="HEAD/NECK CANCER" Q
 . I $P(IBENCL,"^",7) S IBRMARK="COMBAT VETERAN" Q
 . I $P(IBENCL,"^",8) S IBRMARK="PROJECT 112/SHAD" Q
 ;
 ; look up PCE info
 D ENCEVENT^PXKENC(IBPCEX)
 ;
 S IBVRNB=$$RNB($G(^TMP("PXKENC",$J,IBPCEX,"VST",IBPCEX,800)),.IBARR)
 ;
 ; find dx rnb's
 S IBDX=0 F  S IBDX=$O(^TMP("PXKENC",$J,IBPCEX,"POV",IBDX)) Q:'IBDX  S IBDX(+$G(^TMP("PXKENC",$J,IBPCEX,"POV",IBDX,0)))=$$RNB($G(^TMP("PXKENC",$J,IBPCEX,"POV",IBDX,800)),.IBARR)
 ;
 ; look for v cpt's with IBDX
 S IBCPT=0 F  S IBCPT=$O(^TMP("PXKENC",$J,IBPCEX,"CPT",IBCPT)) Q:'IBCPT  F IBP=5,9,10,11 Q:'$D(^TMP("PXKENC",$J,IBPCEX,"CPT",IBCPT,0))  D
 . ;
 . ; dx exists in v cpt but not v pov use visit level determination
 . I $P(^TMP("PXKENC",$J,IBPCEX,"CPT",IBCPT,0),"^",IBP),'$D(IBDX($P(^TMP("PXKENC",$J,IBPCEX,"CPT",IBCPT,0),"^",IBP))) D:IBVRNB REL(IBVRNB) Q
 . ;
 . ; use dx determination (where dx exists on v cpt)
 . I $P(^TMP("PXKENC",$J,IBPCEX,"CPT",IBCPT,0),"^",IBP) D:$G(IBDX($P(^TMP("PXKENC",$J,IBPCEX,"CPT",IBCPT,0),"^",IBP))) REL($G(IBDX($P(^TMP("PXKENC",$J,IBPCEX,"CPT",IBCPT,0),"^",IBP)))) Q
 ;
 ; check for no assoc dx and apply visit level determination
 S IBCPT=0 F  S IBCPT=$O(^TMP("PXKENC",$J,IBPCEX,"CPT",IBCPT)) Q:'IBCPT  D
 . S IBDX=0 F IBP=5,9,10,11 Q:IBDX  I +$P($G(^TMP("PXKENC",$J,IBPCEX,"CPT",IBCPT,0)),"^",IBP) S IBDX=1
 . I 'IBDX,IBVRNB D REL(IBVRNB)
 ;
 ; if some procedures left, then we need to bill, set return array
 I $D(^TMP("PXKENC",$J,IBPCEX,"CPT")) S IBRMARK="" M IBR=^TMP("PXKENC",$J,IBPCEX)
 ;
CLQ K ^TMP("PXKENC",$J)
 Q IBRMARK
 ;
RNB(IBDATA,IBARR) ; find rnb's
 ; pass in PCE 800 data (visit or v pov) to find any reasons not billalbe
 ; IBARR = classifications that could apply to patient
 ; the RNB number returned is from the IBARR number (SDCO21 array)
 N IBX,IBR S IBR=""
 S IBX=0 F  S IBX=$O(IBARR(IBX)) Q:'IBX!(IBR)  I $P(IBDATA,"^",$P($T(CLDATA+(IBX+1)),"^",2)) S IBR=IBX
 Q IBR
 ;
REL(IBRNB) ; kills of tmp if related and set IBRMARK
 K ^TMP("PXKENC",$J,IBPCEX,"CPT",IBCPT)
 S IBRMARK=$P($T(CLDATA+(IBRNB+1)),"^",3)
 Q
 ;
CLDATA ; classification data
 ; format is:  SCDO21 array^vpov/vcpt/visit 800 piece^reason not billable
 ;;1^2^AGENT ORANGE
 ;;2^3^IONIZING RADIATION
 ;;3^1^SC TREATMENT
 ;;4^4^SOUTHWEST ASIA
 ;;5^5^MILITARY SEXUAL TRAUMA
 ;;6^6^HEAD/NECK CANCER
 ;;7^7^COMBAT VETERAN
 ;;8^8^PROJECT 112/SHAD
 ;
