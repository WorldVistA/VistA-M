IVMCME5 ;ALB/SEK,KCL,BRM,AEG,BRM,TDM - CHECK INCOME TEST DATA (CON'T.) ; 1/9/03 3:51pm
 ;;2.0;INCOME VERIFICATION MATCH;**17,26,38,49,58,62,67**;21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
 ; This routine is called from IVMCME4.
 ;
MT(STRING,INCOME) ; Calculate means test status
 ;
 ; - init vars
 N X,Y,ADJ,HAR,INC,NET,THRESH,THRESHA,THRESHT,IVMTEXT,XMSUB,CAT,CAT1
 N THRESHG,THRESHV,EXP,NWC,DGMTICYR
 ;DGMTBS - BASE THRESHOLD VALUE FOR SITE
 ;DGMTBH - BASE THRESHOLD VALUE SENT FROM HEC
 ;DGTDEP - TOTAL # OF DEPENDENTS SENT BY HEC.
 N VADM,DGMTBS,DGMTBH,DGTDEP,ECODE,DGMTICY    ;BRM added for IVM*2*26
 ;
 ; - perform initial error checking
 S CAT1=$P(STRING,HLFS,3)
 I '$$GETSTAT^DGMTH(CAT1,1) S ERROR="Invalid Means Test Status" G MTQ
 ;
 S CAT=$P(STRING,HLFS,26)
 ;
 I CAT="" S CAT=CAT1
 I CAT'="A",CAT'="C",CAT'="P",CAT'="G" S ERROR="Invalid Means Test Status for Test-Determined Status" G MTQ
 ;
 ; - if previous yr mt threshold flag is set use date of prev year
 S X=$S($P(STRING,HLFS,11):($E($P(STRING,HLFS,2),1,4)-1),1:$E($P(STRING,HLFS,2),1,4)),DGMTICY=$P($G(STRING),HLFS,2)
 N Y S Y=$$HL7TFM^XLFDT(DGMTICY,"1D") X ^DD("DD") S DGMTICY=Y
 ;
 S %DT="" D ^%DT S X=Y K %DT
 ;
 S THRESH=$G(^DG(43,1,"MT",X,0)),THRESHT=$P(THRESH,U,2),DGMTBS=THRESHT
 I $P(STRING,HLFS,12) S THRESHT=THRESHT+$P(THRESH,U,3)+(($P(STRING,HLFS,12)-1)*$P(THRESH,U,4)),DGTDEP=$P($G(STRING),HLFS,12)
 S DGMTICYR=$$LYR^DGMTSCU1($$HL7TFM^XLFDT($P(STRING,HLFS,2)))
 S THRESHV=$$GMTT(DFN,DGMTICYR,$G(DGTDEP))
 ;
 S INC=$P(STRING,HLFS,4)
 S EXP=$P(STRING,HLFS,9)
 S NET=$P(STRING,HLFS,5)
 S NWC=+$G(^DG(43,1,"GMT"))  ; net worth calculation flag
 S ADJ=$P(STRING,HLFS,6)
 S THRESHA=$P(STRING,HLFS,8),DGMTBH=THRESHA
 S THRESHG=$P(STRING,HLFS,28)
 I $P(STRING,HLFS,12),(THRESHA'=THRESHT) S THRESHA=THRESHA+$P(THRESH,U,3)+(($P(STRING,HLFS,12)-1)*$P(THRESH,U,4))
 S DECLINE=$P(STRING,HLFS,16)
 S HAR=$P(STRING,HLFS,13)
 ;
 ; - perform error checking
 I DECLINE,((CAT="A")!(CAT="G")) S ERROR="Declines to give income info-must be MT Copay Required" G MTQ
 I DECLINE,CAT="C" G MTQ
 ;
 ; - if threshold A is incorrect, send message to sites's IVM MESSAGE
 ;   mail group and continue to process
 I CAT'="G"&(THRESHT'=THRESHA) D
 .;
 .;brm;27apr00;code modifications below to add PID and Name to message
 .D:$G(DFN)'=""
 ..N VAHOW,VAROOT,VAPTYP
 ..D DEM^VADPT
 .S XMSUB="MT threshold discrepancy - "
 .S XMSUB=XMSUB_"PID - "_$P($G(VADM(2)),U,2)
 .S IVMTEXT(1)="While uploading the following income test from HEC a"
 .S IVMTEXT(2)="discrepancy was found with the threshold values."
 .S IVMTEXT(3)="  ",IVMTEXT(4)="   NAME: "_$G(VADM(1))
 .S IVMTEXT(5)="  ",IVMTEXT(6)="   PID : "_$P($G(VADM(2)),"^",2)
 .S IVMTEXT(8)="  ",IVMTEXT(9)="Date of Test sent from HEC: "_DGMTICY
 .S IVMTEXT(10)="  "
 .S IVMTEXT(11)="Site MT Threshold value: "_$J($FN($G(THRESHT),",",0),6)
 .S IVMTEXT(12)="  "
 .S IVMTEXT(13)="HEC Transmitted MT Threshold value: "_$J($FN($G(DGMTBH),",",0),6)
 .S IVMTEXT(14)="  ",IVMTEXT(16)="Total number of dependents: "_$G(DGTDEP)
 .S IVMTEXT(17)="  "
 .;brm;27apr00;end of changes
 .;
 .D MAIL^IVMUFNC("DGMT MT/CT UPLOAD ALERTS")
 .Q
 I (INC-EXP)'>THRESHA D  I ERROR]"" G MTQ
 .I NET']"" S ERROR="This veteran requires net worth" Q
 .I ((NET-EXP)+$S(NWC:0,1:INC)'>$P(THRESH,U,8))&((CAT="C")!(CAT="G")) S ERROR="Income plus net worth not greater than threshold value-incorrect status" Q
 .I ((NET-EXP)+$S(NWC:0,1:INC)>$P(THRESH,U,8))&(CAT="A"),'$P(STRING,HLFS,6) S ERROR="Patient should be adjudicated-no adjudicated date/time" Q
 I (INC-EXP)>THRESHA,CAT'="C",'HAR,'ADJ,CAT'="P",CAT'="G" S ERROR="Incorrect means test status for Test-Determined Status"
MTQ Q
 ;
 ;
CO(STRING) ; Calculate copay test status
 ;
 ; - init vars
 N CAT,CAT1,COPDT,DECLINE,DEDEX,DEP,DGCAT,DGCOPS,DGCOST,INC
 ;
 ; - vars containing ZMT fields
 S COPDT=$$FMDATE^HLFNC($P(STRING,HLFS,2))
 S CAT1=$P(STRING,HLFS,3)
 I '$$GETSTAT^DGMTH(CAT1,2) S ERROR="Invalid Copay Test Status" G COQ
 ;
 ;For the Test-Determined Status only
 ; - a status of E or M or P should be transmitted
 ; - P only is networth is used to determine exemption
 S CAT=$P(STRING,HLFS,26)
 I CAT="" S CAT=CAT1
 I CAT'="E",CAT'="M",CAT'="P" S ERROR="Invalid Copay Test Status for Test-Determined Status" G COQ
 I CAT="P",'$$NETW^IBARXEU1 S ERROR="Invalid Copay Test Status for Test-Determined Status" G COQ
 ;
 ; - a status of E or M or P should be transmitted
 ; - P only is networth is used to determine exemption
 I CAT'="E",CAT'="M",CAT'="P" S ERROR="Invalid Copay Test Status" G COQ
 I CAT="P",'$$NETW^IBARXEU1 S ERROR="Invalid Copay Test Status" G COQ
 S INC=$P(STRING,HLFS,4)
 S DEDEX=$P(STRING,HLFS,9)
 S DEP=$P(STRING,HLFS,12)
 S DECLINE=$P(STRING,HLFS,16)
 ;
 S DGCOST=COPDT_U_DFN_U_U_INC,$P(DGCOST,U,14)=DECLINE,$P(DGCOST,U,15)=DEDEX,$P(DGCOST,U,18)=DEP,$P(DGCOST,U,19)=2
 S DGCOPS=$$INCDT^IBARXEU1(DGCOST)
 S DGCAT=$S(+DGCOPS=1:"E",+DGCOPS=2:"M",+DGCOPS=3:"P",1:"I")
 I CAT'=DGCAT S ERROR="Copay Test Status should be "_DGCAT
COQ Q
 ;
 ;
INC ; Gather income totals
 N DEBD,DEB,DEBT,DGX,EXCL,INC,INCYR,NET,X,Y
 I $P(STRING,HLFS,4)']"",'$$IS^IVMCUC(DFN,DGLY),'$P(STRING,HLFS,16) S ERROR="No Income transmitted"
 S INC=$P(ARRAY("ZIC"),HLFS,21),DEBT=$P(ARRAY("ZIC"),HLFS,22),NET=$P(ARRAY("ZIC"),HLFS,23)
 S DGX=0 F  S DGX=$O(ARRAY(DGX)) Q:'DGX  D
 .S INC=INC+($P(ARRAY(DGX,"ZIC"),HLFS,21))
 .S NET=NET+($P(ARRAY(DGX,"ZIC"),HLFS,23))
 .I $P(ARRAY(DGX,"ZDP"),U,6)'=2 D  Q
 ..S X=$E($P(ARRAY("ZMT"),U,2),1,4),%DT="" D ^%DT S INCYR=Y
 ..S EXCL=$P($G(^DG(43,1,"MT",INCYR,0)),U,17)
 ..S DEBD=($P(ARRAY(DGX,"ZIC"),HLFS,9)-EXCL-$P(ARRAY(DGX,"ZIC"),HLFS,15))
 ..S DEBD=$S(DEBD>0:DEBD,1:0)
 ..S DEB=($P(ARRAY(DGX,"ZIC"),HLFS,9)-DEBD)
 ..S DEBT=DEBT+DEB
 .S DEBT=DEBT+($P(ARRAY(DGX,"ZIC"),HLFS,22))
INCQ Q
 ;
 ;
SIGN ; Date Veteran Signed/Refused to Sign
 I $P(STRING,HLFS,15)]"" D  G:ERROR]"" SIGNQ
 .S X=$P(STRING,HLFS,15) I $E(X,1,4)<1994!($E(X,1,4)>($E(DT,1,3)+1700)) S ERROR="Invalid Date Veteran Signed Test" Q
 .S X=$$FMDATE^HLFNC($P(STRING,HLFS,15)),%DT="X" D ^%DT I Y<0 S ERROR="Invalid Date Veteran Signed Test" Q
