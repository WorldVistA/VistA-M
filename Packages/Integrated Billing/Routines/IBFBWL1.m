IBFBWL1 ;ALB/PAW-IB Billing Worklist Main ;30-SEP-2015
 ;;2.0;INTEGRATED BILLING;**554**;21-MAR-94;Build 81
 ;Per VA Directive 6402, this routine should not be modified.
 ;
GETAUT(IBGRP) ; Obtain new invoices, based upon review group
 ;required input IBGRP = 1 (FR) or 2 (SC) or 3 (BI)
 ;output ^TMP("IBFBWL",$J), containing auths for group queue
 N IBA
 S IBA=""
 I IBGRP=1 D LOOP1
 I IBGRP=2 D LOOP2
 I IBGRP=3 D LOOP3
 Q
 ;
LOOP1 ; Loop to create Fee Revenue Worklist
 F  S IBA=$O(^IBFB(360,"FR","FR",IBA)) Q:IBA=""  D
 . D BLDTMP
 Q
 ;
LOOP2 ; Loop to create RUR SC/SA Worklist
 F  S IBA=$O(^IBFB(360,"SC","SC",IBA)) Q:IBA=""  D
 . D BLDTMP
 Q
 ;
LOOP3 ; Loop to create Billing Worklist
 F  S IBA=$O(^IBFB(360,"BI","BI",IBA)) Q:IBA=""  D
 . D BLDTMP
 Q
 ;
BLDTMP ; Build ^TMP("IBFBWL",$J)
 N DFN,IBAUTH,IBFPTP,IBDIV,IBDOB,IBIEN,IBNAME,IBSSN,IBFP,IBST,IBEND
 I '$D(^IBFB(360,IBA)) Q
 S DFN=$$GET1^DIQ(360,IBA_",",.02,"I")
 S IBAUTH=$$GET1^DIQ(360,IBA_",",.03)
 S IBIEN=IBAUTH_","_DFN_","
 S IBDIV=$$GET1^DIQ(161.01,IBIEN,101,"I")
 I IBDIV'="",$D(FILTERS(1)) I '$D(FILTERS(1,IBDIV)) Q  ; If filtering by select divisions
 I IBDIV="",$D(FILTERS(1)) Q  ; Filtering by division, but no division on auth
 I $D(FILTERS(2)) I '$D(FILTERS(2,DFN)) Q  ; If filtering by select patients
 S IBFPTP=$$GET1^DIQ(360,IBA_",",3.02)
 I $P(FILTERS(0),U,4)=1,IBFPTP'=1 Q  ; If filtering by first party
 I $P(FILTERS(0),U,4)=3,IBFPTP=1 Q  ; If filtering by first party
 D DEMOS
 Q
 ;
DEMOS ; Demographics
 N IBFP,IBINV,IBFPNUM,IBSSN,IBST,IBSTK,IBSTL,IBSSX,IBSSLE,IBSSLS,VA,VADM,VAERR
 D DEM^VADPT
 I VAERR K VADM
 S IBNAME=$G(VADM(1)) S:IBNAME="" IBNAME=" "
 S IBDOB=$P($G(VADM(3)),U,1)
 S IBSSX=$P($G(VADM(2)),U,1),IBSSLE=$L(IBSSX),IBSSLS=6 I $E(IBSSX,IBSSLE)="P" S IBSSLS=5
 S IBSSN=$E(IBNAME,1)_$E(IBSSX,IBSSLS,IBSSLE)
 S IBFP=$$GET1^DIQ(161.01,IBIEN_",",.03)  ; NVC
 I IBFP="" S IBFP="UNK"
 S IBST=""
 D GETST^IBFBUTIL(IBA)
 I IBST="" S IBST="UNK"
 ; Sort by DOS (primary), Type (secondary)
 S ^TMP("IBFBWL",$J,IBST,IBFP,IBNAME,DFN,IBAUTH,IBA)=IBNAME_U_IBDOB_U_IBSSN_U_IBFP_U_IBST_U_IBINV
 Q
 ;
BLDWL ; Build Work List Screen
 ; build display lines
 K ^TMP("IBFBWLX",$J)
 N DFN,IBA,IBAUTH,IBFP,IBNAME,IBST,IBXX,FIRST,LINE,VCNT
 S (VALMCNT,FIRST,VCNT)=0
 S IBST=""
 F  S IBST=$O(^TMP("IBFBWL",$J,IBST)) Q:IBST=""  D
 . S IBFP=""
 . F  S IBFP=$O(^TMP("IBFBWL",$J,IBST,IBFP)) Q:IBFP=""  D
 .. S IBNAME=""
 .. F  S IBNAME=$O(^TMP("IBFBWL",$J,IBST,IBFP,IBNAME)) Q:IBNAME=""  D
 ... S FIRST=1
 ... S DFN=""
 ... F  S DFN=$O(^TMP("IBFBWL",$J,IBST,IBFP,IBNAME,DFN)) Q:DFN=""  D
 .... S IBAUTH=""
 .... F  S IBAUTH=$O(^TMP("IBFBWL",$J,IBST,IBFP,IBNAME,DFN,IBAUTH)) Q:IBAUTH=""  D
 ..... S IBA=""
 ..... F  S IBA=$O(^TMP("IBFBWL",$J,IBST,IBFP,IBNAME,DFN,IBAUTH,IBA)) Q:IBA=""  D
 ...... S VCNT=VCNT+1
 ...... S LINE=$$SETL("",VCNT,"",1,4) ;line#
 ...... S IBXX=^TMP("IBFBWL",$J,IBST,IBFP,IBNAME,DFN,IBAUTH,IBA)
 ...... S IBNAME=$P(IBXX,U)
 ...... S LINE=$$SETL(LINE,IBNAME,"",5,23)
 ...... S LINE=$$SETL(LINE,$$FDATE^VALM1($P(IBXX,U,2)),"",28,8)
 ...... S LINE=$$SETL(LINE,$P(IBXX,U,3),"",37,5)
 ...... S LINE=$$SETL(LINE,$P(IBXX,U,4),"",43,10)
 ...... I $P(IBXX,U,4)="CIVIL HOSPITAL" S LINE=LINE_" (INP)"
 ...... I $P(IBXX,U,4)="CONTRACT NURSING HOME" S LINE=LINE_" (SNF)"
 ...... I $P(IBXX,U,5)'="UNK" S LINE=$$SETL(LINE,$$FDATE^VALM1($P(IBXX,U,5)),"",60,8)
 ...... E  S LINE=$$SETL(LINE,"","",60,8)
 ...... S LINE=$$SETL(LINE,$P(IBXX,U,6),"",69,11)
 ...... S VALMCNT=VALMCNT+1
 ...... D SET^VALM10(VALMCNT,LINE,VCNT)
 ...... S ^TMP("IBFBWLX",$J,VCNT)=DFN_U_IBNAME_U_IBAUTH_U_IBA
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
