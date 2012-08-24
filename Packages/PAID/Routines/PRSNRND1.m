PRSNRND1 ;WOIFO/DAM - Non Direct Care Summary by Skill Mix II REPORT ;060409
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 ;   
 ; 
GATHER(SKILMIX,GRP,NUROLE,PRSIEN,BEG,END) ;Entry point to gather POC data from 451
 ;INPUT:
 ;   SKILMIX: ARRAY containing totals for various types of work
 ;            subscripted by nurse role (or skill mix)
 ;   GRP: Nurse default location or T&L Unit
 ;   NUROLE: the role (f451.1) of the nurse defined by PRSIEN
 ;           this role will match one of the subscripts in the
 ;           SKILMIX array
 ;   PRSIEN: Nurse ien 450
 ;   BEG,END: FileMan begin and end dates for report
 ;
 N INDEX,CNT,DAYNODE,FMDT,PPIEN,PRSNDAY
 S FMDT=BEG-.1
 S (INDEX,CNT)=0
 F  S FMDT=$O(^PRST(458,"AD",FMDT)) Q:FMDT>END!(FMDT'>0)!STOP  D
 . S DAYNODE=$G(^PRST(458,"AD",FMDT))
 . S PPIEN=+DAYNODE
 . S PRSNDAY=$P(DAYNODE,U,2)
 . K POCD   ;array to hold POC data
 . D L1^PRSNRUT1(.POCD,PPIEN,PRSIEN,PRSNDAY)
 . Q:$G(POCD(0))=0
 . D DATA(.SKILMIX,GRP,NUROLE)
 ;
 Q
 ;
 ;
DATA(SKILMIX,GRP,NUROLE) ;Extract data from POCD array
 ;
 N PRSL,ST,SP,MEAL,HOURS,TT,TIEN,LNG,POC,POC1,WIEN,TW,TWD
 ;
 S PRSL=0
 F  S PRSL=$O(POCD(PRSL)) Q:PRSL'>0  D
 . ;
 . ;Start and stop time and mealtime
 . S ST=$P(POCD(PRSL),U),SP=$P(POCD(PRSL),U,2),MEAL=$P(POCD(PRSL),U,3)
 . ;
 . ;Get elapsed time
 . S HOURS=$$AMT^PRSPSAPU(ST,SP,MEAL)
 . ;
 . ;Type of Time code IEN
 . S (TIEN,LNG)=" "
 . S TT=$P(POCD(PRSL),U,4)
 . I TT'="" D
 . . ;
 . . ;Type of Time code
 . . S TIEN=$O(^PRST(457.3,"B",TT,TIEN))
 . . Q:TIEN=""
 . . ;
 . . ;Description for Type of Time code
 . . S LNG=$P(^PRST(457.3,TIEN,0),U,2)  ;eg, Direct Care, AL
 . ;
 . S POC1=" "
 . S POC=$P(POCD(PRSL),U,5)
 . I POC'="" D
 . . S POC1=$P($$ISACTIVE^PRSNUT01(DT,POC),U,2) ;Location
 . ;
 . ;Type of Work Code IEN
 . S (TW,TWD)=" "
 . S WIEN=$P(POCD(PRSL),U,6)
 . I WIEN'="" D
 . . ;
 . . ;Type of Work Code
 . . S TW=$P(^PRSN(451.5,WIEN,0),U)
 . . ;
 . . ;Description for Type of Work code
 . . S TWD=$P(^PRSN(451.5,WIEN,0),U,2)
 . ;
 . ;save skill mix, hours and type of work into SKILMIX array
 . ;
 . I $G(TW)'="DC" D
 .. S $P(SKILMIX(GRP,TWD,NUROLE),U,1)=$P($G(SKILMIX(GRP,TWD,NUROLE)),U,1)+HOURS
 Q
HDR(EXTBEG,EXTEND) ;Display header for report of Individual Nurse Activity
 ;
 W @IOF
 S PG=PG+1
 W ?17,"NURSE NON DIRECT SUMMARY BY SKILL MIX REPORT"
 W !,?15,EXTBEG_" - "_EXTEND,?45,"Run Date: ",TODAY,?70,"Page: ",$J(PG,3)
 W !         ;blank line
 W !,"Location",?22,"Non Direct",?53,"# of",?60,"# of",?67,"# of",?74,"Total"
 W !,?22,"Care",?53,"Hours",?60,"Hours",?67,"Hours",?74,"Hours"
 W !,?22,"Category",?53,"RN",?60,"LPN",?67,"UAP"
 W !,"--------------------------------------------------------------------------------"
 ;
 Q
PRTLP(EXTBEG,EXTEND) ;Order through SKILMIX array, total data & display
 N RNDC,LNDC,UNDC,GP,TNDC,SKILL,NDCARE
 S GP=0
 F  S GP=$O(SKILMIX(GP)) Q:GP=""!STOP  D
 . S NDCARE=""
 . F  S NDCARE=$O(SKILMIX(GP,NDCARE)) Q:NDCARE=""!STOP  D
 .. S (RNDC,LNDC,UNDC,TNDC)=0
 .. S SKILL=""
 .. F  S SKILL=$O(SKILMIX(GP,NDCARE,SKILL)) Q:SKILL=""!STOP  D
 ... I SKILL["RN" S RNDC=$P(SKILMIX(GP,NDCARE,SKILL),U)+$G(RNDC)
 ... I SKILL["LPN" S LNDC=$P(SKILMIX(GP,NDCARE,SKILL),U)+$G(LNDC)
 ... I SKILL'["RN",SKILL'["LPN" S UNDC=$P(SKILMIX(GP,NDCARE,SKILL),U)+$G(UNDC)
 .. S TNDC=$G(RNDC)+$G(LNDC)+$G(UNDC)  ;total hours
 .. D PPP(.STOP,EXTBEG,EXTEND)
 Q
PPP(STOP,EXTBEG,EXTEND) ;
 W !
 W GP,?22,NDCARE,?53,RNDC,?60,LNDC,?67,UNDC,?74,TNDC
 W !
 I (IOSL-5)<$Y S STOP=$$ASK^PRSLIB00() I 'STOP D HDR(EXTBEG,EXTEND)
 Q
