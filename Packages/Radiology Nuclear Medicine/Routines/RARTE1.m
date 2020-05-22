RARTE1 ;HISC/CAH,FPT,GJC AISC/MJK,RMO-Edit/Delete a Report ; Dec 17, 2019@10:05:19
 ;;5.0;Radiology/Nuclear Medicine;**2,15,17,23,31,68,56,47,124,163,162**;Mar 16, 1998;Build 2
 ;Private IA #4793 DELETE^WVRALINK, CREATE^WVRALINK 
 ;Supported IA #10035
 ;Supported IA #10007
 ;11/07/2005 KAM/BAY 110020 - Correct DUZ ID from Talk Technology
 ;                            During the Unverify process
DEL D SET^RAPSET1 I $D(XQUIT) K XQUIT Q
 S (RAPRG74,RAXIT)=0
 S DIC("A")="Select Report Day-Case#: "
 S DIC("W")="S RA0=^(0) W ""   "",$S($D(^DPT(+$P(RA0,""^"",2),0)):$P(^(0),""^""),1:""Unknown"") K RA0 W ""   "",$$FLD^RARTFLDS(+Y,""PROC"")"
 S DIC("S")="I $P(^(0),U,5)'=""X""" ;select only non-deleted reports
 S DIC="^RARPT(",DIC(0)="AEMQZ" D ^DIC K DIC G END:Y<0
 S RA0=Y(0),(DA,RAIEN)=+Y
 I $O(^RARPT(RAIEN,2005,0)) D  D END Q
 . W !!?5,"Cannot delete a report that is associated with an image."
 . W !?5,"Contact your Imaging Coordinator for further assistance.",!
 . S DIR(0)="E",DIR("A")="Press RETURN to continue"
 . D ^DIR K DIR,DIRUT,DUOUT
 . Q  ;08/23/00
 D CHK17^RARTE3 ;see this subroutine for values of RAOK
 G:RAOK=1 END ;can't del rpt w/o RACN or RACNI so avoid err at UP1^RAUTL1
 S RAXIT=$$LOCK^RAUTL12("^RARPT(",RAIEN)
 I RAXIT K RAXIT D END Q  ; record locked by another
