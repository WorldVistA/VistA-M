FBBPG7Y ;SLT - PURGE BATCH FILE ENTRIES AFTER 7 YRS ;03/01/2015
 ;;3.5;FEE BASIS;**158**;JAN 30, 1995;Build 94
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ; Main Entry Point
 ;
 N PRGDT,FNLZDT,IEN,ZNODE,BCNT,B,FBTYPE,FBDUZ
 S PRGDT=$$FMADD^XLFDT(DT,-2555)
 ;S PRGDT=2940121 ;$$FMADD^XLFDT(DT,-7650) - debug
 S BCNT=0
 ;
 S FNLZDT="" K ^TMP($J,"FBBPG7Y")
 F  S FNLZDT=$O(^FBAA(161.7,"AF",FNLZDT)) Q:('FNLZDT!(FNLZDT>PRGDT))  D
 . S IEN=""
 . F  S IEN=$O(^FBAA(161.7,"AF",FNLZDT,IEN)) Q:'IEN  D
 . . S ZNODE=^FBAA(161.7,IEN,0),B=$P(ZNODE,U),FBTYPE=$P(ZNODE,U,3),FBDUZ=$P(ZNODE,U,5)
 . . ;
 . . I FBTYPE="B3" D MEDP(IEN)
 . . I FBTYPE="B2" D TRAVP(IEN)
 . . I FBTYPE="B5" D RPHP(IEN)
 . . I FBTYPE="B9" D CHP(IEN)
 . . ;
 . . S BCNT=BCNT+1
 . . S ^TMP($J,"FBBPG7Y",BCNT)=IEN_U_FNLZDT
 . . S DIK="^FBAA(161.7,",DA=IEN D ^DIK
 . ;
 ;
 D SNDBUL(PRGDT,BCNT)
 Q
 ;
MEDP(BIEN) ;outpatient
 ;
 N PIEN,K,L,M
 S PIEN=0
 F  S PIEN=$O(^FBAAC("AC",BIEN,PIEN)) Q:'PIEN  D
 . S K=0
 . F  S K=$O(^FBAAC("AC",BIEN,PIEN,K)) Q:'K  D
 . . S L=0
 . . F  S L=$O(^FBAAC("AC",BIEN,PIEN,K,L)) Q:'L  D
 . . . S M=0
 . . . F  S M=$O(^FBAAC("AC",BIEN,PIEN,K,L,M)) Q:'M  D
 . . . . I $D(^FBAAC(PIEN,1,K,1,L,1,M,0)) D
 . . . . . S ^TMP($J,"FBBPG7Y",BCNT,"MEDP",K,L,M)=PIEN
 . . . . . S $P(^(0),U,8)=""
 K ^FBAAC("AC",BIEN)
 Q
 ;
TRAVP(BIEN) ;travel
 ;
 N PIEN,K
 S PIEN=0
 F  S PIEN=$O(^FBAAC("AD",BIEN,PIEN)) Q:'PIEN  D
 . S K=0
 . F  S K=$O(^FBAAC("AD",BIEN,PIEN,K)) Q:'K  D
 . . I $D(^FBAAC(PIEN,3,K,0)) D
 . . . S ^TMP($J,"FBBPG7Y",BCNT,"TRAVP",K)=PIEN
 . . . S $P(^(0),U,2)=""
 K ^FBAAC("AD",BIEN)
 Q
 ;
RPHP(BIEN) ;Rx
 ;
 N PIEN,K
 S PIEN=0
 F  S PIEN=$O(^FBAA(162.1,"AE",BIEN,PIEN)) Q:'PIEN  D
 . S K=0
 . F  S K=$O(^FBAA(162.1,"AE",BIEN,PIEN,K)) Q:'K  D
 . . I $D(^FBAA(162.1,PIEN,"RX",K,0)) D
 . . . S ^TMP($J,"FBBPG7Y",BCNT,"RPHP",K)=PIEN
 . . . S $P(^(0),U,17)=""
 K ^FBAA(162.1,"AE",BIEN),^FBAA(162.1,"AJ",BIEN)
 Q
 ;
CHP(BIEN) ;inpatient
 ;
 N IIEN
 S IIEN=0
 F  S IIEN=$O(^FBAAI("AC",BIEN,IIEN)) Q:'IIEN  D
 . I $D(^FBAAI(IIEN,0)) D
 . . S ^TMP($J,"FBBPG7Y",BCNT,"CHP")=IIEN
 . . S $P(^FBAAI(IIEN,0),U,17)=""
 K ^FBAAI("AC",BIEN),^FBAAI("AE",BIEN)
 Q
 ;
SNDBUL(PRGDT,BCNT) ;send a bulletin to a mail group
 ;
 N XMB,FBPGDT,Y,XMY
 S XMB(1)=$S($D(^VA(200,DUZ,0)):$P(^(0),U),1:"Unknown User")
 S Y=DT D PDF^FBAAUTL S FBPGDT=Y,XMB(2)=FBPGDT
 S Y=PRGDT D PDF^FBAAUTL S XMB(3)=Y
 S XMB(4)=BCNT
 S XMB="FBAA BATCH PURGE"
 ;debug
 S XMY=DUZ
 ;
 D ^XMB
 Q
 ;
