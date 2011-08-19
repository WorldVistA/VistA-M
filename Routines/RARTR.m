RARTR ;HISC/CAH COLUMBIA/REB AISC/MJK,RMO-Queue/print Reports ;06/10/09  06:30
 ;;5.0;Radiology/Nuclear Medicine;**5,13,16,27,43,55,75,92,99**;Mar 16, 1998;Build 5
 ;Supported IA #2056 reference to GET1^DIQ
PRT ; Begin print/build of e-mail message
 ;
 ; ** NOTE: If the layout of this output is changed  **
 ; **       please check that routine RAO7PC3 is     **
 ; **       not affected. It assumes fixed format of **
 ; **       the following headings:                  **
 ; **            Clinical History:                   **
 ; **            Report:                             **
 ; **            Impression:                         **
 ; **            Primary Diagnostic Code:            **
 ; **            Secondary Diagnostic Codes:         **
 ; **            Primary Interpreting Staff:         **
 ;
 Q:'$D(^RARPT(+$G(RARPT),0))
 ; Use and Set if running in the foreground and Writing to the device
 I '$D(RAUTOE) D
 . U IO
 . S RAFFLF=IOF
 . S RAORIOF=RAFFLF
 ;
 W:$Y>0&('$D(RAUTOE)) @RAFFLF   ; If RAUTOE defined build mail msg
 S X=$G(^RARPT(+$G(RARPT),0))   ;  RAORIOF=RAFFLF
 ;
 ;S RAFFLF=$S('$D(ORACTION):RAFFLF,ORACTION'=8:RAFFLF,1:"!")
 D INIT ; setup exam/report variables
 ;start p99
 I $$PTSEX^RAUTL8(RADFN)="F",'$D(RAUTOE) D
 .N RA700332,RA700380 S RA700332=$$GET1^DIQ(70.03,$G(RACNI)_","_$G(RADTI)_","_$G(RADFN),32)
 .W:RA700332'="" !,"Pregnancy Screen: ",RA700332
 .S RA700380=$$GET1^DIQ(70.03,$G(RACNI)_","_$G(RADTI)_","_$G(RADFN),80)
 .I (RA700332'="Patient answered no"),(RA700380'="") S RA700380="Pregnancy Screen Comment: "_RA700380 D OUTTEXT^RAUTL9(RA700380,"",1,75,"","!","")
 .W !
 ;end of p99
 I RAY0<0!(RAY1<0)!(RAY2<0)!(RAY3<0) K RAFFLF Q  ; data nodes missing
 ;
PRT1 I $D(RAUTOE) D
 . S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=" "
 . I $D(RADDEN) D
 .. S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="Report Unverified by: "_$P($G(^VA(200,$S($G(RADUZ):RADUZ,1:DUZ),0)),"^")
 .. Q
 . Q
 I +$O(^RARPT(RARPT,"ERR",0)) D
 . S RAERRFLG="" ; set for future reference (display AMENRPT^RARTR text)
 . W:'$D(RAUTOE) !!?10,$$AMENRPT^RARTR2(),!
 . I $D(RAUTOE) D
 .. S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=" "
 .. S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="         "_$$AMENRPT^RARTR2()
 .. Q
 . Q
 I $P(RAY3,"^",25)<2 D  G END:$D(RAOOUT)
 . D MODS^RAUTL2,OUT1^RARTR3
 . D:+$P(RAY3,"^",28) RDIO^RARTUTL(+$P(RAY3,"^",28))  Q:$D(RAOOUT)
 . D:+$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"RX",0)) PHARM^RARTUTL(RACNI_","_RADTI_","_RADFN_",")
 . ;W:'$D(RAUTOE) !
 . S:$D(RAUTOE) ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=""
 . Q
 I $P(RAY3,"^",25)>1 D
 . D MEMS1^RARTR3
 . W:'$D(RAUTOE) !
 . S:$D(RAUTOE) ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=""
 . Q
 G END:$D(RAOOUT)
 ; Check for duplicate history in file 70 and 74.
 D CHKDUPHX^RART1  ; Sets RADUPHX to 1 for duplicate or 0 if different.
 F RAP="H","AH","R","I" K ^UTILITY($J,"W"),^(1) D  G END:$D(RAOOUT)
 . S RAP("P")=$S(RAP="H":"Clinical History:",RAP="AH":"Additional Clinical History:",RAP="R":"Report:",1:"Impression:")
 . ; Don't continue if printing Additional Clinical History and it is a
 . ; duplicate of Clinical History.
 . Q:RAP="AH"&(RADUPHX>0)
 . W:'$D(RAUTOE) !?RATAB,RAP("P")
 . I $D(RAUTOE),($D(RADDEN)),(RAP="R") D
 .. N RABAN1,RABAN2,RASPCE S $P(RASPCE," ",46)=""
 .. S RABAN1="*** Uncorrected Version   ***"
 .. S RABAN2="*** Refer to final report ***"
 .. S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=""
 .. S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=RASPCE_RABAN1
 .. S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=RASPCE_RABAN2
 .. S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=""
 .. Q
 . S:$D(RAUTOE) ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="    "_RAP("P")
 . W:$D(RASTFL)&(RAP="R")&('$D(RAUTOE)) ?45,"Status: ",$$XTERNAL^RAUTL5(RAST,$P($G(^DD(74,5,0)),"^",2))
 . I RAP="R",($D(RAUTOE)) D
 .. S $P(RAP("S")," ",(46-$L(^TMP($J,"RA AUTOE",RAACNT))))=""
 .. I '$D(RADDEN) S ^TMP($J,"RA AUTOE",RAACNT)=^(RAACNT)_RAP("S")_"Status: "_$$XTERNAL^RAUTL5(RAST,$P($G(^DD(74,5,0)),"^",2))
 .. Q
 . D:$D(RAUTOE) SET^RARTR2
 . D:'$D(RAUTOE) WRITE^RARTR2 Q:$D(RAOOUT)
 . K ^UTILITY($J,"W")
 . Q
 I $D(RADDEN),($G(^RARPT(RARPT,"PURGE"))) D
 . ; when the report is unverified and purge data exists (rpt adden)
 . N RAPRGE S RAPRGE=+$G(^RARPT(RARPT,"PURGE"))
 . S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=""
 . S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="Report Purged: "_$$FMTE^XLFDT(RAPRGE,"1P")
 . S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=""
 . Q
 I $P($G(^RA(79.1,+$P(RAY2,U,4),0)),U,18)="Y" D PRTDX^RARTR1 G:$D(RAOOUT) END ;print dx codes
 D EN1^RARTR0 G:$D(RAOOUT) END
 I '$D(RAVERFND) D  G END:$D(RAOOUT)
 . I '$D(RAUTOE) D:($Y+RAFOOT+4)>IOSL HANG^RARTR2 Q:$D(RAOOUT)  D HD:($Y+RAFOOT+4)>IOSL
 . N RADFTSBN,RADFTSBT S:$D(RADDEN) RAVERF=+$P(RA74B4,"^",9)
 . S RADFTSBN=$E($P($G(^VA(200,RAVERF,20)),"^",2),1,25)
 . S:RADFTSBN']"" RADFTSBN=$E($P($G(^VA(200,RAVERF,0)),"^"),1,25)
 . S RADFTSBT=$E($P($G(^VA(200,RAVERF,20)),"^",3),1,30)
 . I RADFTSBT']"" S RADFTSBT=$$TITLE^RARTR0(RAVERF)
 . W:'$D(RAUTOE) !!,"VERIFIED BY:",!?2,$S(RADFTSBN]"":RADFTSBN,1:"")
 . W:RADFTSBT]""&('$D(RAUTOE)) ", "_RADFTSBT
 . I $D(RAUTOE) D
 .. S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="VERIFIED BY:"
 .. S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="  "_$S(RADFTSBN]"":RADFTSBN,1:"")_$S(RADFTSBT]"":", "_RADFTSBT,1:"")
 .. S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=""
 .. Q
 . Q
 K RASBPN,RASBT,RASECIEN,RASECOND,RASECSS
 I '$D(RAUTOE) D:($Y+RAFOOT+4)>IOSL HANG^RARTR2 G END:$D(RAOOUT) D HD:($Y+RAFOOT+4)>IOSL
 W:'$D(RAUTOE) !!,$S($D(^RABTCH(74.2,+RABTCH,0)):$P(^(0),"^"),1:""),"/" I +$G(^RARPT(RARPT,"T")),$D(^VA(200,+$P(^RARPT(RARPT,"T"),"^"),0)) W:'$D(RAUTOE) $P(^(0),"^",2)
 S:$D(RAUTOE) ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=$P($G(^RABTCH(74.2,+RABTCH,0)),"^")_"/"_$S(+$G(^RARPT(RARPT,"T"))&($D(^VA(200,+$P($G(^RARPT(RARPT,"T")),"^"),0))):$P(^(0),"^",2),1:"")
 S:$D(RAUTOE) ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=""
 D HANG^RARTR2 G END:$D(RAOOUT)
 I RAST'="V" D:'$D(RAMDV) SETDIV^RARTR2 I $P(RAMDV,U,25) D WARNING^RARTR1
 G PEND:RAST'="PD"
 S $P(RASTRSK,"*",80)=""
 I '$D(RAUTOE) D
 . D HD:($Y+RAFOOT+9)>IOSL
 . W !,$E(RASTRSK,1,22)," P R O B L E M   S T A T E M E N T ",$E(RASTRSK,1,22)
 . W !!,$S($D(^RARPT(RARPT,"P")):^("P"),1:"None entered.") W !!,RASTRSK
 . Q
 E  D
 . S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=$E(RASTRSK,1,22)_" P R O B L E M   S T A T E M E N T "_$E(RASTRSK,1,22)
 . S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=$S($D(^RARPT(RARPT,"P")):^("P"),1:"None entered.")
 . S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=""
 . Q
