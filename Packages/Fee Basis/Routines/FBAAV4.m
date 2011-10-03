FBAAV4 ;AISC/GRR-ELECTRONICALLY TRANSMIT PATIENT MRA'S ;12/16/2003
 ;;3.5;FEE BASIS;**13,34,37,70**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;D STATION^FBAAUTL,HD^FBAAUTL Q:$D(FB("ERROR"))
 S FBTXT=0,ZMCNT=1 ;FBTXT , ZMCNT 
GO S J=0 F  S J=$O(^FBAA(161.26,"AC","P",J)) Q:J'>0  S FB0=$G(^FBAA(161.26,J,0)) I $P(FB0,U) S Y(0)=$G(^DPT($P(FB0,U),0)) I Y(0)]"" S FBTYPE=$S($P(FB0,U,4)]"":$P(FB0,U,4),1:"A"),FBFDC=$P(FB0,U,6),FBMST=$P(FB0,U,7) D
 .; GETBT-prepare header 
 .; NEWMSG^FBAAV01-get new message number, reset line counter, set subject line 
 .; STORE^FBAAV01- increment line counter and store in ^XMB
 .; FBLN -line counter; FBFEE- "FEE message" counter; FBOKTX=1 if message pending, 0 otherwise
 .I 'FBTXT S FBTXT=1 D GETBT,NEWMSG^FBAAV01,STORE^FBAAV01
 .; prepare and store patient MRA portion (can be more than 1)
 .D GOT
 D:+$G(FBOKTX) XMIT^FBAAV01
 Q
 ;GETBT - prepare the "header" of the message 
GETBT D GETNXB^FBAAUTL ;get next batch # in FBBN
 S FBZBN=$E("00000",$L(FBBN)+1,5)_FBBN,FBSN=FBSN_$E("      ",$L(FBSN)+1,6)
 S FBSTR=FBHD_"C2"_$E(DT,4,7)_$E(DT,2,3)_FBSN_FBZBN_"$"
 Q
 ; 
