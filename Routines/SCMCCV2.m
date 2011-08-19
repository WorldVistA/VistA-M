SCMCCV2 ;ALB/JLU;PC Attending conversion;6/4/1999
 ;;5.3;Scheduling;**195**;AUG 13, 1993
 ;
STRTQJOB ;this is the start of the queue job to convert PC Attending
 ;Assignments.
 ;The following variables are defined when the job starts
 ;SCMCTM(X) the array of team IENs as subscripts
 ;SCMCPOS(X) the array of positions as subscripts
 ;SCMCFIX is set to either F for fix of C for Check
 ;SCMCTYPE is set to A for ALL, T for team or P for position
 ;
 N STOP,ZSTOP,SCMCCNT
 S SCMCCNT="0^0^0" ;total count^fixed count^err count
 S (STOP,ZSTOP)=0
 D INIT^SCMCCV1
 D BLDLIST
 D:$D(^TMP("SCMC",$J)) PROCLIST
 D MAIL ;WATCH FOR ZSTOP
 K ^TMP("SCMC",$J),^XTMP("SCMCATTCONV")
 Q
 ;
 ;
BLDLIST ;gathers all the PC Attending Assignments within PCMM database.
 ;this will be placed in the following global for processing
 ;^TMP("SCMC",$J,TM IEN,POS IEN,POS ASGN IEN 404.43)=DFN^ASGNDT
 ;
 N DFN,ASGNDT,TMPOS,POSASGN,TMASGN,TMASGNZ,TM
 K ^TMP("SCMC",$J)
 ;
 F DFN=0:0 S DFN=$O(^SCPT(404.43,"APCPOS",DFN)) Q:DFN=""  F ASGNDT=0:0 S ASGNDT=$O(^SCPT(404.43,"APCPOS",DFN,2,ASGNDT)) Q:ASGNDT=""  DO
 .F TMPOS=0:0 S TMPOS=$O(^SCPT(404.43,"APCPOS",DFN,2,ASGNDT,TMPOS)) Q:TMPOS=""  F POSASGN=0:0 S POSASGN=$O(^SCPT(404.43,"APCPOS",DFN,2,ASGNDT,TMPOS,POSASGN)) Q:POSASGN=""  DO
 ..S TMASGN=+$G(^SCPT(404.43,POSASGN,0))
 ..I 'TMASGN Q
 ..I +$P(^SCPT(404.43,POSASGN,0),U,4),$P(^(0),U,4)<DT Q  ;has a discharge date in the past.
 ..S TMASGNZ=$G(^SCPT(404.42,TMASGN,0))
 ..I 'TMASGNZ Q
 ..S TM=$P(TMASGNZ,U,3)
 ..I 'TM Q
 ..S ^TMP("SCMC",$J,TM,TMPOS,POSASGN)=DFN_"^"_ASGNDT
 ..Q
 .Q
 Q
 ;
 ;
PROCLIST ;works through the list built by the builder via the SCMCTYPE
 ;checks are done to ensure the convert can happen then it is converted.
 ;
 ;TMP GLOBAL ^TMP("SCMC",$J,TEAM IEN, POS IEN, POS ASSIGNMENT IEN)="DFN^
 ;ASSIGNMENT DATE FM FORMAT"
 ;
 N TM,POS,POSASGNZ,POSASGN
 ;
 F TM=0:0 S TM=$O(^TMP("SCMC",$J,TM)) Q:+TM<1!(ZSTOP)  F POS=0:0 S POS=$O(^TMP("SCMC",$J,TM,POS)) Q:POS=""!(ZSTOP)  F POSASGN=0:0 S POSASGN=$O(^TMP("SCMC",$J,TM,POS,POSASGN)) Q:POSASGN=""  DO  Q:(ZSTOP)
 .N PAT,TMPZ,SSN,ASGNDTI,ASGNDTE,DFN,Y
 .S TMPZ=^TMP("SCMC",$J,TM,POS,POSASGN)
 .S DFN=$P(TMPZ,U,1)
 .S PAT=$P(^DPT($P(TMPZ,U,1),0),U,1)
 .S SSN=$P(^(0),U,9) ;naked from line before
 .S (ASGNDTI,Y)=$P(TMPZ,U,2)
 .D DD^%DT
 .S ASGNDTE=Y
 .I SCMCTYPE="A" D CONVERT
 .I SCMCTYPE="T",$D(SCMCTM(TM)) D CONVERT
 .I SCMCTYPE="P",$D(SCMCPOS(POS)) D CONVERT
 .I '($P(SCMCCNT,U,1)#50) S ZSTOP=$S($$S^%ZTLOAD:1,1:0)
 .Q
 Q
 ;
 ;
BPERCNT ;bumps the error counter
 S $P(SCMCCNT,U,3)=$P(SCMCCNT,U,3)+1
 Q
 ;
BPTOTCNT ;bumps the total counter
 S $P(SCMCCNT,U,1)=$P(SCMCCNT,U,1)+1
 Q
 ;
