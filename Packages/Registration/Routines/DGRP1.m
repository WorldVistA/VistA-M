DGRP1 ;ALB/MRL,ERC,BAJ,PWC,JAM,JAM - DEMOGRAPHIC DATA ;19 Jul 2017  3:02 PM
 ;;5.3;Registration;**109,161,506,244,546,570,629,638,649,700,653,688,750,851,907,925,941,985**;Aug 13, 1993;Build 15
 ;
EN ;
 ; JAM - Patch DG*5.3*941, Reformatting Registration screen 1.  New field layout.
 ;S (DGRPS,DGRPW)=1 D H^DGRPU F I=0,.11,.121,.122,.13,.15,.24,57,"SSN" S DGRP(I)=$S($D(^DPT(DFN,I)):^(I),1:"")
 N DGRP
 S (DGRPS,DGRPW)=1 D H^DGRPU F I=0,.13,.15,.24,"SSN" S DGRP(I)=$S($D(^DPT(DFN,I)):^(I),1:"")
 I $P(DGRP(.15),"^",2)]"" S Z="APPLICANT IS LISTED AS 'INELIGIBLE' FOR TREATMENT!",DGRPCM=1 D WW^DGRPV S DGRPCM=0
 ;I $P(DGRP(.15),"^",3)]"" S Z="APPLICANT IS LISTED AS 'MISSING'.  NOTIFY APPROPRIATE PERSONNEL!",DGRPCM=1 D WW^DGRPV S DGRPCM=0
 ;Retrieve SSN Verification status DG*5.3*688 BAJ 11/22/2005
 N SSNV D GETSTAT(.SSNV)
 S Z=1 D WW^DGRPV W "  Name: " S Z=$P(DGRP(0),"^",1),Z1=31 D WW1^DGRPV
 ; DG*5.3*985; JAM - reformat screen 1 to add group 6 - Preferred Name next to Name field and move SSN and Pseudo Reason down
 S DGRPW=0,Z1="",Z=6 D WW^DGRPV S Z=$P(DGRP(.24),"^",5),Z1=1 S Z=$S(Z]"":" Preferred Name: "_$E(Z,1,17),1:" Preferred Name: Not Answered") D WW1^DGRPV
 S DGRPW=1
 W ! S Z="",Z1=6 D WW1^DGRPV S Y=$P(DGRP(0),"^",3) X ^DD("DD") W "DOB: ",Y
 W ! S Z="",Z1=7 D WW1^DGRPV
 ;Display SSN and SSN Verification status DG*5.3*688 BAJ 11/22/2005
 W "SS: " S X=$P(DGRP(0),"^",9),Z=$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,10),Z1=13 D WW1^DGRPV W SSNV
 ;add Pseuso SSN Reason - DG*5.3*653, ERC
 I $P(DGRP(0),U,9)["P" D
 . N DGSPACE
 . S DGSPACE=10-$L(Z) ;adjust to maintain spacing on screen
 . S Z=""
 . S Z1=14+DGSPACE D WW1^DGRPV W "PSSN Reason: "
 . N DGREAS D SSNREAS(.DGREAS)
 . Q:$G(DGREAS)']""
 . W DGREAS
 D GETNCAL  ;Display name component, sex, and alias information
 S Z=3,DGRPX=DGRP(0) W ! D WW^DGRPV W " Remarks: ",$S($P(DGRPX,"^",10)]"":$E($P(DGRPX,"^",10),1,65),1:"NO REMARKS ENTERED FOR THIS PATIENT")
 ;JAM - Patch DG*5.3*941 registration screen changes - remove addresses from screen and Cell/pager/email now in group 3 and Preferred Lang in group 4
 S Z=4,DGRPW=1.1 W ! D WW^DGRPV W "    Cell Phone: "  ;DG*5.3*941
 ;
 ;* Output Cell phone
 I $P(DGRP(.13),U,4)'="" W ?19,$P(DGRP(.13),U,4)
 I $P(DGRP(.13),U,4)="" W ?19,"UNANSWERED"
 ;
 ; DG*5.3*985; JAM - Move pager up to same line across from cell phone
 ;* Output Pager
 W ?47,"Pager #: "
 I $P(DGRP(.13),U,5)'="" W ?56,$P(DGRP(.13),U,5)
 I $P(DGRP(.13),U,5)="" W ?56,"UNANSWERED"
 ;
 ;* Output Email Address
 W !,"    Email Address: "
 I $P(DGRP(.13),U,3)'="" W ?19,$P(DGRP(.13),U,3)
 I $P(DGRP(.13),U,3)="" W ?19,"UNANSWERED"
 ;
