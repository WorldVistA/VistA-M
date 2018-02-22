XVEMRV ;DJB/VRR**Verify/Convert Scroll Array,Chk Tag/Line ;2017-08-15  4:36 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; VERIFY, TAGCHK, TAGCHK1 modified to take unlimited size routines and labels
 ; Above change (c) 2016 Sam Habiel
 ;
VERIFY(ND) ;When editor is exitted, verify that Lines and Tags are legal
 ;When VERIFY is called, FLAGQ=1
 ;ND="IR"_VRRS
 ;QUIT...... 0=Tag and Line are ok
 ;           1=Invalid tag   2=Invalid tag subscript
 ;           3=Line exceeds 245 characters
 NEW I,LN,QUIT,TG,TMP
 S:$G(ND)'>0 ND=1 S ND="IR"_ND,QUIT=0
 S TMP=$G(^TMP("XVV",ND,$J,1)) Q:TMP=" <> <> <>"
 D GETTAG S LN=$P(TMP,$C(30),2,999)
 F I=2:1 S TMP=$G(^TMP("XVV",ND,$J,I)) D  Q:QUIT  Q:TMP=" <> <> <>"  Q:TMP']""
 . I TMP=" <> <> <>" D  Q
 . . S QUIT=$$TAGCHK1(TG) Q:QUIT  ;Bad line tag
 . . I ($L(LN)+$L(TG)+1)>245 S QUIT=3 Q  ;Too long
 . I TMP'[$C(30) S LN=LN_$E(TMP,10,999) Q  ;Scrolled part of line
 . S QUIT=$$TAGCHK1(TG) Q:QUIT  ;Bad line tag
 . I ($L(LN)+$L(TG)+1)>245 S QUIT=3 Q  ;Too long
 . D GETTAG S LN=$P(TMP,$C(30),2,999)
 Q:'QUIT  D ASK
 Q
GETTAG ;Get tag from scroll array and convert to external format
 S TG=$P(TMP," "_$C(30),1) I TG?1.N1." " S TG="" Q
 F  Q:$E(TG)'=" "  S TG=$E(TG,2,999) ;Strip starting spaces
 Q
ASK ;Do they want to quit or correct problems
 NEW ANS
 D ENDSCR^XVEMKT2 W $C(7),!?1,"WARNING!",!?1
 I QUIT=1 W "This routine has an invalid line tag."
 I QUIT=2 W "This routine has a line tag with an invalid subscript."
 I QUIT=3 W "This routine has a line that exceeds 245 characters."
 I $G(XVZI) K XVZI W !?1,"Open up the editor to make corrections. (..E)",! Q
 W !?1,"You may wish to remain in the editor to make corrections.",!
ASK1 W !?1,"Do you still wish to exit? YES// "
 R ANS:300 S:'$T ANS="Y" S:ANS="" ANS="Y"
 S ANS=$$ALLCAPS^XVEMKU($E(ANS))
 I "Y,N"'[ANS W "   Y=Yes  N=No" G ASK1
 I ANS="N" S FLAGQ=0 D REDRAW1^XVEMRU
 Q
 ;====================================================================
TAGCHK(TAG) ;Check line tag. 1=Bad Tag
 I $G(TAG)']"" Q 0
 NEW I,TAG1,TAG2,TEST
 S TAG1=$P(TAG,"(")
 ; I $L(TAG1)>8 D MSG^XVEMRUM(8) Q 1 (sam): Bye bye
 I $E(TAG1)'?1AN,$E(TAG1)'="%" D MSG^XVEMRUM(8) Q 1
 I $L(TAG1)>1,$E(TAG1)'?1N,$E(TAG1,2,999)'?1.AN D MSG^XVEMRUM(8) Q 1
 I $E(TAG1)?1N,TAG1'?1.N D MSG^XVEMRUM(8) Q 1
 I TAG'?.E1"(".E Q 0
 I $E(TAG,$L(TAG))'=")" D MSG^XVEMRUM(9) Q 1
 S TAG2=$P(TAG,"(",2,99),TAG2=$E(TAG2,1,$L(TAG2)-1)
 I TAG2="" Q 0
 S TEST=0 F I=1:1:$L(TAG2,",") I $P(TAG2,",",I)'?1A.AN&($P(TAG2,",",I)'?1"%".AN) S TEST=1 Q
 I TEST D MSG^XVEMRUM(9) Q 1
 Q 0
TAGCHK1(TAG) ;Check line tag. Don't generate message.
 ;0=Tag is ok   1=Invalid tag   2=Invalid subscript
 I $G(TAG)']"" Q 0
 NEW I,TAG1,TAG2,TEST
 S TAG1=$P(TAG,"(")
 ; I $L(TAG1)>8 Q 1  ; VEN/SMH - No tag size limit anymore
 I $E(TAG1)'?1AN,$E(TAG1)'="%" Q 1
 I $L(TAG1)>1,$E(TAG1)'?1N,$E(TAG1,2,999)'?1.AN Q 1
 I $E(TAG1)?1N,TAG1'?1.N Q 1
 I TAG'?.E1"(".E Q 0
 I $E(TAG,$L(TAG))'=")" Q 2
 S TAG2=$P(TAG,"(",2,99),TAG2=$E(TAG2,1,$L(TAG2)-1)
 I TAG2="" Q 0
 S TEST=0 F I=1:1:$L(TAG2,",") I $P(TAG2,",",I)'?1A.AN&($P(TAG2,",",I)'?1"%".AN) S TEST=1 Q
 I TEST Q 2
 Q 0
 ;====================================================================
CONVERT(ND) ;Convert scroll array to ^UTILITY($J)
 ;ND="IR"_VRRS
 NEW CNT,DELIM,I,LN,TG,TMP
 S:$G(ND)'>0 ND=1 S ND="IR"_ND
 KILL ^UTILITY($J)
 S DELIM=" "
 S TMP=$G(^TMP("XVV",ND,$J,1)) Q:TMP=" <> <> <>"
 S CNT=1 D GETTAG S LN=$P(TMP,$C(30),2,999)
 F I=2:1 S TMP=$G(^TMP("XVV",ND,$J,I)) D  Q:TMP=" <> <> <>"  Q:TMP']""
 . I TMP=" <> <> <>" D  Q
 . . I LN]"" S ^UTILITY($J,0,CNT)=TG_DELIM_LN,CNT=CNT+1
 . I TMP'[$C(30) S LN=LN_$E(TMP,10,999) Q  ;Scrolled part of line
 . S ^UTILITY($J,0,CNT)=TG_DELIM_LN,CNT=CNT+1
 . D GETTAG S LN=$P(TMP,$C(30),2,999)
 Q
