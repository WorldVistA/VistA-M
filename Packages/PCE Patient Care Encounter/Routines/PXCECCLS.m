PXCECCLS ;WASH/BDB,PKR - UPDATE ENCOUNTER SC/EI FROM DX SC/EI ;03/16/2018
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**124,174,168,211**;Feb 12, 2004;Build 244
 Q
 ;
VST(PXVIEN) ;
 ;  PXVIEN  Pointer to the Visit (#9000010)
 ;
 ;Loop over the V POV Service Connected and Environmental Indicator
 ;(SC/EI) fields and auto-populate the encounter level  SC/EI based
 ;on the following rules:
 ;
 ;If the SC/EI for at least one ICD diagnosis is "Yes", the
 ;Encounter Level SC/EI will automatically be set to "Yes"
 ;regardless if the Encounter Level SC (or EI) was previously
 ;populated ("Yes", "No" or Null). Note: This presumes that a
 ;single ICD diagnosis with SC/EI determination of "Yes" makes the
 ;Encounter SC/EI determination "Yes".
 ;
 ;If the SC/EI for all ICD diagnosis are "No" the Encounter Level
 ;SC/EI will automatically be set to "No" regardless if the
 ;Encounter Level SC/EI was previously populated ("Yes", "No" or
 ;Null). Note: This presumes that an Encounter SC/EI cannot be
 ;"Yes" if all ICD diagnosis have an SC/EI determination of "No".
 ;
 ;If at least one ICD diagnosis is missing SC/EI determination and
 ;none of the other ICD diagnosis SC/EI determination is "Yes" do
 ;not change the SC/EI determination of the Encounter level. Note:
 ;This presumes that if one or more ICD diagnosis do not have an
 ;SC/EI determination then no inference can be made upon the
 ;Encounter Level SC determination. In addition if another package
 ;populates SC/EI directly do not overwrite that value in the case
 ;of incomplete data. In other words do not set the Encounter Level
 ;to Null.
 ;
 ;VARIABLE LIST TO AUTO POPULATE THE ENCOUNTER LEVEL SC/EI
 ;For each SC/EI in the PXSCEINW string:
 ; = 1 SC/EI Classification determined by the DX's is found to be "Yes"
 ; = 0 SC/EI Classification determined by the DX's is found to be "NO"
 ; =-1 SC/EI cannot be determined by the DX's =""
 ;
 ;Do not ask the SC/EI questions Edit flag for SC: SCEF, AO: AOEF,
 ;IR: IREF, EC:ECEF, MST: MSTEF , HNC: HNCEF , CV: CVEF,
 ;SHAD:SHADEF Used in Visit File Filing - See example below:
 ; VSIT("SCEF")=1 SC/EI
 ;  Classification determined by the DX's - do not ask SC/EI
 ; VSIT("SCEF")=0
 ;  SC/EI Classification undetermined by the DX's - ask SC/EI etc.
 ;
 ;====================
 ;If the Visit is missing the patient quit.
 I $P($G(^AUPNVSIT(PXVIEN,0)),U,5)="" Q
 S VSIT("IEN")=PXVIEN
 S (VSIT("SCEF"),VSIT("AOEF"),VSIT("IREF"),VSIT("ECEF"))=0
 S (VSIT("MSTEF"),VSIT("HNCEF"),VSIT("CVEF"),VSIT("SHADEF"))=0
 I '$D(^AUPNVPOV("AD",PXVIEN)) D UPD^VSIT Q
 ;Initialize the SC/EI variables. The variables ending in A0 will be
 ;true if all if all the diagnosis entries are 0 for that variable.
 N AO,CV,EC,HNC,IR,MST,SC,SHAD,VSITA0
 N AOA0,CVA0,ECA0,HNCA0,IRA0,MSTA0,SCA0,SHADA0
 N PXPOV,PXPOV800
 S (AO,CV,EC,HNC,IR,MST,SC,SHAD)=""
 S (AOA0,CVA0,ECA0,HNCA0,IRA0,MSTA0,SCA0,SHADA0)=1
 ;Loop over all V POV entries for the Visit.
 S PXPOV=0
 F  S PXPOV=+$O(^AUPNVPOV("AD",PXVIEN,PXPOV)) Q:PXPOV=0  D
 . S PXPOV800=$G(^AUPNVPOV(PXPOV,800))
 . I SC'=1 S SC=$P(PXPOV800,U,1) I SC'=0 S SCA0=0
 . I AO'=1 S AO=$P(PXPOV800,U,2) I AO'=0 S AOA0=0
 . I IR'=1 S IR=$P(PXPOV800,U,3) I IR'=0 S IRA0=0
 . I EC'=1 S EC=$P(PXPOV800,U,4) I EC'=0 S ECA0=0
 . I MST'=1 S MST=$P(PXPOV800,U,5) I MST'=0 S MSTA0=0
 . I HNC'=1 S HNC=$P(PXPOV800,U,6) I HNC'=0 S HNCA0=0
 . I CV'=1 S CV=$P(PXPOV800,U,7) I CV'=0 S CVA0=0
 . I SHAD'=1 S SHAD=$P(PXPOV800,U,8) I SHAD'=0 S SHADA0=0
 S (VSIT("SCEF"),VSIT("AOEF"),VSIT("IREF"),VSIT("ECEF"))=0
 S (VSIT("MSTEF"),VSIT("HNCEF"),VSIT("CVEF"),VSIT("SHADEF"))=0
 I (SC=1)!(SCA0=1) S VSIT("SC")=SC,VSIT("SCEF")=1
 I (AO=1)!(AOA0=1) S VSIT("AO")=AO,VSIT("AOEF")=1
 I (IR=1)!(IRA0=1) S VSIT("IR")=IR,VSIT("IREF")=1
 I (EC=1)!(ECA0=1) S VSIT("EC")=EC,VSIT("ECEF")=1
 I (MST=1)!(MSTA0=1) S VSIT("MST")=MST,VSIT("MSTEF")=1
 I (HNC=1)!(HNCA0=1) S VSIT("HNC")=HNC,VSIT("HNCEF")=1
 I (CV=1)!(CVA0=1) S VSIT("CV")=CV,VSIT("CVEF")=1
 I (SHAD=1)!(SHADA0=1) S VSIT("SHAD")=SHAD,VSIT("SHADEF")=1
 I $G(VSIT("SC"))=1 S (VSIT("AO"),VSIT("IR"),VSIT("EC"))="@"
 D UPD^VSIT
 Q
 ;
