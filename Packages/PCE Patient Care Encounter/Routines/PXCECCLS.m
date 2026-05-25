PXCECCLS ;WASH/BDB,PKR - UPDATE ENCOUNTER SC/EI FROM DX SC/EI ;Aug 04, 2025@11:50:49
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**124,174,168,211,234,244**;Feb 12, 2004;Build 37
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
 N CIDX,CODE,DONOTUPD,FINAL,IDX,VSIT,NODE,PXPOV,PXPOV800,PXSAS,SAS,UPDATE,X
 S VSIT("IEN")=PXVIEN
 I '$D(^AUPNVPOV("AD",PXVIEN)) D UPD^VSIT Q
 ;Initialize the SC/EI variables. The variables ending in A0 will be
 ;true if all if all the diagnosis entries are 0 for that variable.
 ;Loop over all V POV entries for the Visit.
 S PXPOV=0,UPDATE=0
 F  S PXPOV=+$O(^AUPNVPOV("AD",PXVIEN,PXPOV)) Q:PXPOV=0  D
 . D GETSAFORVPOVDET^PXSPECAUTH(.SAS,.PXPOV800,PXPOV)
 . S IDX=0 F  S IDX=$O(SAS(IDX)) Q:IDX'>0  D
 .. S NODE=SAS(IDX,0),CODE=$$GETCODE^PXSPECAUTH($P(NODE,U))
 .. I $P(NODE,U,2)=1 S FINAL(CODE)=NODE Q
 .. I $P(NODE,U,2)=0 D  Q
 ... I $G(FINAL(CODE))="" S FINAL(CODE)=NODE Q
 ... I $P(FINAL(CODE),U,2)=0!($P(FINAL(CODE),U,2)=1) Q
 ... S FINAL(CODE)=-1
 .. I $P(NODE,U,2)=-1 D
 ... I $P($G(FINAL(CODE)),U,2)=1 Q
 ... S FINAL(CODE)=-1
 K SAS
 S VSIT(900)=""
 S CODE="",IDX=0 F  S CODE=$O(FINAL(CODE)) Q:CODE=""  D
 .S NODE=FINAL(CODE) I NODE=-1 Q
 .S IDX=IDX+1,SAS(IDX,0)=$$FINDBYCODE^PXSPECAUTH(CODE)_U_$P(NODE,U,2)
 I $D(SAS) M VSIT(900)=SAS S VSIT(900)=IDX
 D UPD^VSIT
 Q
 ;
