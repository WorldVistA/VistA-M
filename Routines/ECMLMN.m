ECMLMN ;ALB/ESD - Multiple patients processing ;26 AUG 1997 14:42
 ;;2.0; EVENT CAPTURE ;**5,10,15,13,17,18,23,42,47,54,76**;8 May 96;Build 6
 ;
 ;
EN ;- Entry point for multiple patients (part of Multiple Dates/Procs option)
 ;
 N ECGO,ECNXT,ECPAT,ECORD,ECPCE,ECPCEQ,ECS
 ;
 ;- Ask patient related questions
 D ENPAT(.ECGO)
 ;
 ;- ListMan entry point
 I +$G(ECGO)=1 D EN^VALM("EC MUL PATIENTS")
 ;
 Q
 ;
ENPAT(ECFL,ECONE) ;- Ask patient name, ordering section, inpat/outpat,
 ;                  dx, assoc clinic, and classification questions
 ;                  (AO, IR, EC, SC, MST, HNC, CV, SHAD)
 ;
SEL K ECNXT,ECPAT,ECORD,ECPCE,ECPCEQ,ECS
 S ECFL=1,ECS=""
 ;
 ;- Patient name
 S ECNXT=$$ASKPAT^ECMUTL1(.ECPAT)
 I ECNXT=-1!((ECNXT=-2)&('$D(^TMP("ECPAT",$J)))) S ECFL=-1 G ENPATQ
 I ECNXT=-2,$D(^TMP("ECPAT",$J)) G ENPATQ
 ;
 ;- Inpatient/outpatient status (in ECPCE("I/O"))
 I '$$INOUT^ECMUTL1(ECPAT) G ENPATQ
 ;
 ;- Patient eligibility (in ECPCE("ELIG"))
 D ASKELIG^ECMUTL1(ECDSSU,ECPCE("I/O"),ECPAT)
 ;
 ;- Display inpatient/outpatient status on screen
 D DSPSTAT^ECUTL0(ECPCE("I/O"))
 ;
 ;- Ordering section
 S ECORD=$$ASKORD^ECMUTL1
 I 'ECORD D REMOVE^ECMUTL1(ECPAT) G ENPATQ
 ;
 ;- Send Event Code Screen IEN of first procedure (used only if 'Send to
 ;  PCE' fld in DSS Unit file is 'N' and patient is an inpatient)
 ;
 I $P($G(^TMP("ECMPIDX",$J,1)),"^",3)]"" S ECS=$O(^ECJ("AP",ECL,+$P(ECDSSU,"^"),+ECCAT,$P($G(^TMP("ECMPIDX",$J,1)),"^",3),0))
 ;
 ;- Dx, associated clinic, and classification questions
 S ECPCEQ=$$PCEDAT^ECMUTL1(+$P(ECDSSU,"^"),ECS,.ECPCE)
 I ECPCEQ>0 D REMOVE^ECMUTL1(ECPAT) G ENPATQ
 I ECPCEQ=0 D BLDPAT
ENPATQ I '$G(ECONE),ECNXT>0 W ! G SEL
 Q
 ;
 ;
BLDPAT ;- Build ^TMP("ECPAT",$J) array with patient data
 ;
 N ECNODE,ECNUM
 S ECNUM=2
 S $P(^TMP("ECPAT",$J,$P(ECPAT,"^")),"^",12)=""
 S $P(^TMP("ECPAT",$J,$P(ECPAT,"^")),"^",1)=$P(ECPAT,"^",2)
 S $P(^TMP("ECPAT",$J,$P(ECPAT,"^")),"^",2)=+$P(ECORD,"^")
 F ECNODE="I/O","CLIN","CLINNM","DX","DXNM","AO","ENV","IR","SC","ELIG","MST","HNC","CV","SHAD" D
 . S ECNUM=ECNUM+1
 . S $P(^TMP("ECPAT",$J,$P(ECPAT,"^")),"^",ECNUM)=$S(ECNODE="CLINNM":$P($G(ECPCE("CLIN")),"^",2),ECNODE="DXNM":$P($G(ECPCE("DX")),"^",2),1:$P($G(ECPCE(ECNODE)),"^"))
 I $D(ECPCE("DXS")) M ^TMP("ECPAT",$J,$P(ECPAT,"^"),"DXS")=ECPCE("DXS")
 Q
 ;
 ;
HDR ;- Header
 ;
 S VALMHDR(1)=" Location: "_$G(ECLN)_"  ("_$G(ECL)_")"
 S VALMHDR(1)=$$SETSTR^VALM1("Provider #1: "_$P(ECU(1),"^",2),VALMHDR(1),40,30)
 S VALMHDR(2)=" DSS Unit: "_$P(ECDSSU,"^",2)
 S VALMHDR(2)=$$SETSTR^VALM1("   Category: "_$P(ECCAT,"^",2),VALMHDR(2),40,30)
 Q
 ;
 ;
INIT ;-- Init vars and display selected procedures for patient(s)
 ;
 N ECPTCNT,BL,X,IC,IW,DC,DW,NC,NW,PC,PW,RC,RW,SC,SW
 K ^TMP("ECMPT",$J),^TMP("ECMPTIDX",$J)
 D CLEAN^VALM10
 ;
 S (VALMCNT,ECPTCNT)=0
 S BL="",$P(BL," ",30)=""
 S X=VALMDDF("INDEX"),IC=$P(X,"^",2),IW=$P(X,"^",3)
 S X=VALMDDF("PATIENT"),PC=$P(X,"^",2),PW=$P(X,"^",3)
 S X=VALMDDF("SSN"),SC=$P(X,"^",2),SW=$P(X,"^",3)
 ;
 D BLD
 S $P(^TMP("ECMPT",$J,0),"^",4)=VALMCNT
 Q
 ;
 ;
BLD ;- Get data from array for screen display
 ;
 N DFN,ECDFN,ECX,VA,VAERR
 S ECDFN=0 F  S ECDFN=$O(^TMP("ECPAT",$J,ECDFN)) Q:'ECDFN  D
 . K DFN S DFN=ECDFN D PID^VADPT6
 . D BLDLM
 . D PRDSP
 Q
 ;
 ;
BLDLM ;- Display patient data
 ;
 K ECX
 S ECPTCNT=ECPTCNT+1,ECX="",$P(ECX," ",VALMWD+1)=""
 S ECX=$E(ECX,1,IC-1)_$E(ECPTCNT_BL,1,IW)_$E(ECX,IC+IW+1,VALMWD)
 S ECX=$E(ECX,1,PC-1)_$E($P(^TMP("ECPAT",$J,ECDFN),"^")_BL,1,PW)_$E(ECX,PC+PW+1,VALMWD)
 S ECX=$E(ECX,1,SC-1)_$E($G(VA("PID"))_BL,1,SW)_$E(ECX,SC+SW+1,VALMWD)
 ;
 D SET(ECX)
 ;
 ;- Tmp array ECMPTIDX contains:
 ;  Cnt^DFN^Name^Ord Sect^In/Out^Clin^Clin Nam^DX^DX Nam^AO^EC^IR^SC^Elig^MST^HNC^CV^SHAD
 ;
 S ^TMP("ECMPTIDX",$J,ECPTCNT)=VALMCNT_"^"_ECDFN_"^"_$G(^TMP("ECPAT",$J,ECDFN))
 ;- Set secondary diagnosis codes in array ECMPTIDX
 I $D(^TMP("ECPAT",$J,ECDFN,"DXS")) D
 . M ^TMP("ECMPTIDX",$J,ECPTCNT,"DXS")=^TMP("ECPAT",$J,ECDFN,"DXS")
 Q
 ;
 ;
SET(X) ;- Create ^TMP("ECMPT",$J) array for screen display
 ;
 S VALMCNT=VALMCNT+1,^TMP("ECMPT",$J,VALMCNT,0)=X
 S ^TMP("ECMPT",$J,"IDX",VALMCNT,ECPTCNT)=""
 Q
 ;
 ;
PRDSP ;- Display selected procedure dates/times and procedures
 ;
 N I,X,J,ECCPT,ECPR
 S I=0
 D SET("")
 D SET($$SETSTR^VALM1("Procedure(s):","",8,13))
 D CNTRL^VALM10(VALMCNT,8,13,IORVON,IORVOFF)
 ;
 F  S I=$O(^TMP("ECMPIDX",$J,I)) Q:'I  D
 . S X=""
 . S X=$$SETSTR^VALM1($$FTIME^VALM1($P($G(^TMP("ECMPIDX",$J,I)),"^",2)),X,10,18)
 . S X=$$SETSTR^VALM1($P($P($G(^TMP("ECMPIDX",$J,I)),"^",3),";"),X,34,5)
 . S ECCPT=$P(^TMP("ECMPIDX",$J,I),"^",3)
 . S ECCPT=$S(ECCPT["ICPT":+ECCPT,1:$P($G(^EC(725,+ECCPT,0)),"^",5))
 . I ECCPT'="" S ECCPT=$P($$CPT^ICPTCOD(ECCPT,$P(^TMP("ECMPIDX",$J,I),"^",2)),"^",2)
 . S ECPR=$S(ECCPT'="":ECCPT_" ",1:ECCPT)_$P(^TMP("ECMPIDX",$J,I),"^",4)
 . S X=$$SETSTR^VALM1(ECPR,X,42,VALMWD)
 . D SET(X)
 . ;set modifier in ^TMP global for display 
 . S J="" F  S J=$O(^TMP("ECMPIDX",$J,I,"MOD",J)) Q:J=""  S X="" D
 . . S X=$$SETSTR^VALM1("  - "_J_" "_$P(^TMP("ECMPIDX",$J,I,"MOD",J),"^"),X,41,VALMWD)
 . . D SET(X)
 ;
 D SET("")
 ;
PRDSPQ Q
 ;
HLPS ;- Brief help
 ;
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
HELP ;- Help for list
 S ECZ=""
 I $D(X),X'["??" D HLPS,PAUSE^VALM1 G HLPQ
 D CLEAR^VALM1
 F I=1:1 S ECZ=$P($T(HELPTXT+I),";",3,99) Q:ECZ="$END"  D PAUSE^VALM1:ECZ="$PAUSE" Q:'Y  W !,$S(ECZ["$PAUSE":"",1:ECZ)
 W !,"Possible actions are the following:"
 D HLPS,PAUSE^VALM1 S VALMBCK="R"
HLPQ K ECZ,Y,I Q
 ;
EXIT ;- Clean up and exit
 ;
 K ECPLST
  K ^TMP("ECPAT",$J),^TMP("ECMPT",$J)
 K VALMDDF
 D CLEAN^VALM10,CLEAR^VALM1
 Q
 ;
 ;
PATDEL ;- Entry point for EC MUL PAT DEL protocol
 ;
 N ECFND,ECI,ECSEL,VALMY
 S VALMBCK=""
 D FULL^VALM1
 D EN^VALM2(XQORNOD(0))
 S (ECFND,ECSEL)=0
 F  S ECSEL=$O(VALMY(ECSEL)) Q:'ECSEL  D
 . I $D(^TMP("ECMPTIDX",$J,ECSEL)) K ECDAT S ECDAT=^(ECSEL) D
 .. S ECI=0 F  S ECI=$O(^TMP("ECPAT",$J,ECI)) Q:'ECI!(ECFND)  D
 ... I $P(ECDAT,"^",2)=ECI S ECFND=1 K ^TMP("ECPAT",$J,ECI) D REMOVNM(ECI)
 .. I ECFND=0 W !!,*7,">>> This patient could not be found. <<<" D PAUSE^VALM1 Q
 I ECFND=1 D INIT^ECMLMN
 S VALMBCK="R"
 K ECDAT
PATDELQ Q
 ;
 ;
REMOVNM(ECI) ;- Remove patient name from array which tracks dup patients
 ;
 Q:'$G(ECI)
 N ECX
 S ECX=0
 F  S ECX=$O(^TMP("ECPLST",$J,ECX)) Q:'ECX  D
 . I +$P($G(^TMP("ECPLST",$J,ECX)),"^")=ECI K ^TMP("ECPLST",$J,ECX)
 Q
 ;
 ;
ADDPAT ;- Entry point for EC MUL PAT ADD protocol
 ;
 N ECADD,ECOK
 S VALMBCK=""
 D FULL^VALM1
 D ENPAT(.ECOK,1)
 I +$G(ECOK)=1 D INIT^ECMLMN
 I +$G(ECOK)<0 W !!,*7,">>> No patient entered. <<<" D PAUSE^VALM1
 S VALMBCK="R"
ADDPATQ Q
 ;
 ;
HELPTXT ; - Help text
 ;;Enter actions(s) by typing the name(s), or abbreviation(s).
 ;;
 ;;ACTION DEFINITIONS:
 ;;  AP - Add a Patient allows the user to add a Patient to those
 ;;        patients previously entered
 ;;  DP - Delete a Patient allows the user to delete a patient from
 ;;        those patients previously entered
 ;;  FP - File Patients will enter the patients into the Event Capture
 ;;        procedure database
 ;;  
 ;; NOTE: The procedures you have entered with this option MUST be filed
 ;;       with the 'FP' action for the data to be filed into the Event
 ;;       Capture system.
 ;;------------------------------------------------------------------------------
 ;;$PAUSE
 ;;$END
