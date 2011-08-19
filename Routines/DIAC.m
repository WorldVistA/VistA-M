DIAC ;SFISC/YJK-FILE ACCESS CHECK ;3/18/99  12:59
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN Q:'$D(DIAC)!'$D(DIFILE)
 I '$D(^DIC(DIFILE,0))#2 S (DIAC,%)=0 Q
 I DUZ(0)="@" S (DIAC,%)=1 Q
 S A1=$S(DIAC="DD":2,DIAC="DEL":3,DIAC="LAYGO":4,DIAC="RD":5,DIAC="WR":6,DIAC="AUDIT":7,1:0) D:A1 CK
 K A1 S %=DIAC Q
 ;
CK I $S($D(^VA(200,"AFOF")):1,1:$D(^DIC(3,"AFOF"))) D FOF Q
 I '$D(^DIC(DIFILE,0,DIAC)) S DIAC=1 Q
 S %=^(DIAC) I %="" S DIAC=1 Q
 F A1=1:1:$L(%) I DUZ(0)[$E(%,A1) S DIAC=1 Q
 I 'DIAC S DIAC=0
 Q
 ;
FOF S DIAC=0 I $S($D(^VA(200,DUZ,"FOF",DIFILE,0)):1,1:$D(^DIC(3,DUZ,"FOF",DIFILE,0))),$P(^(0),U,A1) S DIAC=1
 Q
 ;
 ;;
