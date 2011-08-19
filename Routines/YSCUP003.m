YSCUP003 ;DALISC/LJA - Pt Move Utils: MATCH, GETMH, GETMOVES ;8/23/94 16:09 [ 08/28/94  12:57 PM ]
 ;;5.01;MENTAL HEALTH;**2,11,20,29**;Dec 30, 1994
 ;;
 ;
MATCH(ARR,ARR1) ;  Call to see if MH data matches Movements data
 ;  YST -- req
 QUIT:$G(YST)']""  ;->
 ;
 ;  ARR,ARR1 array data MUST be created by GETMH and GETMOVES
 ;  ARR = MH array (YSMH)       ARR1 = Movements array (YSPM)
 ;
 ;  Admission IEN from last Movement set
 S YSXEC="S YSMV=$O("_$P(ARR1,")")_",""M"",0))" X YSXEC
 ;
 ; Admission IEN from last MH entry
 S YSXEC="S YSMH=$O("_$P(ARR,")")_",""M"",0))" X YSXEC
 ;
 ;  YSMHMOV set by GETMOVES,STORE...
 S YST=YST_U_$G(YSMHMOV)_U_(YSMV>0&(YSMH>0)&(YSMV=YSMH))
 ;
 ;  Add 5th piece... Any MH wards in ^UTIL data?
 S YS5=0
 S LP="^UTILITY(""DGPM"","_$J,END=LP_",",LP=LP_")"
 F  S LP=$Q(@LP) QUIT:LP'[END  D
 .  S NODE=@LP,WIEN=+$P(NODE,U,6)
 .  S:$D(^YSG("CEN",+WIEN)) YS5=1
 S $P(YST,U,5)=YS5
 ;
 ;  Add 6th piece... Any MH Inpt entries
 S YST=YST_U_($D(^YSG("INP","C",+YSDFN))>0)
 QUIT
 ;
GETMH(YSDFN,ARR) ;  Get all MH entries into 'ARRAY'...
 ;  ARR,YSDFN -- req --> YSNMH + ARRay + YSOK
 ;  ARR Format:  YSDATA... Not, YSDATA(
 S YSOK=0
 N DFN S DFN=+YSDFN
 ;
 I $G(YSDFN)'>0!($G(ARR)']"") QUIT  ;-> ... leaving Y=0
 I ARR'[")" D
 .  S ARR=$E(ARR,1,($L(ARR)-1))_")"
 K @ARR
 S YSLMHA=0 ; Admission IEN of last MH Inpt Entry...
 S YSNMH=0 ;Number of MH entries
 S YSIEN=0
 F  S YSIEN=$O(^YSG("INP","C",+YSDFN,YSIEN)) QUIT:YSIEN'>0  D
 .  S YS0=$G(^YSG("INP",+YSIEN,0)) QUIT:YS0']""  ;->
 .  S YS7=$G(^YSG("INP",+YSIEN,7)) QUIT:YS7']""  ;->
 .  S YSMOVES=$P(YS7,U,3) QUIT:YSMOVES'>0  ;->
 .  S:$P(YSMOVES,"~",2)=+YSMOVES YSMOVES=+YSMOVES
 .  ;  If second piece = 1st piece, it's not a "true" discharge/transfer
 .  S YSNMH=YSNMH+1
 .  S YSOK=1
 .  S YSX=$P(ARR,")")_","_(999-YSNMH)_",0)",@YSX=+YSIEN_"~"_YS0
 .  S YSX=$P(ARR,")")_","_(999-YSNMH)_",7)",@YSX=YS7
 .  S YSLMHA=YSMOVES_U_(999-YSNMH)_U_+YSIEN
 .  QUIT:$P(YSMOVES,"~",2)'>0  ;->
 S YSX=$P(ARR,")")_","_"""M"""_","_+YSLMHA_")"
 S @YSX=$P(YSLMHA,U,2,3)
 QUIT
 ;
