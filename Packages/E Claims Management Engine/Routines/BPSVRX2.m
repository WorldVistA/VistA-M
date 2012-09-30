BPSVRX2 ;SLT - View ECME Prescription ;7/18/2011
 ;;1.0;E CLAIMS MGMT ENGINE;**11**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Reference to $$RDIS^DGRPDB supported by DBIA #4807
 ;
 Q
 ;
DGELST(RXIEN,FILL,VIEWTYPE,BPSSNUM) ; View Registration Eligibility Status screen
 N DFN,X,RPTYPE,LC,PAT,X1,SPS,Z,RPW,I,RP,RPX,Z1,LINE,NA,RPU,SP,MBCK,RPE,AAC
 N I1,SHAD,CV,I3,LEN,MAXLEN,INST,INSTP
 I '$D(ZTQUEUED) W !,"Compiling data for View Registration Eligibility Status ... "
 K ^TMP($J,"BPSELST")
 S LC=0,SP=" ",MAXLEN=80
 S DFN=+$$RXAPI1^BPSUTIL1(RXIEN,2,"I")
 S PAT=$$SSNNM(DFN)
 F I=0,.29,.3,.31,.32,.321,.36,.362,"TYPE","VET" S RP(I)=$G(^DPT(DFN,I))
 S X=$S(RP("TYPE")="":0,1:+RP("TYPE"))
 S RPTYPE=$S(X:$$EXTERNAL^DILFD(2,391,"",X),1:"PATIENT TYPE UNKNOWN")
 S X1=MAXLEN-($L(PAT)+$L(RPTYPE))
 S LC=LC+1,^TMP($J,"BPSELST",LC,0)=PAT_$$PAD(X1-1)_RPTYPE
 S X="",$P(X,"=",MAXLEN)="",RPU="UNANSWERED"
 S LC=LC+1,^TMP($J,"BPSELST",LC,0)=X
 ; section 1
 S Z=1,LINE=$$WW(Z)_$$PAD(7)_"Patient Type: "
 S RPX=RP("TYPE"),Z=$$GET1^DIQ(391,RPX,.01,"I")
 S Z=$S(Z]"":Z,1:RPU),Z1=34
 S LINE=LINE_Z_$$PAD(Z1-$L(Z))_"Veteran: "
 S RPX=RP("VET"),(X,Z1)=1
 S LINE=LINE_$$YN(X,RPX,Z1)
 S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 ;
 S LINE=$$PAD(9)_"Svc Connected: "
 S RPX=RP(.3),X=1,Z1=31,NA=$S($P(RP("VET"),U)="Y":0,1:1)
 S LINE=LINE_$$YN2(NA,X,RPX,Z1,.Z)
 S LINE=LINE_"SC Percent: "
 I $E(Z)'="Y" D
 . S LINE=LINE_"N/A"
 . S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 I $E(Z)="Y" D
 . S X=$P(RPX,U,2)
 . S LINE=LINE_$S(X="":"UNANSWERED",1:+X_"%")
 . S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 . S X=$P(RP(.3),U),NA=$S(X'="Y":1,1:0)
 . S LINE=$$PAD(9)_"SC Award Date: "_$$DATENP(RPX,12)
 . S LINE=LINE_$$PAD(53-$L(LINE))_"Unemployable: "_$$YN2(NA,5,RPX,0)
 . S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 . S LINE=$$PAD(19)_"P&T: "_$$YN2(NA,4,RPX,23)
 . I $P(RP(.3),U,4)["Y" S LINE=LINE_"P&T Effective Date: "
 . S:$P(RP(.3),U,13)']"" LINE=LINE_"UNANSWERED"
 . I $P(RP(.3),U,13)]"" D
 . . S Y=$$FMTE^XLFDT($P(RP(.3),U,13))
 . . S LINE=LINE_$G(Y)
 . S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 ;
 S LINE=$$PAD(9)_"Rated Incomp.: ",X=$$YN3(RP(.29),12)
 S LINE=LINE_X
 I X["Y" D
 . S LINE=LINE_$$PAD(3)_"Date (CIVIL): "_$$DATENP(RP(.29),2)
 . S LINE=LINE_$$PAD(4)_"Date (VA): "_$$DATENP(RP(.29),1)
 S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 ;
 S RPX=RP(.31)
 S LINE=$$PAD(10)_"Claim Number: "_$S($P(RPX,U,3)]"":$P(RPX,U,3),1:RPU)
 S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 ;
 S INST="",INSTP=$P(RP(.31),U,4)
 I INSTP S INST=$$EXTERNAL^DILFD(2,.314,"",INSTP)
 S LINE=$$PAD(11)_"Folder Loc.: "_$S(INST]"":INST,INSTP:"INVALID",1:"UNANSWERED")
 S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 ; section 2
 S Z=2,LINE=$$WW(Z)_$$PAD(3)_"Aid & Attendance: "
 S Z=$$YN3(RP(.362),12)
 S Z1=31
 S LINE=LINE_Z_$$PAD(Z1-$L(Z))_"Housebound: "
 S Z=$$YN3(RP(.362),13)
 S LINE=LINE_Z
 S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 ;
 S LINE=$$PAD(12)_"VA Pension: ",Z=$$YN3(RP(.362),14)
 S Z1=28
 S LINE=LINE_Z_$$PAD(Z1-$L(Z))_"VA Disability: ",Z=$$YN3(RP(.3),11)
 S LINE=LINE_Z
 S MBCK=$$MBCK(Z)
 S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 ;
 S LINE=$$PAD(4)_"Total Check Amount: "
 S X=$$DISP(RP(.362),20,'MBCK)
 S LINE=LINE_$S(X:"$"_X,1:X)
 S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 ;
 S LINE=$$PAD(10)_"GI Insurance: "
 S Z=$$YN3(RP(.362),17),Z1=35
 S LINE=LINE_Z_$$PAD(Z1-$L(Z))_"Amount: "
 S X=$$DISP(RP(.362),6)
 S LINE=LINE_$S(X:"$"_X,1:X)
 S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 ; section 3
 S Z=3,LINE=$$WW(Z)
 S RPE=+RP(.36),Z=$$GET1^DIQ(8,+RPE,.01,"I"),Z=$S(Z]"":Z,1:RPU)
 S LINE=LINE_$$PAD(2)_"Primary Elig Code: "_Z
 S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 ;
 ;Agency/Country
 S X=$$EXTERNAL^DILFD(2,.361,"",+$P(RP(.36),U))
 S AAC=$S($D(RP(.36)):$S(X]"":+$P(RP(0),U,4),1:""),1:"")
 S AAC(1)=$S('$D(RP("VET")):"",RP("VET")'="N":"",AAC=4:"A",AAC=5:"C",1:"")
 I AAC(1)]"" D
 . S X=$$EXTERNAL^DILFD(2,.309,"",+$P(RP(.3),U,9))
 . S LINE=$$PAD(8)_"Agency/Country: "_$S(X]"":X,1:RPU)
 . S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 ;
 S LINE=$$PAD(4)_"Other Elig Code(s): "
 S I1=0,SPS="",$P(SPS,SP,25)=""
 F I=0:0 S I=$O(^DPT("AEL",DFN,I)) Q:'I  D
 . S X=$$EXTERNAL^DILFD(2,.361,"",I)
 . I X]"",I'=RPE D
 . . S I1=I1+1
 . . I I1>1 S LINE=SPS_X
 . . E  S LINE=LINE_X
 . . S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 I 'I1 D
 . S LINE=LINE_"NO ADDITIONAL ELIGIBILITIES IDENTIFIED"
 . S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 ;
 S RPX=+$P(RP(.32),U,3)
 S LINE=$$PAD(5)_"Period of Service: "_$S(RPX:$$EXTERNAL^DILFD(2,.323,"",RPX),1:RPU)
 S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 ;
 I $$ODS(DFN) D  ;ODS system on
 . S RPX=$G(^DPT(DFN,"ODS"))
 . S LINE=$$PAD(6)_"Recalled to Duty: "
 . S LINE=LINE_$S($P(RPX,U,2)=1:"FROM NATIONAL GUARDS",$P(RPX,U,2)=2:"FROM RESERVES",$P(RPX,U,2)=0:"NO",1:RPU)
 . S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 . ;
 . S LINE=$$PAD(18)_"Rank: "_$S(+$P(RPX,U,3):$$EXTERNAL^DILFD(2,11500.03,"",$P(RPX,U,3)),1:RPU)
 . S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 ;
 ;Combat Vet Eligibility
 S SHAD=$P(RP(.321),U,15) ;SHAD Indicator
 S CV=$$CVEDT(DFN)
 I +$G(CV)=1 D
 . S LINE="<3.1> Combat Vet Elig.: "_$S($P(CV,U,3)=1:"ELIGIBLE",$P(CV,U,3)=0:"EXPIRED",1:"")
 . I $P($G(CV),U,2)]"" D
 . . S Y=$$FMTE^XLFDT($P(CV,U,2))
 . . S LINE=LINE_$$PAD(1)_"End Date: "_Y
 . I SHAD=1 D
 . . S LINE=LINE_$$PAD(55-$L(LINE))_"<3.2>Proj 112/SHAD: YES"
 . S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 I (+$G(CV)'=1)&(SHAD=1) D
 . S LINE=$$PAD(55)_"<3.2>Proj 112/SHAD: YES"
 . S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 ;
 ;Service connected conditions
 S LINE="",LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE ;blank line
 S Z=4,LINE=$$WW(Z)_" Service Connected Conditions as stated by applicant"
 S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 S X="",$P(X,"-",52)=""
 S SPS=$$PAD(4)
 S LINE=SPS_X
 S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 S LINE=SPS
 S (I,I3,LEN)=0
 F  S I=$O(^DPT(DFN,.373,I)) Q:'I  D
 . N I373
 . S I373=^DPT(DFN,.373,I,0)
 . S I1=$P(I373,U)_" ("_+$P(I373,U,2)_"%), "
 . S I3=I
 . I $L(LINE)+$L(I1)>MAXLEN D
 . . S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 . . S LINE=SPS_I1
 . E  D
 . . S LINE=LINE_I1
 I 'I3 D
 . S LINE=LINE_"NONE STATED"
 . S LC=LC+1,^TMP($J,"BPSELST",LC,0)=LINE
 ;
 D UPDATE^BPSVRX($NA(^TMP($J,"BPSELST")),"","","View Registration Eligibility Status",BPSSNUM)
 K ^TMP($J,"BPSELST")
DGELSTX ;
 Q
 ;
DGELV(RXIEN,FILL,VIEWTYPE,BPSSNUM) ; View Registration Eligibility Verification screen
 N LC,SP,MAXLEN,DFN,PAT,X,RPTYPE,X1,SPS,RPU,I,RP,Z,RPX,Z1,RPVR,Y,RPNA,STATID,VMETH
 N EC,EFF,I3,ARR,AI,IVC,VA200,LINE
 I '$D(ZTQUEUED) W !,"Compiling data for View Registration Eligibility Verification ... "
 K ^TMP($J,"BPSELV")
 S LC=0,SP=" ",MAXLEN=80
 S DFN=+$$RXAPI1^BPSUTIL1(RXIEN,2,"I")
 F I=.3,.32,.36,.361,"TYPE","VET" S RP(I)=$G(^DPT(DFN,I))
 S PAT=$$SSNNM(DFN)
 S RPTYPE="PATIENT TYPE UNKNOWN"
 I RP("TYPE")]"" D
 . S RPTYPE=$$GET1^DIQ(391,RP("TYPE"),.01,"I")
 S X1=MAXLEN-($L(PAT)+$L(RPTYPE))
 S LC=LC+1,^TMP($J,"BPSELV",LC,0)=PAT_$$PAD(X1-1)_RPTYPE
 S X="",$P(X,"=",MAXLEN)="",RPU="UNANSWERED",RPNA="NOT APPLICABLE"
 S LC=LC+1,^TMP($J,"BPSELV",LC,0)=X
 ; section 1
 S Z=1,Z1=28,LINE=$$WW(Z)_" Eligibility Status: "
 S RPX=RP(.361)
 S X=$P(RPX,U),Z=$S(X']"":"NOT VERIFIED",X="V":"VERIFIED",X="R":"PENDING RE-VERIFICATION",1:"PENDING VERIFICATION")
 S LINE=LINE_Z_$$PAD(Z1-$L(Z))_"Status Date: "
 S RPVR=$S(X]"":1,1:0)
 S Y=$P(RPX,U,2) I Y]"" S Y=$$FMTE^XLFDT(Y)
 S LINE=LINE_$S(Y]"":Y,RPVR:RPU,1:RPNA)
 S LC=LC+1,^TMP($J,"BPSELV",LC,0)=LINE
 ;
 S STATID=+$P(RPX,U,6)
 S LINE=$$PAD(5)_"Status Entered By: "
 S VA200=$$GET1^DIQ(200,STATID,.01,"I")
 S LINE=LINE_$S(VA200]"":VA200_" (#"_STATID_")",RPVR:RPU,1:RPNA)
 S LC=LC+1,^TMP($J,"BPSELV",LC,0)=LINE
 ;
 S LINE=$$PAD(6)_"Interim Response: "
 S Y=$P(RPX,U,4) I Y]"" S Y=$$FMTE^XLFDT(Y)
 S LINE=LINE_$S(Y]"":Y,1:RPU_" (NOT REQUIRED)")
 S LC=LC+1,^TMP($J,"BPSELV",LC,0)=LINE
 ;
 S SPS=$$PAD(9)
 S VMETH=$P(RPX,U,5)
 S LINE=SPS_"Verif. Method: "_$S(VMETH]"":VMETH,RPVR:RPU,1:RPNA)
 S LC=LC+1,^TMP($J,"BPSELV",LC,0)=LINE
 ;
 ; SPS same as above
 S LINE=SPS_"Verif. Source: "_$S($P(RPX,U,3)="H":"HEC",$P(RPX,U,3)="V":"VISTA",1:"NOT AVAILABLE")
 S LC=LC+1,^TMP($J,"BPSELV",LC,0)=LINE
 ;
 S Z=2,LINE=$$WW(Z)_$$PAD(5)_"Money Verified: "
 S Y=$P(RP(.3),U,6) I Y]"" S Y=$$FMTE^XLFDT(Y)
 S LINE=LINE_$S(Y]"":Y,1:"NOT VERIFIED")
 S LC=LC+1,^TMP($J,"BPSELV",LC,0)=LINE
 ;
 S Z=3,LINE=$$WW(Z)_$$PAD(3)_"Service Verified: "
 S Y=$P(RP(.32),U,2) I Y]"" S Y=$$FMTE^XLFDT(Y)
 S LINE=LINE_$S(Y]"":Y,1:"NOT VERIFIED")
 S LC=LC+1,^TMP($J,"BPSELV",LC,0)=LINE
 ;
 S SPS=$$PAD(1)
 S Z=4,LINE=$$WW(Z)_SPS_"Rated Disabilities: "
 S IVC=$$GET1^DIQ(391,+RP("TYPE"),.02,"I")
 I $P(RP("VET"),U)'="Y",$S(IVC="":1,IVC:0,1:1) D  Q
 . S LINE=LINE_RPNA_" - NOT A VETERAN"
 . S LC=LC+1,^TMP($J,"BPSELV",LC,0)=LINE
 . D ELVSTOR($NA(^TMP($J,"BPSELV")),BPSSNUM)
 ; implied else continues here
 S EC=$P(RP(.36),U)
 I EC S EC=$$GET1^DIQ(8,EC,.01,"I")
 S LINE=LINE_SPS_"SC%: "_$S(EC="NSC":"",$P(RP(.3),U,2)="":"",1:$P(RP(.3),U,2))
 S EFF=$P(RP(.3),U,14)
 I EFF]"" S Y=EFF S Y=$$FMTE^XLFDT(Y) S EFF=Y
 S LINE=LINE_$$PAD(4)_"EFF. DATE OF COMBINED SC%: "_EFF
 S LC=LC+1,^TMP($J,"BPSELV",LC,0)=LINE
 ;
 S LINE=$$PAD(55)_"Orig"
 S LINE=LINE_$$PAD(70-$L(LINE))_"Curr"
 S LC=LC+1,^TMP($J,"BPSELV",LC,0)=LINE
 ;
 S LINE=$$PAD(3)_"Rated Disability"
 S LINE=LINE_$$PAD(46-$L(LINE))_"Extr"
 S LINE=LINE_$$PAD(55-$L(LINE))_"Eff Dt"
 S LINE=LINE_$$PAD(70-$L(LINE))_"Eff Dt"
 S LC=LC+1,^TMP($J,"BPSELV",LC,0)=LINE
 ;
 I '$$RDIS^DGRPDB(DFN,.ARR) D  ;IA #4807
 . S LINE="NONE STATED"
 . S LC=LC+1,^TMP($J,"BPSELV",LC,0)=LINE
 E  D
 . S (I3,AI)=0
 . F  S AI=$O(ARR(AI)) Q:'AI  D
 . . S I3=I3+1
 . . N CURR,ORIG,BP0,BP1,BP2,BP4,BP5,BP6
 . . I $G(ARR(AI))']"" Q
 . . S BP1=$$EXTERNAL^DILFD(2.04,.01,"",+ARR(AI))
 . . I BP1="" Q
 . . S BP0=$$EXTERNAL^DILFD(2.04,3,"",$P(ARR(AI),U,3))
 . . S BP2="("_$S($P(ARR(AI),U,3)=1:$P(ARR(AI),U,2)_"% SC",$P(ARR(AI),U,3)]"":$P(ARR(AI),U,2)_"% NSC",1:"unspec")_")"
 . . S BP4=$P(ARR(AI),U,4),BP5=$P(ARR(AI),U,5),BP6=$P(ARR(AI),U,6)
 . . I BP5]"" S Y=BP5 S Y=$$FMTE^XLFDT(Y) S ORIG=Y
 . . I BP6]"" S Y=BP6 S Y=$$FMTE^XLFDT(Y) S CURR=Y
 . . S LINE=$G(BP0)_"-"_BP1_BP2
 . . S LINE=LINE_$$PAD(47-$L(LINE))_$G(BP4)
 . . S LINE=LINE_$$PAD(50-$L(LINE))_" - "
 . . S LINE=LINE_$$PAD(53-$L(LINE))_$G(ORIG)
 . . S LINE=LINE_$$PAD(64-$L(LINE))_" - "
 . . S LINE=LINE_$$PAD(68-$L(LINE))_$G(CURR)
 . . S LC=LC+1,^TMP($J,"BPSELV",LC,0)=LINE
 . I 'I3 D
 . . S LINE="NONE STATED"
 . . S LC=LC+1,^TMP($J,"BPSELV",LC,0)=LINE
 ;
 D ELVSTOR($NA(^TMP($J,"BPSELV")),BPSSNUM)
