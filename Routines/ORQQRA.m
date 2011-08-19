ORQQRA ; slc/CLA - Functions which return patient radiology/nuclear med data ;12/15/97
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9**;Dec 17, 1997
LIST(ORY,ORPT,ORSDT,OREDT,ORMAX) ; return patient's radiological procedures (max. number) between start date/time and end date/time:
 ;ORY: return variable, results are returned in the format: radiology id^
 ;     procedure name^diagnostic code^report status^abnormal flag
 ;ORPT:  patient identifier from Patient File [#2]
 ;ORSDT: start date/time in Fileman format
 ;OREDT: end date/time in Fileman format
 ;ORMAX: maximum number of procedures to return
 N DIFF,ORSRV,ORLOC
 ;
 ;get patient's location flag (INPATIENT ONLY - outpt locations cannot be
 ;reliably determined, and many simultaneous outpt locations can occur):
 I +$G(ORPT)>0 D
 .N DFN S DFN=ORPT,VA200="" D OERR^VADPT
 .I +$G(VAIN(4))>0 S ORLOC=+$G(^DIC(42,+$G(VAIN(4)),44))
 .K VA200,VAIN
 ;
 S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 I '$L($G(ORSDT)) D
 .S DIFF=$$GET^XPAR("USR^LOC.`"_$G(ORLOC)_"^SRV.`"_$G(ORSRV)_"^DIV^SYS^PKG","ORQQRA SEARCH RANGE",1,"E")
 .D DT^DILF("T","T-"_DIFF,.ORSDT,"","")
 .I ORSDT=-1 S ORY(1)="^Error in date range." Q
 I '$L($G(OREDT)) D NOW^%DTC S OREDT=+% K %
 K ^TMP($J,"RAE1")
 D EN1^RAO7PC1(ORPT,ORSDT,OREDT,ORMAX)
 N I,RAID S I=1,RAID=0
 F  S RAID=$O(^TMP($J,"RAE1",+ORPT,RAID)) Q:RAID<1  D
 .S ORY(I)=RAID_"^"_^TMP($J,"RAE1",+ORPT,RAID),I=I+1
 K ^TMP($J,"RAE1")
 Q
DETAIL(Y,PATIENT,INVDT,CASE) ; RETURN DETAILED NARRATIVE FOR A RAD PROC
 N RADID S RADID=PATIENT_"^"_INVDT_"^"_CASE
 K ^TMP($J,"RAE2")
 D EN3^RAO7PC1(RADID)
 N PROC,CASE,I,J,CR S PROC="",CASE="",I=1,J=0,CR=$CHAR(13)
 S CASE=$O(^TMP($J,"RAE2",PATIENT,CASE)) Q:CASE=""  D
 .S PROC=$O(^TMP($J,"RAE2",PATIENT,CASE,PROC)) Q:PROC=""  D
 ..S Y(I)="Procedure: "_PROC_"      Report Status: "_$P(^(PROC),U)
 ..S Y(I)=Y(I)_"        Case No. "_CASE,I=I+1
 ..S Y(I)=CR,I=I+1,Y(I)="Diagnostic Code: "_^(PROC,"D",1),I=I+1
 ..I $G(^TMP($J,"RAE2",PATIENT,CASE,PROC,"I",1))'="" D
 ...S Y(I)=CR,I=I+1,Y(I)="Impression: ",I=I+1
 ...F  S J=$O(^TMP($J,"RAE2",PATIENT,CASE,PROC,"I",J)) Q:J<1  S Y(I)=^(J),I=I+1
 ..I $G(^TMP($J,"RAE2",PATIENT,CASE,PROC,"R",1))'="" D
 ...S Y(I)=CR,I=I+1,Y(I)="Report: ",I=I+1,J=0
 ...F  S J=$O(^TMP($J,"RAE2",PATIENT,CASE,PROC,"R",J)) Q:J<1  S Y(I)=^(J),I=I+1
 ..S Y(I)=CR,I=I+1,Y(I)="Verified by: "_$P($G(^TMP($J,"RAE2",PATIENT,CASE,PROC,"V")),U,2)
 K ^TMP($J,"RAE2")
 Q
SEVEN(Y,PATIENT) ; RETURN PATIENT'S RADIOLOGY PROCEDURES FOR THE PAST SEVEN DAYS
 K ^TMP($J,"RAE7")
 D EN2^RAO7PC1(PATIENT)
 N I,RAID S I=1,RAID=0
 F  S RAID=$O(^TMP($J,"RAE7",+PATIENT,RAID)) Q:RAID<1  D
 .S Y(I)=RAID_"^"_^TMP($J,"RAE7",+PATIENT,RAID),I=I+1
 K ^TMP($J,"RAE7")
 Q
CM(ORQOI) ; extrinic funct. returns contrast media used by the procedure 
 ; and/or if the procedure is a cholecystogram
 ; B = barium, M = unspecified contrast media, C = cholecystogram
 N CMT
 S CMT=$G(^ORD(101.43,ORQOI,"RA"))
 I $L($G(CMT)) S CMT=$P(CMT,U)
 Q CMT
