RAORDR ;ABV/SCR/MKN - Refer Pending/Hold Requests ; Dec 04, 2019@12:37:22
 ;;5.0;Radiology/Nuclear Medicine;**148,161**;Mar 16, 1998;Build 1
 ;
 Q
 ;
 ; Routine              IA          Type
 ; -------------------------------------
 ; DEM^VADPT           10061        (S)
 ; ^DIWP               10011        (S)
 ; ^SC(                10040        (S)
 ; ^VA(200             10060        (S)
 ; ^DPT(               10035        (S)
 ; CMT^ORQQCN2         TBR
 ; ^OR(100             5771,6475    (C)
 ; ^GMR(123            6116,2586    (C)
 ;
ENT ;
 ;
 N DIC,DIR,DIRUT,DTOUT,DUOUT,QQ,RA123IEN,RA44NA,RAANS,RAANS2,RAARAY,RAARRAY
 N RACDW,RACDWN,RACIENS,RACOMCT,RACNT,RACOM,RACOUNT,RADD,RADFN,RADT,RAEND
 N RAERR,RAEXPL,RAF,RAHDR,RAI,RAILOC,RAJUST,RAJUST2,RAILOC1,RALOCNM,RAMAND
 N RAN,RANOW,RANOW2,RAO,RAOBEG,RAOEND,RAOIFN,RAOPHY,RAORD0,RAORDIEN,RAPOP
 N RAPR,RAPRTYDT,RAQUES,RAQUIT,RAREASON,RAREQSTA,RARES,RASELOC,RASTART,RASUB
 N RAT,RAUCID,X,Y
 ;
 S (RAARRAY,RACIENS,RAILOC)=""
GETPAT ;
 S (RACOUNT,RASELOC)=0 K RAEOS
 K DIC,DIRUT,^TMP("RAORDR",$J),RAARRAY
 S DIC="^DPT(",DIC(0)="AEMQ" D ^DIC K DIC
 I $D(DIRUT) S RAQUIT=1
 Q:$G(RAQUIT)!($G(Y)=-1)
 S RADFN=+Y
 K DIR S DIR(0)="E" D ^DIR G:'+Y GETPAT
 S Y="P",RAQUIT=0
 W !
 S RACOUNT=0
 F RAREQSTA=3,5,8 S RAOIFN=0 F  S RAOIFN=$O(^RAO(75.1,"AS",RADFN,RAREQSTA,RAOIFN)) Q:'RAOIFN!($D(RAEOS))  D
 . I $D(^RAO(75.1,RAOIFN,0)) D
 . . S RAO(0)=^RAO(75.1,RAOIFN,0) I RAREQSTA=3&($P(RAO(0),U,7)) Q:$$AUTOHOLD($P(RAO(0),U,7))
 . . S RAOPHY=$P(RAO(0),U,14)
 . . S RALADT=$P(RAO(0),U,21)
 . . S RACOUNT=RACOUNT+1,RAARRAY(RACOUNT)=RAOIFN
 I '$D(RAARRAY(1)) W !,"No Imaging orders found for this patient",! G GETPAT
 S (RACOUNT,RAF,RARES)=0
 D GETORD
 G:'RARES GETPAT
 S RAORDIEN=$$MAKECONS^RAORDR1($G(RAARRAY(Y)))
 ;Add comments to Consult that was just created
 S RAUCID="",RA123IEN=$G(^OR(100,RAORDIEN,4)) I $P(RA123IEN,";",2)="GMRC" D
 . S RA123IEN=+RA123IEN,RAUCID=$$GET1^DIQ(123,RA123IEN,80)
 . D:RA123IEN&($D(RAEXPL(RAANS2)))
 . . S RAI="",RACOMCT=0 F  S RAI=$O(RACDW(RAANS,RAANS2,RAI)) Q:RAI=""  D
 . . . S RACOMCT=RACOMCT+1,RACOM(RACOMCT)=$P(RACDW(RAANS,RAANS2,RAI),U)
 . . . I $P(RACDW(RAANS,RAANS2,RAI),U,2)]"",$G(RAEXPL(RAANS2))]"" D ADDEXPL
 . . S RADT=$$NOW^XLFDT()
 . . L +^GMR(123,RA123IEN):5 I '$T D ERROR^RAORDR1("Consult record locked, cannot update comments.") Q  ;p161 -Lock consult
 . . D CMT^ORQQCN2(.RAERR,RA123IEN,.RACOM,"N","",RADT)
 . . L -^GMR(123,RA123IEN)
 . D:RA123IEN&(RAANS2=0)
 . . S RAI="",RACOMCT=0 F  S RAI=$O(RACDW(RAANS,RAI)) Q:RAI=""  D
 . . . S RACOMCT=RACOMCT+1 S:$P(RACDW(RAANS,RAI),U)]"" RACOM(RACOMCT)=$P(RACDW(RAANS,RAI),U)
 . . . I $P(RACDW(RAANS,RAI),U,2)]"",$G(RAEXPL)]"" D ADDEXPLS
 . . S RADT=$$NOW^XLFDT()
 . . L +^GMR(123,RA123IEN):5 I '$T D ERROR^RAORDR1("Consult record locked, cannot update comments.") Q  ;p161 -Lock consult
 . . D CMT^ORQQCN2(.RAERR,RA123IEN,.RACOM,"N","",RADT)
 . . L -^GMR(123,RA123IEN)
 . W !!,"Consult with UCID: "_$S(RAUCID]"":RAUCID,1:"(Not known)")," has been created",!
 . I 'RA123IEN W !!,"**NO Consult created**",!
 D KILL
 G GETPAT
 ;
