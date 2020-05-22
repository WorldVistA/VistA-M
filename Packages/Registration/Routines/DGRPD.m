DGRPD ;ALB/MRL,MLR,JAN,LBD,EG,BRM,JRC,BAJ,JAM,HM,BDB -PATIENT INQUIRY (NEW) ;July 09, 2014  12:16pm
 ;;5.3;Registration;**109,124,121,57,161,149,286,358,436,445,489,498,506,513,518,550,545,568,585,677,703,688,887,907,925,936,940,941,987,1006**;Aug 13, 1993;Build 6
 ; *286* Newing variables X,Y in OKLINE subroutine
 ; *358* If a patient is on a domiciliary ward, don't display MEANS
 ; TEST required/Medication Copayment Exemption messages
 ; *436* If an inpatient is not on a domiciliary ward, don't display
 ; Medication Copayment Exemption message
 ; *545* Add death information near the remarks field
 ; *677* Added Emergency Response
 ; *688* Modified to display Country and Foreign Address
 ; *936* Modified to display Health Benefit Plans
 ; *940* #879316,#879318 - Display Permanent & Total Disabled Status
 ; *941* #887088 - Redesign of Inquiry Screen layout for displaying the addresses
 ;
 ; Integration Agreements:
 ; 6138 - DGHBPUTL API
 ;
