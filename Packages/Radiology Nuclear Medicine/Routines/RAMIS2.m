RAMIS2 ;HISC/CAH,FPT,GJC-Radiology AMIS Report ;9/12/94  11:07
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
CHK S RADFLAG=0 K ^TMP($J,"RA D-TYPE")
 I $P($G(^RA(79,0)),U,4)>1 D
 . D SELDIV^RAUTL7
 . I $O(^TMP($J,"RA D-TYPE",""))=""!$G(RAQUIT) D
 .. W !!?5,"No divisions selected" K RADFLAG
 .. Q
 . Q
 E  D ALLDIV
 Q
ALLDIV N C,RAD0,RADIVN,Y S RAD0=0
 F  S RAD0=$O(^RA(79,RAD0)) Q:RAD0'>0  D
 . S (RADIVN,Y)=+$P($G(^RA(79,RAD0,0)),U)
 . I $O(RACCESS(DUZ,"DIV",RADIVN,0))'>0 Q
 . S C=$P(^DD(79,.01,0),U,2) D Y^DIQ S RADIVN(0)=Y
 . S ^TMP($J,"RA D-TYPE",RADIVN(0),RADIVN)=""
 . Q
 Q