SIGNQ Q
 ;
LTC(STRING) ;calculate LTC test status
 ;
 N CAT1
 S CAT1=$P(STRING,HLFS,3)
 I '$$GETSTAT^DGMTH(CAT1,4) S ERROR="Invalid LTC Test Status"
 Q
 ;
GMTT(DFN,DGMTICY,DGTDEP) ;Get GMT Threshold values for veteran
 ; Input:      DFN = Patient IEN
 ;         DGMTICY = Last Income year
 ;          DGTDEP = Total number of dependents
 ;Output:     GMTT = GMT Thresholds for Veteran
 ;
 N DGMTGMT,GMT,GMTT,PCT
 S GMTT=0
 D GETFIPS^EASAILK(DFN,DGMTICY,.GMT)
 I '$G(GMT("GMTIEN")) Q GMTT
 S DGMTGMT=$G(^EAS(712.5,GMT("GMTIEN"),1))
 I (DGTDEP+1)<9 S GMTT=$P(DGMTGMT,"^",(DGTDEP+1)) Q GMTT
 S PCT=((DGTDEP+1)-8)*8+132,GMTT=$P(DGMTGMT,"^",4)*PCT/100
 S GMTT=$S(GMTT#50=0:GMTT,1:GMTT+(50-(GMTT#50)))
 Q GMTT
