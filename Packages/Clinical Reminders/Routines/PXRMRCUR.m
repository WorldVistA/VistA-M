PXRMRCUR ;SLC/PKR - Reminder definition computing finding recursion check. ;10/24/2016
 ;;2.0;CLINICAL REMINDERS;**47**;Feb 04, 2005;Build 289
 ;
 ;==========================================
DEFCHK(RDCFIEN,DEFIEN,NPAIR,RPAIR) ;Check a definition for recursion.
 N CFPARAM,FI,NDEFIEN,RECUR
 I '$D(^PXD(811.9,DEFIEN,20,"E","PXRMD(811.4,",RDCFIEN)) Q 0
 S RECUR=0,FI=""
 F  S FI=$O(^PXD(811.9,DEFIEN,20,"E","PXRMD(811.4,",RDCFIEN,FI)) Q:(RECUR)!(FI="")  D
 . S NPAIR=NPAIR+1
 . S RPAIR(NPAIR,1)=$P(^PXD(811.9,DEFIEN,0),U,1)
 . S RPAIR(NPAIR,1,"SRC")=811.9_";"_DEFIEN_";"_FI
 . S CFPARAM=$G(^PXD(811.9,DEFIEN,20,FI,15))
 . I CFPARAM="" Q
 . S RPAIR(NPAIR,2)=CFPARAM
 . S NDEFIEN=$O(^PXD(811.9,"B",CFPARAM,""))
 . I NDEFIEN="" Q
 . S RPAIR(NPAIR,2,"SRC")=811.9_";"_NDEFIEN_";"_FI
 . I CFPARAM=RPAIR(NPAIR,1) S RECUR=1_U_RPAIR(NPAIR,1,"SRC")
 . I NPAIR>1 S RECUR=$$PAIRCHK(NPAIR,.RPAIR)
 . I RECUR Q
 . S RECUR=$$DEFCHK(RDCFIEN,NDEFIEN,.NPAIR,.RPAIR)
 Q RECUR
 ;
 ;==========================================
PAIRCHK(NPAIR,RPAIR) ;Check reminder pairs for recursion.
 N IND,RECUR
 S IND=1,RECUR=0
 F  Q:(RECUR)!(IND=NPAIR)  D
 . I (RPAIR(NPAIR,2)=RPAIR(IND,1))&(RPAIR(NPAIR,1)=RPAIR(IND,2)) S RECUR=1_U_RPAIR(IND,1,"SRC")_U_RPAIR(IND,2,"SRC")
 . S IND=IND+1
 Q RECUR
 ;
 ;==========================================
RECCHK(DEFIEN) ;When using the computed finding VA-REMINDER DEFINITION it is
 ;possible for recursion to occur if a reminder definition calls itself
 ;somewhere in the chain. These routines are used to scan a reminder
 ;definition and reminder terms used by the definition to check for
 ;recursion. If recursion is found the return value is:
 ;1^file #;IEN^file #;IEN where file # and IEN specify the source of
 ;the recursion. If no recursion is found the return value is 0.
 ;The alogrithm finds all reminder pairs and checks for the same pair
 ;twice. Here are some examples:
 ;The simplest case where reminder A calls itself is represented by
 ;the pairs (A,A) and (A,A). If A calls B and B calls A this is
 ;represented by the pairs (A,B) and (B,A). 
 N NPAIR,RDCFIEN,RECUR,RPAIR
 S RDCFIEN=$O(^PXRMD(811.4,"B","VA-REMINDER DEFINITION",""))
 S NPAIR=0
 ;Check the definition first.
 S RECUR=$$DEFCHK(RDCFIEN,DEFIEN,.NPAIR,.RPAIR)
 ;Check terms.
 I 'RECUR S RECUR=$$TERMCHK(RDCFIEN,DEFIEN,.NPAIR,.RPAIR)
 Q RECUR
 ;
 ;==========================================
TERMCHK(RDCFIEN,DEFIEN,NPAIR,RPAIR) ;Check terms used by a reminder definition.
 N CFPARAM,DEF,FI,FINDING,NDEFIEN,RECUR,TERMIEN
 I '$D(^PXD(811.9,DEFIEN,20,"E","PXRMD(811.5,")) Q 0
 S DEF=$P(^PXD(811.9,DEFIEN,0),U,1)
 S RECUR=0,TERMIEN=""
 F  S TERMIEN=$O(^PXD(811.9,DEFIEN,20,"E","PXRMD(811.5,",TERMIEN)) Q:(RECUR)!(TERMIEN="")  D
 . I '$D(^PXRMD(811.5,TERMIEN,20,"E","PXRMD(811.4,",RDCFIEN)) Q
 . S FINDING=$O(^PXD(811.9,DEFIEN,20,"E","PXRMD(811.5,",TERMIEN,""))
 . S FI=""
 . F  S FI=$O(^PXRMD(811.5,TERMIEN,20,"E","PXRMD(811.4,",RDCFIEN,FI)) Q:(RECUR)!(FI="")  D
 .. S NPAIR=NPAIR+1
 .. S RPAIR(NPAIR,1)=DEF
 .. S RPAIR(NPAIR,1,"SRC")=811.9_";"_DEFIEN_";"_FINDING
 .. S CFPARAM=$G(^PXRMD(811.5,TERMIEN,20,FI,15))
 .. S RPAIR(NPAIR,2)=CFPARAM
 .. S RPAIR(NPAIR,2,"SRC")=811.5_";"_TERMIEN_";"_FI
 .. I CFPARAM=RPAIR(NPAIR,1) S RECUR=1_U_RPAIR(NPAIR,1,"SRC")_U_RPAIR(NPAIR,2,"SRC") Q
 .. I CFPARAM="" Q
 .. I NPAIR>1 S RECUR=$$PAIRCHK(NPAIR,.RPAIR)
 .. I RECUR Q
 .. S NDEFIEN=$O(^PXD(811.9,"B",CFPARAM,""))
 .. I NDEFIEN="" Q
 .. S RECUR=$$DEFCHK(RDCFIEN,NDEFIEN,.NPAIR,.RPAIR)
 Q RECUR
 ;
 ;==========================================
TRECCHK(TERMIEN) ;Starting with a term check for recursion.
 N CFPARAM,IND,NPAIR,RDCFIEN,RECUR,RPAIR
 I '$D(^PXRMD(811.5,TERMIEN,20,"E","PXRMD(811.4,",35)) Q 0
 S RDCFIEN=$O(^PXRMD(811.4,"B","VA-REMINDER DEFINITION",""))
 S RECUR=0
 S NPAIR=0
 S IND=0
 F  S IND=$O(^PXRMD(811.5,TERMIEN,20,"E","PXRMD(811.4,",35,IND)) Q:IND=""  D
 . S CFPARAM=$G(^PXRMD(811.5,TERMIEN,20,IND,15))
 . I CFPARAM="" Q
 . S DEFIEN=$O(^PXD(811.9,"B",CFPARAM,""))
 . I DEFIEN="" Q
 . S RECUR=$$DEFCHK(RDCFIEN,DEFIEN,.NPAIR,.RPAIR)
 . I 'RECUR S RECUR=$$TERMCHK(RDCFIEN,DEFIEN,.NPAIR,.RPAIR)
 Q RECUR
 ;
