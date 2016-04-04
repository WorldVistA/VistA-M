DDBRS ;SFISC/DCL-SET UP SPLIT SCREEN ;NOV 04, 1996@13:55
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
TB(IOTM,IOBM,TA) ;Set Top and Bottom Margins in Target Array
 ;pass IOTM, IOBM and TA all by reference **
 N I,X
 I (((IOBM-IOTM)+1)#2) S IOBM=IOBM-1
 S TA(0,"IOTM")=IOTM
 S TA(0,"IOBM")=IOBM
ETA S X=((IOBM+1)-(IOTM-1)\2)-2
 S TA(1,"IOTM")=IOTM
 S TA(1,"IOBM")=IOTM+X
 S TA(2,"IOBM")=IOBM
 S TA(2,"IOTM")=IOBM-X
ETB D
 .N IOTM,IOBM
 .F I=+$G(I):1:2 S IOTM=TA(I,"IOTM"),IOBM=TA(I,"IOBM") D
 ..S TA(I,"DDBSY")=(IOTM-2)_";"_(IOTM-1)_";"_(IOBM-1)_";"_(IOBM)
 ..S TA(I,"DDBSRL")=(IOBM-IOTM)+1
 ..Q
 .Q
 Q
 ;
ENTB(TA,DDBLD) ;called to reset DDBSY and DDBSRL for resizing split screen
 ;TA PASSED BY REFERENCE
 N I
 S I=1
 D ETB
 F I=1,2 S TA(I,"DDBTPG")=TA(I,"DDBTL")\TA(I,"DDBSRL")+(TA(I,"DDBTL")#TA(I,"DDBSRL")'<1)
 F I="DDBTPG","DDBSY","DDBSRL" S @I=TA(TA,I)
 I DDBLD<0 S TA(1,"DDBL")=TA(1,"DDBL")-$S(TA(1,"DDBL")>0:1,1:0) Q
 S TA(1,"DDBL")=TA(1,"DDBL")+$S(TA(1,"DDBL")<TA(1,"DDBTL"):1,1:0) Q
 Q
 ;
INIT(SUB,TA) ;Finish saving variables for TA pass TA by reference **
 N I G:$G(SUB)]"" SUB
 F SUB=1,2 D SUB
 Q
SUB F I="DDBSRL","DDBHDR","DDBHDRC","DDBTL","DDBSA","DDBSF","DDBST","DDBZN","DDBDM","DDBC","DDBPSA","DDBRPE","DDBPMSG","DDBTPG" S TA(SUB,I)=@I
 S TA(SUB,"DDBL")=+$G(DDBL)
 Q
 ;
SR(X,Y,ARRAY) ;Save, Restore, Array - Pass Array by reference **
 D INIT(X,.ARRAY)
 S X=""
 F  S X=$O(ARRAY(Y,X)) Q:X=""  S @X=ARRAY(Y,X)
 S ARRAY=Y  ;* * active array * *
 Q
 ;
FULL(TA) ;Full Screen
 ;TA passed by reference
 I TA=1 S DDBL=DDBL+(DDBSRL+2)
 N I,X
 F I="IOBM","IOTM","DDBSY","DDBSRL" S @I=TA(0,I)
 S DDBTPG=DDBTL\DDBSRL+(DDBTL#DDBSRL'<1)
 S I=1 D ETA
 W @IOSTBM
 S TA=0  ;* * active array * *
 S DDBL=$G(DDBL,0) S:DDBL<0 DDBL=0 S:DDBL>DDBTL DDBL=DDBTL
 D PSR^DDBR0(1)
 Q
 ;
SPLIT ;Split Screen
 N I
 F I="IOBM","IOTM","DDBSY","DDBSRL" S @I=DDBRSA(2,I)
 S DDBTPG=DDBTL\DDBSRL+(DDBTL#DDBSRL'<1)
 S I=1
 D INIT("",.DDBRSA)
 W @IOSTBM
 S DDBL=$G(DDBL,0) S:DDBL<0 DDBL=0 S:DDBL>DDBTL DDBL=DDBTL
 D PSR^DDBR0(1)
 D SR(2,1,.DDBRSA)
 W @IOSTBM
 S DDBL=DDBL-(DDBSRL+2),DDBRSA(1,"DDBL")=DDBL
 S DDBL=$G(DDBL,0) S:DDBL<0 DDBL=0 S:DDBL>DDBTL DDBL=DDBTL
 D PSR^DDBR0(1)
 Q
 ;
 ;;NOTE: DDBRSA=0 - full screen
 ;;      DDBRSA=1 - top of split screen
 ;;      DDBRSA=2 - bottom of split screen
