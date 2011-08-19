PSBOHDR ;BIRMINGHAM/EFC - REPORT HEADERS ;5/28/10 2:51pm
 ;;3.0;BAR CODE MED ADMIN;**5,13,42**;Mar 2004;Build 23
 ;
 ; Reference/IA
 ; EN6^GMRVUTL/1120
 ; WARD^NURSUT5/3052
 ; IN5^VADPT/10061
 ; DEM^VADPT/10061
 ;
PT(DFN,PSBHDR,PSBCONT,PSBDT) ;
 ; DFN:     Patient File IEN
 ; PSBCONT: True if this is a continuation page
 ; PSBDT:   Date of Pt Information (Default to DT)
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
 ..S X=+$P(X,U,8) S:X X=X*2.54\1 S PSBHDR("HEIGHT")=$S(X:X_"cm",1:"*")
 ..S GMRVSTR="WT" D EN6^GMRVUTL
 ..S X=+$P(X,U,8) S:X X=X*.45\1 S PSBHDR("WEIGHT")=$S(X:X_"kg",1:"*")
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
 W $C(13),$TR($J("",IOM)," ","=")
 W !,$G(PSBHDR(0))
 W !,$G(PSBHDR(1)),?(IOM-$L(PSBHDR("DATE"))),PSBHDR("DATE")
 S PSBHDR("PAGE")=PSBHDR("PAGE")+1
 W !,$G(PSBHDR(2)),?(IOM-10),$J("Page: "_PSBHDR("PAGE"),10)
 F X=3:1 Q:'$D(PSBHDR(X))  W !,PSBHDR(X)  ; More Lines If Needed
 I $G(PSBCONT) W !?(IOM-35\2),"*** CONTINUED FROM PREVIOUS PAGE ***"
 W !!,"Patient:",?10,PSBHDR("NAME")
 W ?40,$$GET^XPAR("ALL","PSB PATIENT ID LABEL")_":",?51,PSBHDR("SSN")
 W ?75,"DOB:",?82,PSBHDR("DOB")," (",PSBHDR("AGE"),")"
 D:'$G(PSBCONT)
 .W !,"Sex: ",?10,PSBHDR("SEX"),?40,"Ht/Wt:     ",PSBHDR("HEIGHT"),"/",PSBHDR("WEIGHT"),?75,"Ward: ",?82,PSBHDR("WARD")," Rm ",PSBHDR("ROOM")
 .W !,"Dx:",?10,PSBHDR("DX"),?40,"Last Mvmt: ",PSBHDR("MVMTLAST"),?75,"Type:  ",PSBHDR("MVMTTYPE")
 .; Reactions/Allergies
 .W !!,"ADRs:"
 .F X=0:0 S X=$O(PSBHDR("REAC",X)) Q:'X  W:$X>12 ! W ?12,PSBHDR("REAC",X)
 .W !!,"Allergies:"
 .F X=0:0 S X=$O(PSBHDR("ALERGY",X)) Q:'X  W:$X>12 ! W ?12,PSBHDR("ALERGY",X)
 .; Local Mods Allowed Here and showup only on First Page
 .; Immunizations
 .;D SHOT80^ASFSHOTF
 W !,$TR($J("",IOM)," ","=")
 Q
 ;
WARD(PSBWP,PSBHDR,PSBCONT,PSBDT) ; 
 ; WARD:    Nurse Location File IEN
 ; PSBCONT: True if this is a continuation page
 ; PSBDT:   Date of Pt Information (Default to DT)
 N PSBWRDA
 S:'$G(PSBDT) PSBDT=DT
 I '$D(PSBHDR("DATE")) D NOW^%DTC S Y=+$E(%,1,12) D D^DIQ S PSBHDR("DATE")="Run Date: "_Y
 S:'$D(PSBHDR("PAGE")) PSBHDR("PAGE")=0
 W:$Y>1 @IOF
 W:$X>0 !
 W $TR($J("",IOM)," ","="),!,$G(PSBHDR(0)),!,$G(PSBHDR(1)),?(IOM-$L(PSBHDR("DATE"))),PSBHDR("DATE")
 S PSBHDR("PAGE")=PSBHDR("PAGE")+1
 W !,$G(PSBHDR(2)),?(IOM-10),$J("Page: "_PSBHDR("PAGE"),10)
 F X=3:1 Q:'$D(PSBHDR(X))  W !,PSBHDR(X)  ; More Lines If Needed
 I $G(PSBCONT) W !?(IOM-35\2),"*** CONTINUED FROM PREVIOUS PAGE ***"
 D WARD^NURSUT5("L^"_PSBWP,.PSBWRDA)
 W !!,"Ward Location: "_$P(PSBWRDA(PSBWP,.01),U,2)
 S X="Division: "_$P(PSBWRDA(PSBWP,.02),U,2)
 W ?(IOM-$L(X)),X,!,$TR($J("",IOM)," ","=")
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
