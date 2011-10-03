SRHLUO3 ;BIR/DLR - Surgery Interface (Cont.) Utilities for building Outgoing HL7 Segments ; [ 05/20/99   7:14 AM ]
 ;;3.0; Surgery ;**41,88,127,151**;24 Jun 93
 ; Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
 ; Reference to ^PSS50 supported by DBIA #4533
 ;
 ;INIT^HLTRANS MUST BE called before calling this routine.
 ;Mandatory variables
 ;I    - IEN of the entry to be processed
 ;SRI  - next available number in ^TMP(SRENT... global
MFE(SRI,REC,FILE,FIELD,SRENT) ;Master File Entry segment
 N I,ID,SRX,SRY,X,SRRX
 ;event point processing
 I $G(SRENT)'="" S I=$P(SRENT,U),ID=$P(SRENT,U,2) D SMFE
 ;set of codes
 I $G(SRENT)="",$G(FIELD)'="" S Y="",C=$P(^DD(FILE,FIELD,0),U,2) D Y^DIQ F X=2:1:$L(C,";")-1 S I=X-1,ID=$P($P(C,";",X),":",2) D SMFE
 ;files
 I $G(SRENT)="",$G(FIELD)="" D
 .I FILE=50 S SDT=$$FMADD^XLFDT(DT,-366) F  S SDT=$O(^SRF("AC",SDT)) Q:'SDT!(SDT>DT)  S XIEN=0 F  S XIEN=$O(^SRF("AC",SDT,XIEN)) Q:'XIEN  D
 ..I $D(^SRF(XIEN,22,0)) S X2=0 F  S X2=$O(^SRF(XIEN,22,X2)) Q:'X2  I $D(^(X2,0)) S I=$P(^(0),U) D DATA^PSS50(I,,,,,"SRRX") S ^TMP("SRHL",$J,"MED",I)=HLCOMP_$P($G(^TMP($J,"SRRX",I,.01)),"^")_HLCOMP
 ..K ^TMP($J,"SRRX",I)
 ..S X2=0 F  S X2=$O(^TMP("SRHL",$J,"MED",X2)) Q:'X2  S ID=^(X2) D SMFE,ZRX
 ..K ^TMP("SRHL",$J,"MED")
 .I FILE=44 S I=0 F  S I=$O(^SC(I)) Q:'I  S ID=$P(^(I,0),U)_HLCOMP_HLCOMP D SMFE
 .I FILE=80 S I=0 F  S I=$O(^ICD9(I)) Q:'I  S ID=$P(^(I,0),U)_HLCOMP_HLCOMP D SMFE,ZI9
 .I FILE=81 S I=0 F  S I=$O(^ICPT("B",I)) Q:I=""  S ID=I_HLCOMP_HLCOMP D SMFE,ZC4
 .I FILE=133.4 S I=0 F  S I=$O(^SRO(133.4,I)) Q:'I  S ID=HLCOMP_$P(^(I,0),U)_HLCOMP D SMFE,ZMN
 .I FILE=133.7 S I=0 F  S I=$O(^SRO(133.7,I)) Q:'I  S ID=HLCOMP_$P(^(I,0),U)_HLCOMP D SMFE,ZRF
 .I FILE=200 S SDT=$$FMADD^XLFDT(DT,-366) F  S SDT=$O(^SRF("AC",SDT)) Q:'SDT!(SDT>DT)  S XIEN=0 F  S XIEN=$O(^SRF("AC",SDT,XIEN)) Q:'XIEN  D
 ..;4-surgeon,5-first asst.,6-second asst.,13-attend surgeon
 ..I $D(^SRF(XIEN,.1)) F XF=4,5,6,13 S I=$P(^SRF(XIEN,.1),U,XF),ROLE=$S(XF=4:"SURGEON",XF=5:"1ST ASST.",XF=6:"2ND ASST.",XF=13:"ATT. SURGEON") D:I'="" XPER
 ..;1-prin. anes.,2-relief anes.,3-asst. anes.,4-anes. super.
 ..I $D(^SRF(XIEN,.3)) F XF=1,2,3,4 S I=$P(^SRF(XIEN,.3),U,XF),ROLE=$S(XF=1:"PRIN. ANES.",XF=2:"RELIEF ANESTHETIST",XF=3:"ASSISTANT ANESTHETIST",XF=4:"ANES. SUPER.") D:I'="" XPER
 ..;tourniquet applied by
 ..I $D(^SRF(XIEN,2,0)) S X2=0 F  S X2=$O(^SRF(XIEN,2,X2)) Q:'X2  S I=$P(^(X2,0),U,3),ROLE="TOURNIQUET APPLIED BY" D:I'="" XPER
 ..;monitor applied by
 ..I $D(^SRF(XIEN,27,0)) S X2=0 F  S X2=$O(^SRF(XIEN,27,X2)) Q:'X2  S I=$P(^(X2,0),U,4),ROLE="MONITOR APPLIED BY" D:I'="" XPER
 ..;extubated by
 ..I $D(^SRF(XIEN,6,0)) S X2=0 F  S X2=$O(^SRF(XIEN,6,X2)) Q:'X2  I $D(^(X2,6)) S I=$P(^(6),U),ROLE="EXTUBATED BY" D:I'="" XPER
 ..;medications administered by, ordered by
 ..I $D(^SRF(XIEN,22,0)) S X2=0 F  S X2=$O(^SRF(XIEN,22,X2)) Q:'X2  I $D(^(X2,0)) F XF=3,4 S I=$P(^(0),U,XF),ROLE=$S(XF=3:"MEDICATION ORDERED BY",XF=4:"MEDICATION ADM BY") D:I'="" XPER
 .S I=0 F  S I=$O(^TMP("SRHL",$J,"PER",I)) Q:'I  S ID=^(I) D SMFE,STF
 .K ^TMP("SRHL",$J,"PER")
 Q
SMFE ;
 S ^TMP("HLS",$J,SRI)="MFE"_HL("FS")_REC_HL("FS")_I_HL("FS")_$E(DT,1,8)_HL("FS")_ID,SRI=SRI+1
 Q
MFI(SRI,ID,FEC,FILE,SRENT) ;Master File Identification segment
 I '$D(ID)!'$D(FEC) W !!,"Invalid Master File Identifier or Event Code.",!! Q
 S ^TMP("HLS",$J,SRI)="MFI"_HL("FS")_HLCOMP_ID_HLCOMP_$S(FILE=80:"I9",FILE=81:"C4",$E(FILE,1,3)'=130:"99VA"_FILE,1:"L")_HL("FS")_HL("FS")_FEC_HL("FS")_HL("FS")_HL("FS")_"AL",SRI=SRI+1
 Q
STF ;staff master file
 S ^TMP("HLS",$J,SRI)="STF"_HL("FS")_$P($G(^VA(200,I,1)),U,9)_HLCOMP_HLCOMP_HL("FS")_HL("FS")_$P($$HNAME^SRHLU(I),HLCOMP,2,3),SRI=SRI+1
 Q
ZI9 ;master file update to ICD-9 (File #80)
 S SRY=$$ICDDX^ICDCODE(I),^TMP("HLS",$J,SRI)="ZI9"_HL("FS")_$P(SRY,U,2)_HLCOMP_$P(SRY,U,4)_HLCOMP_HL("FS")_$S($P(SRY,U,10)'="":$P(SRY,U,10),1:0),SRI=SRI+1
 Q
ZC4 ;master file update to CPT-4 (File #81)
 S SRX=$$CPT^ICPTCOD(I),^TMP("HLS",$J,SRI)="ZC4"_HL("FS")_$P(SRX,U,2)_HLCOMP_$P(SRX,U,3)_HLCOMP_HL("FS")_$S($P(SRX,U,7)'="":$P(SRX,U,7),1:0),SRI=SRI+1
 Q
ZRX ;master file update to MEDICATION (File #50)
 D DATA^PSS50(I,,,,,"SRRX") S ^TMP("HLS",$J,SRI)="ZRX"_HL("FS")_HLCOMP_$P($G(^TMP($J,"SRRX",I,.01)),"^")_HLCOMP_HL("FS")_$P($G(^("I")),U)_HL("FS")_$S($P($G(^(2)),U,3)["S":1,1:0),SRI=SRI+1
 K ^TMP($J,"SRRX",I)
 Q
ZMN ;master file update to MONITOR (File #133.2)
 S ^TMP("HLS",$J,SRI)="ZMN"_HL("FS")_HLCOMP_$P(^SRO(133.4,I,0),U)_HLCOMP_HL("FS")_$S($P(^(0),U,2)'="":$P(^(0),U,2),1:0),SRI=SRI+1
 Q
ZRF ;master file update to REPLACEMENT FLUIDS (File #133.7)
 S ^TMP("HLS",$J,SRI)="ZRF"_HL("FS")_HLCOMP_$P(^SRO(133.7,I,0),U)_HLCOMP_HL("FS")_$S($P(^(0),U,2)'="":$P(^(0),U,2),1:0),SRI=SRI+1
 Q
 ;cpt4,icd9,medication,monitor,personnel,replacement fluid
 I SRTYP'=3,(SRTYP'=5) D MSG^SRHLMFN(SRTBL,FEC,REC,SRENT)
 Q
XPER ;personnel information extract (SSN) from file 200
 S ^TMP("SRHL",$J,"PER",I)=$$HNAME^SRHLU(I)_"^"_ROLE
 Q
