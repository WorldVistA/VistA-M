XGSA ;SFISC/VYD - screen attribute primitives ;03/15/95  13:50
 ;;8.0;KERNEL;;Jul 10, 1995
SET(XGNEWATR) ;set screen attributes return only the ESC codes
 ;ABSOLUTE setting of screen attributes to new attributes regadless
 ;of prev state.  For relative change use CHG
 ;XGNEWATR=char represents what all attributes should become ex: R1B0
 ;XGCURATR=state of all current attributes in form of a char
 S XGCURATR=XGNEWATR ;set curr attr var
 Q ^XUTL("XGATR",XGNEWATR)
 ;
CHG99(XGATR) ;XGATR=passed attribute string ie: R1B0G1
 ;RELATIVE change of screen attributes to the new ones.  Only changes attributes that were passed, retains others.  For ABSOLUTE set use SET
 N X,%,XGATRLTR,XGATRNO,XGCURBIN,XGESC,XGONOFF
 ;S XGCURBIN=$$CNV(XGCURATR)
 S XGCURBIN=^XUTL("XGATR1",XGCURATR)
 ;parse passed string, generate ESC codes
 F %=1:2:$L(XGATR) S XGATRLTR=$E(XGATR,%),XGONOFF=$E(XGATR,%+1) D
 . I XGATRLTR'="E" D  ;continue if not EMPTY
 . . S XGATRNO=$F("BIRDGU",XGATRLTR) ;get attr # to match in XGATRSET
 . . S $E(XGCURBIN,XGATRNO)=XGONOFF ;chg bin str
 . E  S XGCURBIN="00000001" ;EMPTY attr clears everything
 ;in case all prev attr got turned off, turn on EMPTY attr
 S $E(XGCURBIN,8)=$S($E(XGCURBIN,1,7)[1:0,1:1)
 ;S XGCURATR=$$CNV(XGCURBIN)
 S XGCURATR=^XUTL("XGATR1",XGCURBIN)
 Q ^XUTL("XGATR",XGCURATR) ;return escape sequence
 ;
 ;
CHG(XGATR) ;XGATR=passed attribute string ie: R1B0G1
 ;RELATIVE change of screen attributes to the new ones.  Only changes attributes that were passed, retains others.  For ABSOLUTE set use SET
 N X,%,XGATRLTR,XGATRASC,XGBIT,XGONOFF
 S XGATRASC=$A(XGCURATR)
 F %=1:2:$L(XGATR) S XGATRLTR=$E(XGATR,%),XGONOFF=$E(XGATR,%+1) D
 . I XGATRLTR'="E" D  ;continue if not EMPTY
 . . S XGBIT=2**($F("UGDRIB",XGATRLTR)-1) ;bit mask
 . . ;if attribute bit needs to change add/subtract the mask
 . . S:(XGATRASC\XGBIT#2)'=XGONOFF XGATRASC=XGATRASC+$S(XGONOFF=0:-XGBIT,1:XGBIT)
 . E  S XGATRASC=1 ;EMPTY attr clears everything
 S:XGATRASC=0 XGATRASC=1 ;if all attr got turned off, turn on EMPTY attr
 S XGCURATR=$C(XGATRASC)
 Q ^XUTL("XGATR",XGCURATR) ;return escape sequence
 ;
 ;
STAT(XGATR) ;returns the state of a specific attribute
 ;XGATR is the attribute mnemonic character. Possible values are
 ;B-blinking, I-high intensity, R-reverse, D-double wide, G-graphics
 ;U-underline, E-empty
 Q $A(XGCURATR)\(2**($F("EUGDRIB",XGATR)-2))#2
 ;
 ;
ESC(XGATR) ;return ESC codes of all attributes in XGATR
 ;XGATR=char represents what all attributes should be ex: R1B0
 N %,XGESC,X,XGBIN
 I XGATR'=XGEMPATR D  ;if setting to other than EMPTY attribute
 .;get binary representation of CURRENTATTRIBUTES and NEWATTRIBUTES
 .S XGBIN=$$CNV(XGATR)
 .S XGESC=IORESET D  ;turn off all attr & process only 1s to turn on
 ..F %=2:1:7 S X=$E(XGBIN,%) S:X XGESC=XGESC_$P(XGATRSET(%),U,2)
 E  S XGESC=IORESET
 Q XGESC
 ;
 ;
CNV(ATR) ;convert attribute from character to binary and vice-versa
 ;if $L(ATR)=8 then binary format is passed and character returned
 ;if $L(ATR)=1 then character format is passed and binary str returned
 N X,Y
 I $L(ATR)=1 S X=$A(ATR),Y="" F  S Y=(X#2)_Y,X=X\2 I 'X S Y=$E(100000000+Y,2,9) Q
 E  S Y="" F X=1:1:8 S Y=Y*2+$E(ATR,X)
 E  S Y=$C(Y)
 Q Y
