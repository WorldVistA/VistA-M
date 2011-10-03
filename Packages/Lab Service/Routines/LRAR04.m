LRAR04 ;SLC/RWF/DAL/HOAK - REMOVE OLD DATA FROM PT. FILE ; 12/12/96  10:16 ;
 ;;5.2;LAB SERVICE;**111**;Sep 27, 1994
 ;
 ;    Rewrite 11/96 Hoak --------------->
 ;
 Q  ;LRC2=NUMBER OF PT, LRC3=NUMBER OF DATES
MOVE ;
 ;  This is where we make the copies to be archived  <----------
 ;
 ;      Move data from ^LR to ^LAR------>arcive global----------|
 ;                                                              |
 S LRCNT=$P(^LR(LRDFN,LRSS,0),U,3,4) ;                          |
 S:LRSS="CH" ^LAR("Z",LRDFN,LRSS,0)="^63.999904D^"_LRCNT ;      |
 S:LRSS="MI" ^LAR("Z",LRDFN,LRSS,0)="^63.999905DA^"_LRCNT ;     |
 S %X="^LR(LRDFN,LRSS,LRIDT," ;                                 |
 S %Y="^LAR(""Z"",LRDFN,LRSS,LRIDT," ;                          |
 ;                                                              |
 D %XY^%RCR ; <-------------------------------------------------/
 ;
 ;
 S:LRC1 LRC2=LRC2+1,LRC1=0
 S ^LAR("Z",LRDFN,0)=^LR(LRDFN,0)
 S ^LAR("Z","B",LRDFN,LRDFN)=""
 S ^LAR("NAME",PNM,LRDFN)=""
 S ^LAR("SSN",SSN,LRDFN)=""
 S LRC3=LRC3+1
 QUIT
 ;
PT ;
 S PNM="unk",SSN="unk"
 Q:LRDPF<1  D DEM^LRX
 S:SSN="" SSN="unk" S:PNM="" PNM="unk"
 QUIT
 ;
 ;
DFN ;
 ;from LRARCHIV
 ;
 ;
 S LRI=0
 S LRJT0=$P(^LR(0),U,4)
 I '$G(LRDT7) S LRDT7=LR(1)
 ;
CONTROL ;
 S LRDFN=0
 Q
 ;
 ;
QUERY ;
 D DFN
 D NOW^%DTC S ^TMP("LR9","ENDX")=%
 S LRDFN=0
 K ^TMP("LR9")
 D NOW^%DTC S ^TMP("LR9","START")=%
 S LRQCNT=0
 ;
 ;        ^LR(13,"CH",7038789.916,0)
 ;
 ;  This block builds a TMP global of data relevant for the date
 ;  range LRSDTX to LREDT
 ;
 ;--->New concept employed; gather only LRDFN(s) in date range
 ;    archive only these
 ;
 S LRV7=LREDT
 S LRSDTX=9999999-LR(1)
 S LREDT=9999999-LRV7 I $E(LREDT,1,1)=2 S LREDT=LRV7
 S LRDFN="^LR(1,0)"
 S ^TMP("LR9","RANGE")=LRSDTX_U_LREDT
 ;
 F  S LRDFN=$Q(@LRDFN) Q:$P(LRDFN,",")'["LR("  S LR9=$P(LRDFN,",",3) D
 .  Q:$P(LRDFN,",",2)'["CH"
 .  S LR8=+$P(LRDFN,"LR(",2) Q:LR8'>0
 .  I LR9>LRSDTX,LR9<LREDT D
 ..  I $P(^LR(LR8,0),U,2)=2 S ^TMP("LR9",LR8)=^LR(LR8,0)_U_LR9_U_LREDT_U_+^LR(LR8,"CH",LR9,0) D
 ...  S $P(LRDFN,"LR(",2)=LR8+.1_","_$P(LRDFN,LR8_",",2)
 ...  S LRQCNT=LRQCNT+1
 ..  S LR5=$L(LRDFN)
 ..  I $E(LRDFN,LR5,LR5)'=")" S LRDFN=LRDFN_")"
 D NOW^%DTC S ^TMP("LR9","END0")=%
 Q
DISPLAY ;
 W !,"My preliminary screening process reveals ",$G(LRQCNT)," LRDFN(s)."
 Q
 ;
 ;
