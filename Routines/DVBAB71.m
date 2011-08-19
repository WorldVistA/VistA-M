DVBAB71 ;ALB/KLB - CAPRI REQUEST STATUS INQUIRY ;09/11/00
 ;;2.7;AMIE;**35**;Apr 10, 1995
 ;
STRT(MSG,DFN,RECIEN) ; 
 S U="^"
 K ^TMP("CAPRI")
 I '$D(DFN) S MSG(1)="You must select a patient."
 Q:'$D(DFN)
 Q:DFN=""
 S PTNAME=$E($P(^DPT(DFN,0),U),1,25)
 ;S RECIEN=0,RECIEN=$O(^DVB(396,"B",DFN,RECIEN))
 S DVB0=$G(^DVB(396,RECIEN,0)),DVB1=$G(^DVB(396,RECIEN,1)),DVB2=$G(^DVB(396,RECIEN,2)),DVB6=$G(^DVB(396,RECIEN,6))
 S MCNT=1
 ;S ^TMP("CAPRI",MCNT)="Patient Name: "_PTNAME_"^",MCNT=MCNT+1
 I $P(DVB2,U,10)="L" S DOCTYP="ACTIVITY DATE: "
 I $P(DVB2,U,10)="A" S DOCTYP="Admission Date: "
 S Y=$P(DVB0,U,4) X ^DD("DD")
 S ^TMP("CAPRI",MCNT)=" Patient Name: "_PTNAME_"             "_DOCTYP_Y_"^",MCNT=MCNT+1
 ;S ^TMP("CAPRI",MCNT)="SSN: "_$P(^DPT(DFN,0),U,9)_"^",MCNT=MCNT+1
 S ^TMP("CAPRI",MCNT)="          SSN: "_$P(^DPT(DFN,0),U,9)_"                  Claim Number: "_$P(^DPT(DFN,.31),U,3)_"^",MCNT=MCNT+1
 S DIV=$P(DVB2,U,9) I DIV'="" S DIV=$P(^DG(40.8,DIV,0),U)
 S ^TMP("CAPRI",MCNT)="Receiving Div: "_DIV_"^",MCNT=MCNT+1
 S ^TMP("CAPRI",MCNT)="  Requisition          Status      Status Date    Operator    Current Division"_"^",MCNT=MCNT+1
 S Y=$P(DVB0,U,10) X ^DD("DD") S DIV=$P(DVB6,U,9),STAT=$P(DVB0,U,9) I STAT="P" S STAT="PENDING        " I STAT="C" S STAT="COMPLETED     " I STAT="" S STAT="              "
 I DIV'="" S DIV=$P(^DG(40.8,DIV,0),U)
 S ^TMP("CAPRI",MCNT)="---------------------------------------------------------------------------"_"^",MCNT=MCNT+1
 S OP=$P(DVB1,U,13) I OP="" S OP="            "
