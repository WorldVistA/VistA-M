ACKQSEL ;HIRMFO/BH-QUASAR Utility Routine ;  04/01/99 
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
 ;
SELECT(ACKTYP,ACKIN,ACKOUT,ACKFLD,ACKHLP,ACKDEF) ; generic prompt to select from a list
 ;  input: ACKTYP  1=one only, 2=many, 3=many or 'ALL'.
 ;         ACKIN   array/global containing valid items
 ;                  where @ACKIN@(name) exists
 ;         ACKOUT  array/global specifying where to put selected items
 ;                  where @ACKOUT@(name)="" and @ACKOUT=null or '^'
 ;         ACKFLD   field name^max len
 ;                   (used in prompt and list of items)
 ;         ACKHLP   mumps execute for help (displayed for both ? and ??)
 ;         ACKDEF   Default type^value 
 ;                   if type is 1,default displayed with prompt and //
 ;                   if type is 2, default appears on spacebar return   
 ;         ^TMP("ACKQSEL",$J,1) used during this program
 ;
 ;  initialise variables
 N DIR,ACKEXIT,ACKSEL,DIWL,DIWR,DIWF,ACKNUM,ACKNXT,ACKMTCH,ACKADD,X,ACKEOF
 N ACKDONE,ACKLIST
 S:$G(ACKDEF)="" ACKDEF=0
 K @ACKOUT
 K ^TMP("ACKQSEL",$J,1)
 S DIWL=1,DIWR=80,DIWF=""
 ; prompt for the field
 S ACKNUM=0,ACKEXIT=0    ; number selected so far, exit flag
 ; loop until user has finished selecting 
 ;   (will exit after 1 if ACKTYP=1)
 F  D SELECT2 Q:ACKEXIT
 ; kill temp list
 K ^TMP("ACKQSEL",$J,1)
 ;
SELECTX ; exit point
 Q
 ;
SELECT2 ; prompt the user
 K DIR S DIR("A")="Select "_$P(ACKFLD,U,1),DIR(0)="FO^1:"_$P(ACKFLD,U,2)
 ; change field to optional if one or more already selected
 I $O(@ACKOUT@(""))'="" S DIR(0)="FO^1:"_$P(ACKFLD,U,2)
 S DIR("?")="^"_ACKHLP
 I ACKTYP>1 S DIR("?")=DIR("?")_" S ACKLIST=2 D SELHELP^ACKQSEL"
 S DIR("??")="^"_ACKHLP_" S ACKLIST=1 D SELHELP^ACKQSEL"
 I +ACKDEF=1 S DIR("B")=$$UP($P(ACKDEF,U,2))
 D ^DIR
 S X=$$UP(X) ; convert input to upper case
 I X=" ",+ACKDEF=2 S X=$$UP($P(ACKDEF,U,2)) W "   ",X
 I X?1"^"1.E W !,"Jumping not allowed." K DUOUT Q
 I $D(DTOUT) S @ACKOUT="T",ACKEXIT=1 Q          ; timed out
 I $D(DUOUT)!(X="^") S @ACKOUT="^",ACKEXIT=1 Q  ; user quit
 I X="" S @ACKOUT="",ACKEXIT=1 Q  ; null entered (ie. done)
 ;
 ; validate the input
 S ACKSEL=X,ACKMTCH=0,ACKNUM=0,ACKADD=1
 I $E(ACKSEL)="-",$L(ACKSEL)>1 S ACKADD=2,ACKSEL=$E(ACKSEL,2,$L(ACKSEL))
 S ACKNXT=ACKSEL
 ;
 ; if ALL selected then transfer all entries to selected list
 I ACKTYP=3,ACKSEL="ALL" D  Q
 . I ACKADD=1 D  S ACKEXIT=1 Q             ;all selected
 . . S ACKNXT="" F  S ACKNXT=$O(@ACKIN@(ACKNXT)) Q:ACKNXT=""  D
 . . . S @ACKOUT@(ACKNXT)=""
 . I ACKADD=2 K @ACKOUT        ;all de-selected
 ;
 ; if no matches then quit
 I ACKADD=1,'$D(@ACKIN@(ACKSEL)) S ACKNXT=$O(@ACKIN@(ACKSEL)) I ACKNXT="" W "     ??" Q
 I ACKADD=2,'$D(@ACKOUT@(ACKSEL)) S ACKNXT=$O(@ACKOUT@(ACKSEL)) I ACKNXT="" W "     ??" Q
 I $E(ACKNXT,1,$L(ACKSEL))'=ACKSEL W "     ??" Q
 ;
 ; if only one match then quit
 I ACKADD=1,$E($O(@ACKIN@(ACKNXT)),1,$L(ACKSEL))'=ACKSEL D  Q
 . S @ACKOUT@(ACKNXT)=""
 . I ACKTYP=1 S ACKEXIT=1
 . ;S X=ACKSEL D ^DIWP,^DIWW
 . W $E(ACKNXT,$L(ACKSEL)+1,$L(ACKNXT)) W:ACKTYP'=1 "    selected"
 . S ACKSEL=ACKNXT
 I ACKADD=2,$E($O(@ACKOUT@(ACKNXT)),1,$L(ACKSEL))'=ACKSEL D  Q
 . K @ACKOUT@(ACKNXT)
 . ;S X=ACKSEL D ^DIWP,^DIWW
 . W $E(ACKNXT,$L(ACKSEL)+1,$L(ACKNXT)) W:ACKTYP'=1 "    de-selected"
 . S ACKSEL=ACKNXT
 ;
 ; to get here, there must be 2 or more matches
 I ACKADD=2 Q  ;multiple de-selection not allowed
 K ^TMP("ACKQSEL",$J,1)
 S X="|SETTAB(5,10)|" D ^DIWP S X=" " D ^DIWP
 I $D(@ACKIN@(ACKSEL)) D
 . S ACKMTCH=1,X="|TAB|1|TAB|"_ACKSEL D ^DIWP
 . S ^TMP("ACKQSEL",$J,1,ACKMTCH)=ACKSEL
 S ACKEOF=0  ; indicates end of file reached
 S ACKNUM="" ; number selected by user
 ; loop to display all matching items
 S ACKNXT=ACKSEL F  D SELECT3 Q:ACKEOF  Q:ACKNUM]""
 ; if item selected then add to file
 I ACKNUM?1.N D
 . S ACKSEL=^TMP("ACKQSEL",$J,1,ACKNUM)
 . S @ACKOUT@(ACKSEL)=""
 . ; if only one selection required then exit
 . I ACKTYP=1 S ACKEXIT=1 Q
 Q
 ;
