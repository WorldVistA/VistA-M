YSFORM ;SLC/TGA,HIOFO/FT - HEADER & FOOTER FOR FORMS ;2/11/13 3:09pm
 ;;5.01;MENTAL HEALTH;**108**;Dec 30, 1994;Build 17
 ;Reference to FILE 4 fields supported by DBIA #10090
 ;Reference to $$SITE^VASITE supported by IA #10112
 ;
ENHD ;Generates page header
 S:'$D(YSCON) YSCON=0 S:'$D(YSFTR) YSFTR="" S:'$D(YSFHDR(1)) YSFHDR(1)="" W @IOF
 S:'$D(YSLCN) YSLCN=$$SITE,YSLCN="VAMC "_YSLCN
 I IOST?1"C-".E W YSNM,?47,"SSN ","xxx-xx-"_$E(YSSSN,8,11),?65,"DOB ",YSDOB,!
 I IOST?1"P".E W ! F I0=1:1:80 W "-"
 I IOST?1"P".E W ! W:YSFTR]"" "MEDICAL RECORD"
 W ?80-$L(YSFHDR)/2,YSFHDR I IOST?1"P".E W ! F I0=1:1:IOM W "-"
 W:YSCON !?25,"(Continued from previous page)" X:YSFHDR(1)]"" YSFHDR(1)
 K I0 S YSCON=0
 Q
ENFT ;Generates page footer
 S:'$D(YSFTR) YSFTR="" S:'$D(YSCON) YSCON=0
 S:'$D(YSLCN) YSLCN=$$SITE,YSLCN="VAMC "_YSLCN
 F I0=1:1:(IOSL-$Y-9) W !
 W ! W:YSCON ?28,"(Continued on next page)"
 W ! F I0=1:1:IOM W "_"
 W !,YSNM,?(31+(37-$L(YSLCN)/2)),YSLCN W:YSFTR]"" ?69,"VAF 10-9034"
 I YSFTR]"" S YSFTR(1)="(VICE "_YSFTR_")"
 W !,"xxx-xx-"_$E(YSSSN,8,11) W:YSDOB]"" "   DOB ",YSDOB W:YSFTR]"" ?(80-$L(YSFTR(1))),YSFTR(1)
 W:IOST?1"P".E ! K I0
 Q
SITE() ;get site name
 N YSDA
 S YSDA=+$P($$SITE^VASITE,U)
 Q $$GET1^DIQ(4,YSDA_",",.01)
