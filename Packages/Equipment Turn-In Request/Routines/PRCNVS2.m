PRCNVS2 ;SSI/ALA-Patch 2 Post Init ;[ 02/12/97  11:48 AM ]
 ;;1.0;Equipment/Turn-In Request;**2**;Sep 13, 1996
 ;  Fix "P" cross-reference
 K ^PRCN(413,"P")
 S DIK="^PRCN(413,",DIK(1)="34^P"
 D ENALL^DIK
 K DIK,II,LPRI,OLDPRI,PRCNX,PRIMAX,SERV,DA,DIC
 Q
