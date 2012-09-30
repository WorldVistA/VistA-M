PRSNRSM1 ;WOIFO/DAM - Group Work Summary by Skill Mix II REPORT ;060409
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified
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
 N FMDT,INDEX,CNT,DAYNODE,PPIEN,PRSNDAY,POCD
 ;
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
HDR(EXTBEG,EXTEND) ;Display header for report of Individual Nurse Activity
 ;
 W @IOF
 S PG=PG+1
 W ?17,"NURSE GROUP WORK SUMMARY BY SKILL MIX REPORT"
 W !,?15,EXTBEG_" - "_EXTEND,?45,"Run Date: ",TODAY,?70,"Page: ",$J(PG,3)
 W !         ;blank line
 W !,"Grouping",?30,"Direct Care",?45,"Nondirect Care",?65,"Leave Hours"
 W !,?1,"-Skill Mix",?33,"Hours",?49,"Hours"
 W !,"--------------------------------------------------------------------------------"
 ;
 Q
 ;
DATA(SKILMIX,GRP,NUROLE) ;Extract display data from POCD array
 ;
 N PRSL,ST,SP,MEAL,HOURS,TT,TIEN,LNG,POC,POC1,WIEN,TW,TWD
 S STOP=0
 ;
 ;
 S PRSL=0
 F  S PRSL=$O(POCD(PRSL)) Q:PRSL'>0!STOP  D
 . ;Start Time
 . S ST=$P(POCD(PRSL),U)
 . ;
 . ;Stop Time 
 . S SP=$P(POCD(PRSL),U,2)
 . ;
 . ;Meal Time
 . S MEAL=$P(POCD(PRSL),U,3)
 . ;
 . ;Get elapsed time
 . ;
 . S HOURS=$$AMT^PRSPSAPU(ST,SP,MEAL)
 . ;
 . ;Type of Time code IEN
 . S (TIEN,LNG)=""
 . S TT=$P(POCD(PRSL),U,4) I TT'="" D
 . . ;
 . . ;Type of Time code
 . . S TIEN=$O(^PRST(457.3,"B",TT,"")) Q:TIEN=""!STOP
 . . ;
 . . ;Description for Type of Time code
 . . S LNG=$P(^PRST(457.3,TIEN,0),U,2)  ;eg, Direct Care, AL
 . . ;
 . S POC1=""
 . S POC=$P(POCD(PRSL),U,5) I POC'="" D
 . . S POC1=$P($$ISACTIVE^PRSNUT01(DT,POC),U,2) ;Location
 .  ;
 .  ;Type of Work Code IEN
 .  S WIEN=$P(POCD(PRSL),U,6) I WIEN'="" D
 . . ;
 . . ;Type of Work Code
 . . S TW=$P(^PRSN(451.5,WIEN,0),U)
 . . ;
 . . ;Description for Type of Work code
 . . S TWD=$P(^PRSN(451.5,WIEN,0),U,2)
 .
 .;  save skill mix and hours into SKILMIX array
 .  Q:(LNG="")!(POC1="")
 .;
 .;  If we find leave then update totals, otherwise it's work 
 .;  (direct or nondirect) we update.
 .  ;S $P(SKILMIX(NUROLE),U,4)=GRP    ;Nurse default location
 .  I "^HX^AL^AA^DL^ML^RL^SL^CB^AD^WP^"[(U_TT_U) D
 ..    S $P(SKILMIX(GRP,NUROLE),U,3)=$P($G(SKILMIX(GRP,NUROLE)),U,3)+HOURS
 .  E  D
 ..    I $G(TW)="DC" D
 ...      S $P(SKILMIX(GRP,NUROLE),U,1)=$P($G(SKILMIX(GRP,NUROLE)),U,1)+HOURS
 ..    E  D 
 ...      S $P(SKILMIX(GRP,NUROLE),U,2)=$P($G(SKILMIX(GRP,NUROLE)),U,2)+HOURS
 Q
PRTLP(EXTBEG,EXTEND,STOP) ;Order through the SKILMIX array and pull information for display
 N LV,DC,NDC,GP,SKILL
 S GP=0
 F  S GP=$O(SKILMIX(GP)) Q:GP=""!STOP  D
 .  S SKILL=0
 .  F  S SKILL=$O(SKILMIX(GP,SKILL)) Q:SKILL=""!STOP  D
 ..  S LV=$P(SKILMIX(GP,SKILL),U,3)
 ..  S DC=$P(SKILMIX(GP,SKILL),U)
 ..  S NDC=$P(SKILMIX(GP,SKILL),U,2)
 ..  D PPP(EXTBEG,EXTEND,.STOP)
 Q
PPP(EXTBEG,EXTEND,STOP) ;
 W !
 W GP
 W !
 W ?1,"-"_SKILL
 W ?35,DC
 W ?51,NDC
 W ?70,LV
 W !
 ;
 I (IOSL-5)<$Y S STOP=$$ASK^PRSLIB00() I 'STOP D HDR(EXTBEG,EXTEND)
 Q
