FBNHRCS4 ;ACAMPUS/dmk-RCS CON'T create code sheet ;1/14/98
 ;;3.5;FEE BASIS;**12**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;create code sheets in the generic code sheet package after
 ;asking user.         FBGECS=1 if code sheets to be created.
 ;
 Q:'$G(FBGECS)
 I $E(IOST,1,2)'="C-" W @IOF
 ;
 S I=0
 F  S I=$O(^TMP($J,"FBTOT",I)) Q:'I!$G(FBOUT)  D  Q:$G(FBOUT)
 .   ; set the following GCS variables
 .   ; GECSSYS="FEE BASIS - GECO" (from file 2101.1)
 .   ; GECS("SITENOASK")=3 byte station number from 161.4 default psa
 .   ; GECSAUTO=BATCH  that way code sheet are maked for batching
 .   ; GECS("TTF")=transaction type  from file 2101.2
 .S GECSSYS="FEE BASIS - GECO",GECSAUTO="BATCH"
 .S GECS("SITENOASK")=FBSN,GECS("TTF")="18-3"
 .;N %DT S X=$P($G(^TMP($J,"FBTOT",I)),U,12) D ^%DT S $P(^TMP($J,"FBTOT",I),U,12)=Y
 .S GECS("STRING",0)="CNH^"_^TMP($J,"FBTOT",I)_"^$"
 .D  D ^GECSENTR W !
 .. I $Y+5>IOSL,$E(IOST,1,2)'="C-" W @IOF
 ;
 K GECS,GECSSYS,GECSAUTO,I
 Q
