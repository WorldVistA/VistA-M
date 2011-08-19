VAQDIS20 ;ALB/JFP - Function Calls for Display;03FEB93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
 ;
FUNCT ; *************** Function Calls *************** 
 ;
CENTER(LINE,CTR) ; -- Centers text on 80 column screen
 ;              INPUT  : line - line to center in
 ;                     : ctr  - text to center
 ;             OUTPUT  : X    - centered text
 Q:('$D(LINE)) ""
 Q:('$D(CTR)) ""
 N LEN,LNST
 S LEN=$L(CTR)
 S LNST=((80-LEN)\2)+1
 S X=$$INSERT^VAQUTL1(CTR,LINE,LNST,LEN)
 Q X
 ;
STATE(STATE) ; -- Converts state to abrev
 ;              INPUT  : state - long state
 ;             OUTPUT  : stavb     - abrev state
 Q:('$D(STATE)) ""
 Q:STATE="" ""
 N SDA,STABV
 S SDA="",SDA=$O(^DIC(5,"B",STATE,SDA))
 S STABV=$S(SDA'="":$P(^DIC(5,SDA,0),U,2),1:" ")
 Q STABV
 ;
COUNTY(STATE,CNTYPT) ; -- Converts county pointer to apha, if passed
 ;              INPUT  : state  - long state
 ;                     : cntypt - county pointer OR text
 ;             OUTPUT  : county - county name
 Q:('$D(STATE)) ""
 Q:('$D(CNTYPT)) ""
 Q:(CNTYPT'?1N.N) CNTYPT
 Q:STATE="" ""
 Q:CNTYPT="" ""
 N SDA,CDA,STAVB,COUNTY
 S (SDA,CDA)=""
 S SDA=$O(^DIC(5,"B",STATE,SDA))
 Q:SDA="" ""
 S CDA=$O(^DIC(5,SDA,1,"C",CNTYPT,CDA))
 S COUNTY=$S(CDA'="":$P(^DIC(5,SDA,1,CDA,0),U,1),1:" ")
 Q COUNTY
 QUIT
 ;
BLANK ; -- Sets up blank line
 S X=$$SETSTR^VALM1(" ","",1,80) D TMP ; -- null line
 QUIT
 ;
TMP ; -- Sets up display array
 S VALMCNT=VALMCNT+1
 S @ROOT@(VALMCNT,0)=$E(X,1,79)
 QUIT
 ;
ROOT(ROOT) ; -- Sets root to display
 I ROOT["()" S TMP=$P(ROOT,")",1),ROOT=TMP_$C(34)_"DISPLAY"_$C(34)_")" K TMP  QUIT ROOT
 I ROOT[")" S TMP=$P(ROOT,")",1),ROOT=TMP_","_$C(34)_"DISPLAY"_$C(34)_")" K TMP  QUIT ROOT
 I ROOT'[")" S ROOT=ROOT_"("_$C(34)_"DISPLAY"_$C(34)_")"  QUIT ROOT
 QUIT ROOT
 ;
END ; -- End of code
 QUIT
