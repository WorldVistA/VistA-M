SPN18E ;SAN/WDE ENVIRONMENT CHECK FOR SPN*2.0*18;12/2/2002
 ;;2.0;Spinal Cord Dysfunction;**18**;01/02/97
 ;
EN ;ENTRY
 N ROU,TEST,VER,X,ZAP,P18
 S ROU="SPNCTINA"
 D CHK
 I $G(ZAP)=1 S XPDABORT=2 W !,"***SPN*2.0*18 ABORTED***",! D EXIT Q
 S ROU="DGUTL4"
 D CHK2
 I $G(ZAP)=1 S XPDABORT=2 W !,"***SPN*2.0*18 ABORTED***",! D EXIT Q
 W !,"***Environment is fine***",!
 K ROU,TEST,VER,ZAP,P18
 Q
CHK ;CHECK FOR PATCHED ROUTINE SPNCTINA
 S X="S TEST=$T(+2^"_ROU_")" X X
 S VER=$P(TEST,";",3),P18=$P(TEST,";",5)
 I VER="" W !,"This account is missing some SPN routines!" S ZAP=1 Q
 I VER'[2 W !,"This is not the current version of Spinal Cord!" S ZAP=1 Q
 I P18'[19 W !,"Routine: ",ROU," is missing patch SPN*2*19" S ZAP=1
 Q
CHK2 ;CHECK FOR PATCHED ROUTINE DGUTL4
 S X="S TEST=$T(+2^"_ROU_")" X X
 S VER=$P(TEST,";",3),P18=$P(TEST,";",5)
 I VER="" W !,"This account is missing some DG routines!" S ZAP=1 Q
 I VER'[5.3 W !,"This is not the current version of DG!" S ZAP=1 Q
 I P18'[415 W !,"Routine: ",ROU," is missing patch DG*5.3*415" S ZAP=1
 Q
EXIT ;
 K ROU,TEST,VER,ZAP,P18
 Q
