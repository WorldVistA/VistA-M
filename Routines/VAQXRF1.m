VAQXRF1 ;ALB/JRP - X-REF CODES FOR PDX;25-NOV-92
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
AB(IFN,SET,FNUM,OLDX) ;AB* X-REF FOR ENCRYPTED FIELDS FILE (#394.73)
 ;INPUT  : IFN - Internal file number of record
 ;         SET - If 1, set cross reference
 ;               If 0, kill cross reference (DEFAULT)
 ;         FNUM - Only valid for KILLS
 ;                The field number that was changed
 ;         OLDX - Only valid for KILLS
 ;                The previous value
 ;OUTPUT : 0 - Cross reference was set/killed
 ;        -1 - Cross reference not set/killed
 ;        -2 - Bad input
 ;
 ;CHECK INPUT & RECORD EXISTANCE
 Q:($G(IFN)="") -2
 S SET=+$G(SET)
 Q:('$D(^VAT(394.73,IFN))) -2
 Q:(('SET)&('$D(FNUM))&('$D(OLDX))) -2
 ;DECLARE VARIABLES
 N FILE,FIELD,ZERO
 ;GET INFO FOR X-REF & QUIT IF ANY PART IS NULL
 S ZERO=$G(^VAT(394.73,IFN,0))
 Q:(ZERO="") -1
 S FILE=$P(ZERO,"^",2)
 I ('SET) S:(FNUM=.02) FILE=OLDX
 Q:(FILE="") -1
 S FIELD=$P(ZERO,"^",3)
 I ('SET) S:(FNUM=.03) FIELD=OLDX
 Q:(FIELD="") -1
 ;SET X-REF
 S:(SET) ^VAT(394.73,"A-NCRYPT",FILE,FIELD,IFN)=""
 ;KILL X-REF
 K:('SET) ^VAT(394.73,"A-NCRYPT",FILE,FIELD,IFN)
 Q 0
 ;
AC(IFN,SET,FNUM,OLDX) ;AC* X-REF FOR DATA FILE (#394.62)
 ;INPUT  : IFN - Internal file number of record
 ;         SET - If 1, set cross reference
 ;               If 0, kill cross reference (DEFAULT)
 ;         FNUM - Only valid for KILLS
 ;                The field number that was changed
 ;         OLDX - Only valid for KILLS
 ;                The previous value
 ;OUTPUT : 0 - Cross reference was set/killed
 ;        -1 - Cross reference not set/killed
 ;        -2 - Bad input
 ;
 ;
 ;CHECK INPUT & RECORD EXISTANCE
 Q:($G(IFN)="") -2
 S SET=+$G(SET)
 Q:('$D(^VAT(394.62,IFN))) -2
 Q:(('SET)&('$D(FNUM))&('$D(OLDX))) -2
 ;DECLARE VARIABLES
 N TRANS,SEG,ZERO
 ;GET INFO FOR X-REF & QUIT IF ANY PART IS NULL
 S ZERO=$G(^VAT(394.62,IFN,0))
 Q:(ZERO="") -1
 S SEG=$P(ZERO,"^",2)
 I ('SET) S:(FNUM=.02) SEG=OLDX
 Q:(SEG="") -1
 S TRANS=$P($G(^VAT(394.62,IFN,"TRNS")),"^",1)
 I ('SET) S:(FNUM=40) TRANS=OLDX
 Q:(TRANS="") -1
 ;SET X-REF
 S:(SET) ^VAT(394.62,"A-SEGMENT",TRANS,SEG,IFN)=""
 ;KILL X-REF
 K:('SET) ^VAT(394.62,"A-SEGMENT",TRANS,SEG,IFN)
 Q 0
 ;
