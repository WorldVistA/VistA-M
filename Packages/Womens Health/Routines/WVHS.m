WVHS ;HCIOFO/FT - HEALTH SUMMARY INTERFACE ;12/18/2019
 ;;1.0;WOMEN'S HEALTH;**5,24**;Sep 30, 1998;Build 582
 ;
UD ; User Defined Health Summary. Called from [WV HS-USER DEFINED] option
 ; Select patient (DFN) and call HS supported call.
 S WVPOP=0 N DFN
 D PATIENT I WVPOP D KILL Q
 N GMP,GMPATT,GMTSPHDR
 I $T(MAIN^GMTSADOR)']"" D  D KILL Q
 .W !,"Sorry, the Health Summary package utility 'MAIN^GMTSADOR' does not exist.",!,"Please contact your IRM support person.",!
 .Q
 D MAIN^GMTSADOR
 D KILL
 Q
PATIENT ; Select a patient (can be male or female)
 N DIC,DTOUT,DUOUT
 S DIC="^DPT(",DIC(0)="AEMQZ"
 D ^DIC
 I Y<0!($D(DTOUT))!($D(DUOUT)) S WVPOP=1 Q
 S DFN=+Y
 Q
KILL ;
 K WVDFN,WVEND,WVPOP,WVSTART,WVTYPE,X,Y
 Q
 ;
 ;//AGP begin changes
LAST3(SUB,DFN,NGET,DIR) ;
 ;a DIR of 1 returns Newest to Oldest by date
 ;a DIR of -1 returns Oldest to Newest by date
 ;time is not taken into consideration
 N ARRAY,CNT,DATE,I,INC,INVDATE,MAX,SORTARR,PROCIEN,TIEN,TERMLARR,TERMLIEN
 N TNAME,WVIEN,WVDX,WVTERM,Y
 K ^TMP(SUB,$J)
 S MAX=$$BLDTARR^PXRMPRAD(.TERMLARR)
 F X=1:1:MAX D
 .S TNAME=TERMLARR(X)
 .S TIEN=$O(^PXRMD(811.5,"B",TNAME,"")) Q:TIEN'>0
 .S TERMLIEN(TIEN)=""
 S DATE="",CNT=0,I=1 F  S DATE=$O(^WV(790.1,"AC",DFN,DATE),-1) Q:DATE=""!(CNT>(NGET-1))  D
 .S WVIEN=0 F  S WVIEN=$O(^WV(790.1,"AC",DFN,DATE,WVIEN)) Q:WVIEN'>0!(CNT>(NGET-1))  D
 ..I $P($G(^WV(790.1,WVIEN,0)),U,15)="" Q
 ..S PROCIEN=$P($G(^WV(790.1,WVIEN,0)),U,4) Q:PROCIEN'>0
 ..S WVTERM=+$P($G(^WV(790.2,PROCIEN,3)),U) Q:WVTERM'>0
 ..I '$D(TERMLIEN(TIEN)) Q
 ..S CNT=CNT+1,ARRAY(CNT)=WVIEN
 S INC="",CNT=0 F  S INC=$O(ARRAY(INC),DIR) Q:INC=""  D
 .S WVIEN=ARRAY(INC)
 .S PROCIEN=$P($G(^WV(790.1,WVIEN,0)),U,4) Q:PROCIEN'>0
 .I $P($G(^WV(790.2,PROCIEN,0)),U,5)'="R" Q
 .K ^TMP("WV RPT",$J)
 .D EN^WVALERTR(WVIEN,.WVDX)
 .S CNT=CNT+1
 .I CNT>1 S I=I+1,^TMP(SUB,$J,I,0)="",I=I+1,^TMP(SUB,$J,I,0)="__________________________________________________________",I=I+1,^TMP(SUB,$J,I,0)=""
 .S Y=0 F  S Y=$O(^TMP("WV RPT",$J,Y)) Q:Y'>0  S I=I+1,^TMP(SUB,$J,I,0)=$G(^TMP("WV RPT",$J,Y,0))
 I CNT=0 S ^TMP(SUB,$J,1,0)="No Test Found"
 I CNT>0 S ^TMP(SUB,$J,1,0)="Total tests returned: "_CNT
 Q "~@"_$NA(^TMP(SUB,$J))
 ;//AGP end changes
