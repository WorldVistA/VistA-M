XVEMSID ;DJB/VSHL**Utilities - LIST USERS,ID NOTES [9/28/95 8:28am];2017-08-15  5:02 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
LIST ;List Users
 I '$D(^XVEMS("ID"))&('$D(^("PARAM")))&('$D(^("QU"))) D  Q
 . W !?2,"No user ID's on record.",!
 NEW DZ,FLAGQ,ID,NAM,X
 S FLAGQ=0 D HD,CHECK1 G:FLAGQ EX D CHECK2 G:FLAGQ EX D CHECK3
EX ;
 W !
 Q
CHECK1 ;ID in use. User has logged in thru VA KERNEL.
 W !?2,"1. VA KERNEL:" Q:'$D(^XVEMS("ID","SHL"))
 S ID=0 F  S ID=$O(^XVEMS("ID","SHL",ID)) Q:ID=""!FLAGQ  S X="" F  S X=$O(^XVEMS("ID","SHL",ID,X)) Q:X=""!FLAGQ  S DZ=$O(^XVEMS("ID","SHL",ID,X,0)) D
 . S NAM="" I $G(^VA(200,DZ,0))]"" S NAM=$P(^(0),"^")
 . D PRINT
 Q
CHECK2 ;ID in use. User has QWIK commands.
 W !!?2,"2. QWIK:" Q:'$D(^XVEMS("QU"))
 S (DZ,ID,NAM,X)=""
 F  S ID=$O(^XVEMS("QU",ID)) Q:ID=""!FLAGQ  D PRINT
 Q
CHECK3 ;ID in use. User has set parameters.
 W !!?2,"3. PARAM:" Q:'$D(^XVEMS("PARAM"))
 S (DZ,ID,NAM,X)=""
 F  S ID=$O(^XVEMS("PARAM",ID)) Q:ID=""!FLAGQ  D PRINT
 Q
PRINT ;Print line
 W !?18,ID,?26,NAM,?59,X,?70,DZ I $Y>(XVV("IOSL")-5) D PAGE
 Q
HD ;
 W @XVV("IOF"),!?19,"U S E R   L I S T   ( B Y   T Y P E )"
 W !!?7,"TYPE",?20,"ID",?40,"NAME",?62,"UCI",?72,"DUZ"
 W !?2,"--------------",?18,"-------",?27,"------------------------------",?59,"---------",?70,"-------"
 Q
PAGE ;
 D PAUSEQ^XVEMKC(2) Q:FLAGQ  W @XVV("IOF") D HD
 Q
 ;====================================================================
IDNOTES ;How to change your ID number.
 W !!?1,"To change your ID:"
 W !!?5,"o  If you're running the VShell as a VA KERNEL menu option, HALT back"
 W !?5,"   to the KERNEL and go into regular Programmer Mode."
 W !!?5,"o  Move to your MGR UCI. Use ..QSAVE to save your QWIKs."
 W !!?5,"o  Use ..UL to list ID numbers already in use, and select a new ID"
 W !?5,"   number that isn't already being used."
 W !!?5,"o  Exit Shell and re-enter with new ID number."
 W !!?5,"o  Use ..QSAVE to restore QWIKs to new ID."
 W !!?5,"o  Confirm that QWIKs have been restored to your new ID number."
 W !!?5,"o  Delete old ID by: DO IDKILL^XVEMSID"
 W ! Q
IDKILL ;Delete your old ID
 ; KILL ^XVEMS("CLH",ID), ^("PARAM",ID), ^("QU",ID), ^("ID","SHL",ID)
 ; Delete appropriate ^XVEMS("ID") nodes.
 NEW ASK,DZ,ID,X
IDKILL1 R !!?1,"Enter ID to be deleted: ",ID:300 S:'$T ID="^" I "^"[ID Q
 I ID'?1.N!(ID'>0) W "   Enter old ID number to be deleted." G IDKILL1
 I $G(XVVSHL)="RUN",ID=XVV("ID") D  G IDKILL1
 . W $C(7),!!?1,"You are currently logged in with this ID number."
 . W !?1,"You're not allowed to delete yourself."
 D WARNING W !!?1,"Do you want to DELETE ID number ",ID,"? NO//"
 R ASK:300 I '$T!(ASK="") S ASK="N"
 I "yY"'[$E(ASK) W "   Aborting..",! Q
 KILL ^XVEMS("CLH",ID),^XVEMS("PARAM",ID),^XVEMS("QU",ID)
 S X="" F  S X=$O(^XVEMS("ID","SHL",ID,X)) Q:X=""  S DZ="" F  S DZ=$O(^XVEMS("ID","SHL",ID,X,DZ)) Q:DZ=""  D  ;
 . KILL ^XVEMS("ID","DUZ",DZ,X,ID)
 KILL ^XVEMS("ID","SHL",ID)
 W !?1,"ID number ",ID," deleted..",!
 Q
WARNING ;Give warning before deleting
 W $C(7),!!?5,"WARNING: All QWIKs for this ID will be deleted. Stop now and"
 W !?5,"use ..QSAVE if you wish to save these QWIKs and restore them"
 W !?5,"to your active ID number."
 Q
