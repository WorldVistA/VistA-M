XVEMSS ;DJB/VSHL**..SAVE ;2017-08-16  10:41 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
SAVE ;
 NEW BOX,CNT,CODE,FLAGQ,ID,MENU,QWIK,RTN,TEMP,VEN,X,XVVS,XX
 S FLAGQ=0 D MENU G:FLAGQ EX
 I "1,2"[MENU D ZSAVE^XVEMKY3 G:FLAGQ EX
 I MENU=1 D  G:FLAGQ EX
 . D GETRTNS Q:FLAGQ
 . W ! D ASK Q:FLAGQ
 . D BUILD^XVEMSS1
 I MENU=2 D  G:FLAGQ EX
 . D GETRTNR Q:FLAGQ
 . D BOX Q:FLAGQ
 . D ID Q:FLAGQ
 . D RESTORE^XVEMSS1
EX ;
 Q
MENU ;
 W !!,"*** Save/Restore User QWIKs ***"
 W !!,"1. Save QWIKs"
 W !,"2. Restore QWIKs",!
MENU1 R !,"Select NUMBER: ",MENU:500 S:'$T MENU="^" I "^"[MENU S FLAGQ=1 Q
 I "??"[MENU D  W ! G MENU1
 . W !!,"Enter 1 to save your QWIKs to a routine."
 . W !,"Enter 2 to restore QWIKs from a routine."
 S MENU=+MENU,MENU=MENU\1
 I MENU<1!(MENU>2) W $C(7),"   Enter a number from 1 to 2" G MENU1
 Q
 ;
GETRTNS ;Get routine name for SAVE
 D RTN Q:FLAGQ
 I RTN="@" KILL ^XVEMS("PARAM",XVV("ID"),"SAVE") S FLAGQ=1 Q
 I "??"[RTN D MSG G GETRTNS
 I RTN?1"%".E!(RTN'?1A.7AN) D  G GETRTNS
 . W "   Invalid routine name.."
 S ^XVEMS("PARAM",XVV("ID"),"SAVE")=RTN
 Q
 ;
GETRTNR ;Get routine for RESTORE
 D RTN Q:FLAGQ
 I "??"[RTN D  G GETRTNR
 . W !,"Enter the name of the routine that contains your saved User QWIKs."
 I @("$T(+2^"_RTN_")'["";;VSHELL;;""") D  G GETRTNR
 . W !!,"Invalid routine. Routine's 2nd line must be: ;;VSHELL;;"
 Q
 ;
RTN ;Get Routine name
 S TEMP=""
 I $D(^XVEMS("PARAM",XVV("ID"),"SAVE")) S TEMP=^("SAVE")
 W !!,"Enter ROUTINE: " W:TEMP]"" TEMP_"// "
 R RTN:300 S:'$T RTN="^" S:RTN="" RTN=TEMP
 I "^"[RTN S FLAGQ=1 Q
 F  Q:$E(RTN)'="^"  S RTN=$E(RTN,2,999) ;Strip off '^'
 Q
 ;
ASK ;
 W !,"I will save your QWIKs to routine ^",RTN,".  Ok? YES// "
 R XX:300 S:'$T XX="^" S:XX="" XX="YES" I XX="^" S FLAGQ=1 Q
 I "YNyn"'[$E(XX) W "   Y=YES or N=NO" G ASK
 I "Yy"'[$E(XX) S FLAGQ=1
 Q
 ;
BOX ;Save QWIKs to a particular box
 W !,"Enter BOX: "
 R BOX:500 S:'$T BOX="^" Q:BOX=""  I BOX="^" S FLAGQ=1 Q
 S BOX=BOX\1 I BOX'>0 D  G BOX
 . W !!,"^=Abort Restore   <RET>=Accept Default Boxes"
 . W !,"If you want to restore the saved QWIKs to a particular box so they don't"
 . W !,"get mixed up with your own QWIKs, enter that box here.",!
 Q
 ;
ID ;Get ID number
 R !,"Enter ID: ",ID:500 S:'$T ID="^" I "^"[ID S FLAGQ=1 Q
 S ID=ID\1 I ID'>0 D  G ID
 . W "   Enter ID number of person to receive these QWIKs."
 Q
 ;
MSG ;Store routine name in ^XVEMS("PARAM",XVV("ID"),"SAVE")
 ;SAVE will use this routine to save your QWIKs.
 W !!,"Enter the name of a routine. QSAVE will then save your User QWIKs as"
 W !,"lines of code in this routine. You then can use QSAVE to reverse the"
 W !,"process and restore your QWIKs. Use this option to Backup your QWIKs or"
 W !,"to move your QWIKs to another system."
 W !!,"IMPORTANT: As a programmer, it is your responsibility to make sure"
 W !,"the routine name you enter here DOES NOT already exist. If it does"
 W !,"it will be overwritten."
 W !!,"Enter '@' to stop displaying the current default routine."
 Q
