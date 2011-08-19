RAO7NEW ;HISC/FPT - Create entry in OE/RR Order file (100) ;11/16/98  15:10
 ;;5.0;Radiology/Nuclear Medicine;**5,10,18,41,75**;Mar 16, 1998 ;Build 4
 ;
 ; This routine invokes IA #1300-A, #2083, #10082
 ;last modification for P18 by SS July 5,2000
EN1(RAOIFN) ; 'RAOIFN' is the ien in file 75.1  
 ; In RA*5.0*18 this call is used when procedure CHANGED during registration, adding to visit and editing 
 ; New vars & define the following variables: RAECH, RAECH array & RAHLFS
 N A,B,DFN,RA,RA0,RACNT,RACPT,RADFN,RAECH,RAHL7DT,RAHLFS,RALOC,RANATURE
 N RAPRIOR,RAPROC,RAR,RARMBED,RATAB,RAVAR,RAWARD,RAXIT
 N RAORORDN,RAD70SB,RAORDCTR ;P18, OR Order No, "DT" of #70, Orderctrl,subscr of 70
 N RABWDX,RABWDX1 ; Billing Awareness Project.
 S RAORORDN="",RAD70SB=0,RAORDCTR="SN" ;P18, these sets mean that it's request mode (not the case, when procedure changed during registering or editing) 
 I $D(RAREGMOD) S RAORORDN=$P(^RAO(75.1,RAOIFN,0),"^",7)_"^OR",RAORDCTR="XX" ;P18,if register mode (see RAREG2 for EN1^RAO7XX)
 S RATAB=1 D EN1^RAO7UTL
 S RA0=$G(^RAO(75.1,RAOIFN,0)) Q:RA0']""
SS2 I RAORDCTR="XX" D UPDTRA0^RAO7XX ;P18, update RA0 with #70 inf, sets RAD70SB, that provide D2^D3 of #70
 S RADFN=+RA0,RAR=$G(^RAO(75.1,RAOIFN,"R"))
SS3 I RAORDCTR="XX",RAD70SB'=0 S RAR=$G(^RADPT(+RA0,"DT",$P(RAD70SB,"^",1),"P",$P(RAD70SB,"^",2),"R")) ;P18
 ;
 ;*Billing Awarenes Project:
 ;   Retrieve Ordering ICD Dx data to Send to CPRS.
 D SENDCPRS^RABWORD1(RAOIFN)
 ;*
 S RAVAR="RATMP(",RAVARBLE="RATMP"
 ; msh
 S @(RAVAR_RATAB_")")=$$MSH^RAO7UTL("ORM^O01") ;P18
 ; pid
 S RATAB=RATAB+1,@(RAVAR_RATAB_")")=$$PID^RAO7UTL(RA0)
 ; pv1
 S RATAB=RATAB+1,@(RAVAR_RATAB_")")=$$PV1^RAO7UTL(RA0)
 K RA("PV1"),VAIP,RABWVSIT
 ; orc
 S RAHL7DT=$$HLDATE^HLFNC($P(RA0,U,21),"TS"),RAPRIOR=$P(RA0,U,6)
 S RAPRIOR=$S(RAPRIOR=1:"S",RAPRIOR=2:"A",RAPRIOR=9:"R",1:"")
 S RA("ORC",7)="^^^"_RAHL7DT_"^^"_RAPRIOR
 S RA("ORC",10)=$P(RA0,U,15),RA("ORC",12)=$P(RA0,U,14)
 S RA("ORC",11)=$P(RA0,U,8) ;approving radiologist
 S RA("ORC",15)=$$HLDATE^HLFNC($P(RA0,"^",16),"TS")
 S RANATURE="" I $L($P(RA0,"^",26)) S RANATURE=$$UP^XLFSTR($P(RA0,"^",26))_RAECH(1)_$$EXTERNAL^DILFD(75.1,26,"",$P(RA0,"^",26))
 F I=1,2 I '$L($P(RANATURE,"^",I)) S RANATURE="S"_RAECH(1)_"SERVICE CORRECTION"
 K I S RA("ORC",16)=RANATURE_RAECH(1)_"99ORN"_RAECH(1)_RAECH(1)_RAECH(1)
 S RATAB=RATAB+1
 ;P18, next line was modified
