RASTREQ ;HISC/CAH,GJC AISC/MJK-Status Requirements Check Routine ;04 Aug 2017 10:01 AM
 ;;5.0;Radiology/Nuclear Medicine;**1,10,23,40,56,99,90,137**;Mar 16, 1998;Build 4
 ;Supported IA #10104 UP^XLFSTR
 ;Supported IA #1367 LKUP^XPDKEY
 ;Supported IA #10060 ^VA(200
 ;Supported IA #10076 ^XUSEC(
 ;Supported IA #2056 GET1^DIQ and GETS^DIQ
 ; Called by 
 ; (1) Stat Track's [RA STATUS CHANGE]'s fld EXAM STATUS' input transform
 ; (2) ASK+22^RASTED, if user "^" out of stat trk editing
 ; (3) Cancel an Exam's [RA CANCEL]'s fld EXAM STATUS' input transform
 ; (4) Enter Last Past Visit Before DHCP's [RA LAST PAST VISIT]'s ""
 ;
 ; Instead of using RAIMGTY, recalculate
 ; the imaging type using the imaging type on the exam node because
 ; status updating through report entry/edit, batch verify, and several
 ; other options is NOT screened by sign-on imaging type, so does not
 ; stay the same through a user's session.
 ;
 ; 'RAMES1' is used to display which Exam Status required fields are
 ; not populated.  This only applies to the 'Status Tracking Of Exams'
 ; option.
 ;
 ; If tracking ^-out, this rtn would be called outside of edt tmpl,
 ; and thus the DA vars would not be defined, so we need to set them here
 ;
 N RASAVY M RASAVY=Y  ;save the value of Y, patch #90
 S:'$D(DA)#2 DA=RACNI S:'$D(DA(1))#2 DA(1)=RADTI S:'$D(DA(2))#2 DA(2)=RADFN
 ; If Fileman enter/edit, we need to define RADFN, RADTI, RACNI so the
 ; nuc med checks won't bomb
 S:'$D(RACNI)#2 RACNI=DA S:'$D(RADTI)#2 RADTI=DA(1) S:'$D(RADFN)#2 RADFN=DA(2)
 ;
 S RAIMGTYI=+$P($G(^RADPT(DA(2),"DT",DA(1),0)),U,2),RAIMGTYJ=$P($G(^RA(79.2,+RAIMGTYI,0)),U,1),RASAVTYJ=RAIMGTYJ
 S RAMES1="W:$G(K)=$P($G(^RA(72,+$G(RANXT72),0)),U,3)&('$D(ZTQUEUED)#2) !?3,""No '"",RAZ,""'"",?35,"" entered for this exam.""" ; display if at the ranext exm stat level
 S RAXX=+$G(X)
 I '$D(^RA(72,RAXX,0))!(RAIMGTYJ']"") D  M Y=RASAVY Q
 . K X W:'$D(ZTQUEUED)#2 !?3,"Error: cannot determine Imaging Type of exam.  Contact IRM."
 . K RAMES1,RAXX
 . Q
 N RA,RASN,RASTI,RADES,RAOKAY,RA3
 ; RADES = order seq. desired, RAOKAY= actual order seq. okay'd
 S X1=$G(^RA(72,RAXX,0)),RADES=$P(X1,U,3)
 I $$LKUP^XPDKEY(+$P(X1,"^",4))]"",'$D(^XUSEC($$LKUP^XPDKEY(+$P(X1,"^",4)),DUZ)) K X W:'$D(ZTQUEUED)#2 !?3,"You do not have the proper access privileges to ",!?3,"change this exam to this status" M Y=RASAVY Q
 S RAJ=^RADPT(DA(2),"DT",DA(1),"P",DA,0),RAOR=-1
 S RABEFORE=$P($G(^RA(72,+$P(RAJ,U,3),0)),U,3) ; current order seq
 ; Don't need to set RAORDIFN,RACS,RAPRIT,RAF5
 I '$D(^RA(72,"AA",RAIMGTYJ,0,RAXX)) D LOOP^RASTREQ1 S RAIMGTYJ=RASAVTYJ
 I $D(^RA(72,"AA",RAIMGTYJ,0,RAXX)) D CANCEL^RASTREQ1
 S RAIMGTYJ=RASAVTYJ
 ; Can't use X to determine if status change to next was successful
 ; due to looping thru all status levels for this img type
 ; chk if calculated order is at NEXT or higher level
 ; RAAFTER is set in rastreq1; it has 2 meanings :
 ;   upon return from rastreq1, RAAFTER means highest seq order qualified
 ;   upon exit from this rtn,   RAAFTER means actual seq order used
 I RABEFORE<RAAFTER D  G MSG
 . I RADES<RAAFTER S RAOKAY=RADES
 . E  S RAOKAY=RAAFTER
 . Q
 I RAAFTER<RABEFORE D  G MSG
 . I RADES<RAAFTER S RAOKAY=RADES
 . E  S RAOKAY=RAAFTER
 . Q
 ; at this point RAAFTER=RABEFORE
 I RADES<RAAFTER S RAOKAY=RADES
 E  S RAOKAY=RABEFORE
