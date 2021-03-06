GMRCONS2 ;ALB/MRY - Consult/Scheduling link report ;4/10/06  14:21
 ;;3.0;CONSULT/REQUEST TRACKING;**52**;DEC 27, 1997
 ;
 ;Continued from GMRCONS1
 D SUMARY,CT,SUMARY2,CT2
 S SETNOD=" " D SETNOD S SETNOD=" " D SETNOD S SETNOD="End of report." D SETNOD
 ;
VALM S VALMHDR(1)="Service: "_SRVNM
 S SETNOD=$$SPC("Status",21),SETNOD=SETNOD_"Date",SETNOD=$$SPC(SETNOD,31),SETNOD=SETNOD_"SC",SETNOD=$$SPC(SETNOD,36),SETNOD=SETNOD_"L4",SETNOD=$$SPC(SETNOD,41),SETNOD=SETNOD_"Patient",SETNOD=$$SPC(SETNOD,62)
 S SETNOD=SETNOD_"Appointment",SETNOD=$$SPC(SETNOD,79),SETNOD=SETNOD_"Date/Time",SETNOD=$$SPC(SETNOD,97)
 D CHGCAP^VALM("CAPTION LINE",SETNOD)
 Q
 ;
SUMARY ;Create the "A" x-ref
 ;;ACTERAP;Active, By Admin;Active, Edit Re-submit Admin Purpose
 ;;ACTERCC;Active, Can By Clinic;Active, Edit Re-submit, Cancel by Clinic
 ;;ACTERCP;Active, Can By Patient;Active, Edit Re-submit, Cancel by Patient
 ;;ACTERNS;Active, No-Show;Active, Edit Re-submit, No Show
 ;;ACTEROW;Active, Edit Resubmit;Active, Edit Re-submit, Old Way
 ;;ACTWOLHNWL;Active, Manually;Active, Without Link History
 ;;ACTWOLHWL;Active, EWL;Active, Without Link History EWL
 ;;ACTWOLHIFC;Active, IFC;Active, Without Link History IFC
 ;;CANCELED;Cancelled;Cancelled
 ;;COMPLETE;Completed;Completed
 ;;DSCNTUED;Discontinued;Discontinued
 ;;INCMPLTE;Incomplete;Incomplete
 ;;PENNWL;Pending;Pending
 ;;PENWL;Pending, EWL;Pending, Electronic Wait List
 ;;SCHWALCO;Sch, Linked, Ck'd Out;Scheduled, Linked, Checked Out;1
 ;;SCHWALNCO;Scheduled, Linked;Scheduled, Linked;1
 ;;SCHWHNAL;Sch, Not Linked now;Scheduled, Not Linked
 ;;SCHWOLHNWL;Sch, Never Linked;Scheduled, Without Link History
 ;;SCHWOLHWL;Schedule, EWL;Scheduled, Without Link history, wait listed
 ;;SCHWOLHIFC;Schedule, IFC;Scheduled, Without Link history, interfacility consult
 ;;TOC;Total Open Consults;Total Open Consults
 ;;TCC;Total Closed Consults;Total Closed Consults
 ;;
 F A=1:1 S B=$T(SUMARY+A) Q:$P(B,";",3)=""  S ^TMP($J,"A",$P(B,";",3))=0
 S ST="" F  S ST=$O(^TMP($J,"S",ST)) Q:ST=""  D  K WL
 .S AD=0 F  S AD=$O(^TMP($J,"S",ST,AD)) Q:'+AD  S CS=0 F  S CS=$O(^TMP($J,"S",ST,AD,CS)) Q:'+CS  S TND=^(CS),PTNM=$P(TND,U),PTIEN=$P(TND,U,2),LSTACT=$P(TND,U,3),AWAS1=$P(TND,U,4),AHST1=$P(TND,U,5),SRV=$P(TND,U,6) D  K WL
 ..S STPCLNC="",SC=0 F  S SC=$O(^GMR(123.5,SRV,688,SC)) Q:'+SC  S STPCOD=$P(^GMR(123.5,SRV,688,SC,0),U) I STPCOD'="" S STPCLNC=$P(^DIC(40.7,STPCOD,0),U)_","_STPCLNC
 ..I ST="ACTIVE" D ACTIVE,TOC
 ..I ST="SCHEDULED" D SCHEDULE,TOC
 ..I ST="PENDING" D PENDING,TOC
 ..I ST="PARTIAL RESULTS" D INCMPLTE,KILNODE,TOC
 ..I ST="CANCELLED" D CANCELED,KILNODE,TCC
 ..I ST="DISCONTINUED" D DSCNTUED,KILNODE,TCC
 ..I ST="COMPLETE" D COMPLETE,KILNODE,TCC
 Q
ACTIVE D ACTIVE^GMRCONS1 Q
SCHEDULE D SCHEDULE^GMRCONS1 Q
PENDING D PENDING^GMRCONS1 Q
INCMPLTE D INCMPLTE^GMRCONS1 Q
CANCELED D CANCELED^GMRCONS1 Q
DSCNTUED D DSCNTUED^GMRCONS1 Q
COMPLETE D COMPLETE^GMRCONS1 Q
TOC D TOC^GMRCONS1 Q
TCC D TCC^GMRCONS1 Q
KILNODE D KILNODE^GMRCONS1 Q
 ;
