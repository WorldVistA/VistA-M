SPN15E ;SAN/WDE ENVIRONMENT CHECK FOR SPN*2.0*16;10/17/2001
 ;;2.0;Spinal Cord Dysfunction;**16**;01/02/97
 ;
EN ;ENTRY
 N ROU,TEST,VER,X,ZAP,P15
 S ROU="SPNDIV"
 D CHK
 I $G(ZAP)=1 S XPDABORT=2 W !,"***SPN*2.0*16 ABORTED***",! D EXIT Q
 W !,"***Environment is fine***",!
 D EXIT
 Q
CHK ;CHECK FOR PATCH SPN*2*15
 S X="S TEST=$T(+2^"_ROU_")" X X
 S VER=$P(TEST,";",3),P15=$P(TEST,";",5)
 I VER="" W !,"This account is missing some SPN routines!" S ZAP=1 Q
 I VER'[2 W !,"This is not the current version of Spinal Cord!" S ZAP=1 Q
 I P15'[15 W !,"Routine: ",ROU," is missing patch SPN*2*15" S ZAP=1
 Q
EXIT ;
 K ROU,TEST,VER,ZAP,P15
 Q