SS4 S @(RAVAR_RATAB_")")="ORC"_RAHLFS_RAORDCTR_RAHLFS_RAORORDN_RAHLFS_RAOIFN_RAECH(1)_"RA"_$$STR^RAO7UTL(4)_RA("ORC",7)_$$STR^RAO7UTL(3)_RA("ORC",10)_RAHLFS_RA("ORC",11)_RAHLFS_RA("ORC",12)_$$STR^RAO7UTL(3)_RA("ORC",15)_RAHLFS_RA("ORC",16)
 K RA("ORC")
 ; obr
 S RAPROC(0)=$G(^RAMIS(71,+$P(RA0,U,2),0)),RAPROC(9)=+$P(RAPROC(0),U,9)
 S RACPT(0)=$$NAMCODE^RACPTMSC(RAPROC(9),DT)
 S RA("OBR",4)=$P(RACPT(0),U)_U_$P(RACPT(0),U,2)_U_"CPT4"_U_+$P(RA0,U,2)_U_$P(RAPROC(0),U)_"^99RAP"
 S RA("OBR",12)=""
 S:$P(RA0,U,24)]""&("Yy"[$P(RA0,U,24)) RA("OBR",12)="isolation"
 S RA("OBR",18)=""
SS5 I RAORDCTR="XX",RAD70SB'=0 D MODIF70^RAO7XX($P(RAD70SB,"^",1),$P(RAD70SB,"^",2))  G CONTIN ;P18 by SS
 I $O(^RAO(75.1,RAOIFN,"M",0)) D
 . S (A,RAXIT)=0
 . F  S A=$O(^RAO(75.1,RAOIFN,"M",A)) Q:A'>0  D  Q:RAXIT
 .. S B(0)=$G(^RAO(75.1,RAOIFN,"M",A,0))
 .. S B(1)=$P($G(^RAMIS(71.2,+B(0),0)),U)
 .. I $L(RA("OBR",18))+$L(B(1))>60 S RAXIT=1 Q
 .. S RA("OBR",18)=$G(RA("OBR",18))_B(1)_RAECH(2)
 .. Q
 . S RA("OBR",18)=$P(RA("OBR",18),RAECH(2),1,$L(RA("OBR",18),RAECH(2))-1)
 . Q
CONTIN S RALOC(0)=$G(^RA(79.1,+$P(RA0,U,20),0))
 S RA("OBR",19)=+$P(RA0,U,20)_U_$P($G(^SC(+RALOC(0),0)),U)
 S:+RA("OBR",19)'>0 RA("OBR",19)=""
 S RA("OBR",30)=$S($P(RA0,U,19)="":"","Aa"[$P(RA0,U,19):"WALK","Pp"[$P(RA0,U,19):"PORT","Ss"[$P(RA0,U,19):"CART","Ww"[$P(RA0,U,19):"WHLC",1:"")
 ;----- P75 REASON FOR STUDY OBR-31.2 -----
 S (RAREASDY,RA("OBR",31))=RAECH(1)_$P($G(^RAO(75.1,RAOIFN,.1)),U)
 S RA("OBRZ")="OBR"_$$STR^RAO7UTL(4)_RA("OBR",4)_$$STR^RAO7UTL(8)_RA("OBR",12)_$$STR^RAO7UTL(6)
 S RA("OBRZ")=RA("OBRZ")_RA("OBR",18)_RAHLFS_RA("OBR",19)_$$STR^RAO7UTL(11)_RA("OBR",30)_RAHLFS_RA("OBR",31)
 S RATAB=RATAB+1,@(RAVAR_RATAB_")")=RA("OBRZ")
 K RA("OBR"),RA("OBRZ")
 ; nte
SS1 I RAORDCTR="XX",RAD70SB'=0 D  ;P18 nte segment
 . N RA18Z S RA18Z=$$GETTCOM^RAUTL11(+RA0,$P(RAD70SB,"^",1),$P(RAD70SB,"^",2))
 . I RA18Z="" K RA18Z Q
 . S RATAB=RATAB+1,@(RAVAR_RATAB_")")="NTE"_RAHLFS_"16"_RAHLFS_"L"_RAHLFS_$E(RA18Z,1,245)
 . K RA18Z Q
 ; obx
 ;P18 next line was modified - Clinical History capture
 ;----- P75 modifications -----
 I '$$PATCH^XPDUTL("OR*3.0*243") D  ;Reason for Study captured & passed as Clinical History
 . S RACNT=1,RATAB=RATAB+1 ;set Set ID (RACNT) value at one (denotes Reason for Study)
 . S @(RAVAR_RATAB_")")="OBX"_RAHLFS_RACNT_RAHLFS_"TX"_RAHLFS_"2000.02^Clinical History^AS4"_RAHLFS_"1"_RAHLFS_"REASON FOR STUDY: "_RAREASDY
 . S RACNT=RACNT+1,RATAB=RATAB+1,$P(RABREAK,"-",($L("REASON FOR STUDY: "_RAREASDY)+1))=""
 . S @(RAVAR_RATAB_")")="OBX"_RAHLFS_RACNT_RAHLFS_"TX"_RAHLFS_"2000.02^Clinical History^AS4"_RAHLFS_"1"_RAHLFS_RABREAK
 . K RABREAK
 . Q
 E  S RACNT=0 ;OR*3.0*243 is installed, Reason for Study captured in OBR-31.2
 ;capture only clinical history data. Set ID starts at zero
SS6 S A=0 F  S A=$S(RAORDCTR="XX"&(RAD70SB'=0):$O(^RADPT(+RA0,"DT",$P(RAD70SB,"^",1),"P",$P(RAD70SB,"^",2),"H",A)),1:$O(^RAO(75.1,RAOIFN,"H",A))) Q:A'>0  D
SS7 . S RACNT=RACNT+1,RATAB=RATAB+1
 . ;P18 next line was modified
 . S @(RAVAR_RATAB_")")="OBX"_RAHLFS_RACNT_RAHLFS_"TX"_RAHLFS_"2000.02^Clinical History^AS4"_RAHLFS_"1"_RAHLFS_$S(RAORDCTR="XX"&(RAD70SB'=0):$G(^RADPT(+RA0,"DT",$P(RAD70SB,"^",1),"P",$P(RAD70SB,"^",2),"H",A,0)),1:$G(^RAO(75.1,RAOIFN,"H",A,0)))
 . Q
 S DFN=RADFN D DEM^VADPT
 I $P(VADM(5),U)]"",("Ff"[$P(VADM(5),U)) D
 . S RATAB=RATAB+1,RACNT=RACNT+1
 . S @(RAVAR_RATAB_")")="OBX"_RAHLFS_RACNT_RAHLFS_"TX"_RAHLFS_"2000.33^Pregnant^AS4"_$$STR^RAO7UTL(2)_$S($P(RA0,U,13)="":"","Yy"[$P(RA0,U,13):"Y","Nn"[$P(RA0,U,13):"N",1:"U")
 . Q
 I +$P(RA0,U,9) D
 . S RATAB=RATAB+1,RACNT=RACNT+1
 . S @(RAVAR_RATAB_")")="OBX"_RAHLFS_RACNT_RAHLFS_"CE"_RAHLFS_"34^Contract Sharing/Source^99DD"_$$STR^RAO7UTL(2)_$P(RA0,U,9)_RAECH(1)_$P($G(^DIC(34,+$P(RA0,U,9),0)),U)
 . Q
 I RAR]"" D
 . S RATAB=RATAB+1,RACNT=RACNT+1
 . S @(RAVAR_RATAB_")")="OBX"_RAHLFS_RACNT_RAHLFS_"TX"_RAHLFS_"^Research Source^"_$$STR^RAO7UTL(2)_RAR
 . Q
 I +$P(RA0,U,12) D
 . S RATAB=RATAB+1,RACNT=RACNT+1
 . S @(RAVAR_RATAB_")")="OBX"_RAHLFS_RACNT_RAHLFS_"TS"_RAHLFS_"^Pre Op Scheduled Date/Time^"_$$STR^RAO7UTL(2)_$$HLDATE^HLFNC($P(RA0,U,12),"TS")
 . Q
 ; DG1 Segment
 ;*Billing Awareness Project:
 ;   Send Ordering ICD Dx data to CPRS: DG1 and related ZCL segments.
 I $D(RABWDX1) D
 . N RA1 S RA1=""
 . F  S RA1=$O(RABWDX1(RA1)) Q:RA1=""  D
 .. S RATAB=RATAB+1,RACNT=RACNT+1
 .. S @(RAVAR_RATAB_")")=RABWDX1(RA1)
 . Q
 ;*
 K RAREASDY,VA,VADM,VAERR D MSG^RAO7UTL("RA EVSEND OR",.@RAVARBLE)
 Q
