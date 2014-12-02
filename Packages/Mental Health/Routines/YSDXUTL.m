YSDXUTL ;ALB/RBD - DX CODE SET UTILITIES FOR MENTAL HEALTH ;04/02/2012
 ;;5.01;MENTAL HEALTH;**107**;Dec 30, 1994;Build 23
 ;
 Q  ; Library utilities, do not enter from top.
 ;
ACTIVE(YSCS) ; Return start date for requested coding system
 ;  Input:  Coding system abbreviation from #80.4 or #757.3
 ;          ICD, ICP, 10D, 10P
 ;
 ;  Output:  n^FM date  where
 ;           n = 0 ; requested coding system is not active
 ;           n = 1 ; requested coding system is active
 ;           FM date = starting date of requested code type
 ;      or
 ;           -1^error message ; coding system not valid
 ;
 N YSICDD,YSOUT,X,Y
 S X=YSCS,DIC=80.4,DIC(0)="",D="C" D IX^DIC
 I Y<0 Q "-1^Invalid Coding System"
 S YSICDD=$$IMPDATE^LEXU(YSCS)
 S YSOUT=$S(YSICDD'<DT:0,1:1)_U_YSICDD
 K D,DIC
 Q YSOUT
 ;
AVDX ; Build array of available Diagnosis Sets (Dx only, not Procedure Sets) in YSDXA("DX SET",fm-date)
 ; [1] = IEN in #80.4
 ; [2] = Code Set name
 ; [3] = Code Set abbreviation
 ; [4] = File number holding code set values (always 80 in this function)
 ; [5] = Date that code set becomes active (FM format)
 N YSMSG,YSI,YSD,YSR
 K YSDXA
 D LIST^DIC(80.4,"",".02;.03I;.04I","P","","","","","I $P(^(0),U,3)=80","","YSDXA","YSMSG")
 Q:'$D(YSDXA("DILIST",0))
 F YSI=1:1:$P(YSDXA("DILIST",0),U,1) D
 . S YSR=YSDXA("DILIST",YSI,0),YSD=$P(YSR,U,5)
 . S YSDXA("DX SET",YSD)=YSR
 K YSDXA("DILIST")
 Q
 ;
ACTDT(YSTRXD) ; Active Dx Code Set for date supplied
 ; Input - a FileMan date
 ; Returns 4 piece value:
 ; [1] = Code Set abbreviation
 ; [2] = IEN into file #80.4
 ; [3] = Long name
 ; [4] = Activation Date (FM)
 ; or
 ; 0 if no active Dx code set is found for the date supplied
 ;
 N YSDT,YSOUT,YSREC
 D AVDX
 I '$D(YSDXA("DX SET")) Q 0
 S YSDT=0,YSOUT=0
 F  S YSDT=$O(YSDXA("DX SET",YSDT)) Q:YSDT=""  D
 . S YSREC=YSDXA("DX SET",YSDT)
 . I YSTRXD'<YSDT S YSOUT=$P(YSREC,U,3)_U_$P(YSREC,U,1)_U_$P(YSREC,U,2)_U_$P(YSREC,U,5)
 K YSDXA
 Q YSOUT
 ;
DXVALID ;
 N A,YSCODSET,YSDATA,YSDXDA,YSDXDATE,YSFILE,YSTYPE S YSDXDATE=$P(^YSD(627.8,DA,0),U,3)
 I YSDXDATE="" S YSDXDATE=$G(DG("0;3"))
 S A(1,"F")="!!",A(2)=" ",A(2,"F")="!!"
 I YSDXDATE="" S A(1)="MISSING DIAGNOSIS DATE/TIME" D EN^DDIOL(.A) K X Q
 S YSCODSET=$$ACTDT(YSDXDATE)
 I YSCODSET=0 S A(1)="NO ICD CODE SET FOUND FOR DIAGNOSIS DATE/TIME SUPPLIED" D EN^DDIOL(.A) K X Q
 S YSFILE=$P(X,";",2),YSDXDA=$P(X,";",1)
 I YSFILE["YSD" D  Q
 . S YSTYPE=$P(^YSD(627.7,YSDXDA,0),U,8) S:YSTYPE="" YSTYPE="9"
 . I YSTYPE="9",$P(YSCODSET,U,1)'="ICD" D  Q
 .. S A(1)="DIAGNOSIS DATE/TIME DOES NOT CORRELATE WITH DSM DIAGNOSIS CODE" D EN^DDIOL(.A) K X
 . I YSTYPE="10",$P(YSCODSET,U,1)'="10D" D
 .. S A(1)="DIAGNOSIS DATE/TIME DOES NOT CORRELATE WITH DSM DIAGNOSIS CODE" D EN^DDIOL(.A) K X
 I YSFILE["ICD9" D
 . S YSDATA=$$ICDDATA^ICDXCODE("DIAG",YSDXDA,YSDXDATE,"I")
 . I $P(YSDATA,U,1)=-1 D
 .. S A(1)="DIAGNOSIS DATE/TIME DOES NOT CORRELATE WITH ICD DIAGNOSIS CODE" D EN^DDIOL(.A) K X
 Q
 ;
