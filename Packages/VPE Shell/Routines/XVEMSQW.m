XVEMSQW ;DJB/VSHL**QWIKs - Vendor List [9/9/95 6:40pm];2017-08-16  10:39 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
VENLIST ;List Vendor Specific Code
 NEW CD,FLAGQ,NAM,TYPE
 W !?1,"*** List Vendor Specific Code ***"
 W !?1,"Enter the name of an existing System/User QWIK"
 S FLAGQ=0 F  S TYPE="" D GETNAM Q:FLAGQ  I TYPE]"" D LISTCD
 Q
GETNAM ;Get either User or System QWIK
 W ! S CD="" D SCREEN^XVEMKEA("Enter QWIK: ",1,XVV("IOM")-2)
 I CD="?"!(CD="??")!(XVVSHC="<ESCH>") D  G GETNAM
 . W !?3,"Enter the name of an existing System/User QWIK"
 I ",<ESC>,<F1E>,<F1Q>,<TAB>,<TO>,"[(","_XVVSHC_",")!(CD']"")!(CD="^") S FLAGQ=1 Q
 S CD=$$ALLCAPS^XVEMKU(CD)
 I CD'?1A.7AN D MSG^XVEMSQA(1) G GETNAM
 S NAM=CD
 I $D(^XVEMS("QU",XVV("ID"),NAM)),$D(^XVEMS("QS",NAM)) D BOTH Q
 S TYPE=$S($D(^XVEMS("QU",XVV("ID"),NAM)):"User",$D(^XVEMS("QS",NAM)):"System",1:"")
 I TYPE']"" W "   No such QWIK"
 Q
LISTCD ;List Code
 W @XVV("IOF"),!?12,"D I S P L A Y   V E N D O R   S P E C I F I C   C O D E"
 W !!?1,"QWIK NAME...... ",NAM
 W !?1,"TYPE........... ",TYPE
 W !?1,"DESCRIPTION.... " W $S(TYPE="System":$P(^XVEMS("QS",NAM,"DSC"),"^",1),1:$P(^XVEMS("QU",XVV("ID"),NAM,"DSC"),"^",1))
 W !!?1,"Default Code..." S CD=$S(TYPE="System":^XVEMS("QS",NAM),1:^XVEMS("QU",XVV("ID"),NAM)) D LISTCD1
 I TYPE="User" NEW X S X="" F  S X=$O(^XVEMS("QU",XVV("ID"),NAM,X)) Q:X'>0  D LISTNAM S CD=^(X) D LISTCD1
 I TYPE="System" NEW X S X="" F  S X=$O(^XVEMS("QS",NAM,X)) Q:X'>0  D LISTNAM S CD=^(X) D LISTCD1
 Q
LISTCD1 ;List Code with wrapping
 NEW LMAR,PROMPT,START,WIDTH
 S PROMPT="",(LMAR,START)=17,WIDTH=61 D LISTCD^XVEMKEA
 Q
LISTNAM ;
 W !!?1,"Vendor ",$S(X=1:"M/11.... ",X=2:"DSM..... ",X=7:"M/VX.... ",X=8:"MSM..... ",X=9:"DTM..... ",X=13:"M/11+... ",X=16:"VAXDSM.. ",1:"........ ")
 Q
BOTH ;Both a User & System QWIK exists
 NEW XX
 W !!!?1,"There are 2 QWIKs named ",NAM,". Which one do you wish to see?",!?3,"U = User QWIK",!?3,"S = System QWIK"
BOTH1 R !?1,"Enter letter of your choice: ",XX:300 S:'$T XX="^" I "^"[XX Q
 S XX=$$ALLCAPS^XVEMKU($E(XX))
 I "US"'[XX W "   Enter U or S" G BOTH1
 S TYPE=$S(XX="U":"User",XX="S":"System",1:"")
 Q
