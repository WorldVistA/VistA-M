SRHLUO ;B'HAM ISC/DLR - Surgery Interface Utilities for building Outgoing HL7 Segment ; [ 05/06/98   7:14 AM ]
 ;;3.0; Surgery ;**41,127**;24 Jun 93
 ; Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ; ** ASSUMMED variable list
 ; all - INIT^HLTRANS
 ; DFN - IEN file #2
 ; SRI - incremental variable ^TMP("HLS",$J,SRI) 
 ;     - returns the next #
 ; CASE- IEN (file 130) case number must be set before the call
 ;
AL1(SRI,SRENT) ;AL1 segment(s) - allergy information from the generic call to (GMRADPT)
 Q:'$D(DFN)
 S X="GMRADPT" X ^%ZOSF("TEST") Q:'$T
 N TYPE,X,AL1,CNT
 ;Allergy package valid entry point returns GMRAL(x)
 D ^GMRADPT
 S CNT=1
 F X=0:0 S X=$O(GMRAL(X)) Q:X'>0  D
 .S TYPE=$P(GMRAL(X),"^",3),AL1(X)="AL1"_HL("FS")_$E("0000",$L(CNT)+1,4)_CNT_HL("FS")_$S(TYPE="D":"DA",TYPE="F":"FA",TYPE="O":"MA",1:"")_HL("FS")_HLCOMP_$P(GMRAL(X),"^",2)
 .S ^TMP(SRENT,$J,SRI)=AL1(X),SRI=SRI+1,CNT=CNT+1
 K GMRAL
 Q
DG1(SRI,SRENT) ;DG1 segment(s) - surgery diagnosis information
 Q:'$D(CASE)
 N DG1,I9,X,X1
 I $D(^SRF(CASE,34)) I $P(^SRF(CASE,34),U,2)'="" D
 .S I9=$$ICDDX^ICDCODE($P(^SRF(CASE,34),U,2),$P($G(^SRF(CASE,0)),"^",9))
 .S DG1="DG1"_HL("FS")_"0001"_HL("FS")_"I9"_HL("FS")_$P(I9,U,2)_HL("FS")_$P(I9,U,4)_HL("FS")_HL("FS")_"P" D
 ..S ^TMP("HLS",$J,SRI)=DG1,SRI=SRI+1,DG1=""
 I $D(^SRF(CASE,33)) I $P(^SRF(CASE,33),U)'="" S DG1="DG1"_HL("FS")_"0001"_HL("FS")_"I9"_HL("FS")_HL("FS")_$P(^SRF(CASE,33),U)_HL("FS")_HL("FS")_"PR" D
 .S ^TMP("HLS",$J,SRI)=DG1,SRI=SRI+1,DG1=""
 I $D(^SRF(CASE,14,0)) S X1=2 F X=0:0 S X=$O(^SRF(CASE,14,X)) Q:X'>0  D
 .I $P(^(0),U,3) S I9=$$ICDDX^ICDCODE($P(^SRF(CASE,14,0),U,3),$P($G(^SRF(CASE,0)),"^",9)) D
 ..S ^TMP("HLS",$J,SRI)="DG1"_HL("FS")_$E("0000",$L(X1)+1,4)_X1_HL("FS")_"I9"_HL("FS")_$P(I9,U,2)_HL("FS")_$P(I9,U,4)_HL("FS")_HL("FS")_"PR",X1=X1+1,SRI=SRI+1
 Q
