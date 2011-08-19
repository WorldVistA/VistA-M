SCAPMCU5 ;bp/cmf - TEAM API UTILITIES ; 2 june 1999
 ;;5.3;Scheduling;**177**;AUG 13, 1993
 ;;1.0
 ;
VALHIST(SCFILE,SCTPIEN,SCVAL) ; returns valid act/inact ien pairs in SCVAL
 ;
 S SCFILE=$G(SCFILE,0)
 I "^404.58^404.59^404.52^404.53^"'[SCFILE Q $$S(1)
 S SCTPIEN=+$G(SCTPIEN,0)
 I SCTPIEN<1!('$D(^SCTM(404.57,SCTPIEN))) Q $$S(2)
 S SCVAL=$G(SCVAL,"")
 I SCVAL']"" Q $$S(3)
 ;
 N SCCNT,SCTOP,SCX,SCACT,SCACT1,SCINACT,SCINACT1,SCFIRST,SCSTOP
 M SCX(1)=^SCTM(SCFILE,"AIDT",SCTPIEN,1)
 M SCX(0)=^SCTM(SCFILE,"AIDT",SCTPIEN,0)
 S SCCNT=0
 S SCTOP=0
 S SCACT=-9999999                                  ;act dt
 F  S SCACT=$O(SCX(1,SCACT)) Q:'SCACT  D
 . S SCACT1=""                                     ;act ien
 . F  S SCACT1=$O(SCX(1,SCACT,SCACT1),-1) Q:'SCACT1  D
 . . S SCINACT=SCACT                               ;inact dt
 . . I $D(SCX(0,SCINACT)) Q:$$INACT()
 . . S SCINACT=$O(SCX(0,SCINACT),-1)               ;next? inact dt
 . . I SCINACT="" D  Q                             ;current asgn
 . . . Q:SCTOP
 . . . D VALID
 . . . S SCTOP=1
 . . . Q
 . . S SCX=$$INACT()
 . . Q
 . Q
 ;
 S SCFIRST=0_U_0
 I $G(@SCVAL@(0))>0 D
 . S SCCNT=@SCVAL@(0)
 . S SCACT=$O(@SCVAL@(SCCNT,0))
 . S SCACT1=$O(@SCVAL@(SCCNT,SCACT,0))
 . S SCFIRST=SCACT_U_SCACT1
 . Q
 Q ($D(SCX(1)))!($D(SCX(0)))_U_SCFIRST
 ;
INACT() S SCSTOP=0
 S SCINACT1=SCACT1                             ;inact ien
 F  S SCINACT1=$O(SCX(0,SCINACT,SCINACT1)) Q:'SCINACT1!(SCSTOP)  D
 . I "^404.58^404.59^"[SCFILE D VALID Q
 . I SCFILE=404.52,$$CP(3) D VALID Q
 . I SCFILE=404.53,$$CP(6) D VALID Q
 . Q
 Q SCSTOP
 ;
VALID S SCCNT=SCCNT+1
 S SCX=$S(+$G(SCINACT):-SCINACT,1:"")_U_$S(+$G(SCINACT1):SCINACT1,1:"")
 I SCX=U,SCCNT>1 S SCCNT=SCCNT-1 Q  ;latest entry ONLY should have empty inact data
 S @SCVAL@(SCCNT,-SCACT,SCACT1)=SCX
 S @SCVAL@(0)=SCCNT
 S @SCVAL@("I",SCACT1,SCCNT)=""
 K SCX(1,SCACT,SCACT1)
 I SCINACT'="",SCINACT1'="" K SCX(0,SCINACT,SCINACT1)
 S SCSTOP=1
 Q
 ;
CP(SCX) ; if 404.52, practitioner (.03)s must match
 ; if 404.53, preceptor (.06)s must match
 Q $P(^SCTM(SCFILE,SCACT1,0),U,SCX)=$P(^SCTM(SCFILE,SCINACT1,0),U,SCX)
 ;
 ;
ACTHIST(SCVAL,SCDATES) ;given val hist array, prior active?
 ; input:  scval   = scval array produced by $$valhist call, above
 ;         scdates = standard PCMM date array
 ;
 ; output:      p1 = prior activation: 1=yes, 0=no
 ;              p2 = active as of end date: 1=yes, 0=no
 ;              p3 = if p2=1, activation ien, else inactivation ien
 ;
 N SCX,SCX1,SCX2,SCA,SCDATE,SCP1,SCP2
 I '$D(@SCVAL)!($G(@SCVAL@(0))<1) Q $$S(4)
 I '$D(@SCDATES) Q $$S(5)
 S SCDATE=$G(@SCDATES@("END"),DT)+.000001
 ; arrange scval by assign date
 F SCX=1:1:@SCVAL@(0) D
 . S SCX1=$O(@SCVAL@(SCX,0))
 . S SCX2=$O(@SCVAL@(SCX,SCX1,0))
 . S SCA(SCX1,SCX2)=@SCVAL@(SCX,SCX1,SCX2)
 . Q
 S SCX1=+$O(SCA(SCDATE),-1)
 S SCP1=(SCX1>0)
 S (SCP2,SCP3)=0
 I +SCP1 D
 . S SCX2=$O(SCA(SCX1,""),-1)
 . S SCX=$P(SCA(SCX1,SCX2),U)
 . S SCDATE=SCDATE-.000001
 . I (SCX="")!(SCX'<SCDATE) S SCP2=1
 . S SCP3=$S(SCP2=1:SCX2,1:$P(SCA(SCX1,SCX2),U,2))
 Q SCP1_U_SCP2_U_SCP3
 ;
S(SCX) Q "Invalid "_$P($T(T+SCX),";;",2)
 ;
T ;
 ;;File Number;;
 ;;Team Position Ien;;
 ;;(null) Result Array;;
 ;;(null) History Array;;
 ;;(null) Date Array;;
 ;
