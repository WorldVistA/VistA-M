ACKQUTL6 ;HCIOFO/BH-A&SP Utilities routine ; 12/28/07 11:04am
 ;;3.0;QUASAR;**1,7,17**;Feb 11, 2000;Build 28
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
DATACHEK(X,ACKVIEN) ;  Checks that the input (X) is a valid time also checks that 
 ;          current user has supervisor status
 ;
 I $$TIMECHEK^ACKQASU5(ACKVIEN,"") Q 0
 S X=$$TTIME(X) Q X
 ;
 ;
SUPER(DUZ) ;  Function passes back true if DUZ belongs to a supervisor
 N ACKDUZ
 S ACKDUZ=$$PROVCHK^ACKQASU4(DUZ)
 I 'ACKDUZ Q 0
 I $D(^ACK(509850.3,ACKDUZ,0)),$P(^(0),"^",6)=1 Q 1
 Q 0
 ;
 ;
TTIME(X) ;   Time input validation used within input transform of
 ;           the Appointment time field (#55) of the visit file.
 ;
 ;           X=Time entered by the user
 ;           Return value either O if input was invalid or formatted
 ;           time.
 ;
 N Y,ACKFMT,ACKAMPM
 I X="NOW"!(X="now") D NOW^%DTC S X=$P(%,".",2)
 I X="NOO" S X="NOON"
 ;
 S %DT="%DTS"
 ; S DIR(0)="D^::%DT"
 S X="2990303@"_X
 K Y
 D ^%DT
 ;
 I Y="-1" Q 0
 S Y=$P(Y,".",2)
 S ACKT="."_Y
 ;
 S ACKFMT=Y
 ;. D AMPM
 ;. W ?30,"("_+$E(ACKFMT,1,2)_":"_$E(ACKFMT,3,4)_":"_$E(ACKFMT,5,6)_ACKAMPM_")"
 ;. D AMPM
 ;. W ?30,"("_+$E(ACKFMT,1,2)_":"_$E(ACKFMT,3,4)_ACKAMPM_")"
 W ?30,"("_$$FMT(ACKFMT)_")"
 Q ACKT
 ;
FMT(ACKFMT,ACKSTYL) ; convert Quasar Time to external format
 ; inputs:- ACKFMT - fileman time (internal)  (reqd)
 ;            can be passed in as 'date.time','.time' or just 'time'
 ;          ACKSTYL - style of output (optional)
 ;                    where 0 = 12:mm[:ss] am/pm (no lead space)
 ;                          1 = 12:mm[:ss] am/pm (lead space)
 ;                          2 = 12:mm am/pm
 N ACKHH,ACKAMPM
 S ACKSTYL=+$G(ACKSTYL)
 I ACKFMT["." S ACKFMT=$P(ACKFMT,".",2)
 S ACKFMT=ACKFMT_"00000"
 S ACKHH=+$E(ACKFMT,1,2)
 G:ACKSTYL=1 FMT1
 G:ACKSTYL=2 FMT2
FMT0 ; style 0 - 12:mm[:ss] am/pm  (the default)
 S ACKAMPM=" AM" I ACKHH>11,ACKHH<24 S ACKAMPM=" PM"
 I ACKHH<1 S ACKHH=12
 I ACKHH>12 S ACKHH=ACKHH-12
 S ACKFMT=ACKHH_":"_$E(ACKFMT,3,4)_$S(+$E(ACKFMT,5,6)>0:":"_$E(ACKFMT,5,6),1:"")_ACKAMPM
 Q ACKFMT
FMT1 ; style 1 - 12:mm[:ss] am/pm  (with lead space if hour<10)
 S ACKAMPM=" AM" I ACKHH>11,ACKHH<24 S ACKAMPM=" PM"
 I ACKHH<1 S ACKHH=12
 I ACKHH>12 S ACKHH=ACKHH-12
 S ACKFMT=$J(ACKHH,2)_":"_$E(ACKFMT,3,4)_$S(+$E(ACKFMT,5,6)>0:":"_$E(ACKFMT,5,6),1:"")_ACKAMPM
 Q ACKFMT
FMT2 ; style 2 - 12:mm am/pm
 S ACKAMPM=" AM" I ACKHH>11,ACKHH<24 S ACKAMPM=" PM"
 I ACKHH<1 S ACKHH=12
 I ACKHH>12 S ACKHH=ACKHH-12
 S ACKFMT=$J(ACKHH,2)_":"_$E(ACKFMT,3,4)_ACKAMPM
 Q ACKFMT
 ;
DUPECHK(X,DA,ACKP) ;  Check there are no previous duplicate entries
 N ACKTGT,ACKCLIN,ACKVD,ACKPAT
 S ACKPAT=ACKP
 D GETS^DIQ(509850.6,DA_",",".01;1;2.6","I","ACKTGT")
 S ACKVD=$G(ACKTGT(509850.6,DA_",",.01,"I")) I ACKVD="" Q 1
 I ACKPAT="" S ACKPAT=$G(ACKTGT(509850.6,DA_",",1,"I")) I ACKPAT="" Q 1
 S ACKCLIN=$G(ACKTGT(509850.6,DA_",",2.6,"I")) I ACKCLIN="" Q 1
 I $D(^ACK(509850.6,"APCE",ACKPAT,ACKCLIN,ACKVD,X)) Q 0
 Q 1
 ;
DUPCHK ;  Called from xecutable help of Appointment Time field when ACKITME is
 ;  defined.  This will only be defined if DUPECHK returned false
 W !!,"Quasar already has a Visit entry for this Patient, within the same Clinic,"
 W !,"on the same date at the same time."
 W !!,"Please re-enter a new Appointment Time.",!!
 K ACKITME Q
 ;
 ;
CDR() ;  COMPUTE SUGGESTED CDR BASED ON TREATING SPECIALTY
 S VAIP("D")=ACKVD D IN5^VADPT S ACKTS=+$$GET1^DIQ(45.7,+VAIP(8),1,"I"),ACKCDN=$$GET1^DIQ(42.4,ACKTS,6)_".00"
 S ACKCDP=$S($O(^ACK(509850,"B",ACKCDN,0)):$O(^(0)),1:0) I 'ACKCDP S ACKCDP=$O(^ACK(509850,"B","2611.00",0))
 S ACKCDN=$P(^ACK(509850,ACKCDP,0),U),ACKCD=$P(^(0),U,2)
 K %,%H,%I,ACKTS,ACKCDP,VAIP,VAERR
 W !!,"Suggested CDR Account :",ACKCDN,"  ",ACKCD,!
 Q ACKCDN
 ;
 ;----------------------------------------------------------------
 ;  Routines and Utilities used within the Clinician Template
 ;
 ;
STAFFNO(X) ;  Finds valid staff No. to be used when allocating next time
 ;
 N ACKFIRST,ACKFIND,ACKX
 S ACKFIRST=1
 I X=9999 S X="0000" S ACKFIRST=0
 D GETNEXT,FILE
 Q
 ;
GETNEXT ;
 S ACKFIND=0
 F  Q:ACKFIND  D
 . S ACKX=+X
 . S X=X+1
 . I X=9999,ACKFIRST S ACKFIRST=0 S X=0 Q
 . I X=9999,'ACKFIRST S ACKFIND=1 Q
 . S X=$E("0000",$L(X)+1,4)_X
 . I '$D(^ACK(509850.3,"C",X)) S ACKFIND=1,X=ACKX Q
 Q
 ;
FILE ;
 S ^ACK(509850.3,"ALID")=$E("0000",$L(X)+1,4)_X
 Q
 ;
 ;
IDATE(D0,Y) ;  Checks that the entered Inactive date falls after the
 ;          Active date (if one has been entered).
 I Y="" Q 1  ;  Its valid to not enter an inactivation date. 
 N ACKACT
 S ACKACT=$$GET1^DIQ(509850.3,D0,.03,"I") I ACKACT="" Q 1
 I Y<ACKACT Q 0
 Q 1
 ;
ADATE(D0,Y) ;  Checks that the entered Active date falls before the
 ;          Inactive date (if one has been entered).
 N ACKINA
 S ACKINA=$$GET1^DIQ(509850.3,D0,.04,"I") I ACKINA="" Q 1
 I Y>ACKINA Q 0
 Q 1
 ;
STAFFREF(X,DA) ;    Cross Reference called from Cross Reference 'Logic'
 Q  ;Disabled With the removal of "D" X-ref ACKQ*3*17
 ;
 N ACKNAME
 ;ACKQ*3*17
 ;S ACKNAME=$$GET1^DIQ(8930.3,X_",",.01)
 S ACKNAME=$$GET1^DIQ(200,X_",",.01)
 S ^ACK(509850.3,"D",ACKNAME,DA)=""
 Q
 ;
REINDEX() ;   Re-Indexes 'D' Cross Reference of Staff file
 Q  ;Disabled With the removal of "D" X-ref ACKQ*3*17
 ;   First checks that all ^USR(8930.3 entries that 509850.3 points to
 ;   still exist
 N ACK01,ACK,ACKARR,ACKCNT
 K ACKARR
 S ACK=0,ACKCNT=0
 F  S ACK=$O(^ACK(509850.3,ACK)) Q:'ACK  D
 . S ACK01=$P(^ACK(509850.3,ACK,0),"^",1)
 . I '$D(^USR(8930.3,ACK01,0)) D SETARR(ACK)
 ;
 I $D(ACKARR) D  Q 0
 . W !!,"Warning - The following user(s) have been deleted from the USR Class Membership"
 . W !,"file (#8930.3)."
 . W !,"Quasar's A&SP Staff file (#509850.3) points to this file."
 . W !,"The Quasar staff member(s) need to be re-entered into the USR Class Membership"
 . W !,"file (8930.3) and the associated Quasar staff record amended to point to this"
 . W !,"new entry.",!!
 . N ACK1
 . S ACK1=""
 . F  S ACK1=$O(ACKARR(ACK1)) Q:ACK1=""  D
 . . W "     "_ACKARR(ACK1),!
 . W !!
 . W "Please inform IRM/National VistA Support of this problem.  This error"
 . W !,"can be re-created by running this option again."
 . W !!
 ;
 N DA,D0,X,Y
 K ^ACK(509850.3,"D")
 S DIK="^ACK(509850.3,"
 S DIK(1)=".07^D"
 D ENALL^DIK
 Q 1
 ;
SETARR(ACK) ;
 Q  ;Disabled With the removal of "D" X-ref ACKQ*3*17
 ;
 N ACKNAME
 S ACKNAME=""
 F  S ACKNAME=$O(^ACK(509850.3,"D",ACKNAME)) Q:ACKNAME=""  D
 . I $D(^ACK(509850.3,"D",ACKNAME,ACK)) S ACKCNT=ACKCNT+1 S ACKARR(ACKCNT)=ACKNAME
 Q
 ;
LONG(ACKPC,ACKQPR) ;  Displays Long Description of Procedure Code
 ;
 Q
 N ACKQ,ACKRES,ACKNEW,ACKSTR,ACK1,ACKQARR,ACKLEN,ACKCNT S ACKSTR="",ACKCNT=0
 S ACK1=0
 F  S ACK1=$O(^ICPT(ACKPC,"D",ACK1)) Q:'ACK1  D
 . S ACKNEW=^ICPT(ACKPC,"D",ACK1,0)
 . S ACKNEW=$$STRIP(ACKNEW)
 . I $G(ACKSTR)'="" S ACKNEW=ACKSTR_" "_ACKNEW
 . S ACKLEN=$L(ACKNEW)
 . I ACKLEN>54 D
 . . I ACKLEN=55 S ACKCNT=ACKCNT+1,ACKQARR(ACKCNT)=ACKNEW S ACKSTR="" Q
 . . S ACKRES=$$FORMAT(ACKNEW) S ACKNEW=$P(ACKRES,"^",1),ACKSTR=$P(ACKRES,"^",2),ACKCNT=ACKCNT+1,ACKQARR(ACKCNT)=ACKNEW
 . I ACKLEN<55 S ACKSTR=ACKNEW
 I $G(ACKSTR)'="" D
 . S ACKQ=1
 . F  Q:'ACKQ  D
 . . S ACKNEW=ACKSTR S ACKRES=$$FORMAT(ACKNEW)
 . . S ACKNEW=$P(ACKRES,"^",1),ACKSTR=$P(ACKRES,"^",2)
 . . S ACKCNT=ACKCNT+1,ACKQARR(ACKCNT)=ACKNEW
 . . I $G(ACKSTR)="" S ACKQ=0
 ;
 ;  Display Array
 ;
 I '$D(ACKQARR) Q
 N ACKK1,ACKQUIT
 S ACKK1="",ACKQUIT=0
 W !!," Long Description: "
 F  S ACKK1=$O(ACKQARR(ACKK1)) Q:'ACKK1!(ACKQUIT)  D
 . I ACKK1'=1 W !,"                   "
 . W ACKQARR(ACKK1) I ACKQPR=1,ACKK1=3 W "..." S ACKQUIT=1
 W !
 ;
 Q
 ;
FORMAT(ACKNEW) ;
 ;
 N ACKRES,ACKCCT,ACKEND,ACKN
 I $L(ACKNEW)<56 S ACKRES=ACKNEW_"^"_"" Q ACKRES
 S ACKCCT=0,ACKEND=0
 F  Q:ACKEND  D
 . S ACKCCT=ACKCCT+1
 . I $L($P(ACKNEW," ",1,ACKCCT))<56 S ACKN=ACKCCT
 . I $L($P(ACKNEW," ",1,ACKCCT))'<56 S ACKEND=1
 S ACKRES=$P(ACKNEW," ",1,ACKN)_"^"_$P(ACKNEW," ",ACKN+1,999)
 Q ACKRES
 ;
STRIP(ACKNEW) ;
 N ACKARRAY,ACKCT,ACKLEN,ACKX,ACKY,ACKI
 S ACKY="",ACKCT=0
 S ACKLEN=$L(ACKNEW)
 F ACKI=1:1:ACKLEN D
 . S ACKX=$E(ACKNEW,ACKI,ACKI)
 . I ACKX'=" " S ACKY=ACKY_ACKX
 . I ACKX=" ",ACKY'="" S ACKCT=ACKCT+1 S ACKARRAY(ACKCT)=ACKY S ACKY=""
 . I ACKI=ACKLEN,ACKY'="" S ACKCT=ACKCT+1 S ACKARRAY(ACKCT)=ACKY S ACKY=""
 ;
 N ACKLOOP,ACKSTRG
 S ACKLOOP=0,ACKSTRG=""
 F  S ACKLOOP=$O(ACKARRAY(ACKLOOP)) Q:ACKLOOP=""  D
 . S ACKSTRG=ACKSTRG_ACKARRAY(ACKLOOP)_" "
 ;
 S ACKLEN=$L(ACKSTRG)
 I $E(ACKSTRG,ACKLEN,ACKLEN)=" " S ACKSTRG=$E(ACKSTRG,1,ACKLEN-1)
 ;
 Q ACKSTRG
PLIST(ACKPAT,ACKDC) ; Determines if an entry exists in the Problem file
 ; returns Status as first piece, Problem List IEN as second piece
 ; (Status^IEN)
 ; Status values -  1=Inactive, 2=Active
 N ACKIFN,ACKPLQT
 S (ACKIFN,ACKPLQT)=0
 I $D(^AUPNPROB("AC",ACKPAT)) D
 . F  S ACKIFN=$O(^AUPNPROB("AC",ACKPAT,ACKIFN)) Q:(ACKIFN="")  D  Q:ACKPLQT
 . .I $D(^AUPNPROB("B",ACKDC,ACKIFN)) S ACKPLQT=ACKIFN
 I ACKPLQT Q $S($P($G(^AUPNPROB(ACKPLQT,0)),U,12)="A":2,1:1)_U_ACKPLQT
 Q 0
 ;