LR ;
 D DQ1^LRARCHIV
 D QUERY
 S LRWHICH="CH"
 K ^TMP("LRT2")
 S LRDFN=0
 ;
 ;********************************************************************
 ;                                                                   *
 ;      Leave Micro question for next go-round                       *
 ;                                                                   *
 ;********************************************************************
 ;
 F  S LRDFN=$O(^TMP("LR9",LRDFN)) Q:+LRDFN'>0  D  I LRDFN'>0 D TEND QUIT
 .  S LRDPF=$P(^TMP("LR9",LRDFN),U,2) S DFN=$P(^(LRDFN),U,3)
 .  I +LRDPF=2 S RC1=1 D PT
 .  I +LRDPF'=2 QUIT
 .  S LRIDT=$P(^TMP("LR9",LRDFN),U,7)
 .  S LRSS="CH" D LAB
 D LST^LRARCHIV
 D QUIT^LRARCHIV
 Q
LAB ;
 S LRJTX=$P(^LR(0),U,4)
 S LRIDT=LRIDT-.1
 F  S LRIDT=$O(^LR(LRDFN,LRSS,LRIDT)) Q:+LRIDT'>0!(LRIDT>LREDT)  D
 .  I $D(^LR(LRDFN,LRSS,LRIDT,0)) S LRDT7=+^(0)
 .  S LRI=$G(LRI)+1
 .  ;D JOBTIME^LRAC12
 .  W "."
 .  D LAB1
 Q
 ;
LAB1 ;
 D  I LRIDT<1 D UPDT Q
 .  Q:'LRIDT
 .  I '$D(PNM) D PT
 .  IF '$D(^LR(LRDFN,LRSS,LRIDT,0)) D  QUIT
 ..  S ^TMP("LRBAD",LRDFN,LRSS,LRIDT)=PNM_" "_LRIDT
 .  S LRDAT=^LR(LRDFN,LRSS,LRIDT,0)
 .  IF LRSS="CH",'$P(LRDAT,U,3) D  QUIT
 ..  S ^TMP("LRUNV",LRDFN,LRSS,LRIDT)=PNM_" "_LRIDT
 .  IF $O(^LR(LRDFN,LRSS,LRIDT,0))=""!('+$O(^(0))) D  QUIT
 ..  S ^TMP("LRNOD",LRDFN,LRSS,LRIDT)=PNM_" "_LRIDT
 ;
 I $L($P(LRDAT,U,9)) D CHECKX
 ;
 QUIT
 ;
 ;----------------------------------------------------------------------
 ;------Here is where we check the major header  and force to perm.
 ;
CHECKX S LRMH=$P($P(LRDAT,U,9),":")  ;Major Header
 S LRFG=$P($P(LRDAT,U,9),":",2)  ;PAGE
 ;
 ;     Checking all the test for different major header
 ;
 ;
 S TEST=.5
 F  S TEST=$O(^LR(LRDFN,"CH",LRIDT,TEST)) Q:+TEST'>0  D
 .  Q:$D(^TMP("LRT2",TEST))#2
 .  D ^LRAR02
 ;--------------------------------------------------------------------
 ;
 D MOVE
 Q
 ;
TEND ;
 W @IOF
 W !!,"The SEARCH process is complete."
 W !!,$P(LRI/LRJT0*100,".")," Percent of ^LR was searched"
 D STAMP^LRX
 W !,"Total patient count: ",LRC2,". Specimen count: ",LRC3,! K LRDFN
 QUIT
 ;
UPDT ;
 S X=0,LRCNT=0
 F I=0:0 S X=$O(^LR(LRDFN,LRSS,X)) Q:X<1  S LRCNT=LRCNT+1
 ;--------------------------------------------CH-----------MICRO NO BB?
 I LRCNT=0 S ^LR(LRDFN,LRSS,0)=$S(LRSS="CH":"^63.04D",1:"^63.05DA") Q
 S $P(^LR(LRDFN,LRSS,0),U,4)=LRCNT
 Q
RCC ;
 ;REMOVE CONTROL CHAR.
 S X=LRDAT
 S LRDAT=""
 F I=1:1:$L(X) S LRDAT=LRDAT_$S($A(X,I)>126:"",$A(X,I)>31:$E(X,I),1:"")
 S ^LR(LRDFN,LRSS,LRIDT,I1)=LRDAT
 QUIT
