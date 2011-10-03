RARTR0 ;HISC/GJC-Queue/Print Radiology Rpts utility routine. ;05/20/09  09:30
 ;;5.0;Radiology/Nuclear Medicine;**8,26,74,84,99**;Mar 16, 1998;Build 5
 ; 06/28/2006 BAY/KAM Remedy Call 146291 - Change Patient Age to DOB
 ;
 ;Integration Agreements
 ;----------------------
 ;DT^DILF(2054); GETS^DIQ(2056); $$FMTE^XLFDT(10103); $$UP^XLFSTR(10104); ^DIWP(10011)
 ;NEW PERSON file read w/FM (10060)
 ;
EN1 ; Called from RARTR ;P84 GETS^DIQ added... 
 S RARPT(0)=$G(^RARPT(+$G(RARPT),0)) Q:RARPT(0)']""
 S RARPT(10)=$P(RARPT(0),"^",10)
 S RAVERF=+$P(RARPT(0),U,9),RAPVERF=+$P(RARPT(0),U,13)
 K RAPIR,RAPIS S RAPIR=+$P(RALB,"^",12),RAPIS=+$P(RALB,"^",15)
 ;format of the RAPIR/RAPIS arrays: P84 logic
 ;RAPI*=IEN file 200
 ;RAPI*(200,RAPI*,.01)= NAME (required)
 ;RAPI*(200,RAPI*,20.2) = SIGNATURE BLOCK PRINTED NAME (if any)
 ;RAPI*(200,RAPI*,20.3) = SIGNATURE BLOCK TITLE (if any)
 I RAPIR D GETS^DIQ(200,RAPIR,".01;20.2;20.3","","RAPIR") S RAPIR("IENS")=RAPIR_","
 I RAPIS D GETS^DIQ(200,RAPIS,".01;20.2;20.3","","RAPIS") S RAPIS("IENS")=RAPIS_","
 S RAWHOVER=+$P(RARPT(0),"^",17)
 I RAVERF,((RAPIR=RAVERF)!(RAPIS=RAVERF)) D
 . S RAVERFND="" ; Set verifier found flag
 . Q
 I RAPIS D  Q:$D(RAOOUT)
 . ;get signature block name if defined
 . S RALBS=$E(RAPIS(200,RAPIS("IENS"),20.2),1,25)
 . S:RALBS="" RALBS=$E(RAPIS(200,RAPIS("IENS"),.01),1,25) ;default to NAME
 . ;
 . ;get signature block title if defined
 . S RALBST=$G(RAPIS(200,RAPIS("IENS"),20.3)) ; max: 50 chars
 . S:RALBST="" RALBST=$$TITLE^RARTR0(RAPIS)
 . ;
 . I '$D(RAUTOE) D:($Y+RAFOOT+4)>IOSL HANG^RARTR2 Q:$D(RAOOUT)
 . I '$D(RAUTOE) D HD^RARTR:($Y+RAFOOT+4)>IOSL
 . I '$D(RAUTOE) D
 .. W !,"Primary Interpreting Staff:",!?2,$S(RALBS]"":RALBS,1:"Unknown")
 .. W:$L(RALBST) ", "_$E(RALBST,1,((IOM-$X)-16))
 .. ; The '-16' above is derived from $L("(Pre-Verifier)")+1 FORMATTING
 .. Q
 . E  D
 .. S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="Primary Interpreting Staff:"
 .. S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="  "_$S(RALBS]"":RALBS,1:"Unknown")
 .. Q:'$L(RALBST)  N RALEN S RALEN=$L(^TMP($J,"RA AUTOE",RAACNT))
 .. S ^TMP($J,"RA AUTOE",RAACNT)=^TMP($J,"RA AUTOE",RAACNT)_", "_$E(RALBST,1,((80-RALEN)-16))
 .. Q
 . I $D(RAVERFND)&(RAPIS=RAVERF),(RAPIS(200,RAPIS("IENS"),.01)'="RADIOLOGY,OUTSIDE SERVICE") D
 .. I $G(RARPT(10))']"",('$D(RAUTOE)) D  Q
 ... W:RAWHOVER=RAPIS !?10,"(Verifier, no e-sig)"
 ... W:RAWHOVER'=RAPIS !?10,"Verified by transcriptionist for "_RALBS  ;Removed RA*5*8 _", M.D."
 ... Q
 .. I $G(RARPT(10))']"",($D(RAUTOE)) D  Q
 ... S:RAWHOVER=RAPIS ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="          (Verifier, no e-sig)"
 ... S:RAWHOVER'=RAPIS ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="          Verified by transcriptionist for "_RALBS  ;Removed RA*5*8 _", M.D."
 ... Q
 .. W:'$D(RAUTOE) " (Verifier)"
 .. S:$D(RAUTOE) ^TMP($J,"RA AUTOE",RAACNT)=^TMP($J,"RA AUTOE",RAACNT)_" (Verifier)"
 .. Q
 . I RAPIS=RAPVERF,'$D(RAUTOE) W " (Pre-Verifier)"
 . I RAPIS=RAPVERF,$D(RAUTOE) S ^TMP($J,"RA AUTOE",RAACNT)=^TMP($J,"RA AUTOE",RAACNT)_" (Pre-Verifier)"
 . Q
 D SECSTF^RARTR1 Q:$D(RAOOUT)  ; Print secondary interp'ting staff now
 ;now for primary resident definitions...
 I RAPIR D  Q:$D(RAOOUT)
 . ;get signature block name if defined
 . S RALBR=$E(RAPIR(200,RAPIR("IENS"),20.2),1,25)
 . S:RALBR="" RALBR=$E(RAPIR(200,RAPIR("IENS"),.01),1,25) ;default to NAME
 . ;
 . ;get signature block title if defined
 . S RALBRT=$G(RAPIR(200,RAPIR("IENS"),20.3)) ; max: 50 chars
 . S:RALBRT="" RALBRT=$$TITLE^RARTR0(RAPIR)
 . ;
 . I '$D(RAUTOE) D:($Y+RAFOOT+4)>IOSL HANG^RARTR2 Q:$D(RAOOUT)
 . I '$D(RAUTOE) D HD^RARTR:($Y+RAFOOT+4)>IOSL
 . I '$D(RAUTOE) D
 .. W !,"Primary Interpreting Resident:",!?2,$S(RALBR]"":RALBR,1:"Unknown")
 .. W:$L(RALBRT) ", "_$E(RALBRT,1,((IOM-$X)-16))
 .. Q
 . I $D(RAUTOE) D
 .. S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="Primary Interpreting Resident:"
 .. S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="  "_$S(RALBR]"":RALBR,1:"Unknown")
 .. Q:'$L(RALBRT)  N RALEN S RALEN=$L(^TMP($J,"RA AUTOE",RAACNT))
 .. S ^TMP($J,"RA AUTOE",RAACNT)=^TMP($J,"RA AUTOE",RAACNT)_", "_$E(RALBRT,1,((80-RALEN)-16))
 .. Q
 . I $D(RAVERFND)&(RAPIR=RAVERF) D
 .. I $G(RARPT(10))']"",('$D(RAUTOE)) D  Q
 ... W:RAWHOVER=RAPIR !?10,"(Verifier, no e-sig)"
 ... W:RAWHOVER'=RAPIR !?10,"Verified by transcriptionist for "_RALBR  ;Removed RA*5*8 _", M.D."
 ... Q
 .. I $G(RARPT(10))']"",($D(RAUTOE)) D  Q
 ... S:RAWHOVER=RAPIR ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="          (Verifier, no e-sig)"
 ... S:RAWHOVER'=RAPIR ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="          Verified by transcriptionist for "_RALBR  ;Removed RA*5*8 _", M.D."
 ... Q
 .. W:'$D(RAUTOE) " (Verifier)"
 .. S:$D(RAUTOE) ^TMP($J,"RA AUTOE",RAACNT)=^TMP($J,"RA AUTOE",RAACNT)_" (Verifier)"
 .. Q
 . I RAPIR=RAPVERF,('$D(RAUTOE)) W " (Pre-Verifier)"
 . I RAPIR=RAPVERF,($D(RAUTOE)) S ^TMP($J,"RA AUTOE",RAACNT)=^TMP($J,"RA AUTOE",RAACNT)_" (Pre-Verifier)"
 . Q
 D SECRES^RARTR1 ; Print out secondary interp'ting resident now
 K RAPIR,RAPIS ;P84 kills added
 Q
 ;
TITLE(X) ;Return the radiology classification in lieu of the signature block title
 ; 'X' is the IEN of the Primary Interpreting Resident i.e, ^DD(70.03,12
 ; -OR-
 ; 'X' is the IEN of the Primary Interpreting Staff i.e, ^DD(70.03,15
 Q $S($D(^VA(200,"ARC","R",X)):"Resident Physician",$D(^VA(200,"ARC","S",X)):"Staff Physician",1:"")
 ; 
HEAD ; Set up header info for e-mail message (called from INIT^RARTR)
 ; 06/28/2006 BAY/KAM Remedy Call 146291 Change Patient Age to DOB
 N RAGE,RATPHY,RACSE,RAILOC,RANME,RAPRIPHY,RAPTLOC,RAREQPHY,RASERV,RASEX,RADOB
 N RASPACE,RASSN,X1,X2 S:'$D(RAACNT) RAACNT=0
 ;Added next line for Remedy Call 146291
 D DT^DILF("E",$P(RAY0,"^",3),.RADOB) ;Get Date of Birth/External Fmt
 ;
 S RANME=$P(RAY0,"^"),RASSN=$P(RAY0,"^",9)
 S RASEX=$$UP^XLFSTR($P(RAY0,"^",2))
 S RACSE=$P($G(^RARPT(RARPT,0)),"^")_"@"_$P($$FMTE^XLFDT($P(RAY2,"^")),"@",2)
 ; Remedy Call 146291 Removed line calculating age
 S RAREQPHY=$$XTERNAL^RAUTL5($P(RAY3,"^",14),$P($G(^DD(70.03,14,0)),"^",2))
 S RAPTLOC=$$PTLOC^RAUTL12() S:RAREQPHY']"" RAREQPHY="Unknown"
 S RASERV=$$XTERNAL^RAUTL5($P(RAY3,"^",7),$P($G(^DD(70.03,7,0)),"^",2))
 S RATPHY=$$ATND^RAUTL5(RADFN,DT),RAPRIPHY=$$PRIM^RAUTL5(RADFN,DT)
 S RAILOC=$$XTERNAL^RAUTL5($P(RAY2,"^",4),$P($G(^DD(70.02,4,0)),"^",2))
 S:RAILOC']"" RAILOC="Unknown" S:RASERV']"" RASERV="Unknown"
 S RANME=$E(RANME,1,20)_"  "
 S RASSN=$E(RASSN,1,3)_"-"_$E(RASSN,4,5)_"-"_$E(RASSN,6,9)_"    "
 ; Remedy Call 146291 Changed next line to use RADOB(0)
 S RAGE="DOB-"_$G(RADOB(0))_" "_$S(RASEX="F":"F",RASEX="M":"M",1:"UNK")
 S $P(RASPACE," ",(22-$L(RAGE)))=""
 S RAGE=RAGE_RASPACE,RACSE="Case: "_RACSE
 S RAREQPHY="Req Phys: "_$E(RAREQPHY,1,28)
 S RASPACE="",$P(RASPACE," ",(42-$L(RAREQPHY)))=""
 S RAREQPHY=RAREQPHY_RASPACE
 S RAPTLOC="Pat Loc: "_$S(RAPTLOC]"":$E(RAPTLOC,1,30),1:"Unknown")
 S RATPHY="Att Phys: "_$E(RATPHY,1,28)
 S RASPACE="",$P(RASPACE," ",(42-$L(RATPHY)))=""
 S RATPHY=RATPHY_RASPACE
 S RAILOC="Img Loc: "_$E(RAILOC,1,30)
 S RAPRIPHY="Pri Phys: "_$E(RAPRIPHY,1,28)
 S RASPACE="",$P(RASPACE," ",(42-$L(RAPRIPHY)))=""
 S RAPRIPHY=RAPRIPHY_RASPACE
 S RASERV="Service: "_$E(RASERV,1,30)
 S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=RANME_RASSN_RAGE_RACSE
 S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=RAREQPHY_RAPTLOC
 S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=RATPHY_RAILOC
 S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=RAPRIPHY_RASERV
 ;p99: get pt sex, add pregnancy screen and pregnancy screen comment
 I $$PTSEX^RAUTL8(RADFN)="F",$D(RAY3) D
 .Q:RAY3<0
 .N RAPCOMM,RA32PSC,DIWF,DIWL,DIWR,X S RAPCOMM=$G(^RADPT(RADFN,"DT",+$G(RADTI),"P",+$G(RACNI),"PCOMM"))
 .S:$P(RAY3,U,32)'="" ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="Pregnancy Screen: "_$S($P(RAY3,"^",32)="y":"Patient answered yes",$P(RAY3,"^",32)="n":"Patient answered no",$P(RAY3,"^",32)="u":"Patient is unable to answer or is unsure",1:"")
 .I ($P(RAY3,U,32)'="n"),$L(RAPCOMM) D
 ..S DIWF="",DIWL=3,DIWR=75,X="Pregnancy Screen Comment: "_RAPCOMM K ^UTILITY($J,"W") D ^DIWP
 ..F RA32PSC=0:0 S RA32PSC=$O(^UTILITY($J,"W",3,RA32PSC)) Q:RA32PSC'>0  S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=^UTILITY($J,"W",3,RA32PSC,0)
 ..K ^UTILITY($J,"W")
 S:$D(RAERRFLG) ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="         "_$$AMENRPT^RARTR2()
 S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=""
 Q
