SPN19E ;SAN/WDE ENVIRONMENT CHECK FOR SPN*2.0*19;1/16/2003
 ;;2.0;Spinal Cord Dysfunction;**19**;01/02/97
 ;
EN ;ENTRY
 N ROU,TEST,VER,X,ZAP,P19
 S ROU="SPNLEDT2"
 D CHK
 I $G(ZAP)=1 S XPDABORT=2 W !,"***SPN*2.0*19 ABORTED***",! D EXIT Q
 I $G(ZAP)=1 S XPDABORT=2 W !,"***SPN*2.0*19 ABORTED***",! D EXIT Q
 W !,"***Environment is fine***",!
 K ROU,TEST,VER,ZAP,P19
 Q
CHK ;CHECK FOR PATCH SPN*2*16
 S X="S TEST=$T(+2^"_ROU_")" X X
 S VER=$P(TEST,";",3),P19=$P(TEST,";",5)
 I VER="" W !,"This account is missing some SPN routines!" S ZAP=1 Q
 I VER'[2 W !,"This is not the current version of Spinal Cord!" S ZAP=1 Q
 I P19'[16 W !,"Routine: ",ROU," is missing patch SPN*2*16" S ZAP=1
 Q
EXIT ;
 K ROU,TEST,VER,ZAP,P19
 Q
