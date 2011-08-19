RARTE ;HISC/FPT,GJC AISC/MJK,RMO-Edit/Delete Reports ;05/22/09  10:20
 ;;5.0;Radiology/Nuclear Medicine;**18,34,45,56,99**;Mar 16, 1998;Build 5
 ;Supported IA #3544 ^VA(200,"ARC"
 ;Supported IA #10076 ^XUSEC(
 ;Supported IA #2056 ^GET1^DIQ
 ;Supported IA #10009 YN^DICN
 ; last modification by SS for P18 June 14,2000
 ;
 D SET^RAPSET1 I $D(XQUIT) K XQUIT Q
 W !!?3,"Note: To enter receipt of OUTSIDE INTERPRETED REPORTS,",!?3,"please use the 'Outside Report/Entry Edit' option.",!
 N RAXIT,RADRS,RASUBY0 S RAXIT=0 ;RADRS=copy (1=diag, 2=resid,staff)
 I $D(RANOSCRN) S X=$$DIVLOC^RAUTL7() I X D Q^RARTE4 QUIT
 ;
 ;1. DO NOT KILL the RASIG variable; the RASIG() array is needed in
 ;   the edit template [RA REPORT EDIT] later
 ;2. The RAELESIG canNOT store file 74's ien, as no rpt has been picked
 ;   from this call to ES^RASIGU
 ;
 I $D(^XUSEC("RA VERIFY",DUZ)),($$GET1^DIQ(200,DUZ_",",20.4)]""),($D(^VA(200,"ARC","R",DUZ))!($D(^VA(200,"ARC","S",DUZ)))) D  Q:'$D(RAELESIG)
 . W ! D ES^RASIGU S:%=1 RAELESIG=""
 . K:'$D(RAELESIG) %,%W,%Y,%Y1,C,X,X1,X2
 . Q
 K RABTCH I $P(RAMDV,"^",13) D ASKBTCH^RARTE1 G Q1^RARTE4:X["^" D 1^RABTCH:"Yy"[$E(X) I '$D(RABTCH) W " ...no batch selected",!
START K RAVER S RAVW="",RAREPORT=1 D ^RACNLU G Q^RARTE4:"^"[X
 S RASUBY0=Y(0) ; save value of y(0)
 G:$P(^RA(72,+RAST,0),"^",3)>0 DISPLAY
 I $D(^XUSEC("RA MGR",DUZ)) G DISPLAY
 G:$P(RAMDV,"^",22)=1 DISPLAY
 W $C(7),!!,"The STATUS for this case is CANCELLED. You may not enter a report.",!! D INCRPT^RARTE4 G START
 ;
DISPLAY ; Display exam specific info, edit/enter the report
 N RA18EX S RA18EX=0 ;P18 for quit if uparrow inside PUTTCOM
 I '($D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))#2) D  D Q^RARTE4 QUIT
 . W !!?2,"Case #: ",RACN," for ",RANME S RAXIT=1
 . W !?2,"Procedure: '",$E(RAPRC,1,45),"' has been deleted"
 . W !?2,"by another user!",$C(7)
 . Q
 ;Lock case node so no one else can edit rpt pointer during this session
 S RAPNODE="^RADPT("_RADFN_",""DT"","_RADTI_",""P"","
 S RAXIT=$$LOCK^RAUTL12(RAPNODE,RACNI) I RAXIT D INCRPT^RARTE4 G START
 S RAI="",$P(RAI,"-",80)="" W !,RAI
 W !?1,"Name     : ",$E(RANME,1,25),?40,"Pt ID       : ",RASSN
 W !?1,"Case No. : ",RACN,?18,"Exm. St: ",$E($P($G(^RA(72,+RAST,0)),"^"),1,12),?40,"Procedure   : ",$E(RAPRC,1,25)
        ;check for contrast media; display if CM data exists (patch 45)
 S RACMDATA=$$CMEDIA^RAUTL8(RADFN,RADTI,RACNI)
 D:$L(RACMDATA) CMEDIA(RACMDATA)
 K RACMDATA
 S RA18EX=$$PUTTCOM2^RAUTL11(RADFN,RADTI,RACN," Tech.Comment: ",15,70,-1,0) ;P18
 I RA18EX=-1 Q  ;P18
 N RAPRTSET,RAMEMARR,RA1
 D EN2^RAUTL20(.RAMEMARR)
 I RAPRTSET D
 . S RA1=""
 . F  S RA1=$O(RAMEMARR(RA1)) Q:RA1=""!(RA18EX=-1)  I RA1'=RACNI D
 .. W !,?1,"Case No. : ",+RAMEMARR(RA1)
 .. W:$P(RAMEMARR(RA1),"^",4)]"" ?18,"Exm. St: ",$E($P($G(^RA(72,$P(RAMEMARR(RA1),"^",4),0)),"^"),1,12)
 .. W ?40,"Procedure   : ",$E($P($G(^RAMIS(71,+$P(RAMEMARR(RA1),"^",2),0)),"^"),1,26)
 ..;check printset for contrast media; display if CM data exists
 ..S RACMDATA=$$CMEDIA^RAUTL8(RADFN,RADTI,RA1)
 ..D:$L(RACMDATA) CMEDIA(RACMDATA)
 ..K RACMDATA
 .. S RA18EX=$$PUTTCOM2^RAUTL11(RADFN,RADTI,+RAMEMARR(RA1)," Tech.Comment: ",15,70,-1,0) Q:RA18EX=-1  ;P18
 .. Q
 . Q
SS1 I RA18EX=-1 Q  ;P18
 W !?1,"Exam Date: ",RADATE,?40,"Technologist: " I $O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"TC",0))>0,$D(^VA(200,+^($O(^(0)),0),0)) W $E($P(^(0),"^"),1,25)
 W !?1,"Req Phys    : ",$E($S($D(^VA(200,+$P(Y(0),"^",14),0)):$P(^(0),"^"),1:""),1,25)
 ; p99: get pt sex and display pregnancy data
 I $$PTSEX^RAUTL8(RADFN)="F" D
 .N RA3,RAPCOMM S RA3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 .S RAPCOMM=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"PCOMM"))
 .W:$P(RA3,U,32)'="" !?1,"Pregnancy Screen: ",$S($P(RA3,"^",32)="y":"Patient answered yes",$P(RA3,"^",32)="n":"Patient answered no",$P(RA3,"^",32)="u":"Patient is unable to answer or is unsure",1:"")
 .W:$P(RA3,U,32)'="n"&$L(RAPCOMM) !?1,"Pregnancy Screen Comment: ",RAPCOMM
 S Y(0)=RASUBY0
 W !,RAI
 ;end p99
 I $D(^RARPT(+RARPT,0)) S RA1=$P(^(0),"^",5) I "^V^EF^"[("^"_RA1_"^") W !?3,$C(7),"Report has already been ",$S(RA1="V":"verified",1:"electronically filed"),! D UNLOCK^RAUTL12(RAPNODE,RACNI) D INCRPT^RARTE4 G START
 ;Create new rpt, or skip to IN to edit existing report
 G IN^RARTE4:$D(^RARPT(+RARPT,0))
 G:'RAPRTSET NEW G:$P(^RA(72,+RAST,0),"^",3)>0 NEW
 ; case is part of a print set, AND is cancelled
 N RA2 S (RA1,RA2)=""
 F  S RA1=$O(RAMEMARR(RA1)) Q:RA1=""  S:$P(RAMEMARR(RA1),"^",3)]"" RA2=$P(RAMEMARR(RA1),"^",3)
 G:RA2="" NEW
 W !!,$C(7),"Other cases of this cancelled case ",RACN,"'s print set are entered in a report already",!!,"You may NOT create a new report for this cancelled case,",!,"but you may include this cancelled case in the existing report."
 W !!,"Do you want to include this cancelled case in the same report",!,"as the others in the print set ?"
 S %=2 D YN^DICN
 W:%>0 "...",$S(%=1:"Include",1:"Skip")," this case"
 I %=1 S $P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),"^",17)=RA2,RARPT=RA2,RARPTN=$P(^RARPT(RARPT,0),"^"),RA1=RACN D INSERT^RARTE2
 D UNLOCK^RAUTL12(RAPNODE,RACNI) D INCRPT^RARTE4 G START
NEW G:'RAPRTSET NEW1
 L +^RADPT(RADFN,"DT",RADTI):0 G:$T NEW1
 W !!?10,$C(7),"** This case belongs to a printset,",?68,"**",!?10,"** and someone else is currently doing REPORT ENTRY/EDIT",?68,"**"
 W !?10,"** on another case for this same printset,",?68,"**",!?10,"** so you may not enter a new report.",?68,"**"
 H 2 D UNLOCK^RAUTL12(RAPNODE,RACNI) D INCRPT^RARTE4 G START
NEW1 S RARPTN=$E(RADTE,4,7)_$E(RADTE,2,3)_"-"_RACN
 W !?3,"...report not entered for this exam...",!?10,"...will now initialize report entry..."
 S I=+$P(^RARPT(0),"^",3)
 G LOCK^RARTE4
 Q
 ;
CMEDIA(X) ;check if contrast media is associated with the report (exam)
 ;variables assumed to exist X: the string of contrast media used
 ;delimited by the comma.
 N Y W !," Contrast :"
 F Y=1:1 Q:$P(X,", ",Y)=""  W ?12,$P(X,", ",Y) W:$P(X,", ",Y+1)'="" !
 Q