ASKDEL ; ask if deletion is appropriate
 R !!,"Do you wish to delete this report? NO// ",X:DTIME
 S:'$T!(X="")!(X["^") X="N"
 I "Nn"[$E(X) D UNLOCK^RAUTL12("^RARPT(",RAIEN) G DEL
 I "Yy"'[$E(X) D  G ASKDEL
 . W:X'["?" $C(7)
 . W !!?3,"Enter 'YES' to delete this report, or 'NO' not to."
 . Q
 ; comment out next line, these 3 vars are already set by CHK17^RARTE3
 ;S RADFN=+$P(RA0,"^",2),RADTI=9999999.9999-$P(RA0,"^",3),RACN=$P(RA0,"^",4)
 G:RAOK=2 AD2 ;don't remove piece 17 if rpt doesn't match exm's rpt ptr
 ; del other member's REPORT TEXT xrefs, and set pointer to #74 as null
 D DEL17^RARTE2(RAIEN) ;del ptrs to file 74 excluding lead case of prtset
 S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P","B",RACN,0))
 G:'$D(^RADPT(RADFN,"DT",RADTI,"P",+RACNI,0))#2 AD2
 ; kill any xrefs for file #70's REPORT TEXT
 S DA(2)=RADFN,DA(1)=RADTI,DA=RACNI D ENKILL^RAXREF(70.03,17,RAIEN,.DA)
 ; set REPORT TEXT to null
 S $P(^RADPT(RADFN,"DT",RADTI,"P",+RACNI,0),"^",17)=""
AD2 K RAXIT S RAPRG74=1 ;RAPRG74 used in kill logic file 74 fld .01
 D MARKDEL^RARTE7 ; mark report deleted, save DXs, remov DXs fm case(s)
 W !?10,"...report deletion complete."
 D:RAOK'=2 UP1^RAUTL1 ;skip update status if report doesn't belong to exm
 D UPDTPNT^RAUTL9(RAIEN) ; Update pointers in 74.2, and 74.4!
 D UNLOCK^RAUTL12("^RARPT(",RAIEN) ; unlock report
 I RAOK'=2,$T(DELETE^WVRALINK)]"" D DELETE^WVRALINK(RADFN,RADTI,RACNI) ; women's health, skip if report doesn't belong to exm
END K %,%Y,D0,DA,DIC,DIE,RAJ1,DIK,RADFN,RADTI,RACN,RACNI,RA0,RAIEN,RAOR
 K RAORDIFN,RAPRG74,RASN,RASTI,Y ;KLM/163 - removed RADUZ from kill
 K RADATE,RADTE,X
 K RA791,RACANC,RACN0,RACPT,RACPTNDE,RAI,RAN,RAOBR4,RAPKG,RAPRCNDE,RAPROC,RAPROCIT,RAPRV,RASULT,RAXIT
 K C,D,D1,DDER,DDH,DFN,DI,DISYS,DIWF,DIWL,DIWR,DQ,DR,GMRAL,HLN,HLRESLT,HLSAN,I,VA,VADM,VAERR,X0
 Q
 ;
UNVER(RAXRPT) ; unverify a report
 ; Input: if RAXRPT>0 then we know the report we wish to delete
 ;                    this requires no user interaction.
 ;           RAXRPT=0 user is prompted for the report they wish to
 ;                    delete (interactive)
 ;
 I 'RAXRPT D SET^RAPSET1 G Q:$D(XQUIT)
 I RAXRPT N X S X=RAXRPT
 S RAXIT=0,DIC="^RARPT(",DIC("S")="I $P(^(0),U,5)=""V"""
 S DIC(0)=$S('RAXRPT:"AEMQZ",1:"NZ")
 D DICW,^DIC K DIC I Y<0 D Q Q
 S RA74B4=$G(Y(0))
 S (RARPT,DA)=+Y,RADFN=$P(Y(0),U,2)
 S RADTI=9999999.9999-$P(Y(0),"^",3),RACN=$P(Y(0),"^",4)
 I 'RAXRPT S DR="D EN1^RAUTL9 I $D(DIRUT) S Y=""@99"";S:RASTATX'=""PD"" Y=""@10"";25;@10;5////^S X=RASTATX;S:X=""V"" Y=""@99"";9///@;17///@;100///NOW;@99"
 S:RAXRPT DR="5////^S X=""D"";9///@;17///@;100///NOW"
 ;11/07/2005 KAM/BAY 110020 Modified next line to look for voice recognition
 S DIE="^RARPT(",DR(2,74.01)="2////U;3////"_$S(($D(RAQUIET)#2)&($D(RASUB)#2):$G(^TMP("RARPT-REC",$J,RASUB,"RAVERF")),1:DUZ)
 S RAXIT=$$LOCK^RAUTL12("^RARPT(",RARPT)
 ;
 ;this check is to see if a report from the outside is to be amended $G(RAXRPT)>0
 I RAXIT S:$G(RAXRPT)>0 RAERR="^RARPT("_RARPT_", could not be locked for addendum." D Q QUIT
 ;if called from RAHLO1 and the lock fails we need to set RAERR
 ;RAERR is needed back in RAHLO1 p162
 ;
 D ^DIE K DE,DQ,DIE,DR D UNLOCK^RAUTL12("^RARPT(",RARPT)
 N RA1,RA2,RA3,RA4 S RA1=RADFN,RA2=RADTI,RA3=RACN,RA4=RARPT
 S RA(0)=$G(^RARPT(RARPT,0)),RA(5)=$P(^RARPT(RARPT,0),"^",5)
 S RA(7)=$P(^RARPT(RARPT,0),"^",7),RA(10)=$P(^RARPT(RARPT,0),"^",10)
 I RA(5)'="V" D
 . I RA(7)]"" D ENKILL^RAXREF(74,7,RA(7),RARPT) S $P(^RARPT(RARPT,0),"^",7)=""
 . I RA(10)]"" D ENKILL^RAXREF(74,10,RA(10),RARPT) S $P(^RARPT(RARPT,0),"^",10)=""
 . N RADDEN,RAUTOE S (RADDEN,RAUTOE)="" D ^RARTR,EN1^RARTE3(RA4)
 . Q
 S RADFN=RA1,RADTI=RA2,RACN=RA3,RARPT=RA4
 S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P","B",RACN,0)) I $D(^RADPT(RADFN,"DT",RADTI,"P",+RACNI,0)) D UP1^RAUTL1 I $D(^RABTCH(74.4,"B",RARPT)) D
 .S DA=0 F  S DA=$O(^RABTCH(74.4,"B",RARPT,DA)) Q:'DA  D
 ..S DIK="^RABTCH(74.4," D ^DIK
 ..Q
 .Q
 I "^V^EF^"'[("^"_$P($G(^RARPT(RARPT,0)),"^",5)_"^"),$T(DELETE^WVRALINK)]"" D DELETE^WVRALINK(RADFN,RADTI,RACNI) ; women's health
 ;
Q ; Kill and quit
 K DFN,DI,DIW,DIWF,DIWI,DIWL,DIWT,DIWTC,DIWX,RAACNT,RANUM,RAST,RAWHOVER
 K %,%DT,%W,%Y,%Y1,C,D,D0,D1,DA,DIC,DIE,DIK,DR,RA,RACN,RACNI,RADATE
 K RADFN,RADIV,RADTE,RADTI,RAJ,RAOR,RAORDIFN,RARPT,RASET,RASN,RASTATX
 K RASTI,RAXIT,X,XQUIT,Y,RA74B4,DDH,DIPGM,DISYS,I ;KLM/163 - removed RADUZ from kill
 Q
 ;
STD S (RALR,RALI)=1
STD1 S DIC="^RA(74.1,",DIC("A")="Select 'Standard' Report to Copy: ",DIC(0)="AEMQ" D ^DIC K DIC("A") Q:Y<0
ASKSEL W:$$IMPRPT(RARPT) !!,"Report already exists.  This will over-write it."
 W !,"Are you sure you want the '",$P(Y,"^",2),"' standard report? No// " R X:DTIME G STD1:'$T!(X="")!(X["^")!("Nn"[$E(X))
 I "Yy"'[$E(X) W:X'["?" $C(7) W !!?3,"Enter 'YES' to select the '",$P(Y,"^",2),"' standard report, or 'NO' not to." G ASKSEL
 I RALR=1,RALI=1 K ^RARPT(RARPT,"R"),^("I")
 F I=1:1 Q:'$D(^RA(74.1,+Y,"R",I,0))  S ^RARPT(RARPT,"R",RALR,0)=^(0),RALR=RALR+1
 F I=1:1 Q:'$D(^RA(74.1,+Y,"I",I,0))  S ^RARPT(RARPT,"I",RALI,0)=^(0),RALI=RALI+1
ASKADD R !!,"Do you want to add another standard to this report? No// ",X:DTIME Q:'$T!(X="")!(X["^")!("Nn"[$E(X))  I "Yy"'[$E(X) W:X'["?" $C(7) W !!?3,"Enter 'YES' to add another standard to this report, or 'NO' not to." G ASKADD
 S (^RARPT(RARPT,"R",RALR,0),^RARPT(RARPT,"I",RALI,0))="",RALR=RALR+1,RALI=RALI+1 W ! G STD1
 ;
EDTRPT ; Called from 'RARTE4' and 'RARTVER'.
 N RAXIT S RACT=$S('+$G(^RARPT(RARPT,"T")):"I",1:"E")
 S:'$D(^RARPT(RARPT,"T")) ^("T")=""
 S DA=RARPT,DR="[RA REPORT EDIT]",DIE="^RARPT(" D ^DIE K DE,DQ ;,RAFLAGK
 I $D(Y),RACT="V",'$P(^RARPT(RARPT,0),"^",9) W !,$C(7),"You must enter a verifying Interpreting Physician to 'VERIFY' a report.",!?3,"...report status will now be changed to 'DRAFT'." S DA=RARPT,DR="5///D" D ^DIE K DE,DQ ;Q
 Q:$D(RAONLINE)&($G(RARDX)="E")
 ; move PACS line to its own subroutine
 ;I $D(RAFLAGK) K RAFLAGK Q
 G:$D(Y) PACS
 ;Since report editing is not necessarily screened by sign-on imaging
 ;type, use the imaging type on the exam record   ;ch
 S RAIMGTYI=$P($G(^RADPT(RADFN,"DT",RADTI,0)),U,2),RAIMGTYJ=$P($G(^RA(79.2,+RAIMGTYI,0)),U)
 S X=+$O(^RA(72,"AA",RAIMGTYJ,9,0)),DA(2)=RADFN,DA(1)=RADTI,DA=RACNI,DIE="^RADPT("_DA(2)_",""DT"","_DA(1)_",""P""," K RAIMGTYI,RAIMGTYJ
 S DR=13_$S(RACT'="V":"",'$D(^RA(72,X,.1)):"",$P(^(.1),"^",5)'="Y":"",1:"R")_";I $D(^RA(78.3,+X,0)),$P(^(0),""^"",4)=""y"" S RAAB=1"
 ;
 ;lock the correct sub-file (pset?)
 D DXLOC
 ;
 I RACT="V",$P($G(^RA(72,X,.1)),"^",5)="Y" S DIE("NO^")="BACK"
 I 'RAXIT D ^DIE K DA,DE,DQ,DIE,DR
 I RAXIT!($P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),U,13)="")!($D(Y)) D DXULOC G PACS
 S DR="50///"_RACN
 S DR(2,70.03)=13.1
 S DR(3,70.14)=.01_";I $D(^RA(78.3,+X,0)),$P(^(0),""^"",4)=""y"" S RAAB=1"
 S DA(1)=RADFN,DA=RADTI,DIE="^RADPT("_DA(1)_",""DT"","
 ;
 I 'RAXIT D ^DIE K DA,DE,DQ,DIE,DR
 ;
COPYDX ;if we have a printset copy over the Dx code data (both primary & secondary)
 ;to all our descendents before building our HL7 ORU messsages.
 I RAPRTSET S RADRS=1,RAXIT=0 D COPY^RARTE2 ;P47
 ;unlock the correct sub-file (pset?)
 D DXULOC
 ;
PACS I ($P(^RARPT(RARPT,0),U,5)="V")!($P(^(0),U,5)="R") D RPT^RAHLRPC
 ;pre p124: "^V^EF" post p124 "^V^EF^"
 I "^V^EF^"[("^"_$P(^RARPT(RARPT,0),U,5)_"^"),$T(CREATE^WVRALINK)]"" D CREATE^WVRALINK(RADFN,RADTI,RACNI) ; women's health
 Q
 ;
ASKBTCH R !!,"Do you want to batch print reports? Yes// ",X:DTIME S:'$T X="^" S:X="" X="Y" Q:X["^"  I "Nn"'[$E(X),"Yy"'[$E(X) W:X'["?" $C(7) W !!?3,"Enter 'YES' to batch print reports, or 'NO' not to." G ASKBTCH
 Q
 ;
ASKPRT R !!,"Do you want to print batch now? No// ",X:DTIME S:'$T!(X="")!(X["^") X="N" I "Nn"'[$E(X),"Yy"'[$E(X) W:X'["?" $C(7) W !!?3,"Enter 'YES' to print this batch, or 'NO' not to." G ASKPRT
 Q
DICW ; Build DIC("W") string
 N DO D DO^DIC1
 S DIC("W")=$S($G(DIC("W"))]"":DIC("W")_" ",1:"")_"W ""   "",$$FLD^RARTFLDS(+Y,""PROC"")"
 Q
IMPRPT(Y) ; Does the report we are currently editing have either Report
 ; or Impression Text?
 ; Input : 'Y' - the ien of the report being edited
 ; Output: '1' - either impression or report text exists, '0' - neither
 ;               report or impression text exists.
 Q $S(+$O(^RARPT(Y,"I",0)):1,+$O(^RARPT(Y,"R",0)):1,1:0)
 ;
DXLOC ;lock the correct RAD/NUC MED PATIENT sub-file
 S:'RAPRTSET RAXIT=$$LOCK^RAUTL12("^RADPT("_RADFN_",""DT"","_RADTI_",""P"",",RACNI)
 S:RAPRTSET RAXIT=$$LOCK^RAUTL12("^RADPT("_RADFN_",""DT"",",RADTI)
 Q
 ;
DXULOC ;unlock the correct RAD/NUC MED PATIENT sub-file
 D:'RAPRTSET UNLOCK^RAUTL12("^RADPT("_RADFN_",""DT"","_RADTI_",""P"",",RACNI)
 D:RAPRTSET UNLOCK^RAUTL12("^RADPT("_RADFN_",""DT"",",RADTI)
 Q
 ;
