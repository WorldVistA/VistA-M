IBFBWL5 ;ALB/PAW-IB NVC Precert Worklist Main ;30-SEP-2015
 ;;2.0;INTEGRATED BILLING;**554**;21-MAR-94;Build 81
 ;Per VA Directive 6402, this routine should not be modified.
 ;
GETAUT(IBGRP) ; Obtain new authorizations, based upon review group
 ;required input IBGRP = 1 (IV) or 2 (RUR)
 ;output ^TMP("IBFBWL",$J), containing auths for group queue
 N IBA
 S IBA=""
 I IBGRP=1 D LOOP1
 I IBGRP=2 D LOOP2
 Q
 ;
LOOP1 ; Loop to create Insurance Verification Worklist
 N IBDEL
 F  S IBA=$O(^IBFB(360,"IV","IV",IBA)) Q:IBA=""  D
 . S IBDEL=$$GET1^DIQ(360,IBA_",",.04)
 . I IBDEL'="" Q  ; Check for deleted auth
 . D BLDTMP
 Q
 ;
LOOP2 ; Loop to create RUR Worklist
 N FDA,IBDEL,IBNRD,IENROOT
 F  S IBA=$O(^IBFB(360,"UR","UR",IBA)) Q:IBA=""  D
 . S IBNRD=$$GET1^DIQ(360,IBA_",",3.01,"I")
 . S IBDEL=$$GET1^DIQ(360,IBA_",",.04)
 . I IBDEL'="" Q  ; Check for deleted auth
 . I IBNRD>DT Q  ; RUR Next Review Date in future
 . I IBNRD'<DT D
 .. S IENROOT=""
 .. S FDA(360,IBA_",",3.01)=""
 .. D UPDATE^DIE("","FDA","IENROOT")
 . D BLDTMP
 Q
 ;
BLDTMP ; Build ^TMP("IBFBWL",$J)
 N DFN,IBAUTH,IBCHO,IBCON,IBDIV,IBDOB,IBFBINS,IBIEN,IBNAME,IBSSN,IBFP,IBST,IBEND
 S IBCHO=""
 I '$D(^IBFB(360,IBA)) Q
 S DFN=$$GET1^DIQ(360,IBA_",",.02,"I")
 S IBAUTH=$$GET1^DIQ(360,IBA_",",.03)
 S IBIEN=IBAUTH_","_DFN_","
 S IBST=$$GET1^DIQ(161.01,IBIEN_",",.01,"I")
 S IBFBINS=$$INSURED^IBCNS1(DFN,IBST)  ; Check for active insurance as of auth state date
 Q:'IBFBINS  ; If no active insurance, do not display on worklist
 S IBDIV=$$GET1^DIQ(161.01,IBIEN_",",101,"I")
 I IBDIV'="",$D(FILTERS(1)) I '$D(FILTERS(1,IBDIV)) Q  ; If filtering by select divisions
 I IBDIV="",$D(FILTERS(1)) Q  ; Filtering by division, but no division on auth
 I $D(FILTERS(2)) I '$D(FILTERS(2,DFN)) Q  ; If filtering by select patients
 S IBCON=$$GET1^DIQ(161.01,IBIEN_",",105,"I")  ; Get contract number
 I IBCON S IBCHO=$$GET1^DIQ(161.43,IBCON_",",4) ; Check CHOICE Program Indicator on contract
 I IBCHO="YES" Q  ; Bypass auths with CHOICE contracts
 D DEMOS
 Q
 ;
DEMOS ; Auth Demographics
 N IBEND,IBFP,IBINDT,IBSSN,IBINS0,IBINSCO,IBINS,IBSSX,IBSSLE,IBSSLS,VA,VAERR,VADM
 D DEM^VADPT
 I VAERR K VADM
 S IBNAME=$G(VADM(1)) S:IBNAME="" IBNAME=" "
 S IBSSX=$P($G(VADM(2)),U,1),IBSSLE=$L(IBSSX),IBSSLS=6 I $E(IBSSX,IBSSLE)="P" S IBSSLS=5
 S IBSSN=$E(IBNAME,1)_$E(IBSSX,IBSSLS,IBSSLE)
 S IBFP=$$GET1^DIQ(161.01,IBIEN_",",.03)
 S IBEND=$$GET1^DIQ(161.01,IBIEN_",",.02,"I")
 S IBINDT=IBST
 I IBST="" S IBINDT=DT
 D ALL^IBCNS1(DFN,"IBINS",1,IBINDT,1) ; Sort in COB order - Need highest / PRIMARY
 S IBINS0=$O(IBINS(0))
 S IBINS0=IBINS(IBINS0,0)
 I IBINS0'="" S IBINSCO=$$GET1^DIQ(36,+IBINS0_",",.01)
 I $G(IBINSCO)="" S IBINSCO="UNKNOWN"
 I IBINS0="" S IBINS0=99999999
 ; The next two lines sort for IV (IBGRP=1) or RUR (IBGRP=2)
 ; IV sort is by primary insurance
 ; RUR sort is by auth start date, then primary insurance
 I IBGRP=1 S ^TMP("IBFBWL",$J,IBINSCO,IBNAME,DFN,IBAUTH)=IBNAME_U_IBSSN_U_IBFP_U_IBINSCO_U_IBST_U_IBEND
 I IBGRP=2 S ^TMP("IBFBWL",$J,IBST,IBINSCO,IBNAME,DFN,IBAUTH)=IBNAME_U_IBSSN_U_IBFP_U_IBINSCO_U_IBST_U_IBEND
 Q
 ;
