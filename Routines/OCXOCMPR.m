OCXOCMPR ;SLC/RJS,CLA - ORDER CHECK CODE COMPILER (Function Library Report and code edit) ;10/29/98  12:37
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
EN ;
 ;
 N CODE,D0,D1,IOP,LINLAB,NODE0
 ;
 D ^%ZIS Q:POP
 ;
 U IO S D0=0 F  S D0=$O(^OCXS(860.8,D0)) Q:'D0  D
 .S NODE0=$G(^OCXS(860.8,D0,0)) Q:'$L(NODE0)
 .S LINLAB=$P(NODE0,U,2) Q:'$L(LINLAB)
 .W !!,$P(NODE0,U,1)
 .S LINLAB=LINLAB_"(",D1=0 F  S D1=$O(^OCXS(860.8,D0,"CODE",D1)) Q:'D1  I (^(D1,0)[LINLAB) S CODE=$P($P(^(0),";",2)," ",1) Q
 .W !,?5,CODE
 ;
 U IO W $C(12) D ^%ZISC
 ;
 Q
 ;
DT(X,%DT) N Y D ^%DT Q +Y
 ;
REPORT ;
 ;
 N FNAM S FNAM="" F  S FNAM=$O(^OCXS(860.8,"C",FNAM)) Q:'$L(FNAM)  D
 .N D0
 .S D0=0 F  S D0=$O(^OCXS(860.8,"C",FNAM,D0)) Q:'D0  D
 ..N D1,OCXCALL,OCXHDR,OCXLAB,OCXREC M OCXREC=^OCXS(860.8,D0)
 ..S OCXLAB=$P(OCXREC(0),U,2),OCXHDR=""
 ..S D1=0 F  S D1=$O(OCXREC("CODE",D1)) Q:'D1  D
 ...N OCXPC,OCXLINE S OCXLINE=OCXREC("CODE",D1,0)
 ...I (OCXLINE[(";"_OCXLAB_"(")) S OCXHDR=$P($P(OCXLINE,";",2),")",1)_")"
 ...I (OCXLINE["$$") F OCXPC=2:1:$L(OCXLINE,"$$") D
 ....N OCXFUNC,OCXPIEC
 ....S OCXPIEC=$P($P(OCXLINE,"$$",OCXPC),")",1)_")",OCXFUNC=$P(OCXPIEC,"(",1)
 ....S OCXCALL((OCXFUNC[U)+1,OCXFUNC)=OCXPIEC
 ..;
 ..W !!,OCXHDR," ;",D0,"; ",$P(OCXREC(0),U,1)
 ..S D1=0 F  S D1=$O(OCXCALL(D1)) Q:'D1  D
 ...N D2 S D2="" F  S D2=$O(OCXCALL(D1,D2)) Q:'$L(D2)  D
 ....N OCXFUNC S OCXFUNC=OCXCALL(D1,D2)
 ....I '(D2[U) W !,?8,"Internal Call --> ",D2
 ....E  W !,?5,"External Call --> ",OCXFUNC
 Q
 ;
SCAN ;
 ;
 N OCXVAL,GLREF,COUNT,ANS
 W !!,"Enter value to scan for: " R OCXVAL:DTIME E  Q
 S GLREF="^OCX" F COUNT=1:1  S GLREF=$Q(@GLREF) Q:'$L(GLREF)  D
 .W:($X>70) ! W:'(COUNT#20) "."
 .I (@GLREF[OCXVAL) W !!,GLREF," = ",@GLREF,"    press <CR> to continue... " R ANS:DTIME W !
 Q
 ;
ERROR ;
 Q
 ;