PEND D FOOT^RARTR2,HANG^RARTR2 D:'$D(RAMIE)&('$D(RAUTOE)) Q^RAFLH1
END K:$D(RAOOUT) XQAID,XQAKILL
 K %I,%W,%Y1,C,DN,I,RADXCODE,RARTMES,RAVERF,RAVERFND,RAPVERF
 K RAVERS,RAFOOT,RAY0,RAY1,RAY2,RAY3,RALOC,RAFMT,RAMOD,RASTFL,RALB,RALBR
 K RALBRT,RALBS,RALBST,RAV,RAP,RATAB,RAXX,VAL,VAR,RADFN,RADTI,RACN,RADTE
 K RARPT,RAHDFM,RAFTFM,RAV,RAIOF,RABTCH,RAOOUT,RAPIR,RAPIS,VAERR,Z
 ; K RASTRSK S RAFFLF=RAORIOF K RAORIOF,RAFFLF,RAERRFLG
 ; 05/15/08 BAY/KAM Patch RA*5*92 Added Conditional Kill to next line
 ; to support an AMIE interface (IA 708)
 K RASTRSK,RAORIOF,RAFFLF,RAERRFLG K:'($D(RAMIE)#2) DFN
 ;the next kill line corrects the CPRS V27 report display issue when repeated
 ;on same patient P92
 K %,DIW,DIWF,DIWI,DIWL,DIWT,DIWTC,DIWX,RAACNT,RADUPHX,RANUM,RAREZON,RAST
 Q
