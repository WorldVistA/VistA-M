YSLOCN ;SLC/TGA,SLC/DKG-SITE NUMBER AND NAME ;2/21/91  18:14 ;
 ;;5.01;MENTAL HEALTH;**70**;Dec 30, 1994
 ;
 ; Called as ENTRY action from MENU option YSUSER
 ;
 W @IOF,#,!!!?16,"** THIS IS VERSION ",$P(^YSA(602,1,0),U,2)," OF MENTAL HEALTH **",!!
SITE ;
 D:'$D(DUZ(2)) EMSG1 Q:'$D(DUZ(2))  D:DUZ(2)'>0 EMSG1 Q:DUZ(2)'>0  S YSLC=$P(^DIC(4,DUZ(2),99),U),YSLCN="VAMC "_$P(^DIC(4,DUZ(2),0),U) K X,Y
 D ENDTM^YSUTL
 Q
EMSG1 ;
 S XQUIT=1 W !!?9,"The DIVISION field in the NEW PERSON file for YOUR user name must be set"
 W !?5,"to continue, please see your SITE manager.",!,$C(7) H 3 Q