MSG I RAOKAY=RABEFORE K X W:'$D(ZTQUEUED)#2 !?5," ...exam status not changed" G KOUT2
 S X=$O(^RA(72,"AA",RAIMGTYJ,RAOKAY,0))
 S:$D(RANEXT) RANEXT=^RA(72,+X,0) ;set existing RANEXT to ok'd status
 I RAOKAY<RABEFORE W:'$D(ZTQUEUED)#2 !?5," ...exam status backed down to '",$P($G(^RA(72,+X,0)),U),"'" G KOUT2
 I RAOKAY<RADES W:'$D(ZTQUEUED)#2 !!?5," ...though upgraded, new status level (",$P($G(^RA(72,+$O(^RA(72,"AA",RAIMGTYJ,RAOKAY,0)),0)),U),")",!?5,"is not as high as the desired level (",$P($G(^RA(72,+$O(^RA(72,"AA",RAIMGTYJ,RADES,0)),0)),U),")",!
KOUT1 ; check for higher qualifying status(es)
 G:RAOKAY'<RAAFTER!(RAOKAY=9) KOUT2 S RA3=RAOKAY
 W !!,"This case also qualifies for higher status(es) :",!
 F  S RA3=$O(^RA(72,"AA",RAIMGTYJ,RA3)) Q:RA3=""  Q:RA3>RAAFTER  W:'$D(ZTQUEUED)#2 ?$X+4,$P($G(^RA(72,$O(^(RA3,0)),0)),U)
 W:'$D(ZTQUEUED)#2 !!,"Since Status Tracking can only upgrade one status at a time,",!,"please edit this exam again.",!
KOUT2 S RAAFTER=RAOKAY ;return as actual seq order used, not nec. highest
 K RAIMGTYI,RAIMGTYJ,RAMES1,RAZ,RAXX,RAJ,RAS,RAK,RAE,X1,RASAVTYJ
 M Y=RASAVY
 Q
 ;
1 ;Technologist Check
 N DIERR
 S RA("TECH")="" I $O(^RADPT(DA(2),"DT",DA(1),"P",DA,"TC",0))>0 S RA("TECH")=+^($O(^(0)),0) S RA("TECH")=$$GET1^DIQ(200,RA("TECH")_",",.01)
 I RA("TECH")']"" K X S RAZ="technologist" X:$D(RAMES1) RAMES1
 K RA("TECH") Q
 ;
2 ;Interpreting Physician Check
 N DIERR
 I $$GET1^DIQ(200,$P(RAJ,"^",12)_",",.01)="",$$GET1^DIQ(200,$P(RAJ,"^",15)_",",.01)="" K X S RAZ="interpreting staff or resident" X:$D(RAMES1) RAMES1
 Q
 ;
