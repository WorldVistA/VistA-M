RARTUVR1 ;HISC/FPT,SWM AISC/RMO-Unverified Reports ;8/19/97  11:16
 ;;5.0;Radiology/Nuclear Medicine;**29,56**;Mar 16, 1998;Build 3
 ;
 ;Supported IA #2056 GET1^DIQ
 ; RAHOURS=hours diffce btw DT and RARPTENT, also used in RACUT(rahours)
BTG ; build tmp global
 N RAQT
 S RARE(0)=$G(^RADPT(RADFN,"DT",RADTI,0))
 S RADIVNUM=+$P(RARE(0),U,3),RADIVNME=$P($G(^DIC(4,RADIVNUM,0)),U)
 I RADIVNME]"",('$D(^TMP($J,"RA D-TYPE",RADIVNME))) Q
 S RADIVNME=$S(RADIVNME]"":RADIVNME,1:"Unknown")
 S RAITNUM=+$P(RARE(0),U,2),RAITNAME=$P($G(^RA(79.2,RAITNUM,0)),U)
 I RAITNAME]"",('$D(^TMP($J,"RA I-TYPE",RAITNAME))) Q
 S RAITNAME=$S(RAITNAME]"":RAITNAME,1:"Unknown")
 K RARE(0)
 Q:'$D(^TMP($J,"RAUVR",RADIVNME,RAITNAME))
 S RAQT=0 ; RAQT set to 1 if this report has already been counted
 I RAIP["R" D INC("R") Q:RAQT
 I RAIP["S" D INC("S") Q:RAQT
 I RAIP="U" D INC("U") Q:RAQT
 S ^TMP($J,"RAUVR",RADIVNME,RAITNAME)=$G(^TMP($J,"RAUVR",RADIVNME,RAITNAME))+1
 Q
INC(RATYP) ; Increment count for Resident, Staff or Unknown
 ;
 N RA1
 S RATYP=$E($G(RATYP))
 S RAIPNAME=$S(RATYP="R":RAPRES,RATYP="S":RAPSTF,1:"")
 S:RAIPNAME'="" RAIPNAME=$$GET1^DIQ(200,RAIPNAME_",",.01)
 S:RAIPNAME="" RAIPNAME="UNKNOWN"
 ; If report on ASTAT x-ref for 2 report statuses, then it will be
 ; counted twice. Check if dealt with already. If so, QUIT
 I $D(^TMP($J,RADIVNME,RAITNAME,RATYP,RAIPNAME,RARPT)) S RAQT=1 Q
 S ^TMP($J,RADIVNME,RAITNAME,RATYP,RAIPNAME,RARPT)=$G(RADFN)_U_$G(RADTI)_U_$G(RACNI)
 S ^TMP($J,RADIVNME,RAITNAME,RATYP,RAIPNAME)=$G(^TMP($J,RADIVNME,RAITNAME,RATYP,RAIPNAME))+1
 S RA1=$S(RATYP="R":"RESCNT",RATYP="S":"STFCNT",1:"UNKCNT")
 S ^TMP($J,RADIVNME,RAITNAME,RA1)=$G(^TMP($J,RADIVNME,RAITNAME,RA1))+1
 Q:'$D(RARPTENT)
 S RAHOURS=$$FMDIFF^XLFDT(DT,RARPTENT,2)/3600
 S RAHOURS=$S(RAHOURS<RACUT(1):1,RAHOURS<RACUT(2):2,RAHOURS<RACUT(3):3,1:4)
 S ^TMP($J,RADIVNME,RAITNAME,RATYP,RAIPNAME,"H",RAHOURS)=$G(^TMP($J,RADIVNME,RAITNAME,RATYP,RAIPNAME,"H",RAHOURS))+1
 S ^TMP($J,RADIVNME,RAITNAME,"H",RAHOURS,RARPT)=$G(^TMP($J,RADIVNME,RAITNAME,"H",RAHOURS,RARPT))+1
 Q
 ;
PHYS ;print other staff and residents
 N RA2ND,R1,R2,RASTR
 S (R1,R2)=0 F  S R2=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SRR",R2)) Q:'R2  S:+$G(^(R2,0)) R1=R1+1,RA2ND("SRR",R1)=+^(0),RA2ND("SRR",R1)=$E($$GET1^DIQ(200,RA2ND("SRR",R1)_",",.01),1,20)
 S (R1,R2)=0 F  S R2=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SSR",R2)) Q:'R2  S:+$G(^(R2,0)) R1=R1+1,RA2ND("SSR",R1)=+^(0),RA2ND("SSR",R1)=$E($$GET1^DIQ(200,RA2ND("SSR",R1)_",",.01),1,20)
 S R1=$E($$GET1^DIQ(200,+$P(Y(0),"^",15)_",",.01),1,15) ; prim staff
 S RASTR="Other Att/Res: "
 S:RAIPNAME'[R1 RASTR=RASTR_R1
PHYS1 I '$O(RA2ND("SSR",0)) G PHYS2
 S R1=0
PHYS11 S R1=$O(RA2ND("SSR",R1)) G:R1="" PHYS2
 G:RAIPNAME[RA2ND("SSR",R1) PHYS11 ;omit if name matches current staff/resid/unkn
 I $L(RASTR)+$L(RA2ND("SSR",R1))>IOM W !,RASTR,"; " S RASTR="   "
 S:RASTR]"   " RASTR=RASTR_"; " S RASTR=RASTR_RA2ND("SSR",R1) G PHYS11
PHYS2 S R1=$E($$GET1^DIQ(200,+$P(Y(0),"^",12)_",",.01),1,15) ;prim resid
 I RAIPNAME[R1 G PHYS20 ;omit if name matches current staff/resid/unk
 I $L(RASTR)+$L(R1)>IOM W !,RASTR,"; " S RASTR="   "
 S:RASTR]"   " RASTR=RASTR_"; " S RASTR=RASTR_R1
PHYS20 I '$O(RA2ND("SRR",0)) W !,RASTR Q
 S R1=0
PHYS21 S R1=$O(RA2ND("SRR",R1)) G:R1="" PHYS29
 G:RAIPNAME[RA2ND("SRR",R1) PHYS21 ;omit if name matches current staff/resident/unkn
 I $L(RASTR)+$L(RA2ND("SRR",R1))>IOM W !,RASTR,"; " S RASTR="   "
 S:RASTR]"   " RASTR=RASTR_"; " S RASTR=RASTR_RA2ND("SRR",R1) G PHYS21
PHYS29 W:RASTR]"   " !,RASTR
 Q
DIVSUM ;division summary -- skip if only one imaging type chosen for this div
 Q:$O(^TMP($J,"RAUVR",RADIVNME,0))=$O(^TMP($J,"RAUVR",RADIVNME,""),-1)
 N RA2ND  ;reuse this local array
 I RACNT(0)'<RACNT S RAOUT=$$EOS^RAUTL5() Q:RAOUT  ;before last screen
 W:$Y>0 @IOF W !?$S(IOM<81:20,1:IOM-90),">>>>> Unverified Reports (",$S(RABD="B":"brief",1:"detailed"),") <<<<<" S RAPAGE=RAPAGE+1 W ?$S(IOM<81:70,1:IOM-10),"Page: ",RAPAGE
 W !,"Division: ",?10,RADIVNME,?$S(IOM<81:43,1:IOM-37),"Report Date Range:",?$S(IOM<81:62,1:IOM-18),$$FMTE^XLFDT(BEGDATE),!?$S(IOM<81:62,1:IOM-18),$$FMTE^XLFDT(ENDDATE)
 W !,"Imaging Type(s): "
 S RA1="" F  S RA1=$O(^TMP($J,"RAUVR",RADIVNME,RA1)) Q:RA1=""  W:($L(RA1)+3+$X)>IOM !?17 W RA1,"   "
 W !!,"Run Date: ",RARUNDAT
 W !!!?26,"Division Summary",!?26,$E(RADASH,1,16)
 D HOURAGE^RARTUVR2
 S RA1=0 F  S RA1=$O(^TMP($J,RADIVNME,RA1)) Q:RA1=""  D
 .S RA2="" F  S RA2=$O(^TMP($J,RADIVNME,RA1,"H",RA2)) Q:RA2=""  D
 ..S RA3="" F  S RA3=$O(^TMP($J,RADIVNME,RA1,"H",RA2,RA3)) Q:RA3=""  D
 ...S RA2ND(RA2)=$G(RA2ND(RA2))+1
 W !!,"Total Unverified Reports: "
 W ?29,$S($G(RA2ND(1)):$J(RA2ND(1),$L(RACUT(3))),1:$J(0,$L(RACUT(3)))),?39,$S($G(RA2ND(2)):$J(RA2ND(2),$L(RACUT(3))),1:$J(0,$L(RACUT(3))))
 W ?49,$S($G(RA2ND(3)):$J(RA2ND(3),$L(RACUT(3))),1:$J(0,$L(RACUT(3)))),?59,$S($G(RA2ND(4)):$J(RA2ND(4),$L(RACUT(3))+2),1:$J(0,$L(RACUT(3))+2))
 S RA1=0 F RA4=1:1:4 S RA1=RA1+$G(RA2ND(RA4))
 W !!,"Division Total: ",RA1,!!
 S RAOUT=$$EOS^RAUTL5()
