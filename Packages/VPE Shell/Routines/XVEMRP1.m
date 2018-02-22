XVEMRP1 ;DJB/VRR**Cut,Copy,Paste ;2017-08-15  4:25 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
CUT ;Save lines to clipboard, then delete
 ;<ESCX> Key combination
 I $D(^TMP("XVV","SAVE",$J)) D SAVE,DELETE()
 Q
 ;
COPY ;Save lines to clipboard
 ;<ESCC> Key combination
 I $D(^TMP("XVV","SAVE",$J)) D SAVE ;.......Line save
 I $D(^TMP("XVV","SAVECHAR",$J)) D SAVE1 ;..Character save
 D CLEARALL^XVEMRP
 Q
 ;
PREPASTE ;Make sure a paste occurs after last of scrolled lines.
 NEW DATA,TMP,OLDYND
 S (TMP,OLDYND)=YND
 F  S TMP=$O(^TMP("XVV","IR"_VRRS,$J,TMP)) Q:TMP'>0  S DATA=^(TMP) Q:DATA[$C(30)!(DATA=" <> <> <>")!(DATA']"")  S YND=YND+1
 D PASTE
 S YND=OLDYND
 Q
 ;
PASTE ;Paste lines from clipboard to current routine
 ;<ESCV> Key combination
 ;
 Q:'$D(^XVEMS("E","SAVEVRR",$J))
 I YND>1,$G(^TMP("XVV","IR"_VRRS,$J,YND))=" <> <> <>" W $C(7) Q
 ;
 NEW CNT,END,I,SPREAD,START
 F SPREAD=1:1 Q:$G(^XVEMS("E","SAVEVRR",$J,SPREAD))']""
 S SPREAD=SPREAD-1
 S END=$O(^TMP("XVV","IR"_VRRS,$J,""),-1)
 F I=(END+SPREAD):-1:YND+SPREAD D  ;
 . S ^TMP("XVV","IR"_VRRS,$J,I)=^TMP("XVV","IR"_VRRS,$J,I-SPREAD)
 S CNT=0,START=YND+1
 ;-> If there is no code in this rtn, paste to starting line.
 S:$G(^TMP("XVV","IR"_VRRS,$J,YND))=" <> <> <>" START=YND
 F I=START:1 S CNT=CNT+1 D  Q:CNT=SPREAD
 . S ^TMP("XVV","IR"_VRRS,$J,I)=^XVEMS("E","SAVEVRR",$J,CNT)
 D RENUMBER
 Q
 ;
SAVE ;Save highlighted line code to clipboard
 NEW CNT,X
 S CNT=1,X=0
 F  S X=$O(^TMP("XVV","SAVE",$J,X)) Q:X'>0  D  ;
 . S ^XVEMS("E","SAVEVRR",$J,CNT)=^TMP("XVV","SAVE",$J,X)
 . S CNT=CNT+1
 S ^XVEMS("E","SAVEVRR",$J,CNT)=""
 S ^XVEMS("E","SAVEVRR",$J)="LINE"
 Q
 ;
SAVE1 ;Save highlighted character code to clipboard
 S ^XVEMS("E","SAVEVRR",$J,1)=$G(^TMP("XVV","SAVECHAR",$J))
 S ^XVEMS("E","SAVEVRR",$J,2)=""
 S ^XVEMS("E","SAVEVRR",$J)="CHAR"
 Q
 ;
DELETE(QUIT) ;Delete nodes from scroll array
 ;If QUIT=1 don't do DELETE1. Allows other rtns to use this code.
 ;
 Q:'$D(^TMP("XVV","SAVE",$J))
 ;
 NEW END,I,SPREAD,START,STOP
 S START=$O(^TMP("XVV","SAVE",$J,""))
 S STOP=$O(^TMP("XVV","SAVE",$J,""),-1)
 S SPREAD=STOP-START+1
 S END=$O(^TMP("XVV","IR"_VRRS,$J,""),-1)
 F I=START:1:END-SPREAD D  ;
 . S ^TMP("XVV","IR"_VRRS,$J,I)=^TMP("XVV","IR"_VRRS,$J,I+SPREAD)
 F I=END-SPREAD+1:1:END KILL ^TMP("XVV","IR"_VRRS,$J,I)
 D RENUMBER
 KILL ^TMP("XVV","SAVE",$J)
 Q:$G(QUIT)
DELETE1 ;If highlight made by cursor up, keep cursor where it is
 I YND'<START S XVVT("TOP")=YND-(SPREAD+(YND-XVVT("TOP")))
 S YND=XVVT("TOP")+YCUR-1 ;..Reset YND to account for deleted lines
 I XVVT("TOP")<1 S (XVVT("TOP"),YCUR,YND)=1
 Q
 ;
RENUMBER ;Renumber scroll array
 NEW L,L1,NUM,NUM1,ONE,TMP,TWO,X
 S (NUM,X)=0
 F  S X=$O(^TMP("XVV","IR"_VRRS,$J,X)) Q:X'>0  D  ;
 . S TMP=^(X) I TMP[$C(30) D  ;...Number lines
 . . S NUM=NUM+1,NUM1=+TMP Q:NUM1'>0  S L=$L(NUM),L1=$L(NUM1)
 . . I L>L1!(L=L1) S ONE="",TWO=$L(NUM)+1
 . . E  S ONE=$J("",L1-L),TWO=L1+1
 . . S TMP=NUM_ONE_$E(TMP,TWO,999)
 . S ^TMP("XVV","IR"_VRRS,$J,X)=TMP
 S VRRHIGH=NUM,FLAGSAVE=1
 Q
 ;
ESCD ;User hit <ESC>D to delete current line
 I $D(^TMP("XVV","SAVE",$J)) W $C(7) Q
 I $G(^TMP("XVV","IR"_VRRS,$J,YND))=" <> <> <>" W $C(7) Q
 NEW I,TMP
 F I=YND:-1:1 S ^TMP("XVV","SAVE",$J,I)=$G(^TMP("XVV","IR"_VRRS,$J,I)) Q:^(I)[$C(30)
 F I=YND+1:1 S TMP=$G(^TMP("XVV","IR"_VRRS,$J,I)) Q:TMP']""!(TMP[$C(30))!(TMP=" <> <> <>")  S ^TMP("XVV","SAVE",$J,I)=TMP
 D DELETE(1)
 Q