3 ;Detailed Procedure Check
 S RAZ="detailed procedure" I '$D(^RAMIS(71,+$P(RAJ,"^",2),0)) K X X:$D(RAMES1) RAMES1 Q
 S RAJ1=$G(^RAMIS(71,+$P(RAJ,"^",2),0)) I "DS"'[$P(RAJ1,"^",6) K X X:$D(RAMES1) RAMES1 Q
 S RAZ="detailed procedure (no CPT code)" I $P(RAJ1,"^",9)']"" K X X:$D(RAMES1) RAMES1 Q
 Q
 ;
4 ;Film Data Check
 I '$O(^RADPT(DA(2),"DT",DA(1),"P",DA,"F",0)) K X S RAZ="film data" X:$D(RAMES1) RAMES1
 Q
 ;
5 ;Diagnostic Code Check
 I '$D(^RA(78.3,+$P(RAJ,"^",13),0)) K X S RAZ="diagnostic code" X:$D(RAMES1) RAMES1
 Q
 ;
6 ;Camera/Equipment/Room Check
 S RAE=$S($D(RAMDV):$P(RAMDV,"^",9),1:1) I RAE,'$D(^RA(78.6,+$P(RAJ,"^",18),0)) K X S RAZ="camera/equip/room" X:$D(RAMES1) RAMES1
 Q
 ;
11 ;Report Entered and not just a stub rec for Img/PACS Check
 I '$D(^RARPT(+$P(RAJ,"^",17),0)) G NORPT
 ; since there's a rpt ptr, must check if the rpt is just a stub rpt
 N RA17,RA0 ; use logic from RAREG
 S RA17=+$P(RAJ,"^",17)
 I $$STUB^RAEDCN1(RA17) G NORPT ; rpt is an image stub
 Q
NORPT ; either no report yet, or report is stub
 K X S RAZ="report" X:$D(RAMES1) RAMES1
 Q
 ;
12 ;Report Verified Check
 D 11:$P(RAS,"^",11)'="Y" I $D(^RARPT(+$P(RAJ,"^",17),0)),$P(^(0),"^",5)'="V" K X S RAZ="report verification" X:$D(RAMES1) RAMES1
 Q
 ;
16 ;Impression Entry Check
 ; In Phase 1, for Elec. filed rpts, skip this even if div. param requires it
 I $D(^RARPT(+$P(RAJ,"^",17),0)),$P(^(0),"^",5)="EF" Q
 I $O(^RARPT(+$P(RAJ,"^",17),"I",0))'>0 K X S RAZ="impression" X:$D(RAMES1) RAMES1
 Q
13 ;Procedure Modifers Check
 I '$O(^RADPT(DA(2),"DT",DA(1),"P",DA,"M",0)) K X S RAZ="procedure modifier" X:$D(RAMES1) RAMES1
 Q
14 ;CPT Modifiers Check
 I '$O(^RADPT(DA(2),"DT",DA(1),"P",DA,"CMOD",0)) K X S RAZ="CPT modifiers" X:$D(RAMES1) RAMES1
 Q
 ;
32 ;Pregnancy screen check - P137/KLM
 I $$PTSEX^RAUTL8(DA(2))'="F" Q
 N RAPTAGE
 S RAPTAGE=$$PTAGE^RAUTL8(DA(2),"") I ((RAPTAGE<12)!(RAPTAGE>55)) Q
 I $D(^RARPT(+$P(RAJ,"^",17),0)),$P(^(0),"^",5)="EF" D  Q  ;outside report
 .N RAFDA
 .;If this is an outside report and nothing is entered
 .;for pregnancy screen, we stuff a 'u'(unknown) and
 .;'OUTSIDE STUDY' to keep it consistent with the importer.
 .Q:$P(^RADPT(DA(2),"DT",DA(1),"P",DA,0),U,32)]""
 .S RAFDA(70.03,DA_","_DA(1)_","_DA(2)_",",32)="u"
 .S RAFDA(70.03,DA_","_DA(1)_","_DA(2)_",",80)="OUTSIDE STUDY"
 .D FILE^DIE("K","RAFDA")
 .K RAFDA
 .Q  ;end outside report logic
 ;otherwise, if not defined, don't complete
 I $$GET1^DIQ(70.03,DA_","_DA(1)_","_DA(2),32)']"" K X S RAZ="Pregnancy screen" X:$D(RAMES1) RAMES1
 K RAPTAGE
 Q
 ;
