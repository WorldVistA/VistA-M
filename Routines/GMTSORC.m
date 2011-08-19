GMTSORC ; SLC/JER,KER - Current Orders (V2.5) ; 09/21/2001
 ;;2.7;Health Summary;**15,28,47**;Oct 20, 1995
 ;                 
 ; External References
 ;   DBIA 10141  $$VERSION^XPDUTL
 ;                 
MAIN ; Controls branching and execution
 I $$VERSION^XPDUTL("OR")'<3 G MAIN^GMTSORC3
 Q
 ;                 
WRAP(TEXT,LENGTH) ; Breaks text string into substrings
 ;                
 ;    Input
 ;       TEXT = Text String
 ;       LENGTH = Maximum Length of Substrings
 ;                            
 ;    Output vertical bar delimted text
 ;       substring|substring|substring|substring|substring
 ;                            
 N GMTI,GMTJ,LINE,GMX,GMX1,GMX2,GMY
 I $G(TEXT)']"" Q ""
 F GMTI=1:1 D  Q:GMTI=$L(TEXT," ")
 . S GMX=$P(TEXT," ",GMTI)
 . I $L(GMX)>LENGTH D
 . . S GMX1=$E(GMX,1,LENGTH),GMX2=$E(GMX,LENGTH+1,$L(GMX))
 . . S $P(TEXT," ",GMTI)=GMX1_" "_GMX2
 S LINE=1,GMX(1)=$P(TEXT," ")
 F GMTI=2:1 D  Q:GMTI'<$L(TEXT," ")
 . S:$L($G(GMX(LINE))_" "_$P(TEXT," ",GMTI))>LENGTH LINE=LINE+1,GMY=1
 . S GMX(LINE)=$G(GMX(LINE))_$S(+$G(GMY):"",1:" ")_$P(TEXT," ",GMTI),GMY=0
 S GMTJ=0,TEXT="" F GMTI=1:1 S GMTJ=$O(GMX(GMTJ)) Q:+GMTJ'>0  S TEXT=TEXT_$S(GMTI=1:"",1:"|")_GMX(GMTJ)
 Q TEXT
