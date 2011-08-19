PSGMUTL ;BIR/MV-UTLILITY USE FOR THE MAR AND MEDWS. ;15 SEP 97 / 2:10 PM 
 ;;5.0; INPATIENT MEDICATIONS ;**50,104,110,111,131**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; 
MARFORM ;Prompt for the MAR form (Blank and Non-blank)
 S DIR(0)="SA^1:Print Blank MARs only;2:Print Non-Blank MARs only;3:Print both Blank and Non-Blank MARs"
 S DIR("A")="Select the MAR forms: ",DIR("B")="3"
 S DIR("?")=""
 S DIR("?",1)="Enter 1 to print BLANK (no data) MARs for the patient(s) you select."
 S DIR("?",2)="Enter 2 to print MARs complete with orders."
 S DIR("?",3)="Enter 3 to print both the blank MARs and the MARs complete with orders."
 S DIR("?",4)="Enter an  '^' to exit this option now."
 D ^DIR S PSGMARB=$S($D(DIRUT):0,1:Y)
 Q
BLANK(LEN) ;
 NEW X
 S $P(X," ",LEN)=" "
 Q $G(X)
 ;
TXT(TXT,LEN)   ;
 ;* Input: TXT = TXT string
 ;*        LEN = format length
 ;* Output: MARX array.
 ;*
 NEW OLD,X1,Y D SPLIT K MARX
 S X=0,X1=1,Y="" F  S X=$O(OLD(X)) Q:'X  D
 . I $L(Y_OLD(X))>LEN S MARX(X1)=Y,X1=X1+1,Y="" D
 .. I $E(MARX(X1-1),$L(MARX(X1-1)))'=" " Q
 .. S MARX(X1-1)=$E(MARX(X1-1),1,$L(MARX(X1-1))-1)
 . S Y=Y_OLD(X)
 S:Y]"" MARX(X1)=Y
 S MARX=X1
 Q
 ;
SPLIT ;* Split a word string into individual words.
 ;* Output: OLD(X)
 ;*
 NEW BSD,NEW,X,X1,Y
 S OLD(1)=TXT Q:$L(TXT)<LEN
 F BSD=" ","/","-" S:'$O(OLD(0)) OLD(1)=TXT D:TXT[BSD DELIM(BSD)
 I '$O(OLD(1)),($L(TXT)>LEN) D LEN(1,TXT) K OLD D
 . F X=0:0 S X=$O(NEW(X)) Q:'X  S OLD(X)=NEW(X)
 Q
