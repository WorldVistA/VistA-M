PSODIAG ;BIR/LE - Diagnosis code prompts ;02/27/04
 ;;7.0;OUTPATIENT PHARMACY;**143,219,239,268,225**;DEC 1997;Build 29
 ;Ext ref to ^XUSEC sup by DBIA 10076
 ;Ext ref to $$ICDDX^ICDCODE sup DBIA 3990
 ;Ext ref to $$STATCHK^ICDAPIU sup DBIA 3991
EN ;
 ;don't ask icd's if user doesn't hold provider key
 Q:$T(CIDC^IBBAPI)']""
 Q:'$D(^XUSEC("PROVIDER",DUZ))
 N PSODDFN S PSODDFN=$S($D(DFN):DFN,$D(PSODFN):PSODFN,1:"")  ;need to do this since PU patient update deletes DFN and in case some other function does
 I PSODDFN'="" I '$$CIDC^IBBAPI(PSODDFN) S:(+$G(PSONEW("DFLG")))&(+$G(PSOEDIT)=1)&('$D(DA)) PSONEW("DFLG")=0 Q  ;is CIDC activated; does patient have insurance
 ;new variables and initialize variables based on CPRS or backdoor order.
 N DX,POP,I,J,X,Y,Z,OLD,OLDI,SOLDI,NEW,TNEW,RAR,CPRS,FILDAT,STATCHK,STATCHK2
 I '$G(PSOX("IRXN")) N PSOX S:$G(PSORXED("IRXN")) PSOX("IRXN")=PSORXED("IRXN")
 K DIC
 S CPRS=0
 I $G(PSORXED) S RAR="PSORXED",@RAR@("DFLG")=0,PSORXED("FLD",39.3)=""
 E  S RAR="PSONEW",@RAR@("DFLG")=0 I $G(ORD) D
 . I $D(^PS(52.41,ORD)) S CPRS=1 M PSONEW("ICD")=PSORXED("ICD") K PSORXED("ICD"),PSORXED("FLD",39.3)
 ;
 S FILDAT="",FILDAT=DT I $G(PSOX("IRXN")) S FILDAT=$$GET1^DIQ(52,PSOX("IRXN")_",","22","I")
 ;display any previously entered ICD's
 W !!,"Previously entered ICD-9 diagnosis codes: "
 I 'CPRS D  ;&(RAR="PSORXED"!(RAR="PSONEW")) D
 . I $D(PSOX("IRXN")) I '$D(PSORXED("ICD")) I $D(^PSRX(PSOX("IRXN"),"ICD")) F I=1:1:8 Q:'$D(^PSRX(PSOX("IRXN"),"ICD",I,0))  D
 .. S OLD(I)=$$GET1^DIQ(52.052311,I_","_PSOX("IRXN")_",",".01")
 .. S OLDI(I)=$$GET1^DIQ(52.052311,I_","_PSOX("IRXN")_",",".01","I")
 . I ($D(@RAR@("ICD"))&('$D(OLD)))!($G(PSOCOPY)) D
 .. F I=1:1:8 Q:'$D(@RAR@("ICD",I))  I @RAR@("ICD",I)'="" S OLDI(I)=@RAR@("ICD",I) D
 ... S OLD(I)=$P(^ICD9(OLDI(I),0),"^",1)
 ... S J=I-1 I I=1 W OLD(I) Q
 . F I=1:1:8 Q:'$D(OLD(I))  D WRITE
 E  I CPRS D
 . I '$G(PSONEW("ICD")) F I=1:1:8 Q:'$D(^PS(52.41,ORD,"ICD",I,0))  D
 .. S OLD(I)=$$GET1^DIQ(52.41311,I_","_ORD_",",".01")
 .. S OLDI(I)=$$GET1^DIQ(52.41311,I_","_ORD_",",".01","I")
 . I $D(PSONEW("ICD")) K OLD,OLDI D
 .. F I=1:1:8 Q:'$D(PSONEW("ICD",I))  S OLDI(I)=PSONEW("ICD",I) D
 ... S OLD(I)=$P(^ICD9(OLDI(I),0),"^",1)
 . F I=1:1:8 Q:'$D(OLD(I))  D WRITE
 M SOLDI=OLDI
 ;
EN2 ;ask for ICD's or display previously entered ones for editing
 ;note: because ICD's are not longer required, could not use standard
 ;       FileMan calls everywhere because of need to control deleted
 ;       entries and cross-references.
 W !
 F I=1:1:8 D  Q:+$G(Y)=-1!(@RAR@("DFLG")) 
 . I '$G(PSORXED)&('$G(CPRS)) S RAR="PSONEW"
 .K DIC S DIC("A")=$S(I=1:"Select Primary ICD-9 Code: ",1:"Select Secondary ICD-9 Code: ")
 . I $D(OLD(I)),(OLD(I)'="") S DIC("B")=OLD(I)
 . S X="" W !,DIC("A") D  R X:60   ;did this so that I have control of the deletes
 .. I $D(OLD(I)),(OLD(I)'="") W OLD(I)_"// "
 . I $D(OLD(I)) S:X="" X=OLD(I)
 . I X="" S Y=-1 Q
 . I X["?" W !,"Enter a valid ICD-9 diagnosis code." S I=1-1 Q
 . I X="@" D DELETE Q
 . I X="^" S Y=-1 Q
 . K DIC S DIC=80,DIC(0)="EMZQ"
 . ;S DIC("S")="I $P($$ICDDX^ICDCODE(Y,FILDAT),U,10)&($P($$ICDDX^ICDCODE(Y,FILDAT),U,17)>$P($$ICDDX^ICDCODE(Y,FILDAT),U,12))"
 . S DIC("S")="I $$STATCHK^PSODIAG(Y,FILDAT)"
 . K DTOUT,DUOUT D ^DIC K DIC
 . I X="^" S I=I-1,Y="" Q
 . I $G(DUOUT)!($G(DTOUT)) S Y=-1,X="^" Q
 . I +Y=-1&(X'=""!(X'="^")) I $D(^ICD9("BA",X)) S I=I-1,(X,Y)="" Q  ;user said No to are you sure ?.
 . I Y=-1&(X?1A.A) S I=I-1,Y="" Q  ;user said not to Yes? question.
 . I Y'=-1 D  I STATCHK2=1 S I=I-1,Y="" Q
 .. S (STATCHK,STATCHK2)="",STATCHK=$$STATCHK^ICDAPIU($P(Y,U,2),FILDAT) D
 ... I $P(STATCHK,"^",2)=-1 W !!,"Invalid ICD-9 diagnosis code.  Please choose another.",! S STATCHK2=1 Q
 ... I +STATCHK=0 W !!,"Inactivated ICD-9 Diagnosis Code.  Please choose another.",! S STATCHK2=1 Q
 . I +Y=-1 S I=I-1,Y="" W !!,"Invalid or inactivated ICD-9 diagnosis code.  Please choose another.",! Q
 . S (POP,J)=0 F J=1:1:I D
 ..I $G(DX(J))=+Y W $C(7),!," Duplicate entry.  Please select a different ICD-9 diagnosis code.",! S I=I-1,(Y,X)="",POP=1
 . Q:POP
 . S NEW("ICD",I)=$P(Y,U,1),DX(I)=+Y
 ;
 ;resequence entered ICD's and removed deleted ones from file
 ;I X="^"&(RAR="PSONEW")&('CPRS) S @RAR@("DFLG")=0 K DUOUT,DTOUT,Y,X Q
 ;
 I '$D(NEW("ICD")) I $D(OLDI) M NEW("ICD")=OLDI ;if user ^ out on first icd
 K PSOICDD I '$D(NEW("ICD"))&($G(PSOCOPY)) S PSOICDD=1
 ;
 S J=0 F I=1:1:8 Q:'$D(NEW("ICD",I))  I NEW("ICD",I)'="" S J=J+1,@RAR@("ICD",J)=NEW("ICD",I)
 S TNEW=I
 I X="^" D  ;if up arrow out, set all icd's past ^ point into array
 . ;S Y=TNEW-1 F  S Y=$O(OLDI(Y)) Q:Y=""  S J=J+1,@RAR@("ICD",J)=OLDI(Y)
 . K @RAR@("ICD") S Y="" F  S Y=$O(SOLDI(Y)) Q:Y=""  S @RAR@("ICD",Y)=SOLDI(Y)
 . K PSORXED("FLD",39.3)  ;7/12/04
 I $G(CPRS) K PSORX("ICD") M PSORXED("ICD")=@RAR@("ICD"),PSORX("ICD")=@RAR@("ICD")
 I $G(PSORXED) K PSORX("ICD") M PSORX("ICD")=@RAR@("ICD")
 I '$D(@RAR@("ICD"))&(CPRS) S PSONEW("IDFLG")=1 ;user deleted all in finish/complete order
 Q:(RAR="PSONEW")
 I '$D(@RAR@("ICD"))&('CPRS)&($D(^PSRX(PSOX("IRXN"),"ICD",1,0))) S PSORXED("IDFLG")=1  ;user deleted all
 Q
 ;
 ;called from above to write previously entered ICD's to screen.
WRITE S J=I-1 I I=1 W !,?10,"Primary: ",OLD(I),?30,$P($$ICDDX^ICDCODE(OLD(I),FILDAT),U,4) Q
WRITE2 I I=2 W !,?3,"Secondaries #"_J_": ",OLD(I),?30,$P($$ICDDX^ICDCODE(OLD(I),FILDAT),U,4) Q
 I I>2 W !,?15,"#"_J_": ",OLD(I),?30,$P($$ICDDX^ICDCODE(OLD(I),FILDAT),U,4)
 Q
STATCHK(ICDIEN,FILDAT) ;called from above to check active/inactive date during FileMan call.
 N X S X=""
 S ICDIEN=$P(^ICD9(ICDIEN,0),"^",1) S X=$$STATCHK^ICDAPIU(ICDIEN,FILDAT)
 Q +X
DELETE ;called from above to verify delete with user and to delete said entries
 W !,"SURE YOU WANT TO DELETE? " S X="" R X:30 S X=$TR(X,"yn","YN")
 I X'="Y"&(X'="N") W !,"Enter Y or N" G DELETE
 I X="N" S I=I-1 Q
 F J=I:1:8 Q:'$D(OLDI(J))  D
 . I $D(OLDI(J+1)) S OLDI(J)=OLDI(J+1),OLD(J)=OLD(J+1) D
 .. I CPRS&($D(PSONEW("ICD",J+1))) S PSONEW("ICD",J)=PSONEW("ICD",J+1)
 .. E  I CPRS&('$D(PSONEW("ICD",J+1))) S PSONEW("ICD",J)=OLDI(J+1)
 .. I $G(PSOCOPY) D
 ... I ($D(PSONEW("ICD",J+1))) S PSONEW("ICD",J)=PSONEW("ICD",J+1)
 ... I ($D(PSORXED("ICD",J+1))) S PSORXED("ICD",J)=PSORXED("ICD",J+1)
 . E  K OLD(J),OLDI(J),PSONEW("ICD",J),PSORXED("ICD",J)
 . ;I CPRS!($G(PSOCOPY)) K PSONEW("ICD",J),PSORXED("ICD",J)
 S I=I-1,(X,Y)=""
 Q
 ;
ICD ;called from PSON52 cause PSON52'S too large.  Stores ICD info for new Rx's (CPRS and backdoor) using variables from copy function and new order functions.
 N D,DDATA,ICD,II
 I $G(PSOCOPY)&('$D(PSOX("ICD")))&('$G(PSOICDD)) D
 . S D=0 F D=1:1 Q:'$D(PSOX("ICD",D))
 . F D=D:1:8 K ^PSRX(PSOX("IRXN"),"ICD",D,0)  ;remove any icd's del
 . I $D(^PSRX(PSOX("OIRXN"),"ICD",0)) F D=1:1:8 Q:'$D(^PSRX(PSOX("OIRXN"),"ICD",D,0))  S PSOX("ICD",D)=$P(^PSRX(PSOX("OIRXN"),"ICD",D,0),U,1)
 I $G(ORD) I $D(^PS(52.41,ORD,0))&($D(PSORX("ICD"))) M PSOX("ICD")=PSONEW("ICD")
 I $D(PSOX("ICD")) F D=1:1:8 Q:'$D(PSOX("ICD",D))  S ICD=$G(PSOX("ICD",D)) D
 . S DDATA=ICD_"^"_$G(PSOANSQ("VEH"))_"^"_$G(PSOANSQ("RAD"))_"^"_$S(PSOSCP>49:$G(PSOANSQ("SC>50")),PSOSCP<50&(PSOSCP'=""):$G(PSOANSQ("SC")),1:"")_"^"_$G(PSOANSQ("PGW"))_"^"_$G(PSOANSQ("MST"))_"^"_$G(PSOANSQ("HNC"))_"^"_$G(PSOANSQ("CV"))
 . S DDATA=DDATA_"^"_$G(PSOANSQ("SHAD"))
 . I $P($G(^PS(53,+$G(PSONEW("PATIENT STATUS")),0)),"^",7)=1 I PSOSCP<50&($D(PSOANSQ("SC>50"))) S $P(DDATA,"^",4)=PSOANSQ("SC>50")  ;for times when sc has no % defined.
 . S ^PSRX(PSOX("IRXN"),"ICD",D,0)=DDATA,II=D
 E  S D=1 D
 . S DDATA="^"_$G(PSOANSQ("VEH"))_"^"_$G(PSOANSQ("RAD"))_"^"_$S(PSOSCP>49:$G(PSOANSQ("SC>50")),PSOSCP<50&(PSOSCP'=""):$G(PSOANSQ("SC")),1:"")
 . S DDATA=DDATA_"^"_$G(PSOANSQ("PGW"))_"^"_$G(PSOANSQ("MST"))_"^"_$G(PSOANSQ("HNC"))_"^"_$G(PSOANSQ("CV"))_"^"_$G(PSOANSQ("SHAD"))
 . S ^PSRX(PSOX("IRXN"),"ICD",D,0)=DDATA,II=D
 . I $P($G(^PS(53,+$G(PSONEW("PATIENT STATUS")),0)),"^",7)=1 I PSOSCP<50&($D(PSOANSQ("SC>50"))) S $P(^PSRX(PSOX("IRXN"),"ICD",D,0),"^",4)=PSOANSQ("SC>50")
 S ^PSRX(PSOX("IRXN"),"ICD",0)="^52.052311P^"_II_"^"_II
 K PSOX("ICD"),PSORXED("ICD"),PSONEW("ICD"),PSORX("ICD")
 Q
 ;
UPDATE ;was in PSOORED6; now called from PSOORED6; removes deletes for edits and stores data.
 ;
 N TNEW,DA,DIK,SCEI,I,II
 S DA=PSORXED("IRXN")
 I '$D(PSORXED("ICD"))&($G(PSORXED("IDFLG"))) D  K PSORXED("IDFLG") Q
 . I $D(^PSRX(PSORXED("IRXN"),"ICD",1,0)) D
 .. S TNEW=2 K ^PSRX(PSORXED("IRXN"),"ICD","B") S $P(^PSRX(PSORXED("IRXN"),"ICD",1,0),U,1)=""
 .. F I=TNEW:1:8 Q:'$D(^PSRX(PSORXED("IRXN"),"ICD",I,0))  S DIK="^PSRX("_PSORXED("IRXN")_","_$C(34)_"ICD"_$C(34)_",",DA=I,DA(1)=PSORXED("IRXN") D ^DIK K DA,DIK
 ;
 I $D(PSORXED("ICD")) D
 . S SCEI=$G(^PSRX(DA,"ICD",1,0)),$P(SCEI,"^")=""
 . K ^PSRX(DA,"ICD")
 . F I=1:1:8 Q:'$D(PSORXED("ICD",I))  S $P(SCEI,"^")=PSORXED("ICD",I),^PSRX(DA,"ICD",I,0)=SCEI,^PSRX(DA,"ICD","B",$P(SCEI,"^"),I)="",II=I
 . S ^PSRX(DA,"ICD",0)="^52.052311P^"_II_U_II
 Q
 ;
CSET ;Called from PSOHLNEW due to it's routine size.  Requires PSOICD & PENDING variable.  Sets ICD node for orders passed from CPRS.
 N EE,EEE
 S (EE,EEE)=0 F  S EE=$O(PSOICD(EE)) Q:EE=""  D
 .S EEE=EEE+1,^PS(52.41,PENDING,"ICD",EEE,0)=PSOICD(EE) S:$P(PSOICD(EE),"^")'="" ^PS(52.41,PENDING,"ICD","B",$P(PSOICD(EE),"^"),EEE)=""
 .S ^PS(52.41,PENDING,"ICD",0)="^52.41311PA"_U_EEE_U_EEE
 Q