SEL K DFN,DGRPOUT W ! S DIC="^DPT(",DIC(0)="AEQMZ" D ^DIC G Q:Y'>0 S DFN=+Y N Y W ! S DIR(0)="E" D ^DIR G SEL:$D(DTOUT)!($D(DUOUT)) D EN G SEL
EN ;call to display patient inquiry - input DFN
 ;MPI/PD CHANGE
 S DGCMOR="UNSPECIFIED",DGMPI=$G(^DPT(+DFN,"MPI"))
 K DGRPOUT,DGHOW S DGABBRV=$S($D(^DG(43,1,0)):+$P(^(0),"^",38),1:0),DGRPU="UNSPECIFIED" D DEM^VADPT,HDR^DGRPD1
 ;JAM begin changes Patch DG*5.3*941 add .115 and new address fields layout
 F I=0,.11,.13,.121,.122,.31,.32,.36,.361,.141,.3,.115 S DGRP(I)=$S($D(^DPT(DFN,I)):^(I),1:"")
 ;jam DG*5.3*925 RM#788099 change labels to "Permanent Mailing Address" and "Temporary Mailing Address"
 ;
 W " Residential Address: "
 W ?40,"Permanent Mailing Address: "
 S DGAD=.115,(DGA1,DGA2)=1 D AL^DGRPU(35) S DGAD=.11,DGA1=1,DGA2=2 D AL^DGRPU(35)
 W !?5
 N Z,Z1
 S Z1=39,Z=$S($D(DGA(1)):DGA(1),1:"NONE ON FILE") D WW1^DGRPV W $S($D(DGA(2)):DGA(2),1:"NO PERMANENT MAILING ADDRESS")
 ; loop through DGA array beginning with DGA(2) and print data at ?5 (odds) and ?44 (evens)
 S I=2 F I1=0:0 S I=$O(DGA(I)) Q:I=""  W:(I#2)!($X>40) !?5 W:'(I#2) ?44 W DGA(I)
 N DGCC
 S DGCC=$$COUNTY^DGRPCADD(.DGRP,.115) ; print County if applicable
 W !?5,"County: "_DGCC
 S DGCC=$$COUNTY^DGRPCADD(.DGRP,.11) ; print County if applicable
 W ?44,"County: "_DGCC
 W !?6,"Phone: ",$S($P(DGRP(.13),U,1)]"":$P(DGRP(.13),U,1),1:DGRPU)
 W ?42,"Bad Addr: ",$$EXTERNAL^DILFD(2,.121,"",$P(DGRP(.11),U,16))
 W !?5,"Office: ",$S($P(DGRP(.13),U,2)]"":$P(DGRP(.13),U,2),1:DGRPU)
 W ?46,"Cell: ",$S($P(DGRP(.13),U,4)]"":$P(DGRP(.13),U,4),1:DGRPU)
 W !?44,"E-mail: ",$S($P(DGRP(.13),U,3)]"":$P(DGRP(.13),U,3),1:DGRPU)
 W !!
 K DGA,DGA1,DGA2
 I $P(DGRP(.121),"^",9)="Y" S DGAD=.121,(DGA1,DGA2)=1 D AL^DGRPU(30)
 N CONACT
 ; set Confidential Active Flag
 S CONACT=$P(DGRP(.141),"^",9)
 I CONACT="Y" D
 .; check the begin/end dates, set active flag to NO and do not display if outside the date range 
 .N DGCABEG,DGCAEND,DGI
 .S DGCABEG=$P(DGRP(.141),U,7),DGCAEND=$P(DGRP(.141),U,8)
 .I 'DGCABEG!(DGCABEG>DT)!(DGCAEND&(DGCAEND<DT)) S CONACT="N" Q
 .S DGAD=.141,DGA1=1,DGA2=2 D AL^DGRPU(30)
 W " Temporary Mailing Address: "
 W ?40,"Confidential Mailing Address: "
 W !?5
 W $S($D(DGA(1)):DGA(1),1:"NO TEMPORARY MAILING ADDRESS") W ?44,$S($D(DGA(2)):DGA(2),1:"NONE ON FILE")
 ; loop through DGA array beginning with DGA(2) and print data at ?5 (odds) and ?44 (evens)
 S I=2 F I1=0:0 S I=$O(DGA(I)) Q:I=""  W:(I#2)!($X>40) !?5 W:'(I#2) ?44 W DGA(I)
 W !
 I $D(DGA(1)) D
 .S DGCC=$$COUNTY^DGRPCADD(.DGRP,.121) ; print County if applicable 
 .W ?5,"County: "_DGCC
 I $D(DGA(2)) D
 .S DGCC=$$COUNTY^DGRPCADD(.DGRP,.141) ; print County if applicable
 .W ?44,"County: "_DGCC
 ;W !?2,"CASS Cert: "_$S($P(DGRP(.121),U,15)="Y":"Certified",$P(DGRP(.121),U,15)="F":"Failed",1:"NC")
 ;W ?41,"CASS Cert: "_$S($P(DGRP(.141),U,17)="Y":"Certified",$P(DGRP(.141),U,17)="F":"Failed",1:"NC")
 W !?6,"Phone: ",$S($P(DGRP(.121),U,9)'="Y":"NOT APPLICABLE",$P(DGRP(.121),U,10)]"":$P(DGRP(.121),U,10),1:DGRPU)
 W ?45,"Phone: ",$S($P(DGRP(.141),U,9)'="Y":"NOT APPLICABLE",CONACT'="Y":"NOT APPLICABLE",$P(DGRP(.13),U,15)]"":$P(DGRP(.13),U,15),1:DGRPU)
 S X="NOT APPLICABLE"
 I $P(DGRP(.121),U,9)="Y" D
 .S Y=$P(DGRP(.121),U,7) X:Y]"" ^DD("DD")
 .S X=$S(Y]"":Y,1:DGRPU)_"-",Y=$P(DGRP(.121),U,8) X:Y]"" ^DD("DD")
 .S X=X_$S(Y]"":Y,1:DGRPU)
 N DGACT,DGTYP,DGCAN,DGBEG,DGEND,DGZ,DGXX,DGX,DGTYPNAM,DGCAT
 W !?2,"From/To: ",X
 S DGX="NOT APPLICABLE"
 I CONACT="Y" D
 .S (DGZ,DGX)="" F DGI=7,8 S DGZ=$P(DGRP(.141),"^",DGI),Y=DGZ D
 ..I DGI=7 X:Y]"" ^DD("DD") S DGBEG=Y,DGX=Y
 ..I DGI=8 X:Y]"" ^DD("DD") S DGEND=Y,DGX=DGX_"-"_$S(Y]"":Y,1:"UNANSWERED")
 W ?43,"From/To: "_DGX
 W !?41,"Confidential Address Categories: " I $D(^DPT(DFN,.14)) D
 .; If not active, do not display categories
 .I CONACT'="Y" Q
 .S DGCAT=$$GET1^DID(2.141,.01,"","POINTER","","DGERR")
 .S DGX="",DGCAN="" F  S DGCAN=$O(^DPT(DFN,.14,DGCAN)) Q:DGCAN=""  D
 ..Q:'$D(^DPT(DFN,.14,DGCAN,0))
 ..S DGTYP=$P(^DPT(DFN,.14,DGCAN,0),"^",1),DGACT=$P(^DPT(DFN,.14,DGCAN,0),"^",2)
 ..S DGACT=$S(DGACT="Y":"Active",DGACT="N":"Inactive",1:"Unanswered")
 ..S DGTYPNAM="" F DGI=1:1 S DGTYPNAM=$P(DGCAT,";",DGI) Q:DGTYPNAM=""  D
 ...I DGTYPNAM[DGTYP S DGTYPNAM=$P(DGTYPNAM,":",2),DGX=DGTYPNAM_"("_DGACT_")"_","_DGX
 S DGXX="" F DGI=1:1 S DGXX=$P(DGX,",",DGI) Q:DGXX=""  D
 .W !?42,DGXX
 ;
 I '$$OKLINE^DGRPD1(16) G Q
 N DGEMER S DGEMER=$$EXTERNAL^DILFD(2,.181,"",$P($G(^DPT(DFN,.18)),"^"))
 W:DGEMER]"" !?32,"Emergency Response: ",DGEMER
 I 'DGABBRV W !!?4,"POS: ",$S($D(^DIC(21,+$P(DGRP(.32),"^",3),0)):$P(^(0),"^",1),1:DGRPU),?42,"Claim #: ",$S($P(DGRP(.31),"^",3)]"":$P(DGRP(.31),"^",3),1:"UNSPECIFIED")
 I 'DGABBRV W !?2,"Relig: ",$S($D(^DIC(13,+$P(DGRP(0),"^",8),0)):$P(^(0),"^",1),1:DGRPU),?46,"Birth Sex: ",$S($P(VADM(5),"^",2)]"":$P(VADM(5),"^",2),1:"UNSPECIFIED") ; DG*5.3*907
 I 'DGABBRV W ! D
 .N RACE,ETHNIC,PTR,VAL,X,DIWL,DIWR,DIWF
 .K ^UTILITY($J,"W")
 .S PTR=0 F  S PTR=+$O(^DPT(DFN,.02,PTR)) Q:'PTR  D
 ..S VAL=+$G(^DPT(DFN,.02,PTR,0))
 ..Q:$$INACTIVE^DGUTL4(VAL,1)
 ..S VAL=$$PTR2TEXT^DGUTL4(VAL,1) S:+$O(^DPT(DFN,.02,PTR)) VAL=VAL_", "
 ..S X=VAL,DIWL=0,DIWR=30,DIWF="" D ^DIWP
 .M RACE=^UTILITY($J,"W",0) S:$G(RACE(1,0))="" RACE(1,0)="UNANSWERED"
 .K ^UTILITY($J,"W")
 .S PTR=0 F  S PTR=+$O(^DPT(DFN,.06,PTR)) Q:'PTR  D
 ..S VAL=+$G(^DPT(DFN,.06,PTR,0))
 ..Q:$$INACTIVE^DGUTL4(VAL,2)
 ..S VAL=$$PTR2TEXT^DGUTL4(VAL,2) S:+$O(^DPT(DFN,.06,PTR)) VAL=VAL_", "
 ..S X=VAL,DIWL=0,DIWR=30,DIWF="" D ^DIWP
 .M ETHNIC=^UTILITY($J,"W",0) S:$G(ETHNIC(1,0))="" ETHNIC(1,0)="UNANSWERED"
 .K ^UTILITY($J,"W")
 .W ?3,"Race: ",RACE(1,0),?40,"Ethnicity: ",ETHNIC(1,0)
 .F X=2:1 Q:'$D(RACE(X,0))&'$D(ETHNIC(X,0))  W !,?9,$G(RACE(X,0)),?51,$G(ETHNIC(X,0))
 I '$$OKLINE^DGRPD1(16) G Q
 D LANGUAGE
 I '$$OKLINE^DGRPD1(10) G Q
 ;display cv status #4156
 N DGCV S DGCV=$$CVEDT^DGCV(+DFN)
 W !!,?2,"Combat Vet Status: "_$S($P(DGCV,U,3)=1:"ELIGIBLE",$P(DGCV,U,3)="":"NOT ELIGIBLE",1:"EXPIRED") I DGCV>0 W ?45,"End Date: "_$$FMTE^XLFDT($P(DGCV,U,2),"5DZ")
 ;display primary eligibility
 S X1=DGRP(.36),X=$P(DGRP(.361),"^",1) W !,"Primary Eligibility: ",$S($D(^DIC(8,+X1,0)):$P(^(0),"^",1)_" ("_$S(X="V":"VERIFIED",X="P":"PENDING VERIFICATION",X="R":"PENDING REVERIFICATION",1:"NOT VERIFIED")_")",1:DGRPU)
 W !,"Other Eligibilities: " F I=0:0 S I=$O(^DIC(8,I)) Q:'I  I $D(^DIC(8,I,0)),I'=+X1 S X=$P(^(0),"^",1)_", " I $D(^DPT("AEL",DFN,I)) W:$X+$L(X)>79 !?21 W X
 I '$$OKLINE^DGRPD1(16) G Q
 ;employability status
 W !?6,"Unemployable: ",$S($P(DGRP(.3),U,5)="Y":"YES",1:"NO")
 I '$$OKLINE^DGRPD1(19) G Q
 ; KUM DG*5.3*940 RM #879316,#879318 - Display Permanent & Total Disabled status
 W !?6,"Permanent & Total Disabled: ",$S($P(DGRP(.3),U,4)="Y":"YES",1:"NO")
 I '$$OKLINE^DGRPD1(19) G Q
 ;display the catastrophic disability review date if there is one
 D CATDIS^DGRPD1
 I $G(DGPRFLG)=1 G Q:'$$OKLINE^DGRPD1(19) D
 . N DGPDT,DGPTM
 . W !,$$REPEAT^XLFSTR("-",78)
 . S DGPDT="",DGPDT=$O(^DGS(41.41,"ADC",DFN,DGPDT),-1)
 . W !,"[PRE-REGISTER DATE:] "_$S(DGPDT]"":$$FMTE^XLFDT(DGPDT,"1D"),1:"NONE ON FILE")
 . S DGPTM=$$PCTEAM^DGSDUTL(DFN)
 . I $P(DGPTM,U,2)]"" W !,"[PRIMARY CARE TEAM:] "_$P(DGPTM,U,2)
 . W !,$$REPEAT^XLFSTR("-",78)
 ; Check if patient is an inpatient and on a DOM ward
 ; If inpatient is on a DOM ward, don't display MT or CP messages
 ; If inpatient is NOT on a DOM ward, don't display CP message
 N DGDOM,DGDOM1,VAHOW,VAROOT,VAINDT,VAIP,VAERR
 G Q:'$$OKLINE^DGRPD1(16)
 D DOM^DGMTR
 I '$G(DGDOM) D
 .D DIS^DGMTU(DFN)
 .D IN5^VADPT
 .I $G(VAIP(1))="" D DISP^IBARXEU(DFN,DT,3,1)
 ;I 'DGABBRV,$E(IOST,1,2)="C-" F I=$Y:1:20 W !
 D DIS^EASECU(DFN) ;Added for LTC III (DG*5.3*518)
 S VAIP("L")=""
 I $$OKLINE^DGRPD1(14) D INP
 I '$G(DGRPOUT),($$OKLINE^DGRPD1(10)) D SA ;*KNR*
 ;MPI/PD CHANGE
