PXRRUTIL ;ISL/PKR - Utility routines for use by PXRR. ;3/20/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**12**;Aug 12, 1996
 ;
 ;=======================================================================
SORT(N,ARRAY,KEY) ;Sort an ARRAY with N elements into ascending order,
 ;return the number of unique elements.  KEY is the piece of ARRAY on
 ;which to base the sort.  The default is the first piece.
 ;
 I (N'>0)!(N=1) Q N
 N IC,IND
 I '$D(KEY) S KEY=1
 F IC=1:1:N S ^TMP($J,"SORT",$P(@ARRAY@(IC),U,KEY))=@ARRAY@(IC)
 S IND=""
 F IC=1:1 S IND=$O(^TMP($J,"SORT",IND)) Q:IND=""  D
 . S @ARRAY@(IC)=^TMP($J,"SORT",IND)
 K ^TMP($J,"SORT")
 Q IC-1
 ;
 ;=======================================================================
STRREP(STRING,TS,RS) ;Replace every occurence of the target string (TS)
 ;in STRING with the replacement string (RS).
 ;Example 9.19 (page 220) in "The Complete Mumps" by John Lewkowicz:
 ;  F  Q:STRING'[TS  S STRING=$P(STRING,TS)_RS_$P(STRING,TS,2,999)
 ;fails if any portion of the target string is contained in the with
 ;string.  Therefore a more elaborate version is required.
 ;
 N FROM,NPCS,STR
 ;
 I STRING'[TS Q STRING
 ;Count the number of pieces using the target string as the delimiter.
 S FROM=1
 F NPCS=1:1 S FROM=$F(STRING,TS,FROM) Q:FROM=0
 ;Extract the pieces and concatenate RS
 S STR=""
 F FROM=1:1:NPCS-1 S STR=STR_$P(STRING,TS,FROM)_RS
 S STR=STR_$P(STRING,TS,NPCS)
 Q STR
 ;
