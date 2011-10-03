GMVDCVAL ;HOIFO/DAD,FT-VITALS COMPONENT: VALIDATE DATA ;9/29/00  09:18
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #10035 - FILE 2 references        (supported)
 ; #10040 - FILE 44 references       (supported)
 ; #10060 - FILE 200 fields          (supported)
 ; #10104 - ^XLFSTR calls            (supported)
 ;
EN1(RESULT,GMVDATA) ;
 ; *** Validates vitals data ***
 N GMV,GMVD0,GMVID0,GMVIFIND,GMVIHOLD,GMVILAST,GMVINUM,GMVIXFRM
 N GMVMSG,GMVOK,GMVQARRY,GMVQD0,GMVQFIND,GMVQHOLD,GMVQNUM,GMVRD0
 N GMVRET,GMVRFIND,GMVRHOLD,GMVRNUM,GMVSYSBP,GMVVABBR,GMVVD0
 N GMVVFIND,GMVVHOLD,GMVVLAST,GMVVMEAS,GMVVNUM
 D EXIT
 F GMV=1:1 S GMVSYSBP=$P($T(BPSYSQ+GMV),";;",2) Q:GMVSYSBP=""  D
 . S GMVD0=0
 . F  S GMVD0=$O(^GMRD(120.52,"B",GMVSYSBP,GMVD0)) Q:GMVD0'>0  D
 .. I GMVSYSBP=$P($G(^GMRD(120.52,GMVD0,0)),U) S GMVSYSBP(GMVD0)=""
 .. Q
 . Q
 I $O(@GMVDATA@(""))]"" D
 . ; *** Vital measurement data validation ***
 . I ($O(@GMVDATA@("V",0))>0)!($O(@GMVDATA@("Q",0))>0) D VITMEA
 . ; *** Entered in Error data validation ***
 . I ($O(@GMVDATA@("I",0))>0)!($O(@GMVDATA@("R",0))>0) D ENTERR
 . Q
 E  D
 . D MSG("ERROR: No data to validate/save")
 . Q
 I $G(RESULT(0))="OK" D MSG("OK: Data validated")
 ;
EXIT ; *** Clean-up ***
 K ^TMP($J,"GMVXREF")
 Q
 ;
