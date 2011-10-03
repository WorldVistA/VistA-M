LRAFUNC ;SLC/MRH/FHS - FUNCTION CALLS A5AFUNC
 ;;5.2;LAB SERVICE;**286**;Sep 27, 1994
 ;
 N I,X
 W !!,"Routine: "_$T(+0),! F I=8:1 S X=$T(LRAFUNC+I) Q:'$L(X)  I X[";;" W !,X
 W !!
 Q
 ;;
UPCASE(X) ;; $$UPCASE(X)
 ;; Call by value
 ;; X in lowercase
 ;; Returns uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;;
LOWCASE(X) ;; $$LOWCASE(X)
 ;; Call by value
 ;; X in uppercase 
 ;; Returns lowercase
 Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 ;;
STRIP(X,Y) ;; Strips all instances of character 'Y' in string 'X'
 ;; Call by value
 ;; X contains string on which to perform the strip operation
 ;; Y contains character(s) to strip
 Q $TR($G(X),$G(Y),"")
 ;;
REPLACE(STR,X,Y) ;; Performs a character in 'Y' for character
 ;; in 'X' replace within string 'STR'.
 ;; Call by value
 ;; STR is the string on which to perform the replace operation
 ;; X is the characters to replace
 ;; Y is the translated characters
 ;; ** NOTE ** X AND Y MUST BE IN THE EXACT SAME ORDER ****
 ;; X="ABC" Y="XYZ" all occurances of A will be replaced with X
 ;; B with Y and C with Z
 ;; X="AKZ" Y="Z" every occurance of A will be replaced with Z
 ;; and K and Z will be replaced by "" (NULL)
 Q $TR($G(STR),$G(X),$G(Y))
 ;;
REPEAT(X,Y) ;;
 ;; Call by value
 ;; X is the character that you wish repeated
 ;; Y is the number of repetitions
 ;;** NOTE ** $L(X)*Y must not be greater than 254
 ;; eg. S X=$$REPEAT("-",10)  returns "----------"
 N LRPER
 I $L($G(X))*$G(Y)>254 Q ""
 S LRPER="",$P(LRPER,$G(X),+$G(Y)+1)=""
 Q LRPER
 ;;
INVERT(X) ;;
 ;; Call by value
 ;; Returns String in X in inverted order ABC => CBA
 N I,Y
 I $L($G(X))>254 Q ""
 S Y=""
 F I=$L(X):-1:0 S Y=Y_$E(X,I)
 Q Y
 ;;
GLBR(LRR) ;;
 ;; Call by value
 ;; Returns the global root with extended systax if the global
 ;;  is translated. Useful when using $Q on MSM systems
 N LRC,LRF,LRG,LRI,LRR1,LRR2,LRZ
 S LRR1=$P(LRR,"(")_"(" I $E(LRR1)="^" S LRR2=$P($Q(@(LRR1_""""")")),"(")_"(" S:$P(LRR2,"(")]"" LRR1=LRR2
 S LRR2=$P($E(LRR,1,($L(LRR)-($E(LRR,$L(LRR))=")"))),"(",2,99)
 S LRC=$L(LRR2,","),LRF=1 F LRI=1:1:LRC S LRG=$P(LRR2,",",LRF,LRI) Q:LRG=""  D
 . I ($L(LRG,"(")=$L(LRG,")")&($L(LRG,"""")#2))!(($L(LRG,"""")#2)&($E(LRG)="""")&($E(LRG,$L(LRG))="""")) S LRG=$$S(LRG),$P(LRR2,",",LRF,LRI)=LRG,LRF=LRF+$L(LRG,","),LRI=LRF-1
 Q LRR1_LRR2
S(LRZ) ;
 I $G(LRZ)']"" Q ""
 I $E(LRZ)'="""",$L(LRZ,"E")=2,+$P(LRZ,"E")=$P(LRZ,"E"),+$P(LRZ,"E",2)=$P(LRZ,"E",2) Q +LRZ
 I +LRZ=LRZ Q LRZ
 I LRZ="""""" Q ""
 I $E(LRZ)'?1A,"LR$+@"'[$E(LRZ) Q LRZ
 I "+$"[$E(LRZ) X "S LRZ="_LRZ Q $$Q(LRZ)
 I $D(@LRZ) Q $$Q(@LRZ)
 Q LRZ
Q(LRZ) ;
 S LRZ(LRZ)="",LRZ=$Q(LRZ("")) Q $E(LRZ,4,$L(LRZ)-1)
 ;;
 ;;
 Q
LRPNM(X) ;;Call by value
 ;; change value to upper case string
 ;; removes spaces after comma
 ;; removes double spaces and spaces at the end of the string
 ;; generally used to format patient names
 N Y,I
 S X=$$UPCASE(X)
 ; -- no space after comma and no double spaces
 F Y=", ","  " F  Q:'$F(X,Y)  S X=$E(X,1,($F(X,Y)-2))_$E(X,$F(X,Y),$L(X))
 ; -- no space at the end
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,$L(X)-1)
 Q X
