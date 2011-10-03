RAPRINT1 ;HISC/FPT-Abnormal Exam Report (cont.) ;4/5/96  10:49
 ;;5.0;Radiology/Nuclear Medicine;**34,97**;Mar 16, 1998;Build 6
DIV ; walk through tmp global, start with 'division'
 Q:'$D(^TMP($J))
 N RAFIRST,RAPRTSET,RASAME,RACURR,RAPREV,L1
 S RADIVNME=""
 F  S RADIVNME=$O(^TMP($J,RADIVNME)) Q:RADIVNME=""!(RAOUT)  D IT
 Q
IT ; imaging type
 S RAITNAME=""
 F  S RAITNAME=$O(^TMP($J,RADIVNME,RAITNAME)) Q:RAITNAME=""!(RAOUT)  D DXNUM
 Q
DXNUM ; diagnostic code number
 S RAPREV="" ; Determine If Next Line Item is Related to Previous Line.
 S I=0
 F  S I=$O(^TMP($J,RADIVNME,RAITNAME,I)) Q:I'>0!(RAOUT)  D PATNAME
 Q
PATNAME ; patient name
 S RAPATNME=""
 F  S RAPATNME=$O(^TMP($J,RADIVNME,RAITNAME,I,RAPATNME)) Q:RAPATNME=""!(RAOUT)  D PATIEN
 Q
PATIEN ; patient internal entry number
 S J=0
 F  S J=$O(^TMP($J,RADIVNME,RAITNAME,I,RAPATNME,J)) Q:J'>0!(RAOUT)  D EXAMDATE
 Q
EXAMDATE ; exam date
 S K=0
 F  S K=$O(^TMP($J,RADIVNME,RAITNAME,I,RAPATNME,J,K)) Q:K'>0!(RAOUT)  D CASENUM
 Q
CASENUM ; case number
 S (RAPRTSET,RAFIRST)=0 ; Group PrintSet Exams for Printing.
 S RASAME=0 ; Group Multiple Diagnoses of Same Exam for Printing.
 S L1=$O(^TMP($J,RADIVNME,RAITNAME,I,RAPATNME,J,K,0))
 I L1>0,$P(^RADPT(J,"DT",K,"P",L1,0),U,25)=2 S RAFIRST=1 D
 .I $O(^RADPT(J,"DT",K,"P",L1),-1) S RAFIRST=2 ; Not First PrintSet Exam.
 S L=0
 F  S L=$O(^TMP($J,RADIVNME,RAITNAME,I,RAPATNME,J,K,L)) Q:L'>0!(RAOUT)  D
 .D DECIDE S (RAFIRST,RAPRTSET)=0
 .S RAPREV=J_U_K_U_L ; This Represents Last Line Printed.
 Q
DECIDE ; decide which entries to print
 S RAEXAM(0)=^RADPT(J,"DT",K,"P",L,0)
 I 'RAFIRST,$P(RAEXAM(0),U,25)=2 S RAPRTSET=1 ; Determine Descendants.
 S RACURR=J_U_K_U_L ; Save Current Line Info to be Printed.
 S RADIAG=$P(^RA(78.3,I,0),U)
 S RADXCODE=$S($P(RAEXAM(0),U,13)=I:"(P)",1:"(S)")
 I RASW D PRINT Q
 I RADXCODE="(P)",$P(RAEXAM(0),U,20) Q
 I RADXCODE="(P)",'$P(RAEXAM(0),U,20) D PRINT Q
 I '$D(^RADPT(J,"DT",K,"P",L,"DX")) Q
 S RASDXIEN=$O(^RADPT(J,"DT",K,"P",L,"DX","B",I,0)) I RASDXIEN'>0 Q
 S RASDXDTE=$P(^RADPT(J,"DT",K,"P",L,"DX",RASDXIEN,0),U,2)
 I RASDXDTE="" D PRINT
 Q
