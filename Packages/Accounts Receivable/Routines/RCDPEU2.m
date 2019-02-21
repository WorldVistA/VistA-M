RCDPEU2 ;AITC/CJE - ELECTRONIC PAYER UTILITIES ;05-NOV-02
 ;;4.5;Accounts Receivable;**326**;Mar 20, 1995;Build 26
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
EFT344(PROMPT,IEN344) ; Select and EFT and update reciept - EP
 ; Input: PROMPT - Prompt to use when picking an EFT
 ;        IEN344 - Internal entry number to file 344
 ; Output
 N FDA,IEN34431,SCREEN
 S SCREEN="I '$O(^RCY(344,""AEFT"",+Y,0)),$P($G(^RCY(344.31,+Y,0)),U,8)=0"
 S IEN34431=$$ASKEFT(PROMPT,SCREEN)
 I IEN34431>0,IEN344 D  ;
 . S FDA(344,IEN344_",",.17)=IEN34431
 . D FILE^DIE("","FDA")
 . I '$D(^TMP("DIERR",$J)) K DIC("W")
 . W !!,IEN34431,!!
 Q
ASKEFT(PROMPT,SCREEN) ; Select an EFT for an EDI Lockbox receipt - EP
 ; Inputs: PROMPT - Prompt to use when asking user to enter an EFT.
 ;         SCREEN - Screen for use in file 344.31 look-up
 ; Returns: IEN from file 344.31 or -1 if user times out or '^'
 ;
 N COUNT,DA,DIC,DIR,DIRUT,DIROUT,DTOUT,DUOUT,FIELDS,FILE,FLAGS,IENS,INDEXES,QUIT,RETURN,VALUE,X,Y
 K ^TMP("DILIST",$J),^TMP("DIERR",$J)
 S (RETURN,QUIT)=0
 S FILE=344.31,IENS=""
 S FIELDS=".01;.02;.03;.04;.07;.14"
 S FLAGS="M"
 S INDEXES=""
 F  D  Q:QUIT  ;
 . W !,PROMPT R VALUE:DT
 . I '$T S QUIT=1,RETURN=-1 Q  ; Timeout
 . I VALUE="" S QUIT=1,RETURN=0 Q
 . I $E(VALUE)="^"!(VALUE="") S QUIT=1,RETURN=-1 Q
 . I $E(VALUE)="?" S VALUE=""
 . I VALUE="" D  ;
 . . D LIST^DIC(FILE,"",FIELDS,FLAGS,"*","","","B",SCREEN,"","","")
 . E  D  ;
 . . D FIND^DIC(FILE,"",FIELDS,FLAGS,VALUE,"","",SCREEN,"","","")
 . S COUNT=$P($G(^TMP("DILIST",$J,0)),"^",1)
 . I COUNT=1,VALUE'="" D  Q  ;
 . . S RETURN=+$P($G(^TMP("DILIST",$J,2,1)),"^",1),QUIT=1
 . I COUNT>0 D  ;
 . . S RETURN=$$PICKEFT()
 . . I RETURN>0 S QUIT=1
 Q RETURN
 ;
PICKEFT() ; Given output from FIND^DIC, pick an EFT from the list
 ; Input: ^TMP("DILIST",$J) in non-packed format
 ; Returns: IEN from file 344.31, or 0 if user does not pick an item from the list
 ;
 N CNT,COUNT,QUIT,RETURN
 S COUNT=$P($G(^TMP("DILIST",$J,0)),"^",1)
 S (QUIT,RETURN)=0
 F CNT=1:1:COUNT D  Q:QUIT  ;
 . D WRITE(CNT)
 . I CNT#10=0!(CNT=COUNT) D  Q:QUIT  ;
 . . S RETURN=$$READ(CNT) I RETURN=-1!(RETURN>0) S QUIT=1
 Q RETURN
 ;
READ(LAST) ;
 ; Input: LAST - The last number displayed that can be picked in the number range 1-LAST
 ; Returns: IEN from 344.31 if one is picked, otherwise -1 (^ or timeout) or 0 - nothing picked
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,QUIT,RETURN,VALUE,X,Y
 S RETURN=0
 S DIR(0)="NO^1:"_LAST
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) Q -1
 I Y,$D(^TMP("DILIST",$J,2,Y)) S RETURN=^TMP("DILIST",$J,2,Y)
 Q RETURN
WRITE(X) ; Write out one entry from 344.31
 ; Input: X=Counter from ^TMP("DILIST",$J) output from FIND^DIC
 ; Output: To screen
 N DEPDAT,DEPNO,EFTID,EFTIEN,EFTTR,PAYAMT,PAYNAM,PAYTR,SP,TIN
 S SP=$J("",3)
 S EFTIEN=$P(^TMP("DILIST",$J,1,X),".")
 S EFTID=^TMP("DILIST",$J,"ID",X,.01)
 S PAYNAM=^TMP("DILIST",$J,"ID",X,.02)
 S TIN=^TMP("DILIST",$J,"ID",X,.03)
 S PAYTR=^TMP("DILIST",$J,"ID",X,.04)
 S PAYAMT=^TMP("DILIST",$J,"ID",X,.07)
 S DEPNO=$$GET1^DIQ(344.3,EFTIEN,.03,"E")
 S DEPDAT=$$FMTE^XLFDT($$GET1^DIQ(344.3,EFTIEN,.07,"I"),"2DZ")
 ; EFT DETAIL lookup
 S PAYNAM=$E(PAYNAM,1,62-$L(TIN))_"/"_TIN I PAYNAM="/" S PAYNAM=""
 W !,$J(X,4),?7,EFTID,?16," ",PAYNAM
 W !,?16," ",PAYTR,?48," ",$J(PAYAMT,10)
 W ?59," ",DEPNO,?71," ",DEPDAT
 Q
