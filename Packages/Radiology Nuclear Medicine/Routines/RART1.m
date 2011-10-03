RART1 ;HISC/GJC,SWM-Reporting Menu (Part 2) ;05/13/09  08:05
 ;;5.0;Radiology/Nuclear Medicine;**8,16,15,21,23,27,34,99**;Mar 16, 1998;Build 5
 ;Print Report By Patient has been moved to 4^RART2!
 ;these sections are moved to ^RART3 : QRPT, PHYS, MODSET, OUT1
 ;RVD P99, add pregnancy screen and commment if populated for female pt.
CHK I 'RARPT!('$D(^RARPT(+RARPT,0))) W !?3,$C(7),"No report filed for case number ",RACN,"." K RARPT Q
 I $D(RADFT),$P(^RARPT(+RARPT,0),"^",5)'["D" W !?3,$C(7),"Report for case number ",RACN," is not in a 'draft' status." K RARPT Q
 I '$D(RADFT),$P(^RARPT(+RARPT,0),"^",5)["D" W !?3,$C(7),"Report filed for case number ",RACN," but not available for printing." K RARPT Q
 Q
 ;
5 ;;Draft Report (Reprint)
 D SETVARS Q:'($D(RACCESS(DUZ))\10)!('$D(RAIMGTY))  S RADFT="" G 4^RART2
 ;
6 ;;Display a Report By Patient
 W ! S DIC(0)="AEMQ" D ^RADPA G Q6:Y<0 S RADFN=+Y,RAHEAD="**** Patient's Exams ****",RAF1=1,RAREPORT=1 D ^RAPTLU G Q6:X="^" G 6:'$D(RADUP)
 I X=1 R X:3
OERR ;entry from RA OERR PROFILE protocol
 F RAI=0:0 S RAI=$O(RADUP(RAI)) Q:RAI'>0  S Y=^TMP($J,"RAEX",RAI) D 61,DISP Q:X="^"
 K RADUP,RAI,RAJ,X,^TMP($J,"RAEX") Q:$D(ORVP)  G 6
61 F RAJ=1:1:11 S @$P("RADFN^RADTI^RACNI^RANME^RASSN^RADATE^RADTE^RACN^RAPRC^RARPT^RAST","^",RAJ)=$P(Y,"^",RAJ)
 S Y(0)=^RADPT(RADFN,"DT",RADTI,"P",RACNI,0) Q
 ;
OERR1 ;Entry Point for Alert Follow-Up Action for OE/RR
 Q:'$D(XQADATA)!('$D(XQAID))  S (RARPT,Y)=XQADATA D RASET^RAUTL2
 S:Y Y(0)=Y,RANME=$S($D(^DPT(RADFN,0)):$P(^(0),"^"),1:"Unknown"),RAPRC=$S($D(^RAMIS(71,+$P(Y(0),"^",2),0)):$P(^(0),"^"),1:"Unknown")
 S RALERTS="" D DISP K:X="^" XQAID,XQAKILL
 I $D(XQAID) S DFN=$P(XQAID,",",2) D DELETE^XQALERT
 K RALERTS
 Q
 ;