SELECT3 ; choose from multiple matching entries
 S ACKDONE=0 ; indicates next five have been displayed
 F  S ACKNXT=$O(@ACKIN@(ACKNXT)) D  Q:ACKDONE
 . I (ACKNXT="")!($E(ACKNXT,1,$L(ACKSEL))'=ACKSEL) S ACKDONE=1,ACKEOF=1 Q
 . S ACKMTCH=ACKMTCH+1,X="|TAB|"_ACKMTCH_"|TAB|"_ACKNXT D ^DIWP
 . S ^TMP("ACKQSEL",$J,1,ACKMTCH)=ACKNXT
 . I ACKMTCH#5=0 S ACKDONE=1
 ; if the next entry on the list is null or does not match 
 ;  the user entry then we are at end of file
 I ACKNXT'="" D
 . I $O(@ACKIN@(ACKNXT))="" S ACKEOF=1
 . I $E($O(@ACKIN@(ACKNXT)),1,$L(ACKSEL))'=ACKSEL S ACKEOF=1
 D ^DIWW
 K DIR
 S DIR("A")="Select",DIR(0)="NO^1:"_ACKMTCH_":0"
 D ^DIR
 S ACKNUM=X
 I ACKNUM'="^",ACKNUM'?1.N S ACKNUM=""
 I 'ACKEOF,ACKNUM'="^" S X=" " D ^DIWP
 Q
 ;
SELHELP ; display help for the select prompt
 ;  called by Fileman as the Help routine for the item
 ;   being prompted in the SELECT function above.
 ;  not intended for use by other functions/routines.
 ; requires the following 
 ;  @ACKIN@(itm)   list of available items
 ;  @ACKOUT@(itm)   currently selected items
 ;  ACKLIST   which list to display 1=IN 2=OUT
 ;  ACKFLD    the name of the field
 ;
 N ACKITM,DIWL,DIWR,DIWF,X,ACKEXIT,ACK,DIR,ACKFILE
 S ACKITM="",DIWL=1,DIWR=80,DIWF=""
 S X="|SETTAB(10)|" D ^DIWP S X=" " D ^DIWP
 I ACKLIST=2 D
 . S X="    "_$S($O(@ACKOUT@(""))="":"No ",1:"The following ")
 . S X=X_$P(ACKFLD,U,1)_"s have been selected so far..."
 . D ^DIWP
 I ACKLIST=1 D
 . S X="    Choose from:"
 . D ^DIWP
 ; begin listing the items
 S ACKITM="",ACKEXIT=0
 F  D SELHELP2 Q:ACKEXIT
 ; end
 Q
 ;
SELHELP2 ; list the next 10
 S ACKFILE=$S(ACKLIST=1:ACKIN,1:ACKOUT)
 S X=" " D ^DIWP
 F ACK=1:1:10 S ACKITM=$O(@ACKFILE@(ACKITM)) Q:ACKITM=""  D
 . S X="|TAB|"_ACKITM D ^DIWP
 D ^DIWW
 ; if end of list encountered then exit
 I (ACKITM="")!($O(@ACKFILE@(ACKITM))="") S ACKEXIT=1 Q
 ; prompt to continue
 K DIR S DIR(0)="E"
 D ^DIR
 I X="^" S ACKEXIT=1
 Q
UP(X) ; convert X to uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
