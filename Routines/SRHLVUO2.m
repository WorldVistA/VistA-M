SRHLVUO2 ;BIR/DLR - Surgery Interface (Cont.) Utilities for building Outgoing HL7 Segments ; [ 06/23/99   7:14 AM ]
 ;;3.0; Surgery ;**41,88,127**;24 Jun 93
 ; Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
ZIS(SRI) ;sets ^TMP("HLS",$J,HLSDT,I) global for sending ZIS Appointment Information - Service Segment(s)
 N X,XX,SRJ,SRM,SRP,SRREP,SRX,ZIS
 S X=0 F  S X=$O(^SRF(CASE,13,X)) Q:'X  I $G(^(X,2))'="" D
 .S ZIS(1)=$P(^SRF(CASE,13,X,2),U) I ZIS(1)'="" S SRX=$$CPT^ICPTCOD(ZIS(1),$P($G(^SRF(CASE,0)),U,9)),ZIS(1)=$P(SRX,U,2)_HLCOMP_$P(SRX,U,3)_HLCOMP_"C4",ZIS(5)=$S($P(^SRF(CASE,13,X,0),U,3)="Y":"CONFIRMED",1:"PENDING")
 .K ZIS(6) S (SRJ,SRREP)=0 F  S SRJ=$O(^SRF(CASE,13,X,"MOD",SRJ)) Q:'SRJ  S SRP=$P(^SRF(CASE,13,X,"MOD",SRJ,0),U),SRM=$$MOD^ICPTMOD(SRP,"I",$P($G(^SRF(CASE,0)),U,9)) D
 ..S ZIS(6)=$G(ZIS(6))_$S(SRREP:HLREP,1:"")_$P(SRM,U,2)_HLCOMP_$P(SRM,U,3)_HLCOMP,SRREP=1
 .S ^TMP("HLS",$J,HLSDT,SRI)="ZIS"_HLFS F XX=1:1:5 S ^TMP("HLS",$J,HLSDT,SRI)=^TMP("HLS",$J,HLSDT,SRI)_$G(ZIS(XX))_$S(XX=5:"",1:HLFS)
 .I $L($G(ZIS(6))) S ^TMP("HLS",$J,HLSDT,SRI)=^TMP("HLS",$J,HLSDT,SRI)_HLFS_ZIS(6)
 .S SRI=SRI+1
 Q