PRINT ; print entries
 I $Y+5>IOSL D HANG Q:RAOUT  D HDR Q:RAOUT
 I I1("DIV")="" W !?22,"Division: ",RADIVNME S I1("DIV")=RADIVNME
 I I1("IT")="" W !?18,"Imaging Type: ",RAITNAME S I1("IT")=RAITNAME
 I I1("DIV")'=RADIVNME!(I1("IT")'=RAITNAME) D HANG Q:RAOUT  D HDR Q:RAOUT  S I1("DIV")=RADIVNME S I1("IT")=RAITNAME D
 .W !?22,"Division: ",RADIVNME
 .W !?18,"Imaging Type: ",RAITNAME
 .I I1("DX")=I W !?15,"Diagnostic Code: ",RADIAG W !?15,"----------------" D EXPRESS
 I I1("DX")'=I W !?15,"Diagnostic Code: ",RADIAG W !?15,"----------------" D EXPRESS
 S RADFN=J,RAPAT=$S($D(^DPT(J,0)):^(0),1:""),RASSN=$$SSN^RAUTL(RADFN,1)
 S RAPAT=$S($P(RAPAT,U)]"":$P(RAPAT,U),1:"Not Found")
 S Y=9999999.9999-K X ^DD("DD") S RAEXDT=Y
 S RACASE=$P(RAEXAM(0),U)
 S RAWARD=$S($P(RAEXAM(0),U,6):$P(RAEXAM(0),U,6),1:"")
 I RAWARD]"" S RAWARD=$S($D(^DIC(42,RAWARD,0)):$P(^(0),U),1:"")
 I RAWARD']"" S RAWARD=$S($P(RAEXAM(0),U,8):$P(RAEXAM(0),U,8),1:"") I RAWARD]"" S RAWARD=$S($D(^SC(RAWARD,0)):$P(^(0),U),1:"Unknown")
 S RAPROC=$P(RAEXAM(0),U,2)
 S RAPROC=$S($D(^RAMIS(71,RAPROC,0)):$P(^(0),U),1:"Unknown")
 S RAMD=$P(RAEXAM(0),U,14)
 S RAMD=$S(RAMD="":"Unknown",$D(^VA(200,RAMD,0)):$P(^(0),U),1:"Unknown")
 I RADXCODE="(S)",'$D(RASDXIEN) D SDX I '$D(RASDXDTE) K RADXCODE,RASDXDTE,RASDXIEN G PQ
 I RAFIRST!'RAPRTSET D  ; Print Patient Header Once for PrintSets.
 .I RAPREV=RACURR Q  ; Print Patient Header Once for Multiple Dx.
 .W !!
 .I RADXCODE="(P)" W $S($P(RAEXAM(0),U,20):"*",1:"")
 .I RADXCODE="(S)" W $S(RASDXDTE]"":"*",1:"")
 .W $E(RAPAT,1,30)_" -"_RASSN,?38,RADXCODE,?42,$E(RAWARD,1,15),?58,$E(RAMD,1,21)
 ; Print Pat. Case# Once for Single Exam with Multiple Dx or
 ; Once for PrintSets.
 ; Once for different DX though same pat. case#
 I (RAPREV'=RACURR)!(I1("DX")'=I)!RAPRTSET D
 .W !?2 W:RAFIRST=1 "(+)" I (RAFIRST=2)!RAPRTSET W "(.)"
 .W ?6,"Case #",RACASE,?20,$E(RAPROC,1,39),?60,RAEXDT
 I RADXCODE="(P)",'$P(^RADPT(J,"DT",K,"P",L,0),U,20) S $P(^(0),U,20)=DT
 I RADXCODE="(S)",'$P(^RADPT(J,"DT",K,"P",L,"DX",RASDXIEN,0),U,2) S $P(^(0),U,2)=DT
 S ^TMP($J,"RADLY",RADIVNME,RAITNAME)=+^TMP($J,"RADLY",RADIVNME,RAITNAME)+1,CNT=CNT+1
PQ S I1("DX")=I
 K RADXCODE,RASDXDTE,RASDXIEN
 Q
EXPRESS ;output expression text
 N RAXPRESS
 S RAXPRESS=$$GET1^DIQ(757.01,$P($G(^RA(78.3,+I,0)),U,6),.01)
 I RAXPRESS'="" W ?32,"(",RAXPRESS,")"
 Q
HDR ; header
 W:$Y>0 @IOF
 W !?20,"<<<< ABNORMAL DIAGNOSTIC REPORT >>>>",?58,"Print Date: ",PDATE
 W !?13,"(P=Primary Dx, S=Secondary Dx / '*' represents reprint)"
 W !?(80-$L($G(RATRPTG))\2),$G(RATRPTG)
 W !,"Patient Name",?42,"Ward/Clinic",?58,"Requesting Physician"
 W !?20,"Procedure",?60,"Exam Date",!,QQ
 S I1("DIV")="",I1("IT")=""
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAOUT=1
 Q
HANG ; hold screen
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 S:$D(DIRUT) RAOUT=1
 Q
SDX ; secondary dx ien and date
 I '$D(^RADPT(J,"DT",K,"P",L,"DX")) Q
 S RASDXIEN=$O(^RADPT(J,"DT",K,"P",L,"DX","B",I,0))
 Q:RASDXIEN'>0
 S RASDXDTE=$P(^RADPT(J,"DT",K,"P",L,"DX",RASDXIEN,0),U,2)
 Q