BPFXCNT ;bumps the fixed counter
 S $P(SCMCCNT,U,2)=$P(SCMCCNT,U,2)+1
 Q
 ;
 ;
SETERR(ERR) ;set the error into the error global array.
 ;accepts ERR as the error message
 ;
 N EXTTM,EXTPOS,LAST
 S EXTPOS=$P(^SCTM(404.57,POS,0),U,1)
 S EXTTM=$P(^SCTM(404.51,TM,0),U,1)
 ;
 ;sets up the name of the provider for this position
 I '$D(^TMP("SCMC",$J,"ERR",EXTTM,EXTPOS)) DO
 .N VAR,SCDATES,SCMCPROV,SCMCERR
 .S SCDATES("INCL")=1
 .S VAR=$$PRTP^SCAPMC8(POS,"SCDATES","SCMCPROV","SCMCERR")
 .I 'VAR Q
 .;there should be only one provider for this day
 .S ^TMP("SCMC",$J,"ERR",EXTTM,EXTPOS)=$S($D(SCMCPROV(1)):$P(SCMCPROV(1),U,2),1:"No active provider")
 .Q
 ;
 ;
 I '$D(^TMP("SCMC",$J,"ERR",EXTTM,EXTPOS,DFN)) S ^TMP("SCMC",$J,"ERR",EXTTM,EXTPOS,DFN,1)=PAT_"^"_SSN_"^"_ASGNDTE
 ;
 S LAST=$O(^TMP("SCMC",$J,"ERR",EXTTM,EXTPOS,DFN,9999999),-1)
 S ^TMP("SCMC",$J,"ERR",EXTTM,EXTPOS,DFN,LAST+1)=ERR
 Q
 ;
 ;
