FBAAV5 ;AISC/GRR-CREATE TRANSACTIONS FOR CH/CNH PAYMENTS ;11 Apr 2006  2:54 PM
 ;;3.5;FEE BASIS;**3,55,89,98,116,108**;JAN 30, 1995;Build 115
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 D CKB9V^FBAAV01 I $G(FBERR) K FBERR Q
 G:FBSTAT="S"&(FBCHB="Y")&($P(Y(0),"^",18)'="Y") ^FBAAV6
DETCH S FBTXT=0
 ; HIPAA 5010 - line items that have 0.00 amount paid are now required to go to Central Fee
 ;F K=0:0 S K=$O(^FBAAI("AC",J,K)) Q:K'>0  S Y(0)=$G(^FBAAI(K,0)),Y(2)=$G(^(2)) I Y(0)]"",+$P(Y(0),U,9) D
 F K=0:0 S K=$O(^FBAAI("AC",J,K)) Q:K'>0  S Y(0)=$G(^FBAAI(K,0)),Y(2)=$G(^(2)),Y(5)=$G(^(5)) I Y(0)]"" D
 .N FBPICN,FBY
 .S FBPICN=K
 .S FBY=$S($P(Y(2),U,2):$P(Y(2),U,2),1:$P(Y(0),U,2))_U_+$P(Y(2),U,3)
 .I 'FBTXT S FBTXT=1 D NEWMSG^FBAAV01,STORE^FBAAV01,UPD^FBAAV0
 .D GOT
 D:FBTXT XMIT^FBAAV01 Q
GOT ; process an inpatient invoice
 N DFN,FBADJ,FBADJA,FBADJR,FBADMIT,FBAUTHF,FBCDAYS,FBDISDT,FBDISTY,FBNPI
 N FBDRG,FBIENS,FBPA,FBPNAMX,FBVMID,FBX
 N FB4LN,FBADMTDX,FBCSVDT,FBCSID,FBEDIF,FBCNTRN
 S FBIENS=K_","
 S FBCSVDT=$$FRDTINV^FBCSV1(K)
 I '$L($G(FBAASN)) D STATION^FBAAUTL
 S FBPSA=$$PSA(+$P(Y(0),U,20),+$G(FBAASN)) I $L(+FBPSA)'=3 S FBPSA=999
 S FBPAYT=$P(Y(0),"^",13),FBPAYT=$S(FBPAYT]"":FBPAYT,1:"V")
 S L=$P(Y(0),"^",3)
 S FBVID=$S($D(^FBAAV(L,0)):$P(^(0),"^",2),1:"")
 S FBNPI=$$EN^FBNPILK(L)
 S FBVID=FBVID_$E(PAD,$L(FBVID)+1,11)
 S:FBPAYT="R" FBVID=$E(PAD,1,11)
 S FBVMID=$S($D(^FBAAV(L,0)):$P(^(0),"^",17),1:"")
 S FBVMID=$E(PAD,$L(FBVMID)+1,6)_FBVMID
 S POV=$P(Y(0),"^",18)
 S POV=$S(POV']"":"",POV="A":6,POV="B":7,POV="C":8,POV="D":9,POV="E":10,1:POV),POV=$S(POV']"":40,$D(^FBAA(161.82,POV,0)):$P(^(0),"^",3),1:40),FBPOV=POV
 S FBPATT=$P(Y(0),"^",19),FBPATT=$S(FBPATT]"":FBPATT,1:10)
 S FBFTD=$$AUSDT^FBAAV3($P(Y(0),"^",6)) ; from treatment date
 S FBTTD=$$AUSDT^FBAAV3($P(Y(0),"^",7)) ; to treatment date
 S FBSUSP=$P(Y(0),"^",11),FBSUSP=$S(FBSUSP="":" ",$D(^FBAA(161.27,FBSUSP,0)):$P(^(0),"^",1),1:" ")
 S FBINVN=$P(Y(0),"^",1)
 S FBINVN=$E("000000000",$L(FBINVN)+1,9)_FBINVN
 S FBDIN=$$AUSDT^FBAAV3($P(Y(0),"^",2)) ; invoice date rec'd
 S FBAP=$$AUSAMT^FBAAV3($P(Y(0),"^",9),9)
 S FBAC=$$AUSAMT^FBAAV3($P(Y(0),"^",8),9)
 S FBPA=$$AUSAMT^FBAAV3($P(Y(0),"^",26),9)
 S FBDRG=$P(Y(0),"^",24),FBDRG=$E(PAD,$L(FBDRG)+1,4)_FBDRG
 S FBAUTHF=$S($P(Y(0),U,5)["FB583":"U",1:"A") ; auth/unauth flag
 S FBCSID=$$LJ^XLFSTR($P(Y(2),"^",11),20," ") ; patient acct #
 S FBADMTDX=$P(Y(5),"^",9) ; admitting Dx pointer
 D
 . N FBCNTRP
 . S FBCNTRP=$P(Y(5),"^",8)
 . S FBCNTRN=$S(FBCNTRP:$P($G(^FBAA(161.43,FBCNTRP,0)),"^"),1:"")
 . S FBCNTRN=$$LJ^XLFSTR(FBCNTRN,20," ") ; contract number
 S FBEDIF=$S($P($G(^FBAAI(K,3)),"^")]"":"Y",1:" ") ;EDI flag
 ;
 K FBDX
 S FBDX(0)="       " ; initialize admitting Dx transmitted value to 7 spaces
 F M=1:1:25 S FBDX(M)="        "  ;8 spaces
 I FBADMTDX D
 . N FBX
 . S FBX=$$ICD9^FBCSV1(FBADMTDX,FBCSVDT)
 . Q:FBX=""
 . S FBDX(0)=FBX_$E("       ",$L(FBX)+1,7)
 S FBYDX=$G(^FBAAI(K,"DX")),FBYPOA=$G(^FBAAI(K,"POA"))
 F M=1:1:25 Q:$P(FBYDX,"^",M)=""  D
 . S FBDX(M)=$$DX($P(FBYDX,"^",M),FBCSVDT,$P(FBYPOA,"^",M))
 K FBYDX,FBYPOA
 ;
 K FBPRC
 F M=1:1:25 S FBPRC(M)="       "  ;7 SPACES
 S FBYPROC=$G(^FBAAI(K,"PROC"))
 F M=1:1:25 Q:$P(FBYPROC,"^",M)=""  D
 . S FBPRC(M)=$$PROC($P(FBYPROC,"^",M),FBCSVDT)
 K FBYPROC
 ;
 S DFN=$P(Y(0),"^",4)
 ; Note: Prior to the following line Y(0) = the 0 node of file 162.5
 ;After the line Y(0) will equal the 0 node of file #2
 S VAPA("P")="",Y(0)=$S($D(^DPT(DFN,0)):^(0),1:"")
 D PAT^FBAAUTL2
 ; obtain date of birth, must follow call to PAT^FBAAUTL2 to overwrite 
 ; the value returned from it
 S FBDOB=$$AUSDT^FBAAV3($P(Y(0),"^",3))
 D ADD^VADPT
 S FBPNAMX=$$HL7NAME^FBAAV2(DFN) ; patient name
 S FBST=$S($P(VAPA(5),"^",1)="":"  ",$D(^DIC(5,$P(VAPA(5),"^",1),0)):$P(^(0),"^",2),1:"  ")
 I $L(FBST)>2 S FBST="**"
 S:$L(FBST)'=2 FBST=$E(PAD,$L(FBST)+1,2)_FBST
 S FBCTY=$S($P(VAPA(7),"^",1)="":"   ",FBST="  ":"   ",$D(^DIC(5,$P(VAPA(5),"^",1),1,$P(VAPA(7),"^",1),0)):$P(^(0),"^",3),1:"   ")
 I $L(FBCTY)'=3 S FBCTY=$E("000",$L(FBCTY)+1,3)_FBCTY
 S FBZIP=$S('+$G(VAPA(11)):VAPA(6),+VAPA(11):$P(VAPA(11),U),1:VAPA(6)),FBZIP=$TR(FBZIP,"-","")_$E("000000000",$L(FBZIP)+1,9)
 S FBADMIT=$$AUSDT^FBAAV3($P($$B9ADMIT(FBIENS),".")) ; admission date
 ; get and format discharge date and type
 S FBX=$$B9DISCHG(FBIENS)
 S FBDISDT=$$AUSDT^FBAAV3($P($P(FBX,U),".")) ; discharge date
 S FBDISTY=$$RJ^XLFSTR($P(FBX,U,2),3,0) ; discharge type
 K FBX
 ; get volume indicator (covered days)
 S FBCDAYS=$$RJ^XLFSTR($$GET1^DIQ(162.5,FBIENS,54),5,"0")
 ; obtain and format the adjustment codes and amounts
 ; get and format adjustment reason codes and amounts (if any)
 D LOADADJ^FBCHFA(FBIENS,.FBADJ)
 S FBX=$$ADJL^FBUTL2(.FBADJ)
 S FBADJR=$$RJ^XLFSTR($P(FBX,U,1),5," ")
 S FBADJA=$$AUSAMT^FBAAV3($P(FBX,U,3),10,1)
 K FBADJ,FBX
 ;
 ; determine if 4th line needed (set FB4LN =1 when true)
 S FB4LN=1 I FBDX(11)="        ",FBPRC(11)="       " S FB4LN=0
 ;
 ; build 1st line
 S FBSTR=9_FBAASN_FBSSN_FBPAYT_FBPNAMX_FBVID_"  "_FBAP_FBAAON_FBSUSP
 S FBSTR=FBSTR_FBPOV_FBPATT_FBFTD_FBTTD_FBDIN_FBINVN_FBVMID
 S FBSTR=FBSTR_$E(PAD,1,33)_FBST_FBCTY_FBZIP ; reserved for foreign addr
 S FBSTR=FBSTR_FBPSA_$P(FBY,U,2)_$E(PAD,1,14)
 F I=1:1:5 S FBSTR=FBSTR_FBDX(I)
 S FBSTR=FBSTR_"~"
 D STORE^FBAAV01
 ;
 ; build 2nd line
 S FBSTR=$$PADZ^FBAAV01(FBPICN,23)_$$AUSDT^FBAAV3(+FBY)
 F I=1:1:5 S FBSTR=FBSTR_FBPRC(I)
 S FBSTR=FBSTR_FBAC_FBPA_FBDRG_" "_FBADMIT_FBDISDT_FBDOB_FBDISTY_FBCDAYS_FBAUTHF_FBADJR_FBADJA_FBNPI_FBDX(0)_FBCSID_FBEDIF_FBCNTRN
 S FBSTR=FBSTR_$E(PAD,1,32)_"~" ; reserved for IPAC data
 D STORE^FBAAV01
 ;
 ; build 3rd line
 S FBSTR=""
 F I=6:1:10 S FBSTR=FBSTR_FBDX(I)
 F I=6:1:10 S FBSTR=FBSTR_FBPRC(I)
 S FBSTR=FBSTR_"~"
 S:'FB4LN FBSTR=FBSTR_"$"
 D STORE^FBAAV01
 ;
 ; build 4th line (if needed)
 I FB4LN D
 . S FBSTR=""
 . F I=11:1:25 S FBSTR=FBSTR_FBDX(I)
 . F I=11:1:25 S FBSTR=FBSTR_FBPRC(I)
 . S FBSTR=FBSTR_"~$"
 . D STORE^FBAAV01
 Q
 ;
PSA(X,Y) ;call to set default Primary Service Area (PSA)
 ;to send to Austin.
 ;X = pointer to the institution file
 ;Y = default if unable to determine station number in file 4
 ;call returns the 3 digit station number only
 ;if Y undef return '0'
 I '$G(Y) S Y=0
 Q $S('X:+Y,$E($P($G(^DIC(4,+X,99)),U),1,3)'?3N:+Y,1:$E($P($G(^(99)),U),1,3))
 ;
B9ADMIT(FBIENS) ; Determine Admission Date for a B9 payment
 ; input
 ;   FBIENS
 ; returns admission date in internal FileMan format or null value
 N FB7078,FBRET
 S FBRET=""  ;NULL
 ;
 S FB7078=$$GET1^DIQ(162.5,FBIENS,4,"I") ; associated 7078/583
 ;
 ; if invoice points to a 7078 authorization then get date from the 7078
 I $P(FB7078,";",2)="FB7078(" D
 . N FBY
 . S FBY=$G(^FB7078(+FB7078,0))
 . ; if fee program is civil hospital then return 7078 date of admission
 . I $P(FBY,U,11)=6 S FBRET=$P(FBY,U,15)
 . ; if fee program is CNH then return 7078 authorized from date
 . I $P(FBY,U,11)=7 S FBRET=$P(FBY,U,4)
 ;
 ; if invoice points to an unauthorized claim then use the treatment from
 ;   date on the unauthorized claim
 I $P(FB7078,";",2)="FB583(" D
 . N FBY
 . S FBY=$G(^FB583(+FB7078,0))
 . S FBRET=$P(FBY,U,5)
 ;
 ; return the result
 Q FBRET
 ;
B9DISCHG(FBIENS) ; Determine Discharge Date and Type for a B9 payment
 ; input
 ;   FBIENS - Invoice IEN (file 162.5) with trailing comma
 ; returns discharge date in internal FileMan format or null value and
 ; discharge type or null value
 N FB7078,FBDISDT,FBDISTY
 S (FBDISDT,FBDISTY)=""
 ;
 S FB7078=$$GET1^DIQ(162.5,FBIENS,4,"I") ; associated 7078/583
 ;
 ; if invoice points to an unauthorized claim then use the treatment to
 ;   date on the unauthorized claim
 I $P(FB7078,";",2)="FB583(" D
 . N FBY
 . S FBY=$G(^FB583(+FB7078,0))
 . S FBDISDT=$P(FBY,U,6)
 . S FBDISTY=$$GET1^DIQ(162.5,FBIENS,"6.5:1") ; discharge type
 ;
 ; if invoice points to a 7078 authorization then get date from the 7078
 I $P(FB7078,";",2)="FB7078(" D
 . N FBY
 . S FBY=$G(^FB7078(+FB7078,0))
 . ;
 . ; if fee program is civil hospital then return 7078 date of discharge
 . I $P(FBY,U,11)=6 D
 . . S FBDISDT=$P(FBY,U,16) ; discharge date
 . . S FBDISTY=$$GET1^DIQ(162.5,FBIENS,"6.5:1") ; discharge type
 . ;
 . ; if fee program is CNH then get date & type from CNH activity file
 . I $P(FBY,U,11)=7 D
 . . N DFN,FBADMIT,FBADMITR,FBACTA,FBAUTHP,FBDA,FBDTR
 . . S DFN=$P(FBY,U,3) ; patient IEN
 . . S FBADMIT=$P($P(FBY,U,4),".") ; CNH admission date
 . . S FBAUTHP=+$O(^FBAAA("AG",FB7078,DFN,0)) ; authorization 'pointer'
 . . ;
 . . ; find the admission entry in CNH ACTIVITY file   
 . . S FBACTA=0 ; init the admission activity ien
 . . S FBADMITR=9999999-FBADMIT ; reverse admission date
 . . S FBDTR=9999999-$$FMADD^XLFDT(FBADMIT,1) ; start loop
 . . F  S FBDTR=$O(^FBAACNH("AF",DFN,FBDTR)) Q:'FBDTR!($P(FBDTR,".")>FBADMITR)  D  Q:FBACTA
 . . . S FBDA=0 F  S FBDA=$O(^FBAACNH("AF",DFN,FBDTR,FBDA)) Q:'FBDA  D
 . . . . S FBY=$G(^FBAACNH(FBDA,0))
 . . . . I $P(FBY,U,3)="A",$P(FBY,U,10)=FBAUTHP S FBACTA=FBDA ; found it
 . . Q:'FBACTA  ; could not find the admission activity
 . . ;
 . . ; get date from associated discharge (if any) in CNH ACTIVITY file
 . . S FBDA=" "
 . . F  S FBDA=$O(^FBAACNH("AC",FBACTA,FBDA),-1) Q:FBDA'>0  D  Q:FBDISDT
 . . . S FBY=$G(^FBAACNH(FBDA,0))
 . . . I $P(FBY,U,3)="D" D
 . . . . S FBDISDT=$P($P(FBY,U),".")
 . . . . S FBDISTY=$P(FBY,U,8)
 . . . . I FBDISTY'="" S FBDISTY=FBDISTY+100
 ;
 ; return the result
 Q FBDISDT_"^"_FBDISTY
 ;
DX(FBDX,FBDATE,FBPOA) ; format diagnosis & POA for B9
 ; Input
 ;   FBDX   = pointer to file 80 (ICD diagnosis)
 ;   FBDATE = fileman date
 ;   FBPOA  = (optional) poiner to file 161.94 (present on admission)
 ; Returns formatted string of 8 characters
 N FBRET,FBX,FBX2
 S FBRET="        "
 I FBDX D
 . S FBX=$$ICD9^FBCSV1(FBDX,FBDATE)
 . Q:FBX=""
 . S FBX=FBX_$E("       ",$L(FBX)+1,7)
 . S FBX2=$S($G(FBPOA):$P($G(^FB(161.94,FBPOA,0)),"^"),1:"")
 . S:FBX2="" FBX2=" "
 . S FBRET=FBX_FBX2
 Q FBRET
 ;
PROC(FBPROC,FBDATE) ; format procedure for B9
 ; Input
 ;   FBPROC = pointer to file 80.1 (ICD operation/procedure)
 ;   FBDATE = fileman date
 ; Returns formatted string of 7 characters
 N FBRET,FBX
 S FBRET="       "
 I FBPROC D
 . S FBX=$$ICD0^FBCSV1(FBPROC,FBDATE)
 . Q:FBX=""
 . S FBX=FBX_$E("       ",$L(FBX)+1,7)
 . S FBRET=FBX
 Q FBRET
 ;
 ;FBAAV5
