LRDIDLE0 ;DALOI/JMC; Create audit trail of changed values ;Feb 21, 2003
 ;;5.2;LAB SERVICE;**140,171,153,286,396**;Sep 27, 1994;Build 3
 ; Called by LRVER3
 ;
INIT ;
 ; This code controls the automatic audit trail entries for CH subscripted
 ; tests which are reported and subsequently changed. Modification of this
 ; code by local stations may have Medical/Legal ramifications. Local
 ; stations are STRONGLY advised to NOT make changes.
 ;
 N LRCHDT7,LRI,LRJ,LRNEW,LROLD,LRSQ9,LRTXT,LRUSER
 ;
 S LRJ=0,LROK=1,LRCHDT7=$$FMTE^XLFDT(LRNOW7,"MZ"),LRUSER=$$USERID(.DUZ)
 ;
EVAL ;
 ;
 ; Result changed
 I $P($G(LRSA(LRSB,2)),"^") D
 . S LRNEW=$P(LRSB(LRSB),"^") S:LRNEW="" LRNEW="<no value>" ; new value
 . S LROLD=$P(LRSA(LRSB),"^") S:LROLD="" LROLD="<no value>" ; old value
 . S LRSQ9=LROLD_" by ["_$$USERID($P(LRSA(LRSB),"^",4))_"]" ; old result
 . S LRJ=LRJ+1,LRTXT(LRJ)=LRSA(LRSB,1)_" reported incorrectly as "_LRSQ9_"."
 . S LRJ=LRJ+1,LRTXT(LRJ)="Changed to "_LRNEW_" on "_LRCHDT7_" by ["_LRUSER_"]."
 ;
 ; Normalcy flag changed
 I $P($G(LRSA(LRSB,2)),"^",2) D
 . S LRNEW=$P(LRSB(LRSB),"^",2) S:LRNEW="" LRNEW="normal" D  ; new value
 . . I $P(LRSB(LRSB),"^")="canc"!($P(LRSB(LRSB),"^")="CANC") S LRNEW="canc"
 . S LROLD=$P(LRSA(LRSB),"^",2) S:LROLD="" LROLD="normal" ; old value
 . S LRSQ9=LROLD_" by ["_$$USERID($P(LRSA(LRSB),"^",4))_"]" ; old result
 . S LRJ=LRJ+1,LRTXT(LRJ)=LRSA(LRSB,1)_" flagged incorrectly as "_LRSQ9_"."
 . S LRJ=LRJ+1 D
 . . I LRNEW="canc" S LRTXT(LRJ)="Abnormal flag removed on "_LRCHDT7_" by ["_LRUSER_"]." Q
 . . S LRTXT(LRJ)="Changed to "_LRNEW_" on "_LRCHDT7_" by ["_LRUSER_"]."
 ;
 ; Check normal ranges
 I $P($G(LRSA(LRSB,2)),"^",5) D
 . N LRI,LRX,LRY,LRZ
 . S LRX=$P(LRSB(LRSB),"^",5),LRY=$P(LRSA(LRSB),"^",5)
 . ; Units changed
 . I $P(LRX,"!",7)'=$P(LRY,"!",7) D
 . . S LRNEW=$P(LRX,"!",7) S:LRNEW="" LRNEW="<no value>" ; new value
 . . S LROLD=$P(LRY,"!",7) S:LROLD="" LROLD="<no value>" ; old value
 . . S LRSQ9=LROLD_" by ["_$$USERID($P(LRSA(LRSB),"^",4))_"]" ; old value
 . . S LRJ=LRJ+1,LRTXT(LRJ)=LRSA(LRSB,1)_" units reported incorrectly as "_LRSQ9_"."
 . . S LRJ=LRJ+1,LRTXT(LRJ)="Changed to "_LRNEW_" on "_LRCHDT7_" by ["_LRUSER_"]."
 . ; Reference ranges changed
 . S LRZ(0)="^reference low^reference high^critical low^critical high^^^^^^therapeutic low^therapeutic high^"
 . F LRI=2,3,4,5,11,12 I $P(LRX,"!",LRI)'=$P(LRY,"!",LRI) D
 . . S LRNEW=$P(LRX,"!",LRI) S:LRNEW="" LRNEW="<no value>" ; new value
 . . S LROLD=$P(LRY,"!",LRI) S:LROLD="" LROLD="<no value>" ; old value
 . . S LRZ=$P(LRZ(0),"^",LRI)
 . . S LRSQ9=LROLD_" by ["_$$USERID($P(LRSA(LRSB),"^",4))_"]" ; old value
 . . S LRJ=LRJ+1,LRTXT(LRJ)=LRSA(LRSB,1)_" "_LRZ_" reported incorrectly as "_LRSQ9_"."
 . . S LRJ=LRJ+1,LRTXT(LRJ)="Changed to "_LRNEW_" on "_LRCHDT7_" by ["_LRUSER_"]."
 ;
 I LRJ D STORE
 Q
 ;
 ;
STORE ; Store comments in file #63, field #99 COMMENTS
 ;
 N DIWF,DIWL,DIWR,LRI,LRJ,LRK,LRX,X
 ;
 ; Check comment lengths and if greater than 68 break line
 S LRI=0
 F  S LRI=$O(LRTXT(LRI)) Q:'LRI  D
 . I $L(LRTXT(LRI))<69 Q
 . S X=LRTXT(LRI),DIWL=1,DIWR=68,DIWF="",LRJ=0
 . K ^UTILITY($J,"W"),LRTXT(LRI)
 . D ^DIWP
 . F  S LRJ=$O(^UTILITY($J,"W",DIWL,LRJ)) Q:'LRJ  D
 . . S LRK=LRI+(LRJ/100),LRTXT(LRK)=^UTILITY($J,"W",DIWL,LRJ,0)
 . . I $L(LRTXT(LRK))<68 Q
 . . F J=69:68:$L(LRTXT(LRK)) S LRTXT(LRK+(J/10000))=$E(LRTXT(LRK),J,J+68)
 . . S LRTXT(LRK)=$E(LRTXT(LRK),1,68)
 . K ^UTILITY($J,"W")
 ;
 S LRI=0
 F  S LRI=$O(LRTXT(LRI)) Q:'LRI  D
 . S LRX=LRTXT(LRI)
 . D FILECOM^LRVR4(LRDFN,LRIDT,LRX)
 . W !,LRX
 ;
 Q
 ;
 ;
USERID(LRDUZ) ;  Create user id for comment text
 ;
 ; Call with DUZ array by reference
 ;
 ; Returns   LRY = formatted user id (DUZ-VAxxx) where xxx = VA station #
 ;
 N LRY
 S LRY=LRDUZ
 ; If agency or facility not passed assumed agency/facility of current user
 I $G(LRDUZ("AG"))="" S LRDUZ("AG")=DUZ("AG")
 I '$G(LRDUZ(2)) S LRDUZ(2)=DUZ(2)
 ;
 I LRDUZ("AG")="V" S LRY=LRY_"-VA"_$$GET1^DIQ(4,LRDUZ(2)_",",99)
 Q LRY
