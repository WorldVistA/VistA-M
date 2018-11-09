DBALEXM ;Port Clinton, OH/SO- Clean Up Copyright Data from LEXM Global ;4:09 PM  16 Jan 2012
 ;;1.0
 ;And now for some shameless promotion:
 ;Skip Ormsby, part time employee for:
 ;Henry Elliott Company
 Q
 ;
ZAPLEXM ;
 ;Kill off all CPT data
 N FILE
 F FILE=81,81.1,81.3 D
 . N DATA
 . S DATA=^LEXM(FILE,1)
 . S $P(DATA,U,4)=0,$P(DATA,U,5)=0 ;Set last record & count to zero
 . S ^LEXM(FILE,1)=DATA
 . N IEN S IEN=1
 . F  S IEN=$O(^LEXM(FILE,IEN)) Q:'IEN  K ^LEXM(FILE,IEN) ;Kill off node
 .Q
 ;
 ;Remove CPT data from file 757.02
 N IEN S IEN=0
 F  S IEN=$O(^LEXM(757.02,IEN)) Q:'IEN  D
 . N DATA
 . S DATA=^LEXM(757.02,IEN)
 . I $L(DATA,U)'>6 Q  ;Zeroth Node has 6 or more pieces
 . S $P(DATA,U,3)="",$P(DATA,U,4)=""
 . S ^LEXM(757.02,IEN)=DATA
 . Q
 ;
 ;Caclulate new CheckSum and Node Count
 ;From Routine: LEXXGI2, Subroutine VC
 S LEXCHK=+($G(^LEXM(0,"CHECKSUM"))) ;Get current Checksum value
 S LEXNDS=+($G(^LEXM(0,"NODES"))) ;Get current Node Count
 W !,"LEXCHL=",LEXCHK,"  LEXNDS=",LEXNDS
 Q:'$D(^LEXM)!('$D(^LEXM(0)))!($O(^LEXM(0))'>0)
 N LEXCNT,LEXLC,LEXL,LEXS,LEXNC,LEXD,LEXN,LEXC,LEXGCS,LEXP,LEXT
 Q:LEXCHK'>0!(LEXNDS'>0)  S LEXL=64,(LEXCNT,LEXLC)=0,LEXS=(+(LEXNDS\LEXL))
 S:LEXS=0 LEXS=1 W:+($O(^LEXM(0)))>0 ! S (LEXC,LEXN)="^LEXM",(LEXNC,LEXGCS)=0 W "   "
 F  S LEXN=$Q(@LEXN) Q:LEXN=""!(LEXN'[LEXC)  D
 . Q:LEXN="^LEXM(0,""CHECKSUM"")"  Q:LEXN="^LEXM(0,""NODES"")"  S LEXCNT=LEXCNT+1
 . I LEXCNT'<LEXS S LEXLC=LEXLC+1 W:LEXLC'>LEXL "." S LEXCNT=0
 . S LEXNC=LEXNC+1,LEXD=@LEXN,LEXT=LEXN_"="_LEXD F LEXP=1:1:$L(LEXT) S LEXGCS=$A(LEXT,LEXP)*LEXP+LEXGCS
 . Q
 W !,"LEXGCS=",LEXGCS,"  LEXNC=",LEXNC
 S ^LEXM(0,"CHECKSUM")=LEXGCS ;Set New Checksum value
 S ^LEXM(0,"NODES")=LEXNC ;Set New Node Count
 Q