CT ;whole summary
 S LN=0,WDTH=102,PG=1,$P(DSH,"=",WDTH)="",FR=$E(PSD,4,5)_"/"_$E(PSD,6,7)_"/"_$E(PSD,2,3),TO=$E(ED,4,5)_"/"_$E(ED,6,7)_"/"_$E(ED,2,3),PD=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 S SETNOD="SUMMARY From: "_FR_" To "_TO,SETNOD=$$SPC(SETNOD,93),SETNOD=SETNOD_PD D SETNOD
 S SETNOD=DSH D SETNOD S SETNOD=" " D SETNOD
 S PG=PG+1,BB=$O(^TMP($J,"A","")),SUBTOT=0
 S B="",SUM2=0,SUM=0 F  S B=$O(^TMP($J,"A",B)) Q:B=""  S TOT=^(B) I TOT'=0 D:B'="COMPLETE"&(B'="CANCELED")&(B'="DSCNTUED")&(B'="TOC")&(B'="TCC")
 .F TX=1:1 S TEXT=$T(SUMARY+TX),P3=$P(TEXT,";",3) Q:P3=""  I P3[B S SUM=SUM+TOT,SUBTOT=SUBTOT+TOT,SETNOD="    "_$J(TOT,6)_"  "_$P(TEXT,";",4) D SETNOD Q
 S SUM2=SUM2+SUM,SETNOD="----------" D SETNOD S SETNOD=$$SPC("    "_$J(SUM,6),12),SETNOD=SETNOD_"Total OPEN consults" D SETNOD S SETNOD=" " D SETNOD
 S B="",SUM=0 F  S B=$O(^TMP($J,"A",B)) Q:B=""  S TOT=^(B) I TOT'=0 D:B="COMPLETE"!(B="CANCELED")!(B="DSCNTUED")
 .F TX=1:1 S TEXT=$T(SUMARY+TX),P3=$P(TEXT,";",3) Q:P3=""  I P3[B S SUM=SUM+TOT,SETNOD="    "_$J(TOT,6)_"  "_$P(TEXT,";",4) D SETNOD Q
 S SUM2=SUM2+SUM,SETNOD="----------" D SETNOD S SETNOD=$$SPC("    "_$J(SUM,6),12),SETNOD=SETNOD_"Total CLOSED consults" D SETNOD S SETNOD=" " D SETNOD
 S SETNOD="==========" D SETNOD S SETNOD=$$SPC("    "_$J(SUM2,6),12),SETNOD=SETNOD_"GRAND TOTAL" D SETNOD S SETNOD=" " D SETNOD
 Q
SPC(DATA,COL) ;
 N SPC S SPC=DATA,L2=COL,L1=$L(DATA) F L3=1:1:(L2-L1) S SPC=SPC_" "
 Q SPC
 Q
SETNOD ;
 S LN=LN+1,^TMP("GMRCR",$J,"CP",LN,0)=SETNOD,SPC="",VALMCNT=LN
 Q
CT2 ;print clinic summary
 S A="" F  S A=$O(^TMP($J,"B",A)) Q:A=""  S PG=PG+1 D
 .S SETNOD=" " D SETNOD
 .S SETNOD=A_" "_FR_" - "_TO D SETNOD S SETNOD=$$SPC(" ",22),SETNOD=SETNOD_"Consult",SETNOD=$$SPC(SETNOD,63),SETNOD=SETNOD_"Clinic",SETNOD=$$SPC(SETNOD,80),SETNOD=SETNOD_"Appointment",SETNOD=$$SPC(SETNOD,97),SETNOD=SETNOD_"Stop" D SETNOD
 .S SETNOD=$$SPC("Status",22),SETNOD=SETNOD_"Date",SETNOD=$$SPC(SETNOD,32),SETNOD=SETNOD_"SC",SETNOD=$$SPC(SETNOD,37),SETNOD=SETNOD_"L4",SETNOD=$$SPC(SETNOD,42),SETNOD=SETNOD_"Patient",SETNOD=$$SPC(SETNOD,63)
 .S SETNOD=SETNOD_"Appointment",SETNOD=$$SPC(SETNOD,80),SETNOD=SETNOD_"Date/time",SETNOD=$$SPC(SETNOD,97),SETNOD=SETNOD_"Code" D SETNOD S SETNOD=DSH D SETNOD
 .S PG=PG+1,SUM=0,B="" F  S B=$O(^TMP($J,"B",A,B)) Q:B=""  S TOT=^(B) I TOT'=0 D:B'="COMPLETE"&(B'="CANCELED")&(B'="DSCNTUED")&(B'="TOC")&(B'="TCC")
 ..S CNSDT=0 F  S CNSDT=$O(^TMP($J,"B",A,B,CNSDT)) Q:'+CNSDT  S CNSLT=0 F  S CNSLT=$O(^TMP($J,"B",A,B,CNSDT,CNSLT)) Q:'+CNSLT  S CNSLTND=^(CNSLT),PTNM=$P(CNSLTND,U),PRTCNDT=$E(CNSDT,4,5)_"-"_$E(CNSDT,6,7)_"-"_$E(CNSDT,2,3) D
 ...F TX=1:1 S TEXT=$T(SUMARY+TX),P3=$P(TEXT,";",3) Q:P3=""  I P3[B S P4=$P(TEXT,";",4),P6=$P(TEXT,";",6) D
 ....I P6=1 I $D(^SC("AWAS1",CNSLT)) D
 .....S CLINIC=$O(^SC("AWAS1",CNSLT,":"),-1),SDAPT=$O(^SC("AWAS1",CNSLT,CLINIC,":"),-1),STCOD=$P(^SC(CLINIC,0),U,7),STCOD=$P(^DIC(40.7,STCOD,0),U,2),CLINIC=$P(^SC(CLINIC,0),U),SDAPT1=$E(SDAPT,4,5)_"-"_$E(SDAPT,6,7)_"-"_$E(SDAPT,2,3)
 .....S Y=SDAPT D DD^%DT S SDAPTIM=$E($P(Y,"@",2),1,5)
 ....S SETNOD=$$SPC(P4,22),SETNOD=SETNOD_PRTCNDT,SETNOD=$$SPC(SETNOD,32),SETNOD=SETNOD_$P(CNSLTND,U,10),SETNOD=$$SPC(SETNOD,37),SETNOD=SETNOD_$P(CNSLTND,U,9),SETNOD=$$SPC(SETNOD,42),SETNOD=SETNOD_$E(PTNM,1,18),SETNOD=$$SPC(SETNOD,63)
 ....D:P6=1  D SETNOD S SUM=SUM+TOT
 .....S SETNOD=SETNOD_$E(CLINIC,1,15),SETNOD=$$SPC(SETNOD,80),SETNOD=SETNOD_SDAPT1_" @ "_SDAPTIM,SETNOD=$$SPC(SETNOD,98),SETNOD=SETNOD_$E(STCOD,1,5)
 .S SETNOD=" " D SETNOD
 .S BB=$O(^TMP($J,"B",A,"")),SUBTOT=0,SUM2=0,SUM=0,B="" F  S B=$O(^TMP($J,"B",A,B)) Q:B=""  S TOT=^(B) I TOT'=0 D:B'="COMPLETE"&(B'="CANCELED")&(B'="DSCNTUED")&(B'="TOC")&(B'="TCC")
 ..F TX=1:1 S TEXT=$T(SUMARY+TX),P3=$P(TEXT,";",3) Q:P3=""  I P3[B S SUM=SUM+TOT S SUBTOT=SUBTOT+TOT D
 ...S SETNOD="    "_$J(TOT,6)_"  "_$P(TEXT,";",4) D SETNOD Q
 .S SUM2=SUM2+SUM,SETNOD="----------" D SETNOD S SETNOD=$$SPC("    "_$J(SUM,6),12),SETNOD=SETNOD_"Total OPEN consults" D SETNOD S SETNOD=" " D SETNOD
 .S SUM=0,B="" F  S B=$O(^TMP($J,"B",A,B)) Q:B=""  S TOT=^(B) I TOT'=0 D:B="COMPLETE"!(B="CANCELED")!(B="DSCNTUED")
 ..F TX=1:1 S TEXT=$T(SUMARY+TX),P3=$P(TEXT,";",3) Q:P3=""  I P3[B S SUM=SUM+TOT,SETNOD="    "_$J(TOT,6)_"  "_$P(TEXT,";",4) D SETNOD Q
 .S SUM2=SUM2+SUM,SETNOD="----------" D SETNOD S SETNOD=$$SPC("    "_$J(SUM,6),12),SETNOD=SETNOD_"Total CLOSED consults" D SETNOD
 .S SETNOD=" " D SETNOD S SETNOD="==========" D SETNOD
 .S SETNOD=$$SPC("    "_$J(SUM2,6),12),SETNOD=SETNOD_"Total "_A_" consults" D SETNOD S SETNOD=" " D SETNOD
 Q
SUMARY2 ;create the "B" x-reference
 S A="" F  S A=$O(^TMP($J,"A",A)) Q:A=""  S B=0 F  S B=$O(^TMP($J,"A",A,B)) Q:'+B  S C=0 F  S C=$O(^TMP($J,"A",A,B,C)) Q:'+C  S D=0 F  S D=$O(^TMP($J,"A",A,B,C,D)) Q:'+D  S ND=^(D) D
 .S CLNCNM=$P(^GMR(123.5,B,0),U) S ^TMP($J,"B",CLNCNM,A,C,D)=ND,^TMP($J,"C",A,CLNCNM,C,D)=ND S:'($D(^TMP($J,"B",CLNCNM,A))#2) ^TMP($J,"B",CLNCNM,A)=0 S ^TMP($J,"B",CLNCNM,A)=^TMP($J,"B",CLNCNM,A)+1
 Q
