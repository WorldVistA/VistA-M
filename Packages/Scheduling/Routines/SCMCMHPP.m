SCMCMHPP ;BP-CIOFO/LLH - MH Clinician's Patients ; 2/7/2012 10:00am
 ;;5.3;Scheduling;**589**;AUG 13, 1993;Build 41
 ;
 ;Routine copied from SCRPPAT and modified for Mental Health. 
 ;Specific modification is to screen for Mental Health teams and
 ;if all selected it will be all MH teams
 ;as well as outputting an '^' delimited summary report.
 ;
PROMPTS ;
 ;Prompt for division, team, role, clinician, summary only and 
 ;print device
 ;
 N QTIME,PRNT,VAUTP,Y,VAUTD,VAUTT,VAUTR,VAUTS,SORT,NUMBER,VADEL
 K SCUP
 S QTIME=""
 W ! D INST^SCRPU1 I Y=-1 G ERR
 ;Patch 589 - screen teams for Mental Health only
 W ! K Y D PRMTT^SCMCMHU1 I '$D(VAUTT) G ERR
 W ! K Y D ROLE^SCRPU1 I '$D(VAUTR) G ERR
 W ! D PRACT^SCMCMHU1 I '$D(VAUTP) G ERR
 W ! S VAUTS=$$SUMM^SCRPU2() I VAUTS<0 G ERR
 ;Patch 589 - if summary report being requested, ask for ^ delimited output
 S:'VAUTS VADEL=0
 I VAUTS W ! S VADEL=$$DELOUT^SCMCMHU1() I VADEL<0 G ERR
 S SORT=""
 I VADEL=1 S SORT=1
 I SORT'=1 W ! S SORT=$$SORT^SCMCMHU1() I SORT<1 G ERR
 S PRNT=$$PDEVICE^SCRPU3()
 I PRNT=-1 G ERR
 I PRNT["Q;" S QTIME=$$GETTIME^SCRPU3()
 I QTIME=-1 G ERR
 I PRNT'?1"Q;".E S PRNT="Q;"_PRNT
 ;Patch 589 - added VADEL
 S NUMBER=$$ENTRY2(.VAUTD,.VAUTT,.VAUTR,.VAUTP,VAUTS,SORT,PRNT,QTIME,VADEL)
 I NUMBER>0 W !!,"Print queued, task number: ",NUMBER
 Q
 ;
ENTRY2(INST,TEAM,ROLE,PRACT,SUMM,SORT,IOP,ZTDTH,VADEL) ;
 ;Second entry point for GUI to use
 ;Input Parameters:
 ;INST - institutions selected (variable and array)
 ;TEAM - teams selected (variable and array)
 ;ROLE - roles selected (variable and array)
 ;PRACT - clinicians selected (ien new person file) - (variable and array)
 ;SUMM - summary info? y/n (1-yes/0-no) yes don't print patient data
 ;SORT - sort criteria (1-d,t,p/2-d,p,t)
 ;IOP - print device
 ;ZTDTH - queue time (optional)
 ;
 ;validate parameters
 I '$D(INST)!'$D(TEAM)!'$D(ROLE)!'$D(PRACT)!'$D(SUMM)!'$D(SORT)!'$D(IOP)!(IOP="")!'$D(VADEL) Q
 ;
 N NUMBER
 S IOST=$P(IOP,"^",2),IOP=$P(IOP,"^")
 I IOP?1"Q;".E S IOP=$P(IOP,"Q;",2)
 I IOST?1"C-".E D QENTRY G RET
 I ZTDTH="" S ZTDTH=$H
 S ZTRTN="QENTRY^SCMCMHPP"
 ;patch 589 changed clinician's to Clinician's
 S ZTDESC="MH Clinician's Patients",ZTIO=IOP
 N II
 ;Patch 589 added VADEL
 F II="IOSL","INST","INST(","TEAM","TEAM(","ROLE","ROLE(","PRACT(","PRACT","SUMM","IOP","SORT","VADEL" S ZTSAVE(II)=""
 D ^%ZTLOAD
RET S NUMBER=0
 I $D(ZTSK) S NUMBER=ZTSK
 D EXIT1
 Q NUMBER
 ;
QENTRY ;
 ;driver entry point
 ;patch 589 changed clinician's to Clinician's
 S TITL="MH Clinician's Patients"
 I SUMM S TITL=TITL_" Summary Report"
 S STORE="^TMP("_$J_",""SCRPPAT"")"
 K @STORE
 S @STORE=0
 ;Patch 589, changed from ^SCRPPAT2 to ^SCMCMHP2
 D DRIVE^SCMCMHP2
 I $O(@STORE@(0))="" S NODATA=$$NODATA^SCRPU3(TITL)
 ;Patch 589 - if output is sent to a delimited format, use selected device
 ; but do special formating
 I '$D(NODATA)&VADEL D SPECFMT(STORE)
 I '$D(NODATA)&'VADEL D PRINTIT(STORE,IOP,TITL,SORT)
 D EXIT2
 Q
 ;
ERR ;
EXIT1 ;
 K ZTDTH,ZTRTN,ZTDESC,ZTSK,ZTIO,ZTSAVE,VAUTD,VAUTT,VAUTP,VAUTR
 K SCUP,VAUTS,SORT
 Q
 ;
EXIT2 ;
 K @STORE
 K STORE,TITL,IOP,PRACT,INST,TEAM,ROLE,SORT,SUMM,NODATA,STOP
 Q
 ;
PRINTIT(STORE,IOP,TITL,SORT) ; Print All Data
 ;STORE - global location of data
 ;IOP - device to print to
 ;TITL - title of report
 ;SORT - sort order 1-div,team,clinician/2-div,clinician,team
 ;
 N PAGE
 S PAGE=1,STOP=0 W:$E(IOST)="C" @IOF
 N SEC1,SEC2,SEC2,SEC3,SEC4,ST1,ST2,ST3,ST4
 I SORT=1 S SEC1="""T""",SEC2="""P""",SEC3="""TN""",SEC4="""PN"""
 I SORT=2!(SORT=3) S SEC1="""P""",SEC2="""T""",SEC3="""PN""",SEC4="""TN"""
 N SEC,TRD,INS,INAME,SECN,TRDN,PT,FIRST
 S (INAME,INS)="",FIRST=1
 F  S INAME=$O(@STORE@("I",INAME)) Q:INAME=""!(STOP)  D
 .S INS=$O(@STORE@("I",INAME,""))
 .Q:INS=""!STOP
 .D S
 D S1
 Q
S ;
 S SECN="",ST1=$E(STORE,1,($L(STORE)-1))_","_SEC1_")"
 F  S SECN=$O(@ST1@(INS,SECN)) Q:SECN=""!(STOP)  D
 .S SEC=$O(@ST1@(INS,SECN,"")) ;ien of team or clinician
 .Q:SEC=""
 .S ST3=$E(STORE,1,($L(STORE)-1))_","_SEC3_")"
 .S TRDN="",ST2=$E(STORE,1,($L(STORE)-1))_","_SEC2_")"
 .F  S TRDN=$O(@ST2@(INS,TRDN)) Q:TRDN=""!(STOP)  D
 ..S TRD=$O(@ST2@(INS,TRDN,"")) ;ien of team or clinician
 ..Q:TRD=""
 ..;have first team and first clinician ien
 ..S ST4=$E(STORE,1,($L(STORE)-1))_","_SEC4_")"
 ..D PRNT(ST4,ST3,SEC3,.PAGE,TITL,INS,SEC,TRD) Q:STOP
 Q
S1 I $E(IOST)="C",'STOP W ! N DIR S DIR(0)="E" D ^DIR S STOP=Y'=1
 I 'STOP,SUMM=0 S (FIRST,SUMM)=1,TITL=TITL_" Summary Report" W @IOF D PRINTIT(STORE,$G(IOP),TITL,SORT)
 Q
 ;
PRNT(ST4,ST3,SEC3,PAGE,TITL,INS,SEC,TRD) ;
 ;
 N POS
 I (SEC3="""PN""")&($D(@ST3@(INS,SEC,TRD))) D
 .;get each position for clinician
 .N MORE S POS="",MORE=0
 .F  S POS=$O(@ST3@(INS,SEC,TRD,POS)) Q:POS=""!(STOP)  D
 ..I 'SUMM I SORT=3 D  Q
 ...;I MORE ;S FIRST=0
 ...K @STORE@("H1") D SHEAD
 ...I 'MORE I (PAGE=1)!(IOST?1"C-".E) D TITLE^SCRPU3(.PAGE,TITL)
 ...;patch 589 -- modified to print, Clinician rather than Practitioner
 ...I 'MORE N STR S STR=$G(@ST3@(INS,SEC,TRD,POS)) W !," Clinician:"_$P(STR,":",2),!
 ...;I 'MORE W !,$G(@ST3@(INS,SEC,TRD,POS)),!
 ...D PAT^SCRPPAT3(INS,SEC,TRD,SEC3,ST3,ST4,POS) S MORE=1
 ...I $O(@ST3@(INS,SEC,TRD,POS))="" D
 ....I (IOST?1"C-".E) D HOLD(.PAGE,"") S PAGE=PAGE+1 Q:STOP
 ....I (IOST'?1"C-".E) D NEWP1^SCRPU3(.PAGE,TITL) Q:STOP
 ..I SUMM D  Q
 ...I FIRST D TITLE^SCRPU3(.PAGE,TITL),SHEAD,SSH S FIRST=0
 ...I (IOST'?1"C-".E),$Y>(IOSL-4) D NEWP1^SCRPU3(.PAGE,TITL) Q:STOP  D SSH
 ...I (IOST?1"C-".E),$Y>(IOSL-6) D HOLD^SCRPU3(.PAGE,TITL) Q:STOP  D SSH
 ...W !,@STORE@("SUM0",INS,SEC,TRD,POS)
 ...W ?72,$J($G(@STORE@("TOTAL",INS,SEC,TRD,POS)),8)
 ...Q
 ..Q:SORT=3
 ..I FIRST D:'MORE TITLE^SCRPU3(.PAGE,TITL) D SHEAD
 ..;patch 589 - commented W commands out, it wrote the division header incorrectly
 ..I (IOST'?1"C-".E),'SUMM,'FIRST D NEWP1^SCRPU3(.PAGE,TITL) ;W:'STOP !,$G(@STORE@(INS))
 ..I (IOST?1"C-".E),'SUMM,'FIRST D HOLD^SCRPU3(.PAGE,TITL) ;W:'STOP !,$G(@STORE@(INS))
 ..Q:STOP  S FIRST=1 I 'MORE S FIRST=0
 ..;patch 589 - modified to print, Clinician rather than Practitioner
 ..N STR S STR=$G(@ST3@(INS,SEC,TRD,POS)) W !," Clinician:"_$P(STR,":",2)
 ..;W !,$G(@ST3@(INS,SEC,TRD,POS)) ;write clinician (sort 1)
 ..I $L($G(@ST3@(INS,SEC,TRD,POS,"PRCP"))) W !,@ST3@(INS,SEC,TRD,POS,"PRCP")
 ..I $G(SORT)'=3 W !,$G(@ST4@(INS,TRD)) ;write team (sort 2)
 ..W !,$G(@STORE@(INS))
 ..;$o through patients for clinician on team
 ..D PAT^SCRPPAT3(INS,SEC,TRD,SEC3,ST3,ST4,POS) Q:STOP
 ..I (IOST'?1"C-".E),$Y>(IOSL-4) D NEWP1^SCRPU3(.PAGE,TITL) Q:STOP
 ..I (IOST?1"C-".E),$Y>(IOSL-6) D HOLD^SCRPU3(.PAGE,TITL) Q:STOP
 ..D TOTAL1^SCRPPAT3(INS,SEC,TRD,POS) ;print team/clinician total
 ;
 I (SEC3="""TN""")&($D(@ST4@(INS,TRD,SEC))) D
 .S POS=""
 .F  S POS=$O(@ST4@(INS,TRD,SEC,POS)) Q:POS=""!(STOP)  D
 ..I SUMM D  Q
 ...I FIRST D TITLE^SCRPU3(.PAGE,TITL),SHEAD,SSH S FIRST=0
 ...I (IOST'?1"C-".E),$Y>(IOSL-4) D NEWP1^SCRPU3(.PAGE,TITL) Q:STOP  D SSH
 ...I (IOST?1"C-".E),$Y>(IOSL-6) D HOLD^SCRPU3(.PAGE,TITL) Q:STOP  D SSH
 ...W !,@STORE@("SUM0",INS,TRD,SEC,POS)
 ...W ?72,$J(@STORE@("TOTAL",INS,TRD,SEC,POS),8)
 ...Q
 ..I FIRST D TITLE^SCRPU3(.PAGE,TITL),SHEAD
 ..I (IOST'?1"C-".E),'SUMM,'FIRST D NEWP1^SCRPU3(.PAGE,TITL)
 ..I (IOST?1"C-".E),'SUMM,'FIRST D HOLD^SCRPU3(.PAGE,TITL)
 ..Q:STOP  S FIRST=0
 ..I $G(SORT)'=3 W !,$G(@ST3@(INS,SEC)) ;write team (sort 1)
 ..W !,$G(@STORE@(INS))
 ..;patch 589 - modified to print, Clinician rather than Practitioner
 ..I $G(SORT)'=3 N STR D
 ...S STR=$G(@ST4@(INS,TRD,SEC,POS)) W !," Clinician:"_$P(STR,":",2)
 ..;I $G(SORT)'=3 W !,$G(@ST4@(INS,TRD,SEC,POS)) ;write clinician (sort 2)
 ..I $L($G(@ST4@(INS,TRD,SEC,POS,"PRCP"))) W !,@ST4@(INS,TRD,SEC,POS,"PRCP")
 ..W !
 ..;$o through patients for clinician on team
 ..D PAT^SCRPPAT3(INS,SEC,TRD,SEC3,ST3,ST4,POS) Q:STOP
 ..I (IOST'?1"C-".E),$Y>(IOSL-4) D NEWP1^SCRPU3(.PAGE,TITL) Q:STOP
 ..I (IOST?1"C-".E),$Y>(IOSL-6) D HOLD^SCRPU3(.PAGE,TITL) Q:STOP
 ..D TOTAL1^SCRPPAT3(INS,SEC,TRD,POS) ;print team/clinician total
 Q
 ;
SPECFMT(STORE) ; Patch 589 - format delimited output
 ;STORE - global location of data
 ;IOP - device to print to
 ;TITL - title of report
 ;SORT - sort order 1-div,team,clinician/2-div,clinician,team
 ;
 N DATA,INS,POS,SEC,TRD
 ;Patch 589 changed Practitioner's to Clinician
 W !,"Printed on: "_$$FMTE^XLFDT(DT,"5D")_U_"Clinician's Patients Summary Report"
 W !,"Clinician"_U_"Position"_U_"Team"_U_"Patients Assigned"
 S INS=0 F  S INS=$O(@STORE@("SUM0",INS)) Q:INS'>0  D
 .S SEC=0 F  S SEC=$O(@STORE@("SUM0",INS,SEC)) Q:SEC'>0  D
 ..S TRD=0 F  S TRD=$O(@STORE@("SUM0",INS,SEC,TRD)) Q:TRD'>0  D
 ...S POS=0 F  S POS=$O(@STORE@("SUM0",INS,SEC,TRD,POS)) Q:POS'>0  D
 ....S DATA=@STORE@("SUM0",INS,SEC,TRD,POS)
 ....W !,$$FMTDATA(DATA)_U_$G(@STORE@("TOTAL",INS,SEC,TRD,POS))
 Q
 ;
FMTDATA(DATA) ;
 ; patch 589, used to strip trailing spaces from the formated data
 ; input - DATA = formatted data, clinician, Position, Team and Patients Assigned
 ; output - STR = data in DATA, with trailing spaces removed
 ;
 N K,D1,D2,D3,STR
 S STR=""
 I $G(DATA)="" Q "^^^"
 S D1=$E(DATA,1,22),D2=$E(DATA,25,48),D3=$E(DATA,49,71)
 F K=$L(D1):-1 Q:$E(D1,K)'=" "  S D1=$E(D1,1,$L(D1)-1)
 F K=$L(D2):-1 Q:$E(D2,K)'=" "  S D2=$E(D2,1,$L(D2)-1)
 F K=$L(D3):-1 Q:$E(D3,K)'=" "  S D3=$E(D3,1,$L(D3)-1)
 S STR=D1_U_D2_U_D3
 Q STR
 ;
SSH ;Summary subheader
 ;Patch 589 changed "Practitioner" to "Clinician"
 W !?72,"Patients",!,"Clinician",?24,"Position",?48,"Team"
 W ?72,"Assigned",! N SCI F SCI=1:1:80 W "="
 Q
HOLD(PAGE,TIT,MARG) ;
 ;device is home, reached end of page
 N X
 S MARG=$G(MARG) S:MARG'>80 MARG=80
 W !!,"Press Any Key to Continue or '^' to Quit" R X:DTIME
 I '$T!(X="^") S STOP=1 Q
 W @IOF
 Q
SHEAD ;
 ;Patch 589 - moved SHEAD from SCRPPAT3 and removed M.T. Stat
 S @STORE@("H2")="Pt Name"
 S $E(@STORE@("H2"),15)="Pt ID"
 ;Removed by patch 589
 ;S $E(@STORE@("H1"),25)="M.T."
 ;S $E(@STORE@("H2"),25)="Stat"
 S $E(@STORE@("H1"),31)="Prim"
 S $E(@STORE@("H2"),31)="Elig"
 S $E(@STORE@("H1"),42)="Last"
 S $E(@STORE@("H2"),42)="Appt"
 S $E(@STORE@("H1"),54)="Next"
 S $E(@STORE@("H2"),54)="Appt"
 S $E(@STORE@("H2"),66)="Clinic"
 S $P(@STORE@("H3"),"=",81)=""
 Q