LANGUAGE ;Get language data *///*
 S DGLANGDT=9999999,(DGPRFLAN,DGLANG0,DGRP(1),DGRP(2))=""
 S DGLANGDT=$O(^DPT(DFN,.207,"B",DGLANGDT),-1)
 I DGLANGDT="" G L1
 S DGLANGDA=$O(^DPT(DFN,.207,"B",DGLANGDT,0)) I DGLANGDA="" S DGRP(2)="" G L1
 S DGLANG0=$G(^DPT(DFN,.207,DGLANGDA,0)),Y=$P(DGLANG0,U),DGPRFLAN=$P(DGLANG0,U,2)
 S Y=DGLANGDT X ^DD("DD") S DGLANGDT=Y
 S DGRP(1)=DGLANGDT,DGRP(2)=DGPRFLAN
 K DGLANGDT,DGPRFLAN,DGLANG0,DGLANGDA
 ;
L1 W ! S Z=5,DGRPW=1.1 D WW^DGRPV ;*///*  ;DG*5.3*941 - remove extra line feed
 W ?4,"Language Date/Time: ",$S(DGRP(1)="":"UNANSWERED",1:DGRP(1))
 W !?4,"Preferred Language: ",$S(DGRP(2)="":"UNANSWERED",1:DGRP(2))
 ;
 ; ***  Additional displays added for Pre-Registration
 I $G(DGPRFLG)=1 D
 . W !
 . N I,MIS1,X,X1,SA1,TP1,X2,X3,ES1,ADDRDTTM
 . I $D(^DIA(2,"B",DFN)) S X="" F I=1:1 S X=$O(^DIA(2,"B",DFN,X)) Q:X<1  I $P(^DIA(2,X,0),U,3)=.05 S MIS1=$P(^DIA(2,X,0),U,2)
 . W:$D(MIS1)>0 !," [MARITAL STATUS CHANGED:] "_$$FMTE^XLFDT(MIS1,"5D")
 . I $D(^DIA(2,"B",DFN)) S X1="" F I=1:1 S X1=$O(^DIA(2,"B",DFN,X1)) Q:X1<1  S:$P(^DIA(2,X1,0),U,3)=.111 SA1=$P(^DIA(2,X1,0),U,2)
 . W:$D(SA1)>0 !," [STREET ADDRESS LAST CHANGED:] "_$$FMTE^XLFDT(SA1,"5D")
 . I $D(^DIA(2,"B",DFN)) S X2="" F I=1:1 S X2=$O(^DIA(2,"B",DFN,X2)) Q:X2<1  S:$P(^DIA(2,X2,0),U,3)=.131 TP1=$P(^DIA(2,X2,0),U,2)
 . S ADDRDTTM=$P($G(^DPT(DFN,.11)),"^",13)
 . I ADDRDTTM'="" W !," [PERMANENT ADDRESS LAST CHANGED:] "_$$FMTE^XLFDT(ADDRDTTM,"5D")
 . W:$D(TP1)>0 !," [HOME PHONE NUMBER CHANGED:] "_$$FMTE^XLFDT(TP1,"5D")
 . I $D(^DIA(2,"B",DFN)) S X3="" F I=1:1 S X3=$O(^DIA(2,"B",DFN,X3)) Q:X3<1  S:$P(^DIA(2,X3,0),U,3)=.31115 ES1=$P(^DIA(2,X3,0),U,2)
 . W:$D(ES1)>0 !," [EMPLOYMENT STATUS CHANGED:] "_$$FMTE^XLFDT(ES1,"5D")
 . ; The IB Insurance API does not provide date entered or edited information, so this information will not be displayed for preregistration
 . I $$INSUR^IBBAPI(DFN,"","AR",.DGDATA,"1,10,11") F DGI=0:0 S DGI=$O(DGDATA("IBBAPI","INSUR",DGI)) Q:'DGI  D
 .. W !," [INSURANCE:] ",$P(DGDATA("IBBAPI","INSUR",DGI,1),U,2)
 .. W "  EFFECTIVE DATE: ",$$FMTE^XLFDT(DGDATA("IBBAPI","INSUR",DGI,10),"5D"),"  EXPIRATION DATE: ",$$FMTE^XLFDT(DGDATA("IBBAPI","INSUR",DGI,11),"5D")
 ;
 W !
 G ^DGRPP
 ;