Q D KVA^VADPT K %DT,D0,D1,DGA,DGA1,DGA2,DGABBRV,DGAD,DGCC,DGCMOR,DGDOM,DGLOCATN,DGMPI,DGRP,DGRPU,DGS,DGST,DGXFR0,DIC,DIR,DTOUT,DUOUT,DIRUT,DIROUT,I,I1,L,LDM,POP,SDCT,VA,X,X1,Y Q
 ;
INP S VAIP("D")="L" D INP^DGPMV10
 S DGPMT=0
 D CS^DGPMV10 K DGPMT,DGPMIFN K:'$D(DGSWITCH) DGPMVI,DGPMDCD Q
SA F I=0:0 S I=$O(^DGS(41.1,"B",DFN,I)) G CL:'I S X=^DGS(41.1,I,0) I $P(X,"^",2)>(DT-1),$P(X,"^",13)']"",'$P(X,"^",17) S L=$P(X,"^",2) D:$$OKLINE^DGRPD1(17) SAA Q:$G(DGRPOUT)
 Q
SAA ;Scheduled Admit Data
 W !!?14,"Scheduled Admit"
 W:$D(^DIC(42,+$P(X,U,8),0)) " on ward "_$P(^(0),U)
 W:$D(^DIC(45.7,+$P(X,U,9),0)) " for treating specialty "_$P(^(0),U)
 W " on "_$$FMTE^XLFDT(L,"5DZ")
 Q  ;SAA
 ;
