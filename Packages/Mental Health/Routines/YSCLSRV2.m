YSCLSRV2 ;DALOI/RLM-Clozapine data server ;APR 24,1990@15:26
 ;;5.01;MENTAL HEALTH;**69,90,92**;Dec 30, 1994;Build 7
 ; Reference to ^%ZOSF supported by IA #10096
 ; Reference to ^DPT supported by IA #10035
 ; Reference to ^DD("DD" supported by IA #10017
 ; Reference to ^PS(55 supported by IA #787
 ; Reference to ^PSDRUG supported by IA #25
 ; Reference to ^PSRX supported by IA #780
 ; Reference to ^VA(200 supported by IA #10060
 ; Reference to $$SITE^VASITE supported by IA #10112
 ; Reference to $$FMTE^XLFDT() supported by IA #10103
 ; Reference to ^PSDRUG supported by IA #221
 ; Reference to ^LAB(60 supported by IA #333
 ; 
REPORT ;send report of current registrations to the Clozapine group on Forum
 S XMRG="",YSCLA=0 F  S YSCLA=$O(^YSCL(603.01,YSCLA)) Q:'YSCLA  S YSCLDTA=$G(^YSCL(603.01,YSCLA,0)) D
  . I YSCLDTA="" S YSCLER="Clozapine Patient List damaged at " D OUT Q
  . S YSCLWB=$P(YSCLDTA,"^",3),YSCLWB=$S(YSCLWB="M":"Monthly",YSCLWB="W":"Weekly",YSCLWB="B":"Bi-weekly",1:"Unknown")
  . S YSCLER=$P(YSCLDTA,"^")_" is assigned to "_$P($G(^DPT($P(YSCLDTA,"^",2),0)),"^")_" ("_$P($G(^DPT($P(YSCLDTA,"^",2),0)),"^",9)_") "_YSCLWB_" at " D OUT
 S YSCLLNT=$G(YSCLLNT)+1,^TMP($J,"YSCLDATA",YSCLLNT)="=========="
 S YSCLLNT=$G(YSCLLNT)+1,^TMP($J,"YSCLDATA",YSCLLNT)="  Linked Tests:"
 S YSCLA=0 F  S YSCLA=$O(^YSCL(603.04,1,1,YSCLA)) Q:'YSCLA  D
  . S YSCLLNT=$G(YSCLLNT)+1,^TMP($J,"YSCLDATA",YSCLLNT)=$P(^LAB(60,$P(^YSCL(603.04,1,1,YSCLA,0),"^",1),0),"^")
  . S YSCLTYPE=$P(^YSCL(603.04,1,1,YSCLA,0),"^",2),YSCLRPT=$P(^YSCL(603.04,1,1,YSCLA,0),"^",3)
  . S YSCLTA="  reports  "_$S(YSCLTYPE="W":"WHITE BLOOD COUNT",YSCLTYPE="A":"ABSOLUTE NEUTROPHIL COUNT",YSCLTYPE="N":"NEUTROPHIL PERCENT",YSCLTYPE="S":"SEGS %",YSCLTYPE="B":"BANDS %",YSCLTYPE="T":"BANDS A",YSCLTYPE="C":"SEGS A")
  . S ^TMP($J,"YSCLDATA",YSCLLNT)=^TMP($J,"YSCLDATA",YSCLLNT)_YSCLTA_"  "_$S(YSCLRPT:"K/units",1:"units")
 S YSCLLNT=$G(YSCLLNT)+1,^TMP($J,"YSCLDATA",YSCLLNT)="=========="
 ;D OPTION^%ZTLOAD("YSCL WEEKLY TRANSMISSION","LIST") D
 ; . S ZTSK="" F  S ZTSK=$O(LIST(ZTSK)) Q:ZTSK=""  D
 ; . . D STAT^%ZTLOAD S YSCLLNT=$G(YSCLLNT)+1,^TMP($J,"YSCLDATA",YSCLLNT)="Local Task # "_ZTSK_" is "_$S('ZTSK(0):" not ",1:"")_"defined with a status of "_ZTSK(2)
 S YSCLLNT=$G(YSCLLNT)+1,^TMP($J,"YSCLDATA",YSCLLNT)="              Run day is: "_$P(^YSCL(603.03,1,0),"^",2)
 S YSCLLNT=$G(YSCLLNT)+1,^TMP($J,"YSCLDATA",YSCLLNT)="           Debug Mode is: "_$S($P(^YSCL(603.03,1,0),"^",3):"On.",1:"Off.")
 S YSCLLNT=$G(YSCLLNT)+1,^TMP($J,"YSCLDATA",YSCLLNT)="Last Run Date (start) is: "_$$FMTE^XLFDT($P(^YSCL(603.03,1,0),"^",4))
 S YSCLLNT=$G(YSCLLNT)+1,^TMP($J,"YSCLDATA",YSCLLNT)=" Last Run Date (stop) is: "_$$FMTE^XLFDT($P(^YSCL(603.03,1,0),"^",5))
 S YSCLLNT=$G(YSCLLNT)+1,^TMP($J,"YSCLDATA",YSCLLNT)="Last Demographic date is: "_$$FMTE^XLFDT($P(^YSCL(603.03,1,0),"^",6))
 Q
OUT S YSCLLNT=$G(YSCLLNT)+1,^TMP($J,"YSCLDATA",YSCLLNT)=XMRG_YSCLER_YSCLST Q
 ;Build the text for the return message here.
REBUILD ;
 S XMRG="",(YSCLA,YSCLLNT)=1 F  S YSCLA=$O(^PS(55,"ASAND1",YSCLA)) W:'$D(ZTQUEUED) "." Q:YSCLA=""  D
  . S YSCLB=$O(^PS(55,"ASAND1",YSCLA,"")) I YSCLB="" S YSCLER=" record is in error (1) at " D OUT Q
  . I '$D(^PS(55,YSCLB,0)) S YSCLER=" record is in error (2) at " D OUT Q
  . S YSCLB=$P(^PS(55,YSCLB,0),"^") I YSCLB="" S YSCLER=" record is in error (3) at " D OUT Q
  . I '$D(^PS(55,YSCLB,"SAND")) S YSCLER=" record is in error (4) at " D OUT Q
  . S DIC="^DPT(",DIC(0)="X",D="SSN",(YSCLSSN,X)=$P(^DPT(YSCLB,0),"^",9)
  . I $D(^YSCL(603.01,"B",YSCLA)) S YSCLX=$O(^YSCL(603.01,"B",YSCLA,"")) S:YSCLX]"" YSCLX=$P(^YSCL(603.01,YSCLX,0),"^",2),YSCLER=" Clozapine # "_YSCLA_" is in use by "_$P($G(^DPT(YSCLX,0)),"^")_" at " D OUT Q
  . D MIX^DIC1 S YSCLPT=+Y I Y=-1 S YSCLER=" could not be added at " D OUT Q
  . K DD S DIC="^YSCL(603.01,",X=YSCLA,DIC("DR")="1////"_YSCLPT K DO D FILE^DICN
  . S YSCLX=$O(^YSCL(603.01,"B",YSCLA,"")) S:YSCLX]"" YSCLX=$P(^YSCL(603.01,YSCLX,0),"^",2),YSCLER=","_YSCLSSN_" assigned to "_$P($G(^DPT(YSCLX,0)),"^")_" at " D OUT
 Q
OVRRID ;Update record with Monthly, Weekly or Bi-weekly status
 F  X XMREC Q:XMER<0  S XMRG=$TR(XMRG,"- ","") D
  . I XMRG'?2U5N1","9N1",".E S YSCLER=" is in error and was not added at " D OUT Q
  . I $P(XMRG,",")'?2U5N S YSCLER=" is not a valid Clozapine number format " D OUT Q
  . I $P(XMRG,",",2)'?9N S YSCLER=" An SSN must be 9 numbers " D OUT Q
  . K %DT S X=$P(XMRG,",",3),%DT="F" D ^%DT I Y=-1 S YSCLER=" is an invalid date, over-ride authorization not filed at " D OUT Q
  . S YSCLOVR=Y
  . S YSCLNM=$P(XMRG,","),YSCLSSN=$P(XMRG,",",2),YSCLWB=$P(XMRG,",",3)
  . I '$D(^YSCL(603.01,"B",YSCLNM)) S YSCLER=" does not exist at " D OUT Q
  . S YSCLDA=$O(^DPT("SSN",YSCLSSN,0))
  . I YSCLDA="" S YSCLER=" SSN does not exist at " D OUT Q
  . I $O(^YSCL(603.01,"B",YSCLNM,0))="" S YSCLER=" SSN not in Clozapine file " D OUT Q
  . I $O(^DPT("SSN",YSCLSSN,YSCLDA)) S YSCLER=" SSN has more than one owner " D OUT Q
  . I $O(^YSCL(603.01,"B",YSCLNM,0))'=$O(^YSCL(603.01,"C",YSCLDA,0)) S YSCLER=" SSN ("_YSCLSSN_","_$P(^DPT(YSCLDA,0),"^")_") has multiple Clozapine Numbers at " D OUT
  . I $O(^YSCL(603.01,"B",YSCLNM,0))=$O(^YSCL(603.01,"C",YSCLDA,0)) D
  . . S YSCLDA1=$O(^YSCL(603.01,"B",YSCLNM,0)) S $P(^YSCL(603.01,YSCLDA1,0),"^",4)=YSCLOVR
  . . S Y=YSCLOVR D DD^%DT S YSCLER=" "_YSCLNM_" ("_$P(^DPT(YSCLDA,0),"^")_") authorized for over-ride on "_Y_" at " D OUT
 G EXIT^YSCLSERV
 ;
CLAPI ;
 F  X XMREC Q:XMER<0  S XMRG=$TR(XMRG,"- ","") D
  . ;Verify that a valid Clozapine number is listed
  . S YSCLDA=$E(XMRG,1,7)
  . I YSCLDA'?2U5N S YSCLER=" is not a valid Clozapine number " D OUT Q
  . S YSCLDA=$O(^YSCL(603.01,"B",YSCLDA,"")),YSCLDA=$P($G(^YSCL(603.01,YSCLDA,0)),"^",2)
  . I 'YSCLDA S YSCLER=" is not in the local database." D OUT Q
  . S YSCLNM=$$CL^YSCLTST2(YSCLDA) S YSCLER=" = "_YSCLNM_" at " D OUT
  . Q
  G EXIT^YSCLSERV
CL1API ;
 F  X XMREC Q:XMER<0  S XMRG=$TR(XMRG,"- ","") D
  . ;Verify that a valid Clozapine number is listed
  . S YSA=$P(XMRG,"^",1),YSCLDA=$P(XMRG,"^",2)
  . I YSCLDA'?2U5N S YSCLER=" is not a valid Clozapine number " D OUT Q
  . S YSCLDA=$O(^YSCL(603.01,"B",YSCLDA,"")),YSCLDA=$P($G(^YSCL(603.01,YSCLDA,0)),"^",2)
  . I 'YSCLDA S YSCLER=" is not in the local database." D OUT Q
  . D CL1^YSCLTST2(YSCLDA,YSA) D
  . . S YSCLDA1="" F  S YSCLDA1=$O(^TMP($J,"PSO",YSCLDA1)) Q:'YSCLDA1  S YSCLER=" = "_YSCLDA_"="_(9999999-YSCLDA1)_" = "_^TMP($J,"PSO",YSCLDA1)_" at " D OUT
  . Q
  G EXIT^YSCLSERV
 Q
DCON ;
 F  X XMREC Q:XMER<0  S XMRG=$TR(XMRG,"- ","") D
  . ;Verify that a valid Clozapine number is listed
  . S (YSA,YSCLDA)=$E(XMRG,1,7)
  . I YSCLDA'?2U5N S YSCLER=" is not a valid Clozapine number " D OUT Q
  . S YSCLDA=$O(^YSCL(603.01,"B",YSCLDA,"")),YSCLDA=$P($G(^YSCL(603.01,YSCLDA,0)),"^",2)
  . I 'YSCLDA S YSCLER=" is not in the local database." D OUT Q
  . I $P(^PS(55,YSCLDA,"SAND"),"^",2)'="D" S YSCLER=YSA_" is not discontinued" D OUT Q
  . S YSCLER=YSA_" was "_$P(^PS(55,YSCLDA,"SAND"),"^",2)_" is now ""A""" D OUT
  . S $P(^PS(55,YSCLDA,"SAND"),"^",2)="A"
ZEOR ;YSCLSRV2
