ONCOTNMC ;WISC/MLH - HELP/VALIDATION for TNM CODES ;6/16/93  09:10
 ;;2.11;ONCOLOGY;;Mar 07, 1995
 ;
VALID(TYP,COD) ;    VALIDATE a T, N, or M code - COD should be a call by reference (.COD)
 N VALID S VALID=0 ;    flag - assume invalid
 IF (TYP="T")!(TYP="N")!(TYP="M") X "S VALID=$$VALID"_TYP_"(.COD)"
 QUIT VALID
 ;
VALIDT(TCOD) ;    VALIDATE a T code - TCOD should be a call by reference (.TCOD)
 N VALIDT S VALIDT=0 ;    flag - assume invalid
 S TCOD=$TR(TCOD,"abcdisvx","ABCDISVX") ;    go to caps
 I TCOD="IS" S VALIDT=1 ;    in-situ
 E  I TCOD="X" S VALIDT=1 ;    unknown
 E  S VALIDT=$$VALIDTN(.TCOD) ;    numeric
 Q VALIDT
 ;
VALIDTN(NTCOD) ;    VALIDATE a NUMERIC T code - NTCOD should be a call by reference (.NTCOD)
 N VALIDTN S VALIDTN=0 ;    flag - assume invalid
 N NUMVAL S NUMVAL=$E(NTCOD,1) ;    numeric value of T code
 IF NUMVAL?1N,"012345"[NUMVAL D  ;    good so far, continue
 .  I $E(NTCOD,2,$L(NTCOD))="" S VALIDTN=1 ;   OK
 .  E  S VALIDTN=$$VALIDTNA(.NTCOD)
 .  Q
 ;END IF
 ;
 Q VALIDTN
 ;
VALIDTNA(ANTCOD) ;    VALIDATE a NUMERIC T code with ALPHA suffix - ANTCOD should be a call by reference (.ANTCOD)
 N VALIDTNA S VALIDTNA=0 ;    flag - assume invalid
 N ALPVAL S ALPVAL=$E(ANTCOD,2) ;    alpha suffix
 IF "ABCD"[ALPVAL D  ;    good so far, continue
 .  N ROMVAL S ROMVAL=$E(NTCOD,3,$L(ANTCOD)) ;    roman numeral suffix
 .  I "^^I^II^III^IV^"[(U_ROMVAL_U) S VALIDTNA=1 ;    OK
 .  Q
 ;END IF
 ;
 Q VALIDTNA
 ;
VALIDN(NCOD) ;    VALIDATE an N code - NCOD should be a call by reference (.NCOD)
 N VALIDN S VALIDN=0 ;    flag - assume invalid
 S NCOD=$TR(NCOD,"abcdx","ABCDX") ;    go to caps
 I NCOD="X" S VALIDN=1 ;    unknown
 E  S VALIDN=$$VALIDNN(.NCOD) ;    numeric
 Q VALIDN
 ;
VALIDNN(NNCOD) ;    VALIDATE a NUMERIC N code - NNCOD should be a call by reference (.NNCOD)
 N VALIDNN S VALIDNN=0 ;    flag - assume invalid
 N NUMVAL S NUMVAL=$E(NNCOD,1) ;    numeric value of T code
 IF NUMVAL?1N,"01234"[NUMVAL D  ;    good so far, continue
 .  IF $E(NNCOD,2,$L(NNCOD))="" S VALIDNN=1 ;   OK
 .  ELSE  D
 ..    N ALPVAL S ALPVAL=$E(NNCOD,2)
 ..    I "ABCD"[ALPVAL S VALIDNN=1
 ..    Q
 .  ;END IF
 .  ;
 .  Q
 ;END IF
 ;
 Q VALIDNN
 ;
VALIDM(MCOD) ;    VALIDATE an N code - MCOD should be a call by reference (.MCOD)
 N VALIDM S VALIDM=0 ;    flag - assume invalid
 S MCOD=$TR(MCOD,"abcdx","ABCDX") ;    go to caps
 I MCOD="X" S VALIDM=1 ;    unknown
 E  S VALIDM=$$VALIDMN(.MCOD) ;    numeric
 Q VALIDM
 ;
VALIDMN(NMCOD) ;    VALIDATE a NUMERIC N code - NMCOD should be a call by reference (.NMCOD)
 N VALIDMN S VALIDMN=0 ;    flag - assume invalid
 N NUMVAL S NUMVAL=$E(NMCOD,1) ;    numeric value of T code
 IF NUMVAL?1N,"012"[NUMVAL D  ;    good so far, continue
 .  IF $E(NMCOD,2,$L(NMCOD))="" S VALIDMN=1 ;   OK
 .  ELSE  D
 ..    N ALPVAL S ALPVAL=$E(NMCOD,2)
 ..    I "ABCD"[ALPVAL S VALIDMN=1
 ..    Q
 .  ;END IF
 .  ;
 .  Q
 ;END IF
 ;
 Q VALIDMN
