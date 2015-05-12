PSBOHDR ;BIRMINGHAM/EFC - REPORT HEADERS ;12/12/12 12:12pm
 ;;3.0;BAR CODE MED ADMIN;**5,13,42,74,70,76**;Mar 2004;Build 10
 ;
 ; Reference/IA
 ; EN6^GMRVUTL/1120
 ; WARD^NURSUT5/3052
 ; IN5^VADPT/10061
 ; DEM^VADPT/10061
 ;
 ;*70 - add to heading CLINIC ORDERS ONLY when in clinic exclusive
 ;      mode
 ;    - 1489: Blended PSB*3*74 with PSB*3*70
 ;
PT(DFN,PSBHDR,PSBCONT,PSBDT,SRCHTXT,SUBHD) ;
 ; DFN:     Patient File IEN
 ; PSBCONT: True if this is a continuation page
 ; PSBDT:   Date of Pt Information (Default to DT)
 ; SRCHTXT: User selection list
 ; SUBHD:   Sub heading if present - prints before body === line
 S SRCHTXT=$G(SRCHTXT),SUBHD=$G(SUBHD)    ;*70
 W:$Y>1 @IOF
 W:$X>1 !
 S:'$G(PSBDT) PSBDT=DT
 ; BUILD PSBHDR WITH ALL HEADER STUFF
 D:'$D(PSBHDR("NAME"))
 .S VAIP("D")="LAST"
 .D DEM^VADPT,IN5^VADPT
 .S PSBHDR("NAME")=VADM(1)
 .S PSBHDR("SSN")=VA("PID")
 .S PSBHDR("DOB")=$P(VADM(3),U,2)
 .S PSBHDR("AGE")=VADM(4)
 .S PSBHDR("SEX")=$P(VADM(5),U,2)
 .S PSBHDR("MVMTTYPE")=$P(VAIP(2),U,2)
 .S PSBHDR("MVMTLAST")=$P(VAIP(3),U,2)
 .S PSBHDR("WARD")=$P(VAIP(5),U,2)
 .S PSBHDR("ROOM")=$P(VAIP(6),U,2)
 .S PSBHDR("DX")=VAIP(9)
 .K VAIP,VADM,VA
 .;
 .;IHS/MSC/PLS - Call Vitals lookup based on agency code
 .;  and PCC Vitals package usage flag "BEHOVM USE VMSR"=1
 .I $G(DUZ("AG"))="I",$$GET^XPAR("ALL","BEHOVM USE VMSR") D
 ..S X=+$P($$VITAL^APSPFUNC(DFN,"HT"),U,2)
 ..S X=$$VITCHT^APSPFUNC(X)\1,PSBHDR("HEIGHT")=$S(X:X_"cm",1:"*")
 ..S X=+$P($$VITAL^APSPFUNC(DFN,"WT"),U,2)
 ..S X=$$VITCWT^APSPFUNC(X)\1,PSBHDR("WEIGHT")=$S(X:X_"kg",1:"*")
 .E  D
 ..S GMRVSTR="HT" D EN6^GMRVUTL
 ..S X=+$P(X,U,8) S:X X=$J((X*2.54),3,0) S PSBHDR("HEIGHT")=$S(X:X_"cm",1:"*") ;Rounding correction, PSB*3*76
 ..S GMRVSTR="WT" D EN6^GMRVUTL
 ..S X=+$P(X,U,8) S:X X=$J(X/2.2,0,2) S PSBHDR("WEIGHT")=$S(X:X_"kg",1:"*") ;Rounding correction, PSB*3*76
 .;
 .N PSBADRX D ALLR^PSBALL(.PSBADRX,DFN) S X=0,Y=""
 .F  S X=$O(PSBADRX(X)) Q:'X  D
 ..Q:$P(PSBADRX(X),U,1)'="ADR"  S Z=$P(PSBADRX(X),U,2) Q:Z=""
 ..I $L(Y_Z)>(IOM-22) S PSBHDR("REAC",$O(PSBHDR("REAC",""),-1)+1)=Y,Y=""
 ..S Y=Y_$S(Y]"":", ",1:"")_$P(PSBADRX(X),U,2)
 .S:Y]"" PSBHDR("REAC",$O(PSBHDR("REAC",""),-1)+1)=Y
 .I '$D(PSBHDR("REAC")) S PSBHDR("REAC",1)="No ADRs on file."
 .D PSBALG
 .K GMRAL,GMRVSTR,GMRA,PSBARX
 .D NOW^%DTC S Y=+$E(%,1,12) D D^DIQ S PSBHDR("DATE")="Run Date: "_Y
 .S PSBHDR("PAGE")=0
 ;
 W $C(13),$TR($J("",IOM)," ","=")
 ;*70 insert across the board, a heading line base on the order mode
 ;    write line after the report name.  Some reports use PSBHDR(0)
 ;    for report name others use PSBHDR(1).
 W !,$G(PSBHDR(0))
 ; the DO report should not try to print a mode heading *70
 N DORPT S DORPT=$S($P(PSBRPT(0),"-")="DO":1,1:0)
 ;
 S PSBMODE=$S(PSBCLINORD=1:"Include Clinic Orders Only",PSBCLINORD=0:"Include Inpatient Orders Only",1:"Include Inpatient and Clinic Orders")   ;*70
 I 'DORPT,$G(PSBHDR(1))]"",$G(PSBHDR(0))]"" W !,PSBMODE           ;*70
 W !,$G(PSBHDR(1)),?(IOM-$L(PSBHDR("DATE"))),PSBHDR("DATE")
 S PSBHDR("PAGE")=PSBHDR("PAGE")+1
 I 'DORPT,$G(PSBHDR(1))]"",$G(PSBHDR(0))="" W !,PSBMODE           ;*70
 W !,$G(PSBHDR(2)),?(IOM-10),$J("Page: "_PSBHDR("PAGE"),10)
 F X=3:1 Q:'$D(PSBHDR(X))  D      ; More Lines If Needed          ;*70
 . W !,PSBHDR(X)
 . I PSBHDR(X)["Clinic Search" W $$WRAP^PSBO(21,111,SRCHTXT)
 . I PSBHDR(X)["Ward Location" W SRCHTXT
 I $G(PSBCONT) W !?(IOM-35\2),"*** CONTINUED FROM PREVIOUS PAGE ***"
 W !!,"Patient:",?10,PSBHDR("NAME")
 W ?42,$$GET^XPAR("ALL","PSB PATIENT ID LABEL")_":",?53,PSBHDR("SSN")
 W ?76,"DOB:",?83,PSBHDR("DOB")," (",PSBHDR("AGE"),")"
 D:'$G(PSBCONT)
 .W !,"Sex: ",?10,PSBHDR("SEX"),?42,"Ht/Wt:",?53,PSBHDR("HEIGHT"),"/",PSBHDR("WEIGHT"),?76,"Ward: ",?83,PSBHDR("WARD")," Rm: ",PSBHDR("ROOM")           ;added colon to Rm, PSB*3*74   [1489]
 .W !,"Dx:",?10,PSBHDR("DX"),?42,"Last Mvmt:",?53,PSBHDR("MVMTLAST"),?76,"Type:",?83,PSBHDR("MVMTTYPE")
 .; Reactions/Allergies
 .W !!,"ADRs:"
 .F X=0:0 S X=$O(PSBHDR("REAC",X)) Q:'X  W:$X>12 ! W ?12,PSBHDR("REAC",X)
 .W !!,"Allergies:"
 .F X=0:0 S X=$O(PSBHDR("ALERGY",X)) Q:'X  W:$X>12 ! W ?12,PSBHDR("ALERGY",X)
 .; Local Mods Allowed Here and showup only on First Page
 .; Immunizations
 .;D SHOT80^ASFSHOTF
 W:SUBHD]"" !!,SUBHD
 W !,$TR($J("",IOM)," ","=")
 Q
 ;
WARD(PSBWP,PSBHDR,PSBCONT,PSBDT,SRCHTXT) ; 
 ; PSBWP:   Nurse Location File IEN
 ; PSBCONT: True if this is a continuation page
 ; PSBDT:   Date of Pt Information (Default to DT)
 N PSBWRDA
 S:'$G(PSBDT) PSBDT=DT
 I '$D(PSBHDR("DATE")) D NOW^%DTC S Y=+$E(%,1,12) D D^DIQ S PSBHDR("DATE")="Run Date: "_Y
 S:'$D(PSBHDR("PAGE")) PSBHDR("PAGE")=0
 W:$Y>1 @IOF
 W:$X>0 !
 W $TR($J("",IOM)," ","=")
 ;*70 Insert all reports, a heading line based on the order mode.
 ;    Write line after the report name.  Some reports use PSBHDR(0)
 ;    for report name, others use PSBHDR(1).
 W !,$G(PSBHDR(0))
 S PSBMODE=$S(PSBCLINORD=1:"Include Clinic Orders Only",PSBCLINORD=0:"Include Inpatient Orders Only",1:"Include Inpatient and Clinic Orders")        ;*70
 I $G(PSBHDR(0))]"" W !,PSBMODE                                 ;*70
 W !,$G(PSBHDR(1)),?(IOM-$L(PSBHDR("DATE"))),PSBHDR("DATE")
 I $G(PSBHDR(0))="" W !,PSBMODE                                   ;*70
 S PSBHDR("PAGE")=PSBHDR("PAGE")+1
 W !,$G(PSBHDR(2)),?(IOM-10),$J("Page: "_PSBHDR("PAGE"),10)
 F X=3:1 Q:'$D(PSBHDR(X))  D      ; More Lines If Needed
 . W !,PSBHDR(X)
 . I PSBHDR(X)["Clinic Search" W $$WRAP^PSBO(21,111,SRCHTXT)      ;*70
 . I PSBHDR(X)["Ward Location" W SRCHTXT                          ;*70
 I $G(PSBCONT) W !?(IOM-35\2),"*** CONTINUED FROM PREVIOUS PAGE ***"
 D WARD^NURSUT5("L^"_PSBWP,.PSBWRDA)
 S X="Division: "_$P(PSBWRDA(PSBWP,.02),U,2)
 W ?(IOM-$L(X)),X,!,$TR($J("",IOM)," ","=")
 Q
 ;
CLINIC(PSBRPT,PSBHDR,PSBCONT,PSBDT,SRCHTXT) ;
 ; PSBCONT: True if this is a continuation page
 ; PSBDT:   Date of Pt Information (Default to DT)
 S:'$G(PSBDT) PSBDT=DT
 I '$D(PSBHDR("DATE")) D NOW^%DTC S Y=+$E(%,1,12) D D^DIQ S PSBHDR("DATE")="Run Date: "_Y
 S:'$D(PSBHDR("PAGE")) PSBHDR("PAGE")=0
 W:$Y>1 @IOF
 W:$X>0 !
 W $TR($J("",IOM)," ","=")
 ;*70 insert across the board, a heading line base on the order mode
 ;    write line after the report name.  Some reports use PSBHDR(0)
 ;    for report name others use PSBHDR(1).
 W !,$G(PSBHDR(0))
 S PSBMODE=$S(PSBCLINORD=1:"Include Clinic Orders Only",PSBCLINORD=0:"Include Inpatient Orders Only",1:"Include Inpatient and Clinic Orders")               ;*70
 I $G(PSBHDR(0))]"" W !,PSBMODE        ;*70
 W !,$G(PSBHDR(1)),?(IOM-$L(PSBHDR("DATE"))),PSBHDR("DATE")
 I $G(PSBHDR(0))="" W !,PSBMODE        ;*70
 S PSBHDR("PAGE")=PSBHDR("PAGE")+1
 W !,$G(PSBHDR(2)),?(IOM-10),$J("Page: "_PSBHDR("PAGE"),10)
 F X=3:1 Q:'$D(PSBHDR(X))  D      ; More Lines If Needed        ;*70
 . W !,PSBHDR(X)
 . I PSBHDR(X)["Clinic Search" W $$WRAP^PSBO(21,111,SRCHTXT)
 . I PSBHDR(X)["Ward Location" W SRCHTXT
 I $G(PSBCONT) W !?(IOM-35\2),"*** CONTINUED FROM PREVIOUS PAGE ***"
 N DFN D CLIN^PSBO(.PSBRPT) M ^TMP("PSBO",$J)=^TMP("PSJCL",$J)
 W !,$TR($J("",IOM)," ","=")
 Q
 ;
PSBALG ;
 S YA=""
 K PSBAL,GMRALA
 S PSBLIST=""
 D ALLR^PSBALL(.GMRALA,DFN)
 S X="" F  S X=$O(GMRALA(X)) Q:X=""  D
 .I $P(GMRALA(X),U,1)["ALL" D
 ..S PSBAL($P(GMRALA(X),U,2))=""
 S XAB="" F  S XAB=$O(PSBAL(XAB)) Q:XAB=""  D
 .S Z=XAB
 .I $L(YA_Z)>(IOM-22) S PSBHDR("ALERGY",$O(PSBHDR("ALERGY",""),-1)+1)=YA,YA=""
 .S YA=YA_$S(YA]"":", ",1:"")_XAB
 S:YA]"" PSBHDR("ALERGY",$O(PSBHDR("ALERGY",""),-1)+1)=YA
 I '$D(PSBHDR("ALERGY")) S PSBHDR("ALERGY",1)="No Allergies on file."
 Q
 ;
PTFTR() ; [Extrinsic] Patient Page footer
 ;
 I (IOSL<100) F  Q:$Y>(IOSL-6)  W !
 W !,$TR($J("",IOM)," ","=")
 S X="Ward: "_PSBHDR("WARD")_"  Room-Bed: "_PSBHDR("ROOM")
 W !,PSBHDR("NAME"),?(IOM-11\2),PSBHDR("SSN"),?(IOM-$L(X)),X
 I $G(PSBUNK) S X="Note:  ??  Indicates an administration with an *UNKNOWN* Action Status" W !!,X
 Q ""
 ;
SRCHLIST() ;Build appropriate Clinic or Ward/Nurse Unit Search list heading
 N LIST,RPT,LBL,QQ,PSBWP,PSBWRDA
 S LIST=""
 ; Clinic locations lookup
 D:$P($G(PSBRPT(4)),U,2)="C"
 . S:'$D(PSBRPT(2)) LIST="All Clinics"
 . D:$D(PSBRPT(2))
 .. F QQ=$O(PSBRPT(2,0)):1:$O(PSBRPT(2,"B"),-1) S RPT(PSBRPT(2,QQ,0))=""
 .. S LIST=""
 .. S LBL="" F  S LBL=$O(RPT(LBL)) Q:LBL=""  D
 ... I LIST="" S LIST=LBL Q
 ... I LIST]"" S LIST=LIST_", "_LBL
 ; Ward location lookup
WRD I $P(PSBRPT(.1),U)="W" D
 . S PSBWP=$P(PSBRPT(.1),U,3) D WARD^NURSUT5("L^"_PSBWP,.PSBWRDA)
 . S WLOC=PSBWRDA(PSBWP,.01)
 . ;  name if a nurs unit
 . S LIST=$P(WLOC,U,2)
 . ;  hosp/ward loc name if not nurs unit
 . S:LIST="" LIST=$$GET1^DIQ(44,+WLOC,.01)
 Q LIST
 ;
EMPTYHDR(SRCHTXT) ; Write headings & search cirtieria - for no data scenario
 D NOW^%DTC S Y=+$E(%,1,12) D D^DIQ S PSBHDR("DATE")="Run Date: "_Y
 S PSBHDR("PAGE")=1
 ;
 W !,$TR($J("",IOM)," ","=")
 W !,$G(PSBHDR(0))
 S PSBMODE=$S(PSBCLINORD=1:"Include Clinic Orders Only",PSBCLINORD=0:"Include Inpatient Orders Only",1:"Include Inpatient and Clinic Orders")   ;*70
 I $G(PSBHDR(1))]"",$G(PSBHDR(0))]"" W !,PSBMODE
 W !,$G(PSBHDR(1)),?(IOM-$L(PSBHDR("DATE"))),PSBHDR("DATE")
 I $G(PSBHDR(1))]"",$G(PSBHDR(0))="" W !,PSBMODE
 W !,$G(PSBHDR(2)),?(IOM-10),$J("Page: "_PSBHDR("PAGE"),10)
 F X=3:1 Q:'$D(PSBHDR(X))  D      ; More Lines If Needed
 . W !,PSBHDR(X)
 . I PSBHDR(X)["Clinic Search" W $$WRAP^PSBO(21,111,SRCHTXT)
 . I PSBHDR(X)["Ward Location" W SRCHTXT
 W !,$TR($J("",IOM)," ","=")
 Q ""
