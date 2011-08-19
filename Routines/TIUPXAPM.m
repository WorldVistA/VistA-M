TIUPXAPM ;SLC/RMO - CPT Modifier API(s) ;03/06/03@1500
 ;;1.0;TEXT INTEGRATION UTILITIES;**82,161**;Jun 20, 1997
 ;
 ;Pass in encounter date for CSV **161**
MOD(CPT,TIUI,TIUVDT) ;Select CPT Modifiers for CPT Code
 ; Input  -- CPT      CPT Selection Array
 ;           TIUI     Item Number in CPT Selection Array
 ;           TIUVDT   Encounter Date  
 ; Output -- CPT      CPT Selection Array
 N CPTIEN,I,MOD,MODATA,MODCNT
 S CPTIEN=+CPT(TIUI)
 ;
 ;Check if there are any selectable CPT Modifiers for the CPT Code
 ;Current date passed to ICPTCOD, changed to encounter date for CSV **161**
 I +$$CODM^ICPTCOD(CPTIEN,,"",TIUVDT)'>0 G MODQ
 ;
 ;Set CPT Modifier Selection Array for pre-selected CPT Modifiers
 S (I,MODCNT)=0
 F  S I=$O(CPT(TIUI,"MOD",I)) Q:'I  D
 . S MODCNT=MODCNT+1
 . S MOD(+$G(CPT(TIUI,"MOD",MODCNT)))=""
 ;
 ;Display pre-selected CPT Modifiers
 D DISMOD(.CPT,TIUI,1)
 ;
 ;Ask CPT Modifiers
 S MODCNT=$S($G(MODCNT):MODCNT,1:0)
 ;Pass encounter date to ASKMOD for CSV **161**
 F  Q:'$$ASKMOD(CPTIEN,.MOD,MODCNT,.MODATA,TIUVDT)  D
 . S MOD(+MODATA)=""
 . S MODCNT=MODCNT+1
 . S CPT(TIUI,"MOD",MODCNT)=MODATA
 . S MODATA=""
MODQ Q
 ;
 ;Pass in encounter date for CSV **161**
ASKMOD(CPTIEN,MOD,MODCNT,MODATA,TIUVDT) ;Ask CPT Modifier
 ; Input  -- CPTIEN   CPT file (#81) IEN
 ;           MOD      CPT Modifier Selection Array
 ;           MODCNT   Number of Modifiers Selected
 ;   TIUVDT   Encounter Date
 ; Output -- 1=Successful and 0=Failure
 ;           MODATA   Modifier Data from Modifier file (#81.3)
 ;                    1st Piece=IEN
 ;                    2nd Piece=Modifier field (#.01)
 ;                    3rd Piece=Name field (#.02)
 N DIR,DTOUT,DUOUT,Y
 S DIR(0)="PAO^81.3:AEMQZ^K:'$$CHKMOD^TIUPXAPM(.MOD,+Y) X"
 S DIR("A")="Select "_$S($G(MODCNT):"another ",1:"")_"CPT MODIFIER: "
 ;Pass encounter date to ICPTMOD for CSV **161**
 S DIR("S")="I +$$MODP^ICPTMOD(CPTIEN,+Y,""I"",TIUVDT)>0"
 D ^DIR
 I Y>0 S MODATA=+Y_U_$P(Y(0),U,1,2)
 Q $S($G(MODATA)="":0,1:1)
 ;
CHKMOD(MOD,MODIEN) ;Check Selected CPT Modifier
 ; Input  -- MOD      CPT Modifier Selection Array
 ;           MODIEN   Modifier file (#81.3) IEN
 ; Output -- 1=Successful and 0=Failure
 N Y
 S Y=1
 ;Check if CPT Modifier has already been selected
 I $D(MOD(MODIEN)) D EN^DDIOL("This CPT Modifier has already been selected.","","!?5") S Y=0
 Q +$G(Y)
 ;
DISMOD(CPT,TIUI,TIUSELF) ;Display Selected CPT Modifiers
 ; Input  -- CPT      CPT Selection Array
 ;           TIUI     Item Number in CPT Selection Array
 ;           TIUSELF  Selection Process Flag  (Optional)
 ;                    1=Selection Process
 ; Output -- None
 N CAP,MODATA,MODCNT,TC
 ;
 ;Set caption and format parameter
 I $G(TIUSELF) D
 . S CAP="Current CPT Modifiers:",TC=0
 ELSE  D
 . S CAP="CPT Modifier(s):",TC=8
 S MODCNT=0
 F  S MODCNT=$O(CPT(TIUI,"MOD",MODCNT)) Q:'MODCNT  D
 . S MODATA=$G(CPT(TIUI,"MOD",MODCNT))
 . W:MODCNT=1 !,?TC,CAP
 . W !?12,"-",$P(MODATA,U,2),?19,$P(MODATA,U,3)
 Q
