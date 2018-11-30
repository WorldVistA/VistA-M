PXCPTAPI ;ALB/EW - PCE CPT CODE API ; 08/09/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**73,211**;Aug 12, 1996;Build 244
GETCODE(HELP) ;
 N CODE,CODEIEN,CODESYS,EVENTDT,PXCEDT,SRCHTERM
 S CODESYS="CPT^CPC"
 ;Prompt the user for the Lexicon search term.
 S SRCHTERM=$$GETST^PXLEX
 I SRCHTERM="" Q -1
 ;Prompt the user for the Event Date and Time.
 S EVENTDT=$$EVENTDT^PXDATE(HELP)
 S PXCEDT=EVENTDT
 ;If the Event Date and Time is null use the Visit Date.
 I PXCEDT="" S PXCEDT=$P(^TMP("PXK",$J,"VST",1,0,"BEFORE"),U,1)
 ;Let the user select the code(s), only return active codes.
 S CODE=$$GETCODE^PXLEXS(CODESYS,SRCHTERM,PXCEDT,1)
 I CODE="" Q -1
 S CODEIEN=$$CODEN^ICPTCOD(CODE)
 S $P(PXCEAFTR(12),U,1)=EVENTDT
 Q CODEIEN_U_CODE
 ;
 ;GETCODE(PXDFLT,PXCPTDT) ;Read in CPT Code. 
 ;This is replaced by above search in PX*1.0*211
 ;
 ;    INPUT:   PXDFLT - Default CPT code
 ;             PXCPTDT - Visit date
 ;
 ;   OUTPUT:  CPT CODE - Modifier string
 ;
 ;
 ;PROMPT N DIR,DIRUT,DUOUT,DTOUT,PXDATA,X,Y
 ;S DIR(0)="FAO^^K:'$$VALCPT^PXCPTAPI(X,PXCPTDT,.PXDATA) X"
 ;S DIR("A")="CPT Code: "
 ;S DIR("?")="^D CPTHLP^PXCPTAPI"
 ;S DIR("??")="^S X=$$VALCPT^PXCPTAPI(.X,PXCPTDT,.PXDATA)"
 ;S:PXDFLT]"" DIR("B")=PXDFLT
 ;D ^DIR
 ;I $D(DIRUT),X="@" Q X
 ;I $D(DIRUT)!($D(DUOUT))!($D(DTOUT))!(Y="") Q -1
 ;I PXDATA<0 D CPTHLP^PXCPTAPI G PROMPT
 ;Q PXDATA
 ;
 ;
 ;VALCPT(PXTEXT,PXCPTDT,PXVAL) ;
 ;Validate freetext responce entered for CPT Code question
 ;Input:  PXTEXT - CPT Code or CPT Code and CPT Modifier Code
 ;           format: CPT or CPT-MOD,MOD,...
 ;              where CPT = valid CPT Code
 ;                    MOD = valid Modifier Code
 ;        PXCPTDT - visit date
 ;        
 ;
 ;
 ;Output:  1 - Valid
 ;         0 - Invalid
 ;
 ;N DIC,X,Y
 ;S X=$P(PXTEXT,"-")
 ;S DIC=81
 ;S DIC(0)="EMQ"
 ;S DIC("S")="I $$CPTSCREN^PXBUTL(Y,PXCPTDT)"
 ;D ^DIC
 ;S PXVAL=Y_$S($P(PXTEXT,"-",2)]"":"-"_$P(PXTEXT,"-",2),1:"")
 ;Q Y
 ;
CPTMOD(PXIEN,PXMOD,PXHELP) ;Validate selected modifier
 ;
 ;     INPUT:  PXIEN - IEN for CPT code in V CPT file
 ;             PXMOD - IEN for CPT modifier
 ;             PXHELP - Flag to determing if help text should display
 ;                       when an invalid modifier is entered.
 ;                where 1 = Display help text
 ;                      0 = Do not display help text
 ;
 N PXVST,PXVSTDT,PXSTAT
 S PXCPT=$P(^AUPNVCPT(PXIEN,0),U)
 ;If Event Date and Time exists, use it otherwise use Visit Date.
 S PXVSTDT=$P($G(^AUPNVCPT(PXIEN,12)),U,1)
 I PXVSTDT="" D
 . S PXVST=$P(^AUPNVCPT(PXIEN,0),U,3)
 . S PXVSTDT=$P($G(^AUPNVSIT(PXVST,0)),U)
 S PXSTAT=$$MODP^ICPTMOD(PXCPT,PXMOD,"I",PXVSTDT)
 D:PXSTAT'>0 MODHLP
 Q PXSTAT
 ;
CPTHLP ;CPT code help text display
 ;
 W !,"Enter CPT code or partial name for lookup."
 Q
MODHLP ;CPT modifier help text display
 ;
 Q:'$G(PXHELP)
 W !,"You can only enter a modifier that is valid for the selected CPT code."
 Q
