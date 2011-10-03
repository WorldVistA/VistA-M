FBAALU ;AISC/GRR,WCIOFO/SAB-CPT CODE & MODIFIER LOOKUP ;7/15/1999
 ;;3.5;FEE BASIS;**4,77,85**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CPTM(FBDOS,FBDFN,FBCPT,FBMODL) ; Ask CPT Code and optional CPT Modifiers
 ; input
 ;   FBDOS - (optional) date of service, fileman format
 ;   FBDFN - (optional) patient DFN, pointer to file #2 and file #161
 ;   FBCPT - (optional) default CPT value (internal)
 ;   FBMODL- (optional) list of default modifiers (internal)
 ;                      delimited by commas
 ;                      only used when FBCPT accepted by user
 ; output
 ;   FBAACP  - CPT code (internal)
 ;             OR null if not selected
 ;             OR @ if default value (FBCPT) was supplied and user
 ;               entered an @ at the service provided prompt.
 ;   FBX     - CPT code (external) OR null if not selected
 ;   FBMODA( - (optional) CPT modifier array
 ;             FBMODA(#) = CPT modifier (internal)
 ;               where # is a integer greater than 0
 ;   FBGOT   - flag (0 or 1) =1 if CPT code was specified and confirmed
 ;
INIT ; initialize optional input variables and FBGOT
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 N FBCATX,FBCPTX,FBEDIT,FBI,FBLAST,FBMOD,FBMODLE,FBMODX,FBTX
 S:$G(FBDOS)="" FBDOS=DT
 S FBDFN=$G(FBDFN)
 S FBGOT=0
 ;
ASKCPT ; prompt for CPT code
 S DIR(0)="PO^81:EMZ"
 S DIR("A")=$S($G(FBCPT)>0:"",1:"Select ")_"Service Provided"
 I $G(FBCPT)>0 S DIR("B")=$$CPT^FBAAUTL4(FBCPT)
 S DIR("?",1)="The Current Procedural Terminology Code (CPT Code) as"
 S DIR("?",2)="specified on the vendors invoice identifying the service"
 S DIR("?")="the vendor provided to the veteran."
 S ICPTVDT=$G(FBDOS) D ^DIR K DIR,ICPTVDT I $D(DTOUT)!$D(DUOUT) G EXIT
 I $G(FBCPT)]"",X="@" D  G:FBGOT EXIT G ASKCPT
 . S DIR(0)="Y"
 . S DIR("A")="SURE YOU WANT TO DELETE THE ENTIRE SERVICE PROVIDED"
 . D ^DIR K DIR I Y S FBGOT=1,FBAACP="@",FBX="" K FBMODA
 I Y>0 S FBAACP=+Y,FBX=$P(Y,U,2)
 E  G EXIT
 ; *** PASS 3RD PARAMETER TO INCLUDE VA NATIONAL/LOCAL CODES
 S FBCPTX=$$CPT^ICPTCOD(FBAACP,FBDOS,1)
 I '$P(FBCPTX,U,7) D  G ASKCPT
 . W $C(7),!,"     CPT code inactive on date of service ("
 . W $$FMTE^XLFDT(FBDOS),")"
 ;
 K FBMODA
 I $G(FBCPT)>0,FBCPT=FBAACP,$G(FBMODL)]"" D
 . N FBI,FBMOD
 . F FBI=1:1 S FBMOD=$P(FBMODL,",",FBI) Q:FBMOD=""  S FBMODA(FBI)=FBMOD
 ;
ASKMOD ; multiply prompt for CPT modifiers
 ; determine highest number used in list
 S FBLAST=$O(FBMODA(" "),-1)
 ; prompt for CPT modifier
 S DIR(0)="PO^81.3:EMZ"
 S DIR("A")="Select CPT MODIFIER"
 S DIR("?")="^D MODHLP^FBAALU"
 ; *** COMMENT FOLLOWING LINE IF ACCURACY OF API IS NOT FIXED
 ;S DIR("S")="I $$MODP^ICPTMOD(FBAACP,Y,""I"",FBDOS,1)>0"
 S FBMODLE=$$MODL^FBAAUTL4("FBMODA","E")
 W !!,"Current list of modifiers: ",$S(FBMODLE]"":FBMODLE,1:"none")
 S ICPTVDT=$G(FBDOS) D ^DIR K DIR,ICPTVDT I $D(DTOUT)!$D(DUOUT) G EXIT
 ; if value was entered then process it and ask another
 I +Y>0 D  G ASKMOD
 . S FBMOD=+Y
 . ; if specified CPT modifier already in list set FBEDIT = it's number
 . S (FBI,FBEDIT)=0 F  S FBI=$O(FBMODA(FBI)) Q:'FBI  D  Q:FBEDIT
 . . I FBMODA(FBI)=FBMOD S FBEDIT=FBI
 . ; if in list then edit the existing modifier
 . I FBEDIT D  Q:$D(DIRUT)
 . . S DIR(0)="PO^81.3:EMZ"
 . . S DIR("A")="  CPT MODIFIER"
 . . S DIR("B")=$$MOD^FBAAUTL4(FBMODA(FBEDIT))
 . . ; *** COMMENT FOLLOWING LINE IF ACCURACY OF API IS NOT FIXED
 . . ;S DIR("S")="I $$MODP^ICPTMOD(FBAACP,Y,""I"",FBDOS,1)>0"
 . . S ICPTVDT=$G(FBDOS) D ^DIR K DIR,ICPTVDT
 . . I X="@" K FBMODA(FBEDIT) W "   (deleted)" ; "@" removes from list
 . . I +Y>0 S FBMOD=+Y
 . ; validate entered modifier
 . S FBMODX=$$MOD^ICPTMOD(FBMOD,"I",FBDOS,1)
 . I '$P(FBMODX,U,7) D  Q
 . . W $C(7),!,"     CPT Modifier inactive on date of service ("
 . . W $$FMTE^XLFDT(FBDOS),")"
 . ; ensure new value of edited modifier is not already on list
 . I FBEDIT D  Q:FBMOD=""
 . . S FBI=0 F  S FBI=$O(FBMODA(FBI)) Q:'FBI  D  Q:FBMOD=""
 . . . I FBMODA(FBI)=FBMOD,FBI'=FBEDIT S FBMOD="" W !,$C(7),"     Change was not accepted because the new value is already on the list."
 . ; update list
 . I FBEDIT S FBMODA(FBEDIT)=FBMOD ; updated existing modifier
 . E  S FBLAST=FBLAST+1,FBMODA(FBLAST)=FBMOD ; added new modifier
 ;