DATA S ^TMP("CAPRI",MCNT)="  Notice/Discharge:   "_STAT_Y_"    "_OP_DIV_"^",MCNT=MCNT+1
 S Y=$P(DVB0,U,12) X ^DD("DD") S DIV=$P(DVB6,U,11)
 S STAT=$P(DVB0,U,11) I STAT="P" S STAT="PENDING        " I STAT="C" S STAT="COMPLETED     " I STAT="" S STAT="              "
 S OP=$P(DVB1,U,14) I OP="" S OP="            "
 S ^TMP("CAPRI",MCNT)="  Hospital Summary:   "_STAT_Y_"    "_OP_DIV_"^",MCNT=MCNT+1
 S Y=$P(DVB0,U,14) X ^DD("DD") S DIV=$P(DVB6,U,13)
 S STAT=$P(DVB0,U,13) I STAT="P" S STAT="PENDING        " I STAT="C" S STAT="COMPLETED     " I STAT="" S STAT="              "
 S OP=$P(DVB1,U,15) I OP="" S OP="            "
 S ^TMP("CAPRI",MCNT)="21-day Certificate:   "_STAT_Y_"    "_OP_DIV_"^",MCNT=MCNT+1
 S Y=$P(DVB1,U) X ^DD("DD") S DIV=$P(DVB6,U,15)
 S STAT=$P(DVB0,U,15) I STAT="P" S STAT="PENDING        " I STAT="C" S STAT="COMPLETED     " I STAT="" S STATUS="              "
 S OP=$P(DVB1,U,16) I OP="" S OP="            "
 S ^TMP("CAPRI",MCNT)="       Other/Exam:   "_STAT_Y_"    "_OP_DIV_"^",MCNT=MCNT+1
 S Y=$P(DVB1,U,3) X ^DD("DD") S DIV=$P(DVB6,U,17)
 S STAT=$P(DVB0,U,17) I STAT="P" S STAT="PENDING        " I STAT="C" S STAT="COMPLETED     " I STAT="" S STAT="              "
 S OP=$P(DVB1,U,17) I OP="" S OP="            "
 S ^TMP("CAPRI",MCNT)="   Special Report:   "_STAT_Y_"    "_OP_DIV_"^",MCNT=MCNT+1
 S Y=$P(DVB1,U,4) X ^DD("DD") S DIV=$P(DVB6,U,19)
 S STAT=$P(DVB0,U,19) I STAT="P" S STAT="PENDING        " I STAT="C" S STAT="COMPLETED     " I STAT="" S STAT="              "
 S OP=$P(DVB1,U,18) I OP="" S OP="            "
 S ^TMP("CAPRI",MCNT)="Competency Report:   "_STAT_Y_"    "_OP_DIV_"^",MCNT=MCNT+1
 S Y=$P(DVB1,U,5) X ^DD("DD") S DIV=$P(DVB6,U,21)
 S STAT=$P(DVB0,U,21) I STAT="P" S STAT="PENDING        " I STAT="C" S STAT="COMPLETED     " I STAT="" S STAT="              "
 S OP=$P(DVB2,U) I OP="" S OP="            "
 S ^TMP("CAPRI",MCNT)="     Form 21-2680:   "_STAT_Y_"    "_OP_DIV_"^",MCNT=MCNT+1
 S Y=$P(DVB1,U,6) X ^DD("DD") S DIV=$P(DVB6,U,23)
 S STAT=$P(DVB0,U,23) I STAT="P" S STAT="PENDING        " I STAT="C" S STAT="COMPLETED     " I STAT="" S STAT="              "
 S OP=$P(DVB2,U,2) I OP="" S OP="            "
 S ^TMP("CAPRI",MCNT)="Asset Information:   "_STAT_Y_"    "_OP_DIV_"^",MCNT=MCNT+1
 S Y=$P(DVB1,U,8) X ^DD("DD") S DIV=$P(DVB6,U,7)
 S STAT=$P(DVB1,U,7) I STAT="P" S STAT="PENDING        " I STAT="C" S STAT="COMPLETED     " I STAT="" S STAT="              "
 S OP=$P(DVB2,U,3) I OP="" S OP="            "
 S ^TMP("CAPRI",MCNT)=" Admission Report:   "_STAT_Y_"    "_OP_DIV_"^",MCNT=MCNT+1
 S Y=$P(DVB1,U,9) X ^DD("DD") S DIV=$P(DVB6,U,26)
 S STAT=$P(DVB0,U,26) I STAT="P" S STAT="PENDING        " I STAT="C" S STAT="COMPLETED     " I STAT="" S STAT="              "
 S OP=$P(DVB2,U,4) I OP="" S OP="            "
 S ^TMP("CAPRI",MCNT)="OPT Treatment Rpt:   "_STAT_Y_"    "_OP_DIV_"^",MCNT=MCNT+1
 S Y=$P(DVB1,U,10) X ^DD("DD") S DIV=$P(DVB6,U,28)
 S STAT=$P(DVB0,U,28) I STAT="P" S STAT="PENDING        " I STAT="C" S STAT="COMPLETED     " I STAT="" S STAT="              "
 S OP=$P(DVB2,U,5) I OP="" S OP="            "
 S ^TMP("CAPRI",MCNT)="    Beg Date/Care:   "_STAT_Y_"    "_OP_DIV_"^",MCNT=MCNT+1
 S ^TMP("CAPRI",MCNT)=""_"^",MCNT=MCNT+1
 D REM
 S ^TMP("CAPRI",MCNT)=""_"^"
 S Y=$P(DVB1,U,12) X ^DD("DD")
 S ^TMP("CAPRI",MCNT)="Requesting location: "_$E($P(DVB2,U,7),1,20)_"               Date of Request: "_Y,MCNT=MCNT+1
 S ^TMP("CAPRI",MCNT)="       Requested by: "_$E($P(DVB2,U,8),1,25)_"          "_Y
 S MSG=$NA(^TMP("CAPRI"))
 ;F  S XX=$O(^TMP("CAPRI",XX)) Q:'XX  S MSG(XX)=$G(^TMP("CAPRI",XX))
 K Y,PTNAME,DFN,DVB0,DVB1,DVB2,DVB6
 Q
REM S X=0,FLG=0
 F  S X=$O(^DVB(396,RECIEN,5,X)) Q:'X  D
 .I FLG=0 D
 ..S ^TMP("CAPRI",MCNT)="REMARKS: "_$G(^DVB(396,RECIEN,5,X,0))_"^",MCNT=MCNT+1
 ..S FLG=1
 .I FLG=1&(X>1) D
 ..S ^TMP("CAPRI",MCNT)=$G(^DVB(396,RECIEN,5,X,0))_"^",MCNT=MCNT+1
 S ^TMP("CAPRI",MCNT)=""_"^"
 Q