GETMOVES(YSDFN,ARR) ;  Get all existing patient movements into 'ARRAY'...
 ;  ARR,YSDFN -- req --> YSNM + ARRay + YSOK
 ;  ARR Format:  YSDATA... Not, YSDATA(
 ;
 ;  Set YSLMOMH: <L>ast <M>ovement <O>ff <MH> ward...
 ;       If no MH entries found,        YSLMOMH => ""
 ;       If MH movement found,          YSLMOMH => 0
 ;       If movement off MH ward found, YSLMOMH => # ~ Movement data
 ;         (# = subscript of ^TMP("YSPM",$J,#); Movement data = ^TMP("YSPM",$J,#))
 S YSLMOMH=""
 ;
 ;  Set YSFMTMH: <F>irst <M>ovement <T>o <MH> ward...
 ;       If no MH entries found,        YSFMTMH => ""
 ;       If MH movement found,          YSFMTMH => 0
 ;       If movement off MH ward found, YSFMTMH => # ~ Movement data
 ;         (# = subscript of ^TMP("YSPM",$J,#); Movement data = ^TMP("YSPM",$J,#))
 S YSFMTMH=""
 ;
 S YSMHMOV=0
 ;
 N DFN S DFN=+YSDFN
 S YSOK=0
 I $G(YSDFN)'>0!($G(ARR)']"") QUIT  ;-> ... leaving Y=0
 K @ARR
 S YSNM=0 ;Number of movements found...
 ;
 ;  Get last movement - as starting point
 S VAIP("D")="LAST"
 D IN5^VADPT
 I VAIP(13)<1 QUIT  ;-> ... leaving Y=0
 S YSOK=1
 D STORE(VAIP(13),+VAIP(13,1),+VAIP(13,2),+VAIP(13,4))
 S YSLAST=+VAIP(13)
 ;
 ;  Now, loop thru movements, saving into @ARR...
 F  QUIT:YSLAST'>0!(YSNM>25)  D  ;Loop until no more movements found...
 .  ;                             OR movements are > 25...
 .  K VAIP S VAIP("E")=YSLAST
 .  D IN5^VADPT
 .  S YSLAST=VAIP(16) QUIT:YSLAST'>0  ;->
 .  D STORE(+VAIP(16),+VAIP(16,1),+VAIP(16,2),+VAIP(16,4))
 .  I '$D(ZTQUEUED),'$G(DGQUIET) W "."
 K VAIP
 ;
 ;  Save 'housekeeping' variables...
 QUIT
 ;
STORE(NO,DT,MT,WN) ;  Store movement data into @ARR
 ;  ARR,YSNM -- req
 ;NO = Movement IEN
 ;DT = Date/time of movement
 ;MT = Movement type (1=Admit, 2=Transfer, 3=Discharge)
 ;WN = Ward IEN
 ;
 ;  Is movement for a MH ward?  If so, set YSMHMOV flag...
 S:$G(^YSG("CEN",+WN,0))>0 YSMHMOV=1
 ;
 QUIT:$G(NO)<1!($G(DT)'?7N.E)!($G(MT)'?1N)!($G(WN)<1)  ;->
 S YSNM=YSNM+1 ;Movement counter
 S X=$P(ARR,")")_","_(999-YSNM)_")",Y=($G(^YSG("CEN",+WN,0))>0)_U_WN_U_$P($G(^YSG("CEN",+WN,0)),U,9)_U_MT_U_NO_U_DT S @X=Y
 ;
 ;  On admissions, clean YSM?("M",#) replace with newer admission...
 I MT=1 D
 .  S X=$P(ARR,")")_","_"""M"""_","_+NO_")" KILL @X ;        Kill any YSM?("M",#
 .  S X=$P(ARR,")")_","_"""M"""_","_+NO_")",@X=(999-YSNM)_U_DT ;  Make new
 ;                                                         entry...
 ;
 ;  Set special YSPM-related variables...
 I ARR["YSPM" D
 .  I $P(Y,U,4)=2 S YSLTRSF=Y ;Save last TRANSFER in YSLTRSF
 .  I $P(Y,U,4)=1 S YSLADM=Y ;Save last ADMISSION in YSLADM
 .  I +Y>0,$P(Y,U,4)'=3 S YSLMOMH=0 ;Movement is onto a MH ward...
 .  I +Y>0,$P(Y,U,4)=3 S YSLMOMH=(999-YSNM)_"~"_Y ; DC from MH ward
 .  I +Y'>0&(YSLMOMH="0") D  ;Movement off MH ward found...
 .  .  S YSLMOMH=(999-YSNM)_"~"_Y
 .  I +Y>0&(YSFMTMH="") S YSFMTMH=(999-YSNM)_"~"_Y ;1st move to MH
 .  S ^TMP("YSPM",$J,"A",+$P(Y,U,5))=(999-YSNM) ;Movement IEN xref
 ;
 QUIT
 ;
EOR ;YSCUP003 - Pt Move Utils: MATCH, GETMH, GETMOVES ;8/23/94 16:09