CONVERT ;performs two checks then calls the tag to conver data.
 ;
 N ERR,VARONE,REASSIGN
 D BPTOTCNT
 ;
 S VARONE=$$YSPTTPPC^SCMCTPU2(DFN,ASGNDTI,1)
 I 'VARONE DO
 .IF $P(VARONE,U,2)["future" D FUTURE^SCMCCV1 I 1
 .E  S ERR="-"_$P(VARONE,U,2) D SETERR(ERR)
 .Q
 ;
 S VARONE='$$CHKTM(POSASGN,.ERR)
 ;
 I $D(ERR) D BPERCNT
 I '$D(ERR) DO
 .I SCMCFIX="F" D @$S($D(REASSIGN):"REASGN",1:"CHANGE^SCMCCV1("_POSASGN_")")
 .D BPFXCNT ;also counts a fix if in check mode.
 .Q
 ;
CONQ Q
 ;
 ;
REASGN ;discharge old PC Attending and makes new PC Practitioner for today.
 ;
 N VARTHREE,RETURN,FIELDS,SCCONER
 S SCCONER="^TMP(""SCMC"",$J,""JUNK"")"
 S VARTHREE=$$INPTTP^SCAPMC(DFN,POSASGN,DT-1,SCCONER)
 I 'VARTHREE S ERR="-Could not discharge old PC Attending Assignment "_POSASGN D SETERR(ERR) Q
 S FIELDS(.05)=1,FIELDS(.06)=$G(DUZ,.5),FIELDS(.07)=DT
 S RETURN=$$ACPTTP^SCAPMC21(DFN,POS,"FIELDS",DT,SCCONER)
 K @SCCONER
 I $P(RETURN,U,2)=1 Q
 D REOPEN^SCMCCV1
 S ERR="-Could not create a new position assignment.  PC Attending reactivated." D SETERR(ERR)
 Q
 ;
 ;
CHKTM(ASGIEN,ERR) ;Performs checks on the team assignments
 ;
 N TMASGN,RES,POSASGNZ
 S RES=1
 ;
 S POSASGNZ=$G(^SCPT(404.43,ASGIEN,0))
 I POSASGNZ="" S ERR="-Missing Patient Team Position Assignment.",RES=0 D SETERR(ERR)
 ;
 S TMASGN=$P(POSASGNZ,U,1)
 I +TMASGN'>0 S ERR="-Bad team assignment pointer.",RES=0 D SETERR(ERR)
 ;
 S TMASGN=$G(^SCPT(404.42,TMASGN,0))
 I TMASGN="" S ERR="-Missing Team Assignment.",RES=0 D SETERR(ERR)
 ;
 I $P(TMASGN,U,9)>0 S ERR="-Patient Team Assignment status is discharged.",RES=0 D SETERR(ERR)
 ;
 I $P(TMASGN,U,8)'=1 S ERR="-PC Role only allowed if Patient Team Assignment is for Primary Care",RES=0 D SETERR(ERR)
 ;
CHKQ Q RES
 ;
 ;
MAIL ;sets up message for conversion and delivers.
 ;
 N XMY,XMTEST,XMSUB,XMDUZ,CNTR
 ;
 D INIT^SCMCCV1
 I '$D(^TMP("SCMC",$J)) D
 . D SET("")
 . D SET("No PC Attending Assignments to evaluate!")
 . Q
 E  D
 . D TEXT
 . D TOTALS
 . D ERRORS
 . Q
 D ^XMD
 Q
 ;
 ;
TEXT ;fills in the text of the message
 ;
 D HDR
 I SCMCTYPE="A" D LISTA
 I SCMCTYPE="T" D LISTT
 I SCMCTYPE="P" D LISTP
 I ZSTOP D STOPPED
 Q
 ;
 ;
HDR ;header for check mode.
 ;
 D SET("The conversion software was run in a "_$S(SCMCFIX="C":"'CHECK'",1:"'FIX'")_" mode.")
 ;
 I SCMCFIX="C" D SET("No actual conversion took place.")
 E  DO
 .D SET("When possible the PC Attending assignment was changed to PC Practitioner.")
 .D SET("If it could not be converted an error message is listed and the assignment was left in its original state.")
 .Q
 ;
 D SET("")
 Q
 ;
 ;
LISTA ;
 D SET("All PCMM Teams and Positions were reviewed.")
 Q
 ;
 ;
LISTT ;
 N VAR
 D SET("Team(s):")
 S VAR=0
 F  S VAR=$O(SCMCTM(VAR)) Q:VAR=""  D SET($P(^SCTM(404.51,VAR,0),U,1))
 D SET(" ")
 D SET("All positions for each team are included.")
 Q
 ;
 ;
LISTP ;
 N VAR
 D SET("Team:")
 S VAR=$O(SCMCTM(0))
 D SET($P(^SCTM(404.51,VAR,0),U,1))
 D SET(" ")
 D SET("Position(s):")
 S VAR=0
 F  S VAR=$O(SCMCPOS(VAR)) Q:VAR=""  D SET($P(^SCTM(404.57,VAR,0),U,1))
 Q
 ;
 ;
TOTALS ;fills the totals into the message.
 ;
 D SET(" ")
 D SET(" ")
 D SET("Assignments reviewed: "_$P(SCMCCNT,U,1))
 D SET("Assignments "_$S(SCMCFIX="C":"that would have been ",1:"")_"converted: "_$P(SCMCCNT,U,2))
 D SET("Assignments that could not be converted: "_$P(SCMCCNT,U,3))
 D SET(" ")
 Q
 ;
 ;
ERRORS ;load in the error messages into the report.
 ;
 ;^TMP("SCMC",$J,"ERR",TEAM,POSITION,DFN,1) = PATIENT^SSN^ASSIGNMENT DATE
 ;
 N VAR
 D SET(" ")
 D SET(" ")
 D SET("The following assignments could not be converted and why:")
 D SET(" ")
 D SET("Patient Name            SSN     Team           Position        Assignment Date")
 D SET("------------------------------------------------------------------------------")
 ;
 N TM,POS,ASGNDT,DFN
 S TM=""
 F  S TM=$O(^TMP("SCMC",$J,"ERR",TM)) Q:TM=""  DO
 .D SET(" ")
 .D SET(" ")
 .D SET("Team==>     "_TM)
 .S POS="" F  S POS=$O(^TMP("SCMC",$J,"ERR",TM,POS)) Q:POS=""  DO
 ..D SET("Position==> "_POS_"  ("_^TMP("SCMC",$J,"ERR",TM,POS)_")")
 ..F DFN=0:0 S DFN=$O(^TMP("SCMC",$J,"ERR",TM,POS,DFN)) Q:DFN=""  DO
 ...N PAT,VAR1,LP,ERR,TITLE
 ...S VAR1=^TMP("SCMC",$J,"ERR",TM,POS,DFN,1)
 ...S TITLE=$P(VAR1,U,1)
 ...D PADTO(25,.TITLE)
 ...S TITLE=TITLE_$E($P(VAR1,U,2),6,9)
 ...D PADTO(31,.TITLE)
 ...S TITLE=TITLE_$E(TM,1,15)
 ...D PADTO(48,.TITLE)
 ...S TITLE=TITLE_$E(POS,1,15)
 ...D PADTO(65,.TITLE)
 ...S TITLE=TITLE_$P(VAR1,U,3)
 ...D SET(TITLE)
 ...F LP=2:1 S ERR=$G(^TMP("SCMC",$J,"ERR",TM,POS,DFN,LP)) Q:ERR=""  D SET("  "_ERR)
 ...Q
 ..Q
 .Q
 Q
 ;
 ;
PADTO(TOT,VAR) ;
 S VAR=$$LJ^XLFSTR(VAR,TOT)
 Q
 ;
 ;
SET(X) ;sets data into the correct mail storage global
 ;
 S CNTR=CNTR+1
 S ^TMP("SCMC",$J,"MSG",CNTR,0)=X
 Q
 ;
 ;
STOPPED ;
 D SET(" ")
 D SET("*** The conversion job was stopped by request.")
 D SET("*** Some data was still processed.")
 D SET("*** Contact your IRM for more information. ***")
 Q
