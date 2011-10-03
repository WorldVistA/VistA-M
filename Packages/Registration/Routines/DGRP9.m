DGRP9 ;ALB/RMO/MIR - Screen 9 - Income Screening Data ;23 JAN 1992 11:00 am
 ;;5.3;Registration;**45,108,487,688**;Aug 13, 1993;Build 29
 ;
EN ;
 ; DVBGUI : CAPRI GUI User
 I $D(DVBGUI) U IO ;If called from CAPRI menu set output device.
 K DGDEP,DGINC,DGREL
 N DGMT,DGEFDT,DGMTED,DGNOBUCK,DGLSTYR,DGMTV
 S DGLSTYR=$E(DT,1,3)+1699
 S DGRPS=9 D H^DGRPU
 D:'DGRPV NEW^DGRPEIS1
 D ALL^DGMTU21(DFN,"VSD",DT,"IPR")
 S DGNOBUCK=$S(DGRPV:0,1:$$NOBUCKS^DGMTU22(DFN,DT))
 S DGMT=$$LST^DGMTU(DFN,DT),DGEFDT=$P(DGMT,U,2)
 ;
 ; If Date of Test returned is not more than a year old, or the MT does not have one of the following statuses:
 ;      MT COPAY EXEMPT          (MT)  A
 ;      MT COPAY REQUIRED        (MT)  C
 ;      EXEMPT                   (CP)  E
 ;      NON-EXEMPT               (CP)  M
 ;      PENDING ADJUDICATION     (CP)  P
 ; or DGNOBUCK=0 (Prior or Current years IAI data does not exist and no dpdnts or spouse exists)
 ; SET date of test for 408.31 records (DGEFDT) to today (create new records)
 S:'((DGEFDT+10000)>DT&("^A^C^P^E^M^"[(U_$P(DGMT,U,4)))&DGNOBUCK) DGEFDT=DT
 S DGISYR=$E($$LYR^DGMTSCU1(DGEFDT),1,3)+1700 ; IS year (Year previous to DGEFDT)
 D:DT'=DGEFDT ALL^DGMTU21(DFN,"VSD",DGEFDT,"IPR") ; Get IAI records if DGEFDT is <DT
 ;
 ; GTS - DG*5.3*688 MT Version
 ; If creating new IAI records for new year (execution transfers when 'E' is entered in EN^DGRPP)
 S:(+$G(DGIAINEW)=1) DGMTV=1
 ; If identifying IAI records for display to user for first time in L/E execution
 I +$G(DGIAINEW)=0 DO
 . ; If MT 408.31 record exists and is for current year, get form of test; if it doesn't exist, 
 . ;   default form to version 1
 . I ($P(DGMT,"^",1)]""),($E($P(DGMT,"^",2),1,3)=$E(DT,1,3)) S DGMTV=+$P($G(^DGMT(408.31,+DGMT,2)),"^",11) ; existing MT version
 . I ($P(DGMT,"^",1)']"")!(($P(DGMT,"^",1)]"")&($E($P(DGMT,"^",2),1,3)'=$E(DT,1,3))) DO
 . . S DGMTV=1 ; Default IS records without MT to version 1 format
 . . ; If Test Date is not current year
 . . I ($P(DGMT,"^",1)]""),($E($P(DGMT,"^",2),1,3)'=$E(DT,1,3)) DO
 . . . ; If test date is less than 1 yr old or test is an active status get the means test version of the test
 . . . ;  and prior yrs IAI recs exist
 . . . I ((DGEFDT+10000)>DT&("^A^C^P^E^M^"[(U_$P(DGMT,U,4)))&DGNOBUCK) S DGMTV=+$P($G(^DGMT(408.31,+DGMT,2)),"^",11)
 . . . ; If test date is more than 1 yr old OR test is NOT an active status or there are no prior yrs IAI recs
 . . . I '((DGEFDT+10000)>DT&("^A^C^P^E^M^"[(U_$P(DGMT,U,4)))&DGNOBUCK) DO
 . . . .I $D(DGINC),($$VER^DGMTUTL3(.DGINC)=0) DO IAICK(DFN,.DGINC)
 . . ;
 . . ; If 408.21 rec's and records are pre Feb '05 format, then convert IS (0) node to version 1
 . . ; If no IS nodes exist or are version 1, do not convert 0 node.  (Entry will be version 1)
 . . I $P(DGMT,"^",1)']"",$D(DGINC),($$VER^DGMTUTL3(.DGINC)=0) DO IAICK(DFN,.DGINC)
 ;
 ; Default DGMTV=1 when entering a new test and IAI records from prior year are not available
 I +DGMT'>0 I '((DGEFDT+10000)>DT&("^A^C^P^E^M^"[(U_$P(DGMT,U,4)))) S DGMTV=1
 ;
 S DGSP=$D(DGREL("S")) ; DGSP = flag ... + if spouse, 0 if not
 D TOT(.DGINC) ;Totals income into DGTOT(x) node (x=V, S, or D)
 D:(+DGMTV=0) DIS ;Display and keep old version 0 MT in 0 form after saving
 D:(+DGMTV=1) DIS1 ;Display and store MT in version 1 format
 K DGTOT,DGIAINEW
 G ^DGRPP
 ;
DIS ;Display income
 D MTCHK
 N DGBL,SCV0
 S SCV0=""
 W !!?34,"Veteran" W:DGSP ?46,"Spouse" W:DGDEP ?56,"Dependents" W ?73,"Total"
 W !?31,"-----------------------------------------------"
 S DGGTOT=0,DGRPW=1 ;initialize grand total variable
 S Z=1 D WW^DGRPV D FLD(.DGTOT,8,"Social Security (Not SSI)")
 S Z=2 D WW^DGRPV D FLD(.DGTOT,9,"U.S. Civil Service")
 S Z=3 D WW^DGRPV D FLD(.DGTOT,10,"U.S. Railroad Retirement")
 S Z=4 D WW^DGRPV D FLD(.DGTOT,11,"Military Retirement")
 S Z=5 D WW^DGRPV D FLD(.DGTOT,12,"Unemployment Compensation")
 S Z=6 D WW^DGRPV D FLD(.DGTOT,13,"Other Retirement")
 S Z=7 D WW^DGRPV D FLD(.DGTOT,14,"Total Employment Income")
 S Z=8 D WW^DGRPV D FLD(.DGTOT,15,"Interest,Dividend,Annuity")
 S Z=9 D WW^DGRPV D FLD(.DGTOT,16,"Workers Comp or Black Lung")
 S Z=10 D WW^DGRPV D FLD(.DGTOT,17,"All Other Income")
 W !,DGBL,DGBL," Total 1-10 -->"," ",$J($$AMT^DGMTSCU1(DGGTOT),12)
 ;
 ;** Patch DG*5.3*108; estimated household income follows
 W !!,DGISYR_" Estimated ""Household"" Taxable Income: "_$S($P(DGTOT("V"),U,21)'="":$$AMT^DGMTSCU1($P(DGTOT("V"),U,21)),1:"")
 Q
 ;
DIS1 ;Display income in version 1 form for screen 9 in Load/Edit.
 D MTCHK
 N DGBL,SCV0
 W !!?34,"Veteran" W:DGSP ?46,"Spouse" W:DGDEP ?56,"Dependents" W ?73,"Total"
 W !?31,"-----------------------------------------------"
 S DGGTOT=0,DGRPW=1 ;initialize grand total variable
 S Z=1 D WW^DGRPV W "  Total Employment Income",!
 D FLD(.DGTOT,14,"   (Wages, Bonuses, Tips):")
 S Z=2 D WW^DGRPV W "  Net Income from Farm,",!
 D FLD(.DGTOT,17,"   Ranch, Property, Bus.:")
 S Z=3 D WW^DGRPV W "  Other Income Amounts",!
 W "     (Soc. Sec., Compensation,",!
 S SCV0=""
 D FLD(.DGTOT,8,"   Pension, Interest, Div.): ")
 K SCV0
 W !,DGBL,DGBL," Total 1-3 -->  "," ",$J($$AMT^DGMTSCU1(DGGTOT),11)
 ;
 ;** Estimated household income follows
 W !!,DGISYR_" Estimated ""Household"" Taxable Income: "_$S($P(DGTOT("V"),U,21)'="":$$AMT^DGMTSCU1($P(DGTOT("V"),U,21)),1:"")
 Q
 ;
FLD(DGIN,DGPCE,DGTXT) ;Display inc. fields
 ; Input:
 ;       DGIN 0 node of #408.21 for vet,spouse, and deps
 ;       DGRPCE as piece
 ;       DGTXT as income desc.
 ;       DGGTOT - If defined keeps running total 
 N DGTOT,I
 I '$D(DGBL) S $P(DGBL," ",26)=""
 W:Z'["10" " "
 W " ",DGTXT,$P(DGBL," ",$L(DGTXT),28)
 W:('$D(SCV0)) $J($$AMT^DGMTSCU1($P(DGIN("V"),"^",DGPCE)),13)
 W:($D(SCV0)) $J($$AMT^DGMTSCU1($P(DGIN("V"),"^",DGPCE)),10)
 W " ",$S($D(DGIN("S")):$J($$AMT^DGMTSCU1($P(DGIN("S"),"^",DGPCE)),10),1:$E(DGBL,1,10))
 W " ",$S($D(DGIN("D")):$J($$AMT^DGMTSCU1($P(DGIN("D"),"^",DGPCE)),11),1:$E(DGBL,1,11))
 S DGTOT="",I="" F  S I=$O(DGIN(I)) Q:I=""  I $P(DGIN(I),"^",DGPCE)]"" S DGTOT=DGTOT+$P(DGIN(I),"^",DGPCE)
 W "  ",$J($$AMT^DGMTSCU1(DGTOT),12)
 I $D(DGGTOT) S DGGTOT=DGGTOT+DGTOT
 Q
 ;
TOT(DGINC,DGDOEXP) ; Totals income
 ; Input
 ;   DGINC(x,ct) where X is V, S, or D and CT(counter)(per ALL^DGMTU21)
 ;   DGDOEXP: IF =1 TOTAL EXPENSE
 ;
 ;Output
 ;   DGTOT(x) where x is V, S, or D and DGTOT(x) = 0 node of #408.21
 ;    (totaled if x is D...total of all deps)
 ;
 N DGCT,NODE,PIECE
 S DGDOEXP=$G(DGDOEXP)
 S DGTOT("V")=""
 F DGTYPE="V","S","D" I $D(DGREL(DGTYPE)) S DGTOT(DGTYPE)="" D
 . S:DGDOEXP&("VS"[DGTYPE) DGEXP(DGTYPE)=$$GET1ND(+$G(DGINC(DGTYPE)))
 . I "VS"[DGTYPE S DGTOT(DGTYPE)=$$GET0ND(+$G(DGINC(DGTYPE))) Q
 . F DGCT=0:0 S DGCT=$O(DGINC(DGTYPE,DGCT)) Q:'DGCT  D
 . . S:DGDOEXP DGEXP(DGTYPE)=$$GET1ND(+$G(DGINC(DGTYPE,DGCT)))
 . . S NODE=$$GET0ND(+DGINC(DGTYPE,DGCT))
 . . F PIECE=8:1:17 I $P(NODE,"^",PIECE)]"" S $P(DGTOT("D"),"^",PIECE)=$P(DGTOT("D"),"^",PIECE)+$P(NODE,"^",PIECE)
 Q
 ;
GET0ND(IEN) ; Returns the 0 node of File #408.21
 Q $G(^DGMT(408.21,IEN,0))
 ;
GET1ND(IEN) ; Returns the 1 node of file #408.21
 Q $G(^DGMT(408.21,IEN,1))
 ;
MTCHK ; Checks if MT/CP is complete for prior calendar year
 ; Input:
 ;    DFN
 ;    DGINR array of income relation for deps
 ;    DGISYR as income screening year
 ;Output:
 ;    DGMTC as MT complete flag (1= yes,2=Non-Mt'd deps exist, 0 o/w)
 ;    DGMTC("S")= Mt complete, but spouse not MTed
 ;    DGMTC("D")= Mt complete, but at least one dep not MT'D
 ;         $D(DGMTED(X,X) if can't edit MT data
 ;
 N DGFL,DGHD,DGMTYPT,DGMTCP,I,X
 S (DGFL,DGMTC)=0 ;initialize flag to 0
 S DGHD="Income data for "_DGISYR_".  "
 I '$D(DGMTV) N DGMTV S DGMTV=1
 S:DGMTV=0 DGRPVV(9)="0000000000"
 S:DGMTV=1 DGRPVV(9)="000"
 I $P($G(^DGMT(408.21,+$G(DGINC("V")),0)),U,18) S DGHD=DGHD_"  [Data Copied - Not Updated]"
 I '$$MTCOMP^DGRPU(DFN,DGEFDT) W !?(40-($L(DGHD)/2)),DGHD Q  ; CP/MT not complete
 S DGMTCP=$S(DGMTYPT=1:"Means",1:"Copay")
 S:DGMTV=0 DGRPVV(9)="1111111111"
 S:DGMTV=1 DGRPVV(9)="111"
 S DGMTC=1,DGMTED("V")=1 S DGHD=DGHD_DGMTCP_" Test is complete for that calendar year!"
 W !?(40-($L(DGHD)/2)),DGHD
 G:DGEFDT'=DT MTCKQT ;NO EDITING AT ALL FOR LAST YEAR
 I $D(DGREL("S")) S DGFL=1 I +$G(^DGMT(408.22,+$G(DGINR("S")),"MT")) S DGMTED("S")=1,DGFL=0
 I DGFL S DGMTC("S")=1 S DGFL=0
 F I=0:0 S I=$O(DGREL("D",I)) Q:'I  S X=+$G(^DGMT(408.22,+$G(DGINR("D",I)),"MT")) S:X DGMTED("D",I)=1 I 'X S DGFL=1
 I DGFL S DGMTC("D")=1
 I $D(DGMTC("S"))!$D(DGMTC("D")) W !,*7," You can only edit these items for dependents who are not "_DGMTCP_" tested!" S DGMTC=2 S:DGMTV=0 DGRPVV(9)="0000000000" S:DGMTV=1 DGRPVV(9)="000" Q
 W !,*7,?12,"This data must be edited through the "_DGMTCP_" test module!"
MTCKQT Q
 ;
 ;; GTS - DG*5.3*688 MT Version
IAICK(DFN,DGINC) ;Check version of IAI recs that don't have assoc. MT and convert version 0 record
 N DGTY,OTHRTST
 S DGTY=$S((+$G(^DGMT(408.21,+DGINC("V"),0))>0):$E(+$G(^DGMT(408.21,+DGINC("V"),0)),1,3)+1,1:$E(DT,1,3))
 ;NOTE: ISCNVRT not executed when - Patient is changed to NSC VET. but PEC remains SC when Copay test exists.
 ;       Changing PEC to SC will exercise ISCNVRT and convert vr 0 IAI rec's to vr 1
 D ISCNVRT^DGMTUTL(.DGINC)
 S OTHRTST=$$UPDTTSTS^DGMTU21(DFN,DGTY) ;Update 2.11 on all (1, 2 and 4 type) 408.31 recs for DFN and IY
 Q