DGELVX ;
 Q
 ;
ELVSTOR(ARRNAME,BPSSNUM) ;
 D UPDATE^BPSVRX(ARRNAME,"","","View Registration Eligibility Verification",BPSSNUM)
 K @ARRNAME
 Q
 ;
SSNNM(DFN) ; SSN and name
 N X,SSN
 S X=$G(^DPT(+DFN,0))
 S SSN=$P(X,U,9),SSN=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,10)
 S X=$P(X,U)_"; "_SSN
 Q X
 ;
WW(Z) ;Write number on screens for display (Z=number)
 S Z="<"_Z_">"
 Q Z
 ;
WW1(Z,Z1) ;spacing for screen display (Z=item to print)
 N Z2
 F Z2=1:1:(Z1-$L(Z)) S Z=Z_" "
 Q Z
 ;
YN(X,RPX,Z1) ;
 N Z
 S Z=$S($P(RPX,U,X)="Y":"YES",$P(RPX,U,X)="N":"NO",$P(RPX,U,X)="U":"UNKNOWN",1:"UNANSWERED")
 Q $$WW1(Z,Z1)
 ;
YN2(NA,X,RPX,Z1,Z) ;
 S Z=$S(NA:"N/A",$P(RPX,U,X)="Y":"YES",$P(RPX,U,X)="N":"NO",$P(RPX,U,X)="U":"UNKNOWN",1:"UNANSWERED")
 Q $$WW1(Z,Z1)
 ;
