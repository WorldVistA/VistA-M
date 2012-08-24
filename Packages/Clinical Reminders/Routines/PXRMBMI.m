PXRMBMI ;SLC/PKR - National BMI and BSA computed finding. ;12/06/2010
 ;;2.0;CLINICAL REMINDERS;**12,18**;Feb 04, 2005;Build 152
 ;================================
BMI(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;Multi-occurrence computed
 ;finding for BMI.
 N BMI,HDATE,HT,IND,TDATE,WHL,WT
 ;Get the list of weight and height measurements.
 D WANDHL(DFN,NGET,BDT,EDT,.NFOUND,.WHL)
 F IND=1:1:NFOUND D
 . S TDATE=$P(WHL(IND),U,1),WT=$P(WHL(IND),U,2)
 . S HT=$P(WHL(IND),U,3),HDATE=$P(WHL(IND),U,4)
 . S TEST(IND)=1,DATE(IND)=TDATE
 . S TEXT(IND)="height measured "_$$EDATE^PXRMDATE(HDATE)
 . S BMI=WT/(HT*HT)
 . S BMI=$FN(BMI,"",1)
 . S (DATA(IND,"VALUE"),DATA(IND,"BMI"))=BMI
 Q
 ;
 ;================================
BSA(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;Multi-occurrence computed
 ;finding for BSA. The coefficients have been adjusted for heights
 ;in cm and weights in kg expect for Boyd where the weight is grams.
 ;The default is to use the Mosteller formula.
 N BSA,FORMULA,HT,IND,TDATE,TYPE,WHL,WT
 S TYPE=$S(TEST="":"M",TEST="M":"M",TEST="D":"D",TEST="H":"H",TEST="G":"G",TEST="B":"B",1:"M")
 S FORMULA=$S(TYPE="M":"Mosteller",TYPE="B":"Boyd",TYPE="D":"DuBois and Dubois",TYPE="H":"Haycock",TYPE="G":"Gehan and George",1:"Mosteller")_" formula"
 ;Get the list of weight and height measurements.
 D WANDHL(DFN,NGET,BDT,EDT,.NFOUND,.WHL)
 F IND=1:1:NFOUND D
 . S TDATE=$P(WHL(IND),U,1),WT=$P(WHL(IND),U,2)
 . S HT=$P(WHL(IND),U,3),HDATE=$P(WHL(IND),U,4)
 . S TEST(IND)=1,DATE(IND)=TDATE
 . I TYPE="M" S BSA=$$SQRT^XLFMTH((WT*HT)/36)
 . I TYPE="D" S BSA=.20247*$$PWR^XLFMTH(HT,.725)*$$PWR^XLFMTH(WT,.425)
 . I TYPE="H" S BSA=.15058*$$PWR^XLFMTH(HT,.3964)*$$PWR^XLFMTH(WT,.5378)
 . I TYPE="G" S BSA=.164*$$PWR^XLFMTH(HT,.42246)*$$PWR^XLFMTH(WT,.51456)
 . I TYPE="B" D
 .. N WEXP
 .. S WT=1000*WT
 .. S WEXP=.7285-(.0188*$$LOG^XLFMTH(WT))
 .. S BSA=.001277*$$PWR^XLFMTH(HT,.3)*$$PWR^XLFMTH(WT,WEXP)
 . S BSA=$FN(BSA,"",2)
 . S (DATA(IND,"VALUE"),DATA(IND,"BSA"))=BSA
 . S TEXT(IND)=FORMULA_", height measured "_$$EDATE^PXRMDATE(HDATE)
 Q
 ;
 ;================================
GHEIGHT(DFN,WDATE,HT,HDATE) ;Return the height measurement taken on the
 ;date closest to WDATE (WDATE is the date of the weight measurement).
 ;If no height is found return -1.
 N BCKDATE,DAS,DIFFL,DIFFS,DONE,FWDDATE,TEMP
 S (DONE,HDATE)=0,HT=-1
 ;Check for height measured on same date and time.
 S DAS=$O(^PXRMINDX(120.5,"PI",DFN,8,WDATE,""))
 I DAS'="" D
 . D GETDATA^PXRMVITL(DAS,.TEMP)
 . I TEMP("RATE")'=+TEMP("RATE") Q
 . S HT=+(TEMP("RATE")*0.0254),HDATE=WDATE,DONE=1
 I 'DONE S (BCKDATE,FWDDATE)=WDATE
 F  Q:DONE  D
 . S BCKDATE=+$O(^PXRMINDX(120.5,"PI",DFN,8,BCKDATE),-1)
 . S FWDDATE=+$O(^PXRMINDX(120.5,"PI",DFN,8,FWDDATE))
 . I (BCKDATE=0),(FWDDATE=0) S DONE=1 Q
 . S DIFFS=$$FMDIFF^XLFDT(WDATE,BCKDATE,2),DIFFL(DIFFS,BCKDATE)=""
 . S DIFFS=$$FMDIFF^XLFDT(FWDDATE,WDATE,2)
 . S DIFFS=$S(DIFFS<0:-DIFFS,1:DIFFS),DIFFL(DIFFS,FWDDATE)=""
 . S DIFFS=$O(DIFFL("")),HDATE=$O(DIFFL(DIFFS,""))
 . I HDATE=0 Q
 . S DAS=$O(^PXRMINDX(120.5,"PI",DFN,8,HDATE,""))
 . D GETDATA^PXRMVITL(DAS,.TEMP)
 . I (TEMP("RATE")'=+TEMP("RATE"))!(TEMP("RATE")=0) K DIFFL(DIFFS,HDATE) Q
 . S HT=+(TEMP("RATE")*0.0254)
 . S DONE=1
 Q
 ;
 ;================================
WANDHL(DFN,NGET,BDT,EDT,NFOUND,WHL) ;Return an ordered and
 ;paired list of weight and height measurements. Weight is in kilograms
 ;and height is in meters.
 N DAS,DIFFL,DIFFS,DONE,HT,HDATE,NOCC
 N SDIR,TDATE,TEMP,WLIST,WT
 S SDIR=$S(NGET>0:-1,1:1)
 S NOCC=$S(NGET>0:NGET,1:-NGET)
 ;Get a list of weight measurements in the date range.
 S TDATE=BDT-.000001
 F  S TDATE=+$O(^PXRMINDX(120.5,"PI",DFN,9,TDATE)) Q:(TDATE=0)!(TDATE>EDT)  D
 . S DAS=$O(^PXRMINDX(120.5,"PI",DFN,9,TDATE,""))
 . S WLIST(TDATE)=DAS
 ;Get up to NOCC BMI values.
 S TDATE="",(DONE,NFOUND)=0
 F  S TDATE=$O(WLIST(TDATE),SDIR) Q:(DONE)!(TDATE="")  D
 . S DAS=WLIST(TDATE)
 . K TEMP
 . D GETDATA^PXRMVITL(DAS,.TEMP)
 . I TEMP("RATE")'=+TEMP("RATE") Q
 . S WT=+TEMP("RATE")*0.4535924
 .;Find the closest height measurement.
 . D GHEIGHT(DFN,TDATE,.HT,.HDATE)
 . I HT=-1 Q
 . S NFOUND=NFOUND+1
 . S WHL(NFOUND)=TDATE_U_WT_U_HT_U_HDATE
 . I NFOUND=NOCC S DONE=1
 Q
 ;
