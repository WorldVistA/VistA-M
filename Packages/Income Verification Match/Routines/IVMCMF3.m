IVMCMF3 ;ALB/RMM - CHECK INCOME TEST DATA (CON'T.) ; 01/02/03
 ;;2.0;INCOME VERIFICATION MATCH;**71,107**;21-OCT-94
 ;
 ;
 ; This routine is called from IVMCMF2.
 ;
MT(STRING,INCOME) ; Calculate means test status
 ; DGMTBS - BASE THRESHOLD VALUE FOR SITE
 ; DGMTBH - BASE THRESHOLD VALUE SENT FROM HEC
 ; DGTDEP - TOTAL # OF DEPENDENTS SENT BY HEC.
 ;
 N X,Y,ADJ,HAR,INC,NET,THRESH,THRESHA,THRESHT,IVMTEXT,XMSUB,CAT,CAT1
 N VADM,DGMTBS,DGMTBH,DGTDEP,DGMTICY,DGMTCMP,DECLINE,DGMTICYR
 S CAT1=$P(STRING,HLFS,3),CAT=$P(STRING,HLFS,26) I CAT="" S CAT=CAT1
 ;
 ; If previous yr mt threshold flag is set use date of prev year
 S X=$S($P(STRING,HLFS,11):($E($P(STRING,HLFS,2),1,4)-1),1:$E($P(STRING,HLFS,2),1,4)),DGMTICY=$P($G(STRING),HLFS,2)
 N Y S Y=$$HL7TFM^XLFDT(DGMTICY,"1D") X ^DD("DD") S DGMTICY=Y
 S %DT="" D ^%DT S X=Y K %DT
 S THRESH=$G(^DG(43,1,"MT",X,0)),THRESHT=$P(THRESH,U,2),DGMTBS=THRESHT
 I $P(STRING,HLFS,12) S THRESHT=THRESHT+$P(THRESH,U,3)+(($P(STRING,HLFS,12)-1)*$P(THRESH,U,4)),DGTDEP=$P($G(STRING),HLFS,12)
 ;
 S INC=$P(STRING,HLFS,4)-$P(STRING,HLFS,9),NET=$P(STRING,HLFS,5)
 S ADJ=$P(STRING,HLFS,6),THRESHA=$P(STRING,HLFS,8),DGMTBH=THRESHA
 I $P(STRING,HLFS,12),(THRESHA'=THRESHT) S THRESHA=THRESHA+$P(THRESH,U,3)+(($P(STRING,HLFS,12)-1)*$P(THRESH,U,4))
 S DECLINE=$P(STRING,HLFS,16),HAR=$P(STRING,HLFS,13),DGMTCMP=+$P(STRING,HLFS,10)
 S DGMTICYR=$$LYR^DGMTSCU1($$HL7TFM^XLFDT($P(STRING,HLFS,2)))
 ;
 ; If Decline to Give Incone Info & MT CP Req, Quit
 I DECLINE,CAT="C" G MTQ
 ;
 ; If threshold A is incorrect, send message to sites's IVM MESSAGE
 ; mail group and continue to process
 I +DGMTBH>0,DGMTCMP>0,(CAT'="G"&(THRESHT'=THRESHA)) D
 .D:$G(DFN)'=""
 ..N VAHOW,VAROOT,VAPTYP
 ..D DEM^VADPT
 .S XMSUB="MT threshold discrepancy - "_"PID - "_$P($G(VADM(2)),U,2)
 .S IVMTEXT(1)="While uploading the following income test from HEC a"
 .S IVMTEXT(2)="discrepancy was found with the threshold A values."
 .S IVMTEXT(3)="  ",IVMTEXT(4)="   NAME: "_$G(VADM(1))
 .S IVMTEXT(5)="  ",IVMTEXT(6)="   PID : "_$P($G(VADM(2)),"^",2)
 .S IVMTEXT(8)="  ",IVMTEXT(9)="Date of Test sent from HEC: "_DGMTICY
 .S IVMTEXT(10)="  "
 .S IVMTEXT(11)="Site MT Threshold value: "_$J($FN($G(THRESHT),",",0),6)
 .S IVMTEXT(12)="  "
 .S IVMTEXT(13)="HEC Transmitted MT Threshold value: "_$J($FN($G(DGMTBH),",",0),6)
 .S IVMTEXT(14)="  ",IVMTEXT(16)="Total number of dependents: "_$G(DGTDEP)
 .S IVMTEXT(17)="  "
 .D MAIL^IVMUFNC("DGMT MT/CT UPLOAD ALERTS")
 .Q
 ;
 I INC'>THRESHA I ((INC+NET)'>$P(THRESH,U,8))&(CAT="C") S CNT=CNT+1,IVMERR(CNT)="Income plus net worth not greater than threshold value-incorrect status"
 I INC>THRESHA,CAT'="C",'HAR,'ADJ,CAT'="P" S CNT=CNT+1,IVMERR(CNT)="Incorrect means test status for Test-Determined Status"
MTQ Q
 ;
 ;
CO(STRING) ; Calculate copay test status
 ;
 ; Variables containing ZMT fields
 N CAT,CAT1,DGCAT,DGCOPS,DGCOST
 S CAT1=$P(STRING,HLFS,3),CAT=$P(STRING,HLFS,26) I CAT="" S CAT=CAT1
 S DGCOST=$$FMDATE^HLFNC($P(STRING,HLFS,2))_U_DFN_U_U_$P(STRING,HLFS,4)_U_U_U_U_U_U_U_U_U_U_$P(STRING,HLFS,16)_U_$P(STRING,HLFS,9)_U_U_U_$P(STRING,HLFS,12)_U_2
 S DGCOPS=$$INCDT^IBARXEU1(DGCOST),DGCAT=$S(+DGCOPS=1:"E",+DGCOPS=2:"M",+DGCOPS=3:"P",1:"I")
 I CAT'=DGCAT S CNT=CNT+1,IVMERR(CNT)="Copay Test Status should be "_DGCAT
COQ Q