YN3(N,P) ; code from YN2^DG1010P0
 ; Ext Val of YES/NO given node & piece.
 ;IN:  N  -- Val of Node
 ;     P  -- Piece
 ;OUT:[RETURN] -- Ext Val 
 S X=$P(N,U,P)
 Q $S((X="Y"):"YES",(X="N"):"NO",(X="U"):"UNKNOWN",(X=""):"UNANSWERED",("0"[X):"NO",("12"[X):"YES",("3"[X):"UNKNOWN",1:"INVALID")
 ;
DATENP(N,P,NA,BL) ;
 ; Returns External Value of Date in the Pth '^' piece of 'N'
 ; Output is modified by NA & BL as per $$UNK[see above]
 ; INPUT: 
 ; N     -- Contents of a node
 ; P     -- the Pth '^' piece
 ; NA,BL -- Optional output modifiers
 ; OUTPUT[Returned] --  X
 ; OUTPUT[Set]      -- DGUNK =1 if NA=1 or X=""
 N Y,UNK
 S Y=$$DISP(N,P,+$G(NA),$G(BL),.UNK)
 I 'UNK S Y=$$FMTE^XLFDT(Y)
 Q Y
 ;
DISP(N,P,NA,BL,UNK) ;
 ; Returns  the Pth '^' piece of 'N'
 ; Output is modified by NA & BL as per $$UNK[see above]
 ;   INPUT: N -- Contents of a node
 ;     P -- the Pth '^' piece
 ;     NA,BL -- Optional output modifiers
 ;   OUTPUT[Returned] --  X
 ;   OUTPUT[Set]       -- DGUNK =1 if NA=1 or X=""
 N X
 S X=$P($G(N),U,P)
 S UNK=$S($G(NA):1,(X]""):0,1:1)
 Q $S(($G(NA)):"NOT APPLICABLE",(X]""):X,($G(BL)):"",1:"UNANSWERED")
 ;
MBCK(X) ;flag for any MB Y/N fields = yes
 N MBCK
 S MBCK=$S($G(MBCK):1,(X="Y"):1,1:0)
 Q MBCK
 ;
CVEDT(DFN,TDT) ;Provide Combat Vet Eligibility End Date, if eligible
 ;Supported DBIA #4156
 ;Input:  DFN - Patient file IEN
 ;        TDT - Treatment date (optional), 
 ;               DT is default
 ;Output :RESULT=(1,0,-1)^End Date (if populated, otherwise null)^CV
 ;               Eligible on DGDT(1,0)^is patient eligible on input date?
 ;      (piece 1)  1 - qualifies as a CV
 ;                 0 - does not qualify as a CV
 ;                -1 - bad DFN or date
 ;      (piece 3)  1 - vet was eligible on date specified (or DT)      
 ;                 0 - vet was not eligible on date specified (or DT)
 ;
 N RESULT
 S RESULT=""
 I $G(DFN)="" Q -1
 I '$D(^DPT(DFN)) Q -1
 ;if time sent in, drop time
 I $G(TDT)']"" S TDT=DT
 I TDT?7N1"."1.6N S TDT=$E(TDT,1,7)
 I TDT'?7N Q -1
 S RESULT=$$GET1^DIQ(2,DFN_",",.5295,"I")
 I $G(RESULT)']"" Q 0
 ; if treatment date is earlier or equal to end date, veteran is eligible
 S RESULT=$S(TDT'>RESULT:RESULT_"^1",1:RESULT_"^0")
 S RESULT=$S($G(RESULT):1_U_RESULT,1:0)
 Q RESULT
 ;
ODS(DFN) ;ODS software check
 N ODS,POS
 S ODS=$$GET1^DIQ(11500.5,1,.02,"I")
 I 'ODS Q ODS
 S ODS=0
 I $D(^DPT(DFN,.32)) D
 . S POS=$$GET1^DIQ(2,DFN,.323,"I")
 . S:POS=6 ODS=1
 Q ODS
 ;
PAD(LEN) ; space padding function
 ; Input:
 ;   LEN (r) --> padding length
 ; Output:
 ;   A string of space characters
 ;
 N SPS,SP
 S SP=$C(32)
 S SPS="",$P(SPS,SP,LEN+1)=""
 Q SPS
 ;
