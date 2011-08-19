XPARTPV ;SLC/KCM - Transport package level values
 ;;7.3;TOOLKIT;**26**;Apr 25, 1995
 ;
EN ; create transport routines
 W !,"Transport Package Level Parameter Values",!
 N I,PKG,NMSP,ROUNAME,MAXSIZE,NMSP,TODAY,PKGNAME K ^TMP($J)
 S TODAY=$$FMTE^XLFDT($$NOW^XLFDT)
 D PKG^XPARTPV1(.PKG,.PKGNAME,.NMSP) Q:'PKG        ; package & namespace
 D ROU^XPARTPV1(.ROUNAME) Q:ROUNAME=""             ; routine name
 D MAX^XPARTPV1(.MAXSIZE) Q:MAXSIZE=0              ; maximum size
 W !,"Gathering data..."
 D VALTOTMP^XPARTPV1(PKG,NMSP)                     ; put values in ^TMP
 I $O(^TMP($J,"XPARSAVE",0))="" W !,"No data found." Q
 ;
 ; create main transport routine
 W !,"Creating ",ROUNAME
 S I=0 F  S X=$T(XX0+I) Q:$P(X," ")="XMAIN"  D
 . I $P(X," ")="XX0" S X=ROUNAME_" ; Export Package Level Parameters ; "_TODAY
 . I $P(X," ")="XX1" S X=" D ^"_ROUNAME_$$MAKEID^XPARTPV1(1)
 . I $P(X," ")="XX2" S $P(X,"_",2)=""""_PKGNAME_""""
 . S I=I+1,^TMP($J,"ROU",ROUNAME,I,0)=X
 ;
 ; create data loading routines
 N CURSIZE,ROOT,ROOTEND,ROUCNT,NROUNAM,REF,VAL,X
 S ROUCNT=0,ROOT=$NAME(^TMP($J,"XPARSAVE")),ROOTEND=$L(ROOT)
 D NEWROU S I=8                                ; label DATA is at line 8
 S X=ROOT F  S X=$Q(@X) Q:$E(X,1,ROOTEND-1)_")"'=ROOT  D
 . I (CURSIZE+512)>MAXSIZE D NEWROU S I=8
 . S REF=" ;;"_$E(X,ROOTEND+1,255),VAL=" ;;"_@X
 . S I=I+1,^TMP($J,"ROU",NROUNAM,I,0)=REF
 . S I=I+1,^TMP($J,"ROU",NROUNAM,I,0)=VAL
 . S CURSIZE=CURSIZE+$L(REF)+$L(VAL)
 S ^TMP($J,"ROU",NROUNAM,7,0)=" Q"             ; last rtn:  QUIT, not GO
 ;
 ; save routines stored in ^TMP
 D SAVEROU^XPARTPV1
 K ^TMP($J)
 Q
NEWROU ; new data loading routine, changes ROUCNT,NROUNAM,CURSIZ
 N I,X
 S ROUCNT=ROUCNT+1,NROUNAM=ROUNAME_$$MAKEID^XPARTPV1(ROUCNT),CURSIZE=0
 W !,"Creating ",NROUNAM
 S I=0 F  S X=$T(XX3+I) Q:$P(X," ")="XLOAD"  D
 . I $P(X," ")="XX3" S X=NROUNAM_" ; ; "_TODAY
 . I $P(X," ")="XX4" S X=" G ^"_ROUNAME_$$MAKEID^XPARTPV1(ROUCNT+1)
 . S I=I+1,^TMP($J,"ROU",NROUNAM,I,0)=X,CURSIZE=CURSIZE+$L(X)
 Q
 ;
STUB Q
 ;
XX0 ; Export Package Level Parameters
 ;;
MAIN ; main (initial) parameter transport routine
 K ^TMP($J,"XPARRSTR")
 N ENT,IDX,ROOT,REF,VAL,I
 S ROOT=$NAME(^TMP($J,"XPARRSTR")),ROOT=$E(ROOT,1,$L(ROOT)-1)_","
XX1 D STUB                          ; chains routines that load ^TMP
XX2 S IDX=0,ENT="PKG."_STUB
 F  S IDX=$O(^TMP($J,"XPARRSTR",IDX)) Q:'IDX  D
 . N PAR,INST,VAL,ERR
 . S PAR=$P(^TMP($J,"XPARRSTR",IDX,"KEY"),U),INST=$P(^("KEY"),U,2)
 . M VAL=^TMP($J,"XPARRSTR",IDX,"VAL")
 . D EN^XPAR(ENT,PAR,INST,.VAL,.ERR)
 K ^TMP($J,"XPARRSTR")
 Q
XMAIN ;; end of MAIN
 ;
XX3 ; Export Package Level Parameters
 ;;
LOAD ; load data into ^TMP (expects ROOT to be defined)
 S I=1 F  S REF=$T(DATA+I) Q:REF=""  S VAL=$T(DATA+I+1) D
 . S I=I+2,REF=$P(REF,";",3,999),VAL=$P(VAL,";",3,999)
 . S @(ROOT_REF)=VAL
XX4 G STUB
DATA ; parameter data
XLOAD ;; end of LOAD
