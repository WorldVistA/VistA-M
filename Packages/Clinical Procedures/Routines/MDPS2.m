MDPS2 ; HOIFO/NCA - CP/Medicine Report Generator (Cont.) ;5/18/04  09:41
 ;;1.0;CLINICAL PROCEDURES;**2**;Apr 01, 2004
 ; Integration Agreements:
 ; Reference IA #2432 for Hospital Location File #44 FM Lookup
 ;              #1576 for DIVISION file 40.8 lookup
 ;              #2263 for XPAR Utilities
 ;              #4231 for Document CKP^GMTSUP usage.
 ;              #4428 for ORWRP TIME/OCC LIMITS ALL Parameter.
 ;              #10035 for Patient File (#2) Direct Global Reads
 ;              #10060 for New Person file (#200) Read w/FM
 ;              #10061 for ^VADPT call.
 ;              #10103 for XLFDT calls.
 ;
GETDATA(MDGRS,MDDFN,MDPR,MDF,MDR,MDT,MDH) ; Return the text of the Medicine Report
 ; Input: MDGRS - Return Global Array (Required)
 ;        MDDFN - Patient DFN         (Required)
 ;        MDPR - Procedure name in file #697.2 (Required)
 ;        MDF - File number (Required)
 ;        MDR - Record number (Required)
 ;        MDT - The type of report (Full or Caption)   (Required)
 ;        MDH - Header is needed or not (Required)
 ;
 I '$G(MDDFN)!('$D(MDGRS)) Q
 N MDCT,MDDAT,MDERR,MDDRDR,MDFLD,MDFLD1,MDFTYP,MDDS0,MDDS1,MDGPRO,MDL1,MDLAB,MDLNE,MDLP,MDMCT,MDMFLD,MDN,MDNOD,MDNXT,MDPNAM,MDSUBF,MDTX,MDTXT,MDVAL,Y
 S MDN=MDT
 S MDERR=$$GETDATA^MCORMN1(MDPR,MDR,"^TMP(""MCORMN"",$J)",MDF,$S(MDT'="RD":"RD",1:MDT))
 I +MDERR=0 S @MDGRS@(1,0)="No Report Text" Q
 S MDGPRO=$O(^MCAR(697.2,"B",MDPR,0)),(MDDS0,MDDS1)=0,MDPNAM=$P($G(^MCAR(697.2,+MDGPRO,0)),U,8) S:MDPNAM="" MDPNAM=MDPR
 I MDPR["PFT" S MDLNE=0 D GET^MDPFTP1(.MDGRS,MDF,MDR,MDPNAM,MDLNE,MDH) Q
 F  S MDDS1=+$O(^MCAR(690.2,"D",MDGPRO,MDDS1)) Q:'MDDS1!(MDDS0)  D
 .Q:'$D(^MCAR(690.2,MDDS1,0))
 .S:$P(^MCAR(690.2,MDDS1,0),U,3)="F" MDDS0=MDDS1
 I 'MDDS0 S @MDGRS@(1,0)="No Report Text" Q
 S MDFLD="",(MDDRDR,MDLNE)=0,MDNOD=$NA(^TMP("MCORMN",$J)) D HEAD
 ; Get the Single in the Medicine View File (#690.2)
 F  S MDFLD=$O(^MCAR(690.2,MDDS0,1,MDFLD)) Q:MDFLD=""  S MDDRDR=+$G(^(MDFLD,0)) D
 .Q:'MDDRDR
 .S MDDAT=$G(@MDNOD@("F",MDF,MDDRDR,0)),MDLAB=$P(MDDAT,U),MDFTYP=$P(MDDAT,U,2)
 .S:MDLAB'="" MDLAB=MDLAB_": "
 .I +MDFTYP I $E($P(MDFTYP,+MDFTYP,2),1)?1U D SUBF Q
 .I +MDFTYP&($P($G(@MDNOD@("F",+MDFTYP,.01,0)),U,2)["W") D  Q
 ..I MDT="CD" S MDNXT=$O(@MDNOD@("E",MDF,MDR,MDDRDR,0)) Q:'+MDNXT  Q:$G(@MDNOD@("E",MDF,MDR,MDDRDR,+MDNXT))=""
 ..D SETNODE(MDGRS," "),SETNODE(MDGRS,MDLAB)
 ..S MDLP=0 F  S MDLP=$O(@MDNOD@("E",MDF,MDR,MDDRDR,MDLP)) Q:MDLP<1  S MDVAL="  "_$G(^(MDLP)) D SETNODE(MDGRS,MDVAL)
 ..D SETNODE(MDGRS," ")
 ..Q
 .I MDFTYP'["W"&(MDFTYP'["M") D  Q
 ..S MDTXT=$G(@MDNOD@("E",MDF,MDR,MDDRDR,1))
 ..Q:MDT="CD"&(MDTXT="")
 ..I MDFTYP["D" S MDTX=$$FMTE^XLFDT(MDTXT,2),MDTXT=MDTX
 ..S MDVAL=MDLAB_$S(MDLAB'="":"  "_MDTXT,1:"") D SETNODE(MDGRS,MDVAL)
 ..Q
 .Q
 I +$P($G(^MCAR(MDF,MDR,2005,0)),U,4)>0 D
 .D SETNODE(MDGRS," ")
 .D SETNODE(MDGRS,"NOTE: Images are associated with this procedure.")
 .D SETNODE(MDGRS,"      Please use Imaging Display to view the images.")
 .Q
 K ^TMP("MCORMN",$J)
 D FOOTER
 Q
SETNODE(NODE,VALUE) ;Set the node with the string
 S MDLNE=MDLNE+1,@NODE@(MDLNE,0)=VALUE
 Q
SUBF ; Get the Sub-file fields in the Medicine View File (#690.2)
 S MDMFLD=$O(^MCAR(690.2,MDDS0,2,"B",+MDFTYP,0)) Q:'MDMFLD
 S MDCT=0,MDMCT=0 F  S MDCT=$O(@MDNOD@("E",+MDFTYP,MDCT)) Q:MDCT<1  S MDFLD1=0 F  S MDFLD1=$O(@MDNOD@("E",+MDFTYP,MDCT,MDFLD1)) Q:MDFLD1=""  D
 .S:MDFLD1=".01" MDMCT=MDMCT+1
 .Q:'+$O(^MCAR(690.2,MDDS0,2,MDMFLD,1,"B",MDFLD1,0))
 .S MDDAT=$G(@MDNOD@("F",+MDFTYP,MDFLD1,0)),MDLAB=$P(MDDAT,U)
 .S:MDLAB'="" MDLAB=MDLAB_": "
 .I MDT="CD" Q:$G(@MDNOD@("E",+MDFTYP,MDCT,MDFLD1,1))=""
 .I $P(MDDAT,U,2)["M" D  Q
 ..I MDMCT<2 D SETNODE(MDGRS," "),SETNODE(MDGRS,MDLAB)
 ..S MDVAL="  "_$G(@MDNOD@("E",+MDFTYP,MDCT,MDFLD1,1)) D SETNODE(MDGRS,MDVAL) Q
 .I $P(MDDAT,U,2)["D" S MDVAL=$G(@MDNOD@("E",+MDFTYP,MDCT,MDFLD1,1)),MDTX=$$FMTE^XLFDT(MDVAL,2),MDVAL=MDTX D SETNODE(MDGRS,MDLAB_MDVAL) Q
 .S MDVAL="     "_MDLAB_$G(@MDNOD@("E",+MDFTYP,MDCT,MDFLD1,1)) D SETNODE(MDGRS,MDVAL) Q
 .Q
 Q
FOOTER ; Display Medicine Footer
 Q:+$G(MDH)
 N CODE,ERROR,PART,PDUZ,RDATE,SCD,SCRAMBLE,SDUZ,TDATE,TEMP,TRUE,TP,DIC,DR,DA,DIQ
 N ENAME,EES,EDATE,NAME,NUM,VNAME,VES,VDATE,CODE,RELDATE,VERDATE,NA,MFD,MFDNAME,SUPD,CREATION,SUPNUM,SUPNUM,SUP1,SUP2,ROV,VERSION
 N FT,FTYPE,FNAME,PERSON,DTEMP,TT,X,X1,X2
 I '$D(^MCAR(MDF,+MDR,"ES")) Q
 S TEMP=$G(^MCAR(MDF,MDR,"ES"))
 ; Retrieve RC/ES Field (NA = Dont need)
 S NAME="ENAME^NA^EDATE^VNAME^VES^VDATE^CODE^RDATE^VDATE^SUP1^SUP2^MFD^MFDNAME^SUPD^CREATION^SUPNUM",FTYPE="P^X^D^P^F^D^F^D^D^F^F^F^P^D^D^F"
 F TT=1:1:16 S Y=$P(TEMP,U,TT),FT=$P(FTYPE,U,TT),FNAME=$P(NAME,U,TT) D DATE:FT="D",NAME:FT="P",FREE:FT="F"
 S SCD=$S(MFD:EDATE,CODE["RV":VDATE,CODE["ROV":VDATE,CODE="RNV":RDATE,CODE="S":EDATE,1:EDATE)
 S PERSON=$$DECODE(TEMP,CODE,MDF,MDR)
 S ROV=$S(CODE["ROV":"Signing for "_VNAME,1:""),SUPNUM=+SUPNUM,TSUP2=SUP2,SUPNUM=SUPNUM+1
 S:'SUP2 NUM=SUPNUM
 D:SUP2 VERSION
 S VERSION=SUPNUM_" of "_NUM,SS=""
 S $P(SS," -",40)="" D SETNODE(MDGRS,SS)
 S SS=$J(" ",18)_"R e p o r t   R e l e a s e   S t a t u s" D SETNODE(MDGRS,SS)
 D SETNODE(MDGRS," ")
 S SS="Current "_$J(" ",11)_"Date   "_$J(" ",2)_"Person Who" D SETNODE(MDGRS,SS)
 S SS="Report  "_$J(" ",11)_$S(CODE["D":"Last   ",1:"Status ")_"  Last "_$S(CODE["D":"Edited",1:"Changed")
 S SS=SS_$J(" ",13)_"Date of"_$J(" ",12)_"Report" D SETNODE(MDGRS,SS) S SS=""
 S SS="Status  "_$J(" ",11)_$S(CODE["D":"Edited",1:"Changed")_$J(" ",2)_$S(CODE["D":" Procedure",1:"The Status")_$J(" ",15)_" Entry "_$J(" ",12)_"Version" D SETNODE(MDGRS,SS) S SS=""
 S $P(SS,"=",80)="" D SETNODE(MDGRS,SS)
 I $G(MCSTAT)'="" D SETNODE(MDGRS,MCSTAT)
 S SS=$J(" ",19)_SCD_$J(" ",2)_PERSON
 S SS=SS_$J(" ",(52-$L(SS)))
 S SS=SS_CREATION_$J(" ",(64-$L(SS)))_VERSION
 D SETNODE(MDGRS,SS) K SS
 D SETNODE(MDGRS,$J(" ",28)_ROV)
 K MCFILE1
 Q
NAME S Y=$$GET1^DIQ(200,+Y_",",.01,"E"),@FNAME=$P(Y,",",2)_" "_$P(Y,",",1) Q
DATE S @FNAME=+$E(Y,4,5)_"/"_+$E(Y,6,7)_"/"_$E((1700+$E(Y,1,3)),3,4) Q
FREE S @FNAME=Y Q
DECODE(TEMP,CODE,FILE,REC) ;Decode the Validation code 1
 N CR,PDUZ,STR,PRE
 S PRE=+$P(TEMP,U,1) S:PRE=0 PRE=DUZ
 Q:(CODE="")!(CODE="D")!(CODE="PD")!(CODE="MFD")!(CODE="S") $$GET1^DIQ(200,PRE_",",.01) ;HUN-1095-22932
 S CR=$P(TEMP,U,$S(CODE["RV":5,1:2))
 S PDUZ=$P(TEMP,U,$S(CODE["RV":4,1:1))
 S STR=$$SUM^MCESPRT($G(^MCAR(MDF,REC,0)))
 Q $$DECODER^MCESPRT(CR,PDUZ,REC)
 ;
VERSION ; Find the version number of a procedure
 F NUM=SUPNUM:1 D CHECK Q:TSUP2=0
 S NUM=NUM+1
 Q
CHECK ; Find the number of times the report was superseded
 S DTEMP=$G(^MCAR(MDF,TSUP2,"ES"))
 S TSUP2=+$P(DTEMP,U,11)
 Q
HEDSPAS(MDTX,MDSP1) ;    surround text string X with space to length X1
 N I,Y1
 S (TY,Y1)="",$P(Y1," ",MDSP1-$L(MDTX)\2-1)=" ",TY=Y1_" "_MDTX_" "
 F I=$L(TY):1:MDSP1 S TY=TY_" "
 Q TY
SET ; Set GMTS variable
 N MDLIM1 S MDLIM=GMTSNDM
 D:+$G(MDLIM)<1 LIMIT(.MDLIM)
 S MDTS2=(9999999-GMTS1),MDTS1=(9999999-GMTS2)
 Q
LIMIT(MDLIM) ; Get all Report maximum occurrence limit
 N LIM
 S LIM=$$GET^XPAR("USR.`"_DUZ_"^DIV^SYS^PKG","ORWRP TIME/OCC LIMITS ALL",1,"I")
 S MDLIM=$S(+$P(LIM,";",3):+$P(LIM,";",3),1:999)
 Q
HEAD ; Display Header
 N MDPG S MDPG=0
H1 ; Display Header with Page increment
 Q:+$G(MDH)
 N CODE,MDDOB,MDRB,MDTIME,MDWARD,MDTM,X
 S MDPG=MDPG+1 D NOW^%DTC S X=% D DTIME^MCARP S MDTIME=$$FMTE^XLFDT(X,2)
 S MCSTAT="",MDTM=$G(^MCAR(MDF,+MDR,"ES")),CODE=$P(MDTM,U,7),MFD=$P(MDTM,U,12) I CODE'="" S MCSTAT=$S(MFD:" Mark for Deletion",1:"X") S:MCSTAT="X" MCSTAT=$$STATUS^MCESEDT(MDF,CODE)
 D DEM^VADPT
 S SS="Pg. "_MDPG_$J(" ",25)_$$HOSP(DFN)
 S SS=SS_$J(" ",(74-$L(SS_MDTIME)))_MDTIME D SETNODE(MDGRS,SS)
 S SS=$$HEDSPAS(MDPNAM_" REPORT"_$S(MCSTAT="":"",1:" - "_MCSTAT),77) D SETNODE(MDGRS,SS) S SS=""
 S SS=$$DEMO(DFN) D SETNODE(MDGRS,SS)
 N FFF S $P(FFF,"- ",40)="- " D SETNODE(MDGRS,FFF)
 Q
HOSP(DFN) ; Hospital for Header
 N HOSP
 S HOSP=$P($G(^DPT(DFN,.1)),U)
 S:HOSP'="" HOSP=$$FIND1^DIC(44,,"X",HOSP)
 S:HOSP'<1 HOSP=$$GET1^DIQ(44,HOSP,3.5,"I")
 S:HOSP'="" HOSP=$P($G(^DG(40.8,HOSP,0)),U)
 Q HOSP
DEMO(DFN) ; Demographics for Header
 N SS1,MDDOB,MDWARD,SS1
 D DEM^VADPT
 S SS1=$G(VADM(1))_"    "_$P($G(VADM(2)),U,2)_"   "
 S MDDOB=" DOB: "_$P($G(VADM(3)),U,2)_"  ("_$G(VADM(4))_")"
 S SS1=SS1_$J(" ",(39-$L(MDDOB)))_MDDOB
 D KVAR^VADPT
 D INP^VADPT S MDWARD=$S(VAIN(4)'="":$P(VAIN(4),U,2),1:"NOT INPATIENT"),MDRB=VAIN(5) D KVAR^VADPT
 Q SS1_$J(" ",(72-$L(SS1)))_MDWARD_" "_MDRB
HDR ; Page Header
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "  CONSULT                                   DATE/TIME",!
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W "   NUMBER   COMPLETED PROCEDURES            PERFORMED              PROCEDURE CODE",!
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W "  -------   ------------------------------  ----------------       -----------------",!
 Q
HSHDR ; Health Summary One Line Procedure Header
 N MDLINE
 S $P(MDLINE,"-",80)=""
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !,MDLINE
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !,$S(+$P(MDX1,U,13):$J($P(MDX1,U,13),9),1:""),?12,$E($P(MDX1,U,1),1,30),?44,$P(MDX1,U,6),?64,$P(MDX1,U,7)
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !,MDLINE
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 Q
