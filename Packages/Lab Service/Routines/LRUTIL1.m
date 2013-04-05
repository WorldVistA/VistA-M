LRUTIL1 ;DALOI/JDB -- Lab Utilities ;06/12/09  15:31
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 Q
 ;
SELECT(DIC,OUT,FNAME,SELS,SORT,NOALL,MODE) ;
 ; Package replacement for FIRST^VAUTOMA
 ; Allows user to select multiple entries from a file.
 ; Inputs
 ;    DIC :<byref> Standard DIC array
 ;    OUT :<byref> See Outputs below
 ;  FNAME :<opt> Filename to use for "Select " prompt
 ;         : FNAME="" and DIC=# then uses File's Name
 ;   SELS :<opt> How many selections user may make. dflt=20
 ;   SORT :<opt> Numeric or Alpha sort? N or A -or- 0 or 1
 ;  NOALL ;<opt> If 1 then user cannot select "ALL"
 ;   MODE :<opt> Behave like FIRST^VAUTOMA or not (1 or 0)
 ;        : dflt=0 (not) (see Outputs below for info)
 ; Outputs
 ;    Returns the # of records selected
 ;    OUT : Array that holds the records selected
 ;        : MODE=0   OUT=total selected  or  OUT="*" (ALL)
 ;        :  SORT=0 -> OUT(select seq)=IEN
 ;        :  SORT=1 -> OUT(alpha seq)=IEN
 ;        :
 ;        : MODE=1 (VAUTOMA mode) OUT=""  or  OUT=1 (ALL)
 ;        :  SORT=0 -> OUT(IEN)=.01 field
 ;        :  SORT=1 -> OUT(.01 field)=IEN
 ;
 N X,Y,CNT,STOP,DIR,DELSEL,NODE,I,TMPNM,LRDIC
 N DTOUT,DUOUT,DIRUT,DIROUT,DIERR
 ;
 S FNAME=$G(FNAME)
 S SELS=$G(SELS,20)
 S NOALL=$G(NOALL)
 S SORT=$G(SORT)
 S MODE=$G(MODE)
 I SORT="A" S SORT=1
 I SORT="N" S SORT=0
 K OUT
 K DIC("B")
 S (STOP,CNT)=0
 S TMPNM="LRUTIL1"
 I FNAME="" I DIC D  ;
 . K DATA,DIERR
 . D FILE^DID(DIC,"","NAME","DATA","ERR")
 . Q:'$D(DATA)
 . S FNAME=DATA("NAME")
 . K DATA,DIERR
 ;
 K ^TMP(TMPNM,$J)
 I 'NOALL S DIC("B")="ALL" S DIR("B")=DIC("B")
 I $G(DIC(0))="" S DIC(0)="EQMZ"
 F  D  Q:STOP  Q:CNT'<SELS  ;
 . I 'CNT D  ;
 . . S X=$G(DIC("A"))
 . . I X="" S X="Select "_FNAME
 . . S DIR("A")=X
 . . S DIR(0)="FO"
 . . S DIR("?")="^D HELP^LRUTIL1"
 . ;
 . I CNT=1 D  ;
 . . K DIR("B")
 . . S DIR(0)="FAO"
 . . S X=$G(DIC("A"))
 . . I X="" S X=FNAME
 . . Q:X?1"Select another "0.E
 . . S DIR("A")="Select another "_X_": "
 . ;
 . K LRDIC M LRDIC=DIC ;save DIC for ^DIR's help processor
 . D ^DIR
 . I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) K OUT S CNT=0 S STOP=1 Q
 . I 'NOALL I Y="ALL" K OUT S CNT="*" S STOP=1 Q
 . S DELSEL=0
 . I $E(Y)="-" D  ;
 . . S DELSEL=1
 . . S Y=$E(X,2,$L(Y))
 . I Y="" S STOP=1 Q
 . S X=Y
 . D ^DIC
 . I $D(LRDIC("W")) S DIC("W")=LRDIC("W") ; restore DIC("W") - it's killed in DIC calls.
 . I $D(DTOUT)!$D(DUOUT) K OUT S CNT=0 S STOP=1 Q
 . I Y>0 D  ;
 . . S NODE="^TMP(TMPNM,$J,1,0,+Y)"
 . . I SORT=1 S NODE="^TMP(TMPNM,$J,1,$P(Y,""^"",2),+Y)"
 . . I 'DELSEL I '$D(@NODE) D  ;
 . . . S CNT=CNT+1
 . . . S @NODE=CNT
 . . . S ^TMP(TMPNM,$J,2,"B",$P(Y,"^",2),+Y)=""
 . . . S ^TMP(TMPNM,$J,2,"C",+Y)=$P(Y,"^",2)
 . . I DELSEL D  ;
 . . . I $D(@NODE) S CNT=CNT-1 S:CNT<0 CNT=0
 . . . K @NODE
 . . . K ^TMP(TMPNM,$J,2,"B",$P(Y,"^",2),+Y)
 . . . K ^TMP(TMPNM,$J,2,"C",+Y)
 . . ;
 . ;
 ;
 I $D(^TMP(TMPNM,$J,1)) D  ;
 . S NODE="^TMP(TMPNM,$J,1)"
 . S I=0
 . F  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,3)'=1  Q:$QS(NODE,2)'=$J  Q:$QS(NODE,1)'=TMPNM  D  ;
 . . S I=I+1
 . . I 'MODE I SORT S OUT(I)=$QS(NODE,5) Q
 . . I MODE I SORT S OUT($QS(NODE,4))=$QS(NODE,5) Q
 . . I 'SORT S OUT(0,@NODE)=$QS(NODE,5)
 . ;
 ;
 I $D(OUT(0)) D  ;
 . S I=0
 . F  S I=$O(OUT(0,I)) Q:'I  D  ; I=CNT
 . . S X=OUT(0,I) ;IEN
 . . I 'MODE S OUT(I)=X
 . . I MODE S OUT(X)=^TMP(TMPNM,$J,2,"C",X)
 . ;
 ;
 K OUT(0)
 K ^TMP(TMPNM,$J)
 ;
 ; Update OUT with status based on value of MODE.
 I MODE D  ;
 . I CNT=0 K OUT S OUT=""
 . I CNT>0 S OUT=""
 . I CNT="*" K OUT S OUT=1
 ;
 I 'MODE D
 . I CNT=0 K OUT S OUT=""
 . I CNT>0 S OUT=CNT
 . I CNT="*" K OUT S OUT=CNT
 ;
 Q CNT
 ;
 ;
HELP ;
 ; Displays "?" help info. For use with above.
 ; Expects SELS,NOALL,FNAME,CNT,TMPNM,LRDIC
 N LRX,DIC
 W !,"ENTER up to ",SELS,":"
 I 'CNT&'NOALL W !?5,"- <return> for all ",FNAME,"s, or"
 W !?5,"- a ",FNAME," or <return> after all selections made."
 I CNT D  ;
 . W !?5,"- An entry preceded by a minus [-] sign to remove entry from list."
 . W !,"NOTE, you have already selected:"
 . S LRX=""
 . F  S LRX=$O(^TMP(TMPNM,$J,2,"B",LRX)) Q:LRX=""  D  ;
 . . W !?8,LRX
 . W !
 . ;
 ; now show selectable entries
 ; X is from the ^DIR call ($E(X)="?")
 ; DIC isnt avail here because ^DIR News it.
 I $D(LRDIC) M DIC=LRDIC
 D ^DIC
 Q
