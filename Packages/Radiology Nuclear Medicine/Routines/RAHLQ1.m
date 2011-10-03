RAHLQ1 ;HISC/CAH AISC/SAW-Compiles HL7 'ORF' Message Type ;10/7/97  16:02
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ; Set the ^TMP("RARPT-QBAK",$J,RARECNT,... global to the following:
 ; ^TMP("RARPT-QBAK",$J,RARECNT,"PID3")=Patient ID & checksum
 ; "PID5"          Patient name
 ; "PID7"          Patient DOB
 ; "PID8"          sex of the patient
 ; "PID19"         Patient SSN (if any)
 ; "OBR4A"         inverse date/time exam "-" case ien (radti-racni)
 ; "OBR4B"         date/time exam (radte)
 ; "OBR16A"        ien requesting physician
 ; "OBR16B"        name of requesting physician
 ; "OBR20"         name of ward location or principal clinic
 ; "LAN-A"         LANIER ONLY --> $p(racn0,"^",2)
 ; "LAN-B"         LANIER ONLY --> $p(^ramis(71,+$p(racn0,"^",2),0),"^")
 ; "OBX5"          radisp_$p(^ramis(71,+$p(racn0,"^",2),0),"^")
 ;                   radisp_"Unknown"  if no procedure
 ;                   where radisp is  + or .  for printset
 ; "OBX5-MOD"      string of modifiers
 ; "OBX-HIST-NONE" "None Entered" if no clinical history
 ; "OBX5-ALLE"     string of allergies
 ;
 ; "RADFN"         RADFN
 ; "VADM(1)"       VADM(1)
 ; "VADM(3)"       VADM(3)
 ; "RAPRV"         RAPRV
 ; "RADTE0"        RADTE0
 ;
 ; RACN0        =  Examinations 0 node (70.03 sub-file)
EN1 S RADTE0=$S($D(^RADPT(RADFN,"DT",RADTI,0)):+^(0),1:"")
 S RADTE=$S(RADTE0:$E(RADTE0,4,7)_$E(RADTE0,2,3)_"-"_+RACN0,1:+RACN0)
 ;
 ;Compile 'PID' Segment
 S ^TMP("RARPT-QBAK",$J,RARECNT,"RADFN")=RADFN
 S ^TMP("RARPT-QBAK",$J,RARECNT,"VADM(1)")=VADM(1)
 S ^TMP("RARPT-QBAK",$J,RARECNT,"VADM(3)")=VADM(3)
 S ^TMP("RARPT-QBAK",$J,RARECNT,"PID8")=$S(VADM(5)]"":$S("MF"[$P(VADM(5),"^"):$P(VADM(5),"^"),1:"O"),1:"U")
 S:$P(VADM(2),"^")]"" ^TMP("RARPT-QBAK",$J,RARECNT,"PID19")=$P(VADM(2),"^")
 ;
 ;Compile 'OBR' Segment
 S ^TMP("RARPT-QBAK",$J,RARECNT,"OBR4A")=RADTI_"-"_RACNI
 S ^TMP("RARPT-QBAK",$J,RARECNT,"OBR4B")=RADTE
 S RAPRV=$P($G(^VA(200,+$P(RACN0,"^",14),0)),"^")
 S ^TMP("RARPT-QBAK",$J,RARECNT,"OBR16A")=$S(RAPRV]"":+$P(RACN0,"^",14),1:"")
 S ^TMP("RARPT-QBAK",$J,RARECNT,"RAPRV")=RAPRV
 S ^TMP("RARPT-QBAK",$J,RARECNT,"RADTE0")=RADTE0
 S ^TMP("RARPT-QBAK",$J,RARECNT,"OBR20")=$S($D(^DIC(42,+$P(RACN0,"^",6),0)):$P(^(0),"^"),$D(^SC(+$P(RACN0,"^",8),0)):$P(^(0),"^"),1:"Unknown")
 ;
 ;Compile 'OBX' Segment for Procedure
 S ^TMP("RARPT-QBAK",$J,RARECNT,"LAN-A")=$P(RACN0,"^",2)
 S ^TMP("RARPT-QBAK",$J,RARECNT,"LAN-B")=$S($D(^RAMIS(71,+$P(RACN0,"^",2),0)):$P(^(0),"^"),1:"")
 ;
 ; set flags if print set and/or lowest case of print set
 N RACN,RAPRTSET,RAMEMLOW,RADISP
 S RACN=+RACN0,RAPRTSET=0,RAMEMLOW=0,RADISP=" "
 D EN1^RAUTL20
 I RAPRTSET S RADISP="." S:RAMEMLOW RADISP="+"
 ;For Lanier units, comment out next line
 S ^TMP("RARPT-QBAK",$J,RARECNT,"OBX5")=$S($D(^RAMIS(71,+$P(RACN0,"^",2),0)):RADISP_$P(^(0),"^"),1:"Unknown")
 ;
 ;Compile 'OBX' Segment for Modifiers
 D MODS^RAUTL2
 S ^TMP("RARPT-QBAK",$J,RARECNT,"OBX5-MOD")=Y
 ;
 ;Compile 'OBX' Segment for Clinical History
 I '$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H",0)) S ^TMP("RARPT-QBAK",$J,RARECNT,"OBX-HIST-NONE")="None Entered"
 K ^UTILITY($J,"W") S DIWF="",DIWR=80,DIWL=1 F RAI=0:0 S RAI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H",RAI)) Q:'RAI  I $D(^(RAI,0)) S X=^(0) D ^DIWP
 ; save ^UTILITY($J,"W") for bridge routine
 ;
 ;Compile 'OBX' Segment for Allergies
 S DFN=RADFN D ALLERGY^RADEM S X="" I $D(GMRAL) S I=0 F  S I=$O(PI(I)) Q:I'>0  S X0=PI(I) I X0]"" Q:($L(X)+$L(X0))>200  S X=X_X0_", "
 I $L(X) S ^TMP("RARPT-QBAK",$J,RARECNT,"OBX5-ALLE")=X
 K DIWF,DIWL,DIWR,GMRAL,I,PI,RAI,RAPRV,RADTE,RADTE0
 Q
