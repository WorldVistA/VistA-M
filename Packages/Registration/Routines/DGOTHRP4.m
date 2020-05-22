DGOTHRP4 ;SLC/RM - OTH PATIENT PERIOD STATUS REPORT CONT. ;July 20, 2018@5:15
 ;;5.3;Registration;**952**;Aug 13, 1993;Build 160
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;     Last Edited: SHRPE/RM - July 20, 2018 5:15
 ;
 ; ICR# TYPE      DESCRIPTION
 ;----- ----      ---------------------
 ;10024 Sup       WAIT^DICD
 ;10063 Sup       $$S^%ZTLOAD
 ;10086 Sup       HOME^%ZIS
 ;10089 Sup       ^%ZISC
 ;10103 Sup       ^XLFDT: $$FMTE, $$NOW
 ;10112 Sup       $$SITE^VASITE
 ;10015 Sup       GETS^DIQ
 ;10026 Sup       ^DIR
 ;
 ;- no direct entry
 Q
 ;
CONT(DGSORT) ;Statistical Report continuation
 N DGMON,DGQRTR,DGNWTOT,DGCRYTOT,DGINTOT,DGFYAR,DGCARY,DGLN
 ;quarterly report summary
 I 4[$P(DGSORT("DGMON"),U) D
 . D QRPTHD
 . S DGMON="" F  S DGMON=$O(DGSORT("DGMON",DGMON)) Q:DGMON=""  D
 . . D QRPTSUM
 . D QRPTSUM1
 ;fiscal year report summary
 I 5[$P(DGSORT("DGMON"),U) D
 . N I,DGLN
 . D QRPTHD
 . S (DGQRTR,DGMON)=""
 . W !
 . S DGQRTR="" F  S DGQRTR=$O(DGSORT("DGMON",DGQRTR)) Q:DGQRTR=""  D
 . . W !,"FY QUARTER ",DGQRTR,":"
 . . S (DGNWTOT,DGCRYTOT,DGINTOT)=0
 . . S DGMON="" F  S DGMON=$O(DGSORT("DGMON",DGQRTR,DGMON)) Q:DGMON=""  D
 . . . D QRPTSUM
 . . D QRPTSUM1
 . . W !
 . I $D(DGFYAR) D
 . . W !!,"FISCAL YEAR OVER ALL SUMMARY:",!
 . . F I=1:1:4 D
 . . . W !,"FY QUARTER ",I
 . . . W ?20,$J($P(DGFYAR(I),U),4),?30,$J($P(DGFYAR(I),U,2),6)
 . . . W ?44,$J($P(DGFYAR(I),U,3),5),?69,$J($P(DGFYAR(I),U,4),6)
 . . S $P(DGLN,"=",81)=""
 . . W !,DGLN,"TOTAL INACTIVATED FOR THE YEAR:",?69,$J(DGCNT("IN"),6)
 . . ;W !!,"TOTAL NUMBER OF UNIQUE PATIENTS TREATED FOR ",DGDTRNGE,":  ",$J($G(DGNET),3)
 Q
 ;
QRPTHD ;quarterly/fiscal report subheader
 N DGLN
 D HEAD^DGOTHRP3
 W:5[$P(DGSORT("DGMON"),U) !,"TOTAL NUMBER OF UNIQUE PATIENTS TREATED FOR ",DGDTRNGE,":  ",$J($G(DGNET),3)
 W !!,"REPORT SUMMARY:" ;FOR ",DGDTRNGE,":"
 W !!,"Month",?20,"New",?30,"Carry Over",?44,"TOTAL",?69,"INACTIVATED"
 S $P(DGLN,"=",10)="" W !,DGLN,?20,"====",?30,DGLN,?44,"====="
 S $P(DGLN,"=",12)="" W ?69,DGLN
 Q
 ;
QRPTSUM ;quarterly report summary
 N DGNEW,DGCARY
 S DGNEW=$S($G(DGCNT("NEW",DGMON))>0:DGCNT("NEW",DGMON),1:0)
 S DGCARY=$S($G(DGCNT("OLD",DGMON))>0:DGCNT("OLD",DGMON),1:0)
 S DGNWTOT=$G(DGNWTOT)+$G(DGCNT("NEW",DGMON))
 S DGCRYTOT=$G(DGCRYTOT)+$G(DGCNT("OLD",DGMON))
 S DGINTOT=$G(DGINTOT)+$G(DGCNT("IN",DGMON))
 W !
 I 4[$P(DGSORT("DGMON"),U) W $P(DGSORT("DGMON",DGMON),U)
 I 5[$P(DGSORT("DGMON"),U) W "  ",$P(DGSORT("DGMON",DGQRTR,DGMON),U)
 W ?20,$J(DGNEW,4),?30,$J(DGCARY,6),?44,$J(DGNEW+DGCARY,5),?69,$S($G(DGCNT("IN",DGMON))>0:$J(DGCNT("IN",DGMON),6),1:$J(0,6))
 Q
 ;
QRPTSUM1 ;display grand total for quarterly/fiscal quarterly report summary
 N DGLN
 S $P(DGLN,"=",81)=""
 W !,DGLN
 W !,"TOTAL",?20,$J(DGNWTOT,4),?30,$J(DGCRYTOT,6)
 W ?44,$S(4[$P(DGSORT("DGMON"),U):$J(DGCNT,5),1:$J($G(DGNWTOT)+$G(DGCRYTOT),5))
 W ?69,$J(DGINTOT,6)
 I 5[$P(DGSORT("DGMON"),U) D
 . S DGFYAR(DGQRTR)=DGNWTOT_U_DGCRYTOT_U_($G(DGNWTOT)+$G(DGCRYTOT))_U_DGINTOT
 . S DGCNT("IN")=$G(DGCNT("IN"))+DGINTOT
 Q
 ;
PRINTFY(DGSORT,DGLIST,DGQRTR,DGMON,DGQ,DGMNAME) ;print/display carryover OTH patients
 N DGSTAT,DGPTNM,DGCLCK,DGSTR,DGOLD
 S DGSTAT="OLD",(DGOLD,DGPTNM,DGCLCK,DGSTR)=""
 D HEAD^DGOTHRP3
 W ! D SUBHEAD^DGOTHRP3(DGSTAT,DGMNAME)
 F  S DGPTNM=$O(@DGLIST@(DGSTAT,DGQRTR,DGMON,DGPTNM)) Q:DGPTNM=""  D  Q:DGQ
 . F  S DGCLCK=$O(@DGLIST@(DGSTAT,DGQRTR,DGMON,DGPTNM,DGCLCK)) Q:DGCLCK=""  D  Q:DGQ
 . . S DGSTR=@DGLIST@(DGSTAT,DGQRTR,DGMON,DGPTNM,DGCLCK)
 . . W !
 . . I $Y>(IOSL-4) D PAUSE^DGOTHRP2(.DGQ) Q:DGQ  D HEAD^DGOTHRP3 W !
 . . I DGPTNM'=DGOLD D
 . . . W $E(DGPTNM,1,20),?23,$P(DGSTR,U,3)
 . . . S DGOLD=DGPTNM ;display the name and PID only once
 . . W ?31,$P(DGSTR,U,2),?37,$$FMTE^XLFDT($P(DGSTR,U,4),"5Z"),?49,$$FMTE^XLFDT($P(DGSTR,U,5),"5Z")
 . . ;display N/A in replacement for days remaining if 90-Day has been inactivated
 . . W ?61,$S($P(DGSTR,U,8)'="":$J("N/A",4),1:$J($P(DGSTR,U,6),4))
 . W ?68,$$FMTE^XLFDT($P(DGSTR,U,8),"5Z")
 . D CALCIN^DGOTHRP3(DGSTR,DGSTAT,DGMON)  ;count inactivated OTH patients
 . Q:DGQ
 W !!
 Q
 ;
