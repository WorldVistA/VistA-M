RMPRFC5 ;HINES CIOFO/HNC - Utility     ; 3/22/05
 ;;3.0;PROSTHETICS;**83**;Feb 09, 1996;Build 20
 ;
TRIMWP(ARRAY,PIECE) ;OBX segments so that only comment remains
 ; Input:
 ;   ARRAY  = the array in which the segments are contained
 ;      ex. ^TMP("RMPRIF",541083753,"OBX",3,3)=3|TX|^COMMENTS^|3|text "
 ;   PIECE  = the piece in the array where the text lives
 ; 
 ; Output:
 ;   trimmed array 
 ;     ex. ^TMP("RMPRIF",541083753,"OBX",3,3)="text"
 ;
 N I S I=0
 F  S I=$O(@(ARRAY)@(I)) Q:'I  D
 . S @(ARRAY)@(I)=$P(@(ARRAY)@(I),"|",PIECE)
 Q
 Q
EXIT ;
 Q
