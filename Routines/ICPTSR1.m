ICPTSR1 ;ALB/ABR,MRY - CPT IENS - REV CPT CODES ; 1/3/03 2:38pm
 ;;6.0;CPT/HCPCS;**3,4,8,9,12,13**;May 19, 1997
 ;
 ;  This routine points to the ien's of the REVISED CPT codes for 2003
 ;  It is used by the print option, in routine ICPTPRN to create a 
 ;  temporary global to sort by.
 ;
START ;  CREATE GLOBAL
 N ICPTN,ICPTTMP,ICPTX,I,J
 F J=2:1:3 S END=0 D
 . F I=1:1 S FILE="TEXT+"_I_"^ICPTSR"_J D  Q:END
 .. S ICPTX=$P($T(@FILE),";",3)
 .. I ICPTX["$END" S END=1 Q
 .. S ICPTN=$S(+ICPTX:+ICPTX,1:""""_$P(ICPTX,U)_"""")
 .. S ICPTTMP="^TMP(""REVCPT"",$J,"_ICPTN_","_$P(ICPTX,U,2)_")"
 .. S @ICPTTMP=""
 ;D ^ICPTSR2 ; next part of codes
 Q
 ;