ADDEXPL ;
 N I,L,X
 S X=$P($G(RAEXPL(RAANS2)),U,2)
 S RACOM(RACOMCT)=RACOM(RACOMCT)_$S(X]"":":",1:"")
 I X]"" D BRKLINE(.L,X,74) D
 .S I="" F  S I=$O(L(I)) Q:'I  S RACOMCT=RACOMCT+1,RACOM(RACOMCT)=L(I)
 Q
 ;
ADDEXPLS ;
 N I,X,L
 S X=RAEXPL
 I $D(RACOM(RACOMCT)) D  Q
 .S RACOM(RACOMCT)=RACOM(RACOMCT)_$S(X]"":":",1:"")
 .I X]"" D BRKLINE(.L,X,74) D
 ..S I="" F  S I=$O(L(I)) Q:'I  S RACOMCT=RACOMCT+1,RACOM(RACOMCT)=L(I)
 D BRKLINE(.L,X,74)
 S I="" F  S I=$O(L(I)) Q:'I  S RACOM(RACOMCT)=L(I),RACOMCT=RACOMCT+1
 Q
 ;
KILL ;
 K DIC,DIR,DIRUT,QQ,RA123IEN,RA44NA,RAANS,RAANS2,RAARAY,RAARRAY,RACDW,RACDWN,RACIENS,RACOMCT,RACNT,RACOM
 K RACOUNT,RADD,RADFN,RADT,RAEND,RAERR,RAEXPL,RAF,RAHDR,RAI,RAILOC,RAJUST,RAJUST2,RAILOC1,RALOCNM,RAN,RANOW
 K RANOW2,RAO,RAOBEG,RAOEND,RAOIFN,RAOPHY,RAORD0,RAORDIEN,RAPOP,RAPR,RAPRTYDT,RAQUES,RAQUIT,RAREASON
 K RAREQSTA,RARES,RASELOC,RASTART,RASUB,RAT,RAUCID,X,Y
 S (RACIENS,RAILOC)=""
 Q
 ;
