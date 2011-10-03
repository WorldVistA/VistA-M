SROESAR0 ;BIR/ADM - ANESTHESIA REPORT E-SIG UTILITY ; [ 02/14/04  7:47 AM ]
 ;;3.0; Surgery ;**100**;24 Jun 93
 ;
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
VIEW N SRJ,SRCAT,SRFLD,SRFILE,SRLN,SRNP,SRN,SRP,SRSUB,SRW,X,Y
 F SRJ=1:1 S SRFLD=$P($T(FIELD+SRJ),";;",2) Q:SRFLD=""  D
 .S SRNP=$P(SRFLD,"^",3),SRN=$P(SRNP,";"),SRP=$P(SRNP,";",2)
 .S (SRSUB,X)=$P(SRFLD,"^",2),Y=$P(X,"-",2),SRFILE=$P(Y,",")
 .S SRCAT=$P(SRFLD,"^") S SRCAT=$S(SRCAT="":SRFILE,1:SRCAT)
 .S SRW=$S($P(Y,";",2)["W":1,1:0) I SRW D  Q
 ..S ^TMP("SRARAD"_SRS,$J,SRTN,SRCAT,SRSUB,0)=$G(^SRF(SRTN,SRN,0))
 ..I SRS=1 S ^TMP("SRASAVE",$J,SRTN,SRCAT,SRSUB,0)=$G(^SRF(SRTN,SRN,0))
 ..S SRLN=0 F  S SRLN=$O(^SRF(SRTN,SRN,SRLN)) Q:'SRLN  S ^TMP("SRARAD"_SRS,$J,SRTN,SRCAT,SRSUB,SRLN)=$G(^SRF(SRTN,SRN,SRLN,0)) I SRS=1 S ^TMP("SRASAVE",$J,SRTN,SRCAT,SRSUB,SRLN)=$G(^SRF(SRTN,SRN,SRLN,0))
 .S ^TMP("SRARAD"_SRS,$J,SRTN,SRCAT,SRSUB)=$P($G(^SRF(SRTN,SRN)),"^",SRP)
 .I SRS=1 S ^TMP("SRASAVE",$J,SRTN,SRCAT,SRSUB)=$P($G(^SRF(SRTN,SRN)),"^",SRP)
 Q
REVRS ; restore before-edit data
 N SRJ,SRCAT,SRFIELD,SRFILE,SRFLD,SRLN,SRNP,SRN,SRP,SRSUB,SRVAL,SRW,X,Y
 F SRJ=1:1 S SRFLD=$P($T(FIELD+SRJ),";;",2) Q:SRFLD=""  D
 .S SRNP=$P(SRFLD,"^",3),SRN=$P(SRNP,";"),SRP=$P(SRNP,";",2)
 .S (SRSUB,X)=$P(SRFLD,"^",2),Y=$P(X,"-",2),SRFILE=$P(Y,","),SRFIELD=$P(Y,",",2)
 .S SRCAT=$P(SRFLD,"^") S SRCAT=$S(SRCAT="":SRFILE,1:SRCAT)
 .Q:'$D(^TMP("SRARAD1",$J,SRTN,130,SRSUB))
 .S SRW=$S($P(Y,";",2)["W":1,1:0) I SRW D  Q
 ..K ^SRF(SRTN,SRN) S ^SRF(SRTN,SRN,0)=$G(^TMP("SRASAVE",$J,SRTN,130,SRSUB,0))
 ..S SRLN=0 F  S SRLN=$O(^TMP("SRASAVE",$J,SRTN,130,SRSUB,SRLN)) Q:'SRLN  S ^SRF(SRTN,SRN,SRLN,0)=$G(^TMP("SRASAVE",$J,SRTN,130,SRSUB,SRLN,0))
 .S SRVAL=$G(^TMP("SRASAVE",$J,SRTN,130,SRSUB))
 .I SRVAL="" S SRVAL="@"
 .K DA,DIE,DR S DA=SRTN,DIE=130,DR=SRFIELD_"////^S X=SRVAL" D ^DIE K DA,DIE,DR
 D REVRS^SROESARA
 Q
TR S SRP=SRI,SRP=$TR(SRP,"1234567890.,","ABCDEFGHIJPK")
 Q
FIELD ; list of fields (^field name on report-file,field^node;piece)
KPJB ;;^Operating Room-130,.02^0;2
KPAC ;;^ASA Class-130,1.13^1.1;3
KPCA ;;^Principal Anesthetist-130,.31^.3;1
KPCB ;;^Relief Anesthetist-130,.32^.3;2
KPCC ;;^Assistant Anesthetist-130,.33^.3;3
KPCD ;;^Anesthesiologist Supervisor-130,.34^.3;4
KPCDE ;;^Attending Code (Anes Supervise Code)-130,.345^.3;6
KBF ;;^Principal Procedure-130,26^OP;1
KPBE ;;^Intraoperative Blood Loss (ml)-130,.25^.2;5
KPBEE ;;^Total Urine Output (ml)-130,.255^.2;16
KPDF ;;^Postoperative Disposition-130,.46^.4;6
KPAA ;;^PAC(U) Admission Score-130,1.11^1.1;1
KPAB ;;^PAC(U) Discharge Score-130,1.12^1.1;2
KPBA ;;^Anesthesia Care Start Time-130,.21^.2;1
KPBD ;;^Anesthesia Care End Time-130,.24^.2;4
KPCF ;;^Minimum Intraoperative Temperature-130,.36^.3;7
KPAI ;;^Postop Anesthesia Note Date/Time-130,1.19^1.1;9
KACAPA ;;^Postop Anesthesia Note-130,130.1;W^48;0
KPBH ;;^General Comments-130,.28;W^5;0