CL G FA:$O(^DPT(DFN,"DE",0))="" S SDCT=0 F I=0:0 S I=$O(^DPT(DFN,"DE",I)) Q:'I  I $D(^(I,0)),$P(^(0),"^",2)'="I",$O(^(0)) S SDCT=SDCT+1 W:SDCT=1 !!,"Currently enrolled in " W:$X>50 !?22 W $S($D(^SC(+^(0),0)):$P(^(0),"^",1)_", ",1:"")
 ;
FA ;
 N DGARRAY,SDCNT
 S DGARRAY("FLDS")="1;2;3;18",DGARRAY(4)=DFN,DGARRAY(1)=DT,DGARRAY("SORT")="P"
 S SDCNT=$$SDAPI^SDAMA301(.DGARRAY),CT=0 W !!,"Future Appointments: "
 ;if there is lower subscripts hanging from the 101 node,
 ;then it is a valid appointment, otherwise it is
 ;an error eg 01/20/2005
 ;G:'$$OKLINE^DGRPD1(13) RMK ;*///*
 I $D(^TMP($J,"SDAMA301",101))=1 W "Appointment Database is Unavailable" G RMK
 I $O(^TMP($J,"SDAMA301",DFN,DT))'>0 W "NONE" G RMK
 ;
 W ?22,"Date",?33,"Time",?39,"Clinic",!?22 F I=22:1:75 W "="
 F FA=DT:0 S FA=$O(^TMP($J,"SDAMA301",DFN,FA)) G RMK:'FA D  Q:CT>5
 .N STAT S STAT=$P($P(^TMP($J,"SDAMA301",DFN,FA),U,3),";")
 .S C=+$P(^TMP($J,"SDAMA301",DFN,FA),U,2) I STAT'["C" D
 ..D COV
 ..N DGAPPT S DGAPPT=$$FMTE^XLFDT($E(FA,1,12),"5Z")
 ..W !?22,$P(DGAPPT,"@"),?33,$P(DGAPPT,"@",2)
 ..W ?39,$P($P(^TMP($J,"SDAMA301",DFN,FA),U,2),";",2)," ",COV
 ..Q
 I $O(^TMP($J,"SDAMA301",DFN,FA))>0 W !,"See Scheduling options for additional appointments."
