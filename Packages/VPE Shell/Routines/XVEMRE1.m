XVEMRE1 ;DJB/VRR**EDIT - DO Menu Options ;2017-08-15  1:40 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
QUIT ;Call here if you should Quit after returning to ^XVEMRE
 S QUIT=1
 ;
 ;If in WEB mode, redraw WEB in upper right of screen
 I FLAGMODE["WEB" D MODEON^XVEMRU("WEB",1)
 Q
 ;
DO ;Run menu options from ^XVEMRE
 I $G(FLAGVPE)'["EDIT",",<ESCW>,<BS>,<DEL>,<ESCB>,<ESCD>,<ESCJ>,<RET>,"[(","_VK_",") D MSG^XVEMRUM(5) Q
 I $G(FLAGVPE)["LBRY",",<TAB>,<ESCR>,<ESCG>,<ESCH>,<ESCK>,"[(","_VK_",") D MSG^XVEMRUM(5) Q
 ;
WEB I VK="<ESCW>" D WEB^XVEMREP Q
 ;
 I VK="<TAB>" D ^XVEMRM,REDRAW1^XVEMRU G QUIT
 I VK="<ESCN>" D LOCATE1^XVEMRM,REDRAW1^XVEMRU G QUIT
 I VK="<ESCB>" D BREAK^XVEMREJ,REDRAW^XVEMRU(YND) Q
 I VK="<ESCR>" D PARSE^XVEMREP,REDRAW1^XVEMRU G QUIT
 I VK="<ESCG>" D GLB^XVEMREP Q:KEY="S"  G QUIT
 I VK="<ESCL>" D LNDOWN^XVEMREM Q
 I ",<ESC=>,<ESC->,<ESC_>,<ESC.>,<ESC;>,"[(","_VK_",") D INSERT Q
 ;
 ;Exit. Verify tags/lines are legal.
 I ",<ESC>,<F1E>,<F1Q>,<TO>,"[(","_VK_",") D VERIFY G QUIT
 ;
 I ",<HOME>,<END>,<F4AL>,<F4AR>,"[(","_VK_",") D RUN3^XVEMRER G QUIT
 I ",<PGDN>,<F4AD>,"[(","_VK_",") Q:$$ENDFILE^XVEMRE()  D FORWARD^XVEMRER G QUIT ;Page down
 I ",<PGUP>,<F4AU>,"[(","_VK_",") Q:$$TOPFILE^XVEMRE()  D BACKUP^XVEMRER G QUIT  ;Page up
 ;
 I ",<ESCH>,<ESCK>,"[(","_VK_",") D RUN2^XVEMRER G QUIT
 I ",<BS>,<DEL>,"[(","_VK_",") D HIGHOFF^XVEMRE,RUN^XVEMRER,HIGHON^XVEMRE Q
 I VK?1"<F".E1">" D HIGHOFF^XVEMRE,RUN^XVEMRER,HIGHON^XVEMRE Q
 I VK="<RET>" D HIGHOFF^XVEMRE,RETURN^XVEMREP,HIGHON^XVEMRE Q
 ;
 Q:VK?1"<".E1">".E  S FLAGSAVE=1
 D HIGHOFF^XVEMRE ;...Highlight off
 D ^XVEMREA ;.........Insert text
 D HIGHON^XVEMRE ;....Highlight on
 Q
 ;
VERIFY ;Verify tags/lines are legal.
 ;If FLAGQ is set to 0 by VERIFY^XVEMRV, user will be returned to
 ;current rtn to continue editing.
 S FLAGQ=1
 Q:$G(FLAGVPE)'["EDIT"
 I VRRS>1 D  Q
 . I $G(FLAGSAVE) D ENDSCR^XVEMKT2,SAVE^XVEMRMS
 D VERIFY^XVEMRV(VRRS)
 Q
 ;
INSERT ;Speed insert a line of characters (=._-), or a single ';'.
 ;Use when documenting your routine.
 NEW CD,NUM,X
 S X=$E(VK,5) ;.......Get character
 S $P(CD,X,67)="" ;...Set CD=line of character's
 I X=";" S CD="" ;....Only insert a single ';'.
 S CD=";"_CD
 S NUM=$$LINENUM^XVEMRU(YCUR)+1
 ;Put line into clipboard
 S ^XVEMS("E","SAVEVRR",$J,1)=NUM_$J("",9-$L(NUM))_$C(30)_CD
 S ^XVEMS("E","SAVEVRR",$J,2)="" ;Mark clipboard ending point
 D PREPASTE^XVEMRP1
 D REDRAW^XVEMRU(YND)
 Q
