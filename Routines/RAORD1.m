RAORD1 ;HISC/CAH - AISC/RMO-Request An Exam ; 06/27/07 07:22am
 ;;5.0;Radiology/Nuclear Medicine;**10,45,41,75,86**;Mar 16, 1998;Build 7
 ;
 ;Supported IA #10035 reference to ^DPT(
 ;Supported IA #10040 reference to ^SC(
 ;Supported IA #10060 reference to ^VA(200
 ;Supported IA #2055 reference to $$EXTERNAL^DILFD
 ;Supported IA #2378 reference to ORCHK^GMRAOR
 ;Supported IA #10061 reference to ^VADPT
 ;Supported IA #10112 reference to ^VASITE
 ;Supported IA #10103 reference to ^XLFDT
 ;Supported IA #10141 reference to ^XPDUTL
 ;Supported IA #10009 reference to FILE^DICN
 ;Supported IA #10018 reference to ^DIE
 ;
 ;*Billing Awareness Project:
 ; RABWDX Array: ICD Diagnosis^SC^AO^IR^EC^MST^HNC
 ;  RABWDX is used in RABWORD* and RABWPCE*. 
 K RABWDX
 ;*
 S RAPKG="" N RAPTLKUP,RAGMTS,RACOPYOR
 G ADDORD:$D(RAVSTFLG)&($D(RALIFN))&($D(RAPIFN))
 ;
 I '$D(RAREGFLG),'$D(RAVSTFLG) N RAPTLOCK K RAWARD D  G:'RAPTLKUP Q
PAT .S DIC="^DPT(",DIC(0)="AEMQ" W ! D ^DIC K DIC
 .I Y<0 S RAPTLKUP=0 Q 
 .S RAPTLOCK=$$LK^RAUTL19(+Y_";DPT(") G:'RAPTLOCK PAT
 .S (DFN,RADFN)=+Y,(VA200,RAPTLKUP)=1
 .W ! D IN5^VADPT S:VAIP(1) RAWARD=$P(VAIP(5),"^",2)
 .D ELIG^RABWORD2
 .Q
 ;
