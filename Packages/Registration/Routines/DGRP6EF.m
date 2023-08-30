DGRP6EF ;ALB/TMK,EG,BAJ,JLS,ARF,JAM,ARF - REGISTRATION SCREEN 6 FIELDS FOR EXPOSURE FACTORS ;05 Feb 2015  11:06 AM
 ;;5.3;Registration;**689,659,737,688,909,1014,1018,1075,1084,1090**;Aug 13,1993;Build 16
 ;
EN(DFN,QUIT) ; Display Environmental exposure factors/allow to edit
 N I,IND,DG321,DG322,DGCT,DIR,Z,X,Y,DIE,DR,DA,DGNONT
 ; Returns QUIT=1 if ^ entered
 ;
EN1 D CLEAR^VALM1
 N DTOUT,DUOUT,TYPE,SEL,L,S,L1,L2,L3,DGELV
 S DG321=$G(^DPT(DFN,.321)),DG322=$G(^DPT(DFN,.322))
 ;
 S DIR(0)="SA^",DGCT=0
 N DGSSNSTR,DGPTYPE,DGSSN,DGDOB ;ARF-DG*5.3*1014 begin - add standardize patient data to the screen banner
 S DGSSNSTR=$$SSNNM^DGRPU(DFN)
 S DGSSN=$P($P(DGSSNSTR,";",2)," ",3)
 S DGDOB=$$GET1^DIQ(2,DFN,.03,"I")
 S DGDOB=$$UP^XLFSTR($$FMTE^XLFDT($E(DGDOB,1,12),1))
 S DGPTYPE=$$GET1^DIQ(391,$$GET1^DIQ(2,DFN_",",391,"I")_",",.01)
 S:DGPTYPE="" DGPTYPE="PATIENT TYPE UNKNOWN"
 S DGCT=DGCT+1,DIR("A",DGCT)=$P(DGSSNSTR,";",1)_$S($$GET1^DIQ(2,DFN,.2405)'="":" ("_$$GET1^DIQ(2,DFN,.2405)_")",1:"")_"    "_DGDOB
 S DGCT=DGCT+1,DIR("A",DGCT)=$S($P($P(DGSSNSTR,";",2)," ",2)'="":$E($P($P(DGSSNSTR,";",2)," ",2),1,40)_"    ",1:"")_DGSSN_"    "_DGPTYPE
 ;S DGCT=DGCT+1,DIR("A",DGCT)=$$SSNNM^DGRPU(DFN) ;ARF-DG*5.3*1014 end
 S DGCT=DGCT+1,DIR("A",DGCT)="",$P(DIR("A",DGCT),"=",81)=""
 S DGCT=DGCT+1,DIR("A",DGCT)=$J("",23)_"**** ENVIRONMENTAL FACTORS ****",DGCT=DGCT+1,DIR("A",DGCT)=" "
 S IND=$S('$G(DGRPV):"[]",1:"<>")
 S DGCT=DGCT+1
 S Z=$E(IND)_"1"_$E(IND,2)
 ; DG*5.3*1075; Set flag if eligibility is Verified and ELIGIBILITY STATUS ENTERED BY (#.3616) field = POSTMASTER
 S DGELV=1 ;DG*5.3*1090 - DGELV is set to 1 to make A/O Exp. and ION no longer editable in VistA regardless of ELIGIBILITY STATUS and ELIGIBILITY STATUS ENTERED BY source
 I $$GET1^DIQ(2,DFN_",",.3611,"I")="V"&($$GET1^DIQ(2,DFN_",",.3616)="POSTMASTER") S DGELV=1
 ; DG*5.3*1075 - If DGELV flag is set, A/O and Rad Exposure (groups 1 and 2) are read-only
 I DGELV S Z="<1>"
 ; "OTHER" choice added DG*5.3*688
 ; variables S,L1,L2, & L3 used for dynamic spacing
 S SEL=$P(DG321,U,13),S=$C(32),($P(L1,S,6),$P(L2,S,$S(SEL="O":3,1:2)),$P(L3,S,3))=""
 ; DG*5.3*1018 - Add Blue Water Navy Value "B"
 ; DG*5.3*1090 - Add THAILAND(U.S. OR ROYAL THAI MIL BASE):"THLD", LAOS:"LAOS", CAMBODIA(MIMOT OR KREK,KAMPONG CHAM): "CAMB", GUAM, AMERICAN SAMOA, OR TERRITORIAL WATERS:"GUAM", JOHNSTON ATOLL:"JHST"
 S TYPE=$S(SEL="B":" (BWN) ",SEL="K":" (DMZ) ",SEL="V":" (VIET)",SEL="O":" (OTH)",SEL="T":" (THLD)",SEL="L":" (LAOS)",SEL="C":" (CAMB)",SEL="G":" (GUAM)",SEL="J":" (JHST)",1:$J("",7))
 S DIR("A",DGCT)=Z_L1_"A/O Exp.: "_$$YN^DGRP6CL(DG321,2)_TYPE_L2_"Reg: "_$$DAT^DGRP6CL(DG321,7,12)_L3_"Exam: "_$$DAT^DGRP6CL(DG321,9,12)
 S Z=$E(IND)_"2"_$E(IND,2)
 I DGELV S Z="<2>"
 S DGCT=DGCT+1,DIR("A",DGCT)=Z_"     ION Rad.: "_$$YN^DGRP6CL(DG321,3)_$J("",8)_"Reg: "_$$DAT^DGRP6CL(DG321,11,12)_"Method: "
 S:$P(DG321,U,12)>10 $P(DG321,U,12)="" S DIR("A",DGCT)=DIR("A",DGCT)_$P($T(SELTBL+$P(DG321,U,12)),";;",2) ;DG*5.3*1090 increased number of RADIATION EXPOSURE METHOD from 7 to 10
 S Z=$E(IND)_"3"_$E(IND,2)
 ;Env Contam name changed to SW Asia Conditions, DG*5.3*688
 S DGCT=DGCT+1,DIR("A",DGCT)=Z_" SW Asia Cond: "_$$YN^DGRP6CL(DG322,13)_$J("",8)_"Reg: "_$$DAT^DGRP6CL(DG322,14,12)_"  Exam: "_$$DAT^DGRP6CL(DG322,15,11)
 S DGNONT=0 I $$GETSTAT^DGNTAPI1(DFN)>2,'$D(^XUSEC("DGNT VERIFY",DUZ)) S DGNONT=1
 I $G(DGRPV) S DGNONT=1
 S DGCT=DGCT+1,DIR("A",DGCT)=$S(DGNONT:"<",1:"[")_"4"_$S(DGNONT:">",1:"]")_"   N/T Radium: " N DGNT S DGRPX=$$GETCUR^DGNTAPI(DFN,"DGNT") S DIR("A",DGCT)=DIR("A",DGCT)_$G(DGNT("INTRP"))
 ;
 ; DG*5.3*909 Display Camp Lejeune info in entirety
 N DG3217CL S DG3217CL=$G(^DPT(DFN,.3217))
 N DGCLE S DGCLE=$$CLE^DGENCLEA(DFN)
 I DGCLE=1,$G(^DPT(DFN,.32171))=1 S DGCLE=0
 S IND=$S('DGCLE:"<>",1:IND)
 S Z=$E(IND)_"5"_$E(IND,2)
 S DGCT=DGCT+1,DIR("A",DGCT)=Z_" Camp Lejeune: "
 S DIR("A",DGCT)=DIR("A",DGCT)_$$YN^DGRP6CL(DG3217CL,1)
 ;
 ; DG*5.3*1075 - If DGELV flag is set display informational message
 ; DG*5.3*1090 - The display informational message has been updated
 I DGELV D
 . S DGCT=DGCT+1,DIR("A",DGCT)=" "
 . S DGCT=DGCT+1,DIR("A",DGCT)="Only VES users may enter/edit Agent Orange or ION Radiation Exposure."
 . S DGCT=DGCT+1,DIR("A",DGCT)=" "
 ;
 S DGCT=DGCT+1,DIR("A",DGCT)=" "
 N DGENDTXT S DGENDTXT=$S(DGNONT&DGCLE:"3,5",DGNONT&'DGCLE:"3",'DGNONT&DGCLE:"5",1:"4")  ; DG*5.3*909 Determine available choices based also on Camp Lejeune eligibility
 S DIR("A")=$S('$G(DGRPV):"SELECT AN ENVIRONMENTAL FACTOR (1-"_DGENDTXT_") OR (Q)UIT: ",1:"PRESS RETURN TO CONTINUE ")  ;DG*5.3*909 Camp Lejeune choice added
 ; DG*5.3*1075 If DGELV flag is set, no edit of groups 1 and 2
 I DGELV S DIR("A")=$S('$G(DGRPV):"SELECT AN ENVIRONMENTAL FACTOR (3-"_DGENDTXT_") OR (Q)UIT: ",1:"PRESS RETURN TO CONTINUE ")
 ;Env Contam name changed to SW Asia Conditions, DG*5.3*688
 S DIR(0)=$S('$G(DGRPV):"SA^1:A/O Exp;2:ION Rad;3:SW Asia Cond;"_$S(DGNONT:"",1:"4:N/T Radium;")_$S(DGCLE:"5:Camp Lejeune;",1:"")_"Q:QUIT",1:"EA")  ; DG*5.3*909 Camp Lejeune choice added
 ; DG*5.3*1075 If DGELV, no edit of groups 1 and 2
 I DGELV S DIR(0)=$S('$G(DGRPV):"SA^3:SW Asia Cond;"_$S(DGNONT:"",1:"4:N/T Radium;")_$S(DGCLE:"5:Camp Lejeune;",1:"")_"Q:QUIT",1:"EA")  ; DG*5.3*909 Camp Lejeune choice added
 I '$G(DGRPV) S DIR("B")="QUIT"
 I 'DGCLE,$G(^DPT(DFN,.32171))=1,$P($G(XQY0),U)'="DG REGISTRATION VIEW" D
 . S DGHECMSG(1)="Camp Lejeune data has been verified by HEC, please "
 . S DGHECMSG(1)=DGHECMSG(1)_"notify the HEC via"
 . S DGHECMSG(2)="the HEC Alert process if changes are required."
 . S DGHECMSG(3)="Press Return key to continue"
 . S DIR("PRE")="I X=5 W !!,DGHECMSG(1),!,DGHECMSG(2),!!,DGHECMSG(3)"
 . S DIR("PRE")=DIR("PRE")_" R *DGANSWER S X="""""
 D ^DIR K DIR,DGANSWER,DGHECMSG
 I $G(DGRPV)!$D(DUOUT)!$D(DTOUT)!(Y="Q") S:Y'="Q" QUIT=1 G QUIT
 S Z="603"_$E("0",2-$L(+Y))_+Y
 S DIE=2,DA=DFN,DR=$P($T(@Z),";;",2)
 ;
 ; DG*5.3*1075;  If editing group 1, A/O data, capture the current value of the AGENT ORANGE EXPOS. INDICATED? (#.32102) field
 N DGAO
 I Y=1 S DGAO=$$GET1^DIQ(2,DFN,.32102,"I")
 ;
 ; DG*5.3*1075;  If editing group 2, Radiation Exposure data, capture the current value of the RADIATION EXPOSURE INDICATED? (#.32103) field
 N DGRAD
 I Y=2 S DGRAD=$$GET1^DIQ(2,DFN,.32103,"I")
 ;
 ; DG*5.3*909 Camp Lejeune logic added
 I Y'=5 D:DR'="" ^DIE
 E  X DR D AUTOUPD^DGENA2(DFN)
 ;
 ; DG*5.3*1075;jam
 ; If DGRAD is defined, editing of the Radiation Exposure data was done. 
 ; If .32103 field was changed to Y, check if RADIATION EXPOSURE METHOD (#.3212) field is blank 
 I $D(DGRAD),DGRAD'="Y",$$GET1^DIQ(2,DFN,.32103,"I")="Y",$$GET1^DIQ(2,DFN,.3212)="" D
 . ; If no Radiation Method defined, set the RADIATION EXPOSURE INDICATED? value back to DGRAD value (or NO if no DGRAD value)
 . I DGRAD="" S DGRAD="N"
 . S DR=".32103///^S X=DGRAD"
 . D ^DIE
 . K DIE,DA,DR
 K DGRAD
 ;
 ; DG*5.3*1075;jam
 ; If DGAO is defined, editing of the AO Exposure data was done. 
 ; If .32102 field was changed to Y, check if AGENT ORANGE EXPOSURE LOCATION (#.3213) field is blank 
 I $D(DGAO),DGAO'="Y",$$GET1^DIQ(2,DFN,.32102,"I")="Y",$$GET1^DIQ(2,DFN,.3213)="" D
 . ; If no location defined, set the AGENT ORANGE EXPOS. INDICATED? value back to DGAO value (or NO if no DGAO value)
 . I DGAO="" S DGAO="N"
 . S DR=".32102///^S X=DGAO"
 . D ^DIE
 K DIE,DA,DR,DGAO
 ;
 G EN1
 ;
QUIT Q
 ;
EF(DFN,LIN) ;
 N DG321,DG322,LENGTH,Z,SEQ
 K LIN S (LENGTH,LIN)=0
 S DG321=$G(^DPT(DFN,.321)),DG322=$G(^(.322))
 I $P(DG321,U,2)="Y" D
 . S Z="A/O Exp.",SEQ=1
 . ;S:'$P(DG321,U,7)!'$P(DG321,U,9)!($P(DG321,U,10)="") Z=Z_"(Incomplete)"
 . S:'$P(DG321,U,7)!('$P(DG321,U,9))="" Z=Z_"(Incomplete)"
 . D SETLNEX^DGRP6(Z,SEQ,.LIN,.LENGTH)
 ;
 I $P(DG321,U,3)="Y" D
 . S Z="Ion Rad.",SEQ=2
 . S:'$P(DG321,U,11)!($P(DG321,U,12)="") Z=Z_"(Incomplete)"
 . D SETLNEX^DGRP6(Z,SEQ,.LIN,.LENGTH)
 ;
 I $P(DG322,U,13)="Y" D
 . I 'LIN S LIN=LIN+1,LIN(LIN)=""
 . ;Env Contam name changed to SW Asia Conditions, DG*5.3*688
 . S Z="SW Asia Cond.",SEQ=3
 . S:'$P(DG322,U,14)!'$P(DG322,U,15) Z=Z_"(Incomplete)"
 . D SETLNEX^DGRP6(Z,SEQ,.LIN,.LENGTH)
 ; N/T Radium Exposure
 N DGNT,DGRPX S DGRPX=$$GETCUR^DGNTAPI(DFN,"DGNT")
 I "NO"'[$G(DGNT("INTRP")) D
 . I 'LIN S LIN=LIN+1,LIN(LIN)=""
 . S SEQ=4 D SETLNEX^DGRP6("N/T Radium ("_$P(DGNT("INTRP"),"YES,",2)_")",SEQ,.LIN,.LENGTH)
 ; DG*5.3*909 Get latest Camp Lejeune information from PATIENT file
 N DG3217CL
 S DG3217CL=$G(^DPT(DFN,.3217))
 I $P(DG3217CL,U,1)="Y" D
 . I 'LIN S LIN=LIN+1,LIN(LIN)=""
 . S Z="Camp Lejeune",SEQ=5
 . D SETLNEX^DGRP6(Z,SEQ,.LIN,.LENGTH)
  Q
  ;
CHKAOEL(DGY) ;DG*5.3*1018;jam; - Screen logic for .3213 (AGENT ORANGE EXPOSURE LOCATION) field in PATIENT file
 ; Returns:  TRUE if the entry DGY is valid
 ;
 ; Only checking B (BLUE WATER NAVY) entry - All other entries are allowed
 I DGY'="B" Q 1
 N DGBWNDT
 ; Allow B to be displayed when BWN ACTIVE DATE (#1402) in MAS PARAMETER file #43 is reached 
 ; - Get the BWN ACTIVE DATE
 S DGBWNDT=$$GET1^DIQ(43,1,1402,"I")
 ; - If active date not defined, return FALSE
 I 'DGBWNDT Q 0
 ; - If active date is in the future, return FALSE
 I DGBWNDT>$$DT^XLFDT Q 0
 Q 1
 ;
 ; The following tag is a table of values.  Do not change location of values including null at SELTBL+0
 ; DG*5.3*1090 - Added ENEWETAK, EXPOS IN PALOMARES B52, and THULE AFB B52 to the SELTBL tag 
SELTBL ;;
 ;;NO VALUE
 ;;HIROSHIMA/NAGASAKI
 ;;ATMOSPHERIC NUCLEAR TEST
 ;;H/N AND ATMOSPHERIC TEST
 ;;UNDERGROUND NUCLEAR TEST
 ;;EXP. AT NUCLEAR FACILITY
 ;;OTHER
 ;;ENEWETAK
 ;;EXPOS IN PALOMARES B52
 ;;THULE AFB B52 
60301 ;;.32102//NO;S:X'="Y" Y="@65";.3213;.32107;.32109;@65;
 ; DG*5.3*1075 - Add "R" to field .3212, making it Required
60302 ;;.32103//NO;S:X'="Y" Y="@66";.3212R;.32111;@66;
60303 ;;.322013//NO;S:X'="Y" Y="@612";.322014;Q;.322015;@612;
60304 ;;D REG^DGNTQ(DFN)
60305 ;;D ADDEDTCL^DGENCLEA(DFN)
 ;;
