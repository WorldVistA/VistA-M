PSBINJEC ;BIRMINGHAM/GN-LAST INJECTION SITE BROKER ;4/10/12 8:36am
 ;;3.0;BAR CODE MED ADMIN;**68**;Mar 2004;Build 26
 ;
 ; EN^PSJBCMA1/2829
 ;
 ;*******************************************************************
RPC(RESULTS,DFN,PSBOI,TIME,MAX) ;Get Last MAX Injections per Patient by
 ;                       One Orderable Item or ALL Orderable Items
 ;*******************************************************************
 ;
 ; Return Array RESULTS
 ;    RESULTS(0)=nn       nn = total injection line items returned
 ;    RESULTS(n)=string   string = returned injection data
 ;                          (date/time ^ OI ien ^ OI name ^ Inj site)
 ;                or      string = an error line
 ;                          (-1 ^ error text message)
 ; Input Parameters:
 ;     DFN= Patient IEN
 ;   PSBOI= Orderable Item IEN
 ;    TIME= Time range in hours to look back
 ;     MAX = Maximum injections items to be returned
 ;
 ; ** Note: Time and Max work together, which every is reached first,
 ;          then the search ends and returns what was found thus far.
 ;
 N ACDTE,DOSAGE,DSPIVPB,ENDDTE,INJ,INJSITE,IVOK,IVTYPE,INTERMIT,MXTIME
 N ORDIT,ORDITNM,ORDNO,PRMPTINJ,QT,QQ,ROUTE,RR,RTBL,STDROUTE,YY
 K RESULTS
 I '$G(DFN)!('$D(^DPT(DFN))) D  Q
 . D ERR("Error, DFN missing or invalid (param 1)")
 ;
 ;load valid rotation type injection routes table
 D BLDTBL(.RTBL)
 ;
 D:$G(PSBOI) OI        ;by One specific orderable item
 D:'$G(PSBOI) ALL      ;by All orderable items
 Q
 ;               ======== END RPC MAIN ========
 ;
 ;*******************************************************************
