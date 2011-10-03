XQCHK2 ; OAK-BP/BDT - Internal APIs to check Keys for options; 5/20/08
 ;;8.0;KERNEL;**427,503**;Jul 10, 1995;Build 2
 ;;"Per VHA Directive 2004-038, this routine should not be modified".
 Q
 ;; These Internal Kernel APIs are using in the routine XQCHK
 ;; to check Keys for options
 ;; 
CHCKL(XQCY0,XQDUZ) ;Entry point for checking all Locks for an option
 ;; XQCY0 is $P(^XUTL("XQO",XQDIC,"^",%XQOP),"^",2,99)
 ;; XQDUZ is IEN of user
 ;; Return XQRT: Zero or 1^Key found that user needed for the option
 S XQCY0=$G(XQCY0)
 N XQI,XQY,XQX,XQRT,XQK S (XQRT,XQX)=0
 ;check Key for the option; p457
 S XQY=$P(XQCY0,"^"),XQX=$$GETIEN(XQY)
 I +XQX S XQK=$$GET1^DIQ(19,XQX,3)
 I $G(XQK)'="",'$D(^XUSEC(XQK,XQDUZ)) S XQRT=1_"^"_XQK Q XQRT
 ;loop through higher menu options.
 S XQY=$P(XQCY0,"^",5)
 F XQI=1:1  S XQX=$P(XQY,",",XQI) Q:'XQX  D
 . I +XQX S XQK=$$GET1^DIQ(19,XQX,3) I XQK'="",'$D(^XUSEC(XQK,XQDUZ)) S XQRT=1_"^"_XQK Q
 Q XQRT
 ;
CHCKRL(XQCY0,XQDUZ) ;Entry point for checking all Reversed Locks for an option
 ;; XQCY0 is $P(^XUTL("XQO",XQDIC,"^",%XQOP),"^",2,99)
 ;; XQDUZ is IEN of user
 ;; Return XQRT: Zero or 1^Reversed Key found that user has
 S XQCY0=$G(XQCY0)
 N XQI,XQY,XQX,XQRT,XQK S (XQRT,XQX)=0
 ;check Reversed Key for the option; p457
 S XQY=$P(XQCY0,"^"),XQX=$$GETIEN(XQY)
 I +XQX S XQK=$$GET1^DIQ(19,XQX,3.01)
 I $G(XQK)'="",$D(^XUSEC(XQK,XQDUZ)) S XQRT=1_"^"_XQK Q XQRT
 ;loop through higher menu options.
 S XQY=$P(XQCY0,"^",5)
 F XQI=1:1  S XQX=$P(XQY,",",XQI) Q:'XQX  D
 . I +XQX S XQK=$$GET1^DIQ(19,XQX,3.01) I XQK'="",$D(^XUSEC(XQK,XQDUZ)) S XQRT=1_"^"_XQK Q 
 Q XQRT
 ;
GETIEN(XQNAME) ;get IEN for an option; 457
 ;; XQNAME is name of an option
 ;; Retrun XQIEN: Null or IEN if existed
 N XQIEN S XQIEN=""
 I $G(XQNAME)="" Q XQIEN
 I '$D(^DIC(19,"B",XQNAME)) Q XQIEN
 S XQIEN=$O(^DIC(19,"B",XQNAME,XQIEN))
 Q XQIEN
 ;
CHKTOPL(XQIEN,XQDUZ) ;Check Lock for the top level of the secondary options
 ;this need to be called to check the top level first when check the
 ;Locks for lower menu option because the 6th piece of ^XUTL does not
 ;contain the IEN of the top menu option.
 N XQRT,XQK S XQRT=0
 I XQIEN'=+$G(XQIEN) Q XQRT
 S XQK=$$GET1^DIQ(19,XQIEN,3)
 I $G(XQK)'="",'$D(^XUSEC(XQK,XQDUZ)) S XQRT=1_"^"_XQK
 Q XQRT
 ;
CHKTOPRL(XQIEN,XQDUZ) ;Check Reversed Lock the top level of the secondary options
 ;this need to be called to check the top level first when check the
 ;Reversed Locks for lower menu option because the 6th piece of ^XUTL does not
 ;contain the IEN of the top menu option.
 N XQRT,XQK S XQRT=0
 I XQIEN'=+$G(XQIEN) Q XQRT
 S XQK=$$GET1^DIQ(19,XQIEN,3.01)
 I $G(XQK)'="",$D(^XUSEC(XQK,XQDUZ)) S XQRT=1_"^"_XQK
 Q XQRT