RMK I '$G(DGRPOUT),($$OKLINE^DGRPD1(15)) W !!,"Remarks: ",$P(^DPT(DFN,0),"^",10) ;*///*
 D GETS^DIQ(2,DFN_",",".351;.353;.354;.355","E","PDTHINFO")
 W !!
 W "Date of Death Information"
 W !,?5,"Date of Death: ",$G(PDTHINFO(2,DFN_",",.351,"E"))
 W !,?5,"Source of Notification: ",$G(PDTHINFO(2,DFN_",",.353,"E"))
 W !,?5,"Updated Date/Time: ",$G(PDTHINFO(2,DFN_",",.354,"E"))
 W !,?5,"Last Edited By: ",$G(PDTHINFO(2,DFN_",",.355,"E")),!
 I $$OKLINE^DGRPD1(14) D EC^DGRPD1
 ; KUM DG*5.3*936 Call tag to display Health Benefit Plans assigned to Veteran
 D HBP
 K DGARRAY,SDCNT,^TMP($J,"SDAMA301"),ADM,L,TRN,DIS,SSN,FA,C,COV,NOW,CT,DGD,DGD1,I ;Y killed after dghinqky
 Q
 ; KUM DG*5.3*936 Display Health Benefit Plans assigned to Veteran
HBP ;W !!,"Veteran Medical Benefit Plan Currently Assigned to Veteran:" ;DG*5.3*987 HM
 W !!,"VHA Profiles Currently Assigned to Veteran:" ;DG*5.3*1006 BDB;DG*5.3*987 HM
 N DGHBP,HBP,DGCOUNT,DGHBIEN,DGPNAME,X,DGCNT,DGLN,DGLINE
 S DGCOUNT=0
 D GETHBP^DGHBPUTL(DFN)
 S DGHBP="" F  S DGHBP=$O(HBP("CUR",DGHBP)) Q:DGHBP=""  D
 .; DG*5.3*987; jam; Place "zz" before the plan name for inactive plans
 .S DGHBIEN=+HBP("CUR",DGHBP)
 .I $P($G(^DGHBP(25.11,DGHBIEN,0)),"^",4)="Y" S DGPNAME="zz "_DGHBP
 .E  S DGPNAME=DGHBP
 .; DG*5.3*987; arf; Add word wrapping for plan names
 .S X=DGPNAME
 .K ^UTILITY($J,"W") S DIWL=0,DIWR=70,DIWF="" D ^DIWP
 .S DGCNT=^UTILITY($J,"W",0)
 .F DGLN=1:1:DGCNT S DGLINE=^UTILITY($J,"W",0,DGLN,0) W !,?3,DGLINE
 .K ^UTILITY($J,"W")
 .S DGCOUNT=DGCOUNT+1
 I DGCOUNT=0 W !,?3,"None"
 Q
 ;
