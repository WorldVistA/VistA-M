ENPRP2 ;(WIRMFO)/DLM/DH/SAB-Project Tracking Report ;3/31/95
 ;;7.0;ENGINEERING;**28**;Aug 17, 1993
EN ;
 N ENFYA,ENMS,ENMSE,ENMSOK,ENQTR,ENX
 W !!,"PROJECT",?22,"PERCENT",?35,"PLANNED",?48,"REVISED/",?61,"PREVIOUSLY"
 W !,"MILESTONE",?22,"COMPLETE",?33,"QTR",?39,"DATE",?48,"ACTUAL DATE",?61,"REPORTED"
 S ENMSOK=$$MSL^ENPRUTL(ENDA)
 D MSD^ENPRUTL(ENDA,1)
 F ENI=1:1:22 D
 . S ENMSE("P")=$$EXTD(ENMS("P",ENI),0)
 . S ENMSE("P0")=$$EXTD(ENMS("P0",ENI),0)
 . S ENMSE("R")=$$EXTD(ENMS("R",ENI),1)
 . S ENMSE("R0")=$$EXTD(ENMS("R0",ENI),1)
 . S ENMSE("A")=$$EXTD(ENMS("A",ENI),1)
 . S ENMSE("A0")=$$EXTD(ENMS("A0",ENI),1)
 . S ENQTR=$$QTR(ENMS("P",ENI))
 . W !,$$MS^ENPRUTL(ENI)
 . I '$P(ENMSOK,U,ENI) W ?33,"NA",?39,"NA",?48,"NA" Q
 . I "^2^8^10^12^21^"[(U_ENI_U) D
 . . W ?22 D W^ENPRP1($J(ENMS("%",ENI),3),$J(ENMS("%0",ENI),3),"HP")
 . W ?33,ENQTR,?39
 . D W^ENPRP1(ENMSE("P"),ENMSE("P0"),$S(ENMSE("P0")]"":"HA",1:""))
 . W ?48
 . S ENX="",ENX(0)=""
 . I ENMSE("A")]"" D
 . . S ENX=ENMSE("A")_"A"
 . . S ENX(0)=ENMSE("A0")_$S(ENMSE("A0")]"":"A",1:"")
 . I ENMSE("A")']"" S ENX=ENMSE("R"),ENX(0)=ENMSE("R0")
 . D W^ENPRP1(ENX,ENX(0),"HA")
 . I ENX'=ENX(0),ENX(0)]"" W ?61,"("_ENX(0)_")"
 . ;I "^6^11^19^"[(U_ENI_U) D
 . ;. Q:ENMSE("A")]""
 . ;. S ENX=$S(ENI=6:3.45,ENI=11:3.45,ENI=19:3.5,1:"")
 . ;. S ENFYA=$$GET1^DIQ(6925,ENDA,ENX)
 . ;. S ENX=$S(ENMS("R",ENI)]"":ENMS("R",ENI),1:ENMS("P",ENI))
 . ;. S ENX=$E(ENX,1,3)+$E(ENX,4)+1700 ; convert to 4 digit fiscal year
 . ;. I ENX'=ENFYA W ?74,"SLIP"
 Q
EXTD(ENDT,ENOPT) ; external date
 ; ENDT - FileMan Date
 ; ENOPT - 0 for MM-YY or 1 for MM-DD-YY
 Q:ENDT="" ""
 N ENX
 S ENX=$E(ENDT,4,5)_"-"_$S(ENOPT:$E(ENDT,6,7)_"-",1:"")_$E(ENDT,2,3)
 Q ENX
QTR(ENDT) ;extract quarter from ENDT FileMan date
 Q:ENDT="" ""
 N QTR,YEAR
 S QTR=+$E(ENDT,4,5),QTR=$P("2^2^2^3^3^3^4^4^4^1^1^1",U,QTR)
 S YEAR=$E(ENDT,1,3)+$S(QTR=1:1,1:0),YEAR=$E(YEAR,2,3)
 Q YEAR_"."_QTR
 ;ENPRP2
