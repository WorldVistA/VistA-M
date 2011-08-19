ENBCPM3 ;(WASH ISC)/DH-Bar Coded PMI ;3.4.97
 ;;7.0;ENGINEERING;**21,35**;Aug 17, 1993
NOLBL ;No bar code label scanned
 N ENDA,EN,ENSN,ENMOD
 F I=0,1,2 S EN(I)=""
 S ENLBL="NO LABEL",EN(0)=$E(ENEQ,5,40),ENX1=$O(^PRCT(446.4,ENCTID,2,ENCTTI,1,ENX)) I ENX1]"" S EN(1)=$S($E(^(ENX1,0))="*":"",1:^(0)) S:$E(EN(1),1,4)="S/N:" ^(0)="*"_EN(1),ENX=ENX1,EN(1)=$E(EN(1),5,40)
 S EN(2)="NO DESCRIPTION.",ENX1=$O(^PRCT(446.4,ENCTID,2,ENCTTI,1,ENX)) S ENLKAHD=$S(ENX1]"":^(ENX1,0),1:"")
 I ENLKAHD]"",$E(ENLKAHD)'="*",$E(ENLKAHD,1,2)'="SP",$E(ENLKAHD,1,4)'="MOD:",$E(ENLKAHD,1,4)'="PM#:",ENLKAHD'[" EE" S EN(2)=ENLKAHD,ENX=ENX1,^PRCT(446.4,ENCTID,2,ENCTTI,1,ENX,0)="*"_ENLKAHD
 I EN(0)[" " D
 . F  Q:$E(EN(0))'=" "  S EN(0)=$E(EN(0),2,99)
 . F  Q:$E(EN(0),$L(EN(0)))'=" "  S EN(0)=$E(EN(0),1,($L(EN(0))-1))
 I EN(1)[" " D
 . F  Q:$E(EN(0))'=" "  S EN(0)=$E(EN(0),2,99)
 . F  Q:$E(EN(0),$L(EN(0)))'=" "  S EN(0)=$E(EN(0),1,($L(EN(0))-1))
 I EN(1)]"" D
 . S ENDA=$O(^ENG(6914,"F",EN(1),0)) I ENDA>0 S ENSN=EN(1) Q
 . S EN(1,0)=$TR(EN(1)," ~!@#$%^&*()_+|`-=\[]{};':"",./<>?",""),EN(1,0)=$$UP^XLFSTR(EN(1,0)) S ENDA=$O(^ENG(6914,"FC",(EN(1,0)_" "),0)) I ENDA>0 S ENSN=$P($G(^ENG(6914,ENDA,1)),U,3)
 I $G(ENSN)]"" D  Q
 . I EN(0)'=$P($G(^ENG(6914,ENDA,1)),U,2) S ENMSG(0,2)="NOTE: Entered MODEL ("_EN(0)_") does not match stored value."
 . S ENEQ=ENDA D MATCH,POST^ENBCPM4
 ;If match found EN will be killed
 I $D(EN) S ENMSG="ITEM NOT IN DATABASE.",ENMSG(0,1)="Model: "_EN(0),ENMSG(0,2)="Serial number: "_EN(1),ENMSG(0,3)="Description: "_EN(2) D TKNOTE,XCPTN^ENBCPM2
 Q
 ;
PMN ;Process PM #
 S ENLBL="NO LABEL",^PRCT(446.4,ENCTID,2,ENCTTI,1,ENX,0)="*"_ENEQ,ENEQ=$E(ENEQ,5,40) S:ENEQ[" " ENEQ=$TR(ENEQ," ") S ENDA=$O(^ENG(6914,"C",ENEQ,0)) I ENDA>0 S ENEQ=ENDA D MATCH,POST^ENBCPM4 Q
 S ENMSG="ITEM NOT IN DATABASE.",ENMSG(0,1)="PM #: "_ENEQ
 D TKNOTE,XCPTN^ENBCPM2
 Q
 ;
MATCH ;  Equipment unlabelled but present in 6914
 S ENMSG="BAR CODE LABEL MISSING. Equipment ID#: "_ENEQ,ENMSG(0,1)="Record will be updated, but bar code label should be printed and applied."
 D XCPTN^ENBCPM2
 D UPDATE^ENBCPM2
 K EN Q
 ;
TKNOTE ;Addtn'l info to Excptn Mess
 S ENX1=$O(^PRCT(446.4,ENCTID,2,ENCTTI,1,ENX)) S ENLKAHD=$S(ENX1]"":^(ENX1,0),1:"") G:ENLKAHD="" TKNOTE2
 I $E(ENLKAHD)'="*",$E(ENLKAHD,1,2)'="SP",$E(ENLKAHD,1,4)'="MOD:",$E(ENLKAHD,1,4)'="PM#:",ENLKAHD'[" EE" D TKNOTE1 S ENX=ENX1,^PRCT(446.4,ENCTID,2,ENCTTI,1,ENX,0)="*"_ENLKAHD G TKNOTE
 G TKNOTE2
 ;
TKNOTE1 F J=0:0 S J=$O(ENMSG(0,J)) Q:J'>0  S I=J
 S I=I+1,ENMSG(0,I)=ENLKAHD
 Q
 ;
TKNOTE2 ;Exit subrtn
 Q
 ;
HOLD I $E(IOST,1,2)="C-" W !,"Press RETURN to continue..." R X:DTIME
 Q
 ;ENBCPM3