HELP ; Called from 'Help Text' node in DD(70.03,3,4).
 N E,RA
 S RAJ=$G(^RADPT(DA(2),"DT",DA(1),"P",DA,0))
 S RAIMGTYI=+$P($G(^RADPT(DA(2),"DT",DA(1),0)),U,2),RAIMGTYJ=$P($G(^RA(79.2,+RAIMGTYI,0)),U,1)
 I RAIMGTYJ']"" W !,"ERROR:  Cannot determine imaging type of exam!" K FL,K,N,RAIMGTYI,RAIMGTYJ,RAS,RAJ Q
 W !,"This exam meets the requirements for the following statuses:"
 F K=0:0 S K=$O(^RA(72,"AA",RAIMGTYJ,K)) Q:K'>0  D
 . S X="",E=+$O(^RA(72,"AA",RAIMGTYJ,K,0)) Q:E'>0
 . I $D(^RA(72,E,0)) D
 .. S RA(0)=$G(^RA(72,E,0)),N=$P(RA(0),U),RAS=$G(^RA(72,E,.1))
 .. I $L(RAS) D HELP1 I $D(X) W !?10,N S FL="" ;removed D 3, done inside HELP1
 .. Q
 . Q
 W:'$D(FL) !?10,"Does not meet the requirements of any status."
 W ! K RAS,RAJ,N,K,FL,RAIMGTYI,RAIMGTYJ
 Q
HELP1 ; Called from 'HELP' above and 'STUFF^RASTREQ1'
 ; 'RAJ' -> 0 node of the examination
 ; 'E'   -> ien of the examination status
 ; Both 'RAJ' & 'E' set in 'HELP' & 'STUFF^RASTREQ1'
 ;
 N RADIO,RADIOUZD,RAS5 S RADIO=$S($G(^RA(72,E,.5))]"":$G(^(.5)),1:"N")
 S:$P($G(^RA(79.2,+RAIMGTYI,0)),"^",5)="Y" RADIOUZD=""
 ;
 ; Phase 1 Outside Reporting 100% outside work, skip all except Diag. Code
 I $D(^RARPT(+$P(RAJ,"^",17),0)),$P(^(0),"^",5)="EF" S RAS5=$P(RAS,U,5),RAS="",$P(RAS,U,5)=RAS5 K RADIOUZD
 ;
 F RAK=1:1 Q:$P(RAS,"^",RAK,99)']""  D:$P(RAS,"^",RAK)="Y" @RAK
 I $D(X),$P(RAS,"^",3)'="Y",$D(^RA(72,"AA",RAIMGTYJ,9,E)) D 3
 I $D(X),$P(RAS,"^",16)'="Y",$D(^RA(72,"AA",RAIMGTYJ,9,E)),$D(^RA(79,+$P(^RADPT(DA(2),"DT",DA(1),0),"^",3),.1)),$P(^(.1),"^",16)="Y" D 16
 I $D(X),$D(^RA(72,"AA",RAIMGTYJ,9,E)) D 32 ;Check Preg screen -P137 /KLM
 I $D(RADIOUZD) D  ;if Radiopharm Used, then check req'd NucMed flds
 . D EN1^RASTREQN(RADIO,RAJ)
 . I $D(X),($$UP^XLFSTR($P($G(^RA(72,E,.6)),"^",11)="Y")) D EN1^RADOSTIK(RADFN,RADTI,RACNI)
 . Q
 Q
