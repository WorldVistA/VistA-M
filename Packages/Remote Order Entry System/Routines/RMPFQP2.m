RMPFQP2 ;DDC/KAW-PRINT VA FORM 10-2477a; [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;;JUN 16, 1995
RMPFSET I '$D(RMPFMENU) D MENU^RMPFUTL I '$D(RMPFMENU) W !!,$C(7),"*** A MENU SELECTION MUST BE MADE ***" Q  ;;RMPFMENU must be defined
 I '$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS) D ^RMPFUTL Q:'$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS)
 ;; input: None
 ;;output: None
 F KX=1:1:RMPFCNT D PRINT
 G END
PRINT D ^RMPFQP1
 W:$Y>0 @IOF W !?25,"DEPARTMENT OF VETERANS AFFAIRS"
 W !?21,"AUDIOLOGICAL SERVICES ACKNOWLEDGEMENT"
 D LINE
 W !,"1. Extended Audiology Clinic",?38,"|   2. Issuing Audiology Clinic"
 W !?3,"Station No. ",RMPFRSTA,?38,"|",?45,"Station No. ",RMPFSTAP
 W !?38,"|"
 F I=1:1:4 W ! W:$D(RMPFR(I)) ?3,$E(RMPFR(I),1,32) W ?38,"|" W:$D(RMPFS(I)) ?45,$E(RMPFS(I),1,36)
 D LINE
NAM W !,"3. Veteran's Name and Address ",?38,"|  4. Eligibility Status(es) "
 W !,?38,"|"
 W ! W ?38,"|  __ SC for Hearing",?61,"__ IN PAT"
 W ! W ?38,"|  __ 50-100% SC",?61,"__ NHCU"
 W ! W ?38,"|  __ POW",?61,"__ DOM"
 W ! W ?38,"|  __ WWI",?61,"__ OPT-NSC"
 W ! W ?38,"|  __ MBW",?61,"__ ADJ"
 W !?38,"|  __ A&A",?54,"__ ALLIED (Authority Req.)"
 W !?38,"|  __ HB",?54,"__ OTHER  (Specify)"
 D LINE
 D CONT G END:$D(RMPFOUT) D LINE:IOST?1"C-".E
 W !,"5. Soc. Security No.",?16,"| 6. VA Claim No.",?38,"| 7. Date of Birth",?59,"| 8. Disability Code"
 W !?20,"|",?38,"|",?59,"|"
 W !,"       -    -",?20,"|      -    -",?38,"|",?59,"| __DEAF/U  __DEAF/B"
 D LINE
AUTH W !,"9. Currently Authorized Hearing Aid(s)"
 D LINE
 W !?2,"Manfacturer",?16,"|",?22,"Model",?32,"|",?34,"Serial Number",?48,"|",?50,"Furnished By",?64,"|",?67,"Date Issued"
 D LINE
 F I=1:1:4 W !,?16,"|",?32,"|",?48,"|",?64,"|" D LINE
CLINIC W !,"10. Clinic Action Taken    __  VETERAN DOES NOT REQUIRE NEW HEARING AID"
 W !?27,"__  VETERAN DOES NOT REQUIRE HEARING AID"
 W !?27,"__  ITEM(S) LISTED BELOW WERE ISSUED TO VETERAN"
 D LINE
 D CONT G END:$D(RMPFOUT) D LINE:IOST?1"C-".E
 W !,?16,"|",?27,"|",?44,"|",?57,"| Battery",?67,"| Serial No."
 W !,"Natl. Stock No.",?16,"|",?20,"Make",?33,"Model"
 W ?44,"| Serial No.",?57,"|  Type",?67,"| Replaced"
 D LINE
 F I=1:1:2 W !,"6515-01-",?16,"|",?27,"|",?44,"|",?57,"|",?67,"|" D LINE
 D CONT G END:$D(RMPFOUT) D LINE:IOST?1"C-".E
 W !,"11. Type of Fitting",?24,"__ MONAURAL",?38,"__  BINAURAL",?56,"__  CROS",?69,"__  BICROS"
 D LINE
 W !,"12. Authorized Usage of Aids",?38,"__  MONAURAL",?56,"__  BINAURAL"
 D LINE
 W !,"13. Issued aids to be replaced to clinic stock by DDC:",?58,"__  YES",?66,"__  NO",?73,"__ N/A"
 D LINE
 W !,"14. Signature of Issuing Audiologist",?38,"|",?44,"Name and Title",?65,"|15. Order Date"
 W !?38,"|",?65,"|",!?38,"|",?65,"|"
 D LINE
 I IOST?1"P-".E,$Y>58 W @IOF
 W !,"16. I certify that I have",?37,"Signature of Veteran",?65,"|17. Date"
 W !?4,"received the item(s)",?65,"|"
 W !?4,"listed under 10 above ->",?65,"|"
 D LINE
 W !,"VA Form 10-2477a"
 W !,"SEP 1991"
 D CONT G END:$D(RMPFOUT) W:IOST?1"P-".E @IOF
 D:$D(IO("S")) ^%ZISC
END K RMPFRSTA,RMPFR,RMPFS,RMPFRSTA,RMPFS,RMPFR,%DT,I,IN,Y,RMPFOUT,RMPFQUT,RMPFCNT Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
LINE W !,"--------------------------------------------------------------------------------"
 Q
CONT Q:IOST'["C-"  F I=1:1 Q:$Y>21  W !
 W !,"Enter <RETURN> to continue:" D READ Q:$D(RMPFOUT)
 I $D(RMPFQUT) W !!,"Enter <RETURN> to continue or <^> to exit." G CONT
 W @IOF Q
