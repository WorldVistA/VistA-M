RARTR1 ;HISC/FPT,GJC-Queue/print Radiology Reports (cont.) ;1/8/97  08:08
 ;;5.0;Radiology/Nuclear Medicine;**8,18,56,97**;Mar 16, 1998;Build 6
 ;Supported IA #1571 ^LEX(757.01
 ;Supported IA #10104 REPEAT^XLFSTR
 ;Supported IA #10060 and #2056 $$GET1^DIQ for file 200
 ;last modification by SS for P18 JUNE 29,00
PRTDX ; print dx codes on report
 N RATMP,RATMP1
 I '$D(RAUTOE) D HANG^RARTR2:($Y+RAFOOT+4)>IOSL Q:$D(RAOOUT)  D HD^RARTR:($Y+RAFOOT+4)>IOSL
 S RADXCODE=$P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),U,13)
 I '$D(RAUTOE) D
 . W !?RATAB,"Primary Diagnostic Code: ",!?RATAB+4
 . W $S($D(^RA(78.3,+RADXCODE,0)):$P(^(0),U,1),1:"")
 . S RATMP=$$GET1^DIQ(757.01,$P($G(^RA(78.3,+RADXCODE,0)),U,6),.01)
 . W:RATMP]"" " (",RATMP,")"
 . Q
 I $D(RAUTOE) D
 . S RATMP1="    Primary Diagnostic Code: "
 . S RATMP1=RATMP1_$S($D(^RA(78.3,+RADXCODE,0)):$P(^(0),U,1),1:"")
 . S RATMP=$$GET1^DIQ(757.01,$P($G(^RA(78.3,+RADXCODE,0)),U,6),.01)
 . I RATMP]"" S RATMP1=RATMP1_" ("_RATMP_")"
 . S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=RATMP1
 . Q
 I '$D(RAUTOE) D HANG^RARTR2:($Y+RAFOOT+4)>IOSL Q:$D(RAOOUT)  D HD^RARTR:($Y+RAFOOT+4)>IOSL
 I '$D(RAUTOE),('$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX",0))) W ! Q
 I '$D(RAUTOE),($O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX",0))) D  Q
 . W !!?RATAB,"Secondary Diagnostic Codes: "
 . S RADXCODE=0
 . F  S RADXCODE=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX","B",RADXCODE)) Q:RADXCODE'>0!('$D(^RA(78.3,+RADXCODE,0)))!($D(RAOOUT))  D
 .. D HANG^RARTR2:($Y+RAFOOT+4)>IOSL Q:$D(RAOOUT)
 .. D HD^RARTR:($Y+RAFOOT+4)>IOSL
 .. W !?RATAB+4,$P(^RA(78.3,RADXCODE,0),U,1)
 .. S RATMP=$$GET1^DIQ(757.01,$P($G(^RA(78.3,+RADXCODE,0)),U,6),.01)
 .. W:RATMP]"" " (",RATMP,")"
 .. Q
 . K RADXCODE W !
 . Q
 I $D(RAUTOE),('$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX",0))) D  Q
 . S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=""
 . Q
 I $D(RAUTOE),($O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX",0))) D
 . S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="    Secondary Diagnostic Codes: "
 . S RADXCODE=0
 . F  S RADXCODE=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX","B",RADXCODE)) Q:RADXCODE'>0  D
 .. Q:'$D(^RA(78.3,+$G(RADXCODE),0))#2
 .. S RATMP=$$GET1^DIQ(757.01,$P($G(^RA(78.3,+RADXCODE,0)),U,6),.01)
 .. S RATMP1="      "_$P(^RA(78.3,+$G(RADXCODE),0),U)
 .. S RATMP1=RATMP1_$S(RATMP="":"",1:" ("_RATMP_")")
 .. S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=RATMP1
 .. Q
 . S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=""
 . Q
 Q
WARNING ; this printed report should not be used for charting
 S RARPTSTT=$$RSTAT^RAO7PC1A()
 S:RARPTSTT="NO REPORT" RARPTSTT="REPORT STATUS UNKNOWN"
 S:RAST="R" RARPTSTT="("_RARPTSTT_")"
 S RAPOSITN=(80-$L(RARPTSTT)\2)
 I '$D(RAUTOE) D  ;P18 modif
 . W !?RAPOSITN-1,$$REPEAT^XLFSTR("*",$L(RARPTSTT)+2)
 . W:RAST="R" !?(80-$L(RARPTSTT)\2)-1,"*  PRELIMINARY REPORT   *" ;P18
 . W !?(80-$L(RARPTSTT)\2)-1,"*"_RARPTSTT_"*",!?RAPOSITN-1,$$REPEAT^XLFSTR("*",$L(RARPTSTT)+2)
 . Q
 I $D(RAUTOE) D
 . S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=$$REPEAT^XLFSTR("*",$L(RARPTSTT)+2)
 . I RAST="R" S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="*  PRELIMINARY REPORT   *" ;P18
 . S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="*"_RARPTSTT_"*" ;P18
 . S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=$$REPEAT^XLFSTR("*",$L(RARPTSTT)+2)
 . S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=""
 . Q
 K RAPOSITN,RARPTSTT
 Q
SECRES ; Print from the secondary resident multiple
 Q:'$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SRR",0))  ; no data, quit
 N RASR,RASRSBN,RASRSBT,DIERR,RAZ
 I '$D(RAUTOE) D:($Y+RAFOOT+4)>IOSL HANG^RARTR2 Q:$D(RAOOUT)  D HD^RARTR:($Y+RAFOOT+4)>IOSL
 W:'$D(RAUTOE) !,"Secondary Interpreting Resident:"
 S:$D(RAUTOE) ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="Secondary Interpreting Resident:"
 S RASR=0
 F  S RASR=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SRR",RASR)) Q:RASR'>0  D
 . S RASR(0)=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SRR",RASR,0))
 . S RAZ=$$GET1^DIQ(200,+RASR(0)_",",.01)
 . Q:RAZ=""
 . S RASRSBN=$E($$GET1^DIQ(200,+RASR(0)_",",20.2),1,25)
 . S:RASRSBN']"" RASRSBN=$E(RAZ,1,25)
 . S RASRSBT=$$GET1^DIQ(200,+RASR(0)_",",20.3) ; max:; 50 chars
 . I RASRSBT']"" S RASRSBT=$$TITLE^RARTR0(+RASR(0))
 . I '$D(RAUTOE) D:($Y+RAFOOT+4)>IOSL HANG^RARTR2 Q:$D(RAOOUT)  D HD^RARTR:($Y+RAFOOT+4)>IOSL
 . W:'$D(RAUTOE) !?2,$S(RASRSBN]"":RASRSBN,1:"Unknown"),", ",$E(RASRSBT,1,((IOM-$X)-16))
 . ; The '-16' above is derived from $L("(Pre-Verifier)")+1 FORMATTING
 . I $D(RAUTOE) D
 .. S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="  "_$S(RASRSBN]"":RASRSBN,1:"Unknown")
 .. N RALEN S RALEN=$L(^TMP($J,"RA AUTOE",RAACNT))
 .. S ^TMP($J,"RA AUTOE",RAACNT)=^TMP($J,"RA AUTOE",RAACNT)_", "_$E(RASRSBT,1,((80-RALEN)-16))
 .. Q
 . I '$D(RAVERFND),(RAVERF=+RASR(0)) D
 .. S RAVERFND=""
 .. I $G(RARPT(10))']"",('$D(RAUTOE)) D  Q
 ... W:RAWHOVER=+RASR(0) !?10,"(Verifier, no e-sig)"
 ... W:RAWHOVER'=+RASR(0) !?10,"Verified by transcriptionist for "_RASRSBN  ;Removed RA*5*8 _", M.D."
 ... Q
 .. I $G(RARPT(10))']"",($D(RAUTOE)) D  Q
 ... S:RAWHOVER=+RASR(0) ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="          (Verifier, no e-sig)"
 ... S:RAWHOVER'=+RASR(0) ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="          Verified by transcriptionist for "_RASRSBN  ;Removed RA*5*8 _", M.D."
 ... Q
 .. W:'$D(RAUTOE) " (Verifier)"
 .. S:$D(RAUTOE) ^TMP($J,"RA AUTOE",RAACNT)=^TMP($J,"RA AUTOE",RAACNT)_" (Verifier)"
 .. Q
 . I RAPVERF=+RASR(0) W:'$D(RAUTOE) " (Pre-Verifier)" S:$D(RAUTOE) ^TMP($J,"RA AUTOE",RAACNT)=^TMP($J,"RA AUTOE",RAACNT)_" (Pre-Verifier)"
 . Q
 Q
