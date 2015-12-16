DGPTRNU ;ISF/GJW,HIOFO/FT - PTF TRANSMISSION ;2/18/15 2:28pm
 ;;5.3;Registration;**884**;Aug 13, 1993;Build 31
 ;
 ;XLFDT - #10103
 ;
FDATE(DGDT,DGDF) ;format date as MMDDYY
 ;Format options
 ;1 - MMDDYY
 ;2 - MMDDYYYY
 N X,MON,DAY,YR,VAL
 S DGDF=$G(DGDF,1) ;default to 2-digit date
 S X=$$FMTE^XLFDT(DGDT,"5ZP")
 S MON=$P(X,"/")
 S DAY=$P(X,"/",2)
 S YR=$P(X,"/",3)
 S:DGDF=1 VAL=MON_DAY_$E(YR,3,4)
 S:DGDF=2 VAL=MON_DAY_YR
 Q $S(+DGDT'>0:"",1:VAL)
 ;
TIME(DTM) ;extract time in HHMM format from date/time
 N X,Y,H,M
 S X=$$FMTE^XLFDT(DTM,"6F")
 S Y=$P(X,"@",2)
 S H=$P(Y,":"),M=$P(Y,":",2)
 Q H_M
 ;
FMTICD(DGC) ;format ICD code for transmission
 Q $TR(DGC,".","")
 ;
 ;Retrieve nodes from PTF CLOSE OUT (#45.84) where appropriate
GETNODE(DGPTF,DGHOW,DGNODE) ;
 ;DGHOW = 1 - use PTF CLOSE OUT node if defined, PTF otherwise
 ;DGHOW = 2 - use PTF file
 ;DGHOW = 3 - use PTF CLOSE OUT record (forced)
 N VAL,DFN,COUT,IENS45,IENS2,FLD,NODE
 ;the field numbers for the various STORE(*) fields
 S NODE=$S(DGNODE=0:0,DGNODE=32:.32,DGNODE=321:.321,DGNODE=52:.52,1:"")
 S FLD=$S(DGNODE=0:10,DGNODE=11:11,DGNODE=52:12,DGNODE=321:13,DGNODE=32:14,DGNODE=57:15,.3:16,1:0)
 S VAL=""
 S IENS45=DGPTF_","
 S COUT=$$GET1^DIQ(45,IENS45,7.1,"I") ;corresponding entry in PTF CLOSE OUT file
 S DFN=$$GET1^DIQ(45,IENS45,.01,"I") ;ft 2/12/15
 I DGHOW'=3 D
 .S DFN=$$GET1^DIQ(45,IENS45,.01,"I")
 .S IENS2=$G(DFN)_","
 I DGHOW=1 S VAL=$S(COUT:$$GET1^DIQ(45.84,COUT_",",FLD),1:$G(^DPT(DFN,DGNODE)))
 I DGHOW=2 S VAL=$G(^DPT(DFN,.321))
 I DGHOW=3 S VAL=$$GET1^DIQ(45.84,COUT_",",FLD)
 Q VAL
 ;
 ;convenience routines for commonly used nodes
GET0(DGPTF,DGHOW) ;
 S DGHOW=$G(DGHOW,1)
 Q $$GETNODE(DGPTF,DGHOW,0)
 ;
GET32(DGPTF,DGHOW) ;
 S DGHOW=$G(DGHOW,1)
 Q $$GETNODE(DGPTF,DGHOW,.32)
 ;
GET321(DGPTF,DGHOW) ;
 S DGHOW=$G(DGHOW,1)
 Q $$GETNODE(DGPTF,DGHOW,.321)
 ;
GET52(DGPTF,DGHOW) ;
 S DGHOW=$G(DGHOW,1)
 Q $$GETNODE(DGPTF,DGHOW,.52)
 ;
POW(DGPTF) ;POW status
 ;returns
 ;1 - not a POW
 ;3 - POW, unknown
 ;4 - POW, World War I
 ;5 - POW, World War II (Europe)
 ;6 - POW, World War II (Pacific)
 ;7 - POW, Korea
 ;8 - POW, Vietnam
 ;9 - POW, combination
 N DG52,SI,PP,Y,VAL
 S DG52=$$GET52^DGPTRNU(DGPTF)
 S SI=$P(DG52,U,5) ;POW status indicated?,
 S Y=$P(DG52,U,6) ;POW period
 S VAL=1
 I SI="Y" D
 .S VAL=$S(Y=0:3,Y=2:5,Y=3:6,Y=4:7,Y=5:8,Y=6:9,Y=7:"A",Y=8:"B",1:" ")
 Q VAL
 ;
PDIS(DGPTF) ;place of disposition
 N IENS,IENS1,X
 S IENS=DGPTF_","
 S X=$$GET1^DIQ(45,IENS,75,"I"),IENS1=X_","
 Q $$GET1^DIQ(45.6,IENS1,2) ;PTF code
 ;
POS(DGPTF) ;period of service
 N IENS45,DG32,POS1,POS,MV,ELIG
 S IENS45=DGPTF_","
 S DG32=$$GET32^DGPTRNU(DGPTF)
 S POS1=$P(DG32,U,3) ;period of service from PATIENT file (pointer to file #21)
 S POS=$$GET1^DIQ(21,POS1_",",.03) ;code
 ;Now, use the "APTF" cross-reference on the PATIENT MOVEMENT (#405) file to look up
 ;the patient movement associated with this PTF entry
 S MV="" S:$D(^DGPM("APTF",PTF)) MV=$O(^DGPM("APTF",PTF,0))
 ;If the patient movement has ODS AT ADMISSION set (for Operation Desert Shield), ensure
 ;that POS=6 (ODS). This is necessary because the POS may have been set to another value
 ;according the business rules.
 I +$$GET1^DIQ(405,MV_",",11500.01)>0 S POS=6
 S ELIG=$$GET1^DIQ(45,IENS45,20.1,"I") ;admitting eligibility
 S POS=$$CKPOS^DGPTUTL(ELIG,POS) ;update POS (to account for non-vet eligibilities)
 Q POS
 ;
MSTATUS(DGPTF) ;marital status
 N IENS45,DFN,IENS,X,MS
 S IENS45=DGPTF_","
 S DFN=$$GET1^DIQ(45,IENS45,.01,"I"),IENS=DFN_","
 S X=$$GET1^DIQ(2,IENS,.05,"I")
 S MS=$$GET1^DIQ(11,X_",",2,"I")
 S:MS="" MS="U"
 Q MS
 ;
ION(DGPTF) ;ionizing radiation (used by 101)
 ;return value
 ;1 - no claim of exposure
 ;2 - claims exposure, Japan
 ;3 - claims exposure, testing
 ;4 - claims exposure, both testing and Japan
 ;5 - claims exposure, underground nuclear testing
 ;6 - claims exposure, nuclear facility
 ;7 - claims exposure, other
 N DG321,DGNT,DGPOS,RE,E,VPOS
 S DG321=$$GET321^DGPTRNU(DGPTF)
 S DGNT=$P(DG321,U,12) ;radiation exposure method
 S RE=$P(DG321,U,3) ;radiation exposure indicated
 S E=" "
 S DGPOS=$$POS(DGPTF)
 ;valid POS for ionizing radiation?
 S VPOS=$S(DGPOS=0:1,DGPOS=2:1,DGPOS=4:1,DGPOS=5:1,DGPOS=7:1,DGPOS=8:1,DGPOS="Z":1,1:0)
 D:VPOS
 .S E=$S(RE'="Y":1,1:DGNT)
 Q E
 ;
ION2(DGPTF) ;ionizing radiation (used by 701)
 ;returns Y(es), N(o) or space
 N G
 S G=$$GET1^DIQ(45,DGPTF_",",79.27,"I")
 Q $S(G="Y":"Y",G="N":"N",1:" ")
 ;
MST(DGPTF) ;military sexual trauma
 N IENS,X,Y
 S IENS=DGPTF_","
 S Y=$$GET1^DIQ(45,IENS,79.29,"I")
 Q $S(Y="Y":"Y",Y="N":"N",1:" ")
 ;
HNC(DGPTF) ;treatment related to head/neck cancer (HNC)
 N Y,IENS
 S IENS=DGPTF_","
 S Y=$$GET1^DIQ(45,IENS,79.3,"I")
 Q $S(Y="Y":"Y",Y="N":"N",1:" ")
 ;
SWASIA(DGPTF) ;treatment related to service in SW Asia
 N Y,IENS
 S IENS=DGPTF_","
 S Y=$$GET1^DIQ(45,IENS,79.28)
 Q $S(Y="":" ",1:Y)
 ;
CVS(DGPTF) ;combat vet status
 ;returns 1=yes, 2=no
 N DG0,IENS,DFN,Y,ADATE
 S DG0=$$GET0^DGPTRNU(DGPTF)
 S IENS=DGPTF_","
 S DFN=$$GET1^DIQ(45,IENS,.01,"I")
 S ADATE=$P(DG0,U,2) ;admission date
 I ADATE S Y=$$CVEDT^DGCV(DFN,ADATE)
 E  S Y=$$CVEDT^DGCV(DFN,ADATE)
 Q $S(+Y>0:1,1:2)
 ;
CVDT(DGPTF) ;combat vet date
 N DG0,IENS,DFN,ADATE,Y
 S DG0=$$GET0^DGPTRNU(DGPTF)
 S IENS=DGPTF_","
 S DFN=$$GET1^DIQ(45,IENS,.01,"I")
 S ADATE=+$P(DG0,U,2) ;admission date
 I ADATE S Y=$$CVEDT^DGCV(DFN,ADATE)
 E  S Y=$$CVEDT^DGCV(DFN)
 Q $S(+Y>0:$P(Y,U,2),1:0)
 ;
SHAD(DGPTF) ;SHAD/Project 112
 N IENS,Y
 S IENS=DGPTF_","
 S Y=$$GET1^DIQ(45,IENS,79.32,"I")
 Q $S(Y="":" ",1:Y)
 ;
KATRINA(DGPTF) ;Katrina indicator
 N DFN,DG0,ERI
 S IENS=DGPTF_","
 S DG0=$$GET0(DGPTF),DFN=+DG0
 S ERI=$$EMGRES^DGUTL(DFN) ;emergency response indicator
 ;returns "K" or " "
 Q $S("^K^"[(U_ERI_U):"K",1:" ")
 ;
MTI(DGPTF) ;means test indicator
 ;return value
 ;AS - SC and special category veterans
 ;AN - NSC veterans
 ;B -  category "B" NSC veterans
 ;C -  MT copay required (category "C" NSC veterans)
 ;N -  non-veterans
 ;X -  not applicable
 ;U -  not done/completed
 ;G -  GMT copay required
 N VAL,IENS,MT,AO
 S VAL="  "
 S IENS=DGPTF_","
 S AO=$$GET1^DIQ(45.84,IENS,79.26,"I") ;treated for AO condition
 S MT=$$GET1^DIQ(45.84,IENS,10,"I") ;means test indicator
 S MT=$S(MT="":"U",1:MT)
 S VAL=$S(AO="Y":"AS",1:MT)
 Q VAL
 ;
AO(DGPTF) ;treated for agent orange exposure (used by 701)
 ;Y - yes
 ;N - no
 ;" " - unknown or no value
 N G
 S G=$$GET1^DIQ(45,DGPTF_",",79.26,"I")
 Q $S(G="Y":"Y",G="N":"N",1:" ")
 ;
AO2(DGPTF) ;agent orange exposure (used by 101)
 ;return value:
 ;1 - no claim of service in Vietnam
 ;2 - claims service in Vietnam, no exposure
 ;3 - claims service in Vietnam with exposure
 ;4 - claims service in Vietnam with exposure unknown
 ;5 - claims service in DMZ with exposure
 ;may return blank
 N G,DGAO,DGPOS,DG321
 S DG321=$$GET321(DGPTF)
 S G=" "
 S DGAO=$P(DG321,U,2)
 S DGPOS=$$POS^DGPTRNU(DGPTF)
 S:DGPOS=7 G=$S($P(DG321,U)'="Y":1,DGAO="N":2,DGAO="Y":3,1:4)
 ;Check to see if the exposure location was the Korean DMZ
 S:(DGAO="Y")&($P(DG321,U,13)="K") G=5
 Q G
 ;
INCOME(DGPTF) ;income
 N INC,IENS,LI,PAD
 S IENS=DGPTF_","
 S INC=$$GET1^DIQ(45,IENS,101.07)
 S:INC>999999 INC=999999
 S LI=$L(INC)
 S PAD=$S(LI=0:"000000",LI=1:"00000",LI=2:"0000",LI=3:"000",LI=4:"00",LI=5:"0",1:"")
 Q PAD_INC
 ;
DISP(PTF) ;date of disposition
 N IENS
 S IENS=PTF_","
 Q $$GET1^DIQ(45,IENS,70,"I") ;discharge date
 ;
GETMPCR(DGTS) ;MPCR from specialty
  N ARRY,Y,Z,MPCR
  S Y=$$TSDATA^DGACT(42.4,DGTS,.ARRY)
  S Z=$G(ARRY(6))
  I Y>0 S MPCR=$E($P(Z,".")_"0000",1,4)_$E($P(Z,".",2)_"00",1,2)
  E  S MPCR=""
  Q MPCR
  ;
SPCODE(DGTS) ;
 N ARRY,Y,Z
 S Y=$$TSDATA^DGACT(42.4,DGTS,.ARRY)
 S Z=$G(ARRY(6))
 Q $S(Y>0:Z,1:"")
 ;
RACE(DGPTF,DGARR) ;
 N IENS45,IENS,DFN
 N OUT,MOUT
 N I,NUM,MORE,EVAL,IVAL
 S IENS45=DGPTF_","
 S DFN=$$GET1^DIQ(45,IENS45,.01,"I"),IENS=","_DFN_","
 ;retrieve at most 6 entries, screening out those that are inactive
 D LIST^DIC(2.02,IENS,".01",,6,,,,"I '$$INACTIVE^DGUTL4(Y)",,"OUT","MOUT")
 S NUM=$P(OUT("DILIST",0),U) ;number of subrercords returned
 S MORE=$P(OUT("DILIST",0),U,3) ;any more?
 F I=1:1:NUM D
 .S EVAL=$G(OUT("DILIST",1,I))
 .S IVAL=$G(OUT("DILIST",2,I))
 .S @DGARR@(I,"IEN")=IVAL
 .S @DGARR@(I,"VAL")=EVAL
 .S @DGARR@(I,"CODE")=$$PTR2CODE^DGUTL4(IVAL,1,4)
 Q
