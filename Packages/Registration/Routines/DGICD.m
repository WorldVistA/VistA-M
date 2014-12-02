DGICD ;BIR/SJA - CODE SET VERSIONING UTILITY ;01/30/12  05:50 PM
 ;;5.3;Registration;**850**;Aug 13, 1993;Build 171
 ;
 ;Reference to $$ICDDATA^ICDXCODE supported by DBIA #5699
 ;
ASKOK(TOTAL) ;
 Q:$G(TOTAL)<100
 ;
 ; -- See default setting of DGASK at LEX+17
 I $G(DGASK)=1 D  Q
 . D EN^DDIOL("A total of "_$G(TOTAL)_" Entries found for this search.","","!!")
 . D EN^DDIOL("Please refine your Search!")
 . D EN^DDIOL(" ")
 . H 3 S DGOK=0
 . Q
 ;
 I $G(DGASK)=2 D  Q
 . W !!,"   Searching for """_ICDTXT_""" requires inspecting "_$G(TOTAL)_" records to determine"
 . W !,"   if they match the search criteria. This could take quite some time. Suggest"
 . W !,"   refining the search by further specifying """_ICDTXT_""".",!
 . ;
 . N DIR,X,Y
 . S DIR(0)="Y",DIR("A")="   Do you wish to continue (Y/N)"
 . S DIR("B")="No"
 . S DIR("?")="   Answer 'Y' for 'Yes' to continue searching on "_ICDTXT_" or 'N' for 'No' to refine search criteria."
 . D ^DIR
 . I $D(DIROUT)!($D(DIRUT))!($D(DTOUT))!($D(DTOUT)) S DGOK=0 Q
 . S DGOK=Y
 . I DGOK=1 W !,"        Searching...."
 . W !
 Q
LEX ; -- Called indirectly out of input transforms
 ; -- INPUT
 ;            X := the value to be search for (required)
 ;      EFFDATE := the date of interest for the search (required)
 ;
 N %DT,DIROUT,DUOUT,DTOUT,ICDEXIT,ICDDT,ICDTXT,ICDUP,ICDY,XX,DGTOT,DGOK,DGZZONE
 S ICDTXT=$G(X) Q:'$L(ICDTXT)
 ;
 I ICDTXT["?" D  K X,Y Q  ; - added here for calls that bypass ^DGICDGT
 . N TAG,FORMAT
 . S TAG=$S(X["???":"D3^DGICDGT",X["??":"D2^DGICDGT",X["?":"D1^DGICDGT",1:"D1^DGICDGT")
 . D @TAG
 . Q
 ;
 I $L(ICDTXT)<2 D  S X="" Q
 . D EN^DDIOL("Please enter at least the first two characters of the ICD-10","","!!?5")
 . D EN^DDIOL("code or code description to start the search.","","!?5")
 . D EN^DDIOL(" ")
 . Q
 ;
 I '$G(DGASK) S DGASK=2 ;1:= Do not ask to continue, just quit, 2:=ask to continue
 S DGTOT=$$FREQ^LEXU(ICDTXT) ;IA 5679
 I DGTOT>$$MAX^LEXU(30) D ASKOK(DGTOT) Q:'$G(DGOK)
 ;
 S ICDDT=$G(EFFDATE),ICDEXIT=0
 K DGASK,DGOK
 ; Begin Recursive Loop
LOOK ; Lookup
 Q:+($G(ICDEXIT))>0  K ICDY
 S ICDY=$$DIAGSRCH^LEX10CS(ICDTXT,.ICDY,ICDDT,30)
 S:$O(ICDY(" "),-1)>0 ICDY=+ICDY
 I +ICDY'>0 D:'$D(DA) EN^DDIOL("   ??") K X,Y Q
 S XX=$$SEL^DGICDL(.ICDY,8)
 I $D(DUOUT)&('$D(DIROUT)) K:'$D(ICDNT) X Q
 I $D(DTOUT)&('$D(DIROUT)) S ICDEXIT=1 K X Q
 I $D(DIROUT) S ICDEXIT=1 K X Q
 ; Abort if timed out or user enters "^^"
 I $D(DTOUT)!($D(DIROUT)) S ICDEXIT=1 K X Q
 ; Up one level (ICDUP) if user enters "^"
 ; Quit if already at top level and user enters "^"
 I $D(DUOUT),'$D(DIROUT),$L($G(ICDUP)) K X Q
 ; No Selection
 I '$D(DUOUT),XX=-1 S ICDEXIT=1
 ; Code Found and Selected
 I $P(XX,";")'="99:CAT" S Y=+$$ICDDATA^ICDXCODE("10D",$P($P(XX,"^"),";",2)) S ICDEXIT=1 D  Q
  . W:'$D(DGZZONE) "  ",$P(XX,";",2),"  ICD-10  ",$$VST^ICDEX(80,Y)
 ; Category Found and Selected
 D NXT G:+($G(ICDEXIT))'>0 LOOK
 Q
NXT ; Next
 Q:+($G(ICDEXIT))>0  N ICDNT,ICDND,ICDX
 S ICDNT=$G(ICDTXT),ICDND=$G(ICDDT),ICDX=$G(XX)
 N ICDTXT,ICDDT S ICDTXT=$P($P(ICDX,"^"),";",2),ICDDT=ICDND
 G LOOK
 Q
MW(X) ; Multiple Words
 ; returns 0 if 1 word
 ;         1 if more than 1 word
 N INP,CHR,PSN,STR,P1,P2,CT S INP=$G(X) Q:'$L(INP) -1
 S CT=0,STR=" ()_-{}[]\:;,<>" F PSN=1:1:$L(STR)  S CHR=$E(STR,PSN) S CT=0 D  Q:CT>1
 . S P1=$P(INP,CHR,1),P2=$P(INP,CHR,2,299) S:$L(P1)&(P1'?1N.N) CT=CT+1 S:$L(P2)&(P2'?1N.N) CT=CT+1
 Q:CT'>1 0
 Q 1