DIS ; display entered data
 ; if default CPT code exists and default code and modifiers were not
 ;   changed then skip display and confirm steps.
 I $G(FBCPT)>0,FBCPT=FBAACP,$G(FBMODL)=$$MODL^FBAAUTL4("FBMODA","I") S FBGOT=1 G EXIT
 S FBCATX=$$CAT^ICPTAPIU($P(FBCPTX,U,4))
 W !!,"Major Category: " W:$P(FBCATX,U)'=-1 $P(FBCATX,U,4)
 W !,?2,"Sub-Category: " W:$P(FBCATX,U)'=-1 $P(FBCATX,U)
 W !,?6,"Procedure: ",$P(FBCPTX,U,2),"   ",$P(FBCPTX,U,3)
 I $O(FBMODA(0)) D
 . W !,?6,"Modifiers: "
 . S FBI=0 F  S FBI=$O(FBMODA(FBI)) Q:'FBI  D
 . . S FBMODX=$$MOD^ICPTMOD(FBMODA(FBI),"I",FBDOS,1)
 . . W ?22,"-",$P(FBMODX,U,2),"  ",$P(FBMODX,U,3),!
 E  W !
 W !,?20,"Detail Description ",!,?20,"=================="
 K FBTX
 S X=$$CPTD^ICPTCOD(FBAACP,"FBTX",$G(FBDFN),$G(FBDOS))
 S FBI=0 F  S FBI=$O(FBTX(FBI)) Q:'FBI  W !,FBTX(FBI)
 ;
CONF ; confirm entered data
 S DIR(0)="Y",DIR("A")="Is this correct",DIR("B")="YES"
 D ^DIR K DIR I $D(DIRUT) G EXIT
 I 'Y W ! G ASKCPT
 S FBGOT=1
 ;
EXIT ; exit point
 I 'FBGOT S FBAACP="",FBX="" K FBMODA
 Q
 ;
MODHLP ; CPT MODIFIER prompt help text
 ; input
 ;   FBMODA( - (optional) array of modifiers
 ;             FBMODA(#)=CPT MODIFIER (internal)
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 N FBI,FBL,FBMODX,FBQUIT,FBTX
 ;
 ; compile help text for modifier prompt including a list of
 ;   previously entered modifiers.
 S FBTX(1)="Modifiers are used to better describe the service (CPT)"
 S FBTX(2)="rendered. Modifier(s) will be combined with the CPT code"
 S FBTX(3)="for Fee Schedule calculations and to check for duplicate"
 S FBTX(4)="payment entry."
 I $O(FBMODA(0)) D
 . N FBI,FBL,FBMODX
 . S FBTX(5)=" "
 . S FBL=5
 . S FBI=0 F  S FBI=$O(FBMODA(FBI)) Q:'FBI  D
 . . S FBMODX=$$MOD^ICPTMOD(FBMODA(FBI),"I",$G(FBDOS),1)
 . . S FBL=FBL+1,FBTX(FBL)="     "_$P(FBMODX,U,2)_"  "_$P(FBMODX,U,3)
 ;
 ; display the help text
 S FBL=0 F  S FBL=$O(FBTX(FBL)) Q:'FBL  D  Q:$D(DIRUT)
 . ; pause between screens of data (22 lines)
 . I $E(IOST,1,2)="C-",'(FBL#22) S DIR(0)="E" D ^DIR K DIR Q:$D(DIRUT)
 . ; write a line of text
 . W !,FBTX(FBL)
 ;
 Q
 ;
 ;FBAALU