OI ;  Get Last MAX Injections per Patient for one Orderable Item only
 ;*******************************************************************
 ;
 ;default the OI call for Time if less than 1 hour to unlimited
 S TIME=+$G(TIME) I TIME<1 S TIME=9999999
 S ENDDTE=$$FMADD^XLFDT($$NOW^XLFDT,,-TIME)
 ;
 ;default the OI call for Max = last 4
 S MAX=+$G(MAX) I MAX<1 S MAX=4
 S (YY,QT)=0
 ;
 ;   reverse date/time loop thru injection by Med, (AINJOI xref)
 ;
 F ACDTE=9999999:0 S ACDTE=$O(^PSB(53.79,"AINJOI",DFN,PSBOI,ACDTE),-1) Q:('ACDTE)!(ACDTE<ENDDTE)  D
 .S INJ=""
 .F  S INJ=$O(^PSB(53.79,"AINJOI",DFN,PSBOI,ACDTE,INJ)) Q:INJ=""!QT  D
 ..S RR=0
 ..F  S RR=$O(^PSB(53.79,"AINJOI",DFN,PSBOI,ACDTE,INJ,RR)) Q:'RR!QT  D
 ...Q:'$$QUALIFY        ;skip this rec, does not qualify
 ...D ADRESULT          ;add rec to Results as a valid inj site rec
 ...I YY=MAX S QT=1     ;quit, max inj sites found
 ;
 I '$D(RESULTS) D ERR("<<No data to display>>")
 Q
 ;
 ;*************************************************************
ALL ;  Get Last MAX Injections per Patient for any Orderable Item
 ;*************************************************************
 ;
 ;default the ALL call for Time if less than 1 hour to Xpar Max
 S TIME=+$G(TIME)
 I TIME<1 S TIME=$$GET^XPAR("ALL","PSB INJECTION SITE MAX HOURS",,"I")
 S ENDDTE=$$FMADD^XLFDT($$NOW^XLFDT,,-TIME)
 ;
 ;default the ALL call for Max = last 4 Injections
 S MAX=+$G(MAX) I MAX<1 S MAX=9999999
 S (YY,QT)=0
 ;
 ;   Reverse date/time loop thru injection xref, (AINJ), ALL MEDS
 ;
 F ACDTE=9999999:0 S ACDTE=$O(^PSB(53.79,"AINJ",DFN,ACDTE),-1) Q:('ACDTE)!(ACDTE<ENDDTE)  D
 .S INJ=""
 .F  S INJ=$O(^PSB(53.79,"AINJ",DFN,ACDTE,INJ)) Q:INJ=""!QT  D
 ..S RR=0
 ..F  S RR=$O(^PSB(53.79,"AINJ",DFN,ACDTE,INJ,RR)) Q:'RR!QT  D
 ...Q:'$$QUALIFY        ;skip this rec, does not qualify
 ...D ADRESULT          ;add rec to Results as a valid inj site rec
 ...I YY=MAX S QT=1     ;quit, max inj sites found
 ;
 I '$D(RESULTS) D ERR("<<No data to display>>")
 Q
 ;
 ;  ----------------- Supporting Tag calls below ------------------
QUALIFY() ; Determine if a record qualifies as a last Injection Site we want
 ;
 ; Function return: 0 = false, this admin record should not be used
 ;                  1 = true, this admin record shold be used
 ;
 ;Quit false, other than a "given type" for action status
 ; h=held,r=refused,n=not given,rm=removed,m=missing dose
 I ",H,R,N,RM,M,"[(","_$P(^PSB(53.79,RR,0),U,9)_",") Q 0
 ;
 S ORDNO=$P(^PSB(53.79,RR,.1),U)
 K ^TMP("PSJ1",$J)
 D EN^PSJBCMA1(DFN,ORDNO,1)
 S IVTYPE=$P($G(^TMP("PSJ1",$J,0)),U,6)
 S INTERMIT=$P($G(^TMP("PSJ1",$J,0)),U,7)
 S PRMPTINJ=$P($G(^TMP("PSJ1",$J,1,0)),U)
 S DSPIVPB=$P($G(^TMP("PSJ1",$J,1,0)),U,2)
 S ORDIT=$P($G(^TMP("PSJ1",$J,2)),U)
 S ORDITNM=$P($G(^TMP("PSJ1",$J,2)),U,2)
 S ROUTE=$P($G(^TMP("PSJ1",$J,1)),U,13)
 S STDROUTE=$P($G(^TMP("PSJ1",$J,1)),U,14)
 K ^TMP("PSJ1",$J)
 ;
 ;   IV Orders
 ;Quit with T/F, is a valid rotation inj type
 I ORDNO["V" Q $$IVROTATN^PSBINJEC(.RTBL,STDROUTE,IVTYPE,INTERMIT)
 ;
 ;   Unit Dose Orders since not an IV
 ;Quit False, if Prompt for Inj is No OR if display on IVPB is Yes
 I 'PRMPTINJ!DSPIVPB Q 0
 ;
 ;Quit True, is a valid rotation inj type
 Q 1
 ;
ADRESULT ; Add line item to Results array
 ; get last dispense, this one has the dosage given by the nurse
 S DOSAGE=""
 I ORDNO["U" D
 .S QQ=99999999 S QQ=$O(^PSB(53.79,RR,.5,QQ),-1)
 .S:QQ DOSAGE=$P($G(^PSB(53.79,RR,.5,QQ,0)),U,4)
 I ORDNO["V" D
 .S QQ=99999999 S QQ=$O(^PSB(53.79,RR,.6,QQ),-1)
 .S:QQ DOSAGE=$P($G(^PSB(53.79,RR,.6,QQ,0)),U,3)
 S INJSITE=$$GET1^DIQ(53.79,RR_",",.16)
 ;
 S YY=YY+1
 S RESULTS(YY)=ACDTE_U_ORDIT_U_ORDITNM_U_DOSAGE_U_ROUTE_U_INJSITE
 S RESULTS(0)=YY
 Q
 ;
ERR(TXT) ; Error msg handler
 S RESULTS(0)=1
 S RESULTS(1)="-1^"_TXT
 Q
 ;
OK(TXT) ; Success msg handler
 S RESULTS(0)=1
 S RESULTS(1)="1^"_TXT
 Q
 ;
IVROTATN(RTAB,STDRT,IVTY,INT) ;  IV of route and type for injection rotations
 N IVOK S IVOK=0
 I STDRT="" Q IVOK
 I IVTY="S",INT=1 S IVOK=1           ;IV type= Syringe & intermittent
 I IVTY="C",INT=1 S IVOK=1           ;IV type= Chemo & intermittent
 I IVOK,'$D(RTAB(STDRT)) S IVOK=0    ;Std Rte NOT mapped
 Q IVOK
 ;
BLDTBL(TBL) ;  Build Rotation table
 N QQ,RT F QQ=1:1 S RT=$P($T(ROUTES+QQ^PSBINJEC),";;",2) Q:RT="END"  S TBL(RT)=""
 Q
 ;
ROUTES ;  Valid Rotation routes for returning admin record injection data
 ;;INTRADERMAL
 ;;INTRAMUSCULAR
 ;;SUBCUTANEOUS
 ;;END
