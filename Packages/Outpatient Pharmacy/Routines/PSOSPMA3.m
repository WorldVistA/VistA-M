PSOSPMA3 ;BIRM/MFR - ASAP Definitions Listman Actions Handler ;11/11/15
 ;;7.0;OUTPATIENT PHARMACY;**451**;DEC 1997;Build 114
 ;
SHOWHID ; Handles Show/Hide Details
 ; (PSOSHOW: 1: Show Segment Tree only; 2: Show Segments & Data Elements; 3: Show Data Element Details)
 S VALMBCK="R"
 I PSOASVER="1995" D  Q
 . S VALMSG="Details not available for ASAP 1995 version" W $C(7)
 W ?52,"Please wait..." S PSOSHOW=(($G(PSOSHOW)+1)#3)
 D INIT^PSOSPML3,HDR^PSOSPML3 I PSOSHOW=0 S VALMBG=1
 Q
 ;
COPYVER ; Handles 'Copy ASAP Version' Action
 N NEWASVER,DIR,DIRUT,DTOUT,Y,X,VERS,DEFTYPE
 I PSOASVER="1995" S VALMSG="ASAP 1995 Version cannot be copied" W $C(7) G EXIT
 I '$$SECKEY() G EXIT
 I '$$LOCK() G EXIT
 D FULL^VALM1
 I PSOASVER="1995" D  G BACK
 . S VALMSG="ASAP 1995 Version cannot be copied" W $C(7)
CV ; Loop Prompt
 W !!," From ASAP Version: ",PSOASVER,!
 S DIR(0)="58.4001,.01",DIR("A")="   To ASAP Version" D ^DIR I $D(DIRUT)!$D(DTOUT) G BACK
 D VERLIST^PSOSPMU0("A",.VERS)
 I $D(VERS(Y_" ")) W !!?3,"ASAP Version '",Y,"' already exists.",$C(7) G CV
 S NEWASVER=Y
 S X="",DEFTYPE="B"
 I $G(VERS(PSOASVER_" "))="C" D  I X="^" G BACK
 . W ! S X=$$ASKFLD("Y","YES","Copy Customizations") I X="^" Q
 . S DEFTYPE=$S(X=1:"B",1:"S")
 W ! S X=$$ASKFLD("Y","NO","Confirm Copy") I X'=1 G BACK
 W ?40,"Copying..." D CLONEVER^PSOSPMU3(PSOASVER,NEWASVER,DEFTYPE) H 1 W "Done.",$C(7)
 S PSOASVER=NEWASVER
 G BACK
 ;
EDTDELIM ; Handles the 'Edit Delimiters' Action
 N ELMDELIM,SEGDELIM,EOSCHR,X,DONE
 I PSOASVER="1995" S VALMSG="Delimiters cannot be changed for ASAP 1995 Version" W $C(7) G EXIT
 I '$$SECKEY() G EXIT
 I '$$LOCK() G EXIT
 D FULL^VALM1
 W !!,"ASAP Version ",PSOASVER," delimiters: ",!
 D LOADASAP^PSOSPMU0(PSOASVER,"B",.ALLASAP) ; Both ASAP Definitions
 ; Data Element Delimiter
 S DONE=0,ELMDELIM=$P($G(ALLASAP),"^",2)
 F  S X=$$ASKFLD("58.4001,.02",ELMDELIM) Q:X="^"  D  I DONE Q
 . S ELMDELIM=$S(X="@":"",1:X) I X="@" W ?50,"Deleted." Q
 . S DONE=1
 ; Segment Terminator
 S DONE=0,SEGDELIM=$P($G(ALLASAP),"^",3)
 F  S X=$$ASKFLD("58.4001,.03",SEGDELIM) Q:X="^"  D  I DONE Q
 . S SEGDELIM=$S(X="@":"",1:X) I X="@" W ?50,"Deleted." Q
 . S DONE=1
 I X="^" G BACK
 ; End-Of-Segment
 S DONE=0,EOSCHR=$P($G(ALLASAP),"^",4)
 F  S X=$$ASKFLD("58.4001,.04",EOSCHR) Q:X="^"  D  I DONE Q
 . I X'="",X'="@",$$UP^XLFSTR(X)'?1"$C("1.3N.(1","1.3N)1")" D  Q
 . . W !,"Invalid format. Use $C to specify a character escape sequence.",$C(7),!
 . S EOSCHR=$S(X="@":"",1:X) I X="@" W ?50,"Deleted." Q
 . S DONE=1
 I X="^" G BACK
 ; No changes
 I $P($G(ALLASAP),"^",2,4)=(ELMDELIM_"^"_SEGDELIM_"^"_EOSCHR) G BACK
 ;
 W ! S X=$$ASKFLD("Y","YES","Save Changes") I X'=1 G BACK
 W ?40,"Saving..."
 S $P(ALLASAP,"^",2,4)=ELMDELIM_"^"_SEGDELIM_"^"_EOSCHR
 D SAVEVER^PSOSPMU3(PSOASVER,ALLASAP)
 H 1 W "OK",$C(7)
 G BACK
 ;
CUSSEG ; Handles the 'Customize Segment' Action
 N CUSSEG,DIR,DIRUT,DTOUT,X,Y,STDASAP,CUSASAP,ALLASAP,NEWSEG,DONE,QUIT,SEG,OK,SEGREQ,SEGPOS,PARSEG
 N HLPTXT,CUSSEGS,CNT,LITERAL
 I PSOASVER="1995" S VALMSG="ASAP 1995 Version cannot be customized" W $C(7) G EXIT
 I '$$SECKEY() G EXIT
 I '$$LOCK() G EXIT
 D FULL^VALM1
 ;
CSL ; Loop Re-Prompt
 D LOADASAP^PSOSPMU0(PSOASVER,"S",.STDASAP) ; Standard ASAP Definition
 D LOADASAP^PSOSPMU0(PSOASVER,"C",.CUSASAP) ; Custom ASAP Definition
 D LOADASAP^PSOSPMU0(PSOASVER,"B",.ALLASAP) ; Both ASAP Definitions
 ;
CSE ; Error Re-Prompt
 K DIR S HLPTXT="Enter the ASAP Segment ID that you want to customize (e.g.,'AIR')."
 I $G(STDASAP)'="" D
 . S SEG="999" F  S SEG=$O(CUSASAP(SEG)) Q:SEG=""  D
 . . I $$CUSSEG^PSOSPMU3(PSOASVER,SEG) S CUSSEGS(SEG)=$P(CUSASAP(SEG),"^",2)
 I '$D(CUSSEGS) D
 . S DIR("?")=HLPTXT
 E  D
 . S DIR("?",1)=HLPTXT,(DIR("?"),DIR("?",2))=" "
 . S SEG="",CNT=3 F  S SEG=$O(CUSSEGS(SEG)) Q:SEG=""  D
 . . I $O(CUSSEGS(SEG))="" S DIR("?")=SEG_"   "_$P(CUSSEGS(SEG),"^") Q
 . . S DIR("?",CNT)=SEG_"   "_$P(CUSSEGS(SEG),"^"),CNT=CNT+1
 S DIR(0)="FO^1:5",DIR("A")="SEGMENT ID"
 W ! D ^DIR I $D(DIRUT)!$D(DTOUT)!(X="") G BACK
 S LITERAL=0 I $E(X)="""",$E(X,$L(X))="""" S X=$E(X,2,$L(X)-1),LITERAL=1
 I (X'?.AN)!($E(X,$L(X))?1N)!(X[" ") W !,"Invalid Segment ID.",$C(7) G CSE
 I 'LITERAL,'$D(ALLASAP(X)),$D(ALLASAP($$UP^XLFSTR(X))) S X=$$UP^XLFSTR(X)
 S CUSSEG=X W "   ",$P($G(ALLASAP(CUSSEG)),"^",2) W !
 I $D(STDASAP(CUSSEG)) D
 . ; Segment Requirement
 . S X=$$ASKFLD("58.40011,.04",$P($G(ALLASAP(CUSSEG)),"^",4)) I X="^" Q
 . S SEGREQ=X
 . W ! S X=$$ASKFLD("Y","YES","Save Custom Segment") I X'=1 Q
 . W ?40,"Saving..."
 . ; If first time the Segment is being customized, copy; otherwise save
 . I '$D(CUSASAP(CUSSEG)) D
 . . S $P(STDASAP(CUSSEG),"^",4)=SEGREQ
 . . D COPYSEG^PSOSPMU3(PSOASVER,.STDASAP,PSOASVER,CUSSEG)
 . E  D
 . . S $P(CUSASAP(CUSSEG),"^",4)=SEGREQ
 . . D SAVESEG^PSOSPMU3(PSOASVER,CUSSEG,CUSASAP(CUSSEG),ALLASAP)
 . W "OK",$C(7)
 E  D
 . S (Y,NEWSEG)=0
 . I '$D(CUSASAP(CUSSEG)) D  I $D(DIRUT)!$D(DTOUT)!'Y Q
 . . K DIR S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are you adding '"_CUSSEG_"' as a new SEGMENT ID" W $C(7) D ^DIR
 . . S NEWSEG=1 W !
 . S $P(CUSASAP(CUSSEG),"^",1)=CUSSEG
 . ; Segment Name
 . S X=$$ASKFLD("58.40011,.02",$P(CUSASAP(CUSSEG),"^",2)) I X="^" Q
 . S $P(CUSASAP(CUSSEG),"^",2)=X
 . ; Parent Segment
 . S DONE=0
 . F  S X=$$ASKFLD("58.40011,.03",$P(CUSASAP(CUSSEG),"^",3)) Q:X="^"!(X="")  D  I DONE Q
 . . I X="@" S $P(CUSASAP(CUSSEG),"^",3)="" Q
 . . I '$D(ALLASAP(X)),$D(ALLASAP($$UP^XLFSTR(X))) S X=$$UP^XLFSTR(X)
 . . I '$D(ALLASAP(X)) W !,"Parent Segment ID not found.",$C(7) Q
 . . I X=CUSSEG W !,"Parent Segment ID cannot be its own parent.",$C(7) Q
 . . W "   ",$P(ALLASAP(X),"^",2)
 . . S $P(CUSASAP(CUSSEG),"^",3)=X,DONE=1
 . I X="^" Q
 . ; Segment Requirement
 . S X=$$ASKFLD("58.40011,.04",$P(CUSASAP(CUSSEG),"^",4)) I X="^" Q
 . S $P(CUSASAP(CUSSEG),"^",4)=X
 . S DONE=0
 . F  S X=$$ASKFLD("58.40011,.05",$P(CUSASAP(CUSSEG),"^",5)) Q:X="^"  D  I DONE Q
 . . S SEG="999",OK=1 F  S SEG=$O(ALLASAP(SEG)) Q:SEG=""  D  I 'OK Q
 . . . I SEG'=CUSSEG,$P(ALLASAP(SEG),"^",3)=$P(CUSASAP(CUSSEG),"^",3),$P(ALLASAP(SEG),"^",5)=X D
 . . . . S OK=0 W !,"The Segment '",SEG,"' (",$P(ALLASAP(SEG),"^",2),") already occupies this position.",$C(7) Q
 . . I OK S $P(CUSASAP(CUSSEG),"^",5)=X,DONE=1
 . I X="^" Q
 . ; Segment Level
 . S DONE=0,PARSEG=$P(CUSASAP(CUSSEG),"^",3)
 . I PARSEG'="",$P(CUSASAP(CUSSEG),"^",6)="",$P($G(ALLASAP(PARSEG)),"^",6)>3 D
 . . S $P(CUSASAP(CUSSEG),"^",6)=$P($G(ALLASAP(PARSEG)),"^",6)
 . F  S X=$$ASKFLD("58.40011,.06",$P(CUSASAP(CUSSEG),"^",6)) Q:X="^"  D  I DONE Q
 . . I $P(CUSASAP(CUSSEG),"^",3)="",X'=1,X'=6  D  Q
 . . . W !,"Orphan segments can only be located at the MAIN HEADER or MAIN TRAILER levels.",$C(7)
 . . S QUIT=0
 . . I PARSEG'="" D  I QUIT Q
 . . . I $P($G(ALLASAP(PARSEG)),"^",6)>3,X'=$P($G(ALLASAP(PARSEG)),"^",6) D  S QUIT=1 Q
 . . . . W !,"Segment level must be the same as the parent's level (",$P($G(ALLASAP(PARSEG)),"^",6),").",$C(7)
 . . . I X<$P($G(ALLASAP(PARSEG)),"^",6) D  S QUIT=1 Q
 . . . . W !,"Segment level cannot be lower than parent's level (",$P($G(ALLASAP(PARSEG)),"^",6),").",$C(7)
 . . . I X>($P($G(ALLASAP(PARSEG)),"^",6)+1) D  S QUIT=1 Q
 . . . . W !,"Segment level cannot be more than 1 level above parent's level (",$P($G(ALLASAP(PARSEG)),"^",6),").",$C(7)
 . . S $P(CUSASAP(CUSSEG),"^",6)=X,DONE=1
 . I X="^" Q
 . ; Confirm
 . W ! S X=$$ASKFLD("Y","YES","Save Custom Segment") I X'=1 Q
 . W ?40,"Saving..."
 . D SAVESEG^PSOSPMU3(PSOASVER,$S(NEWSEG:"+1",1:CUSSEG),CUSASAP(CUSSEG),ALLASAP)
 . H 1 W "OK",$C(7)
 G CSL
 ;
CUSELM ; Handles the 'Customize Element' Action
 N CUSELM,DIR,DIRUT,DTOUT,X,Y,STDASAP,CUSASAP,SEGID,ELMPOS,MAXLEN,ELMREQ,NEWELM,ELMDATA
 N DIC,DWPK,I,MEXPR,LINE,HLPTXT,CUSELMS,CNT,ELM
 I PSOASVER="1995" S VALMSG="ASAP 1995 Version cannot be customized" W $C(7) G EXIT
 I '$$SECKEY() G EXIT
 I '$$LOCK() G EXIT
 D FULL^VALM1
 ;
CEL ; Loop Re-Prompt
 D LOADASAP^PSOSPMU0(PSOASVER,"S",.STDASAP) ; Standard ASAP Definition
 D LOADASAP^PSOSPMU0(PSOASVER,"C",.CUSASAP) ; Custom ASAP Definition
 D LOADASAP^PSOSPMU0(PSOASVER,"B",.ALLASAP) ; Both ASAP Definitions
 ;
CEE ; Error Re-Prompt 
 K DIR S HLPTXT="Enter the ASAP Data Element ID that you want to customize (e.g.,'PAT03')"
 I $G(STDASAP)'="" D
 . S SEG="999" F  S SEG=$O(CUSASAP(SEG)) Q:SEG=""  D
 . . S ELM=0 F  S ELM=$O(CUSASAP(SEG,ELM)) Q:'ELM  D
 . . . S CUSELMS($P(CUSASAP(SEG,ELM),"^"))=$P(CUSASAP(SEG,ELM),"^",2)
 I '$D(CUSELMS) D
 . S DIR("?")=HLPTXT
 E  D
 . S DIR("?",1)=HLPTXT,(DIR("?"),DIR("?",2))=" "
 . S CNT=2,ELM=""  F  S ELM=$O(CUSELMS(ELM)) Q:ELM=""  D
 . . I $O(CUSELMS(ELM))="" S DIR("?")=ELM_"   "_$P(CUSELMS(ELM),"^") Q
 . . S DIR("?",CNT)=ELM_"   "_$P(CUSELMS(ELM),"^"),CNT=CNT+1
 S DIR(0)="FO^1:10",DIR("A")="DATA ELEMENT ID"
 W ! D ^DIR I $D(DIRUT)!$D(DTOUT)!(X="") G BACK
 S SEGID=$$GETSEGID^PSOSPMU3(X) I SEGID=""!(X[" ") W !,"Invalid Segment.",$C(7) G CEE
 I '$D(ALLASAP(SEGID)),$D(ALLASAP($$UP^XLFSTR(SEGID))) D
 . S X=$$UP^XLFSTR(X),SEGID=$$UP^XLFSTR(SEGID)
 I '$D(ALLASAP(SEGID)) W !!,"Segment ID '",SEGID,"' not found.",$C(7) G CEE
 S ELMPOS=$P(X,SEGID,2) I 'ELMPOS!(ELMPOS'?2N) W !,"Invalid Data Element position (",ELMPOS,").",$C(7) G CEE
 W "   ",$P($G(ALLASAP(SEGID,+ELMPOS)),"^",2) W !
 S CUSELM=X
 I ELMPOS>1,'$D(ALLASAP(SEGID,ELMPOS-1)) D  G CEE
 . W !,"Invalid Data Element position (",ELMPOS,"). Next Data Element must be ",SEGID,$E(100+$O(ALLASAP(SEGID,99),-1)+1,2,3),".",$C(7)
 ;
 S ELMPOS=+ELMPOS
 I $D(STDASAP(SEGID,ELMPOS)) D
 . ; Data Element Maximum Length
 . S X=$$ASKFLD("58.400111,.04",$P($G(ALLASAP(SEGID,ELMPOS)),"^",4)) I X="^" Q
 . S MAXLEN=X
 . ; Data Element Requirement
 . S X=$$ASKFLD("58.400111,.06",$P($G(ALLASAP(SEGID,ELMPOS)),"^",6)) I X="^" Q
 . S ELMREQ=X
 . ; Data Element M Expression
 . S MEXPR="" F I=1:1 Q:'$D(ALLASAP(SEGID,ELMPOS,"VAL",I))  D
 . . S MEXPR=MEXPR_ALLASAP(SEGID,ELMPOS,"VAL",I)
 . S X=$$ASKMEXPR($P(ALLASAP(SEGID),"^",6),CUSELM,MAXLEN,MEXPR) I X="^" Q
 . S MEXPR=X
 . W ! S X=$$ASKFLD("Y","YES","Save Custom Data Element") I X'=1 Q
 . W ?40,"Saving..."
 . ; If first time the Data Element is being customized, copy; otherwise save
 . I '$D(CUSASAP(SEGID,ELMPOS)) D
 . . ; The Custom ASAP Segment node might not be present (1st time), therefore it must be created
 . . I '$D(CUSASAP(SEGID)) D COPYSEG^PSOSPMU3(PSOASVER,.STDASAP,PSOASVER,SEGID)
 . . S $P(STDASAP(SEGID,ELMPOS),"^",4)=MAXLEN
 . . S $P(STDASAP(SEGID,ELMPOS),"^",6)=ELMREQ
 . . S STDASAP(SEGID,ELMPOS,"VAL",1)=MEXPR
 . . D COPYELM^PSOSPMU3(PSOASVER,.STDASAP,PSOASVER,CUSELM)
 . E  D
 . . S $P(CUSASAP(SEGID,ELMPOS),"^",4)=MAXLEN
 . . S $P(CUSASAP(SEGID,ELMPOS),"^",6)=ELMREQ
 . . S CUSASAP(SEGID,ELMPOS,"VAL",1)=MEXPR
 . . K ELMDATA M ELMDATA=CUSASAP(SEGID,ELMPOS)
 . . D SAVEELM^PSOSPMU3(PSOASVER,SEGID,CUSELM,.ELMDATA)
 . W "OK",$C(7)
 E  D
 . K ELMDATA S (Y,NEWELM)=0
 . I '$D(CUSASAP(SEGID,ELMPOS)) D  I $D(DIRUT)!$D(DTOUT)!'Y Q
 . . K DIR S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are you adding '"_CUSELM_"' as a new DATA ELEMENT" W $C(7) D ^DIR
 . . S NEWELM=1 W !
 . ; Data Element ID and Position are non-editable fields
 . S $P(ELMDATA,"^",1)=CUSELM
 . S $P(ELMDATA,"^",5)=ELMPOS
 . ; Data Element Name
 . S X=$$ASKFLD("58.400111,.02",$P($G(CUSASAP(SEGID,ELMPOS)),"^",2)) I X="^" Q
 . S $P(ELMDATA,"^",2)=X
 . ; Data Element Format
 . S X=$$ASKFLD("58.400111,.03",$P($G(CUSASAP(SEGID,ELMPOS)),"^",3)) I X="^" Q
 . S $P(ELMDATA,"^",3)=X
 . ; Data Element Maximum Length
 . S X=$$ASKFLD("58.400111,.04",$P($G(CUSASAP(SEGID,ELMPOS)),"^",4)) I X="^" Q
 . S $P(ELMDATA,"^",4)=X
 . ; Data Element Requirement
 . S X=$$ASKFLD("58.400111,.06",$P($G(CUSASAP(SEGID,ELMPOS)),"^",6)) I X="^" Q
 . S $P(ELMDATA,"^",6)=X
 . ; Data Element Description
 . W !,"DESCRIPTION:" K ^TMP("PSOASDES",$J)
 . ; Transferring Description from Local Array ALLASAP to ^TMP($J)
 . F I=1:1 Q:'$D(ALLASAP(SEGID,ELMPOS,"DES",I))  D
 . . S ^TMP("PSOASDES",$J,I,0)=ALLASAP(SEGID,ELMPOS,"DES",I)
 . K DIC S DWPK=1,DIC="^TMP(""PSOASDES"","_$J_"," D EN^DIWE
 . ; Transferring Description from ^TMP($J) to Local Array CUSASAP
 . F I=1:1 Q:'$D(^TMP("PSOASDES",$J,I,0))  D
 . . S ELMDATA("DES",I)=^TMP("PSOASDES",$J,I,0)
 . ; Data Element M Expression
 . S DONE=0,MEXPR=""
 . F I=1:1 Q:'$D(ALLASAP(SEGID,ELMPOS,"VAL",I))  D
 . . S MEXPR=MEXPR_ALLASAP(SEGID,ELMPOS,"VAL",I)
 . S X=$$ASKMEXPR($P(ALLASAP(SEGID),"^",6),CUSELM,$P(ELMDATA,"^",4),MEXPR) I X="^" Q
 . S ELMDATA("VAL",1)=X
 . ; Confirm
 . W ! S X=$$ASKFLD("Y","YES","Save Custom Data Element") I X'=1 Q
 . W ?40,"Saving..."
 . ; The Custom ASAP Segment node might not be present, therefore it must be created
 . I $G(CUSASAP(SEGID))="" D COPYSEG^PSOSPMU3(PSOASVER,.STDASAP,PSOASVER,SEGID)
 . D SAVEELM^PSOSPMU3(PSOASVER,SEGID,$S(NEWELM:"+1",1:CUSELM),.ELMDATA)
 . W "OK",$C(7)
 G CEL
 ;
ASKFLD(FIELD,DEFAULT,PROMPT) ; Prompt
 ;Input: (r) FIELD   - DD Field reference (e.g., "58.40011;.02") for ^DIR call
 ;       (o) DEFAULT - Default value
 ;       (o) PROMPT  - Alternative prompt label
 ;Output: User entered value or "^"
 N ASKFLD,DIR,DTOUT,DIRUT,X,Y,DONE
 S ASKFLD="",DIR(0)=FIELD S:$G(DEFAULT)'="" DIR("B")=DEFAULT S:$G(PROMPT)'="" DIR("A")=PROMPT
 S DONE=0 F  D ^DIR D  I DONE Q
 . I X["^",$L(X)>1 W !,"Jumping is not supported. Enter '^' to exit.",$C(7) Q
 . I X="@" S ASKFLD=X,DONE=1 Q
 . I (X'=""),$D(DIRUT)!$D(DTOUT) S DONE=1 Q
 . S ASKFLD=Y,DONE=1
 I X'="",X'="@",$D(DIRUT)!$D(DTOUT) S ASKFLD="^"
 Q ASKFLD
 ;
ASKMEXPR(LEVEL,ELMID,MAXLEN,DEFAULT) ; Prompt for M SET Expression
 ;Input: (r) LEVEL   - Level of the Segment where the Data Element is located
 ;       (r) ELMID   - Data Element ID ("PHA01", "DSP02", etc.)
 ;       (r) MAXLEN  - Element ID value Maximum Length
 ;       (o) DEFAULT - Default value
 ;Output: M SET Expression or "^"
 N ASKMEXPR,DONE,ERROR
 S DONE=0,X=$G(DEFAULT)
 F  D  I DONE Q
 . S X=$G(DEFAULT) W !,"M SET EXPRESSION: "_$S(X'="":X_"// ",1:"")
 . R X:DTIME S:X="" X=$G(DEFAULT) I '$T!(X="^") S ASKMEXPR="^",DONE=1 Q
 . I X["?" W ! D MEXPRHLP^PSOSPML3(LEVEL,ELMID) W ! Q
 . I '$$VALID^PSOSPMU3(PSOASVER,X) W !,$P($$VALID^PSOSPMU3(PSOASVER,X),"^",2),$C(7),! Q
 . I '$$CHKVAR^PSOSPMU3(LEVEL,X) Q
 . D CHKCODE^PSOSPMU3(LEVEL,X,.ERROR) I ERROR Q
 . I $E(X,1)="""",$E(X,$L(X))="""",$E(X,2,$L(X)-1)'["""",$L(X)-2>MAXLEN D  Q
 . . W !,"The length cannot be longer than the maximum (",MAXLEN,").",$C(7),!
 . S ASKMEXPR=X,DONE=1
 Q ASKMEXPR
 ;
SECKEY() ; Checking the Security Key PSO SPMP ADMIN for certain actions
 I '$D(^XUSEC("PSO SPMP ADMIN",DUZ)) S VALMSG="PSO SPMP ADMIN key required for this action!" W $C(7) Q 0
 Q 1
 ;
LOCK() ; Try to LOCK the SPMP ASAP RECORD DEFINITION file (#58.4)
 L +^PS(58.4):0 I '$T D  Q 0
 . S VALMSG="Another user is editing the ASAP Definitions" W $C(7)
 Q 1
 ;
BACK ; Unlock ASAP Definition File Go Back to the list
 L -^PS(58.4)
 D INIT^PSOSPML3,HDR^PSOSPML3 I 'VALMCNT Q
EXIT ; Exit without rebuilding the list
 S VALMBCK="R"
 Q
