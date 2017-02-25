PSBINJEC ;BIRMINGHAM/GN-LAST INJECTION SITE BROKER ;03/06/16 3:06pm
 ;;3.0;BAR CODE MED ADMIN;**68,83**;Mar 2004;Build 89
 ;
 ; EN^PSJBCMA1/2829
 ;
 ;*83 - Add new parameter to allow return of Inj or Derm site info
 ;    - New XPAR param for dermal site Hist
 ;
 ;*******************************************************************
RPC(RESULTS,DFN,PSBOI,TIME,MAX,SITETYP) ;Get Last MAX Injection/Derm site
 ;   admins per Patient by One Orderable Item or ALL Orderable Items
 ;*******************************************************************
 ;
 ;** Beginning with patch *83 this API will accept a New Site type
 ;   parameter to allow it to return either Injection or Dermal Site
 ;   info.   ** Defaults to older Injection info only if not passed
 ;
 ; Return Array RESULTS
 ;    RESULTS(0)=nn       nn = total admin line items returned
 ;    RESULTS(n)=string   string = returned site data
 ;                          (date/time ^ OI ien ^ OI name ^ site)
 ;                or      string = an error line
 ;                          (-1 ^ error text message)
 ; Input Parameters:
 ;     DFN= Patient IEN
 ;   PSBOI= Orderable Item IEN
 ;    TIME= Time range in hours to look back
 ;     MAX = Maximum injections items to be returned
 ; SITETYP = "I" for Injections or "D" for Dermal.  (I=def)        *83
 ;
 ; ** Note: Time and Max work together, which every is reached first,
 ;          then the search ends and returns what was found thus far.
 ;
 N ACDTE,DOSAGE,DSPIVPB,ENDDTE,INJ,SITE,IVOK,IVTYPE,INTERMIT,MXTIME
 N ORDIT,ORDITNM,ORDNO,PRMPTINJ,QT,QQ,ROUTE,RR,RTBL,STDROUTE,YY
 K RESULTS
 ;Injection or Dermal site type                                   *83
 S SITETYP=$S($G(SITETYP)="":"I",1:SITETYP)      ;def to "I"
 ;
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
 N INDX                                                           ;*83
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
 S INDX=$S(SITETYP="D":"ADERMOI",1:"AINJOI")                      ;*83
 F ACDTE=9999999:0 S ACDTE=$O(^PSB(53.79,INDX,DFN,PSBOI,ACDTE),-1) Q:('ACDTE)!(ACDTE<ENDDTE)  D
 .S INJ=""
 .F  S INJ=$O(^PSB(53.79,INDX,DFN,PSBOI,ACDTE,INJ)) Q:INJ=""!QT  D
 ..S RR=0
 ..F  S RR=$O(^PSB(53.79,INDX,DFN,PSBOI,ACDTE,INJ,RR)) Q:'RR!QT  D
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
 N INDX                                                           ;*83
 ;default the ALL call for Time if less than 1 passed in. Use XPAR
 ;Param TIME shoud be passed in by GUI client with hours, calc if not
 S TIME=+$G(TIME)
 I TIME<1,SITETYP="D" S TIME=$$GET^XPAR("ALL","PSB DERMAL SITE MAX DAYS",,"I")*24    ;for derm convert days to hours  *83
 I TIME<1,SITETYP'="D" S TIME=$$GET^XPAR("ALL","PSB INJECTION SITE MAX HOURS",,"I")                                  ;*83
 S ENDDTE=$$FMADD^XLFDT($$NOW^XLFDT,,-TIME)
 ;
 ;default the ALL call for Max = last 4 Injections
 S MAX=+$G(MAX) I MAX<1 S MAX=9999999
 S (YY,QT)=0
 ;
 ;   Reverse date/time loop thru injection xref, (AINJ), ALL MEDS
 ;
 S INDX=$S(SITETYP="D":"ADERM",1:"AINJ")                          ;*83
 F ACDTE=9999999:0 S ACDTE=$O(^PSB(53.79,INDX,DFN,ACDTE),-1) Q:('ACDTE)!(ACDTE<ENDDTE)  D
 .S INJ=""
 .F  S INJ=$O(^PSB(53.79,INDX,DFN,ACDTE,INJ)) Q:INJ=""!QT  D
 ..S RR=0
 ..F  S RR=$O(^PSB(53.79,INDX,DFN,ACDTE,INJ,RR)) Q:'RR!QT  D
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
 ; h=held,r=refused,n=not given,m=missing dose
 ;*83
 ;  remove code "RM", this is valid action for MRR meds for last site
 I ",H,R,N,M,"[(","_$P(^PSB(53.79,RR,0),U,9)_",") Q 0
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
 I SITETYP="I",'PRMPTINJ!DSPIVPB Q 0                              ;*83
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
 S SITE=$S(SITETYP="D":$$GET1^DIQ(53.79,RR_",",.18),1:$$GET1^DIQ(53.79,RR_",",.16))   ;*83
 ;
 S YY=YY+1
 S RESULTS(YY)=ACDTE_U_ORDIT_U_ORDITNM_U_DOSAGE_U_ROUTE_U_SITE    ;*83
 S RESULTS(0)=YY
 Q
 ;
LASTSITE(DFN,OI) ;Get the last site via LIFO per OI for VDL - Injection/Dermal
 ; Returns the last body site per the Patient and Orderable Item
 ;  If both an Injection site and Dermal site are found per an OI,
 ;  then the site that occurred most recently (last) will be returned.
 ;
 N LI,LINJ,LDER,LSITE
 D RPC^PSBINJEC(.LI,DFN,OI,9999999,1,"I")
 S LINJ=$G(LI(1))
 D RPC^PSBINJEC(.LI,DFN,OI,9999999,1,"D")
 S LDER=$G(LI(1))
 S LSITE=$S($P(LINJ,U)>$P(LDER,U):$P(LINJ,U,6),1:$P(LDER,U,6))
 Q LSITE
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