VITMEA ; *** Validate vital measurement data ***
 I $$FIND1^DIC(2,"","","`"_GMVDFN)'=GMVDFN D
 . D MSG("ERROR: Missing or invalid Patient parameter")
 . Q
 K GMVRET D DT^DILF("RSTX",GMVDTDUN,.GMVRET,"-NOW")
 I $G(GMVRET,-1)<0 D
 . D MSG("ERROR: Missing or invalid Date/Time Vitals Taken parameter")
 . Q
 I $$FIND1^DIC(44,"","","`"_GMVHOSPL)'=GMVHOSPL D
 . D MSG("ERROR: Missing or invalid Hospital Location parameter")
 . Q
 K GMVRET D DT^DILF("RSTX",GMVDTENT,.GMVRET,"-NOW")
 I $G(GMVRET,-1)<0 D
 . D MSG("ERROR: Missing or invalid Date/Time Vitals Entered parameter")
 . Q
 I $$FIND1^DIC(200,"","","`"_GMVENTBY)'=GMVENTBY D
 . D MSG("ERROR: Missing or invalid Entered By parameter")
 . Q
 I "^C^M^"'[(U_$G(GMVMSYS)_U) D
 . D MSG("ERROR: Missing or invalid Measurement System")
 . Q
 S (GMVVNUM,GMVVLAST,GMVVFIND)=0
 F  S GMVVNUM=$O(@GMVDATA@("V",GMVVNUM)) Q:GMVVNUM'>0  D
 . S GMVVLAST=GMVVNUM
 . S GMVSYSBP=0,GMVQARRY=U
 . S (GMV,GMVVHOLD)=$G(@GMVDATA@("V",GMVVNUM))
 . S GMVVD0=$$VITIEN^GMVDCUTL($P(GMV,U))
 . S (GMVVMEAS,GMVVMEAS(1))=$P(GMV,U,2)
 . I GMVVD0'>0 D
 .. D MSG("ERROR: Missing or invalid Vital Type (V^"_GMVVNUM_"="_GMVVHOLD_")")
 .. Q
 . E  D
 .. S GMVVFIND=1
 .. S GMVVABBR=$P($G(^GMRD(120.51,+GMVVD0,0)),U,2)
 .. S $P(@GMVDATA@("V",GMVVNUM),U,1)=GMVVD0
 .. D BP^GMVDCVAM,PO2^GMVDCVAM
 .. I $$OMIT^GMVDCVAM(GMVVMEAS) D
 ... S GMVVMEAS=$$UP^XLFSTR($E(GMVVMEAS))_$$LOW^XLFSTR($E(GMVVMEAS,2,$L(GMVVMEAS)))
 ... I $O(@GMVDATA@("Q",GMVVNUM,0))>0 D
 .... D MSG("ERROR: Qualifiers not allowed if vital measurement is omitted (V^"_GMVVNUM_"="_GMVVHOLD_")")
 .... Q
 ... Q
 .. S GMVOK=1
 .. I '$$VALID^GMVDCCHK($P(GMVVMEAS,";"),GMVMSYS,GMVVABBR) S GMVOK=0
 .. I GMVOK,GMVVMEAS("PO2")]"" D
 ... S GMVIXFRM=$$GET1^DID(120.5,1.4,"","INPUT TRANSFORM")
 ... I GMVIXFRM]"" S X=GMVVMEAS("PO2") X GMVIXFRM I '$D(X) S GMVOK=0
 ... Q
 .. I 'GMVOK S GMVOK=$$OMIT^GMVDCVAM($P(GMVVMEAS,";"))
 .. I 'GMVOK D
 ... D MSG("ERROR: Invalid Vital Measurement (V^"_GMVVNUM_"="_GMVVHOLD_")")
 ... Q
 .. S GMVVMEAS=$$CNV^GMVDCCNV($P(GMVVMEAS,";"),GMVMSYS,"S",GMVVABBR)
 .. S $P(@GMVDATA@("V",GMVVNUM),U,2)=GMVVMEAS_";"_GMVVMEAS("PO2")
 .. S (GMVQNUM,GMVQFIND)=0
 .. F  S GMVQNUM=$O(@GMVDATA@("Q",GMVVNUM,GMVQNUM)) Q:GMVQNUM'>0  D
 ... S (GMV,GMVQHOLD)=$G(@GMVDATA@("Q",GMVVNUM,GMVQNUM))
 ... S GMVQD0=$$QUAIEN^GMVDCUTL(GMV)
 ... I GMVQD0>0,$O(^GMRD(120.52,"C",GMVVD0,GMVQD0,0))'>0 S GMVQD0=-2
 ... I GMVQD0'>0 D
 .... I GMVQD0=-2 D MSG("ERROR: Invalid Qualifier for Vital Type (Q^"_GMVVNUM_U_GMVQNUM_"="_GMVQHOLD_")")
 .... I GMVQD0'=-2 D MSG("ERROR: Missing or invalid Vitals Qualifier (Q^"_GMVVNUM_U_GMVQNUM_"="_GMVQHOLD_")")
 .... Q
 ... E  D
 .... S GMVQFIND=1
 .... S $P(@GMVDATA@("Q",GMVVNUM,GMVQNUM),U,1)=GMVQD0
 .... S GMVQARRY=GMVQARRY_GMVQD0_U
 .... I GMVSYSBP,$D(GMVSYSBP(GMVQD0))#2 S GMVSYSBP=0
 .... Q
 ... Q
 .. I GMVSYSBP D
 ... D MSG("ERROR: Systolic only BPs must have a Doppler or Palpated qualifier (V^"_GMVVNUM_"="_GMVVHOLD_")")
 ... Q
 .. I 'GMVQFIND,$O(^GMRD(120.52,"C",GMVVD0,0))>0,'$$OMIT^GMVDCVAM(GMVVMEAS) D
 ... D MSG("WARNING: No valid Qualifiers found (Q^"_GMVVNUM_"^##=Qualifier)")
 ... Q
 .. D DUPCHK^GMVDCVAM
 .. Q
 . Q
 I 'GMVVFIND D
 . D MSG("ERROR: No valid Vital Types / Measurements found (V^##=VitalType^Measurement)")
 . Q
 I $O(@GMVDATA@("Q",GMVVLAST)) D
 . S GMV=$S(GMVVFIND'>0:"ERROR",1:"WARNING")
 . D MSG(GMV_": There are more Qualifiers than there are VitalTypes / Measurements")
 . Q
 Q
 ;
ENTERR ; *** Validate Entered in Error data ***
 I $$FIND1^DIC(200,"","","`"_GMVERRBY)'=GMVERRBY D
 . D MSG("ERROR: Missing or invalid Entered in Error By parameter")
 . Q
 S (GMVINUM,GMVILAST,GMVIFIND)=0
 F  S GMVINUM=$O(@GMVDATA@("I",GMVINUM)) Q:GMVINUM'>0  D
 . S GMVILAST=GMVINUM
 . S (GMVID0,GMVIHOLD)=$G(@GMVDATA@("I",GMVINUM))
 . I $$FIND1^DIC(120.5,"","","`"_GMVID0)'=GMVID0 D
 .. D MSG("ERROR: Entered in Error IENS not found (I^"_GMVINUM_"="_GMVIHOLD_")")
 .. Q
 . E  D
 .. I $P($G(^GMR(120.5,GMVID0,2)),U) D
 ... D MSG("ERROR: Vitals record already marked Entered in Error (I^"_GMVINUM_"="_GMVIHOLD_")")
 ... Q
 .. S GMVIFIND=1
 .. S (GMVRNUM,GMVRFIND)=0
 .. F  S GMVRNUM=$O(@GMVDATA@("R",GMVINUM,GMVRNUM)) Q:GMVRNUM'>0  D
 ... S (GMV,GMVRHOLD)=$G(@GMVDATA@("R",GMVINUM,GMVRNUM))
 ... S GMVRD0=$$REAIEN^GMVDCUTL(GMV)
 ... I GMVRD0'>0 D
 .... D MSG("ERROR: Missing or invalid Entered in Error Reason (R^"_GMVINUM_U_GMVRNUM_"="_GMVRHOLD_")")
 .... Q
 ... E  D
 .... S GMVRFIND=1
 .... S @GMVDATA@("R",GMVINUM,GMVRNUM)=GMVRD0
 .... Q
 ... Q
 .. I 'GMVRFIND D
 ... D MSG("ERROR: No valid Entered in Error Reasons found (R^"_GMVINUM_"^##=EnteredInErrorReason)")
 ... Q
 .. Q
 . Q
 I 'GMVIFIND D
 . D MSG("ERROR: No valid Entered in Error IENS found (I^##=EnteredInError)")
 . Q
 I $O(@GMVDATA@("R",GMVILAST)) D
 . S GMV=$S(GMVIFIND'>0:"ERROR",1:"WARNING")
 . D MSG(GMV_": There are more Entered in Error Reasons than there are Entered in Error IENS")
 . Q
 Q
 ;
MSG(X) ; *** Add a line to the message array ***
 S (GMVMSG,RESULT(-1))=1+$G(RESULT(-1),0)
 S RESULT(GMVMSG)=X
 I $P(X,":")="ERROR" S RESULT(0)="ERROR"
 Q
 ;
BPSYSQ ;;Qualifiers that must be present if only systolic BP is present
 ;;DOPPLER
 ;;PALPATED
 ;;