DISP I RARPT,($D(RAPBRPT)),($P($G(^RARPT(+RARPT,0)),"^",5)="V") D  Q
 . ; This code will not allow a user to re-edit a verified report.
 . ; In this case, two or more possible users signed on to the same
 . ; Imaging location, asked to verify the reports of the same
 . ; Interpreting Radiology/Nuclear Medicine Physician.
 . ; For the 'On-line Verifying of Reports' option only!
 . N DIR,DIROUT,DIRUT,DTOUT,DUOUT,Y
 . ; removed  X  from N  so rtn RARTVER would quit if caret entered
 . W !!?10,"Since the time you selected this group of reports,",!?10,$P($G(^VA(200,+$P(^RARPT(+RARPT,0),"^",9),0)),U)," has verified the report for "
 . W !?10,$P($G(^DPT(+$P(^RARPT(+RARPT,0),"^",2),0)),U),"  case #",$P(^RARPT(+RARPT,0),"^"),".",$C(7)
 . S Y=$S($D(^TMP($J,"RA","DT",+$G(RARTDT),+$G(RARPT))):$P($P(^(RARPT),"/",2),U,3),$D(RARPTX(+$G(RPTX))):$P($P(RARPTX(+$G(RPTX)),"/",2),U,3),1:"")
 . I $D(^RAMIS(71,+Y,0)) W !?10,"Procedure ",$P(^(0),U)
 . W ! K DIR S DIR(0)="E" D ^DIR S RAVFIED=1
 . Q
 D HOME^%ZIS S OREND=1
 I 'RARPT!('$D(^RARPT(+RARPT,0))) D  G Q6
 . W !?3,$C(7),"No report filed for case number",$S($D(RACN):" "_RACN,1:""),"."
 . R X:3 ; D:$$IMAGE^RARIC1 DISPF^MAGRIC ;don't call MAG 111300
 . Q
 S RAST=$P(^RARPT(+RARPT,0),"^",5)
 I '$D(RARTVER),(RAST=""!(RAST["D")) D  G Q6
 . W !?3,$C(7),"Report filed for case number ",RACN," but not available for display."
 . R X:3 ; D:$$IMAGE^RARIC1 DISPF^MAGRIC ;don't call MAG 111300
 . Q