AUTOHOLD(ORIFN) ;
 ;Return:
 ;  0 if this consult was placed on Hold other than as a result of auto-submission following an imaging order
 ;  1 if this consult was placed on Hold as a result of auto-submission following an imaging order
 N OR123,ORACT,ORCCFND,X
 Q:'ORIFN
 S (ORACT,ORCCFND)=0 F  S ORACT=$O(^OR(100,ORIFN,8,ORACT)) Q:'ORACT  S X=$G(^OR(100,ORIFN,8,ORACT,1)) D:X]""
 .I X["Placed on hold due to transfer to Community Care with UCID" S X=$P(X,"UCID",2) D
 ..S X=$P(X,"_",2) I X?1.N,$D(^GMR(123,X)) S ORCCFND=1 Q
 Q ORCCFND
 ;
HDR ; header
 W:$Y>0 @IOF
 W !?(80-$L(RAHDR)/2),RAHDR
 W !,"PATIENT NAME",?35,"SSN",?47,"PROCEDURE"
 W !,?10,"DATE DESIRED",?25,"DATE ORDERED",?55,$S(RAREQSTA=3:"HOLD DT",1:"ORDERING PROVIDER")
 W !?10,"IMAGING LOCATION",?50,"REQUEST STATUS"
 W !,QQ
 W !
 Q
GETORD ;
 N DFN,RADFNARY,RALADT,RAMORE,RAQUIT,RAREA,VADM
 K VADM S DFN=RADFN D DEM^VADPT
 S RACOUNT=0
 S QQ="",$P(QQ,"=",80)="="
SELORDER ;
 S RAHDR="SELECT FROM IMAGING ORDERS"
 D HDR Q:$D(RAEOS)
 S (RAMORE,RAQUIT)=0 F  Q:RAQUIT  S RACOUNT=$O(RAARRAY(RACOUNT)) Q:'RACOUNT!(RAQUIT)  S RAO=RAARRAY(RACOUNT) D
 .S:RACOUNT RAT=RACOUNT S:RAF=0 RAF=RAT
 .S RAORD0=^RAO(75.1,+RAO,0),RADT=$P(RAORD0,U,21),RALADT=$P(RAORD0,U,16),RAPR=$P(RAORD0,U,2),RASELOC=$P(RAORD0,U,20)
 .S Y=RADT
 .D DD^%DT
 .S RADD=Y
 .S Y=$P(RALADT,".")
 .D DD^%DT
 .S RAPRTYDT=Y
 .W !,RACOUNT_". ",$E(VADM(1),1,31)
 .W ?35,"*****",$E(VADM(2),$L(VADM(2))-3,$L(VADM(2)))
 .W ?47,$S($D(^RAMIS(71,RAPR,0)):$E($P(^(0),U),1,24),1:"Unknown")
 .W !,?10,RADD,?25,RAPRTYDT,?57,$E($P($G(^VA(200,RAOPHY,0)),U,1),1,23)
 .W !?10,$S('RASELOC:"Unknown",$D(^RA(79.1,RASELOC,0)):$S($D(^SC($P(^(0),U),0)):$P(^(0),U),1:"Unknown"),1:"Unknown")
 .W ?50,$$GET1^DIQ(75.1,+RAO_",",5,"E")
 .S:$Y>20 RAQUIT=1
 K DIR,DIRUT S RACIENS=""
 S DIR(0)="NO^"_RAF_":"_RAT
 S DIR("A")="Select NUMBER of ORDER to be REFERRED to COMMUNITY CARE"
 I RAT?1.N,RACOUNT]"",$O(RAARRAY(RACOUNT))]"" S DIR("A")=DIR("A")_" or press Enter for more orders" S RAMORE=1
 E  S $P(DIR(0),U)="N" ;Remove "O" flag
 D ^DIR
 K DIR
 I Y=""&(RAMORE) S RAF=0 G SELORDER
 Q:Y=""&('RAMORE)
 Q:$D(DIRUT)
 W !,"You selected number "_Y
 S RARES=Y
 Q
GETINFO(RAARAY) ;this function collects information that would be collected from a SEOC in Consult Toolbox
 N DIR,DIRUT,RACOUNT,RAGMRC1,RARPT,Y
 ;
 S (RAJUST,RAQUIT,RARPT)=0
 D SETJUST2 ;Set up RAJUST array with prompts
 D GETMAIN
 S:'$D(RAARAY("TYPEOFSERVICE")) RAARAY("TYPEOFSERVICE")="4^Diagnostic"
 S RAARAY("THIRDPARTY")="2^NO"
 S RAARAY("TRAUMA")="2^NO"
 Q
 ;
SETJUST2 ;Build RAJUST
 N I,LAST,X
 S LAST="",(RAANS,RAANS2)=0
 ;First build RAJUST array with questions
 F I=1:1 S X=$T(JUSTQ+I) Q:X=" ;//"  S OPT=$P(X,";",2),I=$$JUSTMAIN(OPT,I)
 Q
 ;
JUSTMAIN(OPT,LINE) ;
 N J,RET,X
 S RET=LINE
 F J=LINE:1 S X=$T(JUSTQ+J) Q:X=" ;//"  Q:$P(X,";",2)'=OPT  S RET=J D
 .I $P(X,";",3)'="CDW",$P(X,";",3)'="S" S RAJUST(OPT)=$P(X,";",3) Q
 .I $P(X,";",3)="S" S J=$$JUSTSUB(OPT,J) Q
 .I $P(X,";",3)="CDW" S RAJUST(OPT,"CDW",$P(X,";",4))=$P(X,";",5) D  Q
 ..I $P(X,";",3)="CDW",$P(X,";",6)="ASK" S RAJUST(OPT,"CDW",$P(X,";",4),"ASK")=$P(X,";",7) D
 ...I $P(X,";",8) S RAJUST(OPT,"CDW",$P(X,";",4),"MAND")=1
 Q RET
 ;
JUSTSUB(PARENT,LINE) ;
 N J,OPT,RET,X
 F J=LINE:1 S X=$T(JUSTQ+J) Q:X=" ;//"  S RET=J S:J=LINE OPT=$P(X,";",2) Q:PARENT'=OPT  D
 .I $P(X,";",5)'="CDW" S RAJUST(PARENT,"S",$P(X,";",4))=$P(X,";",5) Q
 .I $P(X,";",5)="CDW" S:$P(X,";",7)'="" RAJUST(PARENT,"S",$P(X,";",4),"CDW",$P(X,";",6))=$P(X,";",7) D
 ..I $P(X,";",8)="ASK" S RAJUST(PARENT,"S",$P(X,";",4),"CDW",$P(X,";",6),"ASK")=$P(X,";",9) D
 ...I $P(X,";",10) S RAJUST(PARENT,"S",$P(X,";",4),"CDW",$P(X,";",6),"MAND")=1
 Q RET
 ;
GETMAIN ;Ask the main questions and fill in the answers at tag GETJSUB
 N RAL
 W !!,"Justification for Community Care"
 K DIR S RAL=0,DIR(0)="S^" F I=1:1 S X=$G(RAJUST(I)) Q:X=""  S DIR(0)=DIR(0)_I_":"_$P($P(X,U),";")_";",RAL=RAL+1
 S DIR(0)=$E(DIR(0),1,$L(DIR(0))-1)
 D ^DIR
 I $D(DIRUT) S RAQUIT=1
 S:'RAQUIT RAARAY("JUSTIFICATION")=Y_U_Y(0) ;This array entry is used for Reason for Request WP in Consult
 K DIR,DIRUT
 Q:RAQUIT
 S RAANS=+Y,RAREASON=RAJUST(RAANS) ; Reason for Request
 ;
 ;Now check if there are any main questions or any sub-questions
GETJSUB ;
 ;
 S RARPT=0 K RAEXPL
 I '$D(RAJUST(RAANS,"S")) S RAANS2=0 D  G:RARPT GETMAIN Q
 . ;Set CDW up for main menu item. Ask any text questions if needed
 . S RACDWN="" F  S RACDWN=$O(RAJUST(RAANS,"CDW",RACDWN)) Q:RACDWN=""  D
 . . S RACDW(RAANS,RACDWN)=RAJUST(RAANS,"CDW",RACDWN)_U_$G(RAJUST(RAANS,"CDW",RACDWN,"ASK"))
 . . S RAQUES=$G(RAJUST(RAANS,"CDW",RACDWN,"ASK"))
 . . S RAMAND=$G(RAJUST(RAANS,"CDW",RACDWN,"MAND"))
 . . I RAQUES]"" D
 . . . K DIR S DIR(0)="F"_$S('RAMAND:"O",1:"")_"^3:240",DIR("A")=RAQUES
 . . . S DIR("?")=RAQUES_": 3-240 characters"
 . . . S DIR("??")="^D HELP^RAORDR("_$C(34)_RAQUES_": 3-240 characters"_$C(34)_")"
 . . . D ^DIR
 . . . I $D(DUOUT)!($D(DTOUT)) S RARPT=1 Q
 . . . S RAEXPL=Y
 . . . S:RAEXPL]"" RAARAY("JUSTIFICATION EXPLANATION")="  "_RAEXPL
 ;
 ;Sub-menu questions
 W !!,$P(RAJUST(RAANS),U)
 K DIR S DIR(0)="S^",RASUB="" F  S RASUB=$O(RAJUST(RAANS,"S",RASUB)) Q:RASUB=""  D
 . S DIR(0)=DIR(0)_RASUB_":"_RAJUST(RAANS,"S",RASUB)_";"
 . S RACDWN="" F  S RACDWN=$O(RAJUST(RAANS,"S",RASUB,"CDW",RACDWN)) Q:RACDWN=""  D
 . . S RACDW(RAANS,RASUB,RACDWN)=RAJUST(RAANS,"S",RASUB,"CDW",RACDWN)_U_$G(RAJUST(RAANS,"S",RASUB,"CDW",RACDWN,"ASK"))
 . . S RAEXPL(RASUB)=$P(RACDW(RAANS,RASUB,RACDWN),U,2)
 . . S RAEXPL(RASUB,"MAND")=$G(RAJUST(RAANS,"S",RASUB,"CDW",RACDWN,"MAND"))
 S DIR(0)=$E(DIR(0),1,$L(DIR(0))-1)
 S DIR("A")="Select Reason for "_$P(RAJUST(RAANS),U)
 D ^DIR
 G:$D(DUOUT)!($D(DTOUT)) GETMAIN
 S RAANS2=+Y
 ;If the sub-question requires a reason, ask it now
 S RARPT=0
 I $G(RAEXPL(RAANS2))]"" D  G:RARPT GETJSUB ;^ entered by user in SUB-QUESTION field - go back to Justification question
 . S RAMAND=$G(RAEXPL(RAANS2,"MAND"))
 . K DIR S DIR(0)="F"_$S('RAMAND:"O",1:"")_"^3:240",DIR("A")=$G(RAEXPL(RAANS2))
 . S DIR("?")="Enter "_$G(RAEXPL(RAANS2))_": 3-240 characters"
 . S DIR("??")="^D HELP^RAORDR("_$C(34)_"Enter "_$G(RAEXPL(RAANS2))_": 3-240 characters"_$C(34)_")"
 . D ^DIR
 . I $D(DUOUT)!($D(DTOUT)) S RARPT=1 Q
 . S $P(RAEXPL(RAANS2),U,2)=Y
 . S RAARAY("JUSTIFICATION SUBMENU SELECTION")=$P($P(RAJUST(RAANS,"S",RAANS2),U)," (")_$S(Y]"":":",1:"")
 . S:Y]"" RAARAY("JUSTIFICATION SUBMENU EXPLANATION")=Y
 ;
 Q
 ;
