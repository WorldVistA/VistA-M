PRCRIA10 ;TPA/RAK/WASH IRMFO - Header/Footer Boxes ;8/27/96  15:37
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
FTRBOX(FOOTER,CENTER,VALUE) ;Footer box
 ;--------------------------------------------------------------------
 ;  FOOTER - Text for footer. if none then will default to 
 ;               "Press RETURN to continue, '^' to quit".
 ;  CENTER - If not zero then center text.
 ;   VALUE - Value returned to calling rouine.
 ;          "" - if iom or ioxy are not defined
 ;           0 - if an uparrow '^' is entered
 ;           1 - if return is entered
 ;
 ;         ****************** WARNING **********************
 ;         * this subroutine xecutes the variable "IOXY"   *
 ;         * to move around the screen - be sure to W @IOF *
 ;         * to clear screen and set $y to zero            *
 ;         *************************************************
 ;--------------------------------------------------------------------
 N DIR S VALUE="" Q:'$G(IOM)!($G(IOXY)']"")
 ; *** for MSM ***
 I ^%ZOSF("OS")["MSM" S X=0 X ^%ZOSF("RM")
 S FOOTER=$G(FOOTER),CENTER=+$G(CENTER)
 I FOOTER']"" S FOOTER="Press RETURN to continue, '^' to quit"
 I CENTER S FOOTER=$J(" ",(IOM-$L(FOOTER)/2))_FOOTER
 S DX=0,DY=22 X IOXY W $$REPEAT^XLFSTR("_",IOM)
 ; *** for MSM ***
 I ^%ZOSF("OS")["MSM" S X=IOM X ^%ZOSF("RM")
 K DIR S DIR(0)="EA",DIR("A")=FOOTER D ^DIR S VALUE=Y
 Q
HDRBOX(HEADER,TEXT) ;Header box
 ;--------------------------------------------------------------------
 ;  HEADER() - Text array to be centered and highlighted at top of box.
 ;    TEXT() - Additional text array to be left justified.
 ;
 ;         ****************** WARNING **********************
 ;         * this subroutine xecutes the variable "IOXY"   *
 ;         * to move around the screen - be sure to W @IOF *
 ;         * to clear screen and set $y to zero            *
 ;         *************************************************
 ;--------------------------------------------------------------------
 Q:'$D(HEADER)&('$D(TEXT))
 I $G(HEADER)]"",($D(HEADER)=1) S HEADER(1)=HEADER
 I $D(TEXT)=1 S TEXT(1)=TEXT
 N IOBLC,IOBRC,IOBT,IOG1,IOG0,IOHL,IOLT,IOMT,IORT,IOTLC,IOTRC
 N IOTT,IOVL,IORVON,IORVOFF,I,LEN,X
 S X="IORVON;IORVOFF" D ENDR^%ZISS,GSET^%ZISS
 ; *** for MSM ***
 I ^%ZOSF("OS")["MSM" S X=0 X ^%ZOSF("RM")
 S:$G(IOHL)']"" IOHL="-"
 S:$G(IOVL)']"" IOVL="|"
 F I="IOBLC","IOBRC","IOG0","IOG1","IOTLC","IOTRC" S @I=$G(@$G(I))
 W @IOF,IOG1,IOTLC F I=1:1:(IOM-2) W IOHL
 W IOTRC S DY=$Y,I=""
 F  S I=$O(HEADER(I)) Q:I=""  S LEN=$L(HEADER(I)) D 
 .S DX=0,DY=DY+1 X IOXY W IOVL S DX=(IOM-LEN\2) X IOXY
 .W IOG0,IORVON,HEADER(I),IORVOFF,IOG1 S DX=IOM X IOXY W IOVL
 S I="" F  S I=$O(TEXT(I)) Q:I=""  S LEN=$L(TEXT(I)) D 
 .S DX=0,DY=DY+1 X IOXY W IOVL,IOG0,TEXT(I),IOG1
 .S DX=IOM X IOXY W IOVL
 S DX=0,DY=DY+1 X IOXY W IOBLC F I=1:1:(IOM-2) W IOHL
 S DX=IOM X IOXY W IOBRC
 W IOG0
 ; *** for MSM ***
 I ^%ZOSF("OS")["MSM" S X=IOM X ^%ZOSF("RM")
 Q
