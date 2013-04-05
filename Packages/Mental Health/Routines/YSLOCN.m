YSLOCN ;SLC/TGA,SLC/DKG,HIOFO/FT,HIOFO/hrubovcak-SITE NUMBER AND NAME ;9/20/11 14:27
 ;;5.01;MENTAL HEALTH;**70,60**;Dec 30, 1994;Build 47
 ;
 ;Reference to XPDUTL APIs supported by DBIA #10141
 ;Reference to FILE 4 fields supported by DBIA #10090
 ;
 ; Called as ENTRY action from MENU option YSUSER
 ;
 S X="** Mental Health version "_$$VERSION^XPDUTL("YS")_" **"
 W @IOF,!!,$J(" ",IOM-$L(X)\2)_X,!
 ;
SITE ;
 D:'$D(DUZ(2)) EMSG1 Q:'$D(DUZ(2))  D:DUZ(2)'>0 EMSG1 Q:DUZ(2)'>0
 S YSLC=$$GET1^DIQ(4,DUZ(2),"99","I","","YSERR")
 S YSLCN="VAMC "_$$GET1^DIQ(4,DUZ(2),".01","I","","YSERR")
 K X,Y
 D ENDTM^YSUTL
 Q
EMSG1 ;
 S XQUIT=1 W !!,"The DIVISION field in the NEW PERSON file for YOUR user name must be set."
 W !,"To continue, please see your SITE manager."_$C(7),! H 3 Q
 ;
 ; 13 October 2011
