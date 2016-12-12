ONCODIS ;Hines OIFO/GWB - OncoTrax Banner ;09/13/11
 ;;2.2;ONCOLOGY;**1,4,7,5**;Jul 31, 2013;Build 6
 ;
MAIN ;OncoTrax Banner
 S RC=$$CHKVER^ONCSAPIV()
 D LOGO
 K I,RC
 Q
 ;
LOGO ;Display banner
 W @IOF W !!!!!! F I=1:1:9 W !,?22,$P($T(DISP+I),";",3)
 W !!,?22,"Department of Veterans Affairs"
 W !?22,"OncoTraX V2.2 P5" Q
DISP ;
 ;;VVVV            VVAA
 ;; VVVV          VVAAAA
 ;;  VVVV        VVAAAAAA
 ;;   VVVV      VVAA  AAAA
 ;;    VVVV    VVAA    AAAA
 ;;     VVVV  VVAA      AAAA
 ;;      VVVVVVAA        AAAA
 ;;       VVVVAA   AAAAAAAAAAA
 ;;        VVAA     AAAAAAAAAAA
