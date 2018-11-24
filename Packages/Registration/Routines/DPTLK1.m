DPTLK1 ;ALB/RMO,EG - MAS Patient Look-up Check Cross-References ;Nov 24, 2018@08:06
 ;;5.3;Registration;**32,50,197,249,317,391,244,532,574,620,641,680,538,657,915,OSE/SMH**;Aug 13, 1993;Build 6
 ; OSE/SMH - Changes for VistA Internationalization
 ; (c) Sam Habiel 2018
 ; Licensed under Apache 2.0
FIND ;Cross reference patient lookup
 ;Optional input: DPTNOFZY='1' to suppress fuzzy lookups implemented
 ;                by patch DG*5.3*244
 ;
 N DDCOMA,DPTXOLD,DPTOUT,DPTOVAL,DGLASTLK
 S DGLASTLK=1
 S (DPTXOLD,DPTX)=$$UCASE(DPTX)
 I DPTX?1A.E1","1.A.E S DPTXOLD=DPTX,DDCOMA="I $E($P($G(DPTVAL),"","",2),1,"_$L($P(DPTX,",",2))_")="""_$TR($P(DPTX,",",2),"""")_"""",DPTX=$P(DPTX,",")
 K DPTREFS S DPTREFS=$S(DIC(0)'["M":"B,NOP",DPTX?1A1N.N:$S($L(DPTX)<6:"BS5,CN,RM",1:"CN,RM"),DPTX?4N!(DPTX?4N1A):"BS,SSN,CN,RM",DPTX?9N.E:"SSN,CN,RM",1:"")
 S:DPTREFS="" DPTREFS=$S(DPTX?1N.N:$S($L(DPTX)<5:"CN,RM,BS,SSN",1:"CN,RM,SSN"),DPTX?1N.E:"CN,RM",1:"B,NOP,CN,RM") S:$D(DPTIX) DPTREFS=DPTIX_","_DPTREFS
 ;Use cross reference passed to LIST^DPTLK1 by Person Service Lookup (DPTPSREF) if defined.
 I $G(DPTPSREF)'="" S DPTREFS=DPTPSREF
 S DPTBEG=1,(DPTDFN,DPTNUM,DPTOUT)=0
 F DPTLP=1:1 S DPTREF=$P(DPTREFS,",",DPTLP) Q:DPTREF=""!(DPTDFN)  D  Q:DPTDFN!DPTOUT
 .S DPTVAL=DPTX
 .I DPTREF="NOP",'$G(DPTNOFZY) S DPTVAL=$$FORMAT^XLFNAME7(DPTVAL,1,30,1,0,,1) Q:'$L(DPTVAL)  ; OSE/SMH 2nd par to $$FORMAT is 1 instead of 2 (for CJK names)
 .D LOOK(DPTVAL)
 .I DPTREF="B",'$G(DPTNOFZY) S DPTVAL=$$FORMAT^XLFNAME7(DPTX,1,30,1,0,,1) D:DPTVAL'=DPTX LOOK(DPTVAL) ; OSE/SMH ditto
 .Q
SET I 'DPTDFN S:DPTCNT=1&($D(DPTIFNS(DPTCNT))) DPTDFN=+DPTIFNS(DPTCNT) S DPT("NOPRT^")="" D PRTDPT:'DPTDFN&(DPTCNT>DPTNUM)&(DIC(0)["E") K DPT("NOPRT^") I 'DPTDFN,$D(DPTSEL),DPTSEL="" S DPTX="",DPTDFN=-1
 I DPTDFN'>0,$L($G(DPTXOLD)) I DPTX=$P(DPTXOLD,",") S DPTX=DPTXOLD
 I DPTDFN>0,$D(DPTXOLD) S DPTX=DPTXOLD
 ; one last stab at lookup - DG*641
 I '$G(DPTCNT),DPTX[",",DGLASTLK=1,'$G(DPTNOFZY) D
 .S DPTX=$$FORMAT^XLFNAME7(DPTX,2,30,1)
 .S DDCOMA="I $E($P($G(DPTVAL),"","",2),1,"_$L($P(DPTX,",",2))_")="""_$TR($P(DPTX,",",2),"""")_""""
 .S DPTX=$P(DPTX,",")
 .S DGLASTLK=0
 .S DPTREFS="B,NOP,CN,RM"
 .;Person Service Lookup does not allow lookup by RM cross reference
 .;PSL release 4 does not allow lookup by ward (CN) cross reference
 .I $G(DPTPSREF)'="" S DPTREFS="B,NOP"
 .F DPTLP=1:1 S DPTREF=$P(DPTREFS,",",DPTLP) Q:DPTREF=""!(DPTDFN)  D  Q:DPTDFN!DPTOUT
 ..S DPTVAL=DPTX
 ..D LOOK(DPTVAL)
 ;**915 enterprise search
YN I DPTCNT=1,$P($G(XQY0),"^",2)="Register a Patient",DPTDFN,$T(PATIENT^MPIFXMLP)'="" D  I 'DPTDFN S DPTX="",DPTDFN=-1
 . N %,%Y
 . W !,"Found: ",$P(^DPT(DPTDFN,0),"^")," ",$$FMTE^XLFDT($P(^DPT(DPTDFN,0),"^",3),"2D")," ",$P(^DPT(DPTDFN,0),"^",9)," ",$$GET1^DIQ(2,DPTDFN_",",.301)," ",$$GET1^DIQ(2,DPTDFN_",",391)
 . W !," Ok" D YN^DICN
 . I %=2 S DPTDFN=$$SEARCH^DPTLK7(DPTX,DPTXX) S:DPTDFN<1 DPTCNT=0 D:DPTDFN>1  Q
 .. S DPTS(DPTDFN)=$P(^DPT(DPTDFN,0),"^")_"^"_$P(^DPT(DPTDFN,0),"^")
 . I %=1 Q
 . S DPTDFN=0 G Q
 ;**915 end
 I DGLASTLK=0,$G(DPTCNT) S DGLASTLK=1 G SET
 I DGLASTLK=0,'$G(DPTCNT),$L($G(DPTXOLD)) S DPTX=DPTXOLD
 ; end of DG*641 change
 ;
Q K DPTBEG,DPTIFN,DPTIFNS,DPTLP,DPTLP1,DPTNUM,DPTREF,DPTREFS,DPTVAL
 K DPTOVAL,DPTOUT,DPTXOLD,^TMP("DPTLK",$J)
 Q
 ;
LOOK(DPTVAL) ;Look for x-ref matches
 ;Input: DPTVAL=lookup seed value
 I $L(DPTVAL),$D(^DPT(DPTREF,DPTVAL)) D CHKIFN Q:DPTDFN!DPTOUT
 I $L(DPTVAL),'($D(^DPT(DPTREF,DPTVAL))&(DIC(0)["O"))&(DIC(0)'["X") D CHKVAL
 Q
 ;
CHKVAL S DPTOVAL=DPTVAL
 N DPTSEED S DPTSEED=DPTVAL
 I DPTREF="SSN",(DPTVAL?9N1"p") D  Q
 .S DPTVAL=$E(DPTVAL,1,9)_"P" D CHKIFN
 .Q
 I DPTREF="SSN",(DPTVAL?2.9N) D  Q
 .S DPTVAL=$E(DPTVAL_"0000000",1,9)
 .D CV1(DPTVAL),CHKIFN
 .S DPTVAL=DPTVAL_"P" D CV1(DPTVAL),CHKIFN
 .Q
 D CV1(DPTVAL)
 I DPTREF="CN"!(DPTREF="RM"),DPTVAL'["E",DPTVAL=+DPTVAL,'$D(^DPT(DPTREF,DPTVAL)) D  Q
 .S DPTVAL=$O(^DPT(DPTREF,DPTVAL_" "),-1)
 .D CV1(DPTVAL)
 .Q
 Q
 ;
CV1(DPTVAL) ;Look for input value matches
 I $L(DPTVAL) F DPTLP1=0:0 S DPTVAL=$O(^DPT(DPTREF,DPTVAL)) Q:DPTVAL=""!(DPTDFN)!($P(DPTVAL,DPTSEED)'="")  D CHKIFN
 Q
 ;
CHKIFN F DPTIFN=0:0 S DPTIFN=$O(^DPT(DPTREF,DPTVAL,DPTIFN)) Q:'DPTIFN!(DPTDFN)!DPTOUT  S Y=DPTIFN D SETDPT I $S<DPTSZ F I=1:1:DPTNUM-7 S J=$S($D(DPTIFNS(I)):+DPTIFNS(I),1:0) K DPTIFNS(I),DPTS(J) S DPTBEG=I
 Q
 ;
SETDPT Q:($D(DPTS(Y))&($G(DPTREF)'="B"))!'$D(^DPT(Y,0))
 ; screen out MERGED FROM records - DG/574
 Q:$D(^DPT(Y,-9))
 N DPTNVAL I '$D(DPTOVAL) N DPTOVAL S DPTOVAL=DPTX
 I 1 S X=DPTOVAL X:$D(DIC("S")) DIC("S") Q:'$T  X:($D(DO("SCR"))) DO("SCR") Q:'$T  X:$D(DDCOMA) DDCOMA Q:'$T
 K:$G(DPTCNT)<1 ^TMP("DPTLK",$J)
 S DPTS(Y)=$S('$D(DPTREF):$P(^DPT(Y,0),U),1:$P(^DPT(Y,0),U))_U_$S($D(DPTVAL):$E(DPTVAL,($L(DPTOVAL)+1),$L(DPTVAL)),1:"")
 S DPTNVAL=$P(^DPT(Y,0),U)_U_$S($G(DPTREF)="NOP":$P(^DPT(Y,0),U),$D(DPTVAL):DPTVAL,1:"")
 Q:$D(^TMP("DPTLK",$J,Y,DPTNVAL))
 S DPTCNT=DPTCNT+1,^TMP("DPTLK",$J,Y,DPTNVAL)="",DPTIFNS(DPTCNT)=Y_U_DPTNVAL
 I $D(DPTLARR) D  Q
 .I DPTLMAX,DPTCNT>DPTLMAX D  Q
 ..S @DPTLARR@(DPTCNT)="ADDITIONAL MATCHES FOUND BUT NOT RETURNED"
 ..S DPTOUT=1
 ..Q
 .S @DPTLARR@(DPTCNT)=DPTIFNS(DPTCNT)_U_$$SSN(Y)_U_$$DOB(Y)
 .Q
 I '(DPTCNT#5),DIC(0)["E" D PRTDPT
 Q
 ;
PRTDPT I $D(DDS) D CLRMSG^DDS S DX=0,DY=DDSHBX+1 X DDXY S X=0 X ^%ZOSF("RM")
 N DPTP1,DPTP2
 F DPTNUM=DPTNUM+1:1:DPTCNT Q:DPTOUT  S DPTIFN=+DPTIFNS(DPTNUM) D
 .W:'$D(DDS) !
 .S DPTP2=$P(DPTIFNS(DPTNUM),U,3)
 .S DPTP1=$P(DPTIFNS(DPTNUM),U,2)
 .W ?3,DPTNUM,?$X+(4-$L(DPTNUM))
 .; write the xref value
 .W DPTP2_"  "
 .; write patient name if diff than xref value
 .I DPTP1'=DPTP2 W DPTP1
 .S Y=DPTIFN X:$D(^DPT(DPTIFN,0)) "N DDS X DIC(""W"")" I $D(DDS) S DY=DY+1,DX=0 X DDXY S $X=0
 I '$D(DPT("NOPRT^")) W:'$D(DDS) ! W "ENTER '^' TO STOP, OR "
 W:'$D(DDS) ! W "CHOOSE ",DPTBEG,"-",DPTNUM,": " R X:DTIME S DPTSEL=X D  Q:DPTSEL=""!$D(DTOUT)!$D(DUOUT)
 .S:'$T DPTSEL=$S($D(DPTOVAL):DPTOVAL,$D(DPTVAL):DPTVAL,$D(DPTX):DPTX,$D(DPTXOLD):DPTXOLD,1:""),(DPTOUT,DTOUT)=1
 .S:X="^" (DPTOUT,DUOUT)=1
 S DPTDFN=$S(DPTSEL'?.ANP!($L(DPTSEL)>30):-1,'$D(DPTIFNS(DPTSEL)):-1,$D(DPTS(+DPTIFNS(DPTSEL))):+DPTIFNS(DPTSEL),1:-1),DPTX=$S(DPTDFN<0:DPTSEL,1:DPTX)
 S:DPTDFN=-1 DPTXOLD=DPTSEL
 Q
 ;
LIST(DPTX,DPTLMAX,DPTLARR) ;Silent lookup list
 ;Input: DPTX=lookup value (name, SSN, room, ward, DFN or 
 ;             "space_return").
 ;       DPTLMAX=maximum number of matches to return (optional), this
 ;               parameter has no effect if DFN or "space_return"
 ;               lookup methods are used.
 ;       DPTLARR=name of array to return list of matches, this should
 ;               be a global if DPTLMAX is a large value or unspecified
 ;               This array is returned in the format:
 ;               @DPTLARR@(n)=DFN^patient_name^xref_lookup_match_value^
 ;                            SSN^Date_of_Birth
 ;               If more matches exist than the maximum to be returned
 ;               as specified by DPTLMAX, the @DPTLARR@(DPTLMAX+1) node
 ;               will be defined = "ADDITIONAL MATCHES FOUND BUT NOT 
 ;               RETURNED".
 ;               The calling program has the responsibility to kill
 ;               @DPTLARR prior to calling this entry point.
 ;Output: number of matches and array named by DPTLARR.
 ;
 N X,Y,DPTCNT,DIC,DPTSZ,DPTDFN,DPTIFNS,DPTS
 S DPTCNT=0,DIC(0)="M",DPTSZ=1000 S:$G(DPTLMAX)<1 DPTLMAX=0
 ;Check for "space_return" or DFN lookup
 I DPTX=" "!($E(DPTX)="`") D  Q DPTCNT
 .I DPTX=" " S Y=$S('($D(DUZ)#2):-1,$D(^DISV(DUZ,"^DPT(")):^("^DPT("),1:-1)
 .I $E(DPTX)="`" S Y=$S($D(^DPT(+$P(DPTX,"`",2),0)):+$P(DPTX,"`",2),1:-1)
 .Q:Y<1  Q:'$D(^DPT(Y,0))  D SETDPT S DPTCNT=1
 .Q
 D FIND
 Q $S(DPTLMAX&(DPTCNT>DPTLMAX):DPTLMAX,1:DPTCNT)
 ;
UCASE(DGX) ;Uppercase lookup value
 ;Input: DGX=lookup value
 ;Output: transformed DGX
 N DGI,DGY,DGZ S DGZ=DGX,DGX=""
 F DGI=1:1:$L(DGZ) S DGY=$E(DGZ,DGI) D
 .S:DGY?1L DGY=$C($A(DGY)-32)
 .S DGX=DGX_DGY
 Q DGX
 ;        
SSN(DFN) ;do not show ssn identifier for patient
 ; input DFN = ien in file #2 [required]
 ; output SSN = nnnnnnnnn
 ;
 N SSN
 S SSN="",DFN=+DFN
 I DFN>0 D
 .I $$SCREEN(DFN) S SSN="*SENSITIVE*" Q
 .S SSN=$P($G(^DPT(DFN,0)),U,9)
 .; DG*5.3*657 BAJ 11/20 2005
 .; display Pseudo SSN alert on list
 .I SSN?9N1"P" S SSN=SSN_" **Pseudo SSN**"
 .Q 
 Q SSN
 ;
DOB(DFN,DGYR) ;do not show dob identifier for patient
 ; input DFN = ien in file #2  [required]
 ;       DGYR = 0/1  [optional]
 ;              where 0 returns 4-digit year (default)
 ;                    1 returns 2-digit year
 ;                    2 returns File manager date
 ; output DOB = mm/dd/yyyy (default)
 ;            = mm/dd/yy, if DGYR=1
 ;            = yyymmdd, if DGYR=2
 N B,DOB,YEAR
 S DOB="",DFN=+DFN,DGYR=+$G(DGYR)
 I DFN>0 D
 .I $$SCREEN(DFN) S DOB="*SENSITIVE*" Q
 .S B=$P($G(^DPT(DFN,0)),U,3)
 .I DGYR'=2 D  Q
 ..S YEAR=$S(DGYR=1:"2D",1:"5D")
 ..S DOB=$$FMTE^XLFDT(B,YEAR)
 .S DOB=B
 Q DOB
 ;
SCREEN(DFN) ;Screening logic for SSN & DOB
 ;Input  : DFN - Pointer to PATIENT file (#2)
 ;Output : 1 - Apply screen
 ;         0 - Don't apply screen
 ;Notes  : Screen applied if patient is sensitive or an employee
 ;
 N DGTIME,DGT,DGA1,DG1,DGXFR0
 ;Inpatient check - no longer used (kept for future reference)
 ;D H^DGUTL S DGT=DGTIME D ^DGPMSTAT I DG1 Q 0
 ;Sensitive - screen
 I $P($G(^DGSL(38.1,DFN,0)),"^",2) Q 1
 ;Employee - screen
 I $$EMPL^DGSEC4(DFN) Q 1
 ;Don't screen
 Q 0
