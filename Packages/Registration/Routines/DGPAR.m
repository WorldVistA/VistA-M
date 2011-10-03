DGPAR ;ALB/MRL - ADT PARAMETER ENTRY/EDIT ; 07 MAR 87
 ;;5.3;Registration;**51,86,93,109,214,343**;Aug 13, 1993
 I '$D(^DG(43,1,0))#2 S DA=1,^DG(43,1,0)=1,DIK="^DG(43," D IX1^DIK
WR D DT^DICRW S U="^",DGHEAD="PIMS VERSION "_$S('$D(^DG(43,1,"VERSION")):"'UNKNOWN'",^("VERSION")[".":^("VERSION"),1:^("VERSION")_".0")_" PARAMETER ENTRY/EDIT",IOP="HOME" D ^%ZIS K IOP
 W @IOF,!?20,DGHEAD,! S X="",$P(X,"=",79)="" W X F I=0,"GL","BT","SCLR","DGPRE","REC","PH" S DGNOD(I)=$S($D(^DG(43,1,I)):^(I),1:"")
 S DGMULT=+$P(DGNOD("GL"),"^",2),DGPTFP=+$P(DGNOD(0),"^",31) W !,"[1] Medical Center Name : ",$S($D(^DG(40.8,+$P(DGNOD("GL"),"^",3),0)):$P(^(0),"^",1),1:"NONE SPECIFIED"),?59,"Affiliated: ",$S(+$P(DGNOD("GL"),"^",4):"YES",1:"NO")
 W !?4,"Multidivisional     : ",$S(+$P(DGNOD("GL"),"^",2):"YES",1:"NO")
 W !?4,"Nursing Home Wards  : ",$S(+$P(DGNOD(0),"^",20):"YES",1:"NO")
 W ?52,"Domiciliary Wards: ",$S(+$P(DGNOD(0),"^",21):"YES",1:"NO")
 W !?4,"System Timeout Sec. : ",+$P(DGNOD(0),"^",5),?51,"Print PTF Messages: ",$S($P(DGNOD(0),"^",31):"YES",1:"NO")
 ;W !?4,"G&L Earliest Date   : " S Y=$P(DGNOD("GL"),"^",1) X:Y]"" ^DD("DD") W $S(Y]"":Y,1:"NONE SPECIFIED")
 W !?4,"Default PTF Printer : ",$S($P(DGNOD(0),"^",19)]"":$P(DGNOD(0),"^",19),1:"NONE SPECIFIED"),?55,"High Intensity: ",$S($P(DGNOD(0),"^",36):"ON",1:"OFF")
 W !?4,"Consistency Checker : ",$S($P(DGNOD(0),"^",37):"ON",1:"OFF"),?50,"Abbreviated Inquiry: ",$S($P(DGNOD(0),"^",38):"YES",1:"NO")
 W !?4,"Auto PTF Messages   : ",$S($P(DGNOD(0),"^",40)!($P(DGNOD(0),"^",40)']""):"YES",1:"NO"),?51,"Show Status Screen: ",$S($P(DGNOD(0),"^",34):"YES",1:"NO")
 S DGX=46 W !!,"[2] Days to Update Medicaid",?31,": ",$S('$P(^DG(43,1,0),U,46):365,1:+$P(^(0),U,46))
 W ?45,"Maintain G&L Corrections: " S DGX=29,DGX1="DAY" D DAY W !?4,"Disposition late",?31,": " S DGX=7,DGX1="HOUR" D DAY
 S DGX=8 W ?51,"Supplemental 10/10: " D DO
 S DGX=27 W !?4,"Ask HINQ at Registration",?31,": " D DO
 S DGX=17 W ?46,"DRUG PROFILE with 10/10: " D DO
 I $P(^DG(43,1,0),U,17) D
 .S DGX=44 W !?4,"CHOICE OF DRUG PROFILE?",?31,": " D DO
 .W ?49,"Default Drug Profile: "
 .S X=$P(^DG(43,1,0),U,45) W $S(X="A":"ACTION",1:"INFO.")
 S X="GMTSDVR" X ^%ZOSF("TEST") I $T I $T(ENXQ^GMTSDVR)]"" S DGHSFLG=1
 W !?4,"HEALTH SUMMARY with 10/10  : " W:'$G(DGHSFLG) "N/A"
 I $G(DGHSFLG) D
 .N DIC,X,Y
 .S DGX=42 D DO
 .W ?47,"Default Health Summary: "
 .S X=$P($G(^DG(43,1,0)),U,43),DIC=142,DIC(0)="NX"
 .D ^DIC
 .W $S(Y<0:"NONE",1:$E($P(Y,U,2),1,8))
 K DGHSFLG
EMB S DGX=28 W !?4,"Ask EMBOSS at Registration : " D DO
 S DGX=30 W ?50,"Use Nearest Printer: " D DO
 W !?4,"Reg. Template (LOCAL)",?31,": ",$S('$P(DGNOD(0),"^",35):"NONE SPECIFIED",'$D(^DIE(+$P(DGNOD(0),"^",35),0)):"NONE SPECIFIED",1:$P(^DIE(+$P(DGNOD(0),"^",35),0),"^",1))
 W ?53,"Use Temp Address: ",$S($P(DGNOD("BT"),"^",3):"YES",1:"NO")
 W !?4,"Default Code Sheet Printer : ",$S($P(DGNOD(0),"^",25)]"":$P(DGNOD(0),"^",25),1:"NONE SPECIFIED"),?51,"Ask Device in Reg.: ",$S($P(DGNOD(0),"^",39):"YES",1:"NO")
 S DGX=33 W !?4,"Days to Maintain Sens. Data: ",$S('$P(^DG(43,1,0),"^",33):"Forever",1:+$P(^(0),"^",33))
 S DGX=47 W ?49,"Print Encounter Form",?31,": " D DO
 W !?4,"Default EF Printer",?31,": ",$S($P(DGNOD(0),"^",48)]"":$P(DGNOD(0),"^",48),1:"NONE SPECIFIED")
REC ;Write PATIENT (#2) file record access parameter
 W !?4,"Restrict PATIENT access    : ",$S($P($G(DGNOD("REC")),U)=1:"YES",1:"NO")
 W !?4,"Purple Heart Sort",?31,": ",$S($P($G(DGNOD("PH")),U)="A":"Ascending",1:"Descending")
PREREG ; write pre-registration parameters
 W !!?4,"[Pre-Registration]"
 W !?4,"Sort Method",?31,": ",$P($G(DGNOD("DGPRE")),U),?46,"Background Job Function: ",$P($G(DGNOD("DGPRE")),U,3)
 W !?4,"Days Between Calls",?31,": ",$P($G(DGNOD("DGPRE")),U,2),?41,"Days to Maintain Log Entries: ",$P($G(DGNOD("DGPRE")),U,4)
 W !?4,"Days to Pull Appointments",?31,": ",$P($G(DGNOD("DGPRE")),U,5),?54,"Run for Weekend: ",$S($P($G(DGNOD("DGPRE")),U,6):"YES",1:"NO")
 ;
 I +$P($G(^DG(43,1,"DGPREC",0)),U,3)>0 D
 . W !!?4,"Excluded Clinics:"
 . N NDX,LNDX
 . S LNDX=1
 . S NDX="" F  S NDX=$O(^DG(43,1,"DGPREC","B",NDX)) Q:'NDX  D
 .. I LNDX=1 W !?4,$E($P(^SC(NDX,0),U),1,20) S LNDX=2 Q
 .. I LNDX=2 W ?30,$E($P(^SC(NDX,0),U),1,20) S LNDX=3 Q
 .. I LNDX=3 W ?55,$E($P(^SC(NDX,0),U),1,20) S LNDX=1 Q
 ;
 I +$P($G(^DG(43,1,"DGPREE",0)),U,3)>0 D
 . W !!?4,"Excluded Eligibilities:"
 . N NDX,LNDX
 . S LNDX=1
 . S NDX="" F  S NDX=$O(^DG(43,1,"DGPREE","B",NDX)) Q:'NDX  D
 .. I LNDX=1 W !?4,$E($P(^DIC(8,NDX,0),U),1,20) S LNDX=2 Q
 .. I LNDX=2 W ?30,$E($P(^DIC(8,NDX,0),U),1,20) S LNDX=3 Q
 .. I LNDX=3 W ?55,$E($P(^DIC(8,NDX,0),U),1,20) S LNDX=1 Q
 ;
DIV ; write division parameters
 W !!,"[3]" I DGMULT W ?4,"Divisions: " F I=0:0 S I=$O(^DG(40.8,I)) Q:'I  S X=$P(^(I,0),"^",1)_$S($P(^(0),"^",2)]"":" ("_$P(^(0),"^",2)_"), ",1:"") W:$L(X)>(65-$X) !?15 W X
 I 'DGMULT S DGD=+$P(DGNOD("GL"),"^",3),DGDV=$S($D(^DG(40.8,DGD,"DEV")):^("DEV"),1:""),DGZE=$S($D(^(0)):^(0),1:"") D DEV^DGPAR1
 G ^DGPAR1
DAY S DGD=+$P(DGNOD(0),"^",DGX) I DGX=29,'DGD W "FOREVER" Q
 W DGD,"-",DGX1,$S(DGD=1:"",1:"S") Q
DO I DGX'=8 W $S('$P(DGNOD(0),"^",DGX):"NO",1:"YES") Q
 W $S('$P(DGNOD(0),"^",DGX):"YES",1:"NO") Q