PL ;Ask for the patient location (REQ. LOCATION file: 75.1, field: #22)
 N RACPRS27 S RACPRS27=$$PATCH^XPDUTL("OR*3.0*243")
 S DIC("A")="Patient Location: ",DIC("B")=$S($D(RAWARD)#2:RAWARD,1:"")
 S DIC="^SC(",DIC(0)="AEMQ"
 ;
 ;With the installation of RA*5.0*86 and after the implementation of
 ;CPRS v27 all active locations are eligible for selection regardless
 ;of patient type.
 ;
 ;If RAWARD is defined it is set to the name of the ward; pass either a 0
 ;or 1.
 ;Pass either a 0 or 1 as a value for RACPRS27. If 1 then CPRS GUI v27
 ;(OR*3.0*243) is installed at this facility.
 S DIC("S")="I $$SCREEN^RAORD1A("_($D(RAWARD)#2)_","_(RACPRS27)_")"
 ;
 D ^DIC K DIC K:'$D(RAREGFLG) RAWARD G Q:Y<0 S RALIFN=+Y
 S DIC("A")="Person Requesting Order: "
 ;*Billing Awareness Project:
 S DIC("S")="I $$PROV^RABWORD()"
 ;Display Service Connected prompts if user is a Provider.
 S DIC="^VA(200,",DIC(0)="AEMQ",Y=DUZ S:$$PROV^RABWORD DIC("B")=$P(^VA(200,DUZ,0),"^",1)
 D ^DIC K DIC G Q:Y<0 S RAPIFN=+Y K DD,DO,VA200,VAERR,VAIP G ADDORD:$D(RAVSTFLG)
 ;
ENADD ;OE/RR Entry Point for the ACTION Option
 K ORSTOP,ORTO,ORCOST,ORPURG
 I '$D(RAPKG) G Q:'$D(ORVP)!('$D(ORL))!('$D(ORNP)) S (DFN,RADFN)=+ORVP,RALIFN=+ORL,RAPIFN=$S(+ORNP:+ORNP,$D(RAPIFN):RAPIFN,1:+ORNP),RAFOERR=""
 ; RAFOERR is used as a flag to track when a user enters this option
 ; from OE/RR (frontdoor).  If this variable exists when a request is
 ; being printed, exam information is omitted from the request.
 S RANME=^DPT(RADFN,0),RASEX=$P(RANME,"^",2),RANME=$P(RANME,"^") D EXAM^RADEM1:'$D(RAREGFLG)&($D(RAPKG)) I '$D(RAREGFLG) S VA200=1 D IN5^VADPT S:VAIP(1) RAWARD=$P(VAIP(5),"^",2)
 D SAVE ; save off original value of RAMDV!
 S RAL0=$S($D(^SC(RALIFN,0)):^(0),1:0)
 S RADIV=+$$SITE^VASITE(DT,+$P(RAL0,"^",15)) S:RADIV<0 RADIV=0
 S RADIV=$S($D(^RA(79,RADIV,0)):RADIV,1:$O(^RA(79,0)))
 S RAMDV=$TR($G(^RA(79,+RADIV,.1)),"YyNn","1100")
 D:'$D(RACAT)#2  ;if not defined, define the variable RACAT
 .I $D(RAWARD)#2 S RACAT="INPATIENT" Q
 .N Y S Y=$G(^RADPT(RADFN,0)) I Y="" S RACAT="OUTPATIENT" Q
 .S RACAT=$$EXTERNAL^DILFD(70,.04,"",$P(Y,U,4))
 .S:RACAT="" RACAT="OUTPATIENT"
 .Q
 ; clear clin hist if:
 ;   rad backdoor, or
 ;   oe/rr's first order (quick or not)
 I $D(RAPKG) K ^TMP($J,"RAWP")
 I '$D(RAPKG),$G(XQORS)>1,$G(^TMP("XQORS",$J,XQORS-1,"ITM"))=1 K ^TMP($J,"RAWP")
 ;
ADDORD I $D(RADR1) D ALLERGY,CREATE1 G Q
 ; Set flag variable 'RASTOP' to track if procedure messages (if any)
 ; have been displayed.  Value altered in EN2+1^RAPRI & DISP+12^RAORDU1.
 D:'$D(VAEL) ELIG^VADPT
 I $D(^RAO(75.1,"B",RADFN)) D
 .I '$D(RAVSTFLG) D PREV^RABWORD2 Q
 .D ADDEXAM^RABWORD2
 D DISP^RAPRI G:RAIMGTYI'>0 Q
ADDORD1 W !,"Select Procedure",$S(RACNT:" (1-"_RACNT_") ",1:" "),"or enter '?' for help: "
 R RARX:DTIME
 S:'$T RARX="^" G Q:RARX=""!($E(RARX)="^")
 S:RARX=" " RARX=$S($D(RASX):RASX,1:RARX)
 I $E(RARX)="?"!(RARX=0)!(RARX=" ")!(RARX?.E1N1"-"1N.E)!(RARX?.E1".".E) D HELP^RAPRI G Q:Y'=1 D DISP1^RAPRI G ADDORD1
 S RAEXMUL=1 K RAHSMULT
 F RAJ=1:1 S X=$P(RARX,",",RAJ) Q:X=""  S RASTOP=0 W !!!,"Processing procedure: ",$S(+X&(+X'>RACNT):$P($G(RAPRC(X)),"^"),$E(X)'="`":X,1:"") D LOOKUP^RAPRI Q:$D(RAOUT)  S:RAPRI>0 RASX="`"_RAPRI D:RAPRI>0 ALLERGY,CREATE Q:$D(RAOUT)  K RAPRI
 I $D(RAREASK),'$D(RAOUT) K RAREASK D DISP1^RAPRI G ADDORD1
Q ; Kill, unlock if locked, and quit
 D KILL^RAORD
 D SAVE ; reset RAMDV to its original value!
 I $$ORVR^RAORDU()'<3,(+$G(RAPTLOCK)),(+$G(RADFN)) D
 . D ULK^RAUTL19(RADFN_";DPT(")
 K:'$D(RAREGFLG)&('$D(RAVSTFLG)) RACAT,RADFN,RANME,RAWARD
 I '$D(RAPKG) K RAMDIV,RAMDV,RAMLC
 I $D(RAPKG) K ORIFN,ORIT,ORL,ORNP,ORNS,ORPCL,ORPK,ORPV,ORPURG,ORSTS,ORTX,ORVP,RAPKG
 K RAHSMULT,RAPOP,RAIMAG,RAREAST,RAREQLOC
 K C,DI,DIG,DIH,DISYS,DIU,DIW,DIWF,DIWL,DIWR,DIWT,DN,I,ORCHART,POP,RAMDVZZ,RASCI,RASERIES
 Q
CREATE S RACT=0 D MODS Q:$D(RAOUT)
CREATE1 ;ask for the 'Date Desired' req'd P75
 S RAWHEN=$$DESDT^RAUTL12(RAPRI) S:RAWHEN=-1 RAOUT=1 Q:$D(RAOUT)#2
 S RAWHEN=$$FMTE^XLFDT(RAWHEN,1) ;convert to external format
 ; Ask pregnant if age is between 12 & 55.  Ask once for mult requests
 ; RASKPREG is the variable used to track if the pregnant prompt has
 ; been asked.  Ask only once for multiple requests.
 S:'$D(RASKPREG) RAPREG=$$PREG^RAORD1A(RADFN,$G(DT)),RASKPREG="" Q:$D(RAOUT)
 ;Reason for Study (req'd) & Clinical History (optional) asked in CH^RAUTL5 P75
 D CH^RAUTL5 Q:$D(RAOUT)  ;RAOUT: defined if Reason for Study is nonexistent
BAQUES ;*Billing Awareness Project
 ;   Ask Ordering ICD-9 Diagnosis and Related SC/EI/MST/HNC questions.
 N RADTM D NOW^%DTC S RADTM=%
 D ASK^RABWORD(RADFN,RADTM)
 I '$D(RADR1) D DISP^RAORDU1 Q:$D(RAOUT)  ; Display Order Responses.
 S X=RADFN,DIC="^RAO(75.1,",DIC(0)="L",DLAYGO=75.1
 D FILE^DICN K DIC Q:Y<0  S RAOIFN=+Y K DLAYGO
 I $D(RAREGFLG)!($D(RAVSTFLG)) S RANUM=$S('$D(RANUM):1,1:RANUM+1),RAORDS(RANUM)=RAOIFN
 I $D(^RA(79,+RADIV,.1)),$P(^(.1),"^",21)="y" S RALOCFLG=""
 W ! S DA=RAOIFN,DIE="^RAO(75.1,",DIE("NO^")="OUTOK"
 S DR=$S($D(RADR1):"[RA QUICK EXAM ORDER]",$D(RADR2):"[RA ORDER EXAM]",$D(RAEXMUL)&($D(RAFIN1)):"[RA QUICK EXAM ORDER]",1:"[RA ORDER EXAM]")
 ;*Billing Awareness Project
 ;   If Order questions are being Re-Asked then Re-Ask ICD-9 Dx questions
 I DR="[RA ORDER EXAM]" D ASK^RABWORD(RADFN,RADTM) W !!
 D ^DIE
 K DIE("NO^"),DE,DQ,DIE,DR,RADR1,RADR2
 I $D(RAFIN),$D(^RAO(75.1,RAOIFN,0)) S RAORD0=^(0) D FILEDX^RABWORD(RADFN,RAOIFN) Q:'$D(RAFIN)  D SETORD^RAORDU D OERR^RAORDU:'$D(RAPKG) D ^RAORDQ:$D(RAPKG) K RAORD0
 I '$D(RAFIN) W !?3,$C(7),"Request not complete. Must Delete..." S DA=RAOIFN,DIK="^RAO(75.1," D ^DIK W "...deletion complete!" I $D(RAREGFLG)!($D(RAVSTFLG)) K RAORDS(RANUM)
 I '$D(RAFIN),('$D(^RAO(75.1,RAOIFN,0))#2) Q  ; record deleted!
 K RAFIN
 ; check if the 'stat' or 'urgent' alert is to be sent.
 N RALOC,RAORD0
 S RAORD0=$G(^RAO(75.1,RAOIFN,0)),RALOC=+$P(RAORD0,"^",20)
 Q:'RALOC  ; if no 'SUBMIT TO' location, can't send stat/urgent alerts
 I $P(RAORD0,"^",6)=1!(($P(RAORD0,"^",6)=2)&($P(^RA(79.1,RALOC,0),"^",20)="Y")) D
 .; If 6th piece of RAORD0=1 *stat*, =2 *urgent*
 .Q:$$ORVR^RAORDU()<3
 .; needs OE/RR 3.0 or greater for stat/urgent alerts to fire
 .D OENO^RAUTL19(RAOIFN)
 .Q
 Q
 ;
MODS ;RAPRI= Procedure IEN, RAIMAG=Imaging Type for the procedure.
 ;Edited 4/19/94, Type of Imaging is now a multiple in file 71.2. CEW
 S RAIMAG=+$$ITYPE^RASITE(RAPRI),DIC(0)="AEQMZ",DIC="^RAMIS(71.2,",DIC("A")="Select "_$P($G(^DIC(71.2,0)),"^")_": "
 S DIC("S")="I +$D(^RAMIS(71.2,""AB"",RAIMAG,+Y)),$S('$G(RASERIES):1,$P(^RAMIS(71.2,+Y,0),U,2)="""":1,1:0),$$INIMOD^RAORD1A($P($G(^RAMIS(71.2,+Y,0)),""^""))"
 D ^DIC K DIC,RAIMAG S:$D(DTOUT)!($D(DUOUT)) RAOUT=1 Q:$D(RAOUT)!(X="^")!(X="")  I Y<1 W $C(7),"  ??" G MODS
 S RACT=RACT+1,RAMOD(RACT)=$P(Y,"^",2) G MODS
 Q
 ;
ALLERGY ; If patient has had a previous contrast media allergic reaction
 ; check procedure RAPRI for specific contrast media associations
 ; (new with RA*5*45)
 Q:'$$ORCHK^GMRAOR(RADFN,"CM")
 S RAPRI(0)=$G(^RAMIS(71,RAPRI,0))
 I $P(RAPRI(0),U,6)'="P" D  ;not a parent check lone procedure
 .D CONTRAST^RAUTL2(RAPRI)
 .Q
 E  S I=0 D  ;check descendent procedures for CM
 .F  S I=$O(^RAMIS(71,RAPRI,4,I)) Q:'I  D CONTRAST^RAUTL2(+$G(^(I,0)))
 .K I
 .Q
 K RAPRI(0)
 Q
SAVE ; Save original value of RAMDV before it is altered in the ENADD sub-
 ; routine.  This code will also reset RAMDV to the sign-on value.
 Q:'$D(RAPKG)  ; entered through OE/RR (RAMDV will not be set)
 Q:'$D(RAMDV)&('$D(RAMDVZZ))  ;entered through 'Request an Exam' option used stand-alone outside of Rad/NM pkg
 I '$D(RAMDVZZ) S RAMDVZZ=RAMDV
 E  S RAMDV=RAMDVZZ
 Q
