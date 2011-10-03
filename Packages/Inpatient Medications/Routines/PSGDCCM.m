PSGDCCM ;BIR/CML3-DRUG COST EDIT MESSAGE ;01 MAY 97 / 10:58 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
 K ^TMP($J) S XMSUB="UNIT DOSE COST DATA CHANGED",XMTEXT="^TMP($J,",X(1)=$$ENNPN^PSGMI(DUZ)_" has changed the cost data for the drug "_DRGN_"." F X="SD1","FD" S @X=$E($$ENDTC^PSGMI(@X),1,8)
 S X(2)="The cost was changed to "_NC_" for "_SD1_" through "_FD_".",M=1,^TMP($J,1,0)=""
 F X=1,2 S ^(0)=^TMP($J,M,0)_"  " F Q=1:1 S P=$P(X(X)," ",Q) Q:$P(X(X)," ",Q,99)=""  S:$L(^TMP($J,M,0))+$L(P)>73 M=M+1,^TMP($J,M,0)="" S ^(0)=^TMP($J,M,0)_P_" "
 K XMY F Q=0:0 S Q=$O(^XUSEC("PSJU MGR",Q)) Q:'Q  S XMY(Q)=0
 I '$D(XMY) F Q=0:0 S Q=$O(^XUSEC("PSJ RPHARM",Q)) Q:'Q  S XMY(Q)=0
 S XMY(+DUZ)=1,XMDUZ="MEDICATIONS,UNIT DOSE"
 D ^XMD K ^TMP($J),FDN,PSGID,PSGOD,SD1N,XMDUZ,XMSUB,XMTEXT,XMY Q