COV S COV=$S(+$P(^TMP($J,"SDAMA301",DFN,FA),U,18)=7:" (Collateral) ",1:"")
 S COV=COV_$S(STAT["NT":" * NO ACTION TAKEN *",STAT["N":" * NO-SHOW *",1:""),CT=CT+1 Q
 Q
 ;
OREN S XQORQUIT=1 Q:'$D(ORVP)  S DFN=+ORVP D EN R !!,"Press RETURN to CONTINUE: ",X:DTIME
 Q
LANGUAGE ; Get language data *///*
 S DGLANGDT=9999999,(DGPRFLAN,DGLANG0)=""
 S DGLANGDT=$O(^DPT(DFN,.207,"B",DGLANGDT),-1)
 I DGLANGDT="" G L1
 S DGLANGDA=$O(^DPT(DFN,.207,"B",DGLANGDT,0))
 S DGLANG0=$G(^DPT(DFN,.207,DGLANGDA,0)),Y=$P(DGLANG0,U),DGPRFLAN=$P(DGLANG0,U,2)
 S Y=DGLANGDT X ^DD("DD") S DGLANGDT=Y
L1 W !!,"Language Date/Time: ",$S(DGLANGDT="":"UNANSWERED",1:DGLANGDT),!
 W ?1,"Preferred Language: ",$S(DGPRFLAN="":"UNANSWERED",1:DGPRFLAN)
 K DGLANGDT,DGPRFLAN,DGLANG0,DGLANGDA
 Q
