BPSJPHNM ;BHAM ISC/LJF - HL7 E-Pharm Phone Number Parser ;21-NOV-2003
 ;;1.0;E CLAIMS MGMT ENGINE;**1**;JUN 2004
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
 ;
EN(IX1,C,R) ;
 ; Called with Person Index from VA(200
 N N13,RETVAL,RETP,IX,IX2,UC,LC,PHT,SP,C3,PHD,PHDH,FLAG,PHI
 ;
 I '$G(IX1) Q ""
 I $G(IX1) S N13=$G(^VA(200,+IX1,.13))
 I $G(N13)="" Q ""
 I $G(C)="" S C="^"
 I $G(R)="" S R="~"
 ;
 ; Set up lowercase to UPPERCASE translation
 S LC="abcdefghijklmnopqrstuvwxyz"
 S UC="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 S SP=" ",C3=C_C_C
 ;
 S PHT(1)=C_"PRN"_C_"PH"_C3 ; home phone
 S PHT(2)=C_"WPN"_C_"PH"_C3 ; work phone
 S PHT(3)=C_"WPN"_C_"PH"_C3 ; 3rd phone
 S PHT(4)=C_"WPN"_C_"PH"_C3 ; 4th phone
 S PHT(5)=C_"WPN"_C_"PH"_C3 ; Commercial phone
 S PHT(6)=C_"WPN"_C_"FX"_C3 ; Fax Number
 S PHT(7)=C_"BPN"_C_"BP"_C3 ; Voice Pager Number
 S PHT(8)=C_"BPN"_C_"BP"_C3 ; Digital Pager Number
 S (PHI(9),PHI(9,1),PHI(9,2),PHI(9,3),PHI(9,4),PHI(9,5))=""
 ;
 K PHD M PHD=PHI S PHD=$G(^VA(200,IX1,.13)) I $TR(PHD,"^ ")="" Q ""
 S PHD(10)=PHD
 ; Trim leading and trailing spaces from each piece
 F IX2=1:1:8 D
 . I $TR($P(PHD,U,IX2),SP)="" S $P(PHD,U,IX2)="" Q
 . S PHDH=$P(PHD,U,IX2)
 . S $P(PHDH,$E($TR(PHDH,SP)))=""  ; remove leading spaces
 . S PHDH=$RE(PHDH),$P(PHDH,$E($TR(PHDH,SP)))="",PHDH=$RE(PHDH) ; remove trailing spaces
 . ; remove duplicate work numbers
 . I IX2>1,IX2<6 D  Q
 . . I $G(PHD(11,PHDH)) S $P(PHD,U,IX2)=""
 . . E  S PHD(11,PHDH)=IX2 S $P(PHD,U,IX2)=PHDH
 . S $P(PHD,U,IX2)=PHDH
 S PHD(10)=PHD
 ;
 ; Massage pagers into pieces 7&8
 F IX2=1:1:6 S PHDH=$P(PHD,U,IX2),FLAG="" I PHDH]"" D
 . I PHDH["BEEPER" D
 . . S FLAG="1"_$P(PHDH,"BEEPER",2,99),PHDH=$P(PHDH,"BEEPER")
 . I PHDH["BEEP" D
 . . S FLAG="1"_$P(PHDH,"BEEP",2,99),PHDH=$P(PHDH,"BEEP")
 . I PHDH["BP#" D
 . . S FLAG="1"_$P(PHDH,"BP#",2,99),PHDH=$P(PHDH,"BP#")
 . I PHDH["BP #" D
 . . S FLAG="1"_$P(PHDH,"BP #",2,99),PHDH=$P(PHDH,"BP #")
 . I PHDH["BP " D
 . . S FLAG="1"_$P(PHDH,"BP ",2,99),PHDH=$P(PHDH,"BP ")
 . I PHDH["BP" D
 . . S FLAG="1"_$P(PHDH,"BP",2,99),PHDH=$P(PHDH,"BP")
 . I FLAG D
 . . S $P(PHD,U,IX2)=PHDH,$E(FLAG)=""
 . . I $P(PHD,U,8)="" S $P(PHD,U,8)=FLAG Q
 . . I $P(PHD,U,7)="" S $P(PHD,U,7)=FLAG Q
 . . S $P(PHD,U,8)=$P(PHD,U,8)_" BP#"_FLAG
 ;
 F IX2=1:1:8 S PHD(IX2)=$P(PHD,U,IX2),PHD(IX2,1)="" I PHD(IX2)]"" D
 . S PHD(IX2,1)=$$RESOLVEP(PHD(IX2))
 . ;Init flag fields then load flags
 . M PHD(IX2,9)=PHD(9)
 ;
 S RETVAL="",RETP=0
 F IX2=1:1:8 D
 . I '$L(PHD(IX2)) Q
 . I '$L(PHD(IX2,1)) S $P(PHD(IX2,1),U,4)=PHD(IX2)
 . S PHD(IX2,1)=PHT(IX2)_PHD(IX2,1)
 . S RETP=RETP+1,$P(RETVAL,R,RETP)=PHD(IX2,1)
 . Q
 Q RETVAL
 ;
RESOLVEP(PH) ;
 ;
 N WPA,WPN,WPNH,STDN,WPT,IX,STDN,PREFIX
 ;
 S WPT=$TR(PH,LC,UC),PREFIX=0
 S $P(WPN,SP,$L(WPT))=SP,WPA=WPN
 ;
 ; Separate numerics from text
 F IX=1:1:$L(WPT) D
 . I '$E(WPT,IX),$E(WPT,IX)'=0 S $E(WPA,IX)=$E(WPT,IX)
 . E  S $E(WPN,IX)=$E(PH,IX)
 ; Quit if no numerics
 I '$L($TR(WPN,SP)) Q ""
 ;
 S WPNH=WPN   ; save a copy of the numeric data
 ;
 S $P(WPN,$E($TR(WPN,SP)))=""  ; remove leading spaces
 S WPN=$RE(WPN),$P(WPN,$E($TR(WPN,SP)))="",WPN=$RE(WPN) ; remove trailing spaces
 ; Reduce multiple spaces to single spaces
 F IX=$L(WPN):-1:1 I ($E(WPN,IX,IX+1)=(SP_SP)) S $E(WPN,IX)=""
 ;
 ; WPN contains only NUMBERS and SPACES at this point
 ; check if it is preceded by a 1 as in "1 800 345 9933"
 I $E(WPN,1,2)="1 " S $E(WPN,1,2)="",PREFIX=2
 I 'PREFIX,$E(WPN)=1 S $E(WPN)="",PREFIX=1
 ; check if it's a standard 10 digit number
 S STDN=0
 I $L($TR(WPN,SP))=10 S STDN=1 D
 . I $L(WPN)=10 D  I STDN=1 Q   ; format: 1234567890
 . . S WPN(1)=$E(WPN,1,3),WPN(2)=$E(WPN,4,6),WPN(3)=$E(WPN,7,10)
 . . I PH[WPN(1),PH[WPN(2),PH[WPN(3)
 . . E  S STDN=0
 . S STDN=1
 . I $L(WPN,SP)=3 D  I STDN Q   ; format: 123 456 7890
 . . S WPN(1)=$P(WPN,SP,1),WPN(2)=$P(WPN,SP,2),WPN(3)=$P(WPN,SP,3)
 . . I $L(WPN(1))=3,PH[WPN(1),$L(WPN(2))=3,PH[WPN(2),$L(WPN(3))=4,PH[WPN(3)
 . . E  S STDN=0
 . S STDN=1
 . I $L(WPN,SP)=2 D  I STDN=1 Q  ; Still may be salvageable
 . . S WPN(1)=$P(WPN,SP,1),WPN(2)=$P(WPN,SP,2)
 . . ; is format "123 4567890"?   area code & city/phone
 . . I $L(WPN(1))=3 S WPN(3)=$E(WPN(2),4,7),$E(WPN(2),4,7)="" Q
 . . ; is format "123456 7890"?   area/city code & phone
 . . I $L(WPN(1))=6 S WPN(3)=WPN(2),WPN(2)=$E(WPN(1),4,6),$E(WPN(1),4,6)="" Q
 . . S STDN=0 ;unsalvageable as standard number
 . S STDN=0 ;unsalvageable as standard number
 ;
 ; Quit if standard format
 I STDN Q WPN(1)_WPN(2)_C_WPN(3)
 ;
 ;Not standard, need to do some work
 ;
 F IX=1:1:$L(WPN,SP) S WPN(IX)=$P(WPN,SP,IX)
 S IX=$L(WPN,SP),WPN(0)=""
 ;
 ; add prefix back in if applicable
 I PREFIX=1,$L(WPN(1))'=10 S WPN(1)="1"_WPN(1)
 ;
 ; 1 string of digits
 I IX=1 D  Q:$L(WPN(0)) WPN(0)
 . I $L(WPN(1))<7 S WPN(0)=C_C_WPN(1) Q     ;assume it's an extension
 . I $L(WPN(1))=7 S WPN(0)=$E(WPN(1),1,3)_C_$E(WPN(1),4,7) Q  ;city code & local number
 ;
 ; 2 strings of digits
 I IX=2 D  Q:$L(WPN(0)) WPN(0)
 . ; could be city code & local number
 . I $L(WPN(1))=3,$L(WPN(2))=4 S WPN(0)=WPN(1)_C_WPN(2) Q
 . ; could be full number plus extension
 . I $L(WPN(1))=10 S WPN(0)=$E(WPN(1),1,6)_C_$E(WPN(1),7,10)_C_WPN(2)
 ;
 ; 3 strings could include extension
 I IX=3 D  Q:$L(WPN(0)) WPN(0)
 . ; "301 7933124 123"
 . I $L(WPN(1))=3,$L(WPN(2))=7 S WPN(0)=WPN(1)_$E(WPN(2),1,3)_C_$E(WPN(2),4,7)_C_WPN(3) Q
 . ; "793 3124 123"
 . I $L(WPN(1))=3,$L(WPN(2))=4 S WPN(0)=WPN(1)_C_WPN(2)_C_WPN(3)
 ;
 ; 4 strings could include extension  "301 344 2111 3424
 I IX=4 D  Q:$L(WPN(0)) WPN(0)
 . I $L(WPN(1))=3,$L(WPN(2))=3,$L(WPN(3))=4 S WPN(0)=WPN(1)_WPN(2)_C_WPN(3)_C_WPN(4)
 ;
 Q ""