Q ; Queue the report
 S ZTDTH=$H,ZTRTN="DQ^RARTR",ZTSAVE("RARPT")="" S:$D(RARTMES) ZTSAVE("RARTMES")=""
 D ZIS^RAUTL Q:RAPOP
 ;
DQ S U="^",X="T",%DT="" D ^%DT K %DT S DT=Y G PRT
 ;
INIT ; initialize exam/report variables
 ; main variables set:
 ; RAY0: zero node data from the Patient File (2)
 ; RAY1: zero node data from the Rad/Nuc Med Patient File (70)
 ; RAY2: Registered Exams (70.02) zero node data
 ; RAY3: Examinations     (70.03) zero node data
 S (RAY0,RAY1,RAY2,RAY3)=-1 ; error condition, if no data nodes
 S RADFN=+$P(X,"^",2),RADTE=+$P(X,"^",3),RADTI=(9999999.9999-RADTE)
 S RACN=+$P(X,"^",4),RAST=$P(X,"^",5),RATAB=5
 S:'$D(RABTCH) RABTCH=0 S (DIWL,DIWF)=0
 Q:'$D(^RADPT(RADFN,0))  S RANUM=1,RAY1=^(0)
 Q:'$D(^DPT(RADFN,0))  S RAY0=^(0)
 Q:'$D(^RADPT(RADFN,"DT",RADTI,0))  S RAY2=^(0)
 S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P","B",RACN,0))
 S (RAY3,RALB)=$S($D(^RADPT(RADFN,"DT",RADTI,"P",+RACNI,0)):^(0),1:-1)
 Q:RAY3<0  ; examinations data missing
 ;
 S (RAHDFM,RAFTFM)=1 S:$D(^RA(79.1,+$P(RAY2,"^",4),0)) RAHDFM=^(0),RAFTFM=+$P(RAHDFM,"^",13),DIWL=$P(RAHDFM,"^",14),DIWF=$P(RAHDFM,"^",15),RAHDFM=+$P(RAHDFM,"^",12) S RAFOOT=$S($D(^RA(78.2,RAFTFM,0)):+$P(^(0),"^",2),1:0)
 S:'DIWL DIWL=5 S:'DIWF DIWF=70 S DIWF="WC"_(DIWF-DIWL)
 G @$S($D(RAUTOE):"HEAD^RARTR0",1:"HD1")
 Q
 ;
HD D FOOT^RARTR2:$E(IOST,1,2)'="C-"
HD1 S RAFMT=RAHDFM I $D(RARTMES) W:$Y>0 @RAFFLF W !,?((80-$L(RARTMES))/2),RARTMES,! S RAIOF=RAFFLF,RAFFLF="!"
 I '$D(RARTMES) W:$Y>0 @RAFFLF
 D PRT^RAFLH S:$D(RARTMES) RAFFLF=RAIOF
 W:$D(RAERRFLG) !!?10,$$AMENRPT^RARTR2(),!!
 Q
