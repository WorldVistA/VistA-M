XVEMREL ;DJB/VRR**EDIT - Process Line Tags ;2017-08-15  1:42 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
 ;Determine location of cursor in relation to the line of code, and
 ;allow the editing of line tags.
 ;Return: "Q"=Quit  "C"=Continue
 ;$$LNSTART returns format "6^11"
 ;             Where: 6=Location of character where Tag starts
 ;                   11=Location of character where Line starts
 ;===================================================================
CHKADD() ;Check for valid addition. Process certain additions.
 ;KEY=String entered (^XVEMRE)
 NEW PART,TG
 I $G(FLAGVPE)'["EDIT"!(CD(NUM)=" <> <> <>") S PART="Q"
 E  S PART=$$LNSTART^XVEMRU(CD(NUM)) D  ;..TagStart^LineStart
 . I XCUR+3>$P(PART,"^",2) S PART="C" Q  ;..Cursor's on Line side
 . I XCUR+3>$P(PART,"^",1) Q  ;.............Cursor's on Tag side
 . I PART="11^11",XCUR<9 S PART="ADD" Q  ;..Start a new tag
 . S PART="Q" ;.........Cursor's in area where no adding should occur
 I PART="Q" D  ;........Redraw area where user's input printed
 . W $C(7) NEW X S X=1
 . I CD(NUM)[$C(30) S X=$S((XCUR+3)>$F(CD(NUM),$C(30)):2,1:1)
 . S DX=XCUR,DY=YCUR X XVVS("CRSR")
 . I $E(CD(NUM),XCUR+X)']"" W " "
 . E  W $E(CD(NUM),XCUR+X)
 I "C,Q"[PART Q PART ;..................Quit if [Q]uit or [C]ontinue
 I $P(PART,"^",1)=1 Q "C" ;.............Tag flush with left side
 S TG=$P(CD(NUM),$C(30),1) ;............Set TG=Line Tag
 ;-> Add new tag
 I PART="ADD" S XCUR=8,TG="       "_KEY_" " D WRITE Q "Q"
 ;-> Tag is less than 8 char & should expand into space on left side
 S TG=$E(TG,2,999) ;....................Remove space on left
 ;-> If input is at immediate left side of tag, handle differently
 I (XCUR+1)<$P(PART,"^",1) D  D WRITE Q "Q"
 . S TG=$E(TG,1,XCUR)_KEY_$E(TG,XCUR+1,999)
 S TG=$E(TG,1,XCUR-1)_KEY_$E(TG,XCUR,999)
 D WRITE
 Q "Q"
 ;
CHKDEL() ;Check for valid deletion. Process certain deletions.
 ;VK=Key struck (^XVEMRE)
 NEW L,PART,TG,XPOS
 S XPOS=$S($G(VK)="<DEL>":XCUR,1:XCUR-1)
 I $G(FLAGVPE)'["EDIT"!(CD(NUM)=" <> <> <>") W $C(7) Q "Q"
 S PART=$$LNSTART^XVEMRU(CD(NUM))
 D  ;
 . I XCUR+2>$P(PART,"^",2) S PART="C" Q  ;..Cursor's on Line side
 . I XCUR+2=$P(PART,"^",2) D  Q  ;..........Cursor's at start of line
 . . S PART=$S($G(VK)="<DEL>":"C",1:"Q")
 . I XCUR+1>$P(PART,"^",1) D  Q  ;..........Cursor's on Tag side
 . . Q:$G(VK)'="<DEL>"  I XCUR=($P(PART,"^",2)-3) S PART="Q"
 . I XCUR+1=$P(PART,"^",1),$G(VK)="<DEL>" Q  ;Delete 1st char of Tag
 . S PART="Q"
 I "C,Q"[PART W:PART="Q" $C(7) Q PART
 S TG=$P(CD(NUM),$C(30),1) ;................Set TG=Line Tag
 ;-> If Tag>9 it should collapse from the right side
 I $L(TG)>9 Q "C"
 ;-> If Tag'>9 it should collapse from the left side
 S TG=" "_$E(TG,1,XPOS)_$E(TG,XPOS+2,999)
 ;-> See if tag is deleted. If so, add line number
 I TG?1." " S L=$$LINENUM^XVEMRU(YND),TG=L-1_$J("",9-$L(L-1))
 D WRITE
 Q "Q"
 ;
WRITE ;Display adjusted tag
 S CD(NUM)=TG_$C(30)_$P(CD(NUM),$C(30),2)
 S DX=0,DY=YCUR X XVVS("CRSR")
 W @XVVS("BLANK_C_EOL") X XVVS("XY")
 W $P(CD(NUM),$C(30),1)
 W $P(CD(NUM),$C(30),2)
 D ADJOPEN1^XVEMREA
 Q