ERR(SRI,SRERR)     ;ERR segment
 ; SRERR = AE error code and location (segment^sequence #^field^error) 
 S ^TMP("HLA",$J,SRI)="ERR"_HL("FS")_$G(SRERR(1))_HLCOMP_$G(SRERR(2))_HLCOMP_$G(SRERR),SRI=SRI+1
 Q
MSA(SRI,SRAC) ;MSA segment
 ; SRAC = Acknowledgement code (ID)
 ;  AA = Application Accepted (responsed with information)
 ;  AE = Application Error (bad data send error response)
 ;  AR = Application Reject (no data in date range ... )
 ;
 N MSA
 S MSA(1)=$G(SRAC),MSA(2)=$G(HL("MID")),MSA(3)=$G(SRERR)
 S ^TMP("HLA",$J,SRI)="MSA"_HL("FS") F XX=1:1:3 S ^TMP("HLA",$J,SRI)=$G(^TMP("HLA",$J,SRI))_$G(MSA(XX))_$S(XX=3:"",1:HL("FS"))
 S SRI=SRI+1
 Q
OBX(SRI,SRENT) ;OBX segment(s)
 ; This segment builds OBX segments for the following Preoperative data
 ;  - vitals\measurements ^GMRVUTL routine:   
 ;     height, weight, blood pressure, pulse rate, and temperature
 ;  - IN\OUT-PATIENT STATUS field in File #130
 ;  - CANCEL DATE and CANCEL REASON for cancelled and aborted cases
 ;  - SURGICAL SPECIALTY (OR) or MEDICAL SPECIALTY (NON OR)
 ;  - SURGEON PGY and ANES SUPERVISE CODE
 Q:'$D(CASE)
 N OBX,CNT,TYPE,X,Y
 S CNT=1
 I $D(^SRF(CASE,"NON")) S OBX(2)="CE",OBX(3)=HLCOMP_"MEDICAL SPECIALTY"_HLCOMP,OBX(5)=$P(^("NON"),U,8) I OBX(5)'="" S OBX(5)=HLCOMP_$P(^ECC(723,OBX(5),0),U)_HLCOMP_"99VA723" D SOBX
 I $P(^SRF(CASE,0),U,4)'="" S OBX(2)="CE",OBX(3)=HLCOMP_"SURGICAL SPECIALTY"_HLCOMP,OBX(5)=$P(^(0),U,4) I OBX(5)'="" S OBX(5)=HLCOMP_$P(^SRO(137.45,OBX(5),0),U)_HLCOMP_"99VA137.45" D SOBX
 I $D(^SRF(CASE,200)) I $P(^SRF(CASE,200),U,52)'="" S OBX(2)="NM",OBX(3)=HLCOMP_"SURGEON PGY"_HLCOMP_"L",OBX(5)=$P(^(200),U,52) D SOBX
 I $D(^SRF(CASE,.3)) I $P(^SRF(CASE,.3),U,6)'="" S OBX(2)="CE",OBX(3)=HLCOMP_"ANES SUPERVISE CODE"_HLCOMP_"L",OBX(5)=$P(^(.3),U,6) D SOBX
 I $P(^SRF(CASE,0),U,12)'="" S OBX(2)="CE",OBX(3)=HLCOMP_"PATIENT CLASS"_HLCOMP,OBX(5)=$P(^(0),U,12) S C=$P(^DD(130,.011,0),U,2),Y=OBX(5) D Y^DIQ S OBX(5)=HLCOMP_Y_HLCOMP_"L" D SOBX
 S X="GMRVUTL" X ^%ZOSF("TEST") I $T F TYPE="BP","HT","WT","T","P" S GMRVSTR=TYPE D EN6^GMRVUTL I $G(X)'="" S X1=$P(X,"^"),X2=60,SRX=X D C^%DTC I X'<DT D
 .S OBX(2)="CE",OBX(5)=$P(SRX,"^",8),OBX(11)="S",OBX(14)=$$HLDATE^HLFNC($P(SRX,"^")),OBX(16)=$$HNAME^SRHLU($P(SRX,U,6))
 .I TYPE="BP" S OBX(3)="1002"_HLCOMP_"BP",OBX(5)=$P(SRX,"^",8) D SOBX
 .I TYPE="HT" S OBX(3)="1010.3"_HLCOMP_"Height",OBX(5)=$J(2.54*OBX(5),0,2),OBX(6)="cm" D SOBX
 .I TYPE="WT" S OBX(3)="1010.1"_HLCOMP_"Body Weight",OBX(5)=$J(OBX(5)/2.2,0,2),OBX(6)="kg" D SOBX
 .I TYPE="T" S OBX(3)="1000"_HLCOMP_"Temperature" S OBX(5)=$J(OBX(5)-32*5/9,0,2),OBX(6)="cel" D SOBX
 .I TYPE="P" S OBX(3)="1006.2"_HLCOMP_"HR",OBX(6)="min" D SOBX
 I $D(^SRF(CASE,30)),$P($G(^SRF(CASE,31)),U,8)'="" D
 .S OBX(2)="CE",OBX(3)=HLCOMP_"CANCEL REASON"_HLCOMP_"L",OBX(5)=HLCOMP_$P(^SRO(135,$P(^SRF(CASE,31),U,8),0),U)_HLCOMP_"L",OBX(14)=$$HLDATE^HLFNC($P(^SRF(CASE,30),U)),OBX(16)=$$HNAME^SRHLU($P(^SRF(CASE,30),U,3)) D SOBX
 Q
SOBX ;sets the OBX segment
 S OBX(11)="S"
 S OBX(1)=CNT
 S ^TMP(SRENT,$J,SRI)="OBX"_HL("FS") F XX=1:1:16 S ^TMP(SRENT,$J,SRI)=$G(^TMP(SRENT,$J,SRI))_$G(OBX(XX))_$S(XX=16:"",1:HL("FS")),OBX(XX)=""
 S SRI=SRI+1,CNT=$G(CNT)+1
 Q
PID(SRI,SRENT) ;PID segment builder returns patient information
 Q:'$D(DFN)
 N PID
 S ^TMP(SRENT,$J,SRI)=$$EN^VAFHLPID(DFN,"1,2,3,4,5,6,7,8,10,11,13,16,17,19",1)
 S SRI=SRI+1
 Q