SECSTF ; Print from the secondary staff multiple
 Q:'$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SSR",0))  ; no data, quit
 N RASS,RASSSBN,RASSSBT,DIERR,RAZ
 I '$D(RAUTOE) D:($Y+RAFOOT+4)>IOSL HANG^RARTR2 Q:$D(RAOOUT)  D HD^RARTR:($Y+RAFOOT+4)>IOSL
 W:'$D(RAUTOE) !,"Secondary Interpreting Staff:"
 S:$D(RAUTOE) ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="Secondary Interpreting Staff:"
 S RASS=0
 F  S RASS=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SSR",RASS)) Q:RASS'>0  D
 . S RASS(0)=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SSR",RASS,0))
 . S RAZ=$$GET1^DIQ(200,+RASS(0)_",",.01)
 . Q:RAZ=""
 . S RASSSBN=$E($$GET1^DIQ(200,+RASS(0)_",",20.2),1,25)
 . S:RASSSBN="" RASSSBN=$E(RAZ,1,25)
 . S RASSSBT=$$GET1^DIQ(200,+RASS(0)_",",20.3) ; max: 50 chars
 . I RASSSBT']"" S RASSSBT=$$TITLE^RARTR0(+RASS(0))
 . I '$D(RAUTOE) D:($Y+RAFOOT+4)>IOSL HANG^RARTR2 Q:$D(RAOOUT)  D HD^RARTR:($Y+RAFOOT+4)>IOSL
 . W:'$D(RAUTOE) !?2,$S(RASSSBN]"":RASSSBN,1:"Unknown"),", ",$E(RASSSBT,1,((IOM-$X)-16))
 . ; The '-16' above is derived from $L("(Pre-Verifier)")+1 FORMATTING
 . I $D(RAUTOE) D
 .. S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="  "_$S(RASSSBN]"":RASSSBN,1:"Unknown")
 .. N RALEN S RALEN=$L(^TMP($J,"RA AUTOE",RAACNT))
 .. S ^TMP($J,"RA AUTOE",RAACNT)=^TMP($J,"RA AUTOE",RAACNT)_", "_$E(RASSSBT,1,((80-RALEN)-16))
 .. Q
 . I '$D(RAVERFND),(RAVERF=+RASS(0)) D
 .. S RAVERFND=""
 .. I $G(RARPT(10))']"",('$D(RAUTOE)) D  Q
 ... W:RAWHOVER=+RASS(0) !?10,"(Verifier, no e-sig)"
 ... W:RAWHOVER'=+RASS(0) !?10,"Verified by transcriptionist for "_RASSSBN  ;Removed RA*5*8 _", M.D."
 ... Q
 .. I $G(RARPT(10))']"",($D(RAUTOE)) D  Q
 ... S:RAWHOVER=+RASS(0) ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="          (Verifier, no e-sig)"
 ... S:RAWHOVER'=+RASS(0) ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="          Verified by transcriptionist for "_RASSSBN  ;Removed RA*5*8 _", M.D."
 ... Q
 .. W:'$D(RAUTOE) " (Verifier)"
 .. S:$D(RAUTOE) ^TMP($J,"RA AUTOE",RAACNT)=^TMP($J,"RA AUTOE",RAACNT)_" (Verifier)"
 .. Q
 . I RAPVERF=+RASS(0) W:'$D(RAUTOE) " (Pre-Verifier)" S:$D(RAUTOE) ^TMP($J,"RA AUTOE",RAACNT)=^TMP($J,"RA AUTOE",RAACNT)_" (Pre-Verifier)"
 . Q
 Q