GOT ;patient MRA portion of the message
 N FBCCFLG,FBPATICN,FB2NDSTR
 ; patient info;input:Y(0);output:FBDOB,FBFI,FBFLNAM,FBLNAM,FBMI,FBNAME,FBSEX,FBSSN
 D PAT^FBAAUTL2
 S DFN=$P(FB0,U)
 S FBFLNAM=$$HL7NAME(DFN),FBFI="",FBMI="" ;name (FBFI,FBMI - obsolete)
 ; demographic info, output:VADM
 D DEM^VADPT Q:$G(VAERR)
 S FBBD=$P(VADM(3),"^"),FBBD=$E(FBBD,4,7)_$E(FBBD,2,3) ;DOB
 S FBBD=$S(FBBD="":"      ",1:FBBD),FBSEX=$P(VADM(5),"^"),FBSEX=$S(FBSEX="F":2,1:1)
 S DOD=$P($P(VADM(6),"^"),".") ;DOD
 K VADM,VAERR
 ;S Y(0)=$S($D(^DPT(DFN,.11)):^(.11),1:"") Q:Y(0)']""
 ;S FBADD=$E($P(Y(0),"^",1),1,21),FBADD=FBADD_$E(PAD,$L(FBADD)+1,21),FBCITY=$E($P(Y(0),"^",4),1,13),FBCITY=FBCITY_$E(PAD,$L(FBCITY)+1,13),FBSTAT="  "
 ;S STCD=$P(Y(0),"^",5) I STCD]"" S FBSTAT=$S($D(^DIC(5,STCD,0)):$P(^(0),"^",2),1:"  ")
 ;
 ;address info, output: VAPA()
 S VAPA("P")="" D ADD^VADPT Q:$G(VAERR)
 S FBADD=$$LRJ($G(VAPA(1)),35)_$$LRJ($G(VAPA(2)),35)_$$LRJ($G(VAPA(3)),35) ;street address
 S FBCITY=$$LRJ($G(VAPA(4)),30) ;city
 S STCD=+VAPA(5) I STCD S FBSTAT=$S($D(^DIC(5,STCD,0)):$P(^(0),"^",2),1:"  ") ;state
 S FBZIP=$S('+$G(VAPA(11)):VAPA(6),+VAPA(11):$P(VAPA(11),"^"),1:VAPA(6)) ;zip
 ;check for Confidential Communication (CC) address
 S FBCCFLG=0 I 'VAERR S FBCCFLG=$$SENDCC()
 S FB2NDSTR=$$SECLINE()
 S FBZIP=$TR(FBZIP,"-","")_$E("000000000",$L(FBZIP)+1,9)
 S STCC=+VAPA(7),FBCC="000" I STCC,STCD S FBCC=$S($D(^DIC(5,STCD,1,STCC,0)):$P(^(0),"^",3),1:"000") ;county code
 K VAPA,VAERR
 ;
 ; eligibility, output:VAEL()
 D ELIG^VADPT
 S POS=$S(+VAEL(2):+VAEL(2),1:"") ;PERIOD OF SERVICE
 K VAEL,VAERR
 S POS=$S(POS="":8,$D(^DIC(21,POS,0)):$P(^(0),"^",3),1:8) ;default: 8 (POST-VIETNAM)
 S DOD=$S(DOD="":"000000",1:$E(DOD,4,7)_$E(DOD,2,3))
 ;
 ; service information
 D SVC^VADPT
 S POW=$S(+VASV(4):+VASV(4),1:""),POW=$S(POW="":2,POW=1:1,1:2) ;if prisoner of war
 ;
 ; remove all variables defined by VADPT
 D KVAR^VADPT
 ;
 ;using pointer FEE BASIS PATIENT MRA file retrieve info from 
 ;FEE BASIS PATIENT file#161, from its authorization multiple ^FBAAA(DA(1),1,DA
 S FBAUTH=$P(^FBAA(161.26,J,0),"^",3) Q:FBAUTH']""  Q:'$D(^FBAAA(DFN,1,FBAUTH,0))  S Y(0)=^(0)
 ;authorisation FROM
 S FBFR=$P(Y(0),"^")
 ;authorisation TO
 S FBTO=$P(Y(0),"^",2)
 ;PURPOSE OF VISIT
 S POV=$P(Y(0),"^",7),POV=$S(POV="":"",$D(^FBAA(161.82,POV,0)):$P(^(0),"^",3),1:""),POV=$S(POV]"":POV,1:"05")
 ;TREATMENT TYPE CODE (SHORT TERM,HOME NURSING,I.D. CARD,STATE HOME)
 S FBTT=$P(Y(0),"^",13),FBTT=$S(FBTT]"":FBTT,1:1)
 ;
 S FBRECT=$S(FBTT=4:"7",FBTT=2:"S",$G(POV)>29&($G(POV)<50):"C",1:2)
 ;formatting FORM and TO dates
 S FBFR=$E(FBFR,4,7)_$E(FBFR,2,3),FBTO=$E(FBTO,4,7)_$E(FBTO,2,3)
 ;flag that the authorization From Date is being changed by this 
 ;master record adjustment (see file #161.26, field #5)
 I FBTYPE="C" S FBTO=$S(FBFDC=1:"      ",1:FBTO)
 ;
 I FBTT=2,"^70^71^74^"'[(U_POV_U) S POV=71
 ;if 
 S ZMCNT=ZMCNT+1 I ZMCNT>100 D GETBT,STORE S ZMCNT=ZMCNT+1
 ; patch FB*3.5*13 changed format of delete MRAs to include the From Date
 I FBTYPE="D" D  Q
 . S FBRECT=$S(FBTT=4:"7",FBTT=2:"S",$G(POV)=31:"C",1:2)
 . S FBSTR=FBRECT_FBTYPE_FBSN_FBSSN_FBFR_"$"
 . D ZAP
 I FBTYPE="R" D
 . S FBRECT=$S(FBTT=4:"7",FBTT=2:"S",$G(POV)=31:"C",1:2)
 . ; If Re-Instate for a State Home record type then switch to Add
 . ;   because Central FEE does not retain deleted State Home auth.
 . I FBRECT=7 S FBTYPE="A" Q
 . ; For all other record types send a Re-Instate followed by a Change
 . S FBSTR=FBRECT_FBTYPE_FBSN_FBSSN_"$"
 . D ZAP
 . S FBTYPE="C"
 ; construct Add and Change record types
 S FBTT=$S(FBMST="Y":0,1:FBTT)
 S FBPATICN=$$ICN(DFN) ;get patient's ICN
 S FBSTR=FBRECT_FBTYPE_FBSN_FBSSN_FBFI_FBMI_FBFLNAM_FBADD_FBCITY_FBSTAT_FBZIP_FBFR_FBTO_FBCC_FBBD_POV_" "_FBTT_FBSEX_POW_DOD_" "_POS_FBPATICN_"~"
 ;if no CC address then send only 1st line of Add and Change record
 I FBCCFLG=0 S FBSTR=FBSTR_"$" D ZAP Q
 ;save 1st line of Add and Change record
 D STORE
 ;create 2nd line for CC address
 S FBSTR=FB2NDSTR
 D ZAP
 Q
 ;place in XMB for transmission and update FBAA(161.26
ZAP D STORE
 S DA=J,(DIC,DIE)="^FBAA(161.26,",T="T",DR="1///^S X=T;4///^S X=DT" D ^DIE
 Q
SKIP S FBRECT=$S(FBTT=2:"S",1:2),FBSTR=FBRECT_FBTYPE_FBSN_FBSSN_"$" G ZAP
STORE I ZMCNT>100 D XMIT^FBAAV01,NEWMSG^FBAAV01 S ZMCNT=1
 D STORE^FBAAV01
 Q
 ;---
 ;Patient's INTEGRATION CONTROL NUMBER
 ;to be implemented in future
 ;meanwhile returns 17 spaces
ICN(FBDFN) ;
 Q $$LRJ("",17)
 ;---
 ;adds spaces on right/left or truncates to make return string FBLEN characters long
 ;FBST- original string
 ;FBLEN - desired length
 ;FBCHR -character (default = SPACE)
 ;FBSIDE - on which side to add characters (default = RIGHT)
LRJ(FBST,FBLEN,FBCHR,FBSIDE) ;
 N Y S $P(Y,$S($L($G(FBCHR)):FBCHR,1:" "),$S(FBLEN-$L(FBST)<0:1,1:FBLEN-$L(FBST)+1))=""
 Q $E($S($G(FBSIDE)="L":Y_FBST,1:FBST_Y),1,FBLEN)
 ;---
 ;parse name components
HL7NAME(FBDFN) ;
 N FBAR,FBNM
 S FBAR("FILE")=2,FBAR("IENS")=FBDFN,FBAR("FIELD")=.01
 S FBNM=$$HLNAME^XLFNAME(.FBAR,"L30","|")
 Q $$LRJ(FBNM,30)
 ;
 ;create 2nd line for CC address
 ;VAPA should be determined
SECLINE() ;
 N FBSTR1
 S FBSTR1=$$LRJ($G(VAPA(13)),35)_$$LRJ($G(VAPA(14)),35)_$$LRJ($G(VAPA(15)),35)_$$LRJ($G(VAPA(16)),30) ;street address
 S FBSTR1=FBSTR1_$$LRJ($S(+$G(VAPA(17)):$P($G(^DIC(5,+$G(VAPA(17)),0)),"^",2),1:""),2) ;state
 S FBSTR1=FBSTR1_$$LRJ($TR($P($G(VAPA(18)),"^",1),"-",""),9,"0") ;zip
 S FBSTR1=FBSTR1_$$LRJ($E(+$G(VAPA(20)),4,5)_$E(+$G(VAPA(20)),6,7)_$E(+$G(VAPA(20)),2,3),6)
 S FBSTR1=FBSTR1_$$LRJ($E(+$G(VAPA(21)),4,5)_$E(+$G(VAPA(21)),6,7)_$E(+$G(VAPA(21)),2,3),6)
 S FBSTR1=FBSTR1_$$LRJ($P($G(^DIC(5,+$G(VAPA(17)),1,+$G(VAPA(19)),0)),"^",3),3,"0","L") ;county code
 S FBSTR1=FBSTR1_"~$"
 Q FBSTR1
 ;------
 ;SENDCC
 ;returns 1 if CC address needs to be sent, otherwise - 0
 ;is called after ADD^VADPT, i.e. VAPA should be defined
SENDCC() ;
 ;if it is currrently active
 I $$ACTIVECC^FBAACO0() Q 1
 N X D NOW^%DTC ;set X to TODAY
 I ($P($G(VAPA(22,3)),"^",3)="Y"),+$G(VAPA(20))>X Q 1
 Q 0
 ;
