SDAMQ3 ;ALB/MJK - AM Background Job/Appointments ; 12/1/91
 ;;5.3;Scheduling;**24,466**;Aug 13, 1993;Build 2
 ;
EN(SDBEG,SDEND) ; -- search appts
 N VAUTD,SDCL,X,SDIVNM,SDNAME,SDT,SDDA,SDREQ,SDNONCNT
 S VAUTD=+$P($G(^DG(43,1,"GL")),U,2) S:'VAUTD VAUTD(+$O(^DG(40.8,0)))=""
 S SDCL=0 F  S SDCL=$O(^SC(SDCL)) Q:'SDCL  S X=$G(^SC(SDCL,0)) I $P(X,U,3)["C" D
 .S SDNONCNT=($P(X,U,17)="Y") ; non-count clinic?
 .S SDNAME=$E($P(X,U),1,30),SDIVNM=""
 .S X=$$DIV^SDAMU(.SDCL,.VAUTD,.SDIVNM,35)
 .S SDT=SDBEG F  S SDT=$O(^SC(SDCL,"S",SDT)) Q:'SDT!(SDT>SDEND)  S SDREQ=$$REQ^SDM1A(.SDT) D
 ..S SDDA=0 F  S SDDA=$O(^SC(SDCL,"S",SDT,1,SDDA)) Q:'SDDA  D CHK(SDCL,SDT,SDDA,.SDIVNM,.SDNAME,.SDREQ)
ENQ Q
 ;
CHK(SDCL,SDT,SDDA,SDIVNM,SDNAME,SDREQ) ; -- check appts
 ; input: SDCL := clinic ifn
 ;         SDT := appt d/t
 ;        SDDA := ifn of appt mutiple
 ;      SDIVNM := division name
 ;      SDNAME := clinic name
 ;       SDREQ := required for credit (ci or co)
 ;
 N SD0,SDC,SDNAT,Y,X,DFN,SDPT,SDOE
 S SD0=$G(^SC(SDCL,"S",SDT,1,SDDA,0)),SDC=$G(^("C")),SDNAT=0,DFN=+SD0
 S SDPT=$G(^DPT(DFN,"S",SDT,0))
 ;
 ; -- must be same clinic
 I SDCL'=+SDPT G CHKQ
 ;
 ; -- valid appointment
 I '$$VALID^SDAM2(DFN,SDCL,SDT,SDDA) G CHKQ
 ;
 ; -- check if canceled or no-showed
 S X=$P(SDPT,U,2) I X'="I",X'="",X'="NT" G CHKQ
 ;
 ; -- re-set for inpatient appt
 I X="I"!(X="") D
 .N Y
 .S Y=$$INP^SDAM2(DFN,SDT)
 .I X'=Y S $P(SDPT,U,2)=Y,^DPT(DFN,"S",SDT,0)=SDPT
 .;I Y="I" D CO(DFN,SDT,SDCL,SDREQ)
 ;
 ; -- non-count processing
 I SDNONCNT D CO(DFN,SDT,SDCL,SDREQ) G CHKQ
 ;
 ; -- has appt been checked in or out
 I SDREQ="CI",SDC!($P(SDC,U,3)) G TOT
 I SDREQ="CO" S SDOE=+$$GETAPT^SDVSIT2(DFN,SDT,SDCL) I $P(SDC,U,3),$$CO^SDAMQ(SDOE) G TOT
 G TOT:'SD0
 ;
 ; -- if good appt then set to nt
 I $P(SDPT,U,2)="" S $P(^DPT(DFN,"S",SDT,0),U,2)="NT",SDPT=^(0)
 ;
 ; -- set nt flag
 I $P(SDPT,U,2)="NT" S SDNAT=1
 ;
TOT ; -- set totals clinic
 S X=$G(^TMP("SDSTATS",$J,SDIVNM,"APPT",SDNAME)),^(SDNAME)=(X+SDNAT)_U_($P(X,U,2)+1)
CHKQ Q
 ;
CO(DFN,SDT,SDCL,SDREQ) ; -- attempt to CO quietly for inpats and non-counts
 I SDREQ'="CO" G COQ
 ; -- get encounter ien
 N SDOE S SDOE=+$$GETAPT^SDVSIT2(DFN,SDT,SDCL)
 ; -- if not checked out, try to co
 I '$$CO^SDAMQ(SDOE) D EN^SDCOM(SDOE,0)
COQ Q
 ;
BULL(SDIVNM,SDLN,SDTOT) ;
 N SDNAME,NAT,GRAND,OTHER,TGRAND,TNAT
 S SDNAME="",(TNAT,TGRAND,OTHER)=0
 D HDR
 F  S SDNAME=$O(^TMP("SDSTATS",$J,SDIVNM,"APPT",SDNAME)) Q:SDNAME=""  S X=^(SDNAME) D
 .S NAT=+X,GRAND=+$P(X,U,2)
 .S TNAT=TNAT+NAT,TGRAND=TGRAND+GRAND
 .S SDTOT("DIV","NAT")=SDTOT("DIV","NAT")+NAT
 .S SDTOT("DIV","GRAND")=SDTOT("DIV","GRAND")+GRAND
 .I 'NAT S OTHER=OTHER+GRAND
 .I NAT D LINE(SDNAME,NAT,GRAND)
 D LINE("ALL OTHER CLINICS",0,OTHER)
 D SET("         -------------                 ----------------    -------   -------")
 D LINE("Clinic Totals",TNAT,TGRAND)
BULLQ Q
 ;
LINE(CAPTION,NAT,GRAND) ;
 ; input: CAPTION := text for leftmost col
 ;            NAT := # of encounters requiring action
 ;          GRAND := total # of encounters
 N Y
 S Y="",Y=$$SETSTR^VALM1(CAPTION,Y,10,25),Y=$$SETSTR^VALM1($J(NAT,7),Y,43,7),Y=$$SETSTR^VALM1($J(GRAND,7),Y,60,7),Y=$$SETSTR^VALM1($J($S(GRAND:100*(NAT/GRAND),1:0),6,1)_"%",Y,70,7) D SET(Y)
 Q
 ;
SET(X) ;
 S SDLN=SDLN+1,^TMP("SDAMTEXT",$J,SDLN,0)=X
 Q
 ;
HDR ;
 ; input:  SDIVNM := division name
 ;
 D SET("")
 D SET("                                       Appointments          Total")
 D SET("         Clinic                        Requiring Action      Appts     Pct.")
 D SET("         ------                        ----------------    -------   -------")
 Q