DISP1 I $S('$D(ORACTION):1,ORACTION'=8:1,'$D(X):0,X="T":1,1:0) W @IOF
 W !,RANME," (",$$SSN^RAUTL,")",?41,"Case No. ",?57,": ",$P($G(^RARPT(RARPT,0)),"^")," @",$E(RADATE,$L(RADATE)-4,$L(RADATE))
 W !,$E(RAPRC,1,40) I +$G(^RARPT(RARPT,"T")) W ?41,"Transcriptionist",?57,": ",$E($P($G(^VA(200,+^RARPT(RARPT,"T"),0)),"^"),1,20)
 N R3 S R3=$G(^RADPT(+$G(RADFN),"DT",+$G(RADTI),"P",+$G(RACNI),0))
 W !,"Req. Phys : ",$E($P($G(^VA(200,+$P(R3,"^",14),0)),"^"),1,25)
 S RAPREVER=+$P($G(^RARPT(RARPT,0)),"^",13) W ?41,"Pre-verified",?57,": ",$S($D(^VA(200,RAPREVER,0)):$E($P($G(^VA(200,RAPREVER,0)),"^"),1,24),1:"NO") K RAPREVER
 D PHYS^RART3
 ;Display Pregnancy Screen and Comments if respective field is filled and pt is female, patch #99
 I $$PTSEX^RAUTL8(RADFN)="F" D
 .W:$P(R3,U,32)'="" !,"Pregnancy Screen: ",$S($P(R3,"^",32)="y":"Patient answered yes",$P(R3,"^",32)="n":"Patient answered no",$P(R3,"^",32)="u":"Patient is unable to answer or is unsure",1:"")
 .N RAPCOMM S RAPCOMM=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"PCOMM"))
 .W:$P(R3,U,32)'=""&$L(RAPCOMM) !,"Pregnancy Screen Comment: ",RAPCOMM
 I $D(RAPBRPT),(RAST="PD") D
 . W !,"**Prob Text: "
 . I $G(^RARPT(+RARPT,"P"))]"" D
 .. S X=$G(^RARPT(+RARPT,"P"))
 .. D OUTTEXT^RAUTL9(X,"",10,70,13,"","!")
 .. Q
 . Q
 W !,$$REPEAT^XLFSTR("=",79)
 I $O(^RARPT(RARPT,1,0)) D MODSET^RART3
 I '$O(^RARPT(RARPT,1,0)) D
 . D MODS^RAUTL2,OUT1^RART3
 . I +$P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),"^",28) S X=$$RDIO1^RARTUTL1(+$P(^(0),"^",28))
 . Q:$L($G(X))  ; 'X' should be 'null' to continue
 . S:+$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"RX",0)) X=$$PHARM1^RARTUTL(RACNI_","_RADTI_","_RADFN_",")
 . Q
 Q:$G(X)="P"  G DISP1:$G(X)="T",Q6:$G(X)="^"
 I +$O(^RARPT(RARPT,"ERR",0)) W !?10,$$AMENRPT^RARTR2(),!
 ;
 ; Print the clinical history from file 70
 I +$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H",0)) D
 . K ^UTILITY($J,"W"),^(1) S X="",DIWL=3,DIWF="|WC75"
 . W !?3,"Clinical History:"
 . S RAP="H" D WRITEHX(RAP)
 . Q
 Q:$G(X)="P"  G DISP1:$G(X)="T",Q6:$G(X)="^"
 ;
 ; Print the additional report clinical history if defined and 
 ; different than the order clinical history.
 I +$O(^RARPT(RARPT,"H",0)) D
 . D CHKDUPHX Q:RADUPHX  ; Duplicate history
 . K ^UTILITY($J,"W"),^(1) S X="",DIWL=3,DIWF="|WC75"
 . W !?3,"Additional Clinical History:"
 . S RAP="AH" D WRITEHX(RAP)
 ;
 ; Print Report and Impression text
 F RAP="R","I" D  Q:X="^"!(X="P")!(X="T")
 . K ^UTILITY($J,"W"),^(1) S X="",DIWL=3,DIWF="|WC75"
 . W !?3,$S(RAP="R":"Report:",1:"Impression:") W:RAP="R" ?45,"Status: ",$$XTERNAL^RAUTL5(RAST,$P($G(^DD(74,5,0)),U,2))
 . W:RAP="R"&($E(RAST)="P") $C(7)
 . D WRITE
 . Q
 Q:X="P"  G DISP1:X="T",Q6:X="^"
 ; I $$IMAGE^RARIC1() D DISPF^MAGRIC ;don't call MAG 111300
 I $P($G(^RA(79.1,+$P(^RADPT(RADFN,"DT",RADTI,0),U,4),0)),U,18)="Y" D PRTDX^RART K RADXCODE
 Q:X="P"  G DISP1:X="T",Q6:X="^"
 ;
 I $D(ORVP) D
 .S RAVERF=+$P($G(^RARPT(+RARPT,0)),"^",9)
 .S RADFTSBN=$E($P($G(^VA(200,RAVERF,20)),"^",2),1,25)
 .S:RADFTSBN']"" RADFTSBN=$E($P($G(^VA(200,RAVERF,0)),"^"),1,25)
 .S RADFTSBT=$E($P($G(^VA(200,RAVERF,20)),"^",3),1,30)
 .S:RADFTSBT']"" RADFTSBT=$$TITLE^RARTR0(RAVERF)
 .W !!,"VERIFIED BY:",!?2,$S(RADFTSBN]"":RADFTSBN,1:"")
 .W:RADFTSBT]"" ", "_RADFTSBT
 Q:X="P"  G DISP1:X="T",Q6:X="^"
 ;
 K RAP I '$D(RARTVER) D WAIT Q:X="P"  G DISP1:X="T"
Q6 K %,DIC,DIWF,DIWL,DIWR,I,J,OREND,POP,RABTCH,RAF1,RAHEAD,RALOC,RANME,RAPAR,RAPRC,RAREPORT,RASEL,RASSN,RAST,RAV,RAXX,Y,X1,Z
 K RAVERF,RADFTSBN,RADFTSBT
 K DIW,DIWT,DN
 K C,DIPGM,DISYS,R1,RAIMGTYI,RAP
 K:'$D(RARTVER) RACN,RACNI,RADATE,RADFN,RADTE,RADTI,RARPT Q
 ;