GETNCAL ;Get name component values
 N DGCOMP,DGNC,DGI,DGA,DGALIAS,DGX,DGRPW
 S DGNC="Family^Given^Middle^Prefix^Suffix^Degree"
 S DGCOMP=+$G(^DPT(DFN,"NAME"))_","
 I DGCOMP D GETS^DIQ(20,DGCOMP,"1:6",,"DGCOMP")
 ;Get alias values
 S DGA=0 F DGI=1:1:5 D  Q:'$D(DGALIAS(DGI))
A2 .S DGA=$O(^DPT(DFN,.01,DGA))
 .I 'DGA D:DGI=1  Q
 ..S DGALIAS(DGI)="< No alias entries on file >" Q
 .I DGI=5 S DGALIAS(DGI)="< More alias entries on file >" Q
 .S DGX=$G(^DPT(DFN,.01,DGA,0)) G:'$L(DGX) A2
 .S DGALIAS(DGI)=$P(DGX,U),DGX=$P(DGX,U,2)
 .I $L(DGX) D
 ..S DGX=" "_$E(DGX,1,3)_"-"_$E(DGX,4,5)_"-"_$E(DGX,6,9)
 ..; BAJ DG*5.2*700 retrofit 06/22/06
 ..S DGALIAS(DGI)=$E(DGALIAS(DGI),1,19)
 ..S $E(DGALIAS(DGI),20)=DGX Q
 .S DGALIAS(DGI)=$E(DGALIAS(DGI),1,32)
 .Q  ;
 ;Display name component, sex, multiple birth indicator and alias data
 F DGI=1:1:6 D
 .; DG*5.3*985; jam - Move fields 2 chars over to the left to align with fields above
 .W !?3,$J($P(DGNC,U,DGI),6),": ",$E($G(DGCOMP(20,DGCOMP,DGI)),1,$S(DGI=1:28,1:27))
 .; BAJ DG*5.3*700 retrofit 06/22/06
 .; ob - 10/22/14 added "Birth" on the next line
 .I DGI=1 S (Z,DGRPW)=1 W ?37,"Birth Sex: " S X=$P(DGRP(0),"^",2),Z=$S(X="M":"MALE",X="F":"FEMALE",1:DGRPU),Z1=3 D WW1^DGRPV ;DG*5.3*907
 .I DGI=1 S (Z,DGRPW)=1 W ?56,"MBI: " S X=$P($G(^DPT(DFN,"MPIMB")),U),Z=$S(X="N":"NO",X="Y":"*MULTIPLE BIRTH*",1:DGRPU),Z1=16 D WW1^DGRPV
 .I DGI=2 S DGRPW=0,Z=2 W ?37 D WW^DGRPV W " Alias: "
 .I DGI>1 W ?47,$G(DGALIAS(DGI-1))
 ;*** display Self-Identified Gender Identity DG*5.3*907
 ;Get node with SIGI in it already done at EN+1
 W !?3,"Self-Identified Gender Identity: "
 S X=$P(DGRP(.24),"^",4),Z=$S(X="M":"MALE",X="F":"FEMALE",X="TM":"TRANSMALE/TRANSMAN/FEMALE-TO-MALE",X="TF":"TRANSFEMALE/TRANSWOMAN/MALE-TO-FEMALE",X="O":"OTHER",X="N":"INDIVIDUAL CHOOSES NOT TO ANSWER",1:DGRPU) W Z ;D WW1^DGRPV
 ; *** end of change 
 Q
GETSTAT(SSNV) ;get SSN VERIFIED STATUS DG*5.3*688 BAJ 11/22/2005
 N T
 S T=$P($G(^DPT(DFN,"SSN")),"^",2)
 S SSNV=$S(T=2:"INVALID",T=4:"VERIFIED",1:"")
 Q
 ;
SSNREAS(DGREAS) ;get Pseuso SSN Reason - DG*5.3*653, ERC
 S DGREAS=$P(DGRP("SSN"),U)
 I $G(DGREAS)']"" Q
 S DGREAS=$S(DGREAS="R":"Refused to Provide",DGREAS="S":"SSN Unknown/Follow-up Required",DGREAS="N":"No SSN Assigned",1:"< None Entered >")
 Q
