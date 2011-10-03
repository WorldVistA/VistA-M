PSBVITFL ;BIRMINGHAM/TEJ - BCMA VITAL MEASUREMENT FILER ;8/31/10 11:03am
 ;;3.0;BAR CODE MED ADMIN;**31,42**;Mar 2004;Build 23
 ; Per VHA Directive 2004-038, this routine should not be modified.
 ; 
 ; Reference/IA
 ; STORE^GMRVPCE0/1589
 ; 44/908
 ; 42/10039
 ; 
 ;
 ; Description:
 ; This routine is to service BCMA 3.0 functionality and store VITALs'
 ; data into the VA's VITAL MEASUREMENT FILE - ^GMR(120.5 using the
 ; API GMRVPCE0 or can store VITALs' data into the IHS (Indian Health
 ; Services PCC V MEASUREMENT file.  Determination for which file is
 ; based on the Agency code DUZ("AG") equal "V" or "I" & the Vitals 
 ; package flag at IHS is set to 1 for PCC V file.
 ; 
 ; Parameters:
 ;       Input  -        DFN     (r) Pointer to the PATIENT (#2) file
 ;                       RATE    (r) BCMA trigger event/transaction
 ;                       VTYPE   (o) Pointer to GMRV VITAL TYPE FILE (#120.51)
 ;                                    (default = Pain ["PN"])
 ;                       DTTKN   (o) Date/time (FileMan) measurement was taken 
 ;                                    (default = $$NOW^XLFDT())
 ;                                    
 ;       Output -        RESULTS(0) = 1                                                                                             
 ;                       RESULTS(1) ="1^*** comment ***"                                                              
 ;                 or    RESULTS(1) ="-1^ERROR * Pain Score NOT filed 
 ;                                    successfully"
 ;
 ;       Process results in the storing of VITAL Measurement rate into the VITAL
 ;       MEASUREMENT FILE per the given patient and vital type.
 ;   
RPC(RESULTS,PSBDFN,PSBRATE,PSBVTYPE,PSBDTTKN) ;
 ;
 ; Set up the input array for the API
 ;
 ;PSB*3*31 Quit if patient has been discharged.
 K VADM,VAIN
 N DFN,VA S DFN=$G(PSBDFN),VAIP("D")=""
 D DEM^VADPT,IN5^VADPT
 S RESULTS(0)=1,RESULTS(1)="-1^ERROR * "_$S($G(PSBVTYPE)']""!($G(PSBVTYPE)="PN"):"Pain Score",1:"Vital Measurement")_" NOT filed successfully."
 I 'VAIP(13)&('VADM(6)) S RESULTS(1)=RESULTS(1)_"  Patient has been DISCHARGED." Q
 S:$G(PSBVTYPE)']"" PSBVTYPE="PN"
 S:$G(PSBDTTKN)']"" PSBDTTKN=$$NOW^XLFDT()
 S PSBHLOC=^DIC(42,+$G(VAIP(5)),44)
 ;
 ;Store Vitals info into either the VA Vitals package or the IHS PCC
 ; V measurement package, based on agency variable and Vitals package ; flag setting=1 for PCC V Measurement 
 ;
 N VTYP,PCC,XREF,VSIT,VDAT
 I $G(DUZ("AG"))="I",$$GET^XPAR("ALL","BEHOVM USE VMSR") D
 .S XREF("T")="TMP",XREF("P")="PU",XREF("BP")="BP",XREF("R")="RS",XREF("PN")="PA"
 .S VTYP=+$$FIND1^DIC(9999999.07,"","BX",$$UP^XLFSTR($G(XREF(PSBVTYPE))))
 .Q:'VTYP
 .S VSIT=$P($G(^DGPM(+$G(VAIP(13)),0)),U,27)
 .S VDAT=$P($G(^AUPNVSIT(+VSIT,0)),U)
 .S PCC(1)="HDR^^^"_PSBHLOC_";"_$S(VDAT:VDAT,1:PSBDTTKN)_";H;"_VSIT
 .S PCC(2)="VST^DT^"_$S(VDAT:VDAT,1:PSBDTTKN)
 .S PCC(3)="VST^PT^"_PSBDFN
 .S PCC(4)="VIT+^"_VTYP_"^0^^"_PSBRATE_"^^^"_PSBDTTKN
 .D SAVE^BEHOENPC(.RESULTS,.PCC)
 .S:'RESULTS RESULTS(1)="1^"_$S($G(PSBVTYPE)="PN":"Pain Score",1:PSBVTYPE)_" entered in Vitals via BCMA taken "_$$FMTE^XLFDT(PSBDTTKN,"Z5")
 E  D
 .S GMRVDAT("ENCOUNTER")=U_PSBDFN_U_$G(PSBHLOC)
 .S GMRVDAT("SOURCE")=U_$G(DUZ)
 .S GMRVDAT("VITALS",$G(DUZ),1)=PSBVTYPE_U_$G(PSBRATE)_U_$G(PSBUNTS)_U_PSBDTTKN
 .D STORE^GMRVPCE0(.GMRVDAT)
 .I '$D(GMRVDAT("ERROR")) D NOW^%DTC,YX^%DTC S RESULTS(0)=1,RESULTS(1)="1^"_$S($G(PSBVTYPE)="PN":"Pain Score",1:PSBVTYPE)_" entered in Vitals via BCMA taken "_Y
 Q
 ;
