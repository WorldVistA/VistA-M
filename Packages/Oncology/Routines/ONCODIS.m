ONCODIS ;Hines OIFO/GWB - OncoTrax Banner ;09/13/11
 ;;2.11;Oncology;**6,7,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,55**;Mar 07, 1995;Build 15
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
 W !?22,"OncoTraX V2.11 P55" Q
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