BRKLINE(OUT,LINE,LGTH) ;Break line down into 80 character lines in OUT
 N CT,DIWL,DIWR,I,X
 S LINE=$$TRIM^XLFSTR(LINE)
 K ^UTILITY($J,"W") S CT=0,DIWL=1,DIWR=LGTH,X=LINE D ^DIWP
 S I="" F  S I=$O(^UTILITY($J,"W",1,I)) Q:'I  S CT=CT+1,OUT(CT)=^UTILITY($J,"W",1,I,0)
 K ^UTILITY($J,"W")
 Q
 ;
HELP(MSG) ;
 W !!,MSG
 Q
 ;
JUSTQ ;Justification for Community Care prompts
 ;1;VA facility does not provide the required service
 ;1;CDW;1;#COI#
 ;1;CDW;2;COI-Veteran OPT-IN for Community Care
 ;1;CDW;3;Service Not Available: VA facility does not provide the required service
 ;2;Veteran cannot safely travel to VA facility due to medical reason
 ;2;CDW;1;#COI#
 ;2;CDW;2;COI-Veteran OPT-IN for Community Care
 ;2;CDW;3;Veteran cannot safely travel to VA facility due to medical reason
 ;2;CDW;4;;ASK;Medical reason
 ;3;Veteran cannot travel to VA facility due to geographical inaccessibility
 ;3;CDW;1;#COI#
 ;3;CDW;2;COI-Veteran OPT-IN for Community Care
 ;3;CDW;3;Geographical inaccessibility
 ;4;VA facility cannot timely provide the required service
 ;4;CDW;1;#COI#
 ;4;CDW;2;COI-Veteran OPT-IN for Community Care
 ;4;CDW;3;Wait Time: VA appointment is greater than Wait Time Standard (WTS)
 ;5;Unusual or excessive travel burden
 ;5;S;1;Geographical challenges
 ;5;S;1;CDW;1;#COI#
 ;5;S;1;CDW;2;COI-Veteran OPT-IN for Community Care
 ;5;S;1;CDW;3;UXB-Unusual or excessive travel burden
 ;5;S;1;CDW;4;GEO-Geographical challenges;ASK;Explain
 ;5;S;2;Environmental factors
 ;5;S;2;CDW;1;#COI#
 ;5;S;2;CDW;2;COI-Veteran OPT-IN for Community Care
 ;5;S;2;CDW;3;UXB-Unusual or excessive travel burden
 ;5;S;2;CDW;4;ENV-Environmental factors;ASK;Explain
 ;5;S;3;Medical condition
 ;5;S;3;CDW;1;#COI#
 ;5;S;3;CDW;2;COI-Veteran OPT-IN for Community Care
 ;5;S;3;CDW;3;UXB-Unusual or excessive travel burden
 ;5;S;3;CDW;4;MED-Medical condition;ASK;Explain
 ;5;S;4;Nature or simplicity of services
 ;5;S;4;CDW;1;#COI#
 ;5;S;4;CDW;2;COI-Veteran OPT-IN for Community Care
 ;5;S;4;CDW;3;UXB-Unusual or excessive travel burden
 ;5;S;4;CDW;4;Nature or simplicity of services;ASK;Explain;1
 ;//