LEN(X1,OLD) ;* Wrap word around if it doesn't fit the display length
 NEW X
 Q:$L(OLD)'>LEN
 S X=$E(OLD,1,($L(OLD)-1)) I X["/"!((X["-")&(X'["ON-CALL")) Q
 I $L(OLD)>LEN F X=1:1 S NEW(X1)=$E(OLD,((LEN*X)-LEN+1),(LEN*X)),X1=X1+1 Q:($L(OLD)'>(LEN*X))
 Q
DELIM(BSD) ;* BSD=" ","/","-"
 K NEW
 S X=0,X1=0 F  S X=$O(OLD(X)) Q:'X  K ONCALL F Y=1:1:$L(OLD(X),BSD) D
 . Q:($G(ONCALL)=Y)   ; If ON-CALL is delimited string, ignore
 . S X1=X1+1
 . S NEW(X1)=$P(OLD(X),BSD,Y)
 . I $L(OLD(X),BSD)>1,(Y<$L(OLD(X),BSD)) S NEW(X1)=NEW(X1)_BSD
 . I BSD="-",OLD(X)["ON-CALL" D   ;If dashes, check for ON-CALL
 .. S NEW(X1)=OLD(X),ONCALL=Y+1   ;Keep ON-CALL intact
 . D LEN(.X1,NEW(X1))
 K OLD F X=0:0 S X=$O(NEW(X)) Q:'X  S OLD(X)=NEW(X)
 Q
 ;
MARLB(LEN)         ;
 ;;;LEN=LENGTH
 NEW L,X,TXT K MARLB,DRUGNAME,ON S ON=PSGORD D ONHOLD^PSGMMAR2
 S L=1
 S MARLB(L)=$$BLANK(6)_"|"_$$BLANK(12)_"|",L=L+1
 I $G(PST)["CZ"!($G(PST)["OZ") S MARLB(L)=PSGLOD_" | P E N D I N G"
 E  S MARLB(L)=PSGLOD_" |"_PSGLSD_" |"_PSGLFD
 I $G(ONHOLD) S MARLB(L)=PSGLOD_" | O N  H O L D "
 S MARLB(L)=$$SETSTR^VALM1("("_$E(PPN)_$E(PSSN,8,12)_")",MARLB(L),40,7)
 S L=L+1
 D DRGDISP^PSJLMUT1(PSGP,+PSGORD_$S(PSGORD["P":"P",1:"U"),45,39,.DRUGNAME,0)
 F X=0:0 S X=$O(DRUGNAME(X)) Q:'X  S MARLB(L)=DRUGNAME(X)_$S(X=1:$$BLANK(47-$L(DRUGNAME(X)))_PSGLST,1:""),L=L+1
 D TXT^PSGMUTL(PSGLSI,LEN)
 S X=0 F  S X=$O(MARX(X)) Q:'X  S MARLB(L)=MARX(X),L=L+1
 K MARX
 I $G(PSGP),$G(PSGORD),(PSGLRN]""),(PSGLRN'="O") D
 .N ND4 S ND4=$S(PSGORD["U":$G(^PS(55,PSGP,5,+PSGORD,4)),PSGORD["P":$G(^PS(53.1,+PSGORD,4)),1:"")
 .N PSGLREN,PSGLRNDT S PSGLREN=+$$LASTREN^PSJLMPRI(PSGP,PSGORD),PSGLRNDT=$P(ND4,"^",2) I PSGLREN,PSGLRNDT I PSGLREN>PSGLRNDT S PSGLRN=""
 S X=$E("WS",1,PSGLWS*2)_$S(PSGLSM:$E("HSM",PSGLSM,3),1:"")_$E("NF",1,PSGLNF*2)
 I X="",($L(MARLB(L-1))<30),(L=7) S L=L-1 D
 . S X=MARLB(L)_$$BLANK(29-$L(MARLB(L)))_"RPH: "_$S(PSGLRPH]""&(PSGLRPH'="0"):PSGLRPH,1:"_____")
 . S X=X_$$BLANK(39-$L(X))_"RN: "_$S(PSGLRN]""&(PSGLRN'="0"):PSGLRN,1:"_____")
 . S MARLB(L)=X
 E  D
 . S:L=5 MARLB(5)="",L=6
 . S X=$E("WS",1,PSGLWS*2)
 . S X=X_$$BLANK(4-$L(X))_$S(PSGLSM:$E("HSM",PSGLSM,3),1:"")
 . S X=X_$$BLANK(8-$L(X))_$E("NF",1,PSGLNF*2)
 . S X=X_$$BLANK(29-$L(X))_"RPH: "_$S(PSGLRPH]""&(PSGLRPH'="0"):PSGLRPH,1:"____")
 . S X=X_$$BLANK(39-$L(X))_"RN: "_$S(PSGLRN]""&(PSGLRN'="0"):PSGLRN,1:"_____")
 . S MARLB(L)=X
 S MARLB=L
 I MARLB>6!($G(TS)>6) D MARLB2
 Q
 ;
MARLB2 ;Split array into 2 labels.
 ;TS array must be defined. (TS^PSGMAR3(ADMIN TIMES))
 NEW INIT,X,Y
 S INIT=MARLB(MARLB),Y=6
 F X=6:1:MARLB S X(X)=MARLB(X)
 F X=6:1:($S(MARLB>TS:MARLB,1:TS)-1) D
 . I (X#6)=0 S MARLB(X)="See next label for continuation" Q
 . I Y<(MARLB) S MARLB(X)=X(Y),Y=Y+1 Q
 . S MARLB(X)=""
 S X=X+1 F Y=Y:1:MARLB-1 S MARLB(X)=$G(X(Y)),X=X+1
 F X=X:0 Q:(X#6)=0  S MARLB(X)="",X=X+1
 S MARLB(X)=INIT,MARLB=X
 Q
 N X F X=6:1:MARLB S X(X+1)=MARLB(X)
 S MARLB(6)="See next label for continuation"
 F X=7:1:MARLB S MARLB(X)=X(X)
 F X=X+1:1:11 S MARLB(X)=""
 S MARLB(12)=X(MARLB+1)
 S MARLB=12
 Q
 ;
