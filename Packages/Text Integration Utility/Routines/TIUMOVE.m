TIUMOVE ; SLC/JER - Patient movement look-up ;10/26/95  21:17
 ;;1.0;TEXT INTEGRATION UTILITIES;**3**;Jun 20, 1997
MAIN(TIUY,DFN,TIUSSN,TIUMDT,TIULDT,TIUMTYP,TIUDFLT,TIUMODE,TIULOC) ;
 ; Call with:     .TIUY - (by ref) array in which demographic, movement,
 ;                        & visit data are returned
 ;                [DFN] - patient file entry number
 ;             [TIUSSN] - patient SSN
 ;             [TIUMDT] - movement date
 ;             [TIULDT] - upper bound of date range
 ;            [TIUMTYP] - MAS Movement event type
 ;            [TIUDFLT] - Default movement (e.g., "LAST")
 ;            [TIUMODE] - mode flag 0 ==> Silent
 ;                                  1 ==> Interactive (default)
AGN ; Loop for handling repeated attempts
 N TIUI,TIUII,TIUER,TIUOK,TIUOUT,TIUX,TIUMTSTR,TIUMLST,TIUCNT,X
 S TIUMTYP=$S(+$G(TIUMTYP):+$G(TIUMTYP),1:1)
 S TIUMODE=$S($G(TIUMODE)]"":$G(TIUMODE),1:1)
 S TIUMDT=$S(+$G(TIUMDT):+$G(TIUMDT),1:2400101)
 S TIULDT=$S(+$G(TIULDT):+$G(TIULDT),1:+$$NOW^TIULC)
 S TIUMTSTR="ADMISSION^TRANSFER^DISCHARGE^CHECK-IN^CHECK-OUT^SPECIALTY CHANGE"
 I +$G(DFN)'>0,($G(TIUSSN)]"") S DFN=+$$PATIENT^TIULA($G(TIUSSN))
 I +$G(DFN)'>0 S TIUOUT=1 Q
 I '$D(^DGPM("ATID"_TIUMTYP,DFN)),+TIUMODE W !,"No ",$P(TIUMTSTR,U,TIUMTYP),"S on file.",! Q
 I +TIUMTYP=1,(TIUMODE=0),(TIUDFLT="CURRENT"),+$G(^DPT(DFN,.105)) S TIUX=+$G(^DPT(DFN,.105)) G VADPT
 D TGET(.TIUMLST,DFN,TIUMDT,TIULDT,TIUMTYP,.TIUCNT,TIUMODE)
 ; If call is silent, and multiple movements in result, then quit
 I '+TIUMODE,$S(+TIUCNT=1:1,TIUDFLT="LAST":1,1:0) S TIUX=$G(TIUMLST(1))
 I '+TIUMODE,(+TIUCNT>1),(+$G(TIUX)'>0) Q
 I '+TIUMODE,(+TIUCNT=0) Q
 I +TIUMODE D  I +TIUER Q:+$G(TIUOUT)  G AGN
 . I +TIUCNT'>0 W !,"No ",$P(TIUMTSTR,U,TIUMTYP),"S within search parameters.",! Q
 . W !,"The following ",$P(TIUMTSTR,U,TIUMTYP)
 . W $S(+TIUCNT>1:"(S) are",1:" is")," available:"
 . S (TIUER,TIUOK,TIUI)=0
 . F  S TIUI=$O(TIUMLST(TIUI)) Q:+TIUI'>0!+TIUER!+TIUOK  D
 . . S TIUII=TIUI,TIUX=$P(TIUMLST(TIUI),"^",2,20)
 . . D WRITE I '(TIUI#5) D BREAK
 . Q:$D(TIUOUT)
 . I +TIUER S TIUOUT=1 Q
 . I TIUII#5 D BREAK Q:$D(TIUOUT)
 . I +TIUER S TIUOUT=1 Q
 . S TIUX=$G(TIUMLST(+TIUOK)),^DISV(DUZ,"DGPMEX",DFN)=+TIUX
 . W "  ",$$DATE^TIULS(+$P(TIUX,U,2),"AMTH DD CCYY@HR:MIN")
VADPT D PATVADPT^TIULV(.TIUY,DFN,+TIUX)
 Q
TGET(Y,DFN,MDT,LDT,MTYPE,C,MODE) ; Get list of movements
 N I,N,D S MDT=$G(MDT,9999999.9999999),MTYPE=$G(MTYPE,1),LDT=$G(LDT,0)
 I MDT'=9999999.9999999 S MDT=9999999.9999999-$$IDATE^TIULC(MDT)
 I LDT'=0 S LDT=9999999.9999999-$$IDATE^TIULC(LDT)
 S C=0,I=LDT F  S I=$O(^DGPM("ATID"_MTYPE,DFN,I)) Q:+I'>0!(+I>MDT)  D
 . S N=$O(^DGPM("ATID"_MTYPE,DFN,I,0)) Q:'$D(^DGPM(+N,0)) 
 . S D=^(0),C=C+1,Y(C)=N_"^"_D
 . I +$G(MODE) S Y("TIUMVD",+D)=N,Y("TIUMVDA",N)=C
 Q
BREAK ; Handle prompting
 W !,"CHOOSE 1-",TIUII W:$D(TIUMLST(TIUII+1)) !,"<RETURN> TO CONTINUE",!,"OR '^' TO QUIT" W ": " R X:DTIME
 I $S('$T!(X["^"):1,X=""&'$D(TIUMLST(TIUII+1)):1,1:0) S TIUER=1 Q
 I X="" Q
 I X=" ",$D(^DISV(DUZ,"DGPMEX",DFN)) S TIUX=^(DFN) I $D(TIUMLST("TIUMVDA",+TIUX)) S TIUOK=+$G(TIUMLST("TIUMVDA",+TIUX)) Q
 I X'=+X!'$D(TIUMLST(+X)) W !!,$C(7),"INVALID RESPONSE",! G BREAK
 S TIUOK=X
 Q
WRITE W !,$J(TIUI,4),">  ",$$DATE^TIULS(+TIUX,"AMTH DD, CCYY@HR:MIN"),?30,$S('$D(^DG(405.1,+$P(TIUX,"^",4),0)):"",$P(^(0),"^",7)]"":$P(^(0),"^",7),1:$E($P(^(0),"^",1),1,20))
 W ?55,"TO:  ",$S($D(^DIC(42,+$P(TIUX,"^",6),0)):$E($P(^(0),"^",1),1,18),1:"") I $P(TIUX,"^",18)=9 W !?23,"FROM:  ",$S($D(^DIC(4,+$P(TIUX,"^",5),0)):$P(^(0),"^",1),1:"")
 Q