BLDWL ; Build Work List Screen 
 ; Build display lines
 ; Loop by IV (IBGRP=1) or RUR (IBGRP=2) sort
 K ^TMP("IBFBWLX",$J)
 N DFN,IBAUTH,IBINS0,IBNAME,IBXX,FIRST,LINE,VCNT,IBST
 S (VALMCNT,FIRST,VCNT)=0
 I IBGRP=1 D  Q
 . S IBINS0=""
 . F  S IBINS0=$O(^TMP("IBFBWL",$J,IBINS0)) Q:IBINS0=""  D
 .. S IBNAME=""
 .. F  S IBNAME=$O(^TMP("IBFBWL",$J,IBINS0,IBNAME)) Q:IBNAME=""  D
 ... S FIRST=1
 ... S DFN=""
 ... F  S DFN=$O(^TMP("IBFBWL",$J,IBINS0,IBNAME,DFN)) Q:DFN=""  D
 .... S IBAUTH=""
 .... F  S IBAUTH=$O(^TMP("IBFBWL",$J,IBINS0,IBNAME,DFN,IBAUTH)) Q:IBAUTH=""  D
 ..... S VCNT=VCNT+1
 ..... S LINE=$$SETL("",VCNT,"",1,4) ;line#
 ..... S IBXX=^TMP("IBFBWL",$J,IBINS0,IBNAME,DFN,IBAUTH)
 ..... D SETX
 I IBGRP=2 D  Q
 . S IBST=""
 . F  S IBST=$O(^TMP("IBFBWL",$J,IBST)) Q:IBST=""  D
 .. S IBINS0=""
 .. F  S IBINS0=$O(^TMP("IBFBWL",$J,IBST,IBINS0)) Q:IBINS0=""  D
 ... S IBNAME=""
 ... F  S IBNAME=$O(^TMP("IBFBWL",$J,IBST,IBINS0,IBNAME)) Q:IBNAME=""  D
 .... S FIRST=1
 .... S DFN=""
 .... F  S DFN=$O(^TMP("IBFBWL",$J,IBST,IBINS0,IBNAME,DFN)) Q:DFN=""  D
 ..... S IBAUTH=""
 ..... F  S IBAUTH=$O(^TMP("IBFBWL",$J,IBST,IBINS0,IBNAME,DFN,IBAUTH)) Q:IBAUTH=""  D
 ...... S VCNT=VCNT+1
 ...... S LINE=$$SETL("",VCNT,"",1,4) ;line#
 ...... S IBXX=^TMP("IBFBWL",$J,IBST,IBINS0,IBNAME,DFN,IBAUTH)
 ...... D SETX
 Q
 ;
SETL(LINE,DATA,LABEL,COL,LNG) ; Creates a line of data to be set into the body
 ; of the worklist
 ; Input: LINE - Current line being created
 ; DATA - Information to be added to the end of the current line
 ; LABEL - Label to describe the information being added
 ; COL - Column position in line to add information add
 ; LNG - Maximum length of data information to include on the line
 ; Returns: Line updated with added information
 S LINE=LINE_$J("",(COL-$L(LABEL)-$L(LINE)))_LABEL_$E(DATA,1,LNG)
 Q LINE
 ;
SETX ; Set temp global IBFBWLX by VCNT
 S IBNAME=$P(IBXX,U)
 S LINE=$$SETL(LINE,IBNAME,"",5,23)
 S LINE=$$SETL(LINE,$P(IBXX,U,2),"",29,5)
 S LINE=$$SETL(LINE,$P(IBXX,U,3),"",35,10)
 S LINE=$$SETL(LINE,$P(IBXX,U,4),"",46,15)
 I $P(IBXX,U,5)'="" S LINE=$$SETL(LINE,$$FDATE^VALM1($P(IBXX,U,5)),"",62,8)
 I $P(IBXX,U,6)'="" S LINE=$$SETL(LINE,$$FDATE^VALM1($P(IBXX,U,6)),"",71,8)
 S VALMCNT=VALMCNT+1
 D SET^VALM10(VALMCNT,LINE,VCNT)
 S ^TMP("IBFBWLX",$J,VCNT)=DFN_U_IBNAME_U_IBAUTH
 Q