WRITE K RAXX N Y
 F RAV=0:0 S RAV=$O(^RARPT(RARPT,RAP,RAV)) Q:RAV'>0  D  Q:X="^"!(X="P")!(X="T")
 . S RAXX=^RARPT(RARPT,RAP,RAV,0) S X=""
 . D WAIT:($Y+6)>IOSL&('$D(RARTVERF)) Q:X="^"!(X="P")!(X="T")
 . S X=RAXX D ^DIWP S X=""
 . Q
 Q:X="^"  D ^DIWW:$D(RAXX) Q
 ;
WRITEHX(RAP) ; Get and write the clinical history
 ;
 ;Input:   RAP        H = Clinical History from file 70
 ;                   AH = Additional Clinical History from file 74
 ;
 K RAXX N Y
 S RAV=0
 I RAP="H" D
 . F  S RAV=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H",RAV)) Q:RAV'>0  D  Q:X="^"!(X="P")!(X="T")
 . . S RAXX=^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H",RAV,0),X=""
 . . D WAIT:($Y+6)>IOSL&('$D(RARTVERF)) Q:X="^"!(X="P")!(X="T")
 . . S X=RAXX D ^DIWP S X=""
 . . Q
 I RAP="AH" D
 . F  S RAV=$O(^RARPT(RARPT,"H",RAV)) Q:RAV'>0  D  Q:X="^"!(X="P")!(X="T")
 . . S RAXX=^RARPT(RARPT,"H",RAV,0),X=""
 . . D WAIT:($Y+6)>IOSL&('$D(RARTVERF)) Q:X="^"!(X="P")!(X="T")
 . . S X=RAXX D ^DIWP S X=""
 . . Q
 Q:X="^"  D ^DIWW:$D(RAXX) Q
 ;
CHKDUPHX ; Check Duplicate History in file 70 and 74.
 ; Returns RADUPHX  1 = Duplicate
 ;                  0 = Different
 N RAX,RA74,RA70,RAOK,RAX1
 ; Initialize to Different
 S RADUPHX=0
 ; Quit if H node does not exist.  Could have been purged.
 I '$D(^RARPT(RARPT,"H")) S RADUPHX=1 Q
 S RA74=$O(^RARPT(RARPT,"H",""),-1)
 S RA70=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H",""),-1),RA701=$O(^(0))
 S RAX=RA74-RA70+1 Q:RAX'=1  ; begin comparison
 ; Check line by line of each file
 ; RAOK  1 = all lines match
 ;       0 = at least 1 difference
 S RAOK=1
 F RAX1=RA701:1:RA70 I ^RARPT(RARPT,"H",RAX1,0)'=^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H",RAX1,0) S RAOK=0 Q  ;can exit loop on 1st difference
 I 'RAOK Q
 S RADUPHX=1
 Q
 ;
WAIT ; user input, goto top, print, or continue
 S RARD(1)="Continue^continue normal processing"
 S:$D(RALERTS) RARD(2)="Print^print the entire report"
 S RARD(3)="Top^display the report from the beginning"
 S (RARD("B"),RARD("DTOUT"))=1
 S:$D(RALERTS) RARD("A")="Enter 'Top', 'Print'  or 'Continue':   "
 S:'$D(RALERTS) RARD("A")="Enter 'Top' or 'Continue':   "
 S RARD(0)="S" D SET^RARD K RARD S X=$E(X)
 I $D(RALERTS),(X="P") D QRPT^RART3
 Q:X="^"!(X="P")  W:X="C"&($D(RAP)) @IOF
 Q
 ;
LOCK(X,Y) ; Lock an entry
 W !!,$C(7),"Another user is editing this ",$S(X="R":"report (Case # "_Y_")",1:"exam (diagnostic code)"),".  Please try again later." H 4 Q
 ;
SETVARS ; Setup Rad/Nuc Med required variables
 I $O(RACCESS(DUZ,""))="" D SETVARS^RAPSET1(0)
 Q:'($D(RACCESS(DUZ))\10)
 I $G(RAIMGTY)="" D SETVARS^RAPSET1(1)
 Q
